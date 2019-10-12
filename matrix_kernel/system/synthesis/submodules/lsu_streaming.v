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
// Top level module for buffered streaming accesses.
//
// Properties - Coalesced: Yes, Ordered: Yes, Hazard-Safe: No, Pipelined: ?
//              (see lsu_top.v for details)
//
// Description: Streaming units may be used when all requests are guaranteed
//              to be in order with no NOP instructions in between (NOP 
//              requests at the end are permitted and garbage data is 
//              returned).  Requests are buffered or pre-fetched so the
//              back-end must verify that the requests are hazard-safe.

/*****************************************************************************/
// Streaming read unit:
//   Pre-fetch a stream of size data words beginning at base_address.  The
//   inputs are assumed to be valid once the first i_valid signal is asserted.  
//   Once all data is consumed, further requests are verified to be NOP
//   requests in which case garbage data is returned and the thread passes
//   through the unit.
/*****************************************************************************/
module lsu_streaming_read 
(
   clk, reset, o_stall, i_valid, i_stall, i_nop, o_valid, o_readdata, 
   o_active, //Debugging signal
   base_address, size, avm_address, avm_burstcount, avm_read, 
   avm_readdata, avm_waitrequest, avm_byteenable, avm_readdatavalid
);

/*************
* Parameters *
*************/
parameter AWIDTH=32;
parameter WIDTH_BYTES=32;
parameter MWIDTH_BYTES=32;
parameter ALIGNMENT_ABITS=6;
parameter BURSTCOUNT_WIDTH=6;
parameter KERNEL_SIDE_MEM_LATENCY=1;
parameter MEMORY_SIDE_MEM_LATENCY=1;

// Derived parameters
localparam WIDTH=8*WIDTH_BYTES;
localparam MWIDTH=8*MWIDTH_BYTES;
localparam MBYTE_SELECT_BITS=$clog2(MWIDTH_BYTES);
localparam BYTE_SELECT_BITS=$clog2(WIDTH_BYTES);
localparam MAXBURSTCOUNT=2**(BURSTCOUNT_WIDTH-1);
// Parameterize the FIFO depth based on the "drain" rate of the return FIFO
//   In the worst case you need memory latency + burstcount, but if the kernel
//   is slow to pull data out we can overlap the next burst with that.  Also
//   since you can't backpressure responses, you need at least a full burst
//   of space.
// Note the burst_read_master requires a fifo depth >= MAXBURSTCOUNT + 5.  This
// hardcoded 5 latency could result in half the bandwidth when burst and
// latency is small, hence double it so we can double buffer.
localparam _FIFO_DEPTH = MAXBURSTCOUNT + 10 + ((MEMORY_SIDE_MEM_LATENCY * WIDTH_BYTES + MWIDTH_BYTES - 1) / MWIDTH_BYTES);
// This fifo doesn't affect the pipeline, round to power of 2
localparam FIFO_DEPTH = 2**$clog2(_FIFO_DEPTH);

localparam FIFO_DEPTH_LOG2=$clog2(FIFO_DEPTH);

/********
* Ports *
********/
// Standard globals
input clk;
input reset;

// Upstream pipeline interface
output o_stall;
input i_valid;
input i_nop;
input [AWIDTH-1:0] base_address;
input [31:0] size;

// Downstream pipeline interface
input i_stall;
output o_valid;
output [WIDTH-1:0] o_readdata;
output o_active;

// Avalon interface
output [AWIDTH-1:0] avm_address;
output [BURSTCOUNT_WIDTH-1:0] avm_burstcount;
output avm_read;
input [MWIDTH-1:0] avm_readdata;
input avm_waitrequest;
output [MWIDTH_BYTES-1:0] avm_byteenable;
input avm_readdatavalid;

// FIFO Isolation to outside world
wire f_avm_read;
wire f_avm_waitrequest;
wire [AWIDTH-1:0] f_avm_address;
wire [BURSTCOUNT_WIDTH-1:0] f_avm_burstcount;

