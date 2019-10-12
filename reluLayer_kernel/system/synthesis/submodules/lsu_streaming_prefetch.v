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


/*****************************************************************************/
// Streaming prefetch read unit:
//   Pre-fetch a stream of data words beginning at i_address.  The
//   FIFO is kept full until a non-contiguous address is encountered, at
//   which time the FIFO is either fully or partially drained.
/*****************************************************************************/
module lsu_streaming_prefetch_read 
(
   clk, reset, flush, o_stall, i_valid, i_address, i_stall, i_nop, o_valid, o_readdata, 
   o_active, //Debugging signal
   avm_address, avm_burstcount, avm_read, 
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
input flush;

// Upstream pipeline interface
output o_stall;
input i_valid;
input i_nop; //predicated addresses are treated as valid
input [AWIDTH-1:0] i_address;

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

// Input Pipeline Signals
reg              i_valid_r;
reg [AWIDTH-1:0] i_address_r;

reg              i_valid_rr;
reg [AWIDTH-1:0] i_address_rr;

//Address comparison
reg addr_before_fifo;
reg addr_after_fifo;
reg empty_r;
wire flush_on_fifo_miss;
reg flush_on_fifo_miss_r;
wire internal_flush;

wire [AWIDTH - 1 : 0] i_mem_addr_r;
wire [AWIDTH - 1 : 0] i_mem_addr_rr;

// FIFO signals
wire [AWIDTH - 1 : 0] fifo_high_addr;
wire                  empty;
wire  [MWIDTH -1 : 0] user_data_out;
wire                  wait_for_read;

// FIFO and burst master communication signals
wire          [AWIDTH - 1 : 0] fifo2master_read_addr;
wire                           fifo2master_read;
wire [BURSTCOUNT_WIDTH -1 : 0] fifo2master_burst_size;
wire                           fifo2master_data_valid;
wire           [MWIDTH -1 : 0] fifo2master_data;
wire                           fifo2master_ready;


/**********************************************************/
// Input Pipeline
/**********************************************************/
always @(posedge clk or posedge reset) begin
    if (reset) begin
        i_valid_r          <= 1'b0;
        i_address_r        <= 0;
        i_valid_rr         <= 1'b0;
        i_address_rr       <= 0;
    end else begin
        if (flush) begin
            i_valid_r   <= 1'b0;
            i_valid_rr  <= 1'b0;
        end else if (!o_stall) begin
            //stage 1 input registers
            i_valid_r   <= i_valid;
            // Force address alignment bits to 0.  They should already be 0, but forcing
            // them to 0 here lets Quartus see the alignment and optimize the design
            i_address_r <= i_valid ? ((i_address >> ALIGNMENT_ABITS) << ALIGNMENT_ABITS) : i_address_r;

            //stage 2 input registers
            i_valid_rr   <= i_valid_r;
            i_address_rr <= i_valid_r ? i_address_r : i_address_rr;
        end

    end
end


/**********************************************************/
// Address comparison
/**********************************************************/

//memory word aligned address
assign i_mem_addr_r  = ((i_address_r  >> MBYTE_SELECT_BITS) << MBYTE_SELECT_BITS);
assign i_mem_addr_rr = ((i_address_rr >> MBYTE_SELECT_BITS) << MBYTE_SELECT_BITS);

always @(posedge clk or posedge reset) begin
    if (reset) begin

        addr_before_fifo <= 1'b0;
        addr_after_fifo  <= 1'b0;

        empty_r <= 1;
        flush_on_fifo_miss_r <= 0;
    end else begin
           
        if (flush) begin
            addr_before_fifo <= 1'b0;
            addr_after_fifo  <= 1'b0;

            empty_r <= 1;
        end else if (!o_stall) begin
            // compare to current addresses
            addr_before_fifo <= (i_mem_addr_rr > i_mem_addr_r);
            addr_after_fifo  <= (fifo_high_addr <= i_mem_addr_r);

            empty_r <= empty;
        end

        // use o_stall to retrigger flush if there are two misses in a row
        flush_on_fifo_miss_r <= flush ? 0 : flush_on_fifo_miss & o_stall;

    end
end

// flush data if not in FIFO
assign flush_on_fifo_miss = (addr_before_fifo | addr_after_fifo | empty_r) & !empty;
assign internal_flush = (flush_on_fifo_miss & ~flush_on_fifo_miss_r);

/**********************************************************/
// FIFO for prefetched data
/**********************************************************/
lsu_streaming_prefetch_fifo #(
        .DEPTH             (FIFO_DEPTH       ),
        .LOG2_DEPTH        (FIFO_DEPTH_LOG2  ),
        .MWIDTH            (MWIDTH           ),
        .AWIDTH            (AWIDTH           ),
        .MBYTE_SELECT_BITS (MBYTE_SELECT_BITS),
        .MAXBURSTCOUNT     (MAXBURSTCOUNT    ),
        .BURSTCOUNT_WIDTH  (BURSTCOUNT_WIDTH )
    ) u_fifo (
        .clk   (clk),
        .reset (reset),
        .flush_external (flush),
        .flush_internal (internal_flush),

        // from user
        .user_read_addr  (i_address_r          ),
        .user_valid      (i_valid_r & !flush   ), //mask valids on an external flush
        .user_data_out   (user_data_out        ),

        .user_read_addr_r (i_address_rr        ),
        .user_valid_r     (i_valid_rr & ~flush ), //mask valids on an external flush
        .wait_for_read    (wait_for_read       ),

        .i_stall (o_valid & i_stall),

        // for comparison with incoming user addr
        .empty          (empty         ),
        .fifo_high_addr (fifo_high_addr),

        // to burst master
        .avm_read_addr  (fifo2master_read_addr ),
        .avm_read       (fifo2master_read      ),
        .avm_burst_size (fifo2master_burst_size),
        .avm_data_valid (fifo2master_data_valid),
        .avm_data       (fifo2master_data      ),
        .avm_ready      (fifo2master_ready     )
    ); 

/**********************************************************/
// Avalon Burst Master
/**********************************************************/
lsu_streaming_prefetch_avalon_bust_master #(
        .AWIDTH           (AWIDTH          ),
        .MWIDTH           (MWIDTH          ),
        .MWIDTH_BYTES     (MWIDTH_BYTES    ),
        .BURSTCOUNT_WIDTH (BURSTCOUNT_WIDTH),
        .FIFO_DEPTH_LOG2  (FIFO_DEPTH_LOG2 )
    ) u_burst_master (
        .clk    (clk),
        .reset  (reset),
        .flush  (flush | internal_flush),
        .active (o_active),

        // from FIFO
        .fifo_read_addr  (fifo2master_read_addr ),
        .fifo_read       (fifo2master_read      ),
        .fifo_burst_size (fifo2master_burst_size),
        .fifo_data_valid (fifo2master_data_valid),
        .fifo_data       (fifo2master_data      ),
        .ready           (fifo2master_ready     ),

        // master inputs and outputs
        .master_address       (f_avm_address    ),
        .master_read          (f_avm_read       ),
        .master_byteenable    (avm_byteenable   ),
        .master_readdata      (avm_readdata     ),
        .master_readdatavalid (avm_readdatavalid),
        .master_burstcount    (f_avm_burstcount ),
        .master_waitrequest   (f_avm_waitrequest)
    );

/**********************************************************/
// Outputs to Datapath
/**********************************************************/
//assign o_stall = i_valid_rr & (i_stall | internal_flush | wait_for_read);
assign o_stall = ((o_valid & i_stall) | internal_flush | (wait_for_read & i_valid_rr));
//assign o_valid = i_valid_rr & !o_stall;
assign o_valid = i_valid_rr & !(internal_flush | wait_for_read);
// Handle different user/memory word sizes
// Width adapting signals
generate
    if(MBYTE_SELECT_BITS != BYTE_SELECT_BITS) begin
        assign o_readdata = user_data_out[i_address_rr[MBYTE_SELECT_BITS-1:BYTE_SELECT_BITS] * WIDTH +: WIDTH];
    end else begin
        // Widths are matched, every request is a new memory word
        assign o_readdata = user_data_out;
    end
endgenerate


endmodule


