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

// Wide load/store unit
// Instantiates a top-level LSU

module lsu_wide_wrapper
(
    clock, clock2x, resetn, stream_base_addr, stream_size, stream_reset, i_atomic_op, o_stall, 
    i_valid, i_address, i_writedata, i_cmpdata, i_predicate, i_bitwiseor, i_stall, o_valid, o_readdata, avm_address, 
    avm_enable, avm_read, avm_readdata, avm_write, avm_writeack, avm_writedata, avm_byteenable, 
    avm_waitrequest, avm_readdatavalid, avm_burstcount,
    o_active,
    o_input_fifo_depth,
    o_writeack,
    i_byteenable,
    flush,
    // profile signals
    profile_req_cache_hit_count,
    profile_extra_unaligned_reqs
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
parameter KERNEL_SIDE_MEM_LATENCY=1;  // Latency in cycles
parameter MEMORY_SIDE_MEM_LATENCY=1;  // Latency in cycles
parameter USE_WRITE_ACK=0;   // Enable the write-acknowledge signal
parameter USECACHING=0;
parameter USE_BYTE_EN=0;
parameter CACHESIZE=1024;
parameter PROFILE_ADDR_TOGGLE=0;
parameter USEINPUTFIFO=1;        // FIXME specific to lsu_pipelined
parameter USEOUTPUTFIFO=1;       // FIXME specific to lsu_pipelined
parameter FORCE_NOP_SUPPORT=0;   // Stall free pipeline doesn't want the NOP fifo
parameter HIGH_FMAX=1;       // Enable optimizations for high Fmax

parameter ADDRSPACE=0;
 


// Profiling
parameter ACL_PROFILE=0;      // Set to 1 to enable stall/valid profiling
parameter ACL_PROFILE_ID=1;   // Each LSU needs a unique ID
parameter ACL_PROFILE_INCREMENT_WIDTH=64;

// Local memory parameters
parameter ENABLE_BANKED_MEMORY=0;// Flag enables address permutation for banked local memory config
parameter ABITS_PER_LMEM_BANK=0; // Used when permuting lmem address bits to stride across banks
parameter NUMBER_BANKS=1;        // Number of memory banks - used in address permutation (1-disable)
parameter LMEM_ADDR_PERMUTATION_STYLE=0; // Type of address permutation (currently unused)
// The following localparams have if conditions, and the second is named
// "HACKED..." because address bit permutations are controlled by the
// ENABLE_BANKED_MEMORY parameter.  The issue is that this forms the select
// input of a MUX (if statement), and synthesis evaluates both inputs.
// When not using banked memory, the bit select ranges don't make sense on
// the input that isn't used, so we need to hack them in the non-banked case
// to get through ModelSim and Quartus.
localparam BANK_SELECT_BITS = (ENABLE_BANKED_MEMORY==1) ? $clog2(NUMBER_BANKS) : 1; // Bank select bits in address permutation
localparam HACKED_ABITS_PER_LMEM_BANK = (ENABLE_BANKED_MEMORY==1) ? ABITS_PER_LMEM_BANK : $clog2(MWIDTH_BYTES)+1;

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
parameter ALIGNMENT_ABITS=$clog2(ALIGNMENT_BYTES); // Address bits to ignore
localparam LSU_CAPACITY=256;   // Maximum number of 'in-flight' load/store operations

localparam WIDE_LSU = (WIDTH > MWIDTH); 
localparam LSU_WIDTH =  (WIDTH > MWIDTH) ? MWIDTH:  WIDTH;   // Width of the actual LSU when wider than MWIDTH or nonaligned
localparam LSU_WIDTH_BYTES = LSU_WIDTH/8; 

localparam WIDTH_RATIO =  (WIDTH_BYTES/LSU_WIDTH_BYTES); 
localparam WIDE_INDEX_WIDTH = $clog2(WIDTH_RATIO);

// Performance monitor signals
parameter INPUTFIFO_USEDW_MAXBITS=8;

// LSU unit properties
localparam ATOMIC_PIPELINED_LSU=(STYLE=="ATOMIC-PIPELINED");
localparam PIPELINED_LSU=( (STYLE=="PIPELINED") || (STYLE=="BASIC-COALESCED") || (STYLE=="BURST-COALESCED") || (STYLE=="BURST-NON-ALIGNED") );
localparam SUPPORTS_NOP=( (STYLE=="STREAMING") || (STYLE=="SEMI-STREAMING") || (STYLE=="BURST-NON-ALIGNED") ||  (STYLE=="PREFETCHING") || FORCE_NOP_SUPPORT==1);
localparam SUPPORTS_BURSTS=( (STYLE=="STREAMING") || (STYLE=="BURST-COALESCED") || (STYLE=="SEMI-STREAMING") || (STYLE=="BURST-NON-ALIGNED") || (STYLE=="PREFETCHING"));


/********
* Ports *
********/
// Standard global signals
input clock;
input clock2x;
input resetn;
input flush;

// Streaming interface signals
input [AWIDTH-1:0] stream_base_addr;
input [31:0] stream_size;
input stream_reset;

// Atomic interface
input [WIDTH-1:0] i_cmpdata; // only used by atomic_cmpxchg
input [ATOMIC_WIDTH-1:0] i_atomic_op;

// Upstream interface
output o_stall;
input i_valid;
input [AWIDTH-1:0] i_address;
input [WIDTH-1:0] i_writedata;
input i_predicate;
input [AWIDTH-1:0] i_bitwiseor;
input [WIDTH_BYTES-1:0] i_byteenable;

// Downstream interface
input i_stall;
output o_valid;
output [WIDTH-1:0] o_readdata;

// Avalon interface
output [AWIDTH-1:0] avm_address;
output avm_enable;
output avm_read;
input [WRITEDATAWIDTH-1:0] avm_readdata;
output avm_write;
input avm_writeack;
output o_writeack;
output [WRITEDATAWIDTH-1:0] avm_writedata;
output [WRITEDATAWIDTH_BYTES-1:0] avm_byteenable;
input avm_waitrequest;
input avm_readdatavalid;
output [BURSTCOUNT_WIDTH-1:0] avm_burstcount;

output reg o_active;

// For profiling/performance monitor
output [INPUTFIFO_USEDW_MAXBITS-1:0] o_input_fifo_depth;

// Profiler Signals
output logic profile_req_cache_hit_count;
output logic profile_extra_unaligned_reqs;



// If we are a non-streaming read, do width adaption at avalon interface so we dont stall during data re-use
localparam ADAPT_AT_AVM = 1;   
generate
if(ADAPT_AT_AVM) 
begin


   wire [ AWIDTH-1:0] avm_address_wrapped;
   wire avm_enable_wrapped;
   wire avm_read_wrapped;
   wire [WIDTH-1:0] avm_readdata_wrapped;
   wire avm_write_wrapped;
   wire avm_writeack_wrapped;
   wire [BURSTCOUNT_WIDTH-WIDE_INDEX_WIDTH-1:0] avm_burstcount_wrapped;
   wire [WIDTH-1:0] avm_writedata_wrapped;
   wire [WIDTH_BYTES-1:0]avm_byteenable_wrapped;
   wire avm_waitrequest_wrapped;
   reg avm_readdatavalid_wrapped;

   lsu_top lsu_wide (
     .clock(clock),
     .clock2x(clock2x),
     .resetn(resetn),
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
     .avm_address(avm_address_wrapped),
     .avm_enable(avm_enable_wrapped),
     .avm_read(avm_read_wrapped),
     .avm_readdata(avm_readdata_wrapped),
     .avm_write(avm_write_wrapped),
     .avm_writeack(avm_writeack_wrapped),
     .avm_burstcount(avm_burstcount_wrapped),
     .avm_writedata(avm_writedata_wrapped),
     .avm_byteenable(avm_byteenable_wrapped),
     .avm_waitrequest(avm_waitrequest_wrapped),
     .avm_readdatavalid(avm_readdatavalid_wrapped),
     .profile_req_cache_hit_count(profile_req_cache_hit_count),
     .profile_extra_unaligned_reqs(profile_extra_unaligned_reqs)

   );

   defparam lsu_wide.STYLE = STYLE;
   defparam lsu_wide.AWIDTH = AWIDTH;
   defparam lsu_wide.ATOMIC_WIDTH = ATOMIC_WIDTH;
   defparam lsu_wide.WIDTH_BYTES = WIDTH_BYTES;
   defparam lsu_wide.MWIDTH_BYTES = WIDTH_BYTES;
   defparam lsu_wide.WRITEDATAWIDTH_BYTES = WIDTH_BYTES;
   defparam lsu_wide.ALIGNMENT_BYTES = ALIGNMENT_BYTES;
   defparam lsu_wide.READ = READ;
   defparam lsu_wide.ATOMIC = ATOMIC;
   defparam lsu_wide.BURSTCOUNT_WIDTH = BURSTCOUNT_WIDTH-WIDE_INDEX_WIDTH;
   defparam lsu_wide.USE_WRITE_ACK = USE_WRITE_ACK;
   defparam lsu_wide.USECACHING = USECACHING;
   defparam lsu_wide.USE_BYTE_EN = USE_BYTE_EN;
   defparam lsu_wide.CACHESIZE = CACHESIZE;
   defparam lsu_wide.PROFILE_ADDR_TOGGLE = PROFILE_ADDR_TOGGLE;
   defparam lsu_wide.USEINPUTFIFO = USEINPUTFIFO;
   defparam lsu_wide.USEOUTPUTFIFO = USEOUTPUTFIFO;
   defparam lsu_wide.FORCE_NOP_SUPPORT = FORCE_NOP_SUPPORT; ///we handle NOPs in the wrapper
   defparam lsu_wide.HIGH_FMAX = HIGH_FMAX;
   defparam lsu_wide.ACL_PROFILE = ACL_PROFILE;
   defparam lsu_wide.ACL_PROFILE_INCREMENT_WIDTH = ACL_PROFILE_INCREMENT_WIDTH;
   defparam lsu_wide.ENABLE_BANKED_MEMORY = ENABLE_BANKED_MEMORY;
   defparam lsu_wide.ABITS_PER_LMEM_BANK = ABITS_PER_LMEM_BANK;
   defparam lsu_wide.NUMBER_BANKS = NUMBER_BANKS;
   defparam lsu_wide.WIDTH = WIDTH;
   defparam lsu_wide.MWIDTH = WIDTH;  
   defparam lsu_wide.MEMORY_SIDE_MEM_LATENCY = MEMORY_SIDE_MEM_LATENCY; 
   defparam lsu_wide.KERNEL_SIDE_MEM_LATENCY = KERNEL_SIDE_MEM_LATENCY; 
   defparam lsu_wide.WRITEDATAWIDTH = WIDTH;
   defparam lsu_wide.INPUTFIFO_USEDW_MAXBITS = INPUTFIFO_USEDW_MAXBITS;
   defparam lsu_wide.LMEM_ADDR_PERMUTATION_STYLE = LMEM_ADDR_PERMUTATION_STYLE;
   defparam lsu_wide.ADDRSPACE = ADDRSPACE;

   //upstream control signals
   wire done;
   wire ready; 

   reg in_progress;
   reg [WIDE_INDEX_WIDTH-1:0] index;

   //downstream control signals
   wire new_data;
   wire done_output;
   reg output_ready;
   reg [WIDE_INDEX_WIDTH-1:0] output_index;  
   reg [WIDTH-1:0] readdata_shiftreg; 

   reg [ AWIDTH-1:0] avm_address_reg;
   reg avm_read_reg;
   reg [WIDTH-1:0] avm_readdata_reg;
   reg avm_write_reg;
   reg [BURSTCOUNT_WIDTH-WIDE_INDEX_WIDTH-1:0] avm_burstcount_reg;
   reg [WIDTH-1:0] avm_writedata_reg;
   reg [WIDTH_BYTES-1:0]avm_byteenable_reg;
   
   
   
  if(READ) 
  begin
     assign avm_writedata =   0;
     assign avm_byteenable = 0;
     assign avm_address = avm_address_wrapped; 
     assign avm_burstcount = avm_burstcount_wrapped*WIDTH_RATIO;
     assign avm_write  = 0;
     assign avm_read = avm_read_wrapped;
     assign avm_enable = avm_enable_wrapped;
     
     assign avm_waitrequest_wrapped = avm_waitrequest; 
     //downstream interface
     assign new_data = avm_readdatavalid; //we are accepting another MWIDTH item from the interconnect
     assign done_output = new_data && (output_index >= (WIDTH_RATIO-1)); //the output data will be ready next cycle

     always@(posedge clock or negedge resetn)
     begin
       if(!resetn)
         output_index <= 1'b0;
       else
       //increase index when we take new data
         output_index <= new_data ? (output_index+1)%(WIDTH_RATIO): output_index;
     end

     always@(posedge clock or negedge resetn)
     begin
       if(!resetn)
       begin
         readdata_shiftreg <= 0;
         output_ready <= 0;
       end
       else
       begin
         //shift data in if we are taking new data
         readdata_shiftreg <= new_data ? {avm_readdata,readdata_shiftreg[WIDTH-1:MWIDTH]} : readdata_shiftreg;     
         output_ready <= done_output  ;
       end
     end

     assign avm_readdata_wrapped = readdata_shiftreg;
     assign avm_readdatavalid_wrapped = output_ready;
     
   end else begin 
     //write
     
     //break write into multiple cycles
     assign done  = in_progress && (index >= (WIDTH_RATIO-1)) && !avm_waitrequest; //we are finishing a transaction
     assign ready = (!in_progress || done); // logic can take a new transaction
     
     //if we accept a new item from the lsu
     wire start = (avm_write_wrapped) && (!in_progress || done);      //we are starting a new transaction, do not start if predicated

     always@(posedge clock or negedge resetn)
     begin
       if(!resetn)
       begin
         in_progress <= 0;
         index <= 0;
       end 
       else 
       begin
        // bursting = bursting ? !done  : start && (avm_burstcount_wrapped > 0);
         in_progress <= start || (in_progress && !done);
         //if starting or done set to 0, else increment if LSU is accepting data
         index <= (start || !in_progress) ? 1'b0 : ( avm_waitrequest ? index :index+1);
       end
     end
     reg [ WIDE_INDEX_WIDTH-1:0] write_ack_count;
     
     //count write_acks
     always@(posedge clock or negedge resetn)
     begin
       if(!resetn)
       begin
         write_ack_count   <= 0;        
       end
       else if (avm_writeack)
       begin
         write_ack_count   <= write_ack_count+1;
       end
       else
       begin
         write_ack_count   <= write_ack_count;
       end  
     end
     
       
     assign avm_writeack_wrapped = (write_ack_count  == {WIDE_INDEX_WIDTH{1'b1}} - 1 ) && avm_writeack; 
     
     //store transaction inputs to registers 
     always@(posedge clock or negedge resetn)
     begin
       if(!resetn)
       begin
         avm_address_reg   <= 0;
         avm_writedata_reg <= 0;
         avm_byteenable_reg <= 0;
         avm_burstcount_reg <= 0;

       end
       else if (start)
       begin
         avm_address_reg   <= avm_address_wrapped;
         avm_writedata_reg <= avm_writedata_wrapped;
         avm_byteenable_reg <= avm_byteenable_wrapped;
         avm_burstcount_reg <= avm_burstcount_wrapped;
       end
       else
       begin
         avm_address_reg   <= avm_address_reg;
         avm_writedata_reg <= avm_writedata_reg;
         avm_byteenable_reg <= avm_byteenable_reg;
         avm_burstcount_reg <= avm_burstcount_reg;
       end  
     end

     //let an item through when we finish it
     assign avm_waitrequest_wrapped = !ready;  
     assign avm_writedata =   avm_writedata_reg[((index+1)*MWIDTH-1)-:MWIDTH];
     assign avm_byteenable = avm_byteenable_reg[((index+1)*MWIDTH_BYTES-1)-:MWIDTH_BYTES];
     assign avm_address = avm_address_reg; 
     assign avm_burstcount = avm_burstcount_reg*WIDTH_RATIO;
     assign avm_write = in_progress;
     assign avm_read = 0;
     assign avm_enable = avm_enable_wrapped;
 
   end

end else begin
end
endgenerate

endmodule



