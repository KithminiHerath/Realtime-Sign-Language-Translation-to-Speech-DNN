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


// one-way bidirectional connection:
// altera message_off 10665

module acl_ic_master_endpoint
#(
   parameter integer DATA_W = 32,              // > 0
   parameter integer BURSTCOUNT_W = 4,         // > 0
   parameter integer ADDRESS_W = 32,           // > 0
   parameter integer BYTEENA_W = DATA_W / 8,   // > 0
   parameter integer ID_W = 1,                 // > 0

   // (NUM_READ_MASTERS + NUM_WRITE_MASTERS) should be > 0
   parameter integer NUM_READ_MASTERS = 1,     // >= 0
   parameter integer NUM_WRITE_MASTERS = 1,    // >= 0

   parameter integer ID = 0                    // [0..2^ID_W-1]
)
(
   input logic clock,
   input logic resetn,

   acl_ic_master_intf m_intf,

   acl_arb_intf arb_intf,
   acl_ic_wrp_intf wrp_intf,
   acl_ic_rrp_intf rrp_intf
);
    
   // There shouldn't be any truncation, but be explicit about the id width.
   logic [ID_W-1:0] id = ID;

   // Pass-through arbitration data.
   assign arb_intf.req = m_intf.arb.req;
   assign m_intf.arb.stall = arb_intf.stall;

   // If only one master, no need to check ID

   generate
     // Write return path.
     if (NUM_WRITE_MASTERS > 1) begin
       assign m_intf.wrp.ack = wrp_intf.ack & (wrp_intf.id == id);
     end else begin
       assign m_intf.wrp.ack = wrp_intf.ack;
     end

     // Read return path.
     if (NUM_READ_MASTERS > 1) begin
       assign m_intf.rrp.datavalid = rrp_intf.datavalid & (rrp_intf.id == id);
       assign m_intf.rrp.data = rrp_intf.data;
     end else begin
       assign m_intf.rrp.datavalid = rrp_intf.datavalid;
       assign m_intf.rrp.data = rrp_intf.data;
     end

   endgenerate

endmodule

