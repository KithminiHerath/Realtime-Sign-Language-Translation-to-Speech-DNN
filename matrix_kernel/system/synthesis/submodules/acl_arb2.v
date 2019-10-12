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


`default_nettype none
module acl_arb2
#(
    // Configuration
    parameter string  PIPELINE = "data_stall",    // none|data|stall|data_stall|stall_data
    parameter integer KEEP_LAST_GRANT = 1,       // 0|1 - if one request can last multiple cycles (e.g. write burst), KEEP_LAST_GRANT must be 1
    parameter integer NO_STALL_NETWORK = 0,      // 0|1 - if one, remove the ability for arb to stall backward - must guarantee no collisions!
    parameter ASYNC_RESET = 1,                   // 1 = Registers are reset asynchronously. 0 = Registers are reset synchronously -- the reset signal is pipelined before consumption. In both cases, some registesr are not reset at all.
    parameter SYNCHRONIZE_RESET = 0,             // 1 = resetn is synchronized before consumption. The consumption itself is either asynchronous or synchronous, as specified by ASYNC_RESET.

    // Masters
    parameter integer DATA_W = 32,               // > 0
    parameter integer BURSTCOUNT_W = 4,          // > 0
    parameter integer ADDRESS_W = 32,            // > 0
    parameter integer BYTEENA_W = DATA_W / 8,    // > 0
    parameter integer ID_W = 1                   // > 0
)
(
    // INPUTS

    input wire clock,
    input wire resetn,

    // INTERFACES

    acl_arb_intf m0_intf,
    acl_arb_intf m1_intf,
    acl_arb_intf mout_intf
);

    localparam                    NUM_RESET_COPIES = 1;
    localparam                    RESET_PIPE_DEPTH = 3;
    /* 
        Currently aclrn and sclrn are not actually consumed at this level of hierarchy and normally we don't keep dead code around, but keeping them here (and hooking them
        up properly) as a reminder to the next developer who adds logic at this level to use these signals.
    */
    logic                         aclrn;    
    logic [NUM_RESET_COPIES-1:0]  sclrn;
    logic                         resetn_synchronized;

    /*
      If SYNCHRONIZE_RESET==1, the synchronized version of resetn is distributed down the hierarchy to submodules, and submodules will not synchronize again.
    */
    acl_reset_handler
    #(
        .ASYNC_RESET            (ASYNC_RESET),
        .USE_SYNCHRONIZER       (SYNCHRONIZE_RESET),
        .SYNCHRONIZE_ACLRN      (SYNCHRONIZE_RESET),
        .PIPE_DEPTH             (RESET_PIPE_DEPTH),
        .NUM_COPIES             (NUM_RESET_COPIES) 
    )
    acl_reset_handler_inst
    (
        .clk                    (clock),
        .i_resetn               (resetn),
        .o_aclrn                (aclrn),
        .o_resetn_synchronized  (resetn_synchronized),  
        .o_sclrn                (sclrn)
    );

    /////////////////////////////////////////////
    // ARCHITECTURE
    /////////////////////////////////////////////

    // mux_intf acts as an interface immediately after request arbitration
    acl_arb_intf #(
        .DATA_W( DATA_W ),
        .BURSTCOUNT_W( BURSTCOUNT_W ),
        .ADDRESS_W( ADDRESS_W ),
        .BYTEENA_W( BYTEENA_W ),
        .ID_W( ID_W )
    )
    mux_intf();

    // Selector and request arbitration.
    logic mux_sel;

    assign mux_intf.req = mux_sel ? m1_intf.req : m0_intf.req;

    generate
    if( KEEP_LAST_GRANT == 1 )
    begin
        logic last_mux_sel_r;

        always_ff @( posedge clock )
            last_mux_sel_r <= mux_sel;

        always_comb
            // Maintain last grant.
            if( last_mux_sel_r == 1'b0 && m0_intf.req.request )
                mux_sel = 1'b0;
            else if( last_mux_sel_r == 1'b1 && m1_intf.req.request )
                mux_sel = 1'b1;
            // Arbitrarily favor m0.
            else
                mux_sel = m0_intf.req.request ? 1'b0 : 1'b1;
    end
    else
    begin
        // Arbitrarily favor m0.
        assign mux_sel = m0_intf.req.request ? 1'b0 : 1'b1;
    end
    endgenerate

    // Stall signal for each upstream master.
    generate
    if( NO_STALL_NETWORK == 1 )
    begin
       assign m0_intf.stall = '0;
       assign m1_intf.stall = '0;
    end
    else
    begin
       assign m0_intf.stall = ( mux_sel & m1_intf.req.request) | mux_intf.stall;
       assign m1_intf.stall = (~mux_sel & m0_intf.req.request) | mux_intf.stall;
    end
    endgenerate


    // What happens at the output of the arbitration block? Depends on the pipelining option...
    // Each option is responsible for the following:
    //  1. Connecting mout_intf.req: request output of the arbitration block
    //  2. Connecting mux_intf.stall: upstream (to input masters) stall signal
    generate
    if( PIPELINE == "none" )
    begin
        // Purely combinational. Not a single register to be seen.

        // Request for downstream blocks.
        assign mout_intf.req = mux_intf.req;

        // Stall signal from downstream blocks
        assign mux_intf.stall = mout_intf.stall;
    end
    else if( PIPELINE == "data" )
    begin
        // Standard pipeline register at output. Latency of one cycle.

        acl_arb_intf #(
            .DATA_W( DATA_W ),
            .BURSTCOUNT_W( BURSTCOUNT_W ),
            .ADDRESS_W( ADDRESS_W ),
            .BYTEENA_W( BYTEENA_W ),
            .ID_W( ID_W )
        )
        pipe_intf();

        acl_arb_pipeline_reg #(
            .DATA_W( DATA_W ),
            .BURSTCOUNT_W( BURSTCOUNT_W ),
            .ADDRESS_W( ADDRESS_W ),
            .BYTEENA_W( BYTEENA_W ),
            .ID_W( ID_W ),
            .ASYNC_RESET(ASYNC_RESET),
            .SYNCHRONIZE_RESET(0)
        )
        pipe(
            .clock( clock ),
            .resetn( resetn_synchronized ),

            .in_intf( mux_intf ),
            .out_intf( pipe_intf )
        );

        // Request for downstream blocks.
        assign mout_intf.req = pipe_intf.req;

        // Stall signal from downstream blocks.
        assign pipe_intf.stall = mout_intf.stall;
    end
    else if( PIPELINE == "stall" )
    begin
        // Staging register at output. Min. latency of zero cycles, max. latency of one cycle.

        acl_arb_intf #(
            .DATA_W( DATA_W ),
            .BURSTCOUNT_W( BURSTCOUNT_W ),
            .ADDRESS_W( ADDRESS_W ),
            .BYTEENA_W( BYTEENA_W ),
            .ID_W( ID_W )
        )
        staging_intf();

        acl_arb_staging_reg #(
            .DATA_W( DATA_W ),
            .BURSTCOUNT_W( BURSTCOUNT_W ),
            .ADDRESS_W( ADDRESS_W ),
            .BYTEENA_W( BYTEENA_W ),
            .ID_W( ID_W ),
            .ASYNC_RESET(ASYNC_RESET),
            .SYNCHRONIZE_RESET(0)            
        )
        staging(
            .clock( clock ),
            .resetn( resetn_synchronized ),

            .in_intf( mux_intf ),
            .out_intf( staging_intf )
        );

        // Request for downstream blocks.
        assign mout_intf.req = staging_intf.req;

        // Stall signal from downstream blocks.
        assign staging_intf.stall = mout_intf.stall;
    end
    else if( PIPELINE == "data_stall" )
    begin
        // Pipeline register followed by staging register at output. Min. latency
        // of one cycle, max. latency of two cycles.

        acl_arb_intf #(
            .DATA_W( DATA_W ),
            .BURSTCOUNT_W( BURSTCOUNT_W ),
            .ADDRESS_W( ADDRESS_W ),
            .BYTEENA_W( BYTEENA_W ),
            .ID_W( ID_W )
        )
        pipe_intf(), staging_intf();

        acl_arb_pipeline_reg #(
            .DATA_W( DATA_W ),
            .BURSTCOUNT_W( BURSTCOUNT_W ),
            .ADDRESS_W( ADDRESS_W ),
            .BYTEENA_W( BYTEENA_W ),
            .ID_W( ID_W ),
            .ASYNC_RESET(ASYNC_RESET),
            .SYNCHRONIZE_RESET(0)            
        )
        pipe(
            .clock( clock ),
            .resetn( resetn_synchronized ),

            .in_intf( mux_intf ),
            .out_intf( pipe_intf )
        );

        acl_arb_staging_reg #(
            .DATA_W( DATA_W ),
            .BURSTCOUNT_W( BURSTCOUNT_W ),
            .ADDRESS_W( ADDRESS_W ),
            .BYTEENA_W( BYTEENA_W ),
            .ID_W( ID_W ),
            .ASYNC_RESET(ASYNC_RESET),
            .SYNCHRONIZE_RESET(0)            
        )
        staging(
            .clock( clock ),
            .resetn( resetn_synchronized ),

            .in_intf( pipe_intf ),
            .out_intf( staging_intf )
        );

        // Request for downstream blocks.
        assign mout_intf.req = staging_intf.req;        

        // Stall signal from downstream blocks.
        assign staging_intf.stall = mout_intf.stall;
    end
    else if( PIPELINE == "stall_data" )
    begin
        // Staging register followed by pipeline register at output. Min. latency
        // of one cycle, max. latency of two cycles.

        acl_arb_intf #(
            .DATA_W( DATA_W ),
            .BURSTCOUNT_W( BURSTCOUNT_W ),
            .ADDRESS_W( ADDRESS_W ),
            .BYTEENA_W( BYTEENA_W ),
            .ID_W( ID_W )
        )
        staging_intf(), pipe_intf();

        acl_arb_staging_reg #(
            .DATA_W( DATA_W ),
            .BURSTCOUNT_W( BURSTCOUNT_W ),
            .ADDRESS_W( ADDRESS_W ),
            .BYTEENA_W( BYTEENA_W ),
            .ID_W( ID_W ),
            .ASYNC_RESET(ASYNC_RESET),
            .SYNCHRONIZE_RESET(0)            
        )
        staging(
            .clock( clock ),
            .resetn( resetn_synchronized ),

            .in_intf( mux_intf ),
            .out_intf( staging_intf )
        );

        acl_arb_pipeline_reg #(
            .DATA_W( DATA_W ),
            .BURSTCOUNT_W( BURSTCOUNT_W ),
            .ADDRESS_W( ADDRESS_W ),
            .BYTEENA_W( BYTEENA_W ),
            .ID_W( ID_W ),
            .ASYNC_RESET(ASYNC_RESET),
            .SYNCHRONIZE_RESET(0)            
        )
        pipe(
            .clock( clock ),
            .resetn( resetn_synchronized ),

            .in_intf( staging_intf ),
            .out_intf( pipe_intf )
        );

        // Request for downstream blocks.
        assign mout_intf.req = pipe_intf.req;

        // Stall signal from downstream blocks.
        assign pipe_intf.stall = mout_intf.stall;
    end
    endgenerate
endmodule

module acl_arb_pipeline_reg #(
    parameter integer DATA_W = 32,              // > 0
    parameter integer BURSTCOUNT_W = 4,         // > 0
    parameter integer ADDRESS_W = 32,           // > 0
    parameter integer BYTEENA_W = DATA_W / 8,   // > 0
    parameter integer ID_W = 1,                  // > 0
    parameter ASYNC_RESET = 1,                   // 1 = Registers are reset asynchronously. 0 = Registers are reset synchronously -- the reset signal is pipelined before consumption. In both cases, some registesr are not reset at all.
    parameter SYNCHRONIZE_RESET = 0              // 1 = resetn is synchronized before consumption. The consumption itself is either asynchronous or synchronous, as specified by ASYNC_RESET.
)
(
    input wire clock,
    input wire resetn,

    acl_arb_intf in_intf,
    acl_arb_intf out_intf
);
    
    localparam                    NUM_RESET_COPIES = 1;
    localparam                    RESET_PIPE_DEPTH = 3;
    logic                         aclrn;
    logic [NUM_RESET_COPIES-1:0]  sclrn;

    acl_reset_handler
    #(
        .ASYNC_RESET            (ASYNC_RESET),
        .USE_SYNCHRONIZER       (SYNCHRONIZE_RESET),
        .SYNCHRONIZE_ACLRN      (SYNCHRONIZE_RESET),
        .PIPE_DEPTH             (RESET_PIPE_DEPTH),
        .NUM_COPIES             (NUM_RESET_COPIES) 
    )
    acl_reset_handler_inst
    (
        .clk                    (clock),
        .i_resetn               (resetn),
        .o_aclrn                (aclrn),
        .o_resetn_synchronized  (),  
        .o_sclrn                (sclrn)
    );

    acl_arb_data #(
        .DATA_W( DATA_W ),
        .BURSTCOUNT_W( BURSTCOUNT_W ),
        .ADDRESS_W( ADDRESS_W ),
        .BYTEENA_W( BYTEENA_W ),
        .ID_W( ID_W )
    ) 
    pipe_r();

    // Pipeline register.
    always @( posedge clock or negedge aclrn ) begin
        if( !aclrn ) begin
            pipe_r.req <= 'x;   // only signals reset explicitly below need to be reset at all

            pipe_r.req.request <= 1'b0;
            pipe_r.req.read <= 1'b0;
            pipe_r.req.write <= 1'b0;
        end else begin
            if( !(out_intf.stall & pipe_r.req.request) & in_intf.req.enable) begin
                pipe_r.req <= in_intf.req;
            end

            if (!sclrn[0]) begin
                pipe_r.req.request <= 1'b0;
                pipe_r.req.read <= 1'b0;
                pipe_r.req.write <= 1'b0;            
            end
        end
    end

    // Request for downstream blocks.
    assign out_intf.req.enable     = in_intf.req.enable    ; //the enable must bypass the register
    assign out_intf.req.request    = pipe_r.req.request    ;
    assign out_intf.req.read       = pipe_r.req.read       ;
    assign out_intf.req.write      = pipe_r.req.write      ;
    assign out_intf.req.writedata  = pipe_r.req.writedata  ;
    assign out_intf.req.burstcount = pipe_r.req.burstcount ;
    assign out_intf.req.address    = pipe_r.req.address    ;
    assign out_intf.req.byteenable = pipe_r.req.byteenable ;
    assign out_intf.req.id         = pipe_r.req.id         ;    

    // Upstream stall signal.
    assign in_intf.stall = out_intf.stall & pipe_r.req.request;
endmodule

module acl_arb_staging_reg #(
    parameter integer DATA_W = 32,              // > 0
    parameter integer BURSTCOUNT_W = 4,         // > 0
    parameter integer ADDRESS_W = 32,           // > 0
    parameter integer BYTEENA_W = DATA_W / 8,   // > 0
    parameter integer ID_W = 1,                  // > 0
    parameter ASYNC_RESET = 1,                   // 1 = Registers are reset asynchronously. 0 = Registers are reset synchronously -- the reset signal is pipelined before consumption. In both cases, some registesr are not reset at all.
    parameter SYNCHRONIZE_RESET = 0              // 1 = resetn is synchronized before consumption. The consumption itself is either asynchronous or synchronous, as specified by ASYNC_RESET.

)
(
    input wire clock,
    input wire resetn,

    acl_arb_intf in_intf,
    acl_arb_intf out_intf
);
    logic stall_r;

    localparam                    NUM_RESET_COPIES = 1;
    localparam                    RESET_PIPE_DEPTH = 3;
    logic                         aclrn;
    logic [NUM_RESET_COPIES-1:0]  sclrn;

    acl_reset_handler
    #(
        .ASYNC_RESET            (ASYNC_RESET),
        .USE_SYNCHRONIZER       (SYNCHRONIZE_RESET),
        .SYNCHRONIZE_ACLRN      (SYNCHRONIZE_RESET),
        .PIPE_DEPTH             (RESET_PIPE_DEPTH),
        .NUM_COPIES             (NUM_RESET_COPIES) 
    )
    acl_reset_handler_inst
    (
        .clk                    (clock),
        .i_resetn               (resetn),
        .o_aclrn                (aclrn),
        .o_resetn_synchronized  (),  
        .o_sclrn                (sclrn)
    );


    acl_arb_data #(
        .DATA_W( DATA_W ),
        .BURSTCOUNT_W( BURSTCOUNT_W ),
        .ADDRESS_W( ADDRESS_W ),
        .BYTEENA_W( BYTEENA_W ),
        .ID_W( ID_W )
    ) 
    staging_r();

    // Staging register.
    always @( posedge clock or negedge aclrn ) begin
        if( !aclrn )
        begin
            staging_r.req <= 'x;    // only signals reset explicitly below need to be reset at all

            staging_r.req.request <= 1'b0;
            staging_r.req.read <= 1'b0;
            staging_r.req.write <= 1'b0;
        end else begin
            if ( !stall_r ) begin
                staging_r.req <= in_intf.req;
            end

            if (!sclrn[0]) begin
                staging_r.req.request <= 1'b0;
                staging_r.req.read <= 1'b0;
                staging_r.req.write <= 1'b0;
            end
        end
        
    end

    // Stall register.
    always @( posedge clock or negedge aclrn ) begin
        if ( !aclrn ) begin
            stall_r <= 1'b0;
        end else begin
            stall_r <= out_intf.stall & (stall_r | in_intf.req.request);

            if (!sclrn[0]) begin
                stall_r <= 1'b0;
            end
        end
    end
    // Request for downstream blocks.
    assign out_intf.req = stall_r ? staging_r.req : in_intf.req;

    // Upstream stall signal.
    assign in_intf.stall = stall_r;
endmodule
`default_nettype wire
