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
// Top level module for pipelined memory access.
//
// Properties - Coalesced: No, Ordered: N/A, Hazard-Safe: Yes, Pipelined: Yes
//              (see lsu_top.v for details)
//
// Description: Requests are submitted as soon as they are received.
//              Pipelined access to memory so multiple requests can be 
//              in flight at a time.

// Pipelined read unit:
//    Accept read requests on the upstream interface.  When a request is
//    received, store the requested byte address in the request fifo and
//    pass the request through to the avalon interface.  Response data
//    is buffered in the response fifo and the appropriate word is muxed
//    out of the response fifo based on the address in the request fifo.
//    The response fifo has limited capacity, so a counter is used to track
//    the number of pending responses to generate an upstream stall if
//    we run out of room.

// altera message_off 10036

module lsu_enabled_read
(
    clk, reset, o_stall, i_valid, i_address, i_burstcount, i_stall, o_valid, o_readdata, 
    o_active, //Debugging signal
    avm_enable, avm_address, avm_read, avm_readdata, avm_waitrequest, avm_byteenable,
    avm_readdatavalid,
    avm_burstcount
);

/*************
* Parameters *
*************/
parameter AWIDTH=32;            // Address width (32-bits for Avalon)
parameter WIDTH_BYTES=4;        // Width of the memory access (bytes)
parameter MWIDTH_BYTES=32;      // Width of the global memory bus (bytes)
parameter ALIGNMENT_ABITS=2;    // Request address alignment (address bits)
parameter KERNEL_SIDE_MEM_LATENCY=32;    // The max number of live threads
parameter BURSTCOUNT_WIDTH=6;   // Size of Avalon burst count port

// Derived parameters
localparam MAX_BURST=2**(BURSTCOUNT_WIDTH-1);
localparam WIDTH=8*WIDTH_BYTES;
localparam MWIDTH=8*MWIDTH_BYTES;
localparam BYTE_SELECT_BITS=$clog2(MWIDTH_BYTES);
localparam SEGMENT_SELECT_BITS=BYTE_SELECT_BITS-ALIGNMENT_ABITS;

/********
* Ports *
********/
// Standard global signals
input clk;
input reset;

// Upstream interface
output o_stall;
input i_valid;
input [AWIDTH-1:0] i_address;
input [BURSTCOUNT_WIDTH-1:0] i_burstcount;

// Downstream interface
input i_stall;
output o_valid;
output [WIDTH-1:0] o_readdata;
output reg o_active;

// Avalon interface
output avm_enable;
output [AWIDTH-1:0] avm_address;
output avm_read;
input [MWIDTH-1:0] avm_readdata;
input avm_waitrequest;
output [MWIDTH_BYTES-1:0] avm_byteenable;
input avm_readdatavalid;

output [BURSTCOUNT_WIDTH-1:0] avm_burstcount;

logic [KERNEL_SIDE_MEM_LATENCY-1:0] enable_count;
logic lsu_active;

/***************
* Architecture *
***************/

wire [BYTE_SELECT_BITS-1:0] byte_select;

always @(posedge clk) begin
   if (reset) begin
      o_active <= 1'b0;
   end else begin
      o_active <= i_valid & ~i_stall;
   end
end


// Optional Pipeline register before return
//
reg r_avm_readdatavalid;
reg [MWIDTH-1:0] r_avm_readdata;

// Don't register the return
always@(*)
begin
  r_avm_readdata = avm_readdata;
  r_avm_readdatavalid = avm_readdatavalid;
end

wire [WIDTH-1:0] rdata;
// Byte-addresses enter a FIFO so we can demux the appropriate data back out.
generate
if(SEGMENT_SELECT_BITS > 0)
begin
  wire [SEGMENT_SELECT_BITS-1:0] segment_address_out;
  wire [SEGMENT_SELECT_BITS-1:0] segment_address_in;
  assign segment_address_in = i_address[ALIGNMENT_ABITS +: BYTE_SELECT_BITS-ALIGNMENT_ABITS];

  acl_data_fifo #(
      .DATA_WIDTH(SEGMENT_SELECT_BITS),
      .DEPTH(KERNEL_SIDE_MEM_LATENCY - 1),
      .ALLOW_FULL_WRITE(1),
      .IMPL("shift_reg")
  ) req_fifo (
      .clock(clk),
      .resetn(~reset),
      .data_in( segment_address_in ),
      .data_out( segment_address_out ),
      .valid_in(i_valid), //should be tied to 1 in enable cluster
      .valid_out(),
      .stall_in(i_stall),
      .stall_out()
  );
  assign byte_select = (segment_address_out << ALIGNMENT_ABITS);
  assign rdata = r_avm_readdata[8*byte_select +: WIDTH];
end
else
begin
  assign byte_select = '0;
  assign rdata = r_avm_readdata;
end
endgenerate

