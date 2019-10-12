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


//===----------------------------------------------------------------------===//
//
// Parameterized FIFO with input and output registers and ACL pipeline
// protocol ports (including stall_lookahead and valid_lookahead).
//
//===----------------------------------------------------------------------===//
module acl_fifo_stall_valid_lookahead 
#(
   parameter int     DATA_WIDTH                 = 32,                   // width of the FIFO data ports, in bits
   parameter int     DEPTH                      = 256,                  // maximum capacity of the FIFO
   parameter int     STALL_OUT_LOOKAHEAD_COUNT  = 2,                    // minimum number of empty slots that must be available to write into the FIFO to prevent stall_out_lookahead from being asserted
   parameter int     VALID_OUT_LOOKAHEAD_COUNT  = 3,                    // minimum number of words that must be present in the FIFO to allow valid_out_lookahead to be asserted.  For IMPL=basic, minimum value is 3 due to bug in SCFIFO
   parameter int     REGISTERED_DATA_OUT_COUNT  = 0,                    // number of output ports that must be registered (as opposed to combinatorial), only applies for IMPL==HIGHSPEED
   parameter string  LPM_HINT                   = "unused",    
   parameter string  IMPL                       = "basic"               // IMPL: (basic | acl_highspeed | dummy)
)

(
   input                   clock,                     // master clock, all inputs synchronous with this signal
   input                   resetn,                    // active-low synchronous reset input
   input                   valid_in,                  // indicates input data is valid, combined with stall_out to cause a write to the fifo
   output                  stall_out,                 // indicates the FIFO is full, new words will not be accepted
   output logic            stall_out_lookahead,       // indicates the FIFO is 'almost' full when asserted (as defined by STALL_OUT_LOOKAHEAD_COUNT)
   input  [DATA_WIDTH-1:0] data_in,                   // input data, accepted when valid_in is high and stall_out is low
   output                  valid_out,                 // qualifier for the data_out port, combines with the stall_in to generate a read from the FIFO
   output                  valid_out_lookahead,       // indicates the FIFO is 'almost' empty when de-asserted (as definied by VALID_OUT_LOOKAHEAD_COUNT)
   input                   stall_in,                  // combines with valid_out to generate a read from the FIFO
   output [DATA_WIDTH-1:0] data_out                   // output data, qualified by valid_out, will change when valid_out is asserted and stall_in is not asserted
);

   function integer my_local_log;
   input [31:0] value;
      for (my_local_log=0; value>0; my_local_log=my_local_log+1)
         value = value>>1;
   endfunction    

   generate
   
      // basic implementation uses scfifo
      if (IMPL=="basic") begin

         localparam int ALMOST_FULL_VALUE    = DEPTH-STALL_OUT_LOOKAHEAD_COUNT-1;  // Subtracting 1 so that almost_full asserts 1 cycle earlier to account for the output register (1 extra cycle of latency) that we've added on stall_out_lookahead.
         localparam int ALMOST_EMPTY_VALUE   = VALID_OUT_LOOKAHEAD_COUNT;
         localparam int NUM_BITS_USED_WORDS  = DEPTH == 1 ? 1 : my_local_log(DEPTH-1);    // number of bits for the USED_WORDS 
         
         wire full;
         wire almost_full;
         wire empty;
         wire almost_empty;
              

         scfifo fifo_component (
            .clock (clock),
            .data (data_in),
            .rdreq ((~stall_in) & (~empty)),
            .wrreq (valid_in & (~full)),
            .empty (empty),
            .full (full),
            .q (data_out),
            .aclr (~resetn),
            .almost_empty (almost_empty),
            .almost_full (almost_full),
            .eccstatus(),
            .sclr(),
            .usedw ()
         );
          defparam
            fifo_component.add_ram_output_register = "ON",
            fifo_component.lpm_numwords = DEPTH,
            fifo_component.lpm_showahead = "ON",
            fifo_component.lpm_type = "scfifo",
            fifo_component.lpm_width = DATA_WIDTH,
            fifo_component.lpm_widthu = NUM_BITS_USED_WORDS,
            fifo_component.overflow_checking = "ON",
            fifo_component.underflow_checking = "ON",
            fifo_component.use_eab = "ON",
            fifo_component.almost_full_value = ALMOST_FULL_VALUE,
            fifo_component.almost_empty_value = ALMOST_EMPTY_VALUE;

         assign stall_out = full;
         assign valid_out = ~empty;
         assign valid_out_lookahead = ~almost_empty;

         // Register the stall_out_lookahead outputs since almost_full is a combinational output from the FIFO.
         // The ALMOST_FULL_VALUE is adjusted to reflect this added latency.
         always_ff @(posedge clock) begin
            // No reset needed. Even if the FIFO has some latency between resetn asserting and almost_full clearing, 
            // the worst case is that stall_out_lookahead==1 during this time, which is a safe value 
            // (ie. it should prevent an upstream block from writing to the FIFO during reset)
            stall_out_lookahead <= almost_full; 
         end

      // highspeed implementation uses scfifo_to_acl_high_speed_fifo
      end else if (IMPL=="acl_highspeed") begin

         localparam int ALMOST_FULL_VALUE    = DEPTH-STALL_OUT_LOOKAHEAD_COUNT;
         localparam int ALMOST_EMPTY_VALUE   = VALID_OUT_LOOKAHEAD_COUNT;
         
         wire full;
         wire almost_full;
         wire empty;
         wire almost_empty;
              
         scfifo_to_acl_high_speed_fifo #(
            .lpm_width( DATA_WIDTH ),
            .lpm_numwords( DEPTH ),
            .almost_empty_value( ALMOST_EMPTY_VALUE ),
            .almost_full_value( ALMOST_FULL_VALUE ),
            .add_ram_output_register( "OFF" ),
            .REGISTERED_DATA_OUT_COUNT( REGISTERED_DATA_OUT_COUNT ),
            .ASYNC_RESET( 0 )
         ) fifo_component (
            .clock (clock),
            .data (data_in),
            .rdreq ((~stall_in) & (~empty)),
            .wrreq (valid_in & (~full)),
            .empty (empty),
            .full (full),
            .q (data_out),
            .almost_empty (almost_empty),
            .almost_full (almost_full),
            .sclr(~resetn),
            .aclr(1'b0),
            .usedw ()
         );

         assign stall_out = full;
         assign valid_out = ~empty;
         assign valid_out_lookahead = ~almost_empty;
         assign stall_out_lookahead = almost_full;
         
         
     
      // dummy implementation is NON-FUNCTIONAL, provides input and output registers which are preserved
      // this implementaiton is only useful for checking performance (FMAX) of a block that uses a FIFO and making sure that the FIFO performance is not a factor
      end else begin // IMPL=="dummy"
      
         // preserve on all these registers ensures they won't be used for retiming
         logic                   stall_out_r           /* synthesis preserve */;
         logic                   stall_out_lookahead_r /* synthesis preserve */;
         logic [DATA_WIDTH-1:0]  data_out_r            /* synthesis preserve */;
         logic                   valid_out_r           /* synthesis preserve */;
         logic                   valid_out_lookahead_r /* synthesis preserve */;
         logic                   valid_in_r            /* synthesis preserve */;
         logic  [DATA_WIDTH-1:0] data_in_r             /* synthesis preserve */;
         logic                   stall_in_r            /* synthesis preserve */;
         
         always_ff @(posedge clock) begin
         
            stall_out_r <= valid_in_r;
            stall_out_lookahead_r <= valid_in_r;
            data_out_r <= data_in_r;
            valid_out_r <= valid_in_r;
            valid_out_lookahead_r <= valid_in_r;
            valid_in_r  <= valid_in;
            data_in_r   <= data_in;   
            stall_in_r  <= stall_in;  
            
         end
         
         assign stall_out              = stall_out_r           ;
         assign stall_out_lookahead    = stall_out_lookahead_r ;
         assign data_out               = data_out_r            ;
         assign valid_out              = valid_out_r           ;
         assign valid_out_lookahead    = valid_out_lookahead_r ;

      end
      
   endgenerate
   
endmodule
