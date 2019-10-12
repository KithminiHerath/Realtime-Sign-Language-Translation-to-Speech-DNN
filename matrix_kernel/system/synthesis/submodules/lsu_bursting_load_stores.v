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

module lsu_bursting_read
(
    clk, clk2x, reset, flush, i_nop, o_stall, i_valid, i_address, i_stall, o_valid, o_readdata,
    o_active, //Debugging signal
    avm_address, avm_read, avm_readdata, avm_waitrequest, avm_byteenable,
    avm_readdatavalid,
    avm_burstcount,

    // Profiling
    extra_unaligned_reqs,
    req_cache_hit_count
);

/*************
* Parameters *
*************/
parameter AWIDTH=32;                           // Address width (32-bits for Avalon)
parameter WIDTH_BYTES=8;                       // Width of the memory access (bytes)
parameter MWIDTH_BYTES=64;                     // Width of the global memory bus (bytes)
parameter ALIGNMENT_ABITS=$clog2(WIDTH_BYTES); // Request address alignment (address bits)
parameter DEVICE = "Stratix V";                // DEVICE
parameter BURSTCOUNT_WIDTH=5;                  // MAX BURST = 2**(BURSTCOUNT_WIDTH-1)
parameter KERNEL_SIDE_MEM_LATENCY=1;           // Effective Latency in cycles as seen by the kernel pipeline
parameter MEMORY_SIDE_MEM_LATENCY = 1;         // Latency in cycles between LSU and memory
parameter MAX_THREADS=64;                      // Maximum # of threads to group into a burst request
parameter TIME_OUT=8;                          // Time out counter max
parameter USECACHING = 0;                      // Enable internal cache
parameter CACHE_SIZE_N=1024;                   // Cache depth (width = WIDTH_BYTES)
parameter ACL_PROFILE = 0;                     // Profiler
parameter HIGH_FMAX = 1;                       // Add pipeline to io if set to 1
parameter UNALIGNED = 0;                       // Output word unaligned

/*****************
* Local Parameters *
*****************/
localparam MAX_BURST = 2**(BURSTCOUNT_WIDTH-1);
localparam WIDTH=8*WIDTH_BYTES;
localparam MWIDTH=8*MWIDTH_BYTES;
localparam A_BYTES = 2**ALIGNMENT_ABITS;
localparam WORD_BYTES = (WIDTH_BYTES >= A_BYTES & (UNALIGNED == 0))? WIDTH_BYTES : A_BYTES;
localparam NUM_WORD = MWIDTH_BYTES / WORD_BYTES;
localparam MB_W=$clog2(MWIDTH_BYTES);
localparam OB_W = $clog2(WIDTH_BYTES);
localparam PAGE_ADDR_WIDTH = AWIDTH - MB_W;
localparam OFFSET_WIDTH = $clog2(NUM_WORD);
localparam CACHE_ADDR_W=$clog2(CACHE_SIZE_N);
localparam CACHE_BASE_ADDR_W = AWIDTH-MB_W-CACHE_ADDR_W;
localparam UNALIGNED_DIV_ALIGN = WIDTH_BYTES / A_BYTES;
localparam UNALIGNED_SELECTION_BITS=$clog2(UNALIGNED_DIV_ALIGN);

// Standard global signals
input clk;
input clk2x;
input reset;
input flush;
input i_nop;

// Upstream interface
output logic o_stall;
input i_valid;
input [AWIDTH-1:0] i_address;

// Downstream interface
input  i_stall;
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
output [BURSTCOUNT_WIDTH-1:0] avm_burstcount;

// Profiling
output logic extra_unaligned_reqs;
output logic req_cache_hit_count;

// internal signals
logic stall_pre;
wire  reg_valid;
wire  reg_nop;
wire  [AWIDTH-1:0] reg_address;

// registed to help P&R
logic  R_valid, R_nop;
wire [AWIDTH-1:0] addr_next_wire;
logic  [AWIDTH-1:0] R_addr, R_addr_next, R_addr_next_hold;
// cache status
reg  [CACHE_BASE_ADDR_W:0] cache [CACHE_SIZE_N] /* synthesis ramstyle = "M20K" */;
wire [1:0] in_cache_pre;
logic [CACHE_BASE_ADDR_W-1:0] cached_tag [2];
wire [CACHE_BASE_ADDR_W-1:0] R_tag [2];
wire [CACHE_ADDR_W-1:0] rd_c_index [2];
wire [CACHE_ADDR_W-1:0] wr_c_index;
logic cached_tag_valid [2];
wire tag_match [2];
wire consecutive;
reg  cache_ready;
logic [1:0] in_cache;
wire [MB_W - (MB_W ? 1 : 0) : 0] byte_offset;
reg  include_2nd_part;
logic update_cache;
logic [CACHE_BASE_ADDR_W-1:0] new_tag;
logic  issue_2nd_word;
reg  issue_2nd_hold;
logic  need_2_page;
wire stall_int;
wire need_2_cc;
wire [UNALIGNED_SELECTION_BITS-1:0] shift;
logic [AWIDTH-1:0] lsu_i_address;
reg  p_valid;
reg  [AWIDTH-1:0] p_addr;
reg  [1:0] R_consecutive;
reg  [63:0] non_align_hit_cache;
// coalesced addr
wire [BURSTCOUNT_WIDTH-1:0]c_burstcount;
wire [PAGE_ADDR_WIDTH-1:0] c_page_addr;
wire c_req_valid;
wire c_new_page;
logic [OFFSET_WIDTH-1 : 0] p_offset, c_word_offset;
logic p_offset_valid;
reg [CACHE_ADDR_W-1:0] R_cache_addr;
// fifo
reg fifo_din_en;
reg [1:0] fi_in_cache;
reg [CACHE_ADDR_W-1:0] fi_cached_addr;
reg [UNALIGNED_SELECTION_BITS-1:0] fi_shift;
reg fi_second, fi_2nd_valid;
reg [UNALIGNED_SELECTION_BITS-1:0] R_shift;
reg [MB_W - (MB_W ? 1 : 0) : 0] fi_byte_offset;
wire p_ae;

generate
  if(HIGH_FMAX) begin: GEN_PIPE_INPUT
    acl_io_pipeline #(
      .WIDTH(1+AWIDTH)
    ) in_pipeline (
      .clk(clk),
      .reset(reset),
      .i_stall(stall_pre),
      .i_valid(i_valid),
      .i_data({i_nop, i_address}),
      .o_stall(o_stall),
      .o_valid(reg_valid),
      .o_data({reg_nop, reg_address})
    );
  end
  else begin : GEN_FAST_INPUT
    assign {reg_valid, reg_nop, reg_address} = {i_valid, i_nop, i_address};
  end

  if(USECACHING) begin : GEN_ENABLE_CACHE
    reg R_flush;
    reg [CACHE_ADDR_W:0] flush_cnt;
    reg cache_status_ready;

    assign rd_c_index[0] = R_addr[CACHE_ADDR_W-1+MB_W:MB_W];
    assign rd_c_index[1] = R_addr_next[CACHE_ADDR_W-1+MB_W:MB_W];
    assign {cached_tag_valid[0], cached_tag[0]} = cache[rd_c_index[0]];
    assign {cached_tag_valid[1], cached_tag[1]} = cache[rd_c_index[1]];
    assign wr_c_index = lsu_i_address[CACHE_ADDR_W-1+MB_W:MB_W];
    assign R_tag[0] = R_addr[AWIDTH-1:MB_W+CACHE_ADDR_W];
    assign R_tag[1] = R_addr_next[AWIDTH-1:MB_W+CACHE_ADDR_W];
    assign tag_match[0] = cached_tag[0] == R_tag[0] & cached_tag_valid[0] === 1'b1;
    assign tag_match[1] = cached_tag[1] == R_tag[1] & cached_tag_valid[1] === 1'b1;
    assign in_cache_pre[0] = tag_match[0] & !issue_2nd_word & cache_ready;
    assign in_cache_pre[1] = tag_match[1] & !issue_2nd_word & cache_ready;
    assign new_tag = lsu_i_address[AWIDTH-1:MB_W+CACHE_ADDR_W];
    assign update_cache = R_valid & !R_nop | issue_2nd_word;

    always @(posedge clk or posedge reset) begin
      if(reset) cache_status_ready <= 1'b0;
      else cache_status_ready <= flush_cnt[CACHE_ADDR_W];
    end

    always @ (posedge clk)  begin
      R_flush <= flush;
      if(flush & !R_flush)  flush_cnt <= '0;
      else if(!flush_cnt[CACHE_ADDR_W]) flush_cnt <= flush_cnt + 1'b1;
      cache_ready <= flush_cnt[CACHE_ADDR_W];

      if( (!flush_cnt[CACHE_ADDR_W]) || update_cache) begin
        cache[(!flush_cnt[CACHE_ADDR_W]) ? flush_cnt : wr_c_index] <=
	                  (!flush_cnt[CACHE_ADDR_W]) ? '0 : {1'b1, new_tag};
      end

      in_cache[0] <= R_valid & (in_cache_pre[0] | R_nop) & !issue_2nd_word;
      in_cache[1] <= UNALIGNED? R_valid & (in_cache_pre[1] | R_nop) & !issue_2nd_word & need_2_page : 1'b0;

      include_2nd_part <= issue_2nd_word | in_cache_pre[1] & need_2_page;
      p_valid <= issue_2nd_word | R_valid & !in_cache_pre[0] & !R_nop; // not include nop
      p_offset_valid <= issue_2nd_word | R_valid;
      p_addr <= lsu_i_address;
      R_cache_addr <= lsu_i_address[MB_W+CACHE_ADDR_W-1:MB_W];
    end

    if(OFFSET_WIDTH > 0)  begin
      always @ (posedge clk)  begin
        p_offset <= R_addr[MB_W-1:MB_W-OFFSET_WIDTH];
      end
    end
    if(ACL_PROFILE == 1) begin
      assign req_cache_hit_count = ((|fi_in_cache) & fifo_din_en);
    end
    else
    begin
      assign req_cache_hit_count = 1'b0;
    end
  end // end GEN_ENABLE_CACHE
  else begin : GEN_DISABLE_CACHE
    assign req_cache_hit_count = 1'b0;
    assign in_cache_pre = 2'b0;
    assign in_cache = 2'b0;
    assign include_2nd_part = issue_2nd_word;
    assign p_valid = issue_2nd_word | R_valid & !R_nop; // not include nop
    assign p_offset_valid = issue_2nd_word | R_valid;
    assign p_addr = lsu_i_address;
    if(OFFSET_WIDTH > 0)  begin
      assign p_offset = R_addr[MB_W-1:MB_W-OFFSET_WIDTH];
    end
  end // end GEN_DISABLE_CACHE


  if (UNALIGNED) begin :  GEN_UNALIGN
    assign addr_next_wire[AWIDTH-1:AWIDTH-PAGE_ADDR_WIDTH] = reg_address[AWIDTH-1:AWIDTH-PAGE_ADDR_WIDTH]+1'b1;
    assign addr_next_wire[AWIDTH-PAGE_ADDR_WIDTH-1:0] = '0;
    // Look at the higher bits to determine how much we need to shift the two aligned accesses
    wire [UNALIGNED_SELECTION_BITS-1:0] temp = NUM_WORD - R_addr[AWIDTH-1:ALIGNMENT_ABITS];
    assign shift = UNALIGNED_DIV_ALIGN - temp;
    assign consecutive = reg_nop | reg_address[AWIDTH-1:AWIDTH-PAGE_ADDR_WIDTH] == R_addr_next[AWIDTH-1:AWIDTH-PAGE_ADDR_WIDTH];

    // When do we need to issue the 2nd word ?
    //     The previous address needed a 2nd page and
    //     [1] the current requested address isn't in the (previous+1)th page and
    //     [2] The second page is not in the cache
    assign need_2_cc = need_2_page & !in_cache_pre[1] & R_valid & (!issue_2nd_word | R_consecutive[0]); // need 2 clock cycles to combine segments from 2 pages
    // simulation only
    assign byte_offset = MB_W ? (stall_pre? R_addr[MB_W-1:0] : reg_address[MB_W-1:0]) : 0;
    always @(posedge clk or posedge reset) begin
      if(reset) begin
        issue_2nd_word <= 1'b0;
        R_consecutive <= 'x;
        stall_pre <= 1'b0;
        issue_2nd_hold <= 'x;
      end
      else begin
        issue_2nd_word <= need_2_cc;
        if(!stall_pre | issue_2nd_word) issue_2nd_hold <= need_2_cc;

        R_consecutive[0] <= reg_valid & !stall_int & consecutive & need_2_cc;
        R_consecutive[1] <= R_consecutive[0];
        stall_pre <= (stall_int | need_2_cc & reg_valid & !consecutive);
      end
    end

    always @(posedge clk) begin
      if(reg_valid & !stall_pre) need_2_page <= !reg_nop & (reg_address[MB_W-1:0] + WIDTH_BYTES) > MWIDTH_BYTES;
      if(reg_valid & !stall_pre & !reg_nop) begin
        R_addr <= reg_address;
        R_addr_next <= addr_next_wire;
      end
      R_addr_next_hold <= R_addr_next;
      if(!issue_2nd_word | !stall_pre) begin
        R_valid <= reg_valid & !stall_pre;
        R_nop <= reg_nop;
      end
    end

    if(ACL_PROFILE == 1) begin
      assign extra_unaligned_reqs = need_2_cc & reg_valid & !consecutive;
      always @(posedge clk or posedge reset) begin
        if(reset) begin
          non_align_hit_cache <= '0;
        end
        else begin
          non_align_hit_cache <= non_align_hit_cache + (need_2_page & in_cache_pre[1] & R_valid & (!issue_2nd_word | R_consecutive[0]) & reg_valid & !consecutive);
        end
      end
    end // end ACL_PROFILE == 1

  end // end GEN_UNALIGN
  else begin :  GEN_ALIGN
    assign issue_2nd_word = 1'b0;
    assign need_2_page = 1'b0;
    assign R_addr = reg_address;
    assign R_valid = reg_valid & !stall_int;
    assign R_nop = reg_nop;
    assign stall_pre = stall_int;
  end // end GEN_ALIGN

endgenerate

assign lsu_i_address = issue_2nd_word ? R_addr_next_hold : R_addr;

always @(posedge clk) begin
  c_word_offset <= p_offset;
  R_shift <= need_2_page? shift : '0;
  fifo_din_en <= (|in_cache) | p_offset_valid;
  {fi_in_cache, fi_cached_addr, fi_second} <= {in_cache, R_cache_addr, include_2nd_part};
  fi_shift <= USECACHING? R_shift : (need_2_page? shift : '0);
  fi_2nd_valid <= USECACHING? R_consecutive[1] : R_consecutive[0];
end

generate
if (MB_W) begin : ASSIGN_BYTE_OFFSET
  always @(posedge clk) begin
    if(!include_2nd_part) fi_byte_offset <= p_addr[MB_W-1:0];
  end
end else begin : ZERO_BYTE_OFFSET
  always @(*) begin
    fi_byte_offset = 0;
  end
end
endgenerate

acl_stall_free_coalescer #(
  .AW(AWIDTH),
  .PAGE_AW(PAGE_ADDR_WIDTH),
  .MAX_BURST(MAX_BURST),
  .TIME_OUT(TIME_OUT),
  .CACHE_LAST(USECACHING),
  .MAX_THREAD(MAX_THREADS),
  .DISABLE_COALESCE(0)
) coalescer(
  .clk(clk),
  .reset(reset),
  .i_valid(p_valid),
  .i_addr(p_addr),
  .i_empty(p_ae),
  .o_page_addr(c_page_addr),
  .o_page_addr_valid(c_req_valid),
  .o_num_burst(c_burstcount),
  .o_new_page(c_new_page)
);


lsu_bursting_pipelined_read #(
  .INPUT_AW(PAGE_ADDR_WIDTH),
  .AWIDTH(AWIDTH),
  .WIDTH(WIDTH),
  .MWIDTH(MWIDTH),
  .MEMORY_SIDE_MEM_LATENCY(MEMORY_SIDE_MEM_LATENCY),
  .DEVICE(DEVICE),
  .CACHE_SIZE_N(CACHE_SIZE_N),
  .USECACHING(USECACHING),
  .UNALIGNED(UNALIGNED),
  .UNALIGNED_SHIFT_WIDTH(UNALIGNED_SELECTION_BITS),
  .MAX_BURST(MAX_BURST),
  .INCLUDE_BYTE_OFFSET(0), // sim-only
  .ALIGNMENT_ABITS(ALIGNMENT_ABITS)
) pipelined_read(
  .clk              (clk),
  .reset            (reset),
  .i_address        (c_page_addr),
  .i_addr_valid     (c_req_valid),
  .i_burst_count    (c_burstcount),
  .i_new_page       (c_new_page),
  .i_word_offset    (c_word_offset),
  .i_byte_offset    (fi_byte_offset),
  .i_in_cache       (fi_in_cache),
  .i_cache_addr     (fi_cached_addr),
  .i_shift          (fi_shift),
  .i_second         (fi_second),
  .i_2nd_valid      (fi_2nd_valid), // has two segments' info in one cc
  .i_word_offset_valid(fifo_din_en),
  .i_stall          (i_stall),
  .o_ae             (p_ae),
  .o_empty          (),
  .o_readdata       (o_readdata),
  .o_valid          (o_valid),
  .o_stall          (stall_int),
  .avm_address      (avm_address),
  .avm_read         (avm_read),
  .avm_readdata     (avm_readdata),
  .avm_waitrequest  (avm_waitrequest),
  .avm_byteenable   (avm_byteenable),
  .avm_readdatavalid(avm_readdatavalid),
  .avm_burstcount   (avm_burstcount)
);
endmodule



module acl_io_pipeline #(
  parameter WIDTH = 1
)(
  input  clk,
  input  reset,
  input  i_stall,
  input  i_valid,
  input  [WIDTH-1:0] i_data,
  output o_stall,
  output reg o_valid,
  output reg [WIDTH-1:0] o_data
);

reg R_valid;
assign o_stall = i_stall & R_valid;

always@(posedge clk) begin
  if(!o_stall) {o_valid, o_data} <= {i_valid, i_data};
end

always@(posedge clk or posedge reset)begin
  if(reset) R_valid <= 1'b0;
  else if(!o_stall) R_valid <= i_valid;
end
endmodule


module lsu_bursting_pipelined_read
(
    clk, reset,
    i_in_cache,
    i_cache_addr,
    i_addr_valid,
    i_address,
    i_burst_count,
    i_word_offset,
    i_byte_offset,
    i_shift,
    i_second,
    i_2nd_valid,
    i_word_offset_valid,
    i_new_page,
    o_readdata,
    o_valid,
    i_stall,
    o_stall,
    o_empty,
    o_ae,
    avm_address,
    avm_read,
    avm_readdata,
    avm_waitrequest,
    avm_byteenable,
    avm_burstcount,
    avm_readdatavalid
);

parameter INPUT_AW = 32;
parameter AWIDTH=32;
parameter WIDTH=32;
parameter MWIDTH=512;
parameter MAX_BURST = 16;
parameter ALIGNMENT_ABITS=2;
parameter DEVICE = "Stratix V";
parameter MEMORY_SIDE_MEM_LATENCY=160;
parameter USECACHING = 0;
parameter CACHE_SIZE_N = 1024;
parameter UNALIGNED = 0;
parameter UNALIGNED_SHIFT_WIDTH = 0;
parameter INCLUDE_BYTE_OFFSET = 0; // testing purpose

localparam ALIGNMENT_WIDTH = 2**ALIGNMENT_ABITS * 8;
localparam BYTE_SELECT_BITS=$clog2(MWIDTH/8);
localparam WORD_WIDTH = (WIDTH >= ALIGNMENT_WIDTH & (UNALIGNED == 0))? WIDTH : ALIGNMENT_WIDTH;
localparam NUM_WORD = MWIDTH / WORD_WIDTH;
localparam OFFSET_WIDTH = (NUM_WORD==1)? 1 : $clog2(NUM_WORD);
localparam OFFSET_FIFO_DEPTH = (MEMORY_SIDE_MEM_LATENCY <= 246)? 256 : MEMORY_SIDE_MEM_LATENCY + 10;
localparam WIDE_FIFO_DEPTH = OFFSET_FIFO_DEPTH;
localparam REQUEST_FIFO_DEPTH = OFFSET_FIFO_DEPTH;
localparam WIDE_FIFO_DEPTH_THRESH = MEMORY_SIDE_MEM_LATENCY;
localparam WIDE_FIFO_AW = $clog2(WIDE_FIFO_DEPTH);
localparam BURST_CNT_WIDTH = (MAX_BURST == 1)? 1 : $clog2(MAX_BURST + 1);
localparam REQUEST_FIFO_AW = $clog2(REQUEST_FIFO_DEPTH);
localparam OFFSET_FIFO_AW = $clog2(OFFSET_FIFO_DEPTH);
localparam REQUEST_FIFO_WIDTH = INPUT_AW + BURST_CNT_WIDTH;
localparam CACHE_SIZE_LOG2N=$clog2(CACHE_SIZE_N);
localparam CACHE_ADDR_W=$clog2(CACHE_SIZE_N);
localparam OFFSET_FIFO_WIDTH = 1 + ((NUM_WORD > 1)? OFFSET_WIDTH : 0) + (USECACHING? 1 + CACHE_ADDR_W : 0) + (UNALIGNED? UNALIGNED_SHIFT_WIDTH + 3 : 0) + (INCLUDE_BYTE_OFFSET? BYTE_SELECT_BITS : 0);

// I/O
input clk, reset;
input [UNALIGNED:0] i_in_cache;
input [CACHE_ADDR_W-1:0] i_cache_addr;
input [INPUT_AW-1:0] i_address;
input [BURST_CNT_WIDTH-1:0] i_burst_count;
input [OFFSET_WIDTH-1:0] i_word_offset;
input [BYTE_SELECT_BITS-1:0] i_byte_offset; // simulation
input [UNALIGNED_SHIFT_WIDTH-1:0] i_shift; // used only when UNALIGNED = 1
input i_second; // used only when UNALIGNED = 1
input i_2nd_valid; // used only when UNALIGNED = 1
input i_word_offset_valid;
input i_new_page;
input i_addr_valid;
input i_stall;
output logic [WIDTH-1:0] o_readdata;
output logic o_valid;
output reg o_stall;
output reg o_empty;
output o_ae;
// Avalon interface
output [AWIDTH-1:0] avm_address;
output reg avm_read;
input [MWIDTH-1:0] avm_readdata;
input avm_waitrequest;
output [MWIDTH/8-1:0] avm_byteenable;
input avm_readdatavalid;
output [BURST_CNT_WIDTH-1:0] avm_burstcount;


// offset fifo
wire [OFFSET_FIFO_WIDTH-1:0] offset_fifo_din;
wire [OFFSET_FIFO_WIDTH-1:0] offset_fifo_dout;

// req FIFO
wire rd_req_en;
wire req_fifo_ae, req_fifo_af, req_overflow, offset_overflow, rd_req_empty; // FIFO status
// end req FIFO

// output FIFO
wire rd_data_fifo;
reg  R_rd_data;
wire rd_data_empty;
wire rd_offset;
wire offset_fifo_empty;
wire offset_af;
wire [UNALIGNED:0] d_in_cache;
wire rd_next_page;
wire [CACHE_ADDR_W-1:0] d_cache_addr;
wire [BYTE_SELECT_BITS-1:0] d_byte_offset; // for simulation
reg  R_in_cache;
wire d_second, d_2nd_valid;
wire unalign_stall_offset, unalign_stall_data;
wire [UNALIGNED_SHIFT_WIDTH-1:0] d_shift;
wire [OFFSET_WIDTH-1 : 0] d_offset;
reg  [OFFSET_WIDTH-1 : 0] R_offset;
reg  [MWIDTH-1:0] R_avm_rd_data;
wire [MWIDTH-1:0] rd_data;
// end output FIFO

generate
if (AWIDTH - INPUT_AW) begin : ASSIGN_AVM_ADDRESS_LSBS
  assign avm_address[AWIDTH - INPUT_AW - 1 : 0] = 0;
end
endgenerate
assign avm_byteenable = {(MWIDTH/8){1'b1}};
assign o_ae = req_fifo_ae;
assign rd_req_en = !avm_read | !avm_waitrequest;

always @(posedge clk or posedge reset) begin
  if(reset) begin
    o_empty = 1'b0;
    avm_read <= 1'b0;
    o_stall <= 1'b0;
  end
  else begin
    o_empty <= rd_req_empty;
    o_stall <= offset_af;
    if(rd_req_en) avm_read <= !rd_req_empty;
  end
end


generate
  if(NUM_WORD > 1) begin : GEN_WORD_OFFSET_FIFO
    scfifo #(
      .add_ram_output_register ( "ON"),
      .intended_device_family ( DEVICE),
      .lpm_numwords (OFFSET_FIFO_DEPTH),
      .lpm_showahead ( "OFF"),
      .lpm_type ( "scfifo"),
      .lpm_width (OFFSET_FIFO_WIDTH),
      .lpm_widthu (OFFSET_FIFO_AW),
      .overflow_checking ( "OFF"),
      .underflow_checking ( "ON"),
      .use_eab ( "ON"),
      .almost_full_value(OFFSET_FIFO_DEPTH - 10)
    ) offset_fifo (
      .clock (clk),
      .data (offset_fifo_din),
      .wrreq (i_word_offset_valid),
      .rdreq (rd_offset),
      .usedw (),
      .empty (offset_fifo_empty),
      .full (offset_overflow),
      .q (offset_fifo_dout),
      .almost_empty (),
      .almost_full (offset_af),
      .aclr (reset)
    );
  end
  else begin : GEN_SINGLE_WORD_RD_NEXT
    scfifo #(
      .add_ram_output_register ( "ON"),
      .intended_device_family ( DEVICE),
      .lpm_numwords (OFFSET_FIFO_DEPTH),
      .lpm_showahead ( "OFF"),
      .lpm_type ( "scfifo"),
      .lpm_width (OFFSET_FIFO_WIDTH),
      .lpm_widthu (OFFSET_FIFO_AW),
      .overflow_checking ( "OFF"),
      .underflow_checking ( "ON"),
      .use_eab ( "OFF"), // not instantiate block ram
      .almost_full_value(OFFSET_FIFO_DEPTH - 10)
    ) offset_fifo (
      .clock (clk),
      .data (offset_fifo_din),
      .wrreq (i_word_offset_valid),
      .rdreq (rd_offset),
      .usedw (),
      .empty (offset_fifo_empty),
      .full (offset_overflow),
      .q (offset_fifo_dout),
      .almost_empty (),
      .almost_full (offset_af),
      .aclr (reset)
    );
  end
endgenerate


scfifo #(
  .add_ram_output_register ( "ON"),
  .intended_device_family ( DEVICE),
  .lpm_numwords (REQUEST_FIFO_DEPTH),
  .lpm_showahead ( "OFF"),
  .lpm_type ( "scfifo"),
  .lpm_width (REQUEST_FIFO_WIDTH),
  .lpm_widthu (REQUEST_FIFO_AW),
  .overflow_checking ( "OFF"),
  .underflow_checking ( "ON"),
  .use_eab ( "ON"),
  .almost_full_value(20),
  .almost_empty_value(3)
) rd_request_fifo (
  .clock (clk),
  .data ({i_address, i_burst_count}),
  .wrreq (i_addr_valid),
  .rdreq (rd_req_en),
  .usedw (),
  .empty (rd_req_empty),
  .full (req_overflow),
  .q ({avm_address[AWIDTH - 1: AWIDTH - INPUT_AW], avm_burstcount}),
  .almost_empty (req_fifo_ae),
  .almost_full (req_fifo_af),
  .aclr (reset)
);

/*------------------------------
Generate output data
--------------------------------*/
reg  offset_valid;
reg  [1:0] o_valid_pre;
wire rd_next_page_en, downstream_stall, wait_data, offset_stall, data_stall, valid_hold;

generate
  if(USECACHING) begin : ENABLE_CACHE
    reg  [MWIDTH-1:0] cache [CACHE_SIZE_N]  /* synthesis ramstyle = "no_rw_check, M20K" */;
    logic [MWIDTH-1:0] reused_data[2] ;
    reg  [CACHE_ADDR_W-1:0] R_cache_addr, R_cache_next;

    if(NUM_WORD == 1) begin
       assign offset_fifo_din[OFFSET_FIFO_WIDTH-1:0] = {i_2nd_valid, i_shift, i_second, i_cache_addr, i_in_cache, i_new_page};
       assign {d_2nd_valid, d_shift, d_second, d_cache_addr, d_in_cache, rd_next_page} = offset_fifo_dout[OFFSET_FIFO_WIDTH-1:0];
     end
     else begin
       assign offset_fifo_din[OFFSET_FIFO_WIDTH-1:0] = {i_byte_offset, i_2nd_valid, i_shift, i_second, i_word_offset, i_cache_addr, i_in_cache, i_new_page};
       assign {d_byte_offset, d_2nd_valid, d_shift, d_second, d_offset, d_cache_addr, d_in_cache, rd_next_page} = offset_fifo_dout[OFFSET_FIFO_WIDTH-1:0];
     end

    if(UNALIGNED) begin : GEN_UNALIGNED
      wire need_2nd_page;
      reg  [UNALIGNED_SHIFT_WIDTH-1:0] R_shift [3];
      reg  hold_dout;
      reg  R_second;
      reg  R_need_2nd_page;
      reg  [WIDTH*2-ALIGNMENT_WIDTH-1:0] data_int;
      reg  [WIDTH-1:0] R_o_readdata;
      reg  [1:0] R_2nd_valid;
      reg  second_part_in_cache;
      wire [WIDTH-1:0] c0_data_h, rd_data_h, c0_data_mux, rd_data_mux;
      wire [WIDTH-ALIGNMENT_WIDTH-1:0] c1_data_l, rd_data_l;
      wire get_new_offset, offset_backpressure_stall ;
      wire [CACHE_ADDR_W-1:0] caddr_next;
      wire [1:0] rw_wire;
      reg  [1:0] rw;
      reg  [WIDTH-ALIGNMENT_WIDTH-1:0] R_c1_data_l;

      assign need_2nd_page = |d_shift;
      assign valid_hold = |o_valid_pre;
      assign rw_wire[0] = d_cache_addr == R_cache_addr & R_rd_data;
      assign rw_wire[1] = caddr_next == R_cache_addr & R_rd_data;
      assign c0_data_h = rw[0]? rd_data[MWIDTH-1:MWIDTH-WIDTH] : reused_data[0][MWIDTH-1:MWIDTH-WIDTH];
      assign c1_data_l = rw[1]? R_c1_data_l : reused_data[1][WIDTH-ALIGNMENT_WIDTH-1:0];
      assign rd_data_h = rd_data[MWIDTH-1:MWIDTH-WIDTH];
      assign rd_data_l = rd_data[WIDTH-ALIGNMENT_WIDTH-1:0];
      assign c0_data_mux = rw[0]? rd_data >> R_offset*ALIGNMENT_WIDTH : reused_data[0] >> R_offset*ALIGNMENT_WIDTH ;
      assign rd_data_mux = rd_data >> R_offset*ALIGNMENT_WIDTH;
      assign caddr_next = d_cache_addr+1;
      assign unalign_stall_offset = d_2nd_valid & !offset_backpressure_stall & !R_2nd_valid[0]; //it is a one-cc pulse
      assign unalign_stall_data = R_2nd_valid[0];
      assign get_new_offset = rd_offset | unalign_stall_offset;
      assign offset_backpressure_stall = wait_data | downstream_stall & offset_valid;
      assign offset_stall = offset_backpressure_stall | unalign_stall_offset;
      assign data_stall = downstream_stall | unalign_stall_data;
      assign wait_data = rd_next_page_en & rd_data_empty & !R_2nd_valid[0];
      assign o_readdata = hold_dout? R_o_readdata : data_int[R_shift[2]*ALIGNMENT_WIDTH +: WIDTH];

      always@(posedge clk or posedge reset)begin
         if(reset) begin
           o_valid_pre <= 2'b0;
           o_valid <= 1'b0;
         end
         else begin
          o_valid_pre[0] <= offset_valid & get_new_offset & (!need_2nd_page | !R_2nd_valid[0] & d_second);

           if(i_stall & o_valid & o_valid_pre[0]) o_valid_pre[1] <= 1'b1;
           else if(!i_stall) o_valid_pre[1] <= 1'b0;

           if(o_valid_pre[0]) o_valid <= 1'b1;
           else if(!i_stall) o_valid <= valid_hold;
         end
      end

      always @(posedge clk) begin
        if(R_rd_data) cache[R_cache_addr] <= rd_data;
        if(get_new_offset) begin
          {R_in_cache, R_offset, R_shift[0], R_second} <= {|d_in_cache, d_offset, d_shift, d_second};
          R_cache_addr <= d_cache_addr;
          R_cache_next <= caddr_next;
          R_shift[1] <= R_shift[0];
          R_need_2nd_page <= need_2nd_page;
          second_part_in_cache <= !d_in_cache[0] & d_in_cache[1];
          R_2nd_valid[1] <= R_2nd_valid[0];
          `ifdef SIM_ONLY
            if(d_in_cache[0]) reused_data[0] <= rw_wire[0]? 'x : cache[d_cache_addr];
            reused_data[1] <= rw_wire[1]? 'x : cache[caddr_next];
          `else
            if(d_in_cache[0]) reused_data[0] <= cache[d_cache_addr];
            reused_data[1] <= cache[caddr_next];
          `endif
          if(d_in_cache[1]) R_c1_data_l <= rd_data[WIDTH-ALIGNMENT_WIDTH-1:0];
        end
        // work-around to deal with read-during-write
        if(!downstream_stall & (|d_in_cache)) rw <= rw_wire & d_in_cache;
        if(!offset_backpressure_stall) R_2nd_valid[0] <= d_2nd_valid & !R_2nd_valid[0];

        R_o_readdata <= o_readdata;
        hold_dout <= i_stall & o_valid;

        if(R_in_cache) begin
          data_int[WIDTH*2-ALIGNMENT_WIDTH-1:WIDTH] <= c1_data_l;
          data_int[WIDTH-1:0] <= second_part_in_cache? rd_data_h : R_need_2nd_page? c0_data_h : c0_data_mux;
        end
        else begin
          if(R_second) data_int[WIDTH*2-ALIGNMENT_WIDTH-1:WIDTH] <= rd_data_l;
          if(!R_second | R_2nd_valid[1]) data_int[WIDTH-1:0] <= R_need_2nd_page? rd_data_h : rd_data_mux;
        end

        R_shift[2] <= (R_in_cache | !R_second | R_2nd_valid[1])? R_shift[0] : R_shift[1];
      end
    end   // end UNALIGNED
    else begin : GEN_ALIGNED
      reg  [MWIDTH-1:0] cache [CACHE_SIZE_N] /* synthesis ramstyle = "no_rw_check, M20K" */;
      assign valid_hold = o_valid;
      assign offset_stall = wait_data | downstream_stall & offset_valid;
      assign data_stall = downstream_stall;
      assign wait_data = rd_next_page_en & rd_data_empty; // there is a valid offset, need data to demux

      if(NUM_WORD == 1) assign o_readdata = R_in_cache? reused_data[0][WIDTH-1:0] : rd_data[WIDTH-1:0];
      else assign o_readdata = R_in_cache? reused_data[0] >> R_offset*WORD_WIDTH: rd_data >> R_offset*WORD_WIDTH;

      always @(posedge clk) begin
        if(rd_offset) begin
          R_cache_addr <=  d_cache_addr;
          R_in_cache <= d_in_cache & !(R_rd_data & R_cache_addr == d_cache_addr);
          R_offset <= d_offset;
          // registered cache input and output to infer megafunction RAM
          `ifdef SIM_ONLY // for simulation accuracy
            reused_data[0] <= (d_cache_addr == R_cache_addr & R_rd_data)? 'x : cache[d_cache_addr];  // read during write
          `else
            reused_data[0] <= cache[d_cache_addr];
          `endif
        end
        else if(R_rd_data & R_cache_addr == d_cache_addr) R_in_cache <= 1'b0; // read during write
        if(R_rd_data) cache[R_cache_addr] <= rd_data; // update cache
      end
      always@(posedge clk or posedge reset)begin
        if(reset) o_valid <= 1'b0;
        else if(!i_stall | !o_valid) o_valid <= rd_offset & offset_valid;
      end
    end // end ALIGNED
  end // end USECACHING
  else begin : DISABLE_CACHE
    if(NUM_WORD == 1) begin
       assign offset_fifo_din[OFFSET_FIFO_WIDTH-1:0] = {i_2nd_valid, i_shift, i_second, i_new_page};
       assign {d_2nd_valid, d_shift, d_second, rd_next_page} = offset_fifo_dout[OFFSET_FIFO_WIDTH-1:0];
     end
     else begin
       assign offset_fifo_din[OFFSET_FIFO_WIDTH-1:0] = {i_byte_offset, i_2nd_valid, i_shift, i_second, i_word_offset, i_new_page};
       assign {d_byte_offset, d_2nd_valid, d_shift, d_second, d_offset, rd_next_page} = offset_fifo_dout[OFFSET_FIFO_WIDTH-1:0];
     end
    if(UNALIGNED) begin : GEN_UNALIGNED
      wire need_2nd_page;
      reg  [UNALIGNED_SHIFT_WIDTH-1:0] R_shift [3];
      reg  hold_dout;
      reg  R_second;
      reg  R_need_2nd_page;
      reg  [WIDTH*2-ALIGNMENT_WIDTH-1:0] data_int;
      reg  [WIDTH-1:0] R_o_readdata;
      reg  [1:0] R_2nd_valid;
      wire [WIDTH-1:0] rd_data_h, rd_data_mux;
      wire [WIDTH-ALIGNMENT_WIDTH-1:0] rd_data_l;
      wire get_new_offset, offset_backpressure_stall;

      assign need_2nd_page = |d_shift;
      assign valid_hold = |o_valid_pre;
      assign rd_data_h = rd_data[MWIDTH-1:MWIDTH-WIDTH];
      assign rd_data_l = rd_data[WIDTH-ALIGNMENT_WIDTH-1:0];
      assign rd_data_mux = rd_data >> R_offset*ALIGNMENT_WIDTH;
      assign unalign_stall_offset = d_2nd_valid & !offset_backpressure_stall & !R_2nd_valid[0]; //it is a one-cc pulse
      assign unalign_stall_data = R_2nd_valid[0];
      assign get_new_offset = rd_offset | unalign_stall_offset;
      assign offset_backpressure_stall = wait_data | downstream_stall & offset_valid;
      assign offset_stall = offset_backpressure_stall | unalign_stall_offset;
      assign data_stall = downstream_stall | unalign_stall_data;
      assign wait_data = rd_next_page_en & rd_data_empty & !R_2nd_valid[0];
      assign o_readdata = hold_dout? R_o_readdata : data_int >> R_shift[2]*ALIGNMENT_WIDTH;

      always@(posedge clk or posedge reset)begin
         if(reset) begin
           o_valid_pre <= 2'b0;
           o_valid <= 1'b0;
         end
         else begin
          o_valid_pre[0] <= offset_valid & get_new_offset & (!need_2nd_page | !R_2nd_valid[0] & d_second);
           if(i_stall & o_valid & o_valid_pre[0]) o_valid_pre[1] <= 1'b1;
           else if(!i_stall) o_valid_pre[1] <= 1'b0;

           if(o_valid_pre[0]) o_valid <= 1'b1;
           else if(!i_stall) o_valid <= valid_hold;
         end
      end

      always @(posedge clk) begin
        if(get_new_offset) begin
          {R_offset, R_shift[0], R_second} <= {d_offset, d_shift, d_second};
          R_shift[1] <= R_shift[0];
          R_need_2nd_page <= need_2nd_page;
          R_2nd_valid[1] <= R_2nd_valid[0];
        end
        if(!offset_backpressure_stall) R_2nd_valid[0] <= d_2nd_valid & !R_2nd_valid[0];

        R_o_readdata <= o_readdata;
        hold_dout <= i_stall & o_valid;
        if(R_second) data_int[WIDTH*2-ALIGNMENT_WIDTH-1:WIDTH] <= rd_data_l;
        if(!R_second | R_2nd_valid[1]) data_int[WIDTH-1:0] <= R_need_2nd_page? rd_data_h : rd_data_mux;
        R_shift[2] <= (!R_second | R_2nd_valid[1])? R_shift[0] : R_shift[1];
      end
    end // end GEN_UNALIGNED
    else begin : GEN_ALIGNED
      assign valid_hold = o_valid;
      assign offset_stall = wait_data | downstream_stall & offset_valid;
      assign data_stall = downstream_stall;
      assign wait_data = rd_next_page_en & rd_data_empty; // there is a valid offset, need data to demux

      if(NUM_WORD == 1) assign o_readdata = rd_data[WIDTH-1:0];
      else assign o_readdata = rd_data >> R_offset*WORD_WIDTH;

      always @(posedge clk) begin
        if(rd_offset) R_offset <= d_offset;
      end
      always@(posedge clk or posedge reset)begin
        if(reset) o_valid <= 1'b0;
        else if(!i_stall | !o_valid) o_valid <= rd_offset & offset_valid;
      end
    end // end GEN_ALIGNED
  end // end DISABLE_CACHE
endgenerate

assign downstream_stall = i_stall & valid_hold;
assign rd_next_page_en = offset_valid & rd_next_page;
assign rd_offset = !offset_stall;
assign rd_data_fifo = rd_next_page_en & !data_stall;

always@(posedge clk or posedge reset)begin
  if(reset) begin
    offset_valid <= 1'b0;
    R_rd_data <= 1'b0;
  end
  else begin
    if(rd_offset) offset_valid <= !offset_fifo_empty;
    R_rd_data <= rd_data_fifo & !rd_data_empty;
  end
end


scfifo #(
  .add_ram_output_register ( "ON"),
  .intended_device_family ( DEVICE),
  .lpm_numwords (WIDE_FIFO_DEPTH),
  .almost_full_value(WIDE_FIFO_DEPTH_THRESH),
  .lpm_showahead ( "OFF"),
  .lpm_type ( "scfifo"),
  .lpm_width (MWIDTH),
  .lpm_widthu (WIDE_FIFO_AW),
  .overflow_checking ( "OFF"),
  .underflow_checking ( "ON"),
  .use_eab ( "ON")
) rd_back_wfifo (
  .clock (clk),
  .data (avm_readdata),
  .wrreq (avm_readdatavalid),
  .rdreq (rd_data_fifo),
  .usedw (),
  .empty (rd_data_empty),
  .full (),
  .q (rd_data),
  .almost_empty (),
  .almost_full (),
  .aclr (reset)
);

endmodule

module acl_stall_free_coalescer (
  clk,                        // clock
  reset,                      // reset
  i_valid,                    // valid address
  i_empty,                    // request FIFO is empty
  i_addr,                     // input address
  o_page_addr,                // output page address
  o_page_addr_valid,          // page address valid
  o_num_burst,                // number of burst
  o_new_page
);

parameter AW = 1,
          PAGE_AW = 1,
          MAX_BURST = 1,
          TIME_OUT = 1,
          MAX_THREAD = 1,
          CACHE_LAST = 0,
          DISABLE_COALESCE = 0;

localparam BURST_CNT_WIDTH = $clog2(MAX_BURST+1);
localparam TIME_OUT_W = $clog2(TIME_OUT+1);
localparam THREAD_W = $clog2(MAX_THREAD+1);

input clk;
input reset;
input i_valid;
input i_empty;
input [AW-1:0] i_addr;
// all output signals are registered to help P&R
output reg [PAGE_AW-1:0] o_page_addr;
output reg o_page_addr_valid;
output reg [BURST_CNT_WIDTH-1:0] o_num_burst;
output reg o_new_page;

logic init;
wire match_current_wire, match_next_wire, reset_cnt;
reg  [BURST_CNT_WIDTH-1:0] num_burst;
reg  valid_burst;
wire [PAGE_AW-1:0] page_addr;
reg  [PAGE_AW-1:0] R_page_addr = 0;
reg  [PAGE_AW-1:0] R_page_addr_next = 0;
reg  [PAGE_AW-1:0] addr_hold = 0;
reg  [3:0] delay_cnt; // it takes 5 clock cycles from o_page_addr_valid to being read out from FIFO (if avm_stall = 0), assuming 3 extra clock cycles to reach global mem
reg  [TIME_OUT_W-1:0] time_out_cnt = 0;
reg  [THREAD_W-1:0] thread_cnt = 0;
wire time_out;
wire max_thread;

assign page_addr = i_addr[AW-1:AW-PAGE_AW];                                       // page address
assign match_current_wire = page_addr == R_page_addr;
assign max_thread = thread_cnt[THREAD_W-1] & i_empty;
assign time_out =  time_out_cnt[TIME_OUT_W-1] & i_empty;
assign reset_cnt = valid_burst & (
                   num_burst[BURST_CNT_WIDTH-1]     // reach max burst
                   | time_out
                   | max_thread
                   | !match_current_wire & !match_next_wire & !init & i_valid ); // new burst

generate
if(MAX_BURST == 1) begin : BURST_ONE
  assign match_next_wire = 1'b0;
end
else begin : BURST_N
  assign match_next_wire = page_addr == R_page_addr_next & !init & i_valid & (|page_addr[BURST_CNT_WIDTH-2:0]);
end
if(DISABLE_COALESCE) begin : GEN_DISABLE_COALESCE
  always@(*) begin
    o_page_addr         = page_addr;
    o_page_addr_valid   = i_valid;
    o_num_burst         = 1;
    o_new_page          = 1'b1;
  end
end
else begin : ENABLE_COALESCE
  always@(posedge clk or posedge reset) begin
    // The following reset values were added to work around a PR issue that manifests when registers power up with values other than 0
    // The resets are probably overly aggressive to be conservative due to the negligible cost of adding extra resets.
    // These should be cleaned up when optimizing for S10.
    if(reset) begin
      R_page_addr          <= 0; // maybe unnecessary?  Needs more analysis
      R_page_addr_next     <= 0; // maybe unnecessary?  Needs more analysis
      o_num_burst          <= 0; // probably unnecessary
      o_page_addr          <= 0; // probably unnecessary
      time_out_cnt         <= 0;
      thread_cnt           <= 0;
      delay_cnt            <= 0;
      num_burst            <= 0;
      addr_hold            <= 0;
      o_new_page           <= 0; // probably unnecessary
    end else begin
      if(i_valid) begin
        R_page_addr <= page_addr;
        R_page_addr_next <= page_addr + 1'b1;
      end
      o_num_burst <= num_burst;
      o_page_addr <= addr_hold;
  
      if(i_valid | reset_cnt) time_out_cnt <= 0;  // nop is valid thread, should reset time_out counter too
      else if(!time_out_cnt[TIME_OUT_W-1] & valid_burst) time_out_cnt <= time_out_cnt + 1;
  
      if(reset_cnt) thread_cnt <= i_valid;
      else if(i_valid & !thread_cnt[THREAD_W-1]) thread_cnt <= thread_cnt + 1;
  
      if(o_page_addr_valid) delay_cnt <= 1;
      else if(!delay_cnt[3]) delay_cnt <= delay_cnt + 1;
  
      if(reset_cnt) begin
        num_burst <= i_valid & !match_current_wire;
        addr_hold <= page_addr;
      end
      else if(i_valid) begin
        num_burst <= (!valid_burst & !match_current_wire | init)? 1 : num_burst + match_next_wire;
        if(!valid_burst | init) addr_hold <= page_addr;
      end
      o_new_page <= (!match_current_wire| init) & i_valid;
    end
  end

  always@(posedge clk or posedge reset) begin
    if(reset) begin
      o_page_addr_valid <= 1'b0;
      valid_burst <= 1'b0;
    end
    else begin
      if(reset_cnt) valid_burst <= i_valid & !match_current_wire;
      else if(i_valid) begin
        if(!valid_burst & !match_current_wire | init) valid_burst <= 1'b1;
        else if(match_next_wire) valid_burst <= 1'b1;
      end
      o_page_addr_valid <= reset_cnt;
    end
  end
end
if(CACHE_LAST) begin : GEN_ENABLE_CACHE
  always@(posedge clk or posedge reset) begin
    if(reset) init <= 1'b1;
    else begin
      if(!valid_burst & !o_page_addr_valid & (!i_valid | match_current_wire & !init)) init <= 1'b1; // set init to 1 when the previous request is read out
      else if(i_valid) init <= 1'b0;
    end
  end
end
else begin : GEN_DISABLE_CACHE
  always@(posedge clk or posedge reset) begin
    if(reset) init <= 1'b1;
    else begin
      if(!valid_burst & delay_cnt[3] & !o_page_addr_valid & i_empty & (!i_valid | match_current_wire & !init)) init <= 1'b1; // set init to 1 when the previous request is read out
      else if(i_valid) init <= 1'b0;
    end
  end
end
endgenerate

endmodule


module lsu_bursting_write
(
    clk, clk2x, reset, o_stall, i_valid, i_nop, i_address, i_writedata, i_stall, o_valid,
    i_2nd_offset,
    i_2nd_data,
    i_2nd_byte_en,
    i_2nd_en,
    i_thread_valid,
    o_active, //Debugging signal
    avm_address, avm_write, avm_writeack, avm_writedata, avm_byteenable, avm_waitrequest,
    avm_burstcount,
    i_byteenable
);
parameter AWIDTH=32;            // Address width (32-bits for Avalon)
parameter WIDTH_BYTES=4;        // Width of the memory access (bytes)
parameter MWIDTH_BYTES=32;      // Width of the global memory bus (bytes)
parameter ALIGNMENT_ABITS=2;    // Request address alignment (address bits)
parameter KERNEL_SIDE_MEM_LATENCY=32;    // The max number of live threads
parameter MEMORY_SIDE_MEM_LATENCY=32;    // The latency to get to the iface (no response needed from DDR, we generate writeack right before the iface).
parameter BURSTCOUNT_WIDTH=6;   // Size of Avalon burst count port
parameter USE_WRITE_ACK=0;      // Wait till the write has actually made it to global memory
parameter HIGH_FMAX=1;
parameter USE_BYTE_EN=0;
parameter UNALIGN=0;

localparam WIDTH=8*WIDTH_BYTES;
localparam MWIDTH=8*MWIDTH_BYTES;
localparam BYTE_SELECT_BITS=$clog2(MWIDTH_BYTES);
localparam ALIGNMENT_ABYTES=2**ALIGNMENT_ABITS;

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
input i_nop;
input [AWIDTH-1:0] i_address;
input [WIDTH-1:0] i_writedata;

// used for unaligned
input [BYTE_SELECT_BITS-1-ALIGNMENT_ABITS:0] i_2nd_offset;
input [WIDTH-1:0] i_2nd_data;
input [WIDTH_BYTES-1:0] i_2nd_byte_en;
input i_2nd_en;
input i_thread_valid;

// Downstream interface
input i_stall;
output o_valid;
output reg o_active;

// Avalon interface
output [AWIDTH-1:0] avm_address;
output avm_write;
input avm_writeack;
output [MWIDTH-1:0] avm_writedata;
output [MWIDTH_BYTES-1:0] avm_byteenable;
input avm_waitrequest;
output [BURSTCOUNT_WIDTH-1:0] avm_burstcount;

input [WIDTH_BYTES-1:0] i_byteenable;


// Byte enable control

reg reg_lsu_i_valid, reg_lsu_i_thread_valid;
reg [AWIDTH-1:0] reg_lsu_i_address;
reg [WIDTH-1:0] reg_lsu_i_writedata;
reg [WIDTH_BYTES-1:0] reg_lsu_i_byte_enable;
reg reg_common_burst, reg_lsu_i_2nd_en;
reg reg_i_nop;
reg [BYTE_SELECT_BITS-1-ALIGNMENT_ABITS:0] reg_lsu_i_2nd_offset;
reg [WIDTH-1:0]reg_lsu_i_2nd_data;
reg [WIDTH_BYTES-1:0] reg_lsu_i_2nd_byte_en;


wire stall_signal_directly_from_lsu;
assign o_stall = reg_lsu_i_valid & stall_signal_directly_from_lsu;

// --------------- Pipeline stage : Burst Checking  --------------------
always@(posedge clk or posedge reset)
begin
   if (reset)
   begin
      reg_lsu_i_valid <= 1'b0;
      reg_lsu_i_thread_valid <= 1'b0;
   end
   else
   begin
      if (~o_stall) begin
         reg_lsu_i_valid <= i_valid;
         reg_lsu_i_thread_valid <= i_thread_valid;
      end
   end
end

always@(posedge clk) begin
  if (~o_stall & i_valid & ~i_nop) reg_lsu_i_address <= i_address;

  if (~o_stall)  begin
     reg_i_nop <= i_nop;
     reg_lsu_i_writedata <= i_writedata;
     reg_lsu_i_byte_enable <= i_byteenable;
     reg_lsu_i_2nd_offset <= i_2nd_offset;
     reg_lsu_i_2nd_en <= i_2nd_en;
     reg_lsu_i_2nd_data <= i_2nd_data;
     reg_lsu_i_2nd_byte_en <= i_2nd_byte_en;
     reg_common_burst <= i_nop | (reg_lsu_i_address[AWIDTH-1:BYTE_SELECT_BITS+BURSTCOUNT_WIDTH-1] == i_address[AWIDTH-1:BYTE_SELECT_BITS+BURSTCOUNT_WIDTH-1]);
  end
end

// -------------------------------------------------------------------
lsu_bursting_write_internal #(
   .KERNEL_SIDE_MEM_LATENCY(KERNEL_SIDE_MEM_LATENCY),
   .MEMORY_SIDE_MEM_LATENCY(MEMORY_SIDE_MEM_LATENCY),
   .AWIDTH(AWIDTH),
   .WIDTH_BYTES(WIDTH_BYTES),
   .MWIDTH_BYTES(MWIDTH_BYTES),
   .BURSTCOUNT_WIDTH(BURSTCOUNT_WIDTH),
   .ALIGNMENT_ABITS(ALIGNMENT_ABITS),
   .USE_WRITE_ACK(USE_WRITE_ACK),
   .USE_BYTE_EN(USE_BYTE_EN),
   .UNALIGN(UNALIGN),
   .HIGH_FMAX(HIGH_FMAX)
) bursting_write (
   .clk(clk),
   .clk2x(clk2x),
   .reset(reset),
   .i_nop(reg_i_nop),
   .o_stall(stall_signal_directly_from_lsu),
   .i_valid(reg_lsu_i_valid),
   .i_thread_valid(reg_lsu_i_thread_valid),
   .i_address(reg_lsu_i_address),
   .i_writedata(reg_lsu_i_writedata),
   .i_2nd_offset(reg_lsu_i_2nd_offset),
   .i_2nd_data(reg_lsu_i_2nd_data),
   .i_2nd_byte_en(reg_lsu_i_2nd_byte_en),
   .i_2nd_en(reg_lsu_i_2nd_en),
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
   .avm_waitrequest(avm_waitrequest),
   .common_burst(reg_common_burst)
);
endmodule


//
// Burst coalesced write module
// Again, top level comments later
//
module lsu_bursting_write_internal
(
    clk, clk2x, reset, o_stall, i_valid, i_nop, i_address, i_writedata, i_stall, o_valid,
    o_active, //Debugging signal
    i_2nd_offset,
    i_2nd_data,
    i_2nd_byte_en,
    i_2nd_en,
    i_thread_valid,
    avm_address, avm_write, avm_writeack, avm_writedata, avm_byteenable, avm_waitrequest,
    avm_burstcount,
    i_byteenable,
    common_burst
);

/*************
* Parameters *
*************/
parameter AWIDTH=32;            // Address width (32-bits for Avalon)
parameter WIDTH_BYTES=4;        // Width of the memory access (bytes)
parameter MWIDTH_BYTES=32;      // Width of the global memory bus (bytes)
parameter ALIGNMENT_ABITS=2;    // Request address alignment (address bits)
parameter KERNEL_SIDE_MEM_LATENCY=32;    // Memory latency in cycles
parameter MEMORY_SIDE_MEM_LATENCY=32;    // Memory latency in cycles
parameter BURSTCOUNT_WIDTH=6;   // Size of Avalon burst count port
parameter USE_WRITE_ACK=0;      // Wait till the write has actually made it to global memory
parameter HIGH_FMAX=1;
parameter USE_BYTE_EN=0;
parameter UNALIGN=0;

// WARNING: Kernels will hang if InstrDataDep claims that a store
// has more capacity than this number
//
parameter MAX_CAPACITY=128;     // Must be a power-of-2 to keep things simple

// Derived parameters
localparam MAX_BURST=2**(BURSTCOUNT_WIDTH-1);
//
// Notice that in the non write ack case, the number of threads seems to be twice the sensible number
// This is because MAX_THREADS is usually the limiter on the counter width. Once one request is assemembled,
// we want to be able to start piplining another burst. Thus the factor of 2.
// The MEMORY_SIDE_MEM_LATENCY will further increase this depth if the compiler
// thinks the lsu will see a lot of contention on the Avalon side.
//
localparam __WRITE_FIFO_DEPTH = (WIDTH_BYTES==MWIDTH_BYTES) ? 3*MAX_BURST : 2*MAX_BURST;
// No reason this should need more than max MLAB depth
localparam _WRITE_FIFO_DEPTH = ( __WRITE_FIFO_DEPTH < 64 ) ? __WRITE_FIFO_DEPTH : 64;
// Need at least 4 to account for fifo push-to-pop latency
localparam WRITE_FIFO_DEPTH = ( _WRITE_FIFO_DEPTH > 8 ) ? _WRITE_FIFO_DEPTH : 8;

// Determine the maximum # of threads to group into a burst-coalesced request
// TODO: Create a new parameter with proper name to control this instead of using MEMORY_SIDE_MEM_LATENCY 
localparam MAX_THREADS= MEMORY_SIDE_MEM_LATENCY;

//
localparam WIDTH=8*WIDTH_BYTES;
localparam MWIDTH=8*MWIDTH_BYTES;
localparam BYTE_SELECT_BITS=$clog2(MWIDTH_BYTES);
localparam SEGMENT_SELECT_BITS=BYTE_SELECT_BITS-ALIGNMENT_ABITS;
localparam PAGE_SELECT_BITS=AWIDTH-BYTE_SELECT_BITS;
localparam NUM_SEGMENTS=2**SEGMENT_SELECT_BITS;
localparam SEGMENT_WIDTH_BYTES=(2**ALIGNMENT_ABITS);
localparam SEGMENT_WIDTH=8*SEGMENT_WIDTH_BYTES;
localparam NUM_WORD = MWIDTH_BYTES/SEGMENT_WIDTH_BYTES;
localparam UNALIGN_BITS = $clog2(WIDTH_BYTES)-ALIGNMENT_ABITS;

// Determines the max writes 'in-flight'
localparam MAX_IN_FLIGHT= (USE_WRITE_ACK ? KERNEL_SIDE_MEM_LATENCY : (2*MWIDTH_BYTES/WIDTH_BYTES*MAX_BURST));
localparam COUNTER_WIDTH=(($clog2(MAX_IN_FLIGHT)+1 < $clog2(MAX_CAPACITY+1)) ?
                          $clog2(MAX_CAPACITY+1) : ($clog2(MAX_IN_FLIGHT)+1)); 

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
input i_nop;
input [AWIDTH-1:0] i_address;
input [WIDTH-1:0] i_writedata;

// used for unaligned
input [BYTE_SELECT_BITS-1-ALIGNMENT_ABITS:0] i_2nd_offset;
input [WIDTH-1:0] i_2nd_data;
input [WIDTH_BYTES-1:0] i_2nd_byte_en;
input i_2nd_en;
input i_thread_valid;

// Downstream interface
input i_stall;
output o_valid;
output reg o_active;

// Avalon interface
output [AWIDTH-1:0] avm_address;
output avm_write;
input avm_writeack;
output [MWIDTH-1:0] avm_writedata;
output [MWIDTH_BYTES-1:0] avm_byteenable;
input avm_waitrequest;
output [BURSTCOUNT_WIDTH-1:0] avm_burstcount;

// Byte enable control
input [WIDTH_BYTES-1:0] i_byteenable;

// Help from outside
input common_burst;

/***************
* Architecture *
***************/
wire [WIDTH_BYTES-1:0] word_byte_enable;

wire input_accepted;
wire output_acknowledged;
wire write_accepted;
wire [PAGE_SELECT_BITS-1:0] page_addr;
wire c_new_page;
wire c_page_done;
wire c_nop;
wire [PAGE_SELECT_BITS-1:0] c_req_addr;
wire c_req_valid;
wire c_stall;
reg [COUNTER_WIDTH-1:0] occ_counter;

// Replicated version of the occ and stores counters that decrement instead of increment
// This allows me to check the topmost bit to determine if the counter is non-empty
reg [COUNTER_WIDTH-1:0] nop_cnt;
reg [COUNTER_WIDTH-1:0] occ_counter_neg;
reg [COUNTER_WIDTH-1:0] ack_counter_neg;
wire [1:0] ack_counter_neg_update;
wire [COUNTER_WIDTH-1:0] ack_counter_neg_update_extended;
reg [COUNTER_WIDTH-1:0] ack_counter;
reg [COUNTER_WIDTH-1:0] next_counter;
reg [MWIDTH-1:0] wm_writedata;
reg [MWIDTH_BYTES-1:0] wm_byteenable;
reg [MWIDTH-1:0] wm_wide_wdata;
reg [MWIDTH_BYTES-1:0] wm_wide_be;
wire [MWIDTH-1:0] wm_wide_bite;

wire w_fifo_full;
wire [BURSTCOUNT_WIDTH-1:0] c_burstcount;
// Track the current item in the write burst since we issue c_burstcount burst reqs
reg [BURSTCOUNT_WIDTH-1:0] burstcounter;

// The address components
assign page_addr = i_address[AWIDTH-1:BYTE_SELECT_BITS];


assign word_byte_enable = i_nop? '0: (USE_BYTE_EN ? i_byteenable :{WIDTH_BYTES{1'b1}}) ;


generate
genvar byte_num;
for( byte_num = 0; byte_num < MWIDTH_BYTES; byte_num++) begin : wbiten
  assign wm_wide_bite[byte_num*8 +:8] = {8{wm_wide_be[byte_num]}};
end
endgenerate

wire oc_full;
wire cnt_valid;
wire coalescer_active;
reg all_byteenables_on;

// Coalescer - Groups subsequent requests together if they are compatible
// and the output register stage is stalled
bursting_coalescer #(
    .PAGE_ADDR_WIDTH(PAGE_SELECT_BITS),
    .TIMEOUT(16),
    .TIMEOUT_NOT_ALL_BE((USE_WRITE_ACK) ? 16 : 512),
    .BURSTCOUNT_WIDTH(BURSTCOUNT_WIDTH),
    .MAXBURSTCOUNT(MAX_BURST),
    .MAX_THREADS(MAX_THREADS)
) coalescer (
    .clk(clk),
    .reset(reset),
    .i_page_addr(page_addr),
    .i_valid(i_valid && !oc_full && !w_fifo_full),
    .i_nop(i_nop),
    .o_stall(c_stall),
    .o_start_nop(c_nop), // new burst starts with nop
    .o_new_page(c_new_page),
    .o_page_done(c_page_done),
    .o_req_addr(c_req_addr),
    .o_req_valid(c_req_valid),
    .i_stall(w_fifo_full),
    .o_burstcount(c_burstcount),
    .common_burst(common_burst),
    .all_byteenables_on(all_byteenables_on),
    .o_active(coalescer_active)
);

