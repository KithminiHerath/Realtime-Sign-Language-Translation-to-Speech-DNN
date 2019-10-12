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
// Top level module for in-order coalesced memory access.
//
// Properties - Coalesced: Yes, Ordered: Yes, Hazard-Safe: Yes, Pipelined: Yes
//              (see lsu_top.v for details)
//
// Description: Requests are submitted as soon as possible to memory, stalled
//              requests are coalesced with neighbouring requests if they
//              access the same page of memory.

// Basic coalesced read unit:
//    Accept read requests on the upstream interface.  Requests are sent to 
//    the avalon bus as soon as they are recieved.  If the avalon bus is
//    stalling, requests to the same global-memory word are coalesced into
//    a single request to improve efficiency.  
//
//    The request FIFO stores the byte-address to select the appropriate word 
//    out of the response data as well as an extra bit to indicate if the 
//    request is coalesced with the previous request or if a new request was 
//    made.  The output port looks ahead to the next pending request to
//    determine whether the current response data can be thrown away or
//    must be kept to service the next coalesced request.
module lsu_basic_coalesced_read
(
    clk, reset, o_stall, i_valid, i_address, i_stall, o_valid, o_readdata, 
    o_active, //Debugging signal
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
parameter KERNEL_SIDE_MEM_LATENCY=32;    // Determines the max number of live requests.

// Derived parameters
localparam WIDTH=8*WIDTH_BYTES;
localparam MWIDTH=8*MWIDTH_BYTES;
localparam BYTE_SELECT_BITS=$clog2(MWIDTH_BYTES);
localparam SEGMENT_SELECT_BITS=BYTE_SELECT_BITS-ALIGNMENT_ABITS;
localparam PAGE_SELECT_BITS=AWIDTH-BYTE_SELECT_BITS;

// Constants
localparam REQUEST_FIFO_DEPTH=2*KERNEL_SIDE_MEM_LATENCY;

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
wire [PAGE_SELECT_BITS-1:0] page_addr;
wire [SEGMENT_SELECT_BITS:0] rf_data_in;
wire [BYTE_SELECT_BITS-1:0] byte_addr;
wire next_new_page;
wire c_stall;
wire c_new_page;
wire [PAGE_SELECT_BITS-1:0] c_req_addr;
wire c_req_valid;
wire rf_full;
wire rf_valid;
wire [SEGMENT_SELECT_BITS:0] rf_data;
wire rf_next_valid;
wire [SEGMENT_SELECT_BITS:0] rf_next_data;
wire rf_stall_in;
wire rm_stall;
wire rm_valid;
wire rm_active;
wire [MWIDTH-1:0] rm_data;
wire rm_stall_in;

// Coalescer - Groups subsequent requests together if they are compatible and 
// the avalon bus is stalled.
assign page_addr = i_address[AWIDTH-1:BYTE_SELECT_BITS];
basic_coalescer #(
    .PAGE_ADDR_WIDTH(PAGE_SELECT_BITS),
    .TIMEOUT(MWIDTH/WIDTH)
) coalescer (
    .clk(clk),
    .reset(reset),
    .i_page_addr(page_addr),
    .i_valid(i_valid && !rf_full),
    .o_stall(c_stall),
    .o_new_page(c_new_page),
    .o_req_addr(c_req_addr),
    .o_req_valid(c_req_valid),
    .i_stall(rm_stall)
);

// Response FIFO - Buffers the requests so they can be extracted from the 
// wider memory bus.  Stores the segment address to extract the requested
// word from the response data, and a bit indicating if the request comes
// from a new page.
generate if(SEGMENT_SELECT_BITS > 0)
begin
   wire [SEGMENT_SELECT_BITS-1:0] segment_addr;
   assign segment_addr = i_address[BYTE_SELECT_BITS-1:ALIGNMENT_ABITS];
   assign rf_data_in = {c_new_page, segment_addr};
   assign byte_addr = (rf_data[SEGMENT_SELECT_BITS-1:0] << ALIGNMENT_ABITS);
end
else
begin
   assign rf_data_in = c_new_page;
   assign byte_addr = {BYTE_SELECT_BITS{1'b0}};
end
endgenerate
lookahead_fifo #(
    .WIDTH( SEGMENT_SELECT_BITS + 1 ),
    .DEPTH( REQUEST_FIFO_DEPTH )
) request_fifo (
    .clk(clk), 
    .reset(reset),
    .i_data( rf_data_in ),
    .i_valid( i_valid && !c_stall ),
    .o_full(rf_full),
    .i_stall(rf_stall_in),
    .o_valid(rf_valid),
    .o_data(rf_data),
    .o_next_valid(rf_next_valid),
    .o_next_data(rf_next_data)
);

// Read master - Handles pipelined read transactions through MM-Avalon.
lsu_pipelined_read #(
    .AWIDTH( AWIDTH ),
    .WIDTH_BYTES( MWIDTH_BYTES ),
    .MWIDTH_BYTES( MWIDTH_BYTES ),
    .ALIGNMENT_ABITS( BYTE_SELECT_BITS ),
    .KERNEL_SIDE_MEM_LATENCY( KERNEL_SIDE_MEM_LATENCY ),
    .USEOUTPUTFIFO(1),
    .USEINPUTFIFO( 1 ),       // Add the latency adjusting input fifos
    .PIPELINE_INPUT( 1 ) // Let's add a pipline input to the input side just to help with Fmax
) read_master (
    .clk(clk),
    .resetn(~reset),
    .o_stall(rm_stall),
    .i_valid(c_req_valid),
    .i_address({c_req_addr, {BYTE_SELECT_BITS{1'b0}}}),
    .i_stall(rm_stall_in),
    .o_valid(rm_valid),
    .o_active(rm_active),
    .o_readdata(rm_data),
    .avm_address(avm_address),
    .avm_read(avm_read),
    .avm_readdata(avm_readdata),
    .avm_waitrequest(avm_waitrequest),
    .avm_byteenable(avm_byteenable),
    .avm_readdatavalid(avm_readdatavalid)
);

// Control logic
// Highest bit of rf_next_data indicates whether this is a new avalon request
// (new page) or was coalesced into the previous request.
assign next_new_page = rf_next_data[SEGMENT_SELECT_BITS];
assign rm_stall_in = (!next_new_page && rf_next_valid) || rf_stall_in;
assign rf_stall_in = i_stall || !rm_valid;

// Output MUX
assign o_readdata = rm_data[8*byte_addr +: WIDTH];

// External control signals
assign o_stall = c_stall || rf_full;
assign o_valid = rm_valid && rf_valid;

assign o_active=rf_valid | rm_active;

endmodule

/******************************************************************************/

// Basic coalesced write unit:
//    Accept write requests on the upstream interface.  The avalon spec does
//    not allow a request to change while it is being stalled, so the current
//    request is registered in an output register stage and not modified.
//    Subsequent requests are coalesced together as long as the output register
//    stage is occupied (i.e. the avalon bus is stalling).
//
// TODO: The byte enable format is not actually compliant with the 
// Avalon spec.  Essentially we should not enable non-adjacent words in a write
// request.  This is OK for the DDR Memory Controller as it accepts our
// non-compliant format.  This needs to be investigated further.
module lsu_basic_coalesced_write
(
    clk, reset, o_stall, i_valid, i_address, i_writedata, i_stall, o_valid, i_byteenable,
    o_active, //Debugging signal
    avm_address, avm_write, avm_writeack, avm_writedata, avm_byteenable, avm_waitrequest
);

/*************
* Parameters *
*************/
parameter AWIDTH=32;            // Address width (32-bits for Avalon)
parameter WIDTH_BYTES=4;        // Width of the memory access (bytes)
parameter MWIDTH_BYTES=32;      // Width of the global memory bus (bytes)
parameter ALIGNMENT_ABITS=2;    // Request address alignment (address bits)
parameter KERNEL_SIDE_MEM_LATENCY=32;    // Memory latency in cycles
parameter USE_BYTE_EN = 0;


// Derived parameters
localparam WIDTH=8*WIDTH_BYTES;
localparam MWIDTH=8*MWIDTH_BYTES;
localparam BYTE_SELECT_BITS=$clog2(MWIDTH_BYTES);
localparam SEGMENT_SELECT_BITS=BYTE_SELECT_BITS-ALIGNMENT_ABITS;
localparam PAGE_SELECT_BITS=AWIDTH-BYTE_SELECT_BITS;
localparam NUM_SEGMENTS=2**SEGMENT_SELECT_BITS;
localparam SEGMENT_WIDTH=8*(2**ALIGNMENT_ABITS);
localparam SEGMENT_WIDTH_BYTES=(2**ALIGNMENT_ABITS);

// Constants
localparam COUNTER_WIDTH=8;      // Determines the max writes 'in-flight'

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

// Downstream interface
input i_stall;
output o_valid;
output o_active;

// Avalon interface
output [AWIDTH-1:0] avm_address;
output avm_write;
input avm_writeack;

output [MWIDTH-1:0] avm_writedata;
output [MWIDTH_BYTES-1:0] avm_byteenable;
input avm_waitrequest;

input [WIDTH_BYTES-1:0] i_byteenable;

/***************
* Architecture *
***************/
wire input_accepted;
wire output_acknowledged;
wire write_accepted;
wire [PAGE_SELECT_BITS-1:0] page_addr;
wire c_new_page;
wire [PAGE_SELECT_BITS-1:0] c_req_addr;
wire c_req_valid;
wire c_stall;
reg [COUNTER_WIDTH-1:0] occ_counter;
wire [1:0] occ_counter_update;
wire [COUNTER_WIDTH-1:0] occ_counter_update_extended;
reg [COUNTER_WIDTH-1:0] ack_counter;
reg [COUNTER_WIDTH-1:0] next_counter;
reg [COUNTER_WIDTH-1:0] or_next_counter;
wire [COUNTER_WIDTH-1:0] rf_count;
wire rf_read;
wire rf_empty;
wire rf_full;
reg [MWIDTH-1:0] wm_writedata;
reg [MWIDTH_BYTES-1:0] wm_byteenable;
reg [MWIDTH-1:0] wm_wide_wdata;
reg [MWIDTH_BYTES-1:0] wm_wide_be;
reg [MWIDTH-1:0] wm_wide_bite;
wire or_ready;
reg or_write;
reg [AWIDTH-1:0] or_address;
reg [MWIDTH-1:0] or_writedata;
reg [MWIDTH_BYTES-1:0] or_byteenable;
wire oc_full;

// Output register stage to store the next request
assign or_ready = !or_write || !avm_waitrequest;
always@(posedge clk or posedge reset)
begin
    if(reset)
    begin
        or_write <= 1'b0;
        or_address <= {AWIDTH{1'b0}};
        or_writedata <= {MWIDTH{1'b0}};
        or_byteenable <= {MWIDTH_BYTES{1'b0}};
        or_next_counter <= {COUNTER_WIDTH{1'b0}};
    end
    else
    begin
        if(or_ready)
        begin
            or_write <= c_req_valid;
            or_address <= (c_req_addr << BYTE_SELECT_BITS);
            or_writedata <= wm_writedata;
            or_byteenable <= wm_byteenable;
            or_next_counter <= next_counter;
        end
    end
end
assign avm_address = or_address;
assign avm_write = or_write;
assign avm_writedata = or_writedata;
assign avm_byteenable = or_byteenable;

// The address components
assign page_addr = i_address[AWIDTH-1:BYTE_SELECT_BITS];

// Coalescer - Groups subsequent requests together if they are compatible
// and the output register stage is stalled
basic_coalescer #(
    .PAGE_ADDR_WIDTH(PAGE_SELECT_BITS),
    .TIMEOUT(MWIDTH/WIDTH)
) coalescer (
    .clk(clk),
    .reset(reset),
    .i_page_addr(page_addr),
    .i_valid(i_valid && !oc_full),
    .o_stall(c_stall),
    .o_new_page(c_new_page),
    .o_req_addr(c_req_addr),
    .o_req_valid(c_req_valid),
    .i_stall(!or_ready)
);

// Writedata MUX
generate if( SEGMENT_SELECT_BITS > 0 )
begin
   wire [SEGMENT_SELECT_BITS-1:0] segment_select;
   assign segment_select = i_address[BYTE_SELECT_BITS-1:ALIGNMENT_ABITS];
   always@(*)
   begin
      wm_wide_wdata = {MWIDTH{1'bx}};
      wm_wide_wdata[segment_select*SEGMENT_WIDTH +: WIDTH] = i_writedata;

      wm_wide_be = {MWIDTH_BYTES{1'b0}};
      wm_wide_be[segment_select*SEGMENT_WIDTH_BYTES +: WIDTH_BYTES] = USE_BYTE_EN ? i_byteenable : {WIDTH_BYTES{1'b1}};

      wm_wide_bite = {MWIDTH{1'b0}};
      wm_wide_bite[segment_select*SEGMENT_WIDTH +: WIDTH] = {WIDTH{1'b1}};
   end
end
else
begin
   always@(*)
   begin
      wm_wide_wdata = {MWIDTH{1'bx}};
      wm_wide_wdata[0 +: WIDTH] = i_writedata;

      wm_wide_be = {MWIDTH_BYTES{1'b0}};
      wm_wide_be[0 +: WIDTH_BYTES] =  USE_BYTE_EN ? i_byteenable : {WIDTH_BYTES{1'b1}}  ;

      wm_wide_bite = {MWIDTH{1'b0}};
      wm_wide_bite[0 +: WIDTH] = {WIDTH{1'b1}};
   end
end
endgenerate

// Track the current write burst data - coalesce writes together until the 
// output registers are ready for a new request.
always@(posedge clk or posedge reset)
begin
    if(reset)
    begin
        wm_writedata <= {MWIDTH{1'b0}};
        wm_byteenable <= {MWIDTH_BYTES{1'b0}};
    end
    else
    begin
        if(c_new_page)
        begin
            wm_writedata <= wm_wide_wdata;
            wm_byteenable <= wm_wide_be;
        end
        else if(input_accepted)
        begin
            wm_writedata <= (wm_wide_wdata & wm_wide_bite) | (wm_writedata & ~wm_wide_bite);
            wm_byteenable <= wm_wide_be | wm_byteenable;
        end
    end
end

// Write size tracker - track the number of threads represented by each pending write request
acl_ll_fifo #(
  .WIDTH(COUNTER_WIDTH),
  .DEPTH(KERNEL_SIDE_MEM_LATENCY+1)
) req_fifo (
  .clk(clk),
  .reset(reset),
  .data_in( or_next_counter ),
  .data_out( rf_count ),
  .write( write_accepted && (!rf_empty || !avm_writeack) ),
  .read( rf_read ),
  .empty( rf_empty ),
  .full( rf_full )
);
assign rf_read = avm_writeack && !rf_empty;

// Occupancy counter - track the number of successfully transmitted writes
// and the number of writes pending in the next request.
//    occ_counter - the total occupancy (in threads) of the unit
//    next_counter - the number of threads coalesced into the next transfer
//    ack_counter - the number of pending threads with write completion acknowledged
assign input_accepted = i_valid && !o_stall;
assign write_accepted = avm_write && !avm_waitrequest;
assign output_acknowledged = o_valid && !i_stall;
assign occ_counter_update = input_accepted - output_acknowledged;
assign occ_counter_update_extended = $signed(occ_counter_update);
always@(posedge clk or posedge reset)
begin
   if(reset == 1'b1)
   begin
      occ_counter <= {COUNTER_WIDTH{1'b0}};
      ack_counter <= {COUNTER_WIDTH{1'b0}};
      next_counter <= {COUNTER_WIDTH{1'b0}};
   end
   else
   begin
      occ_counter <= occ_counter + occ_counter_update_extended;
      next_counter <= input_accepted + ((c_req_valid & or_ready) ? {COUNTER_WIDTH{1'b0}} : next_counter);
      ack_counter <= ack_counter + ({COUNTER_WIDTH{avm_writeack}} & ( rf_empty ? or_next_counter : rf_count )) - output_acknowledged;
   end
end
assign oc_full = (occ_counter == {COUNTER_WIDTH{1'b1}});

// Pipeline control signals
assign o_stall = oc_full || c_stall || rf_full;
assign o_valid = (ack_counter > {COUNTER_WIDTH{1'b0}});
assign o_active = (occ_counter != {COUNTER_WIDTH{1'b0}});

endmodule

/******************************************************************************/

/* RESPONSE FIFO */
// lookahead_fifo - A simple sc_fifo instantiation with an additional 
// shift-register stage at the end to provide access to the next two data
// items.
module lookahead_fifo
(
    clk, reset, i_data, i_valid, o_full, i_stall, o_valid, o_data, 
    o_next_valid, o_next_data
);

parameter WIDTH=32;
parameter DEPTH=32;

input clk;
input reset;

input [WIDTH-1:0] i_data;
input i_valid;
output o_full;

input i_stall;
output reg o_valid;
output reg [WIDTH-1:0] o_data;
output o_next_valid;
output [WIDTH-1:0] o_next_data;

wire sr_ready;

// Fifo
acl_data_fifo #(
    .DATA_WIDTH(WIDTH),
    .DEPTH(DEPTH),
    .IMPL("ram_plus_reg")
) req_fifo (
    .clock(clk),
    .resetn(!reset),
    .data_in( i_data ),
    .data_out( o_next_data ),
    .valid_in( i_valid ),
    .valid_out( o_next_valid ),
    .stall_in( !sr_ready ),
    .stall_out( o_full )
);

// Shift-reg
assign sr_ready = !o_valid || !i_stall;
always@(posedge clk or posedge reset)
begin
    if(reset)
    begin
        o_data <= {WIDTH{1'b0}};
        o_valid <= 1'b0;
    end
    else
    begin
        o_valid <= sr_ready ? o_next_valid : o_valid;
        o_data <= sr_ready ? o_next_data : o_data;
    end
end

endmodule

/* BASIC COALESCING MODULE */
// basic_coalescer - Accept new inputs as long as the unit is not stalled,
// or the new request can be coalesced with the pending (stalled) request.
module basic_coalescer
( 
    clk, reset, i_page_addr, i_valid, o_stall, o_new_page, o_req_addr, 
    o_req_valid, i_stall 
);

parameter PAGE_ADDR_WIDTH=32;
parameter TIMEOUT=8;  // power of 2

input clk;
input reset;

input [PAGE_ADDR_WIDTH-1:0] i_page_addr;
input i_valid;
output o_stall;
output o_new_page;

output [PAGE_ADDR_WIDTH-1:0] o_req_addr;
output o_req_valid;
input i_stall;

reg [PAGE_ADDR_WIDTH-1:0] page_addr;
reg valid;
wire ready;
wire waiting;
wire match;

wire timeout;
reg [$clog2(TIMEOUT):0] timeout_counter;

assign timeout = timeout_counter[$clog2(TIMEOUT)];

// Internal signal logic
assign match = (i_page_addr == page_addr);
assign ready = !valid || !(i_stall || waiting);
assign waiting = !timeout && (!i_valid || match);

always@(posedge clk or posedge reset)
begin
    if(reset)
    begin
        page_addr <= {PAGE_ADDR_WIDTH{1'b0}};
        valid <= 1'b0;
        timeout_counter <= '0;
    end
    else
    begin
        page_addr <= ready ? i_page_addr : page_addr;
        valid <= ready ? i_valid : valid;

        if( i_valid )
            timeout_counter <= 'd1;
        else if( valid && !timeout )
            timeout_counter <= timeout_counter + 'd1;
    end
end

// Outputs
assign o_stall = i_valid && !match && !ready;
assign o_new_page = ready;
assign o_req_addr = page_addr;
assign o_req_valid = valid && !waiting;

endmodule

