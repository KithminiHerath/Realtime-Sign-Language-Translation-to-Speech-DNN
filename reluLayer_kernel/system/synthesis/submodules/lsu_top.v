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


//
// Top level load/store unit
//
// Attributes of load/store units
//  Coalesced:  Accesses to neighbouring memory locations are grouped together
//              to improve efficiency and efficiently utilize memory bandwidth.
//  Hazard-Safe:The LSU is not susceptable to data hazards.
//  Ordered:    The LSU requires accesses to be in-order to properly coalesce.
//  Pipeline:   The LSU can handle multiple requests at a time without
//              stalling.  Improves throughput.
//
// Supports the following memory access patterns:
//  Simple      - STYLE="SIMPLE"
//                Coalesced: No, Ordered: N/A, Hazard-Safe: Yes, Pipelined, No
//                Simple un-pipelined memory access.  Low throughput.
//  Pipelined   - STYLE="PIPELINED"
//                Coalesced: No, Ordered: N/A, Hazard-Safe: Yes, Pipelined: Yes
//                Requests are submitted as soon as they are received.
//                Pipelined access to memory so multiple requests can be 
//                in flight at a time.
//  Enabled     - STYLE="ENABLED"
//                Coalesced: No, Ordered: N/A, Hazard-Safe: Yes, Pipelined: Yes
//                Requests are submitted as soon as they are received.
//                Pipelined access to memory so multiple requests can be 
//                in flight at a time. Stalls freeze the pipeline (incl. memory).
//                Currently only used in enable clusters.
//  Coalesced   - STYLE="BASIC-COALESCED"
//   "basic"      Coalesced: Yes, Ordered: Yes, Hazard-Safe: Yes, Pipelined: Yes
//                Requests are submitted as soon as possible to memory, stalled
//                requests are coalesced with neighbouring requests if they
//                access the same page of memory.
//  Coalesced   - STYLE="BURST-COALESCED"
//   "burst"      Coalesced: Yes, Ordered: Yes, Hazard-Safe: Yes, Pipelined: Yes
//                Requests are buffered until the biggest possible burst can
//                be made.
//  Streaming   - STYLE="STREAMING"
//                Coalesced: Yes, Ordered: Yes, Hazard-Safe: No, Pipelined: ?
//                A FIFO is instantiated which burst reads large blocks from 
//                memory to keep the FIFO full of valid data.  This block can 
//                only be used if accesses are in-order, and addresses can be
//                simply calculated from (base_address + n * word_width).  The
//                block has no built-in hazard protection.
//  Prefetching - STYLE="PREFETCHING"
//                Coalesced: No, Ordered: Yes, Hazard-Safe: No, Pipelined: ?
//                A FIFO is instantiated which burst reads large blocks from 
//                memory to keep the FIFO full of valid data based on the 
//                previous address and assuming contiguous reads.  
//                Non-contiguos reads are supported, but a penalty is incurred 
//                to flush and refill the FIFO. 
//  Atomic - STYLE="ATOMIC-PIPELINED"
//"pipelined"
//              Coalesced: No, Ordered: N/A, Hazard-Safe: Yes, Pipelined: Yes
//              Atomic: Yes
//              Requests are submitted as soon as they are received.
//              Pipelined access to memory so multiple requests can be 
//              in flight at a time.
//              Response is returned as soon as read is complete, 
//              write is issued subsequently by the atomic module at the end
//              of arbitration.

