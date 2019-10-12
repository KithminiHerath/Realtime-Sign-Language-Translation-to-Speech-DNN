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


module lsu_non_aligned_write
(
    clk, clk2x, reset, o_stall, i_valid, i_address, i_writedata, i_stall, i_byteenable, o_valid,
    
    o_active, //Debugging signal
    avm_address, avm_write, avm_writeack, avm_writedata, avm_byteenable, avm_waitrequest,
    avm_burstcount, i_nop,
    extra_unaligned_reqs // profiling
);
parameter AWIDTH=32;            // Address width (32-bits for Avalon)
parameter WIDTH_BYTES=4;        // Width of the memory access (bytes)
parameter MWIDTH_BYTES=32;      // Width of the global memory bus (bytes)
parameter ALIGNMENT_ABITS=2;    // Request address alignment (address bits)
parameter KERNEL_SIDE_MEM_LATENCY=32;    // Memory latency in threads
parameter MEMORY_SIDE_MEM_LATENCY=32;    
parameter BURSTCOUNT_WIDTH=6;   // Size of Avalon burst count port
parameter USE_WRITE_ACK=0;      // Wait till the write has actually made it to global memory
parameter HIGH_FMAX=1;
parameter USE_BYTE_EN=0;
parameter ACL_PROFILE = 0;      // Profiler

localparam WIDTH=8*WIDTH_BYTES;
localparam MWIDTH=8*MWIDTH_BYTES;
localparam BYTE_SELECT_BITS=$clog2(MWIDTH_BYTES);
localparam NUM_OUTPUT_WORD = MWIDTH_BYTES/WIDTH_BYTES;
localparam NUM_OUTPUT_WORD_W = $clog2(NUM_OUTPUT_WORD);
localparam UNALIGNED_BITS=$clog2(WIDTH_BYTES)-ALIGNMENT_ABITS;
localparam WIDTH_ABITS=$clog2(WIDTH_BYTES);

/********
* Ports *
********/
// Standard global signals
input clk;
input clk2x;
input reset;

// Upstream interface
output o_stall;
input i_valid;
input [AWIDTH-1:0] i_address;
input [WIDTH-1:0] i_writedata;

// Downstream interface
input i_stall;
output o_valid;
output reg o_active;

// Byte enable control 
input [WIDTH_BYTES-1:0] i_byteenable;


// Avalon interface
output [AWIDTH-1:0] avm_address;
output avm_write;
input avm_writeack;
output [MWIDTH-1:0] avm_writedata;
output [MWIDTH_BYTES-1:0] avm_byteenable;
input avm_waitrequest;
output [BURSTCOUNT_WIDTH-1:0] avm_burstcount;

// Profiling
output extra_unaligned_reqs;

input i_nop;

reg reg_lsu_i_valid;
reg [AWIDTH-BYTE_SELECT_BITS-1:0] page_addr_next;
reg [AWIDTH-1:0] reg_lsu_i_address;
reg [WIDTH-1:0] reg_lsu_i_writedata;
reg reg_nop;
reg reg_consecutive;
reg [WIDTH_BYTES-1:0] reg_word_byte_enable;
reg  [UNALIGNED_BITS-1:0] shift  = 0;
wire extra_unaligned_reqs_int;


wire stall_int;
assign o_stall = reg_lsu_i_valid & stall_int;   
assign extra_unaligned_reqs = extra_unaligned_reqs_int & o_stall;
wire [AWIDTH-1:0] addr_boaundry  = i_address + WIDTH_BYTES;                             

// --------------- Pipeline stage : Consecutive Address Checking  --------------------
always@(posedge clk or posedge reset)
begin
   if (reset) reg_lsu_i_valid <= 1'b0; 
   else if (~o_stall)   reg_lsu_i_valid <= i_valid;