assign avm_byteenable = {MWIDTH_BYTES{1'b1}};


assign avm_address = ((i_address >> BYTE_SELECT_BITS) << BYTE_SELECT_BITS);
assign avm_read = i_valid;
assign avm_burstcount = i_burstcount;
assign avm_enable = ~i_stall | ~lsu_active;

assign o_stall = i_stall; //not used by enable cluster
assign o_valid = r_avm_readdatavalid; //not used by enable cluster
assign o_readdata = rdata;

assign lsu_active = |enable_count;
always @(posedge clk) begin
   if (reset) begin
      enable_count <= 'b0;
   end else begin
      if(~i_stall) begin
        enable_count <= (KERNEL_SIDE_MEM_LATENCY == 1) ? i_valid : {enable_count[KERNEL_SIDE_MEM_LATENCY-2:0], i_valid};
      end
   end
end

endmodule

/******************************************************************************/

// Pipelined write unit:
//    Accept write requests on the upstream interface.  Mux the data into the
//    appropriate word lines based on the segment select bits.  Also toggle
//    the appropriate byte-enable lines to preserve data we are not 
//    overwriting.  A counter keeps track of how many requests have been
//    send but not yet acknowledged by downstream blocks.
module lsu_enabled_write
(
    clk, reset, o_stall, i_valid, i_address, i_writedata, i_stall, o_valid, i_byteenable,
    o_active, //Debugging signal
    avm_enable, avm_address, avm_write, avm_writeack, avm_writedata, avm_byteenable, avm_waitrequest
);

/*************
* Parameters *
*************/
parameter KERNEL_SIDE_MEM_LATENCY=32;    // The max number of live threads
parameter AWIDTH=32;    // Address width (32-bits for Avalon)
parameter WIDTH_BYTES=4;     // Width of the memory access
parameter MWIDTH_BYTES=32;   // Width of the global memory bus
parameter ALIGNMENT_ABITS=2;    // Request address alignment (address bits)
parameter USE_BYTE_EN=0;

localparam WIDTH=8*WIDTH_BYTES;
localparam MWIDTH=8*MWIDTH_BYTES;
localparam BYTE_SELECT_BITS=$clog2(MWIDTH_BYTES);
localparam SEGMENT_SELECT_BITS=BYTE_SELECT_BITS-ALIGNMENT_ABITS;
localparam SEGMENT_WIDTH=8*(2**ALIGNMENT_ABITS);
localparam SEGMENT_WIDTH_BYTES=(2**ALIGNMENT_ABITS);

/********
* Ports *
********/
// Standard global signals
input clk;
input reset;

// Upstream interface
output o_stall;
input i_valid;
input [AWIDTH-1:0] i_address;
input [WIDTH-1:0] i_writedata;
input [WIDTH_BYTES-1:0] i_byteenable;
// Downstream interface
input i_stall;
output o_valid;
output reg o_active;

// Avalon interface
output avm_enable;
output [AWIDTH-1:0] avm_address;
output avm_write;
input avm_writeack;
output reg [MWIDTH-1:0] avm_writedata;
output reg [MWIDTH_BYTES-1:0] avm_byteenable;
input avm_waitrequest;

logic [KERNEL_SIDE_MEM_LATENCY-1:0] enable_count;
logic lsu_active;

/***************
* Architecture *
***************/

wire [WIDTH_BYTES-1:0] byteenable;

assign byteenable = USE_BYTE_EN ? i_byteenable : {WIDTH_BYTES{1'b1}}; 

// Avalon interface
assign avm_address = ((i_address >> BYTE_SELECT_BITS) << BYTE_SELECT_BITS);
assign avm_write = i_valid;


// Mux in the correct data
generate
if(SEGMENT_SELECT_BITS > 0)
begin
  wire [SEGMENT_SELECT_BITS-1:0] segment_select;
  assign segment_select = i_address[ALIGNMENT_ABITS +: BYTE_SELECT_BITS-ALIGNMENT_ABITS];
  always@(*)
  begin
    avm_writedata = {MWIDTH{1'bx}};
    avm_writedata[segment_select*SEGMENT_WIDTH +: WIDTH] = i_writedata;

    avm_byteenable = {MWIDTH_BYTES{1'b0}};
    avm_byteenable[segment_select*SEGMENT_WIDTH_BYTES +: WIDTH_BYTES] = byteenable;
  end
end
else
begin
  always@(*)
  begin
    avm_writedata = i_writedata;
    avm_byteenable = byteenable;
  end
end
endgenerate

assign avm_enable = ~i_stall | ~lsu_active;

assign o_stall = i_stall; //not used in enable cluster
assign o_valid = avm_writeack; //not used in enable cluster

assign lsu_active = |enable_count;
always @(posedge clk) begin
   if (reset) begin
      enable_count <= 'b0;
   end else begin
      if(~i_stall) begin
        enable_count <= (KERNEL_SIDE_MEM_LATENCY == 1) ? i_valid : {enable_count[KERNEL_SIDE_MEM_LATENCY-2:0], i_valid};
      end
   end
end

endmodule

