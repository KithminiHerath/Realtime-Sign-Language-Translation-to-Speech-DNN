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
// Top level module for simple memory access.  See lsu_top.v.
//
// Properties - Coalesced: No, Ordered: N/A, Hazard-Safe: Yes, Pipelined: No
//              (see lsu_top.v for details)
//
// Description: Simple un-pipelined memory access.  Low throughput.
//

// Simple read unit:
//    Accept read requests on the upstream interface.  When a request is
//    received, set the pending register to true to stall any subsequent 
//    requests until the transaction is complete.  Since an avalon master
//    cannot stall a response, staging registers are used at the output to
//    provide a storage location until the downstream block is ready to accept
//    data.  Once the output registers are cleared and there are no pending
//    requests, accept a new transaction.
module lsu_simple_read
(
    clk, reset, o_stall, i_valid, i_address, i_stall, o_valid, o_readdata, 
    o_active,  // Debugging signal
    avm_address, avm_read, avm_readdata, avm_waitrequest, avm_byteenable,
    avm_readdatavalid
);

/*************
* Parameters *
*************/
parameter AWIDTH=32;            // Address width (32-bits for Avalon)
parameter WIDTH_BYTES=4;        // Width of the memory access (bytes)
parameter MWIDTH_BYTES=32;      // Width of the global memory bus (bytes)
parameter ALIGNMENT_ABITS=2;    // Request address alignment (address bits)
                                //   - indicates how many bits of the address 
                                //     are '0' due to the request alignment

parameter HIGH_FMAX=1;

localparam WIDTH=8*WIDTH_BYTES;
localparam MWIDTH=8*MWIDTH_BYTES;
localparam BYTE_SELECT_BITS=$clog2(MWIDTH_BYTES);
localparam MIN_BYTE_SELECT_BITS = BYTE_SELECT_BITS == 0 ? 1 : BYTE_SELECT_BITS;

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

// Downstream interface
input i_stall;
output o_valid;
output [WIDTH-1:0] o_readdata;
output o_active;

// Avalon interface
output [AWIDTH-1:0] avm_address;
output avm_read;
input [MWIDTH-1:0] avm_readdata;
input avm_waitrequest;
output [MWIDTH_BYTES-1:0] avm_byteenable;
input avm_readdatavalid;

/***************
* Architecture *
***************/
reg pending;
wire read_accepted;
wire rdata_accepted;
wire sr_stall;
wire ready;
wire [WIDTH-1:0] rdata;
wire [MIN_BYTE_SELECT_BITS-1:0] byte_address;
reg [MIN_BYTE_SELECT_BITS-1:0] byte_select;

// Ready for new data if we have access to the downstream registers and there
// is no pending memory transaction
assign ready = !sr_stall && !pending;

wire [AWIDTH-1:0] f_avm_address;
wire f_avm_read;
wire f_avm_waitrequest;

// Avalon signals - passed through from inputs
assign f_avm_address = (i_address[AWIDTH-1:BYTE_SELECT_BITS] << BYTE_SELECT_BITS);
assign f_avm_read = i_valid && ready;
assign avm_byteenable = {MWIDTH_BYTES{1'b1}};

// Upstream stall if we aren't ready for new data, or the avalon interface
// is stalling.
assign o_stall = f_avm_waitrequest || !ready;

// Pick out the byte address
// Explicitly set alignment address bits to 0 to help synthesis optimizations.
generate
if (BYTE_SELECT_BITS == 0) begin
assign byte_address = 1'b0;
end
else begin
assign byte_address = ((i_address[MIN_BYTE_SELECT_BITS-1:0] >> ALIGNMENT_ABITS) << ALIGNMENT_ABITS);
end
endgenerate

// State registers
always@(posedge clk or posedge reset)
begin
    if(reset == 1'b1)
    begin
        pending <= 1'b0;
        byte_select <= 'x;  // don't need to reset
    end
    else
    begin
        // A requst remains pending until we receive valid data; and a request
        // becomes pending if we accept a new valid input
        pending <= pending ? !avm_readdatavalid : (i_valid && !o_stall && !avm_readdatavalid);
        // Remember which bytes to select out of the wider global memory bus.
        byte_select <= pending ? byte_select : byte_address;
    end
end

// Mux in the appropriate response bits
assign rdata = avm_readdata[8*byte_select +: WIDTH];

// Output staging register - required so that we can guarantee there is
// a place to store the readdata response
acl_staging_reg #(
    .WIDTH(WIDTH)
) staging_reg (
    .clk(clk), 
    .reset(reset), 
    .i_data(rdata), 
    .i_valid(avm_readdatavalid), 
    .o_stall(sr_stall), 
    .o_data(o_readdata), 
    .o_valid(o_valid), 
    .i_stall (i_stall)
);

generate
if(HIGH_FMAX)
begin
  // Pipeline the interface

  acl_data_fifo #(
      .DATA_WIDTH(AWIDTH),
      .DEPTH(2),
      .IMPL("ll_reg")
  ) avm_buffer (
      .clock(clk),
      .resetn(!reset),
      .data_in(f_avm_address),
      .valid_in(f_avm_read),
      .data_out(avm_address),
      .valid_out( avm_read ),
      .stall_in( avm_waitrequest ),
      .stall_out( f_avm_waitrequest )
  );
end
else
begin
  // No interface pipelining

  assign f_avm_waitrequest = avm_waitrequest;
  assign avm_address = f_avm_address;
  assign avm_read = f_avm_read;
end
endgenerate
assign o_active=pending;

endmodule

// Simple write unit:
//    Accept write requests on the upstream interface.  When a request is
//    received, pass it through to the avalon bus.  Once avalon accepts
//    the request, set the output valid bit to true and stall until
//    the downstream block acknowledges the successful write.
module lsu_simple_write
(
    clk, reset, o_stall, i_valid, i_address, i_writedata, i_stall, o_valid, i_byteenable,
    o_active,  // Debugging signal
    avm_address, avm_write, avm_writeack, avm_writedata, avm_byteenable, avm_waitrequest
);

/*************
* Parameters *
*************/
parameter AWIDTH=32;    // Address width (32-bits for Avalon)
parameter WIDTH_BYTES=4;     // Width of the request
parameter MWIDTH_BYTES=32;   // Width of the global memory bus
parameter ALIGNMENT_ABITS=2;    // Request address alignment (address bits)

localparam WIDTH=8*WIDTH_BYTES;
localparam MWIDTH=8*MWIDTH_BYTES;
localparam BYTE_SELECT_BITS=$clog2(MWIDTH_BYTES);
localparam SEGMENT_SELECT_BITS=BYTE_SELECT_BITS-ALIGNMENT_ABITS;
localparam NUM_SEGMENTS=2**SEGMENT_SELECT_BITS;
localparam SEGMENT_WIDTH=8*(2**ALIGNMENT_ABITS);
localparam SEGMENT_WIDTH_BYTES=(2**ALIGNMENT_ABITS);
parameter USE_BYTE_EN=0;

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
output o_active;

// Avalon interface
output [AWIDTH-1:0] avm_address;
output avm_write;
input avm_writeack;
output reg [MWIDTH-1:0] avm_writedata;
output reg [MWIDTH_BYTES-1:0] avm_byteenable;
input avm_waitrequest;

/***************
* Architecture *
***************/
reg write_pending;
wire write_accepted;
wire ready;
wire sr_stall;

// Avalon interface
assign avm_address = ((i_address >> BYTE_SELECT_BITS) << BYTE_SELECT_BITS);
assign avm_write = ready && i_valid;

// Mux in the correct data
generate if( SEGMENT_SELECT_BITS > 0 )
begin
   wire [SEGMENT_SELECT_BITS-1:0] segment_select;
   assign segment_select = i_address[BYTE_SELECT_BITS-1:ALIGNMENT_ABITS];
   always@(*)
   begin
      avm_writedata = {MWIDTH{1'bx}};
      avm_writedata[segment_select*SEGMENT_WIDTH +: WIDTH] = i_writedata;

      avm_byteenable = {MWIDTH_BYTES{1'b0}};
      avm_byteenable[segment_select*SEGMENT_WIDTH_BYTES +: WIDTH_BYTES] = USE_BYTE_EN ? i_byteenable : {WIDTH_BYTES{1'b1}};
   end
end
else
begin
   always@(*)
   begin
      avm_writedata = {MWIDTH{1'bx}};
      avm_writedata[0 +: WIDTH] = i_writedata;

      avm_byteenable = {MWIDTH_BYTES{1'b0}};
      avm_byteenable[0 +: WIDTH_BYTES] =  USE_BYTE_EN ? i_byteenable : {WIDTH_BYTES{1'b1}};
   end
end
endgenerate

always@(posedge clk or posedge reset)
begin
   if(reset == 1'b1)
   begin
      write_pending <= 1'b0;
   end
   else
   begin
      write_pending <= (write_accepted || write_pending) && !avm_writeack;
   end
end

// Control logic
assign ready = !sr_stall && !write_pending;
assign write_accepted = avm_write && !avm_waitrequest;
assign o_stall = !ready || avm_waitrequest;

// Output staging register - required so that we can guarantee there is
// a place to store the valid bit
acl_staging_reg #(
    .WIDTH(1)
) staging_reg (
    .clk(clk), 
    .reset(reset), 
    .i_data(1'b0), 
    .i_valid(avm_writeack), 
    .o_stall(sr_stall), 
    .o_data(), 
    .o_valid(o_valid), 
    .i_stall (i_stall)
);

assign o_active=write_pending;

endmodule