end
always@(posedge clk) begin
  if (~o_stall & i_valid & ~i_nop)  begin   
    reg_lsu_i_address <= i_address;                               
    page_addr_next <= i_address[AWIDTH-1:BYTE_SELECT_BITS] + 1'b1;
    shift <= addr_boaundry[ALIGNMENT_ABITS+UNALIGNED_BITS-1:ALIGNMENT_ABITS];  
    reg_lsu_i_writedata <= i_writedata;
    reg_word_byte_enable <= USE_BYTE_EN? (i_nop? '0 : i_byteenable) : '1;         
  end
          
  if (~o_stall) begin
    reg_nop <= i_nop;
    reg_consecutive <= !i_nop & page_addr_next === i_address[AWIDTH-1:BYTE_SELECT_BITS]
                        // to simplify logic in lsu_bursting_write   
                        // the new writedata does not overlap with the previous one
                        & i_address[BYTE_SELECT_BITS-1:ALIGNMENT_ABITS] >= shift;  
    
  end
end
// -------------------------------------------------------------------

lsu_non_aligned_write_internal #(
   .KERNEL_SIDE_MEM_LATENCY(KERNEL_SIDE_MEM_LATENCY),
   .MEMORY_SIDE_MEM_LATENCY(MEMORY_SIDE_MEM_LATENCY),
   .AWIDTH(AWIDTH),
   .WIDTH_BYTES(WIDTH_BYTES),
   .MWIDTH_BYTES(MWIDTH_BYTES),
   .BURSTCOUNT_WIDTH(BURSTCOUNT_WIDTH),
   .ALIGNMENT_ABITS(ALIGNMENT_ABITS),
   .USE_WRITE_ACK(USE_WRITE_ACK),
   .USE_BYTE_EN(1),
   .HIGH_FMAX(HIGH_FMAX),
   .ACL_PROFILE(ACL_PROFILE)
) non_aligned_write (
   .clk(clk),
   .clk2x(clk2x),
   .reset(reset),
   .o_stall(stall_int),
   .i_valid(reg_lsu_i_valid),
   .i_address(reg_lsu_i_address),
   .i_writedata(reg_lsu_i_writedata),
   .i_stall(i_stall),
   .i_byteenable(reg_word_byte_enable),
   .o_valid(o_valid),
   .o_active(o_active),
   .avm_address(avm_address),
   .avm_write(avm_write),
   .avm_writeack(avm_writeack),
   .avm_writedata(avm_writedata),
   .avm_byteenable(avm_byteenable),
   .avm_burstcount(avm_burstcount),
   .avm_waitrequest(avm_waitrequest),
   .i_nop(reg_nop),
//   .consecutive(reg_consecutive),                   // TODO: re-enable detection of consecutive writes
   .consecutive(1'b0),                                // disable the consecutive input to work around a functional bug (Case:359307), this will impact throughput and should be undone in the future
   .extra_unaligned_reqs(extra_unaligned_reqs_int)
);
endmodule

//
// Non-aligned write wrapper for LSUs
//
module lsu_non_aligned_write_internal
(
    clk, clk2x, reset, o_stall, i_valid, i_address, i_writedata, i_stall, i_byteenable, o_valid, 
    o_active, //Debugging signal
    avm_address, avm_write, avm_writeack, avm_writedata, avm_byteenable, avm_waitrequest,
    avm_burstcount,
    i_nop,
    consecutive,
    extra_unaligned_reqs
);

// Paramaters to pass down to lsu_top
//
parameter AWIDTH=32;            // Address width (32-bits for Avalon)
parameter WIDTH_BYTES=4;        // Width of the memory access (bytes)
parameter MWIDTH_BYTES=32;      // Width of the global memory bus (bytes)
parameter ALIGNMENT_ABITS=2;    // Request address alignment (address bits)
parameter KERNEL_SIDE_MEM_LATENCY=160;   // Determines the max number of live requests.
parameter MEMORY_SIDE_MEM_LATENCY=0;   // Determines the max number of live requests.
parameter BURSTCOUNT_WIDTH=6;   // Size of Avalon burst count port
parameter USECACHING=0;
parameter USE_WRITE_ACK=0;
parameter TIMEOUT=8;
parameter HIGH_FMAX=1;
parameter USE_BYTE_EN=0;
parameter ACL_PROFILE = 0;      // Profiler

localparam WIDTH=WIDTH_BYTES*8;
localparam MWIDTH=MWIDTH_BYTES*8;
localparam TRACKING_FIFO_DEPTH=KERNEL_SIDE_MEM_LATENCY+1;
localparam WIDTH_ABITS=$clog2(WIDTH_BYTES);
localparam TIMEOUTBITS=$clog2(TIMEOUT);
localparam BYTE_SELECT_BITS=$clog2(MWIDTH_BYTES);

// 
// Suppose that we vectorize 4 ways and are accessing a float4 but are only guaranteed float alignment
//
// WIDTH_BYTES=16           --> $clog2(WIDTH_BYTES) = 4
// ALIGNMENT_ABITS          --> 2
// UNALIGNED_BITS --> 2
//
// +----+----+----+----+----+----+
// | X  | Y  |  Z | W  | A  | B  |
// +----+----+----+----+----+----+
//  0000 0100 1000 1100  ...
//
// float4 access at 1000
//   requires two aligned access
//        0000 -> mux out Z , W
//       10000 -> mux out A , B
//
localparam UNALIGNED_BITS=$clog2(WIDTH_BYTES)-ALIGNMENT_ABITS;

// How much alignment are we guaranteed in terms of bits
// float -> ALIGNMENT_ABITS=2 -> 4 bytes -> 32 bits
localparam ALIGNMENT_DBYTES=2**ALIGNMENT_ABITS;
localparam ALIGNMENT_DBITS=8*ALIGNMENT_DBYTES;
localparam NUM_WORD = MWIDTH_BYTES/ALIGNMENT_DBYTES;

// -------- Interface Declarations ------------

// Standard global signals
input clk;
input clk2x;
input reset;
input i_nop;

// Upstream interface
output o_stall;
input i_valid;
input [AWIDTH-1:0] i_address;
input [WIDTH-1:0] i_writedata;

// Downstream interface
input i_stall;
output o_valid;
output o_active;
output extra_unaligned_reqs;


// Byte enable control 
input [WIDTH_BYTES-1:0] i_byteenable;



// Avalon interface
output [AWIDTH-1:0] avm_address;
output avm_write;
input avm_writeack;
output [MWIDTH-1:0] avm_writedata;
output [MWIDTH_BYTES-1:0] avm_byteenable;
input avm_waitrequest;
output [BURSTCOUNT_WIDTH-1:0] avm_burstcount;

// help from outside to track addresses
input consecutive;

// ------- Bursting LSU instantiation ---------

wire lsu_o_stall;
wire lsu_i_valid;
wire [AWIDTH-1:0] lsu_i_address;
wire [2*WIDTH-1:0] lsu_i_writedata;
wire [2*WIDTH_BYTES-1:0] lsu_i_byte_enable;
wire [AWIDTH-BYTE_SELECT_BITS-1:0] i_page_addr = i_address[AWIDTH-1:BYTE_SELECT_BITS];
wire [BYTE_SELECT_BITS-1:0] i_byte_offset=i_address[BYTE_SELECT_BITS-1:0];

reg reg_lsu_i_valid, reg_lsu_i_nop, thread_valid;
reg [AWIDTH-1:0] reg_lsu_i_address;
reg [WIDTH-1:0] reg_lsu_i_writedata, data_2nd;
reg [WIDTH_BYTES-1:0] reg_lsu_i_byte_enable, byte_en_2nd;
wire [UNALIGNED_BITS-1:0] shift;
wire is_access_aligned;
logic issue_2nd_word;

wire stall_int;
assign lsu_o_stall = reg_lsu_i_valid & stall_int;

// Stall out if we 
//  1. can't accept the request right now because of fifo fullness or lsu stalls, or
//  2. we need to issue the 2nd word from previous requests before proceeding to this one
assign o_stall = lsu_o_stall | issue_2nd_word /*& !i_nop*/ & !consecutive; // can't combine an incoming nop with the 2nd word any more, as we now generate the valid on the 2nd word instead of the first
assign extra_unaligned_reqs = o_stall & !lsu_o_stall;

// --------- Module Internal State -------------
reg [AWIDTH-BYTE_SELECT_BITS-1:0] next_page_addr;

// The actual requested address going into the LSU
assign lsu_i_address[AWIDTH-1:BYTE_SELECT_BITS] = issue_2nd_word? next_page_addr : i_page_addr;
assign lsu_i_address[BYTE_SELECT_BITS-1:0] = issue_2nd_word? '0 : is_access_aligned? i_address[BYTE_SELECT_BITS-1:0] : {i_address[BYTE_SELECT_BITS-1:ALIGNMENT_ABITS] - shift, {ALIGNMENT_ABITS{1'b0}}};


// The actual data to be written and corresponding byte/bit enables
assign shift = i_address[ALIGNMENT_ABITS+UNALIGNED_BITS-1:ALIGNMENT_ABITS];
assign lsu_i_byte_enable = {{WIDTH_BYTES{1'b0}},i_byteenable} << {shift, {ALIGNMENT_ABITS{1'b0}}};
assign lsu_i_writedata = {{WIDTH{1'b0}},i_writedata} << {shift, {ALIGNMENT_ABITS{1'b0}}, 3'd0};

// Is this request access already aligned .. then no need to do anything special
assign is_access_aligned = (i_address[BYTE_SELECT_BITS-1:0]+ WIDTH_BYTES) <= MWIDTH_BYTES;      
assign lsu_i_valid = i_valid | issue_2nd_word;

// When do we need to issue the 2nd word?
// The previous address needed a 2nd word and the current requested address isn't 
// consecutive with the previous

// --- Pipeline before going into the LSU ---
always@(posedge clk or posedge reset)
begin
  if (reset) begin
    reg_lsu_i_valid <= 1'b0;
    thread_valid <= 1'b0;
    issue_2nd_word <= 1'b0;      
  end
  else begin     
    if (~lsu_o_stall) begin
       reg_lsu_i_valid <= lsu_i_valid;
       thread_valid <= (i_valid & (i_nop | is_access_aligned )) | (issue_2nd_word );     // assert thread_valid on the second word of a non-aligned write (both words must be written before the valid can be properly asserted)
       issue_2nd_word <= i_valid & !o_stall & !i_nop & !is_access_aligned; 
    end
    else if(!stall_int) issue_2nd_word <= 1'b0;       // TODO: this looks like dead code, if lsu_o_stall = 1, then stall_int must always be 1 (lsu_o_stall = reg_lsu_i_valid & stall_int)
  end
end
// --- -------------------------------------
reg [BYTE_SELECT_BITS-1-ALIGNMENT_ABITS:0]i_2nd_offset; 
reg [WIDTH-1:0] i_2nd_data;
reg [WIDTH_BYTES-1:0] i_2nd_byte_en;
reg i_2nd_en;
always @(posedge clk) begin    
  if(i_valid & ~i_nop & ~o_stall) next_page_addr <= i_page_addr + 1'b1;
  if(~lsu_o_stall) begin
    reg_lsu_i_address <= lsu_i_address;
    reg_lsu_i_nop <= issue_2nd_word? 1'b0 : i_nop;     
    data_2nd <= lsu_i_writedata[2*WIDTH-1:WIDTH];    
    byte_en_2nd <= lsu_i_byte_enable[2*WIDTH_BYTES-1:WIDTH_BYTES];  
    reg_lsu_i_writedata <= issue_2nd_word ? data_2nd: is_access_aligned? i_writedata : lsu_i_writedata[WIDTH-1:0]; 
    reg_lsu_i_byte_enable <= issue_2nd_word ? byte_en_2nd: is_access_aligned? i_byteenable : lsu_i_byte_enable[WIDTH_BYTES-1:0];
    i_2nd_en <= issue_2nd_word & consecutive & i_valid;   
    i_2nd_offset <= i_address[BYTE_SELECT_BITS-1:ALIGNMENT_ABITS];
    i_2nd_data <= i_writedata;
    i_2nd_byte_en <= i_byteenable;
  end  
end
lsu_bursting_write #(
   .KERNEL_SIDE_MEM_LATENCY(KERNEL_SIDE_MEM_LATENCY),
   .MEMORY_SIDE_MEM_LATENCY(MEMORY_SIDE_MEM_LATENCY),
   .AWIDTH(AWIDTH),
   .WIDTH_BYTES(WIDTH_BYTES),
   .MWIDTH_BYTES(MWIDTH_BYTES),
   .BURSTCOUNT_WIDTH(BURSTCOUNT_WIDTH),
   .ALIGNMENT_ABITS(ALIGNMENT_ABITS),
   .USE_WRITE_ACK(USE_WRITE_ACK),
   .USE_BYTE_EN(1'b1),
   .UNALIGN(1),
   .HIGH_FMAX(HIGH_FMAX)
) bursting_write (
   .clk(clk),
   .clk2x(clk2x),
   .reset(reset),
   .i_nop(reg_lsu_i_nop),
   .o_stall(stall_int),
   .i_valid(reg_lsu_i_valid),
   .i_thread_valid(thread_valid),
   .i_address(reg_lsu_i_address),
   .i_writedata(reg_lsu_i_writedata),
   .i_2nd_offset(i_2nd_offset), 
   .i_2nd_data(i_2nd_data),
   .i_2nd_byte_en(i_2nd_byte_en),
   .i_2nd_en(i_2nd_en),   
   .i_stall(i_stall),
   .o_valid(o_valid),
   .o_active(o_active),
   .i_byteenable(reg_lsu_i_byte_enable),
   .avm_address(avm_address),
   .avm_write(avm_write),
   .avm_writeack(avm_writeack),
   .avm_writedata(avm_writedata),
   .avm_byteenable(avm_byteenable),
   .avm_burstcount(avm_burstcount),
   .avm_waitrequest(avm_waitrequest)
);
endmodule
