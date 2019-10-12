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


// If you change these interfaces, please update acl_atomics_arb_stall as well

interface acl_arb_data #(
    parameter integer DATA_W = 32,              // > 0
    parameter integer BURSTCOUNT_W = 4,         // > 0
    parameter integer ADDRESS_W = 32,           // > 0
    parameter integer BYTEENA_W = DATA_W / 8,   // > 0
    parameter integer ID_W = 1                  // > 0
)
();
    struct packed {
        logic enable;
        logic request;
        logic read;
        logic write;
        logic [DATA_W-1:0] writedata;
        logic [BURSTCOUNT_W-1:0] burstcount;
        logic [ADDRESS_W-1:0] address;
        logic [BYTEENA_W-1:0] byteenable;
        logic [ID_W-1:0] id;
    } req;
endinterface

interface acl_arb_intf #(
    parameter integer DATA_W = 32,              // > 0
    parameter integer BURSTCOUNT_W = 4,         // > 0
    parameter integer ADDRESS_W = 32,           // > 0
    parameter integer BYTEENA_W = DATA_W / 8,   // > 0
    parameter integer ID_W = 1                  // > 0
)
();
    // acl_arb_data is not used here because QIS does not like it
    struct packed {
        logic enable;
        logic request;
        logic read;
        logic write;
        logic [DATA_W-1:0] writedata;
        logic [BURSTCOUNT_W-1:0] burstcount;
        logic [ADDRESS_W-1:0] address;
        logic [BYTEENA_W-1:0] byteenable;
        logic [ID_W-1:0] id;    
    } req;

    logic stall;
endinterface

