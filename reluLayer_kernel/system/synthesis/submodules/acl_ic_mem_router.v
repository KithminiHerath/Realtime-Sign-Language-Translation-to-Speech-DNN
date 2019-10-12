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


module acl_ic_mem_router #(    
    parameter integer DATA_W = 256,
    parameter integer BURSTCOUNT_W = 6,
    parameter integer ADDRESS_W = 32,
    parameter integer BYTEENA_W = DATA_W / 8,

    parameter integer NUM_BANKS = 2
)
(
    input logic clock,
    input logic resetn,

    // Bank select (one-hot)
    input logic [NUM_BANKS-1:0] bank_select,

    // Master
    input logic m_arb_enable,
    input logic m_arb_request,
    input logic m_arb_read,
    input logic m_arb_write,
    input logic [DATA_W-1:0] m_arb_writedata,
    input logic [BURSTCOUNT_W-1:0] m_arb_burstcount,
    input logic [ADDRESS_W-1:0] m_arb_address,
    input logic [BYTEENA_W-1:0] m_arb_byteenable,

    output logic m_arb_stall,

    output logic m_wrp_ack,

    output logic m_rrp_datavalid,
    output logic [DATA_W-1:0] m_rrp_data,

    // To each bank
    output logic b_arb_enable  [NUM_BANKS],
    output logic b_arb_request [NUM_BANKS],
    output logic b_arb_read [NUM_BANKS],
    output logic b_arb_write [NUM_BANKS],
    output logic [DATA_W-1:0] b_arb_writedata [NUM_BANKS],
    output logic [BURSTCOUNT_W-1:0] b_arb_burstcount [NUM_BANKS],
    output logic [ADDRESS_W-$clog2(NUM_BANKS)-1:0] b_arb_address [NUM_BANKS],
    output logic [BYTEENA_W-1:0] b_arb_byteenable [NUM_BANKS],

    input logic b_arb_stall [NUM_BANKS],

    input logic b_wrp_ack [NUM_BANKS],

    input logic b_rrp_datavalid [NUM_BANKS],
    input logic [DATA_W-1:0] b_rrp_data [NUM_BANKS]
);
    integer i;

    localparam PENDING_COUNT_WIDTH=11;
    reg [PENDING_COUNT_WIDTH-1:0] b_pending_count[NUM_BANKS];
    logic [NUM_BANKS-1:0] pending;

    //Given a bank number, makes sure no other bank has pending requests
    function [0:0] none_pending ( input integer i );
        none_pending = ~|(pending & ~({{PENDING_COUNT_WIDTH-1{1'b0}},1'b1}<<i));
    endfunction

    always_comb
    begin
        m_arb_stall = 1'b0;
        m_wrp_ack = 1'b0;
        m_rrp_datavalid = 1'b0;
        m_rrp_data = '0;

        for( i = 0; i < NUM_BANKS; i = i + 1 )
        begin:bank
	    b_arb_enable[i] = m_arb_enable;
            b_arb_request[i] = m_arb_request & bank_select[i] & none_pending(i);
            b_arb_read[i] = m_arb_read & bank_select[i] & none_pending(i);
            b_arb_write[i] = m_arb_write & bank_select[i] & none_pending(i);
            b_arb_writedata[i] = m_arb_writedata;
            b_arb_burstcount[i] = m_arb_burstcount;
            b_arb_address[i] = m_arb_address[ADDRESS_W-$clog2(NUM_BANKS)-1:0];
            b_arb_byteenable[i] = m_arb_byteenable;

            m_arb_stall |= (b_arb_stall[i]  | !none_pending(i)) & bank_select[i];

            m_wrp_ack |= b_wrp_ack[i];
            m_rrp_datavalid |= b_rrp_datavalid[i];
            m_rrp_data |= (b_rrp_datavalid[i] ? b_rrp_data[i] : '0);
        end
    end

    wire add_burst[NUM_BANKS];
    wire incr[NUM_BANKS];
    wire decr_rd[NUM_BANKS];
    wire decr_wr[NUM_BANKS];
    reg [BURSTCOUNT_W-1:0] next_incr[NUM_BANKS];
    reg [1:0] next_decr[NUM_BANKS];
    reg [NUM_BANKS-1:0] last_banksel;

    always@(posedge clock or negedge resetn)
        if (!resetn)
            last_banksel <= {NUM_BANKS{1'b0}};
        else
            last_banksel <= {NUM_BANKS{m_arb_request}} & bank_select;

    // A counter tracks how many outstanding word transfers are needed.  When a
    // request is accepted its burstcount is added to the counter.  When data
    // is returned or writeack'ed, the counter is decremented.
    // This used to be simple - but manual retiming makes it less so
    generate
    genvar b;
    for ( b = 0; b < NUM_BANKS; b = b + 1 )
    begin:bankgen
        assign add_burst[b] = b_arb_request[b] & !b_arb_stall[b] & b_arb_read[b];
        assign incr[b] = b_arb_request[b] & !b_arb_stall[b] & b_arb_write[b];
        assign decr_rd[b] = b_rrp_datavalid[b];
        assign decr_wr[b] = b_wrp_ack[b];

        always@(posedge clock or negedge resetn)
            if (!resetn)
            begin
                next_incr[b] = {BURSTCOUNT_W{1'b0}};
                next_decr[b] = 2'b0;
            end
            else
            begin
                if (add_burst[b])
                    next_incr[b] = m_arb_burstcount;
                else if (incr[b])
                    next_incr[b] = 2'b01;
                else
                    next_incr[b] = {BURSTCOUNT_W{1'b0}};

                next_decr[b] = decr_rd[b] + decr_wr[b];
            end

        always@(posedge clock or negedge resetn)
            if (!resetn)
            begin
                b_pending_count[b] <= {PENDING_COUNT_WIDTH{1'b0}};
            end
            else 
            begin
                b_pending_count[b] <= b_pending_count[b] + next_incr[b] - next_decr[b];
            end

        always_comb
        begin
            pending[b] = |b_pending_count[b] || last_banksel[b];
        end

    end
    endgenerate

endmodule