// Writedata MUX
genvar z;
generate if( SEGMENT_SELECT_BITS > 0 )
begin
  wire [SEGMENT_SELECT_BITS-1:0] segment_select;
  assign segment_select = i_address[BYTE_SELECT_BITS-1:ALIGNMENT_ABITS];
  if(UNALIGN) begin : GEN_UNALIGN
    assign cnt_valid = i_thread_valid; 
    always@(*) begin         
      wm_wide_wdata = i_2nd_en? (i_2nd_data << (i_2nd_offset*SEGMENT_WIDTH)) | {{(MWIDTH-(WIDTH-SEGMENT_WIDTH)){1'b0}}, i_writedata[WIDTH-SEGMENT_WIDTH-1:0]} : i_writedata << (segment_select*SEGMENT_WIDTH);
      wm_wide_be = '0;
      wm_wide_be = ((i_2nd_byte_en & {WIDTH_BYTES{i_2nd_en}}) << (i_2nd_offset*SEGMENT_WIDTH_BYTES)) | (word_byte_enable << (segment_select*SEGMENT_WIDTH_BYTES));        
    end
  end // end GEN_UNALIGN
  else begin: GEN_ALIGN
    assign cnt_valid = i_valid;
    always@(*) begin
     wm_wide_wdata = {MWIDTH{1'bx}};
     wm_wide_wdata[WIDTH-1:0] = i_writedata;
     wm_wide_wdata = wm_wide_wdata << (segment_select*SEGMENT_WIDTH);

     wm_wide_be = {MWIDTH_BYTES{1'b0}};
     wm_wide_be[WIDTH_BYTES-1:0] = word_byte_enable;
     wm_wide_be = wm_wide_be << (segment_select*SEGMENT_WIDTH_BYTES);
    end
  end
end
else
begin
   assign cnt_valid = i_valid;
   always@(*)
   begin
      wm_wide_wdata = {MWIDTH{1'bx}};
      wm_wide_wdata[0 +: WIDTH] = i_writedata;

      wm_wide_be = {MWIDTH_BYTES{1'b0}};
      wm_wide_be[0 +: WIDTH_BYTES] = word_byte_enable;
   end
end
endgenerate

// Occupancy counter - track the number of successfully transmitted writes
// and the number of writes pending in the next request.
//    occ_counter - the total occupancy (in threads) of the unit
//    next_counter - the number of threads coalesced into the next transfer
//    ack_counter - the number of pending threads with write completion acknowledged
reg    pending_nop;
wire   pending_cc = nop_cnt != occ_counter;
wire   burst_start_nop = cnt_valid & c_nop & !o_stall;
wire   start_with_nop = !pending_cc && i_nop && cnt_valid && !o_stall; // nop starts when there are no pending writes
wire   normal_cc_valid = cnt_valid && !o_stall && !i_nop;
wire   clear_nop_cnt = normal_cc_valid || !pending_cc;
assign input_accepted = cnt_valid && !o_stall && !(c_nop || start_with_nop);
assign write_accepted = avm_write && !avm_waitrequest;
assign output_acknowledged = o_valid && !i_stall;
wire [8:0] ack_pending =  {1'b1, {COUNTER_WIDTH{1'b0}}} - ack_counter;


// Track the current write burst data - coalesce writes together until the
// output registers are ready for a new request.
always@(posedge clk or posedge reset)
begin
    if(reset)
    begin
        wm_writedata <= {MWIDTH{1'b0}};
        wm_byteenable <= {MWIDTH_BYTES{1'b0}};
        all_byteenables_on <= 1'b0;
    end
    else
    begin
        if(c_new_page)
        begin
            wm_writedata <= wm_wide_wdata;
            wm_byteenable <= wm_wide_be;
        end
        else if( i_valid && !o_stall && !(c_nop || start_with_nop) )    // same as input_accepted, but replace cnt_valid with i_valid (cnt_valid = i_thread_valid for non-aligned, = i_valid for all others)
        begin
            wm_writedata <= (wm_wide_wdata & wm_wide_bite) | (wm_writedata & ~wm_wide_bite);
            wm_byteenable <= wm_wide_be | wm_byteenable;
        end
        all_byteenables_on <= &wm_byteenable;
    end
end


wire [COUNTER_WIDTH-1:0] num_threads_written;

// This FIFO stores the actual data to be written
//
//
wire w_data_fifo_full, req_fifo_empty;
wire wr_page = c_page_done & !w_fifo_full;
acl_data_fifo #(
    .DATA_WIDTH(MWIDTH+MWIDTH_BYTES),
    .DEPTH(WRITE_FIFO_DEPTH),
    .IMPL(HIGH_FMAX ? "ram_plus_reg" : "ram")
) req_fifo (
    .clock(clk),
    .resetn(~reset),
    .data_in( {wm_writedata,wm_byteenable} ),
    .valid_in( wr_page ),
    .data_out( {avm_writedata,avm_byteenable} ),
    .stall_in( ~write_accepted ),
    .stall_out( w_data_fifo_full ),
    .empty(req_fifo_empty)
);

// This FIFO stores the number of valid's to release with each writeack
//
wire w_ack_fifo_full;
acl_data_fifo #(
    .DATA_WIDTH(COUNTER_WIDTH),
    .DEPTH(2*WRITE_FIFO_DEPTH),
    .IMPL(HIGH_FMAX ? "ram_plus_reg" : "ram")
) ack_fifo (
    .clock(clk),
    .resetn(~reset),
    .data_in( next_counter),
    .valid_in( wr_page ),
    .data_out( num_threads_written ),
    .stall_in( !avm_writeack),
    .stall_out( w_ack_fifo_full )
);

// This FIFO hold the request information { address & burstcount }
//
wire w_fifo_stall_in;
assign w_fifo_stall_in = !(write_accepted && (burstcounter == avm_burstcount));

wire w_request_fifo_full;
acl_data_fifo #(
    .DATA_WIDTH(PAGE_SELECT_BITS+BURSTCOUNT_WIDTH),
    .DEPTH(WRITE_FIFO_DEPTH),
    .IMPL(HIGH_FMAX ? "ram_plus_reg" : "ram")
) req_fifo2 (
    .clock(clk),
    .resetn(~reset),
    .data_in( {c_req_addr,c_burstcount} ),
    .valid_in( c_req_valid & !w_fifo_full ), // The basical coalescer stalls on w_fifo_full holding c_req_valid high
    .data_out( {avm_address[AWIDTH-1: BYTE_SELECT_BITS],avm_burstcount} ),
    .valid_out( avm_write ),
    .stall_in( w_fifo_stall_in ),
    .stall_out( w_request_fifo_full )
);
generate
if (BYTE_SELECT_BITS) begin : ASSIGN_AVM_ADDRESS_LSBS
  assign avm_address[BYTE_SELECT_BITS-1:0] = '0;
end
endgenerate
// The w_fifo_full is the OR of the data or request fifo's being full
assign w_fifo_full = w_data_fifo_full | w_request_fifo_full | w_ack_fifo_full;

assign ack_counter_neg_update = avm_writeack - wr_page;
assign ack_counter_neg_update_extended = $signed(ack_counter_neg_update);

always@(posedge clk or posedge reset)
begin
   if(reset == 1'b1)
   begin
      occ_counter <= {COUNTER_WIDTH{1'b0}};
      occ_counter_neg <= {COUNTER_WIDTH{1'b0}};
      ack_counter <= {COUNTER_WIDTH{1'b0}};
      next_counter <= {COUNTER_WIDTH{1'b0}};
      ack_counter_neg <= '0;
      nop_cnt <= '0;
      burstcounter <= 6'b000001;
      o_active <= 1'b0;
      pending_nop <= 1'b0;
   end
   else
   begin
      if(clear_nop_cnt) begin
        nop_cnt <= '0;
        pending_nop <= 1'b0;
       end
      else if(!start_with_nop) begin
        nop_cnt <= nop_cnt + burst_start_nop;
        if(burst_start_nop) pending_nop <= 1'b1;
      end

      occ_counter <= occ_counter + (cnt_valid && !o_stall) - output_acknowledged;
      occ_counter_neg <= occ_counter_neg - (cnt_valid && !o_stall) + output_acknowledged;

      next_counter <= input_accepted + (c_page_done ? {COUNTER_WIDTH{1'b0}} : next_counter) + (normal_cc_valid? nop_cnt : 0);
      if(USE_WRITE_ACK) begin
        ack_counter <= ack_counter
              - (avm_writeack? num_threads_written : 0)
              - ( (!pending_cc & !normal_cc_valid)?  nop_cnt : 0)
              - start_with_nop
              + output_acknowledged;
        o_active <= occ_counter_neg[COUNTER_WIDTH-1];
      end
      else begin
        ack_counter <= ack_counter - (cnt_valid && !o_stall) + output_acknowledged;
        ack_counter_neg <= ack_counter_neg + ack_counter_neg_update_extended;
        o_active <= occ_counter_neg[COUNTER_WIDTH-1] | ack_counter_neg[COUNTER_WIDTH-1] | coalescer_active; // do not use num_threads_written, because it takes extra resource
      end
      burstcounter <= write_accepted ? ((burstcounter == avm_burstcount) ? 6'b000001 : burstcounter+1) : burstcounter;
   end
end
assign oc_full = occ_counter[COUNTER_WIDTH-1];

// Pipeline control signals
assign o_stall = oc_full || c_stall || w_fifo_full;
assign o_valid = ack_counter[COUNTER_WIDTH-1];


endmodule

// BURST COALESCING MODULE
//
// Similar to the basic coalescer but supports checking if accesses are in consecutive DRAM "pages"
// Supports the ad-hocly discovered protocols for bursting efficiently with avalaon
// - Don't burst from an ODD address
// - If not on a burst boundary, then just burst up to the next burst bondary
//
// Yes, I know, this could be incorporated into the basic coalescer. But that's really not my "thing"
//
module bursting_coalescer
(
    clk, reset, i_page_addr, i_nop, i_valid, o_stall, o_new_page, o_page_done, o_req_addr, o_burstcount,
    o_req_valid, i_stall, o_start_nop,
    common_burst, all_byteenables_on,

    // For the purposes of maintaining latency correctly, we need to know if total # of threads
    // accepted by the caching LSU
    i_input_accepted_from_wrapper_lsu,
    i_reset_timeout,
    o_active
);

parameter PAGE_ADDR_WIDTH=32;
parameter TIMEOUT=8;			    // original timeout
parameter TIMEOUT_NOT_ALL_BE=8;		// timeout to use if waiting for completing an entire global memory word -- idea is to avoid partial writes on cci
parameter BURSTCOUNT_WIDTH=6; // Size of Avalon burst count port
parameter MAXBURSTCOUNT=32;   // This isn't the max supported by Avalon, but the max that the instantiating module needs
parameter MAX_THREADS=64;     // Must be a power of 2
parameter USECACHING=0;

localparam SLAVE_MAX_BURST=2**(BURSTCOUNT_WIDTH-1);
localparam THREAD_COUNTER_WIDTH=$clog2(MAX_THREADS+1);

input clk;
input reset;

input [PAGE_ADDR_WIDTH-1:0] i_page_addr;
input i_nop;
input i_valid;
output o_stall;
output o_new_page;
output o_page_done;
output o_start_nop;

output [PAGE_ADDR_WIDTH-1:0] o_req_addr;
output o_req_valid;
output [BURSTCOUNT_WIDTH-1:0] o_burstcount;
input i_stall;

input common_burst;
input all_byteenables_on;

input i_input_accepted_from_wrapper_lsu;
input i_reset_timeout;
output o_active;

reg [PAGE_ADDR_WIDTH-1:0] page_addr;
reg [PAGE_ADDR_WIDTH-1:0] last_page_addr;
reg [PAGE_ADDR_WIDTH-1:0] last_page_addr_p1;
reg [BURSTCOUNT_WIDTH-1:0] burstcount;
reg valid;
wire ready;
wire waiting;
wire match;


wire timeout;
wire timeout_not_all_be;
wire chosen_timeout;
reg [$clog2(TIMEOUT):0] timeout_counter;
reg [$clog2(TIMEOUT_NOT_ALL_BE):0] timeout_counter_not_all_be;

reg [THREAD_COUNTER_WIDTH-1:0] thread_counter;

generate if(USECACHING)
begin
   assign timeout = timeout_counter[$clog2(TIMEOUT)] | thread_counter[THREAD_COUNTER_WIDTH-1];
   assign timeout_not_all_be = timeout_counter_not_all_be[$clog2(TIMEOUT_NOT_ALL_BE)] | thread_counter[THREAD_COUNTER_WIDTH-1];
end
else
begin
   assign timeout = timeout_counter[$clog2(TIMEOUT)];
   assign timeout_not_all_be = timeout_counter_not_all_be[$clog2(TIMEOUT_NOT_ALL_BE)];
end
endgenerate

// Internal signal logic
wire match_burst_address;
wire match_next_page;
wire match_current_page;

generate
if ( BURSTCOUNT_WIDTH > 1 )
begin
  assign match_next_page     = (i_page_addr[BURSTCOUNT_WIDTH-2:0] === last_page_addr_p1[BURSTCOUNT_WIDTH-2:0]) && (|last_page_addr_p1[BURSTCOUNT_WIDTH-2:0]);
  assign match_current_page  = (i_page_addr[BURSTCOUNT_WIDTH-2:0] === last_page_addr[BURSTCOUNT_WIDTH-2:0]);
end
else
begin
  assign match_next_page     = 1'b0;
  assign match_current_page  = 1'b1;
end
endgenerate

assign match_burst_address = common_burst;//(i_page_addr[PAGE_ADDR_WIDTH-1:BURSTCOUNT_WIDTH-1] == last_page_addr[PAGE_ADDR_WIDTH-1:BURSTCOUNT_WIDTH-1]);

assign chosen_timeout = (all_byteenables_on) ? timeout : timeout_not_all_be;	//if we have a complete global memory word, don't need to wait as long (on systems with partial write penalty like cci)

assign match = (match_burst_address && (match_current_page || match_next_page)) && !thread_counter[THREAD_COUNTER_WIDTH-1];

assign ready = !valid || !(i_stall || waiting);
assign waiting = !chosen_timeout && (!i_valid || match);

wire input_accepted = i_valid && !o_stall;
assign o_start_nop = i_nop & ready;
assign o_active = valid;

always@(posedge clk or posedge reset)
begin
    if(reset)
    begin
        page_addr <= {PAGE_ADDR_WIDTH{1'b0}};
        last_page_addr <= {PAGE_ADDR_WIDTH{1'b0}};
        last_page_addr_p1 <= {PAGE_ADDR_WIDTH{1'b0}};
        burstcount <= 1;
        valid <= 1'b0;
        timeout_counter <= 0;
        thread_counter <= {THREAD_COUNTER_WIDTH{1'b0}};
    end
    else
    begin
        page_addr <= ready ? i_page_addr : page_addr;
        last_page_addr <= ready ? i_page_addr : (input_accepted && match_next_page ? i_page_addr : last_page_addr );
        last_page_addr_p1 <= ready ? i_page_addr+1 : (input_accepted && match_next_page ? i_page_addr+1 : last_page_addr_p1 );
        valid <= ready ? i_valid & !i_nop : valid; // burst should not start with nop thread
        burstcount <= ready ? 6'b000001 : (input_accepted &&  match_next_page ? burstcount+1 : burstcount );
        thread_counter <= ready ? 1 : (USECACHING ?
                                        (i_input_accepted_from_wrapper_lsu && !thread_counter[THREAD_COUNTER_WIDTH-1] ? thread_counter+1 : thread_counter ) :
                                        (input_accepted ? thread_counter+1 : thread_counter));

        if( USECACHING && i_reset_timeout || !USECACHING && i_valid ) begin
            timeout_counter <= 'd1;
            timeout_counter_not_all_be <= 'd1;
        end
        else if( valid && !chosen_timeout ) begin
            timeout_counter <= timeout_counter + 'd1;
            timeout_counter_not_all_be <= timeout_counter_not_all_be + 'd1;
        end
    end
end

// Outputs
assign o_stall = !match && !ready && i_valid;
// We're starting a new page (used by loads)
assign o_new_page = ready || i_valid && match_burst_address && !thread_counter[THREAD_COUNTER_WIDTH-1] && match_next_page;
assign o_req_addr = page_addr;
assign o_burstcount = burstcount;
assign o_req_valid = valid && !waiting;
// We're just finished with a page (used by stores)
assign o_page_done = valid && !waiting && !i_stall || !ready && i_valid && match_burst_address && !thread_counter[THREAD_COUNTER_WIDTH-1] && match_next_page;
endmodule
