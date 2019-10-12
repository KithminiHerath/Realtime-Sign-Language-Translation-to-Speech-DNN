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

module cra_ring_root #(
    parameter integer ASYNC_RESET = 1,          // how do we use reset: 1 means registers are reset asynchronously, 0 means registers are reset synchronously
    parameter integer SYNCHRONIZE_RESET = 0,    // based on how reset gets to us, what do we need to do: 1 means synchronize reset before consumption (if reset arrives asynchronously), 0 means passthrough (managed externally)
    parameter integer ADDR_W = 32,
    parameter integer DATA_W = 32,
    parameter integer ID_W = 3,
    parameter integer ROM_EXT_W = 0,
    parameter integer ROM_ENABLE = 0
)
(
    // clock/reset
    input wire clk,
    input wire rst_n,

    // avalon-slave port
    input wire avs_read,
    input wire avs_write,
    input wire [ADDR_W+ID_W+ROM_EXT_W+ROM_ENABLE-1:0] avs_addr,
    input wire [DATA_W/8-1:0] avs_byteena,
    input wire [DATA_W-1:0] avs_writedata,
    output logic [DATA_W-1:0] avs_readdata,
    output logic avs_readdatavalid,
    output logic avs_waitrequest,

    // ring-in
    input wire ri_read,
    input wire ri_write,
    input wire [ADDR_W+ID_W-1:0] ri_addr,
    input wire [DATA_W-1:0] ri_data,
    input wire [DATA_W/8-1:0] ri_byteena,
    input wire ri_datavalid,
    
    // ring-out
    output logic ro_read,
    output logic ro_write,
    output logic [ADDR_W+ID_W+ROM_EXT_W+ROM_ENABLE-1:0] ro_addr,
    output logic [DATA_W-1:0] ro_data,
    output logic [DATA_W/8-1:0] ro_byteena,
    output logic ro_datavalid
);

logic aclrn, sclrn;
acl_reset_handler
#(
    .ASYNC_RESET            (ASYNC_RESET),
    .USE_SYNCHRONIZER       (SYNCHRONIZE_RESET),
    .SYNCHRONIZE_ACLRN      (SYNCHRONIZE_RESET),
    .PIPE_DEPTH             (1),
    .NUM_COPIES             (1)
)
acl_reset_handler_inst
(
    .clk                    (clk),
    .i_resetn               (rst_n),
    .o_aclrn                (aclrn),
    .o_resetn_synchronized  (),
    .o_sclrn                (sclrn)
);

// case:199865 (scheduled for clean-up in case:200564): ISR concurrent to the
// main thread may issue a request immediately following a read.  The CRA ring
// is not latency balanced so this can lead to a conflict on the shared data
// bus.  Quick fix: each read blocks until the response is sent back.
logic pending;
always@(posedge clk or negedge aclrn) begin
    if (~aclrn) begin
        pending <= 1'b0;
    end
    else begin
        pending <= pending ? (!ri_datavalid) : avs_read;
        if (~sclrn) begin
            pending <= 1'b0;
        end
    end
end

// The avalon slave connection
always@(posedge clk or negedge aclrn) begin
    if (~aclrn) begin
        avs_readdatavalid <= 1'b0;
        avs_readdata <= 'x;
    end
    else begin
        avs_readdatavalid <= ri_datavalid;
        avs_readdata <= ri_data;
        if (~sclrn) begin
            avs_readdatavalid <= 1'b0;
        end
    end
end

// Backpressure should get swept away except in the profiler flow
assign avs_waitrequest = pending;

// The ring output
always@(posedge clk or negedge aclrn) begin
    if (~aclrn) begin
        ro_read <= 1'b0;
        ro_write <= 1'b0;
        ro_datavalid <= 1'b0;
        ro_addr <= 'x;
        ro_data <= 'x;
        ro_byteena <= 'x;
    end
    else begin
        ro_read <= avs_read && !avs_waitrequest;
        ro_write <= avs_write && !avs_waitrequest;
        ro_addr <= avs_addr;
        ro_data <= avs_writedata;
        ro_byteena <= avs_byteena;
        ro_datavalid <= 1'b0;
        if (~sclrn) begin
            ro_read <= 1'b0;
            ro_write <= 1'b0;
            ro_datavalid <= 1'b0;
        end
    end
end
endmodule

`default_nettype wire