`default_nettype none

// altera message_off 10036
module lsu_top
(
    clock, clock2x, resetn, stream_base_addr, stream_size, stream_reset, i_atomic_op, o_stall, 
    i_valid, i_address, i_writedata, i_cmpdata, i_predicate, i_bitwiseor, i_stall, o_valid, 
    o_empty, o_almost_empty, o_readdata, avm_address, avm_enable, avm_read, avm_readdata, avm_write, 
    avm_writeack, avm_writedata, avm_byteenable, avm_waitrequest, avm_readdatavalid, avm_burstcount,
    o_active,
    o_input_fifo_depth,
    o_writeack,
    i_byteenable,
    flush,

    // profile signals
    profile_bw, profile_bw_incr,
    profile_total_ivalid,
    profile_total_req,
    profile_i_stall_count,
    profile_o_stall_count,
    profile_avm_readwrite_count,
    profile_avm_burstcount_total, profile_avm_burstcount_total_incr,
    profile_req_cache_hit_count,
    profile_extra_unaligned_reqs,
    profile_avm_stall
);

/*************
* Parameters *
*************/
parameter STYLE="PIPELINED"; // The LSU style to use (see style list above)
parameter AWIDTH=32;         // Address width (32-bits for Avalon)
parameter ATOMIC_WIDTH=6;    // Width of operation operation indices
parameter WIDTH_BYTES=4;     // Width of the request (bytes)
parameter MWIDTH_BYTES=32;   // Width of the global memory bus (bytes)
parameter WRITEDATAWIDTH_BYTES=32;  // Width of the readdata/writedata signals, 
                                    // may be larger than MWIDTH_BYTES for atomics
parameter ALIGNMENT_BYTES=2; // Request address alignment (bytes)
parameter READ=1;            // Read or write?
parameter ATOMIC=0;          // Atomic?
parameter BURSTCOUNT_WIDTH=6;// Determines max burst size
// Why two latencies? E.g. A streaming unit prefetches data, its latency to
// the kernel is very low because data is for the most part ready and waiting.
// But the lsu needs to know how much data to buffer to hide the latency to
// memory, hence the memory side latency.
parameter KERNEL_SIDE_MEM_LATENCY=1;  // Effective Latency in cycles as seen by the kernel pipeline
parameter MEMORY_SIDE_MEM_LATENCY=1;  // Latency in cycles between LSU and memory
parameter USE_WRITE_ACK=0;   // Enable the write-acknowledge signal
parameter USECACHING=0;
parameter USE_BYTE_EN=0;
parameter CACHESIZE=1024;
parameter PROFILE_ADDR_TOGGLE=0;
parameter USEINPUTFIFO=1;        // FIXME specific to lsu_pipelined
parameter USEOUTPUTFIFO=1;       // FIXME specific to lsu_pipelined
parameter STALLFREE=0;           // specific to lsu_pipelined_write
parameter FORCE_NOP_SUPPORT=0;   // Stall free pipeline doesn't want the NOP fifo
parameter HIGH_FMAX=1;           // Enable optimizations for high Fmax
parameter HYPER_PIPELINE=0;      // enable optimizations targeting HIPI based architectures, note that this can result in a large increase in area (not supported by all LSU types)
//*************************************************
// NOTE: STALL_LATENCY is currently NON-FUNCTIONAL!
//*************************************************
parameter USE_STALL_LATENCY=0;   // enable the stall latency protocol, which changes the definition of the stall and valid signals
parameter UPSTREAM_STALL_LATENCY=0; // round trip latency for the upstream (i_valid/o_stall) port, from o_stall being asserted to i_valid guaranteed deasserted.  Must be 0 if USE_STALL_LATENCY=0.
parameter ALMOST_EMPTY_THRESH=1;    // almost empty threshold, o_almost_empty asserts if the number of available thread is LESS THAN this number, only applies if USE_STALL_LATENCY=1


// TEMPORARY PARAMETER, applies only when HYPER_PIPELINE = 1, simulates FMAX that will be acheived when stall_latency and waitrequest_latency are available
parameter S10_NONFUNCTIONAL_FMAX_SPEEDUP = 0;      // set to '1' to add registers (in a non-functional way) that simulate 

parameter ASYNC_RESET=1;         // set to '1' to use the incoming resetn signal asynchronously, '0' to use synchronous reset (not supported by all LSU types)
parameter SYNCHRONIZE_RESET=1;   // set to '1' to pass the incoming resetn signal through a synchronizer before use

// Profiling
parameter ACL_PROFILE=0;      // Set to 1 to enable stall/valid profiling
parameter ACL_PROFILE_INCREMENT_WIDTH=32;

// Verilog readability and parsing only - no functional purpose
parameter ADDRSPACE=0;

// Local memory parameters
parameter ENABLE_BANKED_MEMORY=0;// Flag enables address permutation for banked local memory config
parameter ABITS_PER_LMEM_BANK=0; // Used when permuting lmem address bits to stride across banks
parameter NUMBER_BANKS=1;        // Number of memory banks - used in address permutation (1-disable)
parameter LMEM_ADDR_PERMUTATION_STYLE=0; // Type of address permutation (currently unused)

// Parameter limitations:
//    AWIDTH: Only tested with 32-bit addresses
//    WIDTH_BYTES: Must be a power of two
//    MWIDTH_BYTES: Must be a power of 2 >= WIDTH_BYTES
//    ALIGNMENT_BYTES: Must be a power of 2 satisfying,
//                     WIDTH_BYTES <= ALIGNMENT_BYTES <= MWIDTH_BYTES
//
//    The width and alignment restrictions ensure we never try to read a word
//    that strides across two "pages" (MWIDTH sized words)

// TODO: Convert these back into localparams when the back-end supports it
parameter WIDTH=8*WIDTH_BYTES;                      // Width in bits
parameter MWIDTH=8*MWIDTH_BYTES;                    // Width in bits
parameter WRITEDATAWIDTH=8*WRITEDATAWIDTH_BYTES;              // Width in bits
localparam ALIGNMENT_ABITS=$clog2(ALIGNMENT_BYTES); // Address bits to ignore
localparam LSU_CAPACITY=256;   // Maximum number of 'in-flight' load/store operations

localparam WIDE_LSU = (WIDTH > MWIDTH); 
// Performance monitor signals
parameter INPUTFIFO_USEDW_MAXBITS=8;

// LSU unit properties
localparam ATOMIC_PIPELINED_LSU=(STYLE=="ATOMIC-PIPELINED");
localparam PIPELINED_LSU=( (STYLE=="PIPELINED") || (STYLE=="BASIC-COALESCED") || (STYLE=="BURST-COALESCED") || (STYLE=="BURST-NON-ALIGNED") );
localparam SUPPORTS_NOP= (STYLE=="STREAMING") || (STYLE=="SEMI-STREAMING") || (STYLE=="BURST-NON-ALIGNED") || (STYLE=="BURST-COALESCED") ||  (STYLE=="PREFETCHING") || (FORCE_NOP_SUPPORT==1);
localparam SUPPORTS_BURSTS=( (STYLE=="STREAMING") || (STYLE=="BURST-COALESCED") || (STYLE=="SEMI-STREAMING") || (STYLE=="BURST-NON-ALIGNED") || (STYLE=="PREFETCHING"));

/********
* Ports *
********/
// Standard global signals
input wire clock;
input wire clock2x;
input wire resetn;
input wire flush;

// Streaming interface signals
input wire [AWIDTH-1:0] stream_base_addr;
input wire [31:0] stream_size;
input wire stream_reset;

// Atomic interface
input wire [WIDTH-1:0] i_cmpdata; // only used by atomic_cmpxchg
input wire [ATOMIC_WIDTH-1:0] i_atomic_op;

// Upstream interface
output wire o_stall;          // protocol for o_stall/i_valid determined by the USE_STALL_LATENCY parameter
input wire i_valid;
input wire [AWIDTH-1:0] i_address;
input wire [WIDTH-1:0] i_writedata;
input wire i_predicate;
input wire [AWIDTH-1:0] i_bitwiseor;
input wire [WIDTH_BYTES-1:0] i_byteenable;

// Downstream interface
input wire i_stall;           // protocol for o_stall/i_valid determined by the USE_STALL_LATENCY parameter
output wire o_valid;
output wire o_empty;          // o_empty and o_almost_empty only supported when USE_STALL_LATENCY=1
output wire o_almost_empty;
output wire [WIDTH-1:0] o_readdata;

// Avalon interface
output wire [AWIDTH-1:0] avm_address;
output wire avm_enable;
output wire avm_read;
input wire [WRITEDATAWIDTH-1:0] avm_readdata;
output wire avm_write;
input wire avm_writeack;
output wire o_writeack;
output wire [WRITEDATAWIDTH-1:0] avm_writedata;
output wire [WRITEDATAWIDTH_BYTES-1:0] avm_byteenable;
input wire avm_waitrequest;
input wire avm_readdatavalid;
output wire [BURSTCOUNT_WIDTH-1:0] avm_burstcount;

output reg o_active;

// For profiling/performance monitor
output logic [INPUTFIFO_USEDW_MAXBITS-1:0] o_input_fifo_depth;

// Profiler Signals
output logic profile_bw;
output logic [ACL_PROFILE_INCREMENT_WIDTH-1:0] profile_bw_incr;
output logic profile_total_ivalid;
output logic profile_total_req;
output logic profile_i_stall_count;
output logic profile_o_stall_count;
output logic profile_avm_readwrite_count;
output logic profile_avm_burstcount_total;
output logic [ACL_PROFILE_INCREMENT_WIDTH-1:0] profile_avm_burstcount_total_incr;
output logic profile_req_cache_hit_count;
output logic profile_extra_unaligned_reqs;
output logic profile_avm_stall;


   ///////////////////////////////////////
   // Reset signal replication and pipelining
   //
   // In order to ensure that the reset signal is not a limiting factor when 
   // doing retiming, we create multiple copies of the reset signal and 
   // pipeline each adequately.
   ///////////////////////////////////////
   localparam                    NUM_RESET_COPIES = 1;
   localparam                    RESET_PIPE_DEPTH = 1;
   logic                         aclrn;
   logic [NUM_RESET_COPIES-1:0]  sclrn;
   logic                         resetn_synchronized;
   acl_reset_handler #(
      .ASYNC_RESET            (ASYNC_RESET),
      .USE_SYNCHRONIZER       (SYNCHRONIZE_RESET),
      .SYNCHRONIZE_ACLRN      (SYNCHRONIZE_RESET),
      .PIPE_DEPTH             (RESET_PIPE_DEPTH),
      .NUM_COPIES             (NUM_RESET_COPIES)
   ) acl_reset_handler_inst (
      .clk                    (clock),
      .i_resetn               (resetn),
      .o_aclrn                (aclrn),
      .o_sclrn                (sclrn),
      .o_resetn_synchronized  (resetn_synchronized)
   );


generate
if(WIDE_LSU) begin
  //break transaction into multiple cycles
  lsu_wide_wrapper lsu_wide (
	.clock(clock),
	.clock2x(clock2x),
	.resetn(resetn_synchronized),
	.flush(flush),
	.stream_base_addr(stream_base_addr),
	.stream_size(stream_size),
	.stream_reset(stream_reset),
	.o_stall(o_stall),
	.i_valid(i_valid),
	.i_address(i_address),
	.i_writedata(i_writedata),
	.i_cmpdata(i_cmpdata),
	.i_predicate(i_predicate),
	.i_bitwiseor(i_bitwiseor),
	.i_byteenable(i_byteenable),
	.i_stall(i_stall),
	.o_valid(o_valid),
	.o_readdata(o_readdata),
	.o_input_fifo_depth(o_input_fifo_depth),
	.o_writeack(o_writeack),
	.i_atomic_op(i_atomic_op),
	.o_active(o_active),
	.avm_address(avm_address),
	.avm_enable(avm_enable),
	.avm_read(avm_read),
	.avm_readdata(avm_readdata),
	.avm_write(avm_write),
	.avm_writeack(avm_writeack),
	.avm_burstcount(avm_burstcount),
	.avm_writedata(avm_writedata),
	.avm_byteenable(avm_byteenable),
	.avm_waitrequest(avm_waitrequest),
	.avm_readdatavalid(avm_readdatavalid),
	.profile_req_cache_hit_count(profile_req_cache_hit_count),
	.profile_extra_unaligned_reqs(profile_extra_unaligned_reqs)
);
  assign o_empty = '0;
  assign o_almost_empty = '0;

  defparam lsu_wide.STYLE = STYLE;
  defparam lsu_wide.AWIDTH = AWIDTH;
  defparam lsu_wide.ATOMIC_WIDTH = ATOMIC_WIDTH;
  defparam lsu_wide.WIDTH_BYTES = WIDTH_BYTES;
  defparam lsu_wide.MWIDTH_BYTES = MWIDTH_BYTES;
  defparam lsu_wide.WRITEDATAWIDTH_BYTES = WRITEDATAWIDTH_BYTES;
  defparam lsu_wide.ALIGNMENT_BYTES = ALIGNMENT_BYTES;
  defparam lsu_wide.READ = READ;
  defparam lsu_wide.ATOMIC = ATOMIC;
  defparam lsu_wide.BURSTCOUNT_WIDTH = BURSTCOUNT_WIDTH;
  defparam lsu_wide.KERNEL_SIDE_MEM_LATENCY = KERNEL_SIDE_MEM_LATENCY;
  defparam lsu_wide.MEMORY_SIDE_MEM_LATENCY = MEMORY_SIDE_MEM_LATENCY;
  defparam lsu_wide.USE_WRITE_ACK = USE_WRITE_ACK;
  defparam lsu_wide.USECACHING = USECACHING;
  defparam lsu_wide.USE_BYTE_EN = USE_BYTE_EN;
  defparam lsu_wide.CACHESIZE = CACHESIZE;
  defparam lsu_wide.PROFILE_ADDR_TOGGLE = PROFILE_ADDR_TOGGLE;
  defparam lsu_wide.USEINPUTFIFO = USEINPUTFIFO;
  defparam lsu_wide.USEOUTPUTFIFO = USEOUTPUTFIFO;
  defparam lsu_wide.FORCE_NOP_SUPPORT = FORCE_NOP_SUPPORT;
  defparam lsu_wide.HIGH_FMAX = HIGH_FMAX;
  defparam lsu_wide.ACL_PROFILE = ACL_PROFILE;
  defparam lsu_wide.ACL_PROFILE_INCREMENT_WIDTH = ACL_PROFILE_INCREMENT_WIDTH;
  defparam lsu_wide.ENABLE_BANKED_MEMORY = ENABLE_BANKED_MEMORY;
  defparam lsu_wide.ABITS_PER_LMEM_BANK = ABITS_PER_LMEM_BANK;
  defparam lsu_wide.NUMBER_BANKS = NUMBER_BANKS;
  defparam lsu_wide.WIDTH = WIDTH;
  defparam lsu_wide.MWIDTH = MWIDTH;  
  defparam lsu_wide.WRITEDATAWIDTH = WRITEDATAWIDTH;
  defparam lsu_wide.INPUTFIFO_USEDW_MAXBITS = INPUTFIFO_USEDW_MAXBITS;
  defparam lsu_wide.LMEM_ADDR_PERMUTATION_STYLE = LMEM_ADDR_PERMUTATION_STYLE;
  defparam lsu_wide.ADDRSPACE = ADDRSPACE;
  
  //the wrapped LSU doesnt interface directly with the avalon master, so profiling here is more accurate for avm signals
  //two signals generated directly by the LSU need to be passed in
  if(ACL_PROFILE==1)
  begin

   // keep track of write bursts
   reg [BURSTCOUNT_WIDTH-1:0] profile_remaining_writeburst_count;
   wire active_write_burst;
   assign active_write_burst = (profile_remaining_writeburst_count != {BURSTCOUNT_WIDTH{1'b0}});
   always@(posedge clock or negedge aclrn) begin
      if (!aclrn) begin
         profile_remaining_writeburst_count <= {BURSTCOUNT_WIDTH{1'b0}};
      end else begin
         if(avm_write & ~avm_waitrequest & ~active_write_burst) begin
            // start of a new write burst
            profile_remaining_writeburst_count <= avm_burstcount - 1;
         end else if(~avm_waitrequest & active_write_burst) begin
            // count down one burst
            profile_remaining_writeburst_count <= profile_remaining_writeburst_count - 1; 
         end
         if (~sclrn[0]) begin
            profile_remaining_writeburst_count <= {BURSTCOUNT_WIDTH{1'b0}};
         end
      end
   end
           

     assign profile_bw = (READ==1) ? avm_readdatavalid : (avm_write & ~avm_waitrequest);
     assign profile_bw_incr = MWIDTH_BYTES;
     assign profile_total_ivalid = (i_valid & ~o_stall);
     assign profile_total_req = (i_valid & ~i_predicate & ~o_stall);
     assign profile_i_stall_count = (i_stall & o_valid);
     assign profile_o_stall_count = (o_stall & i_valid);
     assign profile_avm_readwrite_count = ((avm_read | avm_write) & ~avm_waitrequest & ~active_write_burst);
     assign profile_avm_burstcount_total = ((avm_read | avm_write) & ~avm_waitrequest & ~active_write_burst);
     assign profile_avm_burstcount_total_incr = avm_burstcount;
     assign profile_avm_stall = ((avm_read | avm_write) & avm_waitrequest);

  end
  else begin
     assign profile_bw = 1'b0;
     assign profile_bw_incr = {ACL_PROFILE_INCREMENT_WIDTH{1'b0}};
     assign profile_total_ivalid = 1'b0;
     assign profile_total_req = 1'b0;
     assign profile_i_stall_count = 1'b0;
     assign profile_o_stall_count = 1'b0;
     assign profile_avm_readwrite_count = 1'b0;
     assign profile_avm_burstcount_total = 1'b0;
     assign profile_avm_burstcount_total_incr = {ACL_PROFILE_INCREMENT_WIDTH{1'b0}};
     assign profile_avm_stall = 1'b0;
  end
    
  assign o_empty = '0;
  assign o_almost_empty = '0;
  
end
else begin 

wire lsu_active;

// For handling dependents of this lsu
assign o_writeack = avm_writeack;

// If the memory is banked, permute the address appropriately
wire [AWIDTH-1:0] avm_address_raw;
lsu_permute_address #(
    .AWIDTH               (                                    AWIDTH),
    .ENABLE_BANKED_MEMORY (                      ENABLE_BANKED_MEMORY),
    .NUMBER_BANKS         (                              NUMBER_BANKS),
    .BITS_IN_BYTE_SELECT  (                      $clog2(MWIDTH_BYTES)),
    .WORD_SELECT_BITS     (ABITS_PER_LMEM_BANK - $clog2(MWIDTH_BYTES))
  ) u_permute_address (
    .i_addr(avm_address_raw),
    .o_addr(avm_address)
  );

/***************
* Architecture *
***************/

// Tie off the unused read/write signals

// atomics dont have unused signals
if(ATOMIC==0) begin
  if(READ==1)
  begin
     assign avm_write = 1'b0;
     //assign avm_writedata = {MWIDTH{1'bx}};
     assign avm_writedata = {MWIDTH{1'b0}}; // make writedata 0 because it is used by atomics
  end
  else // WRITE
  begin
    assign avm_read = 1'b0;
  end
end
else begin //ATOMIC
  assign avm_write = 1'b0;
end








// Write acknowledge support: If WRITEACK is not to be supported, than assume
// that a write is fully completed as soon as it is accepted by the fabric.
// Otherwise, wait for the writeack signal to return.
wire lsu_writeack;  
if(USE_WRITE_ACK==1)
begin
   assign lsu_writeack = avm_writeack;
end
else
begin
   assign lsu_writeack = avm_write && !avm_waitrequest;
end


// NOP support: The least-significant address bit indicates if this is a NOP
// instruction (i.e. we do not wish a read/write to be performed).  
// Appropriately adjust the valid and stall inputs to the core LSU block to
// ensure NOP instructions are not executed and preserve their ordering with
// other threads.
wire lsu_i_valid;
wire lsu_o_valid;
wire lsu_o_empty;
wire lsu_o_almost_empty;
wire lsu_i_stall;
wire lsu_o_stall;
wire [AWIDTH-1:0] address;
wire nop;


if ((FORCE_NOP_SUPPORT) && ((STYLE=="BASIC-COALESCED") ||
                            (STYLE=="SIMPLE") ||
                            (STYLE=="PIPELINED") || 
                            (STYLE=="ENABLED") ||
                            (STYLE=="ATOMIC-PIPELINED") ||
                            (STYLE=="BASIC-COALESCED")))
begin
   // Some LSUs simply do not have predicate support, but we may end up in a configuration where we force
   // them to support that feature. In such a case, the only way to do this is to predicate the valid signal
   // such that it accounts for an operation that is not actually being performed.
   //
   // Please note that this kind of operation only works in stall-free clusters.
   assign lsu_i_valid = i_valid & ~i_predicate;
   assign lsu_i_stall = i_stall;
   assign o_valid = lsu_o_valid;
   assign o_empty = lsu_o_empty;
   assign o_almost_empty = lsu_o_almost_empty;
   assign o_stall = lsu_o_stall;
   assign address = i_address | i_bitwiseor;
end
else if(SUPPORTS_NOP)
begin
   // Module intrinsicly supports NOP operations, just pass them on through
   assign lsu_i_valid = i_valid;
   assign lsu_i_stall = i_stall;
   assign o_valid = lsu_o_valid;
   assign o_empty = lsu_o_empty;
   assign o_almost_empty = lsu_o_almost_empty;
   assign o_stall = lsu_o_stall;
   assign address = i_address | i_bitwiseor;
end
else if(PIPELINED_LSU || ATOMIC_PIPELINED_LSU)
begin
   // No built-in NOP support.  Pipelined LSUs without NOP support need us to 
   // build a fifo along side the core LSU to track NOP instructions
   wire nop_fifo_empty;
   wire nop_fifo_full;
   wire nop_next;

   assign nop = i_predicate;
   assign address = i_address | i_bitwiseor;

   // Store the NOP status flags along side the core LSU
   // Assume (TODO eliminate this assumption?) that KERNEL_SIDE_MEM_LATENCY is the max 
   // number of simultaneous requests in flight for the LSU. The NOP FIFO will
   // will be sized to KERNEL_SIDE_MEM_LATENCY+1 to prevent stalls when the LSU is
   // full.
   //
   // For smaller latency values, use registers to implement the FIFO.
   if(KERNEL_SIDE_MEM_LATENCY <= 64)
   begin
      acl_ll_fifo #(
         .WIDTH(1),
         .DEPTH(KERNEL_SIDE_MEM_LATENCY+1)
      ) nop_fifo (
         .clk(clock),
         .reset(~resetn_synchronized),
         .data_in(nop),
         .write(i_valid && !o_stall),
         .data_out(nop_next),
         .read(o_valid && !i_stall),
         .full(nop_fifo_full),
         .empty(nop_fifo_empty)
      );
   end
   else
   begin
      scfifo #(
         .add_ram_output_register( "OFF" ),
         .lpm_numwords( KERNEL_SIDE_MEM_LATENCY+1 ),
         .lpm_showahead( "ON" ),
         .lpm_type( "scfifo" ),
         .lpm_width( 1 ),
         .lpm_widthu( $clog2(KERNEL_SIDE_MEM_LATENCY+1) ),
         .overflow_checking( "OFF" ),
         .underflow_checking( "OFF" )
      ) nop_fifo (
         .clock(clock),
         .data(nop),
         .rdreq(o_valid && !i_stall),
         .wrreq(i_valid && !o_stall),
         .empty(nop_fifo_empty),
         .full(nop_fifo_full),
         .q(nop_next),
         .aclr(!resetn_synchronized),
         .almost_full(),
         .almost_empty(),
         .usedw(),
         .sclr()
      );
   end

   // Logic to prevent NOP instructions from entering the core
   assign lsu_i_valid = !nop && i_valid && !nop_fifo_full;
   assign lsu_i_stall = nop_fifo_empty || nop_next || i_stall;

   // Logic to generate the valid bit for NOP instructions that have bypassed
   // the LSU.  The instructions must be kept in order so they are consistant
   // with data propagating through pipelines outside of the LSU.
   assign o_valid = (lsu_o_valid || nop_next) && !nop_fifo_empty;
   assign o_empty = lsu_o_empty;
   assign o_almost_empty = lsu_o_almost_empty;
   assign o_stall = nop_fifo_full || lsu_o_stall;
end
else
begin
   // An unpipelined LSU will only have one active request at a time.  We just
   // need to track whether there is a pending request in the LSU core and
   // appropriately bypass the core with NOP requests while preserving the
   // thread ordering.  (A NOP passes straight through to the downstream 
   // block, unless there is a pending request in the block, in which case
   // we stall until the request is complete).
   reg pending;
   always@(posedge clock or negedge aclrn)
   begin
      if(~aclrn) begin
         pending <= 1'b0;
      end else begin
         pending <= pending ? ((lsu_i_valid && !lsu_o_stall) || !(lsu_o_valid && !lsu_i_stall)) :
                              ((lsu_i_valid && !lsu_o_stall) && !(lsu_o_valid && !lsu_i_stall));
         if (~sclrn[0]) begin
            pending <= '0;
         end
      end
   end

   assign nop = i_predicate;
   assign address = i_address | i_bitwiseor;

   assign lsu_i_valid = i_valid && !nop;
   assign lsu_i_stall = i_stall;
   assign o_valid = lsu_o_valid || (!pending && i_valid && nop);
   assign o_empty = lsu_o_empty;
   assign o_almost_empty = lsu_o_almost_empty;
   assign o_stall = lsu_o_stall || (pending && nop);
end


// Styles with no burst support require burstcount=1

if(!SUPPORTS_BURSTS)
begin
   assign avm_burstcount = 1;
end


// Profiling signals.
wire req_cache_hit_count;
wire extra_unaligned_reqs;

// initialize
if(STYLE!="BURST-NON-ALIGNED")
assign extra_unaligned_reqs = 1'b0;
if(READ==0 || (STYLE!="BURST-COALESCED" && STYLE!="BURST-NON-ALIGNED" && STYLE!="SEMI-STREAMING"))
assign req_cache_hit_count = 1'b0;

// Generate different architectures based on the STYLE parameter

////////////////
// Simple LSU //
////////////////
if(STYLE=="SIMPLE")
begin
    if(READ == 1)
    begin
        lsu_simple_read #(
            .AWIDTH(AWIDTH),
            .WIDTH_BYTES(WIDTH_BYTES),
            .MWIDTH_BYTES(MWIDTH_BYTES),
            .ALIGNMENT_ABITS(ALIGNMENT_ABITS),
            .HIGH_FMAX(HIGH_FMAX)
        ) simple_read (
            .clk(clock),
            .reset(!resetn_synchronized),
            .o_stall(lsu_o_stall),
            .i_valid(lsu_i_valid),
            .i_address(address),
            .i_stall(lsu_i_stall),
            .o_valid(lsu_o_valid),
            .o_active(lsu_active),
            .o_readdata(o_readdata),
            .avm_address(avm_address_raw),
            .avm_read(avm_read),
            .avm_readdata(avm_readdata),
            .avm_waitrequest(avm_waitrequest),
            .avm_byteenable(avm_byteenable),
            .avm_readdatavalid(avm_readdatavalid)
        );
        assign lsu_o_empty = '0;
        assign lsu_o_almost_empty = '0;
    end
    else
    begin
        lsu_simple_write #(
            .AWIDTH(AWIDTH),
            .WIDTH_BYTES(WIDTH_BYTES),
            .MWIDTH_BYTES(MWIDTH_BYTES),
            .USE_BYTE_EN(USE_BYTE_EN),
            .ALIGNMENT_ABITS(ALIGNMENT_ABITS)
        ) simple_write (
            .clk(clock),
            .reset(!resetn_synchronized),
            .o_stall(lsu_o_stall),
            .i_valid(lsu_i_valid),
            .i_address(address),
            .i_writedata(i_writedata),
            .i_stall(lsu_i_stall),
            .o_valid(lsu_o_valid),
            .i_byteenable(i_byteenable),
            .o_active(lsu_active),
            .avm_address(avm_address_raw),
            .avm_write(avm_write),
            .avm_writeack(lsu_writeack),
            .avm_writedata(avm_writedata),
            .avm_byteenable(avm_byteenable),
            .avm_waitrequest(avm_waitrequest)
        );
        assign lsu_o_empty = '0;
        assign lsu_o_almost_empty = '0;
    end
    assign avm_enable = 1'b1;
end

///////////////
// Pipelined //
///////////////
else if(STYLE=="PIPELINED")
begin
    wire sub_o_stall;
    if(USEINPUTFIFO == 0) begin : GEN_0
      assign lsu_o_stall = sub_o_stall & !i_predicate;
    end
    else begin : GEN_1
      assign lsu_o_stall = sub_o_stall;
    end 
    if(READ == 1)
    begin
        lsu_pipelined_read #(
            .KERNEL_SIDE_MEM_LATENCY(KERNEL_SIDE_MEM_LATENCY),
            .AWIDTH(AWIDTH),
            .WIDTH_BYTES(WIDTH_BYTES),
            .MWIDTH_BYTES(MWIDTH_BYTES),
            .ALIGNMENT_ABITS(ALIGNMENT_ABITS),
            .USEINPUTFIFO(USEINPUTFIFO),
            .USEOUTPUTFIFO(USEOUTPUTFIFO),
            .ASYNC_RESET(ASYNC_RESET),
            .SYNCHRONIZE_RESET(0)
        ) pipelined_read (
            .clk(clock),
            .resetn(resetn_synchronized),
            .o_stall(sub_o_stall),
            .i_valid(lsu_i_valid),
            .i_address(address),
            .i_stall(lsu_i_stall),
            .o_valid(lsu_o_valid),
            .o_readdata(o_readdata),
            .o_input_fifo_depth(o_input_fifo_depth),
            .o_active(lsu_active),
            .avm_address(avm_address_raw),
            .avm_read(avm_read),
            .avm_readdata(avm_readdata),
            .avm_waitrequest(avm_waitrequest),
            .avm_byteenable(avm_byteenable),
            .avm_readdatavalid(avm_readdatavalid)
        );
        assign lsu_o_empty = '0;
        assign lsu_o_almost_empty = '0;
    end
    else
    begin
        lsu_pipelined_write #(
            .KERNEL_SIDE_MEM_LATENCY(KERNEL_SIDE_MEM_LATENCY),
            .AWIDTH(AWIDTH),
            .WIDTH_BYTES(WIDTH_BYTES),
            .MWIDTH_BYTES(MWIDTH_BYTES),
            .USE_BYTE_EN(USE_BYTE_EN),
            .ALIGNMENT_ABITS(ALIGNMENT_ABITS),
            .USEINPUTFIFO(USEINPUTFIFO),
            .STALLFREE(STALLFREE),
            .ASYNC_RESET(ASYNC_RESET),
            .SYNCHRONIZE_RESET(0)
        ) pipelined_write (
            .clk(clock),
            .resetn(resetn_synchronized),
            .o_stall(sub_o_stall),
            .i_valid(lsu_i_valid),
            .i_address(address),
            .i_byteenable(i_byteenable),
            .i_writedata(i_writedata),
            .i_stall(lsu_i_stall),
            .o_valid(lsu_o_valid),
            .o_input_fifo_depth(o_input_fifo_depth),
            .o_active(lsu_active),
            .avm_address(avm_address_raw),
            .avm_write(avm_write),
            .avm_writeack(lsu_writeack),
            .avm_writedata(avm_writedata),
            .avm_byteenable(avm_byteenable),
            .avm_waitrequest(avm_waitrequest)
        );
        assign o_readdata = 'bx;
        assign lsu_o_empty = '0;
        assign lsu_o_almost_empty = '0;

    end
    assign avm_enable = 1'b1;
end

///////////////
// Enabled //
///////////////
else if(STYLE=="ENABLED")
begin
    wire sub_o_stall;
    assign lsu_o_stall = sub_o_stall & !i_predicate;

    if(READ == 1)
    begin
        lsu_enabled_read #(
            .KERNEL_SIDE_MEM_LATENCY(KERNEL_SIDE_MEM_LATENCY),
            .AWIDTH(AWIDTH),
            .WIDTH_BYTES(WIDTH_BYTES),
            .MWIDTH_BYTES(MWIDTH_BYTES),
            .ALIGNMENT_ABITS(ALIGNMENT_ABITS)
        ) enabled_read (
            .clk(clock),
            .reset(!resetn_synchronized),
            .o_stall(sub_o_stall),
            .i_valid(lsu_i_valid),
            .i_address(address),
            .i_stall(lsu_i_stall),
            .o_valid(lsu_o_valid),
            .o_readdata(o_readdata),
            .o_active(lsu_active),
            .avm_address(avm_address_raw),
            .avm_enable(avm_enable),
            .avm_read(avm_read),
            .avm_readdata(avm_readdata),
            .avm_waitrequest(avm_waitrequest),
            .avm_byteenable(avm_byteenable),
            .avm_readdatavalid(avm_readdatavalid)
        );
        assign lsu_o_empty = '0;
        assign lsu_o_almost_empty = '0;
    end
    else
    begin
        lsu_enabled_write #(
            .KERNEL_SIDE_MEM_LATENCY(KERNEL_SIDE_MEM_LATENCY),
            .AWIDTH(AWIDTH),
            .WIDTH_BYTES(WIDTH_BYTES),
            .MWIDTH_BYTES(MWIDTH_BYTES),
            .USE_BYTE_EN(USE_BYTE_EN),
            .ALIGNMENT_ABITS(ALIGNMENT_ABITS)
        ) enabled_write (
            .clk(clock),
            .reset(!resetn_synchronized),
            .o_stall(sub_o_stall),
            .i_valid(lsu_i_valid),
            .i_address(address),
            .i_byteenable(i_byteenable),
            .i_writedata(i_writedata),
            .i_stall(lsu_i_stall),
            .o_valid(lsu_o_valid),
            .o_active(lsu_active),
            .avm_address(avm_address_raw),
            .avm_enable(avm_enable),
            .avm_write(avm_write),
            .avm_writeack(lsu_writeack),
            .avm_writedata(avm_writedata),
            .avm_byteenable(avm_byteenable),
            .avm_waitrequest(avm_waitrequest)
        );
        assign o_readdata = 'bx;
        assign lsu_o_empty = '0;
        assign lsu_o_almost_empty = '0;
    end
end

//////////////////////
// Atomic Pipelined //
//////////////////////
else if(STYLE=="ATOMIC-PIPELINED")
begin
    lsu_atomic_pipelined #(
           .KERNEL_SIDE_MEM_LATENCY(KERNEL_SIDE_MEM_LATENCY),
           .AWIDTH(AWIDTH),
           .WIDTH_BYTES(WIDTH_BYTES),
           .MWIDTH_BYTES(MWIDTH_BYTES),
           .WRITEDATAWIDTH_BYTES(WRITEDATAWIDTH_BYTES),
           .ALIGNMENT_ABITS(ALIGNMENT_ABITS),
           .USEINPUTFIFO(USEINPUTFIFO),
           .USEOUTPUTFIFO(USEOUTPUTFIFO),
           .ATOMIC_WIDTH(ATOMIC_WIDTH)
    ) atomic_pipelined (
           .clk(clock),
           .reset(!resetn_synchronized),
           .o_stall(lsu_o_stall),
           .i_valid(lsu_i_valid),
           .i_address(address),
           .i_stall(lsu_i_stall),
           .o_valid(lsu_o_valid),
           .o_readdata(o_readdata),
           .o_input_fifo_depth(o_input_fifo_depth),
           .o_active(lsu_active),
           .avm_address(avm_address_raw),
           .avm_read(avm_read),
           .avm_readdata(avm_readdata),
           .avm_waitrequest(avm_waitrequest),
           .avm_byteenable(avm_byteenable),
           .avm_readdatavalid(avm_readdatavalid),
           .i_atomic_op(i_atomic_op),
           .i_writedata(i_writedata),
           .i_cmpdata(i_cmpdata),
           .avm_writeack(lsu_writeack),
           .avm_writedata(avm_writedata)
    );
   assign avm_enable = 1'b1;
   assign lsu_o_empty = '0;
   assign lsu_o_almost_empty = '0;
end

/////////////////////
// Basic Coalesced //
/////////////////////
else if(STYLE=="BASIC-COALESCED")
begin
    if(READ == 1)
    begin
        lsu_basic_coalesced_read #(
            .KERNEL_SIDE_MEM_LATENCY(KERNEL_SIDE_MEM_LATENCY),
            .AWIDTH(AWIDTH),
            .WIDTH_BYTES(WIDTH_BYTES),
            .MWIDTH_BYTES(MWIDTH_BYTES),
            .ALIGNMENT_ABITS(ALIGNMENT_ABITS)
        ) basic_coalesced_read (
            .clk(clock),
            .reset(!resetn_synchronized),
            .o_stall(lsu_o_stall),
            .i_valid(lsu_i_valid),
            .i_address(address),
            .i_stall(lsu_i_stall),
            .o_valid(lsu_o_valid),
            .o_readdata(o_readdata),
            .avm_address(avm_address_raw),
            .avm_read(avm_read),
            .avm_readdata(avm_readdata),
            .avm_waitrequest(avm_waitrequest),
            .avm_byteenable(avm_byteenable),
            .avm_readdatavalid(avm_readdatavalid)
        );
        assign lsu_o_empty = '0;
        assign lsu_o_almost_empty = '0;
    end
    else
    begin
        lsu_basic_coalesced_write #(
            .KERNEL_SIDE_MEM_LATENCY(KERNEL_SIDE_MEM_LATENCY),
            .AWIDTH(AWIDTH),
            .WIDTH_BYTES(WIDTH_BYTES),
            .USE_BYTE_EN(USE_BYTE_EN),
            .MWIDTH_BYTES(MWIDTH_BYTES),
            .ALIGNMENT_ABITS(ALIGNMENT_ABITS)
        ) basic_coalesced_write (
            .clk(clock),
            .reset(!resetn_synchronized),
            .o_stall(lsu_o_stall),
            .i_valid(lsu_i_valid),
            .i_address(address),
            .i_writedata(i_writedata),
            .i_byteenable(i_byteenable),
            .i_stall(lsu_i_stall),
            .o_valid(lsu_o_valid),
            .o_active(lsu_active),
            .avm_address(avm_address_raw),
            .avm_write(avm_write),
            .avm_writeack(lsu_writeack),
            .avm_writedata(avm_writedata),
            .avm_byteenable(avm_byteenable),
            .avm_waitrequest(avm_waitrequest)
        );
        assign lsu_o_empty = '0;
        assign lsu_o_almost_empty = '0;
    end
   assign avm_enable = 1'b1;
end

/////////////////////
// Burst Coalesced //
/////////////////////
else if(STYLE=="BURST-COALESCED")
begin
    if(READ == 1)
    begin
      if((USECACHING == 1) || (HYPER_PIPELINE == 0))     // hyper-optimized LSU does not currently support caching
      begin
        lsu_bursting_read #(
            .KERNEL_SIDE_MEM_LATENCY(KERNEL_SIDE_MEM_LATENCY),
            .MEMORY_SIDE_MEM_LATENCY(MEMORY_SIDE_MEM_LATENCY),
            .AWIDTH(AWIDTH),
            .WIDTH_BYTES(WIDTH_BYTES),
            .MWIDTH_BYTES(MWIDTH_BYTES),
            .ALIGNMENT_ABITS(ALIGNMENT_ABITS),
            .BURSTCOUNT_WIDTH(BURSTCOUNT_WIDTH),
            .USECACHING(USECACHING),
            .HIGH_FMAX(HIGH_FMAX),
            .ACL_PROFILE(ACL_PROFILE),
            .CACHE_SIZE_N(CACHESIZE)
        ) bursting_read (
            .clk(clock),
            .clk2x(clock2x),
            .reset(!resetn_synchronized),
            .flush(flush),
            .i_nop(i_predicate),
            .o_stall(lsu_o_stall),
            .i_valid(lsu_i_valid),            
            .i_address(address),
            .i_stall(lsu_i_stall),
            .o_valid(lsu_o_valid),
            .o_readdata(o_readdata),
            .o_active(lsu_active),
            .avm_address(avm_address_raw),
            .avm_read(avm_read),
            .avm_readdata(avm_readdata),
            .avm_waitrequest(avm_waitrequest),
            .avm_byteenable(avm_byteenable),
            .avm_burstcount(avm_burstcount),
            .avm_readdatavalid(avm_readdatavalid),
            .req_cache_hit_count(req_cache_hit_count)
        );
        assign lsu_o_empty = '0;
        assign lsu_o_almost_empty = '0;
      end
      else                                   // LSU optimized for HIPI architecture
      begin
      
         // TEMPORARY CODE for simulating the effect on FMAX of stall latency and waitrequest latency, when those features become available
         // setting S10_NONFUNCTIONAL_FMAX_SPEEDUP = 1 will enable this code, which will render the lsu NON-FUNCTIONAL!
         logic [3:1] avm_waitrequest_pipe;
         logic       avm_waitrequest_internal;
         logic [3:1] stall_pipe;
         logic       stall_internal;
         always @(posedge clock) begin
            avm_waitrequest_pipe[1] <= avm_waitrequest;
            avm_waitrequest_pipe[3:2] <= avm_waitrequest_pipe[2:1];
            stall_pipe[1] <= lsu_i_stall;
            stall_pipe[3:2] <= stall_pipe[2:1];
         end
         assign avm_waitrequest_internal  = S10_NONFUNCTIONAL_FMAX_SPEEDUP ? avm_waitrequest_pipe[3] : avm_waitrequest;
         assign stall_internal            = S10_NONFUNCTIONAL_FMAX_SPEEDUP ? stall_pipe[3] : lsu_i_stall; 

      
         lsu_burst_coalesced_pipelined_read #(
            .AWIDTH                    (AWIDTH),
            .ALIGNMENT_ABITS           (ALIGNMENT_ABITS),
            .WIDTH_BYTES               (WIDTH_BYTES),
            .MWIDTH_BYTES              (MWIDTH_BYTES),
            .BURSTCOUNT_WIDTH          (BURSTCOUNT_WIDTH),
            .USECACHING                (USECACHING),
            .CACHE_DEPTH               (CACHESIZE),
            .TIMEOUT                   (8),
            .MAX_THREADS_PER_BURST_LOG2            (6),
            .END_BURST_MWORD_BOUNDRY_THREADS_LOG2  (6),
            // TODO: the following +10 'magic number' is there to match the latency used by the lsu_bursting_read.  Explicit control of these parameters should be given to the compiler.
            .MIN_THREAD_CAPACITY       ((MEMORY_SIDE_MEM_LATENCY <= 246)? 256 : MEMORY_SIDE_MEM_LATENCY + 10),            // minimum number of threads this block must be able to accept when backpressured (stall_in asserted).  Note that this block may still stall before reaching this capacity if the Avalon bus stalls
            .MIN_MEMORY_BUFFER_DEPTH   ((MEMORY_SIDE_MEM_LATENCY <= 246)? 256 : MEMORY_SIDE_MEM_LATENCY + 10),
            .ACL_PROFILE               (ACL_PROFILE),
            .ASYNC_RESET               (ASYNC_RESET),
            .SYNCHRONIZE_RESET         (0),
            .USE_STALL_LATENCY         (USE_STALL_LATENCY),
            .UPSTREAM_STALL_LATENCY    (UPSTREAM_STALL_LATENCY),
            .ALMOST_EMPTY_THRESH       (ALMOST_EMPTY_THRESH)
         ) bursting_read (
            .clock                     (clock),
            .i_resetn                  (resetn_synchronized),
            .i_valid                   (lsu_i_valid),
            .o_stall                   (lsu_o_stall),
            .i_predicate               (i_predicate),
            .i_address                 (address),
            .i_flush                   (flush),
            .o_valid                   (lsu_o_valid),
            .o_empty                   (lsu_o_empty),
            .o_almost_empty            (lsu_o_almost_empty),
            .i_stall                   (stall_internal),
            .o_readdata                (o_readdata),
            .o_active                  (lsu_active),
            .avm_read                  (avm_read),
            .avm_waitrequest           (avm_waitrequest_internal),
            .avm_address               (avm_address_raw),
            .avm_burstcount            (avm_burstcount),
            .avm_byteenable            (avm_byteenable),
            .avm_readdata              (avm_readdata),
            .avm_readdatavalid         (avm_readdatavalid),
            .extra_unaligned_reqs      (),
            .req_cache_hit_count       (req_cache_hit_count)
         );
      end

    end
    else
    begin
    
        if (HYPER_PIPELINE == 0)
        begin

        lsu_bursting_write #(
            .KERNEL_SIDE_MEM_LATENCY(KERNEL_SIDE_MEM_LATENCY),
            .MEMORY_SIDE_MEM_LATENCY(MEMORY_SIDE_MEM_LATENCY),
            .AWIDTH(AWIDTH),
            .WIDTH_BYTES(WIDTH_BYTES),
            .MWIDTH_BYTES(MWIDTH_BYTES),
            .ALIGNMENT_ABITS(ALIGNMENT_ABITS),
            .BURSTCOUNT_WIDTH(BURSTCOUNT_WIDTH),
            .USE_WRITE_ACK(USE_WRITE_ACK),
            .USE_BYTE_EN(USE_BYTE_EN),
            .HIGH_FMAX(HIGH_FMAX)
        ) bursting_write (
            .clk(clock),
            .clk2x(clock2x),
            .reset(!resetn_synchronized),
            .o_stall(lsu_o_stall),
            .i_valid(lsu_i_valid),
            .i_nop(i_predicate),
            .i_address(address),
            .i_writedata(i_writedata),
            .i_stall(lsu_i_stall),
            .o_valid(lsu_o_valid),
            .o_active(lsu_active),
            .i_byteenable(i_byteenable),
            .avm_address(avm_address_raw),
            .avm_write(avm_write),
            .avm_writeack(lsu_writeack),
            .avm_writedata(avm_writedata),
            .avm_byteenable(avm_byteenable),
            .avm_burstcount(avm_burstcount),
            .avm_waitrequest(avm_waitrequest)
        );
        assign lsu_o_empty = '0;
        assign lsu_o_almost_empty = '0;
        end
        else                                   // LSU optimized for HIPI architecture
        begin

            // TEMPORARY CODE for simulating the effect on FMAX of stall latency and waitrequest latency, when those features become available
            // setting S10_NONFUNCTIONAL_FMAX_SPEEDUP = 1 will enable this code, which will render the lsu NON-FUNCTIONAL!
            logic [3:1] avm_waitrequest_pipe;
            logic       avm_waitrequest_internal;
            logic [3:1] stall_pipe;
            logic       stall_internal;
            always @(posedge clock) begin
               avm_waitrequest_pipe[1] <= avm_waitrequest;
               avm_waitrequest_pipe[3:2] <= avm_waitrequest_pipe[2:1];
               stall_pipe[1] <= lsu_i_stall;
               stall_pipe[3:2] <= stall_pipe[2:1];
            end
            assign avm_waitrequest_internal  = S10_NONFUNCTIONAL_FMAX_SPEEDUP ? avm_waitrequest_pipe[3] : avm_waitrequest;
            assign stall_internal            = S10_NONFUNCTIONAL_FMAX_SPEEDUP ? stall_pipe[3] : lsu_i_stall; 
           
           
            lsu_burst_coalesced_pipelined_write #(
               .AWIDTH(AWIDTH),
               .ALIGNMENT_ABITS(ALIGNMENT_ABITS),
               .WIDTH_BYTES(WIDTH_BYTES),
               .USE_BYTE_EN(USE_BYTE_EN),
               .MWIDTH_BYTES(MWIDTH_BYTES),
               .BURSTCOUNT_WIDTH(BURSTCOUNT_WIDTH),
               .MEMORY_SIDE_CAPACITY(MEMORY_SIDE_MEM_LATENCY<256 ? 256:MEMORY_SIDE_MEM_LATENCY),    // TODO This may need to be changed to give control to compiler
               .USE_WRITE_ACK(USE_WRITE_ACK),
               .TIMEOUT(8),
               .MIN_THREAD_CAPACITY(MEMORY_SIDE_MEM_LATENCY<256 ? 256:MEMORY_SIDE_MEM_LATENCY),     // TODO provide explicit control of this to compiler
               .MIN_MEMORY_BUFFER_DEPTH(MEMORY_SIDE_MEM_LATENCY<256 ? 256:MEMORY_SIDE_MEM_LATENCY), // TODO provide explicit control of this to compiler
               .ASYNC_RESET(ASYNC_RESET),
               .SYNCHRONIZE_RESET(0),
               .USE_STALL_LATENCY(USE_STALL_LATENCY),
               .UPSTREAM_STALL_LATENCY(UPSTREAM_STALL_LATENCY),
               .ALMOST_EMPTY_THRESH(ALMOST_EMPTY_THRESH)
            ) bursting_write (
               .clock(clock),
               .i_resetn(resetn_synchronized),
               .o_stall(lsu_o_stall),
               .i_valid(lsu_i_valid),
               .i_predicate(i_predicate),
               .i_address(address),
               .i_writedata(i_writedata),
               .i_stall(stall_internal),
               .o_valid(lsu_o_valid),
               .o_empty(lsu_o_empty),
               .o_almost_empty(lsu_o_almost_empty),
               .o_active(lsu_active),
               .i_byteenable(i_byteenable),
               .avm_address(avm_address_raw),
               .avm_write(avm_write),
               .avm_writeack(lsu_writeack),
               .avm_writedata(avm_writedata),
               .avm_byteenable(avm_byteenable),
               .avm_burstcount(avm_burstcount),
               .avm_waitrequest(avm_waitrequest_internal)
            );
        
        end

/*
        // this LSU was created to improve FMAX on A10 designs, but after check-in
        // it was found to cause hangs, so has been disabled
        // Note that this LSU does NOT support WRITEACK as currently implemented,
        // so if re-enabling it, only do so for non WRITEACK cases.
        acl_aligned_burst_coalesced_lsu #(
            .KERNEL_SIDE_MEM_LATENCY(KERNEL_SIDE_MEM_LATENCY),
            .MEMORY_SIDE_MEM_LATENCY(MEMORY_SIDE_MEM_LATENCY),
            .AWIDTH(AWIDTH),
            .WIDTH_BYTES(WIDTH_BYTES),
            .MWIDTH_BYTES(MWIDTH_BYTES),
            .ALIGNMENT_ABITS(ALIGNMENT_ABITS),
            .BURSTCOUNT_WIDTH(BURSTCOUNT_WIDTH),
            .USE_WRITE_ACK(USE_WRITE_ACK),
            .USE_BYTE_EN(USE_BYTE_EN),
            .HIGH_FMAX(HIGH_FMAX),
            .INTENDED_DEVICE_FAMILY(INTENDED_DEVICE_FAMILY)
        ) bursting_write (
            .clock(clock),
            .clock2x(clock2x),
            .resetn(resetn_synchronized),
            .o_stall(lsu_o_stall),
            .i_valid(lsu_i_valid),
            .i_predicate(i_predicate),
            .i_address(address),
            .i_writedata(i_writedata),
            .i_stall(lsu_i_stall),
            .o_valid(lsu_o_valid),
            .o_active(lsu_active),
            .i_byteenable(i_byteenable),
            .avm_address(avm_address_raw),
            .avm_write(avm_write),
            .avm_writeack(lsu_writeack),
            .avm_writedata(avm_writedata),
            .avm_byteenable(avm_byteenable),
            .avm_burstcount(avm_burstcount),
            .avm_waitrequest(avm_waitrequest)
        );
        assign o_empty = '0;
        assign o_almost_empty = '0;
*/        
    end
    assign avm_enable = 1'b1;
end



/////////////////////////////////
// Burst Coalesced Non Aligned //
/////////////////////////////////
else if(STYLE=="BURST-NON-ALIGNED")
begin
    if(READ == 1)
    begin
        lsu_bursting_read #(
            .KERNEL_SIDE_MEM_LATENCY(KERNEL_SIDE_MEM_LATENCY),
            .MEMORY_SIDE_MEM_LATENCY(MEMORY_SIDE_MEM_LATENCY),
            .AWIDTH(AWIDTH),
            .WIDTH_BYTES(WIDTH_BYTES),
            .MWIDTH_BYTES(MWIDTH_BYTES),
            .ALIGNMENT_ABITS(ALIGNMENT_ABITS),
            .BURSTCOUNT_WIDTH(BURSTCOUNT_WIDTH),
            .USECACHING(USECACHING),
            .CACHE_SIZE_N(CACHESIZE),
            .HIGH_FMAX(HIGH_FMAX),
            .ACL_PROFILE(ACL_PROFILE),
            .UNALIGNED(1)
        ) bursting_non_aligned_read (
            .clk(clock),
            .clk2x(clock2x),
            .reset(!resetn_synchronized),
            .flush(flush),
            .o_stall(lsu_o_stall),
            .i_valid(lsu_i_valid),
            .i_address(address),
            .i_nop(i_predicate),
            .i_stall(lsu_i_stall),
            .o_valid(lsu_o_valid),
            .o_readdata(o_readdata),
            .o_active(lsu_active),
            .avm_address(avm_address_raw),
            .avm_read(avm_read),
            .avm_readdata(avm_readdata),
            .avm_waitrequest(avm_waitrequest),
            .avm_byteenable(avm_byteenable),
            .avm_burstcount(avm_burstcount),
            .avm_readdatavalid(avm_readdatavalid),
            .extra_unaligned_reqs(extra_unaligned_reqs),
            .req_cache_hit_count(req_cache_hit_count)
        );
        assign lsu_o_empty = '0;
        assign lsu_o_almost_empty = '0;
    end
    else
    begin
        lsu_non_aligned_write #(
            .KERNEL_SIDE_MEM_LATENCY(KERNEL_SIDE_MEM_LATENCY),
            .MEMORY_SIDE_MEM_LATENCY(MEMORY_SIDE_MEM_LATENCY),
            .AWIDTH(AWIDTH),
            .WIDTH_BYTES(WIDTH_BYTES),
            .MWIDTH_BYTES(MWIDTH_BYTES),
            .ALIGNMENT_ABITS(ALIGNMENT_ABITS),
            .BURSTCOUNT_WIDTH(BURSTCOUNT_WIDTH),
            .USE_WRITE_ACK(USE_WRITE_ACK),
            .USE_BYTE_EN(USE_BYTE_EN),
            .HIGH_FMAX(HIGH_FMAX),
            .ACL_PROFILE(ACL_PROFILE)
        ) bursting_non_aligned_write (
            .clk(clock),
            .clk2x(clock2x),
            .reset(!resetn_synchronized),
            .o_stall(lsu_o_stall),
            .i_valid(lsu_i_valid),
            .i_address(address),
            .i_nop(i_predicate),
            .i_writedata(i_writedata),
            .i_stall(lsu_i_stall),
            .o_valid(lsu_o_valid),
            .o_active(lsu_active),
            .i_byteenable(i_byteenable),
            .avm_address(avm_address_raw),
            .avm_write(avm_write),
            .avm_writeack(lsu_writeack),
            .avm_writedata(avm_writedata),
            .avm_byteenable(avm_byteenable),
            .avm_burstcount(avm_burstcount),
            .avm_waitrequest(avm_waitrequest),
            .extra_unaligned_reqs(extra_unaligned_reqs)
        );
        assign lsu_o_empty = '0;
        assign lsu_o_almost_empty = '0;
    end
   assign avm_enable = 1'b1;
end
///////////////
// Streaming //
///////////////
else if(STYLE=="STREAMING")
begin
   if(READ==1)
   begin
      lsu_streaming_read #(
         .KERNEL_SIDE_MEM_LATENCY(KERNEL_SIDE_MEM_LATENCY),
         .MEMORY_SIDE_MEM_LATENCY(MEMORY_SIDE_MEM_LATENCY),
         .AWIDTH(AWIDTH),
         .WIDTH_BYTES(WIDTH_BYTES),
         .MWIDTH_BYTES(MWIDTH_BYTES),
         .ALIGNMENT_ABITS(ALIGNMENT_ABITS),
         .BURSTCOUNT_WIDTH(BURSTCOUNT_WIDTH)
      ) streaming_read (
         .clk(clock),
         .reset(!resetn_synchronized),
         .o_stall(lsu_o_stall),
         .i_valid(lsu_i_valid),
         .i_stall(lsu_i_stall),
         .o_valid(lsu_o_valid),
         .o_readdata(o_readdata),
         .o_active(lsu_active),
         .i_nop(i_predicate),
         .base_address(stream_base_addr),
         .size(stream_size),
         .avm_address(avm_address_raw),
         .avm_burstcount(avm_burstcount),
         .avm_read(avm_read),
         .avm_readdata(avm_readdata),
         .avm_waitrequest(avm_waitrequest),
         .avm_byteenable(avm_byteenable),
         .avm_readdatavalid(avm_readdatavalid)
      );
      assign lsu_o_empty = '0;
      assign lsu_o_almost_empty = '0;
   end
   else
   begin
     lsu_streaming_write #(
         .KERNEL_SIDE_MEM_LATENCY(KERNEL_SIDE_MEM_LATENCY),
         .MEMORY_SIDE_MEM_LATENCY(MEMORY_SIDE_MEM_LATENCY),
         .AWIDTH(AWIDTH),
         .WIDTH_BYTES(WIDTH_BYTES),
         .MWIDTH_BYTES(MWIDTH_BYTES),
         .ALIGNMENT_ABITS(ALIGNMENT_ABITS),
         .BURSTCOUNT_WIDTH(BURSTCOUNT_WIDTH),
         .USE_BYTE_EN(USE_BYTE_EN)
     ) streaming_write (
         .clk(clock),
         .reset(!resetn_synchronized),
         .o_stall(lsu_o_stall),
         .i_valid(lsu_i_valid),
         .i_stall(lsu_i_stall),
         .o_valid(lsu_o_valid),
         .o_active(lsu_active),
         .i_byteenable(i_byteenable),
         .i_writedata(i_writedata),
         .i_nop(i_predicate),
         .base_address(stream_base_addr),
         .size(stream_size),
         .avm_address(avm_address_raw),
         .avm_burstcount(avm_burstcount),
         .avm_write(avm_write),
         .avm_writeack(lsu_writeack),
         .avm_writedata(avm_writedata),
         .avm_byteenable(avm_byteenable),
         .avm_waitrequest(avm_waitrequest)
     );
     assign lsu_o_empty = '0;
     assign lsu_o_almost_empty = '0;
   end
   assign avm_enable = 1'b1;
end
////////////////////
// SEMI-Streaming //
////////////////////
else if(STYLE=="SEMI-STREAMING")
begin
   if(READ==1)
   begin
      lsu_read_cache #(
         .KERNEL_SIDE_MEM_LATENCY(KERNEL_SIDE_MEM_LATENCY),
         .AWIDTH(AWIDTH),
         .WIDTH_BYTES(WIDTH_BYTES),
         .MWIDTH_BYTES(MWIDTH_BYTES),
         .ALIGNMENT_ABITS(ALIGNMENT_ABITS),
         .BURSTCOUNT_WIDTH(BURSTCOUNT_WIDTH),
         .ACL_PROFILE(ACL_PROFILE),
         .REQUESTED_SIZE(CACHESIZE)
      ) read_cache (
         .clk(clock),
         .reset(!resetn_synchronized),
         .flush(flush),
         .o_stall(lsu_o_stall),
         .i_valid(lsu_i_valid),
         .i_address(address),
         .i_stall(lsu_i_stall),
         .o_valid(lsu_o_valid),
         .o_readdata(o_readdata),
         .o_active(lsu_active),
         .i_nop(i_predicate),
         .avm_address(avm_address_raw),
         .avm_burstcount(avm_burstcount),
         .avm_read(avm_read),
         .avm_readdata(avm_readdata),
         .avm_waitrequest(avm_waitrequest),
         .avm_byteenable(avm_byteenable),
         .avm_readdatavalid(avm_readdatavalid),
         .req_cache_hit_count(req_cache_hit_count)
      );
      assign lsu_o_empty = '0;
      assign lsu_o_almost_empty = '0;
   end
   assign avm_enable = 1'b1;
end
/////////////////
// Prefetching //
/////////////////
else if(STYLE=="PREFETCHING")
begin
   if(READ==1)
   begin
      lsu_streaming_prefetch_read #(
         .KERNEL_SIDE_MEM_LATENCY(KERNEL_SIDE_MEM_LATENCY),
         .MEMORY_SIDE_MEM_LATENCY(MEMORY_SIDE_MEM_LATENCY),
         .AWIDTH(AWIDTH),
         .WIDTH_BYTES(WIDTH_BYTES),
         .MWIDTH_BYTES(MWIDTH_BYTES),
         .ALIGNMENT_ABITS(ALIGNMENT_ABITS),
         .BURSTCOUNT_WIDTH(BURSTCOUNT_WIDTH)
      ) streaming_prefetch_read (
         .clk(clock),
         .reset(!resetn_synchronized),
         .flush(flush),
         .o_stall(lsu_o_stall),
         .i_valid(lsu_i_valid),
         .i_stall(lsu_i_stall),
         .o_valid(lsu_o_valid),
         .o_readdata(o_readdata),
         .o_active(lsu_active),
         .i_nop(i_predicate),
         .i_address(address),
         .avm_address(avm_address_raw),
         .avm_burstcount(avm_burstcount),
         .avm_read(avm_read),
         .avm_readdata(avm_readdata),
         .avm_waitrequest(avm_waitrequest),
         .avm_byteenable(avm_byteenable),
         .avm_readdatavalid(avm_readdatavalid)
      );
      assign lsu_o_empty = '0;
      assign lsu_o_almost_empty = '0;
   end
   else
   begin
      // Use Burst Coalesced Non Aligned for Writes in Prefetching style
       lsu_non_aligned_write #(
           .KERNEL_SIDE_MEM_LATENCY(KERNEL_SIDE_MEM_LATENCY),
           .MEMORY_SIDE_MEM_LATENCY(MEMORY_SIDE_MEM_LATENCY),
           .AWIDTH(AWIDTH),
           .WIDTH_BYTES(WIDTH_BYTES),
           .MWIDTH_BYTES(MWIDTH_BYTES),
           .ALIGNMENT_ABITS(ALIGNMENT_ABITS),
           .BURSTCOUNT_WIDTH(BURSTCOUNT_WIDTH),
           .USE_WRITE_ACK(USE_WRITE_ACK),
           .USE_BYTE_EN(USE_BYTE_EN),
           .HIGH_FMAX(HIGH_FMAX),
           .ACL_PROFILE(ACL_PROFILE)
       ) bursting_non_aligned_write (
           .clk(clock),
           .clk2x(clock2x),
           .reset(!resetn_synchronized),
           .o_stall(lsu_o_stall),
           .i_valid(lsu_i_valid),
           .i_address(address),
           .i_nop(i_predicate),
           .i_writedata(i_writedata),
           .i_stall(lsu_i_stall),
           .o_valid(lsu_o_valid),
           .o_active(lsu_active),
           .i_byteenable(i_byteenable),
           .avm_address(avm_address_raw),
           .avm_write(avm_write),
           .avm_writeack(lsu_writeack),
           .avm_writedata(avm_writedata),
           .avm_byteenable(avm_byteenable),
           .avm_burstcount(avm_burstcount),
           .avm_waitrequest(avm_waitrequest),
           .extra_unaligned_reqs(extra_unaligned_reqs)
       );
   end
   assign avm_enable = 1'b1;
   assign lsu_o_empty = '0;
   assign lsu_o_almost_empty = '0;
end


always@(posedge clock or negedge aclrn) begin
   if (~aclrn) begin
      o_active <= 1'b0;
   end else begin
      o_active <= lsu_active;
      if (~sclrn[0]) begin
         o_active <= '0;
      end
   end
end

// Profile the valids and stalls of the LSU

if(ACL_PROFILE==1)
begin

   // keep track of write bursts
   reg [BURSTCOUNT_WIDTH-1:0] profile_remaining_writeburst_count;
   wire active_write_burst;
   assign active_write_burst = (profile_remaining_writeburst_count != {BURSTCOUNT_WIDTH{1'b0}});
   always@(posedge clock or negedge aclrn) begin
      if (~aclrn) begin
         profile_remaining_writeburst_count <= {BURSTCOUNT_WIDTH{1'b0}};
      end else begin
         if(avm_write & ~avm_waitrequest & ~active_write_burst) 
            // start of a new write burst
            profile_remaining_writeburst_count <= avm_burstcount - 1;
         else if(~avm_waitrequest & active_write_burst)
            // count down one burst
            profile_remaining_writeburst_count <= profile_remaining_writeburst_count - 1;
         if (~sclrn[0]) begin
            profile_remaining_writeburst_count <= '0;
         end
      end
   end

   assign profile_bw = ((READ==1) ? avm_readdatavalid : (avm_write & ~avm_waitrequest)) & avm_enable;
   assign profile_bw_incr = MWIDTH_BYTES;
   assign profile_total_ivalid = (i_valid & ~o_stall);
   assign profile_total_req = (i_valid & ~i_predicate & ~o_stall);
   assign profile_i_stall_count = (i_stall & o_valid);
   assign profile_o_stall_count = (o_stall & i_valid);
   assign profile_avm_readwrite_count = ((avm_read | avm_write) & ~avm_waitrequest & ~active_write_burst & avm_enable);
   assign profile_avm_burstcount_total = ((avm_read | avm_write) & ~avm_waitrequest & ~active_write_burst & avm_enable);
   assign profile_avm_burstcount_total_incr = avm_burstcount;
   assign profile_req_cache_hit_count = req_cache_hit_count;
   assign profile_extra_unaligned_reqs = extra_unaligned_reqs;
   assign profile_avm_stall = ((avm_read | avm_write) & avm_waitrequest & avm_enable);

end
else begin
   assign profile_bw = 1'b0;
   assign profile_bw_incr = {ACL_PROFILE_INCREMENT_WIDTH{1'b0}};
   assign profile_total_ivalid = 1'b0;
   assign profile_total_req = 1'b0;
   assign profile_i_stall_count = 1'b0;
   assign profile_o_stall_count = 1'b0;
   assign profile_avm_readwrite_count = 1'b0;
   assign profile_avm_burstcount_total = 1'b0;
   assign profile_avm_burstcount_total_incr = {ACL_PROFILE_INCREMENT_WIDTH{1'b0}};
   assign profile_req_cache_hit_count = 1'b0;
   assign profile_extra_unaligned_reqs = 1'b0;
   assign profile_avm_stall = 1'b0;
end

// synthesis translate_off
// Profiling data - for simulation only
reg  [31:0] bw_kernel;
reg  [31:0] bw_avalon;

// Measure Bandwidth on Avalon signals
always@(posedge clock or negedge aclrn)
begin
   if (~aclrn) begin
      bw_avalon <= '0;
   end else begin
      if (READ==1 && avm_readdatavalid)
         bw_avalon <= bw_avalon + MWIDTH_BYTES;
      else if (READ==0 && avm_write && ~avm_waitrequest)
         bw_avalon <= bw_avalon + MWIDTH_BYTES;
      if (~sclrn[0]) begin
         bw_avalon <= '0;
      end
   end
end

// Measure Bandwidth on kernel signals
always@(posedge clock or negedge aclrn)
begin
   if (~aclrn) begin
      bw_kernel <= '0;
   end else begin
      if (i_valid && !o_stall && ~nop)
         bw_kernel <= bw_kernel + WIDTH_BYTES;
      if (~sclrn[0]) begin
         bw_kernel <= '0;
      end
   end
end
// synthesis translate_on


if(PROFILE_ADDR_TOGGLE==1 && STYLE!="SIMPLE")
begin
  localparam COUNTERWIDTH=12;
  // We currently assume AWIDTH is always 32, but we really need to set this to
  // a tight lower bound to avoid wasting area here.
  logic [COUNTERWIDTH-1:0] togglerate[AWIDTH-ALIGNMENT_ABITS+1];

  acl_toggle_detect 
    #(.WIDTH(AWIDTH-ALIGNMENT_ABITS), .COUNTERWIDTH(COUNTERWIDTH)) atd (
      .clk(clock),
      .resetn(resetn_synchronized),
      .valid(i_valid && ~o_stall && ~nop),
      .value({i_address >> ALIGNMENT_ABITS,{ALIGNMENT_ABITS{1'b0}}}),
      .count(togglerate));

  acl_debug_mem #(.WIDTH(COUNTERWIDTH), .SIZE(AWIDTH-ALIGNMENT_ABITS+1)) dbg_mem (
      .clk(clock),
      .resetn(resetn_synchronized),
      .write(i_valid && ~o_stall && ~nop),
      .data(togglerate));

end


end
endgenerate

endmodule

`default_nettype wire

// vim:set filetype=verilog:
