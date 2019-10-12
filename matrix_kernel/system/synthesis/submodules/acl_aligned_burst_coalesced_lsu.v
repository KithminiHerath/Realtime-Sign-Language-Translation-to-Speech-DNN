// (C) 1992-2018 Intel Corporation.                            
// Intel, the Intel logo, Intel, MegaCore, NIOS II, Quartus and TalkBack words    
// and logos are trademarks of Intel Corporation or its subsidiaries in the U.S.  
// and/or other countries. Other marks and brands may be claimed as the property  
// of others. See Trademarks on intel.com for full list of Intel trademarks or    
// the Trademarks & Brands Names Database (if Intel) or See www.Intel.com/legal (if Altera) 
// Your use of Intel Corporation's design tools, logic functions and other        
// software and tools, and its AMPP partner logic functions, and any output       
// files any of the foregoing (including device programming or simulation         
// files), and any associated documentation or information are expressly subject  
// to the terms and conditions of the Altera Program License Subscription         
// Agreement, Intel MegaCore Function License Agreement, or other applicable      
// license agreement, including, without limitation, that your use is for the     
// sole purpose of programming logic devices manufactured by Intel and sold by    
// Intel or its authorized distributors.  Please refer to the applicable          
// agreement for further details.                                                 


// This module implements a burst-coalesced write LSU for aligned data storage. This means that
// the address for the supplied data must be aligned to the size of the data being stored. This implies that
// the memory bus width is an integer multiple of the data being written.
//
// Architecture:
//             --------------     -----------     --------------------
// kernel ---> | coalescer  |---->| buffers |---->| Avalon Interface |---> off-chip memory
//             --------------     -----------     --------------------
//                   |                                      |
//                   ----------------                       |
//                                  |                       |
//                                  V                       |
//                        -------------------               |
// kernel <---------------| valid generator |<---------------                                                
//                        -------------------               
//
// This design comprises 4 main components: coalescer, buffers, an avalon interface and a valid generator. The coalescer takes
// as input data, address, byte enables and predicate from the kernel. It processes them in an attempt to coalesce subsequent
// write operations into a burst. Once a burst is formed, it is stored in a set of buffers which are then emptied by the
// Avalon interface. Once a request is issued for a given burst, the associated threads are released into the valid generator
// so that they can propagate to the kernel.
//
// To ensure that a burst is always formed within a specific amount of time of inactivity, a timeout generator is embedded within the
// compressor. It checks the state of the compressor and if a pending request is not processed it triggers a write.
//
// Couple of things to notice about this design:
// 1. the coalescer and the valid generators have registered stall signals, both on the input and on the output side. This
//    removes the requirement for staging registers around this LSU. Also, the wait request is guaranteed to be separated from
//    the stall network of the kernel.
// 2. There are two ways to get to the valid generator, either after Avalon interface or straight from the coalescer. The path is chosen using
//    QUICK_VALID_OUT parameter. When set to 1, the valid generator will start producing valids for threads that have been accepted by the coalescer.
//    If it is set to 0, it will wait until the burst corresponding to the tread is accepted by the interconnect (during the time it is issued by the Avalon
//    Interface block).
//
// Further improvements are possible in this design. To do this, simply add additional pipelining stages or change the architecture of each
// module in this design. Since the modules are latency-insensitive with respect to one another, it is the amount of pipelining you add
// will not affect the correctness of operation of other modules. Having said this, be especially careful with how the coalescer and 
// the buffers modules interact as the buffers module produces an "about_to_stall" signal and the compressor expects it. That is, when
// from compressor's perspective when i_about_to_stall is raised, the present output will be absorbed by the buffers module, but the subsequent
// one needs to remain in the compressor until the buffers can accept the next input.
//
// Notes:
// i_predicate input specifies if the input provided should be omitted. If it is set, the data associated with the given input
// will NOT be written to memory and it will trigger a data burst. That is, no coalescing occurs across predicate boundaries.
// This is something we could remedy, but for the moment this is done to match the previous operation of the burst-colaesced LSU.

module acl_aligned_burst_coalesced_lsu
(
   clock, clock2x, resetn, o_active,
   // Kernel Interface
   o_stall,
   i_valid,
   i_stall,
   o_valid,
   i_address,
   i_writedata,
   i_predicate,
   i_byteenable,

   avm_address,
   avm_write,
   avm_writeack,
   avm_writedata,
   avm_byteenable,
   avm_waitrequest,
   avm_burstcount
);
parameter AWIDTH=32;                     // Address width (32-bits for Avalon)
parameter WIDTH_BYTES=32;                // Width of the memory access (bytes)
parameter MWIDTH_BYTES=64;               // Width of the global memory bus (bytes)
parameter ALIGNMENT_ABITS=5;             // Request address alignment (address bits)
parameter KERNEL_SIDE_MEM_LATENCY=32;    // The max number of live threads
parameter MEMORY_SIDE_MEM_LATENCY=32;    // The latency to get to the iface (no response needed from DDR, we generate writeack right before the iface).
parameter BURSTCOUNT_WIDTH=5;            // Size of Avalon burst count port
parameter USE_WRITE_ACK=0;               // Wait till the write has actually made it to global memory
parameter HIGH_FMAX=1;
parameter USE_BYTE_EN=0;
parameter TIMEOUT=16;                    // Time out before a request is forced out
parameter QUICK_VALID_OUT = 1;           // The moment you accept a thread into the LSU, you are allowed to produce a valid out for that thread.
parameter NO_TIMEOUT_WHEN_IDLE = 1;      // When the interconnect is not busy, no need to wait for the timeout to expire. Generate the largest burst you can asap.
parameter INTENDED_DEVICE_FAMILY="Arria 10";

localparam EXTRA_BUFFER_SPACE = (WIDTH_BYTES == MWIDTH_BYTES) ? 3 : 2;
localparam BURST_BUFFER_SIZE = (2**(BURSTCOUNT_WIDTH-1))*EXTRA_BUFFER_SPACE; // Make it 2-3 full bursts. This will usually be 2^6.
localparam MAX_THREADS = 8*(MWIDTH_BYTES/WIDTH_BYTES)*(2**(BURSTCOUNT_WIDTH+1));    // Must be a power of 2
localparam WIDTH=8*WIDTH_BYTES;
localparam MWIDTH=8*MWIDTH_BYTES;
localparam BYTE_SELECT_BITS=$clog2(MWIDTH_BYTES);
localparam ALIGNMENT_ABYTES=2**ALIGNMENT_ABITS;
localparam NUM_THREAD_BITS = $clog2(MAX_THREADS)+1;
localparam EXTRA_REGISTER_STAGE = (INTENDED_DEVICE_FAMILY=="Arria 10") ? 1 : 0;

/********
* Ports *
********/
// Standard global signals
input clock, clock2x;

// Asynchoronous reset. It resets the state machine and valid bits in this module.
input resetn;

// Kernel interface
output o_stall;
input i_valid;
input i_predicate;
input i_stall;
output o_valid;
output o_active;
input [AWIDTH-1:0] i_address;
input [WIDTH-1:0] i_writedata;
input [WIDTH_BYTES-1:0] i_byteenable;

// Avalon interface
output [AWIDTH-1:0] avm_address;
output avm_write;
input  avm_writeack;
output [MWIDTH-1:0] avm_writedata;
output [MWIDTH_BYTES-1:0] avm_byteenable;
input  avm_waitrequest;
output [BURSTCOUNT_WIDTH-1:0] avm_burstcount;

wire consume_word, is_predicate;
wire about_to_stall, trigger_write;

// First, create the request coalescer. The coalescer compacts a sequence of requests into a single memory size data word. It produces
// a signal that states if the burst has ended.

wire [AWIDTH-1:0] address;
wire write;
wire writeack;
wire [MWIDTH-1:0] writedata;
wire [MWIDTH_BYTES-1:0] byteenable;
wire avm_waitrequest;
wire [BURSTCOUNT_WIDTH-1:0] burstcount;
wire [NUM_THREAD_BITS-1:0] thread_count;
wire compressor_valid, stall_coalescer;
wire thread_accepted_by_coalescer;
wire stall_from_valid_gen;
wire buffer_active, avalon_active, coalescer_active;
reg avalon_active_reg, coalescer_active_reg, buffer_active_reg;
reg wait_reg, keep_coalescing;

always@(posedge clock)
begin
  coalescer_active_reg <= coalescer_active;
  buffer_active_reg <= buffer_active;
  avalon_active_reg <= avalon_active;
  wait_reg <= avm_waitrequest;
  keep_coalescing <= buffer_active_reg | avalon_active_reg | wait_reg;
end

acl_burst_coalescer coalescer(
   .clock(clock),
   .resetn(resetn),
   .i_address(i_address),
   .i_writedata(i_writedata),
   .i_predicate(i_predicate),
   .i_byteenable(i_byteenable),
   .i_coalesce((NO_TIMEOUT_WHEN_IDLE == 1) ? keep_coalescing : 1'b1),

   .o_stall(o_stall),
   .i_valid(i_valid),
   .i_about_to_stall(about_to_stall),
   .i_stall(stall_coalescer),
   .o_valid(compressor_valid),
   
   .o_dataword(writedata),
   .o_address(address),
   .o_byteenable(byteenable),
   .o_burstlength(burstcount),
   .o_trigger_write(trigger_write),
   .o_consume_word(consume_word),
   .o_is_predicate(is_predicate),
   .o_thread_count(thread_count),
   .o_active(coalescer_active),
   .o_new_thread_accepted(thread_accepted_by_coalescer),
   .i_stall_from_valid_generator(stall_from_valid_gen)
);
  defparam coalescer.TIMEOUT = TIMEOUT;
  defparam coalescer.AWIDTH = AWIDTH;                     
  defparam coalescer.WIDTH_BYTES = WIDTH_BYTES;                 
  defparam coalescer.MWIDTH_BYTES = MWIDTH_BYTES;               
  defparam coalescer.BURSTCOUNT_WIDTH = BURSTCOUNT_WIDTH;            
  defparam coalescer.HIGH_FMAX = HIGH_FMAX;
  defparam coalescer.USE_BYTE_EN = USE_BYTE_EN;  
  defparam coalescer.MAX_THREADS = MAX_THREADS;
  defparam coalescer.QUICK_VALID_OUT = QUICK_VALID_OUT;  
  
wire discard_entry;
wire [NUM_THREAD_BITS-1:0] passed_threads;
wire valid_buffers;
wire stall_data, stall_burst, single_word_burst;
wire [AWIDTH-1:0] to_avm_address;
wire [MWIDTH-1:0] to_avm_writedata;
wire [MWIDTH_BYTES-1:0] to_avm_byteenable;
wire [BURSTCOUNT_WIDTH-1:0] to_avm_burstcount;

acl_lsu_buffers buffers(
    .clock(clock),
    .resetn(resetn),
    
    .i_store_word(consume_word),
    .i_store_burst(trigger_write),
    .i_writedata(writedata),
    .i_address(address),
    .i_byteenable(byteenable),
    .i_thread_count(thread_count),
    .i_burst_count(burstcount),
    .i_predicate(is_predicate),

    .o_writedata(to_avm_writedata),
    .o_address(to_avm_address),
    .o_byteenable(to_avm_byteenable),
    .o_thread_count(passed_threads),
    .o_burst_count(to_avm_burstcount),
    .o_predicate(discard_entry),
    .o_single_word_burst(single_word_burst),
    
    .i_valid(compressor_valid),
    .o_about_to_stall(about_to_stall),
    .o_stall(stall_coalescer),
    
    .o_valid(valid_buffers),
    .i_read_data(~stall_data),
    .i_read_control(~stall_burst),
    .o_active(buffer_active)
   
    );
  defparam buffers.AWIDTH = AWIDTH;                     
  defparam buffers.MWIDTH_BYTES = MWIDTH_BYTES;               
  defparam buffers.BURSTCOUNT_WIDTH = BURSTCOUNT_WIDTH; 
  defparam buffers.BUFFER_DEPTH = BURST_BUFFER_SIZE; 
  defparam buffers.MAX_THREADS = MAX_THREADS; 
  defparam buffers.EXTRA_REGISTER_STAGE = EXTRA_REGISTER_STAGE;   

wire [NUM_THREAD_BITS-1:0] released_threads;
wire release_threads;
  
avalon_interface avalon(
    .clock(clock),
    .resetn(resetn),
    .i_valid(valid_buffers),
    .o_stall_data(stall_data),
    .o_stall_burst(stall_burst),
    .i_thread_count(passed_threads),
    .i_discard(discard_entry),
    .i_single_word_burst(single_word_burst),
    
    .i_address(to_avm_address),
    .i_writedata(to_avm_writedata),
    .i_byteenable(to_avm_byteenable),
    .i_burstcount(to_avm_burstcount),
  
    .avm_address(avm_address),
    .avm_write(avm_write),
    .avm_writedata(avm_writedata),
    .avm_byteenable(avm_byteenable),
    .avm_waitrequest(avm_waitrequest),
    .avm_burstcount(avm_burstcount),
    .avm_writeack(avm_writeack),
    .o_thread_count(released_threads),
    .o_release_threads(release_threads),
    .i_stall((QUICK_VALID_OUT == 1) ? 1'b0 : stall_from_valid_gen),
    .o_active(avalon_active));
  defparam avalon.AWIDTH = AWIDTH;                     
  defparam avalon.MWIDTH_BYTES = MWIDTH_BYTES;               
  defparam avalon.BURSTCOUNT_WIDTH = BURSTCOUNT_WIDTH; 
  defparam avalon.MAX_THREADS = MAX_THREADS; 
  defparam avalon.USE_WRITE_ACK = USE_WRITE_ACK;  
  
valid_generator outgen(
   .clock(clock),
   .resetn(resetn),
   .o_stall(stall_from_valid_gen),
   .i_valid((QUICK_VALID_OUT == 1) ? thread_accepted_by_coalescer : release_threads),
   .i_thread_count((QUICK_VALID_OUT == 1) ? {{NUM_THREAD_BITS{1'b0}}, thread_accepted_by_coalescer} : released_threads),
   .o_valid(o_valid),
   .i_stall(i_stall));
   defparam outgen.MAX_THREADS = MAX_THREADS;

// Generate the active signal based on the present state of each component. We exclude the valid generator as
// the kernel could never finish before the valid generator has completed operation.
reg active_reg;
always@(posedge clock)
begin
  active_reg <= avalon_active_reg | coalescer_active_reg | buffer_active_reg;
end
assign o_active = active_reg;

endmodule

module avalon_interface(
  clock,
  resetn,
  i_valid,
  o_stall_data,
  o_stall_burst,
  i_thread_count,
  i_discard,
  i_single_word_burst,
    
  i_address,
  i_writedata,
  i_byteenable,
  i_burstcount,
  
  avm_address,
  avm_write,
  avm_writedata,
  avm_byteenable,
  avm_waitrequest,
  avm_burstcount,
  avm_writeack,
  o_thread_count,
  o_release_threads,
  i_stall, o_active);
  
// My max function
function integer my_max;
input integer a;
input integer b;
begin
  my_max = (a > b) ? a : b;
end
endfunction
  
  parameter AWIDTH = 32;                     // Address width (32-bits for Avalon)
  parameter MWIDTH_BYTES = 32;               // Width of the global memory bus (bytes)
  parameter BURSTCOUNT_WIDTH = 6;            // Size of Avalon burst count port
  parameter MAX_THREADS = 64;                // Must be a power of 2
  parameter USE_WRITE_ACK = 0;
  localparam NUM_THREAD_BITS = $clog2(MAX_THREADS)+1;    
  localparam MWIDTH = 8*MWIDTH_BYTES; 
  localparam WA_WIDTH = my_max(10,BURSTCOUNT_WIDTH+4);
   
  
  input clock, resetn, i_valid;
  input i_single_word_burst;
  output o_stall_data, o_stall_burst;
  input [NUM_THREAD_BITS-1 :0] i_thread_count;
  output [NUM_THREAD_BITS-1 :0] o_thread_count;
  input [AWIDTH-1:0] i_address;
  input [MWIDTH-1:0] i_writedata;
  input [MWIDTH_BYTES-1:0] i_byteenable;
  input [BURSTCOUNT_WIDTH-1:0] i_burstcount;
  output o_release_threads;  
  input i_discard;
  input i_stall;
  output o_active;
  
  // Avalon interface
  output [AWIDTH-1:0] avm_address;
  output avm_write;
  output [MWIDTH-1:0] avm_writedata;
  output [MWIDTH_BYTES-1:0] avm_byteenable;
  input  avm_waitrequest, avm_writeack;
  output [BURSTCOUNT_WIDTH-1:0] avm_burstcount;
  
  // Registers
  reg [WA_WIDTH-1:0] write_ack_counter;  
  reg [AWIDTH-1:0] address;
  reg [MWIDTH-1:0] writedata;
  reg [MWIDTH_BYTES-1:0] byteenable;
  reg [BURSTCOUNT_WIDTH-1:0] burstcount;
  reg [BURSTCOUNT_WIDTH-1:0] items_left_minus_1;
  reg [NUM_THREAD_BITS-1:0] thread_count;
  reg is_last;
  reg active_lsu;
  reg processing;
  reg need_thread_release;
  reg predicates;
  // We are checking the writeack counter here to make sure we don't overflow it.
  wire accept_next_burst = (~processing | is_last & ~avm_waitrequest) & (~i_stall & ~write_ack_counter[WA_WIDTH-1]);
  wire accept_next_element = processing & ~avm_waitrequest & (~is_last | (~i_stall & ~write_ack_counter[WA_WIDTH-1]));
  assign o_stall_burst = ~accept_next_burst;
  assign o_stall_data = ~(accept_next_burst | accept_next_element);
  
  always@(posedge clock or negedge resetn)
  begin
    if (~resetn)
    begin
      processing <= 1'b0;
      address <= {{AWIDTH}{1'bx}};
      byteenable <= {{MWIDTH_BYTES}{1'bx}};
      burstcount <= {{BURSTCOUNT_WIDTH}{1'bx}};
      items_left_minus_1 <= {{BURSTCOUNT_WIDTH}{1'bx}};
      is_last <= 1'b0;
      need_thread_release <= 1'b0;
      predicates <= 1'b0;
      writedata <= {{MWIDTH}{1'bx}};
      thread_count <= {{NUM_THREAD_BITS}{1'bx}};
      active_lsu <= 1'bx;
    end
    else
    begin
      active_lsu <= processing;
      if (accept_next_burst)
      begin
        predicates <= i_discard;
        thread_count <= i_thread_count;
        address <= i_address;
        burstcount <= i_burstcount;
      end    

      processing <= accept_next_burst ? (i_valid & ~i_discard) : (~is_last | (processing & avm_waitrequest));
    
      if (accept_next_burst)
      begin
        need_thread_release <= i_valid;
      end
      else
      begin
        need_thread_release <= need_thread_release & avm_waitrequest & ~predicates;
      end

      if (accept_next_burst | accept_next_element)
      begin
        is_last <= (i_single_word_burst & accept_next_burst) | ~accept_next_burst & (items_left_minus_1 == {{{BURSTCOUNT_WIDTH-1}{1'b0}},1'b1});
        items_left_minus_1 <= (accept_next_burst ? i_burstcount : items_left_minus_1) + {{BURSTCOUNT_WIDTH}{1'b1}};
        byteenable <= i_byteenable;
        writedata <= i_writedata;
      end
    end
  end
  
  assign avm_address = address;
  assign avm_write = processing;
  assign avm_writedata = writedata;
  assign avm_byteenable = byteenable;
  assign avm_burstcount = burstcount;  

  reg [NUM_THREAD_BITS - 1 : 0] thread_count_2;
  reg release_threads;
  always@(posedge clock or negedge resetn)
  begin
    if (~resetn)
    begin
      release_threads <= 1'b0;
      thread_count_2 <= {{NUM_THREAD_BITS}{1'bx}};
    end
    else
    begin
      thread_count_2 <= thread_count;
      release_threads <= need_thread_release & (~avm_waitrequest | predicates);
    end
  end
  
  // This section handles the write_ack signal. The idea is to ensure that the LSU is considered active until
  // all words sent to memory have been acknowledged. This is irrespective of having to use a write_ack due to
  // dependencies in the kernel itself. We want to ensure that the kernel does not signal that it is done until
  // all writes it issued are accepted by the memory controller. At that point we know that no read that follows
  // could retrieve incorrect data.
  reg pending_acks;
  wire [WA_WIDTH-1:0] wa_decrement = {{WA_WIDTH}{avm_writeack}};
  wire [WA_WIDTH-1:0] wa_increment = {{WA_WIDTH}{accept_next_burst & i_valid}} & {1'b0,i_burstcount};
  
  always@(posedge clock or negedge resetn)
  begin
    if (~resetn)
    begin
      write_ack_counter <= {{WA_WIDTH}{1'b0}};
      pending_acks <= 1'b0;
    end
    else
    begin
      write_ack_counter <= write_ack_counter + wa_increment + wa_decrement;
      pending_acks <= |write_ack_counter;
    end
  end
  
  assign o_thread_count = thread_count_2;
  assign o_release_threads = release_threads;
  assign o_active = active_lsu | pending_acks;

endmodule

// This module generates a sequence of valid signals after the writes for the corresponding threads have been handled.
module valid_generator(clock, resetn, i_valid, o_stall, i_thread_count, o_valid, i_stall);
  parameter MAX_THREADS = 64;                          // Must be a power of 2
  localparam NUM_THREAD_BITS = $clog2(MAX_THREADS) + 1;
  
  input clock, resetn, i_valid, i_stall;
  input [NUM_THREAD_BITS-1:0] i_thread_count;
  output o_valid;
  output o_stall;
  
  reg [NUM_THREAD_BITS:0] local_thread_count;
  reg valid_sr;
  reg valid_reg;
  wire stall_counter;
  
  // Stall when you have a substantial amount of threads
  // to dispense to prevent the counter from overflowing.
  assign o_stall = local_thread_count[NUM_THREAD_BITS];
  
  // This is a local counter. It will accept a new thread ID if it is not stalling out.
  always@(posedge clock or negedge resetn)
  begin
    if (~resetn)
   begin
     local_thread_count <= {{NUM_THREAD_BITS}{1'b0}};
   end
   else
   begin
     local_thread_count <= local_thread_count +
                           {1'b0, i_thread_count & {{NUM_THREAD_BITS}{i_valid & ~o_stall}}} +
                           {{NUM_THREAD_BITS+1}{~stall_counter & (|local_thread_count)}};
   end
  end
  
  // The counter state is checked in the next cycle, which can stall the counter using the stall_counter signal.
  assign stall_counter = valid_reg & valid_sr;
  always@(posedge clock or negedge resetn)
  begin
    if (~resetn)
   begin
     valid_reg <= 1'b0;
   end
   else
   begin
     if (~stall_counter)
    begin
      valid_reg <= (|local_thread_count);
    end
   end
  end
  
  // Finally we put a staging register at the end.
  always@(posedge clock or negedge resetn)
  begin
    if (~resetn)
    begin
      valid_sr <= 1'b0;
    end
    else
    begin
      valid_sr <= valid_sr ? i_stall : (valid_reg & i_stall);
    end
  end  
  
  assign o_valid = valid_sr | valid_reg;
endmodule


module acl_lsu_buffers(
     clock, resetn,
    
    i_store_word,
    i_store_burst,
     i_writedata,
    i_address,
    i_byteenable,
    i_thread_count,
    i_burst_count,
    i_predicate,

     o_writedata,
    o_address,
    o_byteenable,
    o_thread_count,
    o_burst_count,
    o_predicate,
    
    i_valid,
    o_about_to_stall,
    o_stall,
    
    o_valid,
    i_read_data,
    i_read_control,
    o_single_word_burst,
    o_active);
  parameter AWIDTH = 32;                     
  parameter MWIDTH_BYTES = 32;               
  parameter BURSTCOUNT_WIDTH = 6; 
  parameter BUFFER_DEPTH = 64; 
  parameter MAX_THREADS = 64;
  parameter EXTRA_REGISTER_STAGE = 0;
  
  function integer my_local_log;
  input [31:0] value;
    for (my_local_log=0; value>0; my_local_log=my_local_log+1)
      value = value>>1;
  endfunction  
  
  localparam NUM_THREAD_BITS = $clog2(MAX_THREADS) + 1;  
  localparam WIDTH = 8*MWIDTH_BYTES;
  localparam NUM_BUFFER_DEPTH_BITS = (BUFFER_DEPTH == 1) ? 1 : my_local_log(BUFFER_DEPTH - 1);
  localparam ALMOST_FULL_VALUE = BUFFER_DEPTH - 2;
  localparam TOTAL_DATA_WIDTH = AWIDTH + MWIDTH_BYTES + WIDTH;
  localparam TOTAL_CONTROL_WIDTH = NUM_THREAD_BITS + BURSTCOUNT_WIDTH + 1 + 1;
  
  // Ports
  input clock, resetn;
    
  input i_store_word;
  input i_store_burst;
  input [WIDTH-1 : 0] i_writedata;
  input [AWIDTH-1 : 0] i_address;
  input [MWIDTH_BYTES-1:0] i_byteenable;
  input [NUM_THREAD_BITS-1:0] i_thread_count;
  input [BURSTCOUNT_WIDTH-1:0] i_burst_count;
  input i_predicate;

  output [WIDTH-1 : 0] o_writedata;
  output [AWIDTH-1 : 0] o_address;
  output [MWIDTH_BYTES-1:0] o_byteenable;
  output [NUM_THREAD_BITS-1:0] o_thread_count;
  output [BURSTCOUNT_WIDTH-1:0] o_burst_count;
  output o_predicate;
    
  input i_valid;
  output o_about_to_stall;
  output o_stall;
    
  output o_valid;
  input i_read_data;
  input i_read_control;
  output o_single_word_burst;
  output o_active;
  
  // Design
  wire almost_full;
  wire full;
  wire empty;
  
  wire [TOTAL_DATA_WIDTH-1 : 0] data_in = {i_address, i_byteenable, i_writedata};
  wire [TOTAL_DATA_WIDTH-1 : 0] data_out;
  wire [TOTAL_CONTROL_WIDTH-1 : 0] control_in = {i_thread_count, i_burst_count, i_predicate, (i_burst_count=={{{BURSTCOUNT_WIDTH-1}{1'b0}}, 1'b1})};
  wire [TOTAL_CONTROL_WIDTH-1 : 0] control_out; 
  wire control_empty;
  
  assign o_stall = full;
  assign o_active = ~control_empty;

  wire [TOTAL_DATA_WIDTH-1 : 0] data_in_proxy;
  wire [TOTAL_CONTROL_WIDTH-1 : 0] control_in_proxy;
  wire control_write;
  wire data_write;
    
  generate
    if (EXTRA_REGISTER_STAGE == 1)
    begin
      reg [TOTAL_DATA_WIDTH-1 : 0] data_in_reg;
      reg [TOTAL_CONTROL_WIDTH-1 : 0] control_in_reg;
      reg control_write_reg;
      reg data_write_reg;
     
      always@(posedge clock or negedge resetn)
      begin
        if(~resetn)
        begin
          data_in_reg <= {{TOTAL_DATA_WIDTH}{1'bx}};
          control_in_reg <= {{TOTAL_CONTROL_WIDTH}{1'bx}}; 
          control_write_reg <= 1'b0;
          data_write_reg <= 1'b0;
        end
        else
        begin
          data_in_reg <= data_in;
          control_in_reg <= control_in; 
          control_write_reg <= i_store_burst & i_valid;
          data_write_reg <= i_store_word & i_valid;        
        end
      end
      
      assign data_in_proxy = data_in_reg;
      assign control_in_proxy = control_in_reg;
      assign control_write = control_write_reg;
      assign data_write = data_write_reg;
    end
    else
    begin
      assign data_in_proxy = data_in;
      assign control_in_proxy = control_in;
      assign control_write = i_store_burst & i_valid;
      assign data_write = i_store_word & i_valid;
    end
  endgenerate
  
  scfifo  data_buf (
        .clock (clock),
        .data (data_in_proxy),
        .rdreq ((i_read_data) & (~empty) & (~i_read_control | ~control_empty)),
        .sclr (),
        .wrreq (data_write & (~full)),
        .empty (empty),
        .full (full),
        .q (data_out),
        .aclr (~resetn),
        .almost_empty (),
        .almost_full (almost_full),
        .usedw ());
  defparam
    data_buf.add_ram_output_register = "ON",
    data_buf.intended_device_family = "Stratix V",
      data_buf.lpm_hint = "unused",
    data_buf.lpm_numwords = BUFFER_DEPTH,
    data_buf.lpm_showahead = "ON",
    data_buf.lpm_type = "scfifo",
    data_buf.lpm_width = TOTAL_DATA_WIDTH,
    data_buf.lpm_widthu = NUM_BUFFER_DEPTH_BITS,
    data_buf.overflow_checking = "ON",
    data_buf.underflow_checking = "ON",
    data_buf.use_eab = "ON",
    data_buf.almost_full_value = ALMOST_FULL_VALUE;
    
  scfifo  control_buf (
        .clock (clock),
        .data (control_in_proxy),
        .rdreq (i_read_control & (~control_empty)),
        .sclr (),
        .wrreq (control_write & (~full)),
        .empty (control_empty),
        .full (),
        .q (control_out),
        .aclr (~resetn),
        .almost_empty (),
        .almost_full (),
        .usedw ());
  defparam
    control_buf.add_ram_output_register = "ON",
    control_buf.intended_device_family = "Stratix V",
      control_buf.lpm_hint = "unused",
    control_buf.lpm_numwords = BUFFER_DEPTH,
    control_buf.lpm_showahead = "ON",
    control_buf.lpm_type = "scfifo",
    control_buf.lpm_width = TOTAL_CONTROL_WIDTH,
    control_buf.lpm_widthu = NUM_BUFFER_DEPTH_BITS,
    control_buf.overflow_checking = "ON",
    control_buf.underflow_checking = "ON",
    control_buf.use_eab = "ON",
    control_buf.almost_full_value = ALMOST_FULL_VALUE;    

  assign o_about_to_stall = almost_full;
  assign o_valid = i_read_control ? ~control_empty : ~empty;

  // Produce outputs
  assign o_address = data_out[ TOTAL_DATA_WIDTH - 1: WIDTH+MWIDTH_BYTES];
  assign o_byteenable = data_out[ WIDTH+MWIDTH_BYTES-1 : WIDTH];
  assign o_writedata = data_out[ WIDTH - 1: 0];
  assign o_thread_count = control_out[ TOTAL_CONTROL_WIDTH-1 : BURSTCOUNT_WIDTH + 2];
  assign o_burst_count = control_out[BURSTCOUNT_WIDTH+1:2];
  assign o_predicate = control_out[1]; 
  assign o_single_word_burst = control_out[0]; 
endmodule
    

module acl_burst_coalescer(
   clock, resetn,
   i_address,
   i_writedata,
   i_predicate,
   i_byteenable,
   i_coalesce,

   o_stall,
   i_valid,
   i_about_to_stall,
   i_stall,
   o_valid,
   
   o_dataword,
   o_address,
   o_byteenable,
   o_burstlength,
   o_trigger_write,
   o_thread_count,
   o_consume_word,
   o_is_predicate,
   o_active,
   o_new_thread_accepted,
   
   i_stall_from_valid_generator
);

parameter AWIDTH=32;                     // Address width (32-bits for Avalon)
parameter WIDTH_BYTES=4;                 // Width of the memory access (bytes)
parameter MWIDTH_BYTES=32;               // Width of the global memory bus (bytes)
parameter BURSTCOUNT_WIDTH=6;            // Size of Avalon burst count port
parameter HIGH_FMAX=1;
parameter USE_BYTE_EN=0;
parameter MAX_THREADS=64;                // Must be a power of 2
parameter TIMEOUT=8;                     // Time out before a request is forced out
parameter QUICK_VALID_OUT=1;

localparam WIDTH=8*WIDTH_BYTES;
localparam MWIDTH=8*MWIDTH_BYTES;
localparam NUM_SECTIONS = MWIDTH_BYTES/WIDTH_BYTES;
localparam SECTION_BITS = $clog2(NUM_SECTIONS);
localparam ALIGNMENT_BITS = $clog2(WIDTH_BYTES);
localparam NUM_THREAD_BITS = $clog2(MAX_THREADS);
localparam TIMEOUT_BITS = $clog2(TIMEOUT);
// This paremeter defines the number of least significant bits that MUST be zero in order for us to form a burst
// of length greater than 1.
localparam PAGE_BITS = $clog2(MWIDTH_BYTES) + (BURSTCOUNT_WIDTH-1);

// My min function
function integer my_min;
input integer a;
input integer b;
begin
  my_min = (a > b) ? b : a;
end
endfunction
 
/********
* Ports *
********/
// Standard global signals
input clock;

// Asynchoronous reset. It resets the state machine and valid bits in this module.
input resetn;

// handshaking interfaces
output o_stall;
input i_valid;
output o_valid;
input i_about_to_stall;
input i_stall;
input i_stall_from_valid_generator;
// Only used when QUICK_VALID_OUT=1
output o_active;
output o_new_thread_accepted;

input i_predicate;
input i_coalesce;
input [AWIDTH-1:0] i_address;
input [WIDTH-1:0] i_writedata;
input [WIDTH_BYTES-1:0] i_byteenable;

// Avalon interface
output [AWIDTH-1:0] o_address;
output o_trigger_write;
output [MWIDTH-1:0] o_dataword;
output [MWIDTH_BYTES-1:0] o_byteenable;
output [BURSTCOUNT_WIDTH-1:0] o_burstlength;
output [NUM_THREAD_BITS:0] o_thread_count;
output o_consume_word;
output o_is_predicate;

// Stall/valid registers for each of the three stages.
reg valid_reg_0;
reg stall_reg_0;
reg valid_reg_1;
reg stall_reg_1;
reg valid_reg_2;
reg stall_reg_2;
reg valid_reg_3;
reg stall_reg_3;

// First stage of registers to store data coming in.
(* altera_attribute = "-name auto_shift_register_recognition OFF" *) reg [AWIDTH-1:0] address_reg_0;
(* altera_attribute = "-name auto_shift_register_recognition OFF" *) reg predicate_reg_0;
(* altera_attribute = "-name auto_shift_register_recognition OFF" *) reg [WIDTH-1:0] writedata_reg_0;
(* altera_attribute = "-name auto_shift_register_recognition OFF" *) reg [WIDTH_BYTES-1:0] byteenable_reg_0;

always@(posedge clock or negedge resetn)
begin
  if (~resetn)
  begin
    stall_reg_0 <= 1'b0;
    valid_reg_0 <= 1'b0;
    // Do not connect reset to data registers.
    predicate_reg_0 <= 1'bx;
    address_reg_0 <= {{AWIDTH}{1'bx}};
    byteenable_reg_0 <= {{WIDTH_BYTES}{1'bx}};
    writedata_reg_0 <= {{WIDTH}{1'bx}};
  end
  else
  begin
    if (~stall_reg_0)
    begin
      predicate_reg_0 <= i_predicate & i_valid & ((QUICK_VALID_OUT == 1) ? ~i_stall_from_valid_generator : 1'b1);
      address_reg_0 <= i_address;
      byteenable_reg_0 <= i_byteenable;
      writedata_reg_0 <= i_writedata;
    end
   
    valid_reg_0 <= stall_reg_0 ? valid_reg_0 : (i_valid & ((QUICK_VALID_OUT == 1) ? ~i_stall_from_valid_generator : 1'b1)); 
    stall_reg_0 <= i_about_to_stall;
  end
end

assign o_stall = stall_reg_0 | ((QUICK_VALID_OUT == 1) ? i_stall_from_valid_generator : 1'b0);

// Second stage - we will look at the address and compare it to the presently bursting address. If they are the same,
// then coalesing will happen, if they are not then the presently held page will be pushed out and not coalesced
// with the one just coming in.
(* altera_attribute = "-name auto_shift_register_recognition OFF" *) reg [AWIDTH-1:0] address_reg_1;
(* altera_attribute = "-name auto_shift_register_recognition OFF" *) reg [AWIDTH-1:0] address_reg_1_plus1;
(* altera_attribute = "-name auto_shift_register_recognition OFF" *) reg predicate_reg_1;
(* altera_attribute = "-name auto_shift_register_recognition OFF" *) reg [WIDTH-1:0] writedata_reg_1;
(* altera_attribute = "-name auto_shift_register_recognition OFF" *) reg [WIDTH_BYTES-1:0] byteenable_reg_1;
(* altera_attribute = "-name auto_shift_register_recognition OFF" *) reg timeout_predicate_reg_1;

reg [TIMEOUT_BITS:0] timeout_counter;
wire same_page;
wire next_page;

wire [AWIDTH-1:0] increment = 1 << (ALIGNMENT_BITS + SECTION_BITS);

always@(posedge clock or negedge resetn)
begin
  if (~resetn)
  begin
    stall_reg_1 <= 1'b0;
    valid_reg_1 <= 1'b0;
    timeout_counter <= {{TIMEOUT_BITS+1}{1'b0}};
    // We need to clear address registers, because we depend on their state.
    address_reg_1 <= {{AWIDTH}{1'b0}};
    address_reg_1_plus1 <= {{AWIDTH}{1'b0}};
    // Do not connect reset to data registers.
    predicate_reg_1 <= 1'bx;
    byteenable_reg_1 <= {{WIDTH_BYTES}{1'bx}};
    writedata_reg_1 <= {{WIDTH}{1'bx}};
    timeout_predicate_reg_1 <= 1'bx;
  end
  else
  begin
    if (~stall_reg_1)
    begin
      predicate_reg_1 <= valid_reg_0 & predicate_reg_0 | ~valid_reg_1 & ~valid_reg_0 & timeout_counter[TIMEOUT_BITS];
      timeout_predicate_reg_1 <= ~valid_reg_1 & ~valid_reg_0 & timeout_counter[TIMEOUT_BITS];
      address_reg_1 <= ((valid_reg_0 & ~predicate_reg_0) ? address_reg_0 : address_reg_1);
      address_reg_1_plus1 <= ((valid_reg_0 & ~predicate_reg_0) ? address_reg_0 : address_reg_1) + increment;
      byteenable_reg_1 <= byteenable_reg_0;
      writedata_reg_1 <= writedata_reg_0;      
    end
   
    valid_reg_1 <= stall_reg_1 ? (valid_reg_1) : (valid_reg_0 | ~valid_reg_1 & ~valid_reg_0 & timeout_counter[TIMEOUT_BITS]);    
    stall_reg_1 <= i_about_to_stall;
   
    // Check if you have timed out. If so, insert a predicated write to the pipeline, but mark it as a timeout predicate so that we
    // do not introduce another thread into the pipeline.
    if (~stall_reg_1 & ~valid_reg_1 & ~valid_reg_0 & ~timeout_counter[TIMEOUT_BITS])
      timeout_counter <= timeout_counter + 1'b1;
    else
      timeout_counter <= {{{TIMEOUT_BITS}{1'b0}}, 1'b1};
  end
end
   
// Here we are comparing the address of the page we are trying to coalesce with the page address of the word we already have here.
// If they are the same then the final memory word is in the same page location and we should merge the writes. Otherwise, the
// writes will be distinct.
acl_registered_comparison cmp_present(
     .clock(clock),
     .left(address_reg_0[(AWIDTH-1):(SECTION_BITS + ALIGNMENT_BITS)]),
     .right(address_reg_1[(AWIDTH-1):(SECTION_BITS + ALIGNMENT_BITS)]), // This is the page address of the current word being constructed.
     .enable(~stall_reg_1),
     .result(same_page));
     defparam cmp_present.WIDTH = AWIDTH - SECTION_BITS - ALIGNMENT_BITS;
     
acl_registered_comparison cmp_next(
      .clock(clock),
     .left(address_reg_0[(AWIDTH-1):(SECTION_BITS + ALIGNMENT_BITS)]),
     .right(address_reg_1_plus1[(AWIDTH-1):(SECTION_BITS + ALIGNMENT_BITS)]), // This is the page address of the subsequent word.
     .enable(~stall_reg_1),
     .result(next_page));
     defparam cmp_next.WIDTH = AWIDTH - SECTION_BITS - ALIGNMENT_BITS;     

// Third stage - complete the comparison and register it.
(* altera_attribute = "-name auto_shift_register_recognition OFF" *) reg [AWIDTH-1:0] address_reg_2;
(* altera_attribute = "-name auto_shift_register_recognition OFF" *) reg predicate_reg_2;
(* altera_attribute = "-name auto_shift_register_recognition OFF" *) reg timeout_predicate_reg_2;
(* altera_attribute = "-name auto_shift_register_recognition OFF" *) reg [WIDTH-1:0] writedata_reg_2;
(* altera_attribute = "-name auto_shift_register_recognition OFF" *) reg [WIDTH_BYTES-1:0] byteenable_reg_2;
(* altera_attribute = "-name auto_shift_register_recognition OFF" *) reg same_page_2;
(* altera_attribute = "-name auto_shift_register_recognition OFF" *) reg next_page_2;
reg crossing_burst_boundary;

always@(posedge clock or negedge resetn)
begin
  if (~resetn)
  begin
    stall_reg_2 <= 1'b0;
    valid_reg_2 <= 1'b0;
    // Do not connect reset to data registers.
    predicate_reg_2 <= 1'bx;
    address_reg_2 <= {{AWIDTH}{1'bx}};
    byteenable_reg_2 <= {{WIDTH_BYTES}{1'bx}};
    writedata_reg_2 <= {{WIDTH}{1'bx}};
    timeout_predicate_reg_2 <= 1'bx;
    same_page_2 <= 1'bx;
    next_page_2 <= 1'bx;
    crossing_burst_boundary <= 1'bx;
  end
  else
  begin
    if (~stall_reg_2)
    begin
      // This variable keeps track of burst boundaries. It basically signifies when the new data is at an address corresponding to a burst boundary.
      // In such a case, any burst that was being formed before must end.
      crossing_burst_boundary <= ~(|address_reg_1[ PAGE_BITS - 1 : my_min(PAGE_BITS - 1,SECTION_BITS + ALIGNMENT_BITS)]);
      predicate_reg_2 <= predicate_reg_1;
      timeout_predicate_reg_2 <= timeout_predicate_reg_1;
      address_reg_2 <= address_reg_1;
      byteenable_reg_2 <= valid_reg_1 ? byteenable_reg_1 : {{WIDTH_BYTES}{1'b0}};
      writedata_reg_2 <= writedata_reg_1;      
      same_page_2 <= same_page | predicate_reg_1 & ~timeout_predicate_reg_1;
      next_page_2 <= next_page & ~predicate_reg_1;
    end
    valid_reg_2 <= stall_reg_2 ? (valid_reg_2) : valid_reg_1;       
    stall_reg_2 <= i_about_to_stall;
  end
end

// Fourth stage. This is the place where we actually coalesce two subsequent writes into a single word.
// This section is critical to the operation of this module. Everything else before this point is just there to pipeline the operation
// for higher fmax. If anything can go wrong it will most likely be here.
(* altera_attribute = "-name auto_shift_register_recognition OFF" *) reg [AWIDTH-1:0] address_reg_3;
(* altera_attribute = "-name auto_shift_register_recognition OFF" *) reg [MWIDTH-1:0] writedata_reg_3;
(* altera_attribute = "-name auto_shift_register_recognition OFF" *) reg [MWIDTH_BYTES-1:0] byteenable_reg_3;
(* altera_attribute = "-name auto_shift_register_recognition OFF" *) reg [BURSTCOUNT_WIDTH-1:0] burstlength_reg_3;
(* altera_attribute = "-name auto_shift_register_recognition OFF" *) reg predicate_reg_3;
(* altera_attribute = "-name auto_shift_register_recognition OFF" *) reg timeout_predicate_reg_3;
reg [NUM_THREAD_BITS:0] thread_count;

// Register that specifies if the burst is limited to 1 due to page restrictions.
reg page_limit;
// This register will be 1 when a burst is being formed, and 0 otherwise.
reg forming_burst;

wire trigger_write;
wire consume_word = valid_reg_3 & (next_page_2 & valid_reg_2 | trigger_write);

// This signal defines when we chose to trigger a burst write. Conditions are:
// 1. the new write is neither on the same page or on the subsequent page wrt the previous write. So end the burst and start a new one.
// 2. burst length is maxed and we have another page to write, so start a new burst.
// 3. time out has occured.
// 4. thread count is maxed.
// 5. There is a break in valid signals (valid_reg_2=0) and i_coalesce is low
// This is the most complex logic expression in this design. Simplifying it will make it easier to maintain high fmax as the design
// this LSU is used in gets larger. At this point it comprises 9 inputs.
assign trigger_write = timeout_predicate_reg_2 | predicate_reg_3 | ~i_coalesce & ~valid_reg_2 | thread_count[NUM_THREAD_BITS] |
                     ~same_page_2 & ~next_page_2 & forming_burst & valid_reg_2 | 
                     (crossing_burst_boundary & next_page_2 & valid_reg_2 & forming_burst);

wire [WIDTH_BYTES-1:0] abstracted_byte_enable = ((USE_BYTE_EN == 0) ? {{WIDTH_BYTES}{1'b1}} : byteenable_reg_2) & {{WIDTH_BYTES}{valid_reg_2 & ~predicate_reg_2}};
wire [MWIDTH_BYTES-1:0] previous_byte_enable = (~forming_burst | consume_word) ? {{MWIDTH_BYTES}{1'b0}} : byteenable_reg_3;
reg [MWIDTH_BYTES-1:0] new_byte_enable;
reg [MWIDTH-1:0] temp_new_data;

// Generate the byte enable in the correct position for a given write operation.
generate
if (NUM_SECTIONS == 1)
begin
  // Special case where the temp_new_data is equal to writedata_reg_2 due to the fact that memory data width and
  // input data width are the same size.
  always@(*)
  begin
    temp_new_data = writedata_reg_2;
    new_byte_enable = abstracted_byte_enable;
  end
end
else
begin
  // Here there is more than one section so use the address bits to determine where to put the new data.
  // This is basically a set of muxes feeding registers. The muxes grow smaller the wider the data input is.
  wire [SECTION_BITS-1:0] position = address_reg_2[(SECTION_BITS + ALIGNMENT_BITS - 1):ALIGNMENT_BITS];
  integer index;
  always@(*)
  begin
    for(index = 0; index < NUM_SECTIONS; index = index + 1)
    begin
      if (position == index)
      begin
        temp_new_data[index*WIDTH +: WIDTH] = writedata_reg_2;
        new_byte_enable[index*WIDTH_BYTES +: WIDTH_BYTES] = abstracted_byte_enable;
      end
      else
      begin
        temp_new_data[index*WIDTH +: WIDTH] = {{WIDTH}{1'b0}};
        new_byte_enable[index*WIDTH_BYTES +: WIDTH_BYTES] = {{WIDTH_BYTES}{1'b0}};      
      end
    end
  end
end
endgenerate

// Generate the new data signal to represent the values you are about to write to memory.
wire [MWIDTH-1:0] new_data_value;

genvar i;
generate
  for (i=0; i < MWIDTH_BYTES; i = i + 1)
  begin: data_gen
    assign new_data_value[(i+1)*8 - 1 : i*8] = new_byte_enable[i] ? temp_new_data[(i+1)*8 - 1 : i*8] : writedata_reg_3[(i+1)*8 - 1 : i*8];
  end  
endgenerate

// Final stage of registers.
always@(posedge clock or negedge resetn)
begin
  if (~resetn)
  begin
    stall_reg_3 <= 1'b0;
    valid_reg_3 <= 1'b0;
    forming_burst <= 1'b0;
    // Do not connect reset to data registers.
    thread_count <= {{NUM_THREAD_BITS+1}{1'bx}};
    burstlength_reg_3 <= {{BURSTCOUNT_WIDTH}{1'bx}};
    address_reg_3 <= {{AWIDTH}{1'bx}};
    byteenable_reg_3 <= {{MWIDTH_BYTES}{1'bx}};
    writedata_reg_3 <= {{MWIDTH}{1'bx}};
    predicate_reg_3 <= 1'bx;
    timeout_predicate_reg_3 <= 1'bx;
  end
  else
  begin
    if (~stall_reg_3)
    begin
      // If you were forming a valid burst already then appending a predicate thread to it does not change the validity of the burst.
      // So only label the word as being a predicate if the predicate is the only word to be written.
      predicate_reg_3 <= (trigger_write | ~forming_burst) & predicate_reg_2 | timeout_predicate_reg_2;
      timeout_predicate_reg_3 <= timeout_predicate_reg_2;
      forming_burst <= ~trigger_write & (valid_reg_3 & ~predicate_reg_3) | (valid_reg_2 & ~predicate_reg_2);
      // Since the address is aligned, we do not need the least-significant bits that address bytes within the word of data being written.
      // So just mask them out here.
      // In terms of storing the address: we want to keep the address as what it was while forming a burst, provided that trigger_write is not asserted.
      address_reg_3 <= (~forming_burst | trigger_write) ?
                     {address_reg_2[ AWIDTH - 1 : (SECTION_BITS + ALIGNMENT_BITS)], {{SECTION_BITS + ALIGNMENT_BITS}{1'b0}}}:
                     {address_reg_3[ AWIDTH - 1 : (SECTION_BITS + ALIGNMENT_BITS)], {{SECTION_BITS + ALIGNMENT_BITS}{1'b0}}};
      byteenable_reg_3 <= new_byte_enable | previous_byte_enable;
      writedata_reg_3 <= new_data_value;
      // For burst length:
      // 1. It should be one on a new burst.
      // 2. should increment by one whenever the burst is enlarged.
      burstlength_reg_3 <= ((trigger_write | ~forming_burst) ? {{BURSTCOUNT_WIDTH}{1'b0}} : burstlength_reg_3) + 
                           (valid_reg_2 & ~predicate_reg_2 & (trigger_write | next_page_2 & forming_burst | ~forming_burst));
      // For thread count:
      // 1. if triggering a write, set it to 1 if thread in stage 2 is valid (but not timeout predicate), and 0 otherwise.
      // 2. if not triggering a write increment by to 1 if valid_2 and ~timeout_predicate_reg_2
      thread_count <= ((trigger_write | ~forming_burst) ? {{NUM_THREAD_BITS}{1'b0}} : thread_count) + (valid_reg_2 & ~timeout_predicate_reg_2);    
    end
   
    valid_reg_3 <= stall_reg_3 ? valid_reg_3 : (valid_reg_2 | (valid_reg_3 & ~trigger_write));          
    stall_reg_3 <= i_about_to_stall;
  end
end

// Consume word means that this word is a part of a burst being formed and you should store it in a buffer because the
// next word that is part of this same burst is about to be formed. Note that this signal is not raised when the burst ends,
// so you cannot just ignore either one of these signals.
assign o_consume_word = consume_word;

// Predicate indicates that this is a valid word but is not written to memory.
assign o_is_predicate = predicate_reg_3;
assign o_valid = valid_reg_3 & ~timeout_predicate_reg_3 & ~stall_reg_3; // A time-out predicate should not be counted.
assign o_dataword = writedata_reg_3;
assign o_address = address_reg_3;
assign o_byteenable = byteenable_reg_3;
assign o_burstlength = burstlength_reg_3;

// This output determines when to trigger a new write. This corresponds to a complete burst.
assign o_trigger_write = trigger_write & valid_reg_3;
// This is the number of threads associated with this burst.
assign o_thread_count = thread_count;

assign o_active = valid_reg_0 | valid_reg_1 & ~timeout_predicate_reg_1 | valid_reg_2 & ~timeout_predicate_reg_2 | valid_reg_3 & ~timeout_predicate_reg_3;
assign o_new_thread_accepted = i_valid & ~o_stall;

endmodule

// This module performs a comparison of two n-bit values. This is not that complicated, but we did
// want to break the comparison with a register.
module acl_registered_comparison(clock, left, right, enable, result);
  parameter WIDTH = 32;
  input clock, enable;
  input [WIDTH-1:0] left;
  input [WIDTH-1:0] right;
  output result;

  localparam SECTION_SIZE = 4;
  localparam SECTIONS = ((WIDTH % SECTION_SIZE) == 0) ? (WIDTH/SECTION_SIZE) : (WIDTH/SECTION_SIZE + 1);
  reg [SECTIONS-1:0] comparisons;

  wire [SECTIONS*SECTION_SIZE : 0] temp_left = {{{SECTIONS*SECTION_SIZE-WIDTH + 1}{1'b0}}, left};
  wire [SECTIONS*SECTION_SIZE : 0] temp_right = {{{SECTIONS*SECTION_SIZE-WIDTH + 1}{1'b0}}, right};

  genvar i;
  generate
    for (i=0; i < SECTIONS; i = i + 1)
    begin: cmp
      always@(posedge clock)
      begin
        if(enable) comparisons[i] <= (temp_left[(i+1)*SECTION_SIZE-1:SECTION_SIZE*i] == temp_right[(i+1)*SECTION_SIZE-1:SECTION_SIZE*i]);
      end
    end
  endgenerate

  assign result = &comparisons;
  
endmodule

  