//------------------------------------------------------------------
// This module implements a FIFO using a dual port memory
//    It differs from a FIFO in that the read pointer can skip ahead
//    an arbitrary number of addresses to drop unused data
// All addressing is done at the memory word level
//------------------------------------------------------------------
module lsu_streaming_prefetch_fifo # (
        parameter DEPTH             = 64, //must be a power of two
        parameter LOG2_DEPTH        = 6,
        parameter MWIDTH             = 256,
        parameter AWIDTH            = 32,
        parameter MBYTE_SELECT_BITS = 5,
        parameter MAXBURSTCOUNT     = 64, //must be a power of two
        parameter BURSTCOUNT_WIDTH  = 6
    ) (
        input clk,
        input reset,
        input flush_external,
        input flush_internal,

        // from user
        input          [AWIDTH - 1 : 0] user_read_addr   ,
        input          [AWIDTH - 1 : 0] user_read_addr_r ,
        input                           user_valid       ,
        input                           user_valid_r     ,
        output         [MWIDTH - 1 : 0] user_data_out    ,
        output                          wait_for_read    ,
        input                           i_stall          ,

        // for comparison with incoming user addr
        output reg              empty,
        output [AWIDTH - 1 : 0] fifo_high_addr,

        // to burst master
        output reg          [AWIDTH - 1 : 0] avm_read_addr,
        output reg                           avm_read,
        output reg [BURSTCOUNT_WIDTH -1 : 0] avm_burst_size,
        input                                avm_data_valid,
        input                [MWIDTH -1 : 0] avm_data,
        input                                avm_ready
    );

    //-------------------------------------
    // Signals
    //-------------------------------------

    // FIFO memory
    reg [MWIDTH - 1 : 0] mem [0 : DEPTH - 1];    

    // FIFO ctrl
    wire [LOG2_DEPTH - 1 : 0] rd_fifo_addr;
    wire [LOG2_DEPTH - 1 : 0] wr_fifo_addr;
    reg  [LOG2_DEPTH - 1 : 0] num_words_in_fifo;
    reg      [AWIDTH - 1 : 0] wr_addr;

    reg [MWIDTH - 1 : 0] fifo_data_out;

    wire avm_read_success;
    reg  avm_read_success_r;
    wire [BURSTCOUNT_WIDTH - 2 : 0] first_burst_boundary_word_address;
    wire [BURSTCOUNT_WIDTH - 2 : 0] avm_burst_boundary_word_address;

    wire [AWIDTH - MBYTE_SELECT_BITS - 1 : 0] user_read_addr_word;
    wire [AWIDTH - MBYTE_SELECT_BITS - 1 : 0] user_read_addr_r_word;
    wire [AWIDTH - MBYTE_SELECT_BITS - 1 : 0] avm_read_addr_word;
    wire [AWIDTH - MBYTE_SELECT_BITS - 1 : 0] wr_addr_word;
    wire [AWIDTH - MBYTE_SELECT_BITS - 1 : 0] fifo_addr_diff;

    wire flush;
    wire fifo_flush;
    reg flush_r;

    reg fifo_addr_diff_overflow;
    reg [1:0] avm_ctrl_state;

    wire wait_for_read_int;
    reg wait_for_read_int_r;
    //reg wait_for_read_int_rr;
    //reg [MWIDTH -1 : 0] avm_data_r;

    //-------------------------------------
    // Logic
    //-------------------------------------

    assign flush = flush_external | flush_internal;

    // force flush to only be active for one cycle
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            flush_r <= 0;
        end else begin
            flush_r <= flush;
        end
    end

    assign fifo_flush = flush & !flush_r;

    // FIFO ctrl logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            wr_addr <= 0;
            empty <= 1;
        end else begin
            if (fifo_flush) begin
                wr_addr <= user_read_addr_r;
                empty   <= ~user_valid_r;
            end else begin

                if (avm_data_valid) begin
                    wr_addr <= wr_addr + (1 << MBYTE_SELECT_BITS);
                end

                empty <= empty & ~user_valid;
            end
        end
    end

    assign user_read_addr_word   = (user_read_addr   >> MBYTE_SELECT_BITS);
    assign user_read_addr_r_word = (user_read_addr_r >> MBYTE_SELECT_BITS);
    assign avm_read_addr_word    = (avm_read_addr    >> MBYTE_SELECT_BITS);
    assign wr_addr_word          = (wr_addr          >> MBYTE_SELECT_BITS);
    assign wr_fifo_addr = wr_addr_word & {LOG2_DEPTH{1'b1}};

    //assign rd_fifo_addr = user_read_addr_word & {LOG2_DEPTH{1'b1}};
    assign rd_fifo_addr = wait_for_read_int_r ? (user_read_addr_r_word & {LOG2_DEPTH{1'b1}}) : 
                                                (user_read_addr_word   & {LOG2_DEPTH{1'b1}}) ;

    assign fifo_addr_diff = {1'b0, avm_read_addr_word} - {1'b0, user_read_addr_r_word};


    // FIFO memory
    always @(posedge clk) begin
        if (avm_data_valid) begin
            mem[wr_fifo_addr] <= avm_data;
        end

        if (!i_stall) begin
            fifo_data_out <= mem[rd_fifo_addr];
        end
    end

    // bypass the FIFO on a flush
    //assign user_data_out = (wait_for_read_int_rr) ? avm_data_r : fifo_data_out;
    //assign user_data_out = (wait_for_read_int_r) ? avm_data_r : fifo_data_out;
    assign user_data_out = fifo_data_out;

    // Memory addresses
    assign fifo_high_addr = avm_read_addr;

    // check if a read is pending from the burst master
    // delay the output by a cycle to allow the read data to propogate through the FIFO
    //assign wait_for_read_int = (user_read_addr_r >= wr_addr);
    // unless fifo is flushed, the read address and write address will never be more than the fifo depth apart here, so we can compare them with only one additional bit
    //assign wait_for_read_int = (((user_read_addr_r >> MBYTE_SELECT_BITS) & {(LOG2_DEPTH+1){1'b1}}) >= ((wr_addr >> MBYTE_SELECT_BITS) & {(LOG2_DEPTH+1){1'b1}}));
    //assign wait_for_read_int = (user_read_addr_r_word >= wr_addr_word);
    assign wait_for_read_int = (user_read_addr_word >= wr_addr_word);
    //assign wait_for_read_int = (user_read_addr_r[LOG2_DEPTH + 1 + MBYTE_SELECT_BITS : MBYTE_SELECT_BITS]  >= wr_addr[LOG2_DEPTH + 1 + MBYTE_SELECT_BITS : MBYTE_SELECT_BITS]);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            wait_for_read_int_r <= 0;
            //wait_for_read_int_rr <= 0;
        end else begin
            wait_for_read_int_r  <= flush_external ? 0 : ( flush_internal | (wait_for_read_int_r ? ((user_read_addr_r_word >= wr_addr_word) | i_stall) : wait_for_read_int));
            //wait_for_read_int_rr <= wait_for_read_int_r;
            //avm_data_r <= avm_data;
        end
    end
    assign wait_for_read = wait_for_read_int_r;
    //assign wait_for_read = wait_for_read_int | wait_for_read_int_r;

    // Avalon burst master control
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            avm_read_addr  <= 0;
            avm_burst_size <= 0;
            avm_read       <= 0;
            num_words_in_fifo <= 0;
            fifo_addr_diff_overflow <= 0;
            avm_ctrl_state    <= 0;
            avm_read_success_r <= 0;
        end else begin
            // override everything if flushed
            if (fifo_flush) begin
                num_words_in_fifo <= 0;
                fifo_addr_diff_overflow <= 0;
                avm_ctrl_state    <= 0;
                avm_read          <= user_valid_r; //we know we are reading immediately after a flush if the user data is valid
                avm_read_addr     <= user_read_addr_r;
                avm_burst_size    <= (first_burst_boundary_word_address & 1) ? 1 : (MAXBURSTCOUNT - first_burst_boundary_word_address);
                avm_read_success_r <= 0;
            end else begin
                avm_read_addr  <= (avm_read_addr + (avm_read_success ? (avm_burst_size << MBYTE_SELECT_BITS) : 0));
                avm_burst_size <= avm_read_success_r ? (MAXBURSTCOUNT - avm_burst_boundary_word_address) : avm_burst_size; //updating the burst count one cycle after a read to get proper read address - this is safe because we only read once every 3 cycles
                num_words_in_fifo <= fifo_addr_diff[LOG2_DEPTH - 1 : 0];
                fifo_addr_diff_overflow <= fifo_addr_diff[AWIDTH - MBYTE_SELECT_BITS - 1];

                avm_ctrl_state <= avm_ctrl_state[1] ? 0 : (avm_ctrl_state + 1); //issue a read every three cycles to better pipeline the FIFO tracking calculations
                avm_read <= (avm_ctrl_state == 2) & !empty & (fifo_addr_diff_overflow | (num_words_in_fifo < (DEPTH - MAXBURSTCOUNT))); // read from memory if there is enough room in the FIFO
                avm_read_success_r <= avm_read_success;
            end

        end
    end

    // Handle different burstcount width size.
    generate
        if(BURSTCOUNT_WIDTH == 1) begin
            // For burstcount width of 1
            assign first_burst_boundary_word_address = 0;
            assign avm_burst_boundary_word_address = 0;
        end else begin
            assign first_burst_boundary_word_address = (user_read_addr_r >> MBYTE_SELECT_BITS) & {(BURSTCOUNT_WIDTH - 1){1'b1}};
            assign avm_burst_boundary_word_address   = (avm_read_addr >> MBYTE_SELECT_BITS)    & {(BURSTCOUNT_WIDTH - 1){1'b1}};
        end
    endgenerate

    assign avm_read_success = avm_read & avm_ready;

endmodule

//------------------------------------------------------------------
// convert read requests into bursts on the avalon bus
//------------------------------------------------------------------
module lsu_streaming_prefetch_avalon_bust_master #(
        parameter AWIDTH           = 32,
        parameter MWIDTH           = 256,
        parameter MWIDTH_BYTES     = 32,
        parameter BURSTCOUNT_WIDTH = 6,
        parameter FIFO_DEPTH_LOG2   = 5
    ) (
        input clk,
        input reset,
        input flush,
        output active,

        // from FIFO
        output                            ready,
        input            [AWIDTH - 1 : 0] fifo_read_addr,
        input                             fifo_read,
        input  [BURSTCOUNT_WIDTH - 1 : 0] fifo_burst_size,
        output                            fifo_data_valid,
        output            [MWIDTH -1 : 0] fifo_data,

        // master inputs and outputs
        output           [AWIDTH - 1 : 0] master_address,
        output                            master_read,
        output     [MWIDTH_BYTES - 1 : 0] master_byteenable,
        input            [MWIDTH - 1 : 0] master_readdata,
        input                             master_readdatavalid,
        output [BURSTCOUNT_WIDTH - 1 : 0] master_burstcount,
        input                             master_waitrequest
    );

    reg  [FIFO_DEPTH_LOG2 : 0] pending_reads;
    reg  [FIFO_DEPTH_LOG2 : 0] pending_discards; //at most we will need to discard 2 full bursts of data
    wire                      keep_read;
    wire                      avm_read_accepted;
    wire                      finished_discard;
    wire                      can_discard_full_burst;

    // track pending reads
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pending_reads <= 0;
            pending_discards <= 0;
        end else begin
            if (flush) begin
                pending_reads <= 0;
                pending_discards <= pending_discards + pending_reads - master_readdatavalid;
            end else begin
                pending_reads <= pending_reads + (avm_read_accepted ? master_burstcount : 0) - keep_read;
                pending_discards <= pending_discards - (~finished_discard & master_readdatavalid);
            end
        end
    end

    assign finished_discard = (pending_discards == 0);
    assign can_discard_full_burst = ~pending_discards[FIFO_DEPTH_LOG2];
    assign keep_read = finished_discard & master_readdatavalid;
    assign avm_read_accepted = master_read & !master_waitrequest;

    // check for memory stall
    assign ready = !master_waitrequest & can_discard_full_burst;

    assign master_address = fifo_read_addr;
    assign master_read = fifo_read & can_discard_full_burst & !flush;
    assign master_byteenable = {MWIDTH_BYTES{1'b1}};
    assign master_burstcount = fifo_burst_size;

    assign fifo_data = master_readdata;
    assign fifo_data_valid = keep_read;

    assign active = |pending_reads | ~finished_discard;

endmodule


// vim:set filetype=verilog:
