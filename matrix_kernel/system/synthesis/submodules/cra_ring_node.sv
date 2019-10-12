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

module cra_ring_node #(
    parameter integer ASYNC_RESET = 1,          // how do we use reset: 1 means registers are reset asynchronously, 0 means registers are reset synchronously
    parameter integer SYNCHRONIZE_RESET = 0,    // based on how reset gets to us, what do we need to do: 1 means synchronize reset before consumption (if reset arrives asynchronously), 0 means passthrough (managed externally)
    parameter integer RING_ADDR_W = 32,
    parameter integer CRA_ADDR_W = 32,
    parameter integer DATA_W = 32,
    parameter integer ID_W = 3,
    parameter logic[ID_W-1:0] ID = 3'd0
)
(
    // clock/reset
    input wire clk,
    input wire rst_n,

    // avalon-master port
    output logic avm_read,
    output logic avm_write,
    output logic [CRA_ADDR_W-1:0] avm_addr,
    output logic [DATA_W/8-1:0] avm_byteena,
    output logic [DATA_W-1:0] avm_writedata,
    input wire [DATA_W-1:0] avm_readdata,
    input wire avm_readdatavalid,

    // ring-in
    input wire ri_read,
    input wire ri_write,
    input wire [RING_ADDR_W+ID_W-1:0] ri_addr,
    input wire [DATA_W-1:0] ri_data,
    input wire [DATA_W/8-1:0] ri_byteena,
    input wire ri_datavalid,
    
    // ring-out
    output logic ro_read,
    output logic ro_write,
    output logic [RING_ADDR_W+ID_W-1:0] ro_addr,
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

// The avalon master connection
logic id_match;
generate if(ID_W == 0)
    assign id_match = 1'b1;
else
    assign id_match = (ri_addr[RING_ADDR_W+ID_W-1:RING_ADDR_W] == ID);
endgenerate
always@(posedge clk or negedge aclrn) begin
    if (~aclrn) begin
        avm_read <= 1'b0;
        avm_write <= 1'b0;
        avm_addr <= 'x;
        avm_byteena <= 'x;
        avm_writedata <= 'x;
    end
    else begin
        avm_read <= ri_read && id_match;
        avm_write <= ri_write && id_match;
        avm_addr <= ri_addr[CRA_ADDR_W-1:0]; // Throw away upper address bits
        avm_byteena <= ri_byteena;
        avm_writedata <= ri_data;
        if (~sclrn) begin
            avm_read <= 1'b0;
            avm_write <= 1'b0;
        end
    end
end

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
        ro_read <= ri_read && !id_match;
        ro_write <= ri_write && !id_match;
        ro_addr <= ri_addr;
        ro_data <= avm_readdatavalid ? avm_readdata : ri_data;
        ro_byteena <= ri_byteena;
        ro_datavalid <= avm_readdatavalid | ri_datavalid;
        if (~sclrn) begin
            ro_read <= 1'b0;
            ro_write <= 1'b0;
            ro_datavalid <= 1'b0;
        end
    end
end
endmodule

`default_nettype wire