acl_data_fifo #(
  .DATA_WIDTH(AWIDTH+BURSTCOUNT_WIDTH),
  .DEPTH(2),
  .IMPL("ll_reg")
) avm_buffer (
  .clock(clk),
  .resetn(!reset),
  .data_in( {f_avm_address,f_avm_burstcount} ),
  .valid_in( f_avm_read ),
  .data_out( {avm_address,avm_burstcount} ),
  .valid_out( avm_read ),
  .stall_in( avm_waitrequest ),
  .stall_out( f_avm_waitrequest )
);
/***************
* Architecture *
***************/
// Address alignment signals
wire [AWIDTH-1:0] aligned_base_address;
wire [AWIDTH-1:0] base_offset;

// Read master signals
wire rm_done;
wire rm_valid;
wire rm_go;
wire [MWIDTH-1:0] rm_data;
wire [AWIDTH-1:0] rm_base_address;
wire [AWIDTH-1:0] rm_last_address;
wire [31:0] rm_size;
wire rm_ack;

// Number of threads remaining
reg [31:0] threads_rem;


// Need an input register to break up some of the compex computation
reg i_reg_valid;
reg i_reg_nop;
reg [AWIDTH-1:0] reg_base_address;
reg [31:0] reg_size;
reg [31:0] reg_rm_size_partial;
wire [AWIDTH-1:0] aligned_base_address_partial;
wire [AWIDTH-1:0] base_offset_partial;
assign aligned_base_address_partial = ((base_address >> ALIGNMENT_ABITS) << ALIGNMENT_ABITS);
assign base_offset_partial = aligned_base_address_partial[MBYTE_SELECT_BITS-1:0];

always@(posedge clk or posedge reset)
begin
   if (reset == 1'b1)
   begin
      i_reg_valid <= 1'b0;
      reg_base_address <= 'x;
      reg_size <= 'x;
      reg_rm_size_partial <= 'x; 
      i_reg_nop <= 'x;
   end
   else
   begin
      if (!o_stall) 
      begin
         i_reg_nop <= i_nop;
         i_reg_valid <= i_valid;
         reg_base_address <= base_address;
         reg_size <= size;
         reg_rm_size_partial = (size << BYTE_SELECT_BITS) + base_offset_partial;
      end
   end
end

// Track the number of threads we have yet to process
always@(posedge clk or posedge reset)
begin
   if(reset == 1'b1)
   begin
      threads_rem <= 0;
   end
   else
   begin
      threads_rem <= (rm_go ? reg_size : threads_rem) - (o_valid && !i_stall && !i_reg_nop);
   end
end

// Force address alignment bits to 0.  They should already be 0, but forcing
// them to 0 here lets Quartus see the alignment and optimize the design
assign aligned_base_address = ((reg_base_address >> ALIGNMENT_ABITS) << ALIGNMENT_ABITS);

// Compute the last address to burst from.  In this case, alignment is not
// for Quartus optimization but to properly compute the MWIDTH sized burst.
assign rm_base_address = ((aligned_base_address >> MBYTE_SELECT_BITS) << MBYTE_SELECT_BITS);

// Requests come in based on WIDTH sized words.  The memory bus is MWIDTH
// sized, so we need to fix up the read-length and base-address alignment
// before using the lsu_burst_read_master.
assign base_offset = aligned_base_address[MBYTE_SELECT_BITS-1:0];
assign rm_size = ((reg_rm_size_partial + MWIDTH_BYTES - 1) >> MBYTE_SELECT_BITS) << MBYTE_SELECT_BITS;

// Load in a new set of parameters if a new ND-Range is beginning (determined
// by checking if the current ND-Range completed or the read_master is 
// currently inactive).
assign rm_go = i_reg_valid && (threads_rem == 0) && !rm_valid && !i_reg_nop;
lsu_burst_read_master #(
   .DATAWIDTH( MWIDTH ),
   .MAXBURSTCOUNT( MAXBURSTCOUNT ),
   .BURSTCOUNTWIDTH( BURSTCOUNT_WIDTH ),
   .BYTEENABLEWIDTH( MWIDTH_BYTES ),
   .ADDRESSWIDTH( AWIDTH ),
   .FIFODEPTH( FIFO_DEPTH ),
   .FIFODEPTH_LOG2( FIFO_DEPTH_LOG2 ),
   .FIFOUSEMEMORY( 1 )
) read_master (
   .clk(clk),
   .reset(reset),
   .o_active(o_active),

   .control_fixed_location( 1'b0 ),
   .control_read_base( rm_base_address ),
   .control_read_length( rm_size ),
   .control_go( rm_go ),
   .control_done( rm_done ),
   .control_early_done(),

   .user_read_buffer( rm_ack ),
   .user_buffer_data( rm_data ),
   .user_data_available( rm_valid ),

   .master_address( f_avm_address ),
   .master_read( f_avm_read ),
   .master_byteenable( avm_byteenable ),
   .master_readdata( avm_readdata ),
   .master_readdatavalid( avm_readdatavalid ),
   .master_burstcount( f_avm_burstcount ),
   .master_waitrequest( f_avm_waitrequest )
);

generate
if(MBYTE_SELECT_BITS != BYTE_SELECT_BITS)
begin
   // Width adapting signals
   reg [MBYTE_SELECT_BITS-BYTE_SELECT_BITS-1:0] wa_word_counter;

   // Width adapting logic - a counter is used to track which word is active from
   // each MWIDTH sized line from main memory.  The counter is initialized from 
   // the lower address bits of the initial request.
   always@(posedge clk or posedge reset)
   begin
      if(reset == 1'b1)
         wa_word_counter <= 0;
      else
         wa_word_counter <= rm_go ? aligned_base_address[MBYTE_SELECT_BITS-1:BYTE_SELECT_BITS] : wa_word_counter + (o_valid && !i_reg_nop && !i_stall);
   end
   // Must eject last word if all threads are done
   assign rm_ack = (threads_rem==1 || &wa_word_counter) && (o_valid && !i_stall);
   assign o_readdata = rm_data[wa_word_counter * WIDTH +: WIDTH];
end
else
begin
   // Widths are matched, every request is a new memory word
   assign rm_ack = o_valid && !i_stall;
   assign o_readdata = rm_data;
end
endgenerate

// Stall requests if we don't have valid data
assign o_valid = (i_reg_valid && (rm_valid || i_reg_nop));
assign o_stall = ((!rm_valid && !i_reg_nop) || i_stall) && i_reg_valid;

endmodule

/*****************************************************************************/
// Streaming write unit:
//    The number of write requests is known ahead of time and it is assumed
// that the back-end has verified that there are no hazards.  Write requests
// are buffered until sufficient data is availble to generate a large burst
// write request.
//
// Since the burst-master doesn't support width adaptation, the first and last
// words are written by the wrapper unit.
//
// Based off code for the "write_burst_master" template available on the Altera
// website.
/*****************************************************************************/
module lsu_streaming_write
(
   clk, reset, o_stall, i_valid, i_stall, i_writedata, i_nop, i_byteenable, o_valid, 
   o_active, //Debugging signal
   base_address, size, avm_address, avm_burstcount, avm_write, avm_writeack, avm_writedata,
   avm_byteenable, avm_waitrequest
);

/*************
* Parameters *
*************/
parameter AWIDTH=32;
parameter WIDTH_BYTES=32;
parameter MWIDTH_BYTES=32;
parameter ALIGNMENT_ABITS=6;
parameter BURSTCOUNT_WIDTH=6;
parameter KERNEL_SIDE_MEM_LATENCY=1;
parameter MEMORY_SIDE_MEM_LATENCY=1;  // For stores this will only account for arbitration delay
parameter USE_BYTE_EN=0;


// Derived parameters
localparam WIDTH=8*WIDTH_BYTES;
localparam MWIDTH=8*MWIDTH_BYTES;
localparam MBYTE_SELECT_BITS=$clog2(MWIDTH_BYTES);
localparam BYTE_SELECT_BITS=$clog2(WIDTH_BYTES);
localparam MAXBURSTCOUNT=2**(BURSTCOUNT_WIDTH-1);
localparam __FIFO_DEPTH=2*MAXBURSTCOUNT + (MEMORY_SIDE_MEM_LATENCY * WIDTH + MWIDTH - 1) / MWIDTH;
localparam _FIFO_DEPTH= ( __FIFO_DEPTH > MAXBURSTCOUNT+4 ) ? __FIFO_DEPTH : MAXBURSTCOUNT+5;
// This fifo doesn't affect the pipeline, round to power of 2
localparam FIFO_DEPTH= 2**($clog2(_FIFO_DEPTH));
localparam FIFO_DEPTH_LOG2=$clog2(FIFO_DEPTH);
localparam NUM_FIFOS = MWIDTH / WIDTH;
localparam FIFO_ID_WIDTH = (NUM_FIFOS == 1) ? 1 : $clog2(NUM_FIFOS);  // Things just get messy if we let the FIFO ID be 0 bits wide

/********
* Ports *
********/
// Standard globals
input clk;
input reset;

// Upstream pipeline interface
output o_stall;
input i_valid;
input [WIDTH-1:0] i_writedata;
input i_nop;
input [AWIDTH-1:0] base_address;
input [31:0] size;
input [WIDTH_BYTES-1:0] i_byteenable;
// Downstream pipeline interface
output reg o_valid;
input i_stall;
output o_active;

// internal wires for registering o_valid
wire o_valid_int;
wire i_stall_int;

// Avalon interface
output [AWIDTH-1:0] avm_address;
output [BURSTCOUNT_WIDTH-1:0] avm_burstcount;
output avm_write;
input avm_writeack;
output [MWIDTH-1:0] avm_writedata;
output [MWIDTH_BYTES-1:0] avm_byteenable;
input avm_waitrequest;

// FIFO Isolation to outside world
wire f_avm_write;
wire [MWIDTH-1:0] f_avm_writedata;
wire [MWIDTH_BYTES-1:0] f_avm_byteenable;
wire f_avm_waitrequest;
wire [AWIDTH-1:0] f_avm_address;
wire [BURSTCOUNT_WIDTH-1:0] f_avm_burstcount;

acl_data_fifo #(
  .DATA_WIDTH(AWIDTH+BURSTCOUNT_WIDTH+MWIDTH+MWIDTH_BYTES),
  .DEPTH(2),
  .IMPL("ll_reg")
) avm_buffer (
  .clock(clk),
  .resetn(!reset),
  .data_in( {f_avm_address,f_avm_burstcount,f_avm_byteenable,f_avm_writedata} ),
  .valid_in( f_avm_write ),
  .data_out( {avm_address,avm_burstcount,avm_byteenable,avm_writedata} ),
  .valid_out( avm_write ),
  .stall_in( avm_waitrequest ),
  .stall_out( f_avm_waitrequest )
);

/***************
* Architecture *
***************/
wire [AWIDTH-1:0] aligned_base_address;
wire [AWIDTH-1:0] last_word_address;
wire [AWIDTH-1:0] base_offset;
wire go;

// Address calculations
wire [AWIDTH-1:0] a_base_address;
wire [31:0] a_size;

// Configuration registers
wire c_done;
reg [31:0] c_length;

// This is a re-encoded version of c_lenght that is always equal to c_length-1
// This lets us just test the MSB for c_length_reenc == -1 ( c_lenght = 0 )
// TODO: This means that we can't support the full 32 bit range
reg [31:0] c_length_reenc;
reg [31:0] ack_counter;

// Write master signals
reg wm_first_xfer;
reg [AWIDTH-1:0] wm_address;
   // burstcount counts the total number of words in the current burst
reg [BURSTCOUNT_WIDTH-1:0] wm_burstcount;
   // burst_counter counts the number of words remaining in the current burst
reg [BURSTCOUNT_WIDTH-1:0] wm_burst_counter;

// Special byte masks for the first word and last word transmitted
reg fw_in_enable;
reg fw_out_enable;
reg [MWIDTH_BYTES-1:0] fw_byteenable;
wire lw_out_enable;
reg [MWIDTH_BYTES-1:0] lw_byteenable;

// Burst calculations - first short burst
wire [AWIDTH-1:0] fsb_boundary_offset;
wire fsb_enable;
wire [BURSTCOUNT_WIDTH-1:0] fsb_count;
wire fsb_ready;

// Burst calculations - last short burst
wire lsb_enable;
wire [BURSTCOUNT_WIDTH-1:0] lsb_count;
wire lsb_ready;

// Burst calculations - standard 'middle' burst
wire b_ready;

// Signals tracking the burst request
wire burst_begin;
wire [BURSTCOUNT_WIDTH-1:0] burst_count;
wire write_accepted;

// FIFO signals
wire [FIFO_ID_WIDTH-1:0] fifo_next_word;
reg [FIFO_ID_WIDTH-1:0] fifo_next_word_reg;
wire fifo_full;
wire [FIFO_DEPTH_LOG2-1:0] fifo_used;
wire [MWIDTH-1:0] fifo_data_out;
wire [MWIDTH_BYTES-1:0] fifo_byteenable_out;
wire [NUM_FIFOS-1:0][FIFO_DEPTH_LOG2-1:0] fifo_used_n;
wire [NUM_FIFOS-1:0] fifo_full_n;
wire [MWIDTH_BYTES-1:0] fifo_byteenable;
wire [NUM_FIFOS-1:0] fifo_wrreq_n;

// Number of threads remaining
reg [2:0] valid_in_d;
reg [31:0] threads_remaining_to_be_serviced;

// Number of threads that are being "serviced"
// We need this counter to ensure that we stall subsequent groups
// of threads until we're completely finished writing the inital group
reg [31:0] threads_rem;

// Track the number of threads we have yet to see - there is a 3 cycle
// latency on the data storage FIFOs, so delay the valid in signal to compensate
always@(posedge clk or posedge reset)
begin
   if(reset == 1'b1)
   begin
      valid_in_d <= 3'b000;
      threads_rem <= 0;
   end
   else
   begin
      valid_in_d <= { (i_valid && !o_stall && !i_nop), valid_in_d[2:1] };
      threads_rem <= go ? size : threads_rem - valid_in_d[0];              // do not decrement when loading size, valid_in_d[0] may have 'leftover' valids from previous stream
   end
end

// Force address alignment bits to 0.  They should already be 0, but forcing 
// them to 0 here lets Quartus see the alignment and optimize the design
assign aligned_base_address = ((base_address >> ALIGNMENT_ABITS) << ALIGNMENT_ABITS);

// The address of the last word we will write to
assign last_word_address = aligned_base_address + ((size - 1) << BYTE_SELECT_BITS);

// Zero off any offset bits to find the first MWIDTH aligned burst address
assign a_base_address = ((aligned_base_address >> MBYTE_SELECT_BITS) << MBYTE_SELECT_BITS);

// The offset (in words) from an aligned MWIDTH address
assign base_offset = (aligned_base_address[MBYTE_SELECT_BITS-1:0] >> BYTE_SELECT_BITS);

// The total size (in bytes) of the transaction is (size + base_offset) * bytes rounded up to
// the next MWIDTH aligned size
assign a_size = (((((size + base_offset) << BYTE_SELECT_BITS) + {MBYTE_SELECT_BITS{1'b1}}) >> MBYTE_SELECT_BITS) << MBYTE_SELECT_BITS);

// Begin bursting when the first valid thread arrives - assumed to be when a
// valid thread arrives and the unit is idle.
assign go = i_valid && !o_stall && !i_nop && c_done;

// Control registers and registered avalon outputs
always@(posedge clk or posedge reset)
begin
   if(reset == 1'b1)
   begin
      wm_first_xfer <= 1'b0;
      wm_address <= {AWIDTH{1'b0}};
      c_length <= {32{1'b0}};
      c_length_reenc <= {32{1'b1}};
      wm_burstcount <= {BURSTCOUNT_WIDTH{1'b0}};
      wm_burst_counter <= {BURSTCOUNT_WIDTH{1'b0}};
      fw_byteenable <= {MWIDTH_BYTES{1'b0}};
      lw_byteenable <= {MWIDTH_BYTES{1'b0}};
      fw_in_enable <= 1'b0;
      fw_out_enable <= 1'b0;
      threads_remaining_to_be_serviced <= {32{1'b0}};
   end
   else
   begin
      wm_burstcount <= burst_begin ? burst_count : wm_burstcount;
      lw_byteenable <= (fifo_byteenable[0] ? {MWIDTH_BYTES{1'b0}} : lw_byteenable) | fifo_byteenable;

      // Registers that depend on the 'go' signal
      if(go == 1'b1)
      begin
         wm_first_xfer <= 1'b1;
         wm_address <= a_base_address;
         c_length <= a_size;
         c_length_reenc <= a_size-1;
         wm_burst_counter <= {BURSTCOUNT_WIDTH{1'b0}};
         fw_byteenable <= fifo_byteenable;
         if(NUM_FIFOS > 1)
         begin
            // If WIDTH == MWIDTH then there's no alignment issues to worry about
            fw_in_enable <= (!(i_valid && !o_stall && !i_nop) || (fifo_next_word != {FIFO_ID_WIDTH{1'b1}}));
            fw_out_enable <= 1'b1;
         end

         // When go is high, we've serviced our first thread (size-1) remaining
         // but i'll subract and extra 1 so i can check for (-1) instead of 0
         threads_remaining_to_be_serviced <= size-2;
      end
      else
      begin
         wm_first_xfer <= !burst_begin && wm_first_xfer;
         wm_address <= (!wm_first_xfer && burst_begin) ? (wm_address + (wm_burstcount << MBYTE_SELECT_BITS)) : (wm_address);
         c_length <= write_accepted ? c_length - MWIDTH_BYTES : c_length;
         c_length_reenc <= write_accepted ? c_length_reenc - MWIDTH_BYTES : c_length_reenc;
         wm_burst_counter <= burst_begin ? burst_count : (wm_burst_counter - write_accepted);
         fw_byteenable <= fw_byteenable | ({MWIDTH_BYTES{fw_in_enable}} & fifo_byteenable);
         fw_in_enable <= fw_in_enable && (!(i_valid && !o_stall && !i_nop) || (fifo_next_word != {FIFO_ID_WIDTH{1'b1}}));
         fw_out_enable <= fw_out_enable && !write_accepted;

         // Keep track of the number of threads serviced
         threads_remaining_to_be_serviced <= (i_valid && !o_stall && !i_nop) ? (threads_remaining_to_be_serviced - 1) : threads_remaining_to_be_serviced;
      end
   end
end

// Last word is being transmitted when there is only one burst left, and the burstcount is 1
assign lw_out_enable = (c_length <= MWIDTH_BYTES);

// Bursting is done when length is zero
assign c_done = c_length_reenc[31];

// First short burst - Only active on the first transfer (if applicable)
// Handles the first portion of the transfer which may not be aligned to a
// burst boundary.
assign fsb_boundary_offset = (wm_address >> MBYTE_SELECT_BITS) & (MAXBURSTCOUNT-1);
assign fsb_enable = (fsb_boundary_offset != 0) && wm_first_xfer;
assign fsb_count = (((MAXBURSTCOUNT - fsb_boundary_offset) < (c_length >> MBYTE_SELECT_BITS)) ?
                   (MAXBURSTCOUNT - fsb_boundary_offset) : lsb_count);
assign fsb_ready = (fifo_used > fsb_count) || (fifo_used == fsb_count) && (wm_burst_counter == 0);

// Last short burst - Only active on the last transfer (if applicable).
// Handles the last burst which may be less than MAXBURSTCOUNT.
assign lsb_enable = (c_length <= (MAXBURSTCOUNT << MBYTE_SELECT_BITS));
assign lsb_count = (c_length >> MBYTE_SELECT_BITS);
assign lsb_ready = (threads_rem == 0);

// Standard bursts - always bursting MAXBURSTLENGTH
assign b_ready = (fifo_used > MAXBURSTCOUNT) || ((fifo_used == MAXBURSTCOUNT) && (wm_burst_counter == 0));

// Begin a new burst whenever one of the burst stages is ready with burst data
// and the previous burst is complete or about to complete
assign burst_begin = ((fsb_enable && fsb_ready) || (lsb_enable && lsb_ready) || (b_ready)) &&
                     !c_done && ((wm_burst_counter == 0) || ((wm_burst_counter == 1) && 
                     !f_avm_waitrequest && (c_length > (MAXBURSTCOUNT << MBYTE_SELECT_BITS))));
assign burst_count = fsb_enable ? fsb_count :
                     lsb_enable ? lsb_count : MAXBURSTCOUNT;

// Increment the address when a transfer is successful
assign write_accepted = f_avm_write && !f_avm_waitrequest;

// The next fifo that will accept data
assign fifo_next_word = go ? base_offset : fifo_next_word_reg;
always@(posedge clk or posedge reset)
begin
   if(reset == 1'b1)
   begin
      fifo_next_word_reg <= {FIFO_ID_WIDTH{1'b0}};
   end
   else
   begin
      if(NUM_FIFOS > 1)
         fifo_next_word_reg <= (i_valid && !o_stall) ? fifo_next_word + 1 : fifo_next_word;
   end
end

wire [NUM_FIFOS-1:0] fifo_empty;

//disables read on FIFOs not used for the first or last cycle
wire [NUM_FIFOS-1:0] fifo_read_enable;


// The fifos!
genvar n;
generate
   for(n=0; n<NUM_FIFOS; n++)
   begin : fifo_n

      
      if (USE_BYTE_EN)
      begin
         scfifo #(
           .lpm_width( WIDTH+WIDTH_BYTES ),
           .lpm_widthu( FIFO_DEPTH_LOG2 ),
           .lpm_numwords( FIFO_DEPTH ),
           .lpm_showahead( "ON" ),
           .almost_full_value( FIFO_DEPTH - 2 ),
           .use_eab( "ON" ),
           .add_ram_output_register( "OFF" ),
           .underflow_checking( "OFF" ),
           .overflow_checking( "OFF" )
        ) data_fifo (
           .clock( clk ),
           .aclr( reset ),
           .usedw( fifo_used_n[n] ),
           .data( {i_writedata,i_byteenable }),
           .almost_full( fifo_full_n[n] ),
           .q( { fifo_data_out[n*WIDTH +: WIDTH],fifo_byteenable_out[n*WIDTH_BYTES +: WIDTH_BYTES]} ),
           .rdreq( write_accepted &&  fifo_read_enable[n] ),
           .wrreq( fifo_wrreq_n[n] ),
           .almost_empty(),
           .empty(fifo_empty[n]),
           .full(),
           .sclr()
        );
      end else begin
        scfifo #(
           .lpm_width( WIDTH ),
           .lpm_widthu( FIFO_DEPTH_LOG2 ),
           .lpm_numwords( FIFO_DEPTH ),
           .lpm_showahead( "ON" ),
           .almost_full_value( FIFO_DEPTH - 2 ),
           .use_eab( "ON" ),
           .add_ram_output_register( "OFF" ),
           .underflow_checking( "OFF" ),
           .overflow_checking( "OFF" )
        ) data_fifo (
           .clock( clk ),
           .aclr( reset ),
           .usedw( fifo_used_n[n] ),
           .data( i_writedata ),
           .almost_full( fifo_full_n[n] ),
           .q( fifo_data_out[n*WIDTH +: WIDTH] ),
           .rdreq( write_accepted &&  fifo_read_enable[n] ),
           .wrreq( fifo_wrreq_n[n] ),
           .almost_empty(),
           .empty(fifo_empty[n]),
           .full(),
           .sclr()
        );
        assign fifo_byteenable_out[n*WIDTH_BYTES +: WIDTH_BYTES] = {WIDTH_BYTES{ 1'b1}};     
      end
      
      assign fifo_wrreq_n[n] = i_valid && !o_stall && !i_nop && (fifo_next_word == n);
      assign fifo_byteenable[n*WIDTH_BYTES +: WIDTH_BYTES] = {WIDTH_BYTES{ fifo_wrreq_n[n] }};
      
      assign fifo_read_enable[n] = fw_out_enable ? fw_byteenable[n*WIDTH_BYTES] : (lw_out_enable ? lw_byteenable[n*WIDTH_BYTES] :1'b1);
   end
endgenerate

// Only the last fifo's full/used signals matter to the rest of the design
assign fifo_full = fifo_full_n[NUM_FIFOS-1];
assign fifo_used = fifo_used_n[NUM_FIFOS-1];

// Push some signals out to the avalon bus
assign f_avm_write = !c_done && (wm_burst_counter != 0);
assign f_avm_address = wm_address;
assign f_avm_burstcount = wm_burstcount;
assign f_avm_writedata = fifo_data_out;
assign f_avm_byteenable = fw_out_enable ? fw_byteenable & fifo_byteenable_out:
                       (lw_out_enable ? lw_byteenable : {MWIDTH_BYTES{1'b1}}) & fifo_byteenable_out ;


// Pipeline signals

// Added, when we are NOT done tranferring all data, but we've seen all the threads in this stream request
// then we need to stall the next group
assign o_stall = fifo_full || i_stall_int || (!c_done && threads_remaining_to_be_serviced[31]);

assign o_valid_int = i_valid && !fifo_full && !o_stall;
assign i_stall_int = o_valid && i_stall;

// Making o_valid a register to avoid direct dependence
// between i_stall and o_valid.
always@(posedge clk or posedge reset)
begin
   if(reset == 1'b1)
      o_valid <= {1'b0};
   else if (!i_stall_int)
      o_valid = o_valid_int;
   else
      o_valid = o_valid;
end

assign o_active = |(~fifo_empty);

endmodule







