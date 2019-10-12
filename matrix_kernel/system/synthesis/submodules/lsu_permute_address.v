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



module lsu_permute_address #(
    parameter AWIDTH                  = 32,
    parameter ENABLE_BANKED_MEMORY    =  1,
    parameter NUMBER_BANKS            =  4,
    parameter BITS_IN_BYTE_SELECT     =  2,
    parameter WORD_SELECT_BITS        =  8
  ) (
    input  [AWIDTH-1:0] i_addr,
    output [AWIDTH-1:0] o_addr
  );

  // If this is a banked local memory LSU, then permute address bits so that
  // consective words in memory are in different banks.  Do this by
  // taking the k lowest bits of the word-address and shifting them to the top
  // of the aggregate local memory address width.
  //
  // The permuted address is organized as:
  // { ( High order bits untouched ),
  //   ( Bank select bits ),
  //   ( Word address bits within a bank ),
  //   ( Byte select within a word ) }
  // Not all fields are present in all configs (some configs don't bank,
  //  others don't have any depth to banks so no word select bits).

  // Note that ABITS_PER_LMEM_BANK includes bits for the within-bank word select, the
  // within-word byte select, and the pipelined workgroup select bits.

  function [AWIDTH-1:0] permute_addr ( input [AWIDTH-1:0] addr);
    if (ENABLE_BANKED_MEMORY==1)
    begin
      // Build up the permuted address segment by segment.  Simplifies working
      // around msim "reverse bit select" errors inside generate branches that
      // aren't active.
      automatic int base_bit = 0; 

      // Parameters must be defined before logic
      localparam BANK_HAS_DEPTH = (ENABLE_BANKED_MEMORY==1) ? (WORD_SELECT_BITS > 0) : 0;
      localparam WORD_SELECT_BITS_HACKED = BANK_HAS_DEPTH ? WORD_SELECT_BITS : 1;  // System integrator adds address bit when no depth
      localparam BANK_SELECT_BITS = (ENABLE_BANKED_MEMORY==1) ? $clog2(NUMBER_BANKS) : 0; // Bank select bits in address permutation
      localparam BANK_SELECT_BITS_HACKED = BANK_SELECT_BITS ? BANK_SELECT_BITS : 1;  // Prevents synthesis error in VCS and NCSIM

      permute_addr = addr;  // Start with original address.  Then we modify the required bits.

      // 1. Byte address within a word - jump over these bits without modification
      base_bit += BITS_IN_BYTE_SELECT;

      // 2. Word address within a bank
      if ( BANK_HAS_DEPTH ) begin
          permute_addr[ base_bit +: WORD_SELECT_BITS_HACKED ] = addr[ (BANK_SELECT_BITS + BITS_IN_BYTE_SELECT) +: WORD_SELECT_BITS_HACKED ];
      end
      else  // Else single word memory bank
      begin
        // System integrator makes all banks have an address bit to avoid 0-width signals in the interconnect IP.
        // Here we force that address bit to zero for functional correctness.
        permute_addr[ base_bit +: WORD_SELECT_BITS_HACKED ] = 1'b0;
      end
      base_bit += WORD_SELECT_BITS_HACKED;
     
      // 3. Hoist bank select bits if we have multiple banks
      if (BANK_SELECT_BITS>0) begin
        permute_addr[ base_bit +: BANK_SELECT_BITS_HACKED ] = addr[ BITS_IN_BYTE_SELECT +: BANK_SELECT_BITS_HACKED ];
      end
     end
     else  // Else don't permute the address
     begin
       permute_addr = addr;
     end
  endfunction

  assign o_addr = permute_addr(i_addr);

endmodule

// vim:set filetype=verilog:
