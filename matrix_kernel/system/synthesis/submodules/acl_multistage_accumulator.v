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

module acl_multistage_accumulator #(
  // This module tessellates the accumulator into SECTION_SIZE-bit chunks.
  // it is important to note that this accumulator has been designed to work with kernel finish detector,
  // and as such the increment signal is not pipelined. This means that you cannot simply use it for arbitrary purposes.
  // To make it work as a pipelined accumulator, INCREMENT_WIDTH must be no greater than SECTION_SIZE. In a case that it is,
  // pipelining of the increment signal should be added. However, in kernel finish detector it is unnecessary.
  //
  // Assumption 1 - increment does not change until the final result is computed or INCREMENT_WIDTH < SECTION_SIZE. In the
  //                latter case, increment only needs to be valid for one clock cycle.
  // Assumption 2 - clear and go are never asserted at the same time.
  //
  // Required files:
  //    acl_reset_handler.sv
  //    acl_std_synchronizer_nocut.v
  //    acl_fanout_pipeline.sv
  
  
  parameter ACCUMULATOR_WIDTH = 96,
  parameter INCREMENT_WIDTH = 1,          // Width of increment input
  parameter SECTION_SIZE = 19,
  parameter ASYNC_RESET = 1,              // 1 - resetn is applied asynchronously, 0 - resetn is applied synchronously.
  parameter SYNCHRONIZE_RESET = 0         // 1 - add a local synchronizer to the incoming reset signal
)
(
  input wire clock, 
  input wire resetn,                           // Reset input, must be synchronized to clock.  Can be applied synchronously or asynchronously, depending on ASYNC_RESET value.
  input wire clear,                            // Clears the pipeline, typically asserted at the beginning of computation
  input wire [INCREMENT_WIDTH-1:0] increment,  // Amount to increment by
  input wire go,                               // Triggers an increment, level-triggered
  output logic [ACCUMULATOR_WIDTH-1:0] result   // Accumulator output
);
  
  function integer stage_count;
    input integer width;
    input integer size;
    integer temp,i;
    begin
      temp = width/size;
      if ((width % size) > 0) temp = temp+1;
      stage_count = temp;
    end
  endfunction
  
  function integer mymax;
    input integer a;
    input integer b;
    integer temp;
    begin
      if (a > b) temp = a; else temp = b;
      mymax = temp;
    end
  endfunction  

  localparam TOTAL_STAGES = stage_count(ACCUMULATOR_WIDTH, SECTION_SIZE);
  localparam INCR_FILL = mymax(ACCUMULATOR_WIDTH, TOTAL_STAGES*SECTION_SIZE);
  
  // asynchronous/synchronous reset logic
  localparam                    NUM_RESET_COPIES = 1;
  localparam                    RESET_PIPE_DEPTH = 1;
  logic                         aclrn;
  logic [NUM_RESET_COPIES-1:0]  sclrn;
  acl_reset_handler #(
     .ASYNC_RESET            (ASYNC_RESET),
     .USE_SYNCHRONIZER       (SYNCHRONIZE_RESET),
     .SYNCHRONIZE_ACLRN      (SYNCHRONIZE_RESET),
     .PIPE_DEPTH             (RESET_PIPE_DEPTH),
     .NUM_COPIES             (NUM_RESET_COPIES)
  ) acl_reset_handler_inst (
     .clk                    (clock),
     .i_resetn               (resetn),
     .o_aclrn                (aclrn),
     .o_sclrn                (sclrn),
     .o_resetn_synchronized  ()
  );

  // This little trick is for modelsim to resolve its handling of generate statements.
  // It prevents modelsim from thinking there is an out-of-bound access to increment.
  // This also simplifies one of the if statements below.
  reg [INCR_FILL-1:0] increment_ext;
  initial
  begin
    increment_ext = {{INCR_FILL}{1'b0}};
  end
  
  always@(*)
  begin
    increment_ext = {{INCR_FILL}{1'b0}};
    increment_ext[INCREMENT_WIDTH-1:0] = increment;
  end
  
  reg [TOTAL_STAGES-1 : -1] pipelined_go;  
  reg [SECTION_SIZE:0] stages [TOTAL_STAGES-1 : -1];
  reg [ACCUMULATOR_WIDTH-1:0] pipelined_data [TOTAL_STAGES-1 : 0];  
      
  always@(*)
  begin
    pipelined_go[-1] = go & sclrn[0]; // Drive zero into the go pipeline if (synchronous) reset is asserted - asynchronous reset will be handed in the first registered stage
    stages[-1] = {{SECTION_SIZE}{1'b0}};
  end
  
  genvar i;
  generate
    for (i = 0; i < TOTAL_STAGES; i = i + 1)
    begin: ndr_stage
      // pipelined_go is an enable signal that passes through a pipeline that is the same
      // length as the stages[] pipeline. It enables the additional operation at each stage of
      // the stages[] pipeline.
      always@(posedge clock or negedge aclrn)
      begin
        if( ~aclrn ) begin
          pipelined_go[i] <= 1'b0;
        end else begin
          pipelined_go[i] <= pipelined_go[i-1];      
        end
      end
      
      // This stages[] pipeline breaks up the wide adder (of width ACCUMULATOR_WIDTH) into sections of size
      // SECTION_SIZE. It performs a SECTION_SIZE-width addition operation and sends the carry-out
      // to the next section. This allows the carry-chain length to be limited to SECTION_SIZE and the carry-out
      // to be registered, which boosts performance. 
      // Since the first stage's result is ready much before the last stage's result, 
      // pipelined_data[] is used below to match the latency between all the stages.
      always@(posedge clock or negedge aclrn)
      begin
        if( ~aclrn ) begin
          stages[i] <= {{SECTION_SIZE}{1'b0}};
        end else begin
           if( clear )  
             stages[i] <= {{SECTION_SIZE}{1'b0}};
           else if( pipelined_go[i-1] )
           begin
             if (i*SECTION_SIZE < INCREMENT_WIDTH)
             begin
               // Note that even when (i+1)*SECTION_SIZE-1 > INCREMENT_WIDTH, the increment_ext is extended with 0s,
               // so it does not impact addition. But this does make Modelsim happy.
               stages[i] <= stages[i][SECTION_SIZE-1:0] + increment_ext[(i+1)*SECTION_SIZE-1:i*SECTION_SIZE] + stages[i-1][SECTION_SIZE];
             end
             else
             begin
               stages[i] <= stages[i][SECTION_SIZE-1:0] + stages[i-1][SECTION_SIZE];
             end
           end
        end
      end
     
      // This pipeline runs in parallel with stages[] and its purpose is provide latency matching to
      // each stage so that each stage's result is saved until the very last stage's result
      // is ready. Since pipeline_go is feedforward, pipelined_data can also be feedforward does not need any clken.
      // It also is not reset since stages[] is reset to 0, which will trickle through pipelined_data.
      always@(posedge clock)
      begin
          pipelined_data[i] <= {{ACCUMULATOR_WIDTH}{1'b0}};
          if (i==1)
            pipelined_data[i] <= stages[i-1];
          else if (i > 1)
          begin
            // Sadly Modelsim is kind of stupid here and for i=0 it actually evaluates the 
            // expressions here and finds that (i-1)*SECTION_SIZE - 1 = -SECTION_SIZE - 1 and thinks
            // the indexing to pipelined_data[i-1] happens in opposite direction to the one declared.
            // Quartus is smart enough to figure out that is not the case though, so the synthesized circuit
            // is not affected. To fix this, I am putting a max((i-1)*SECTION_SIZE - 1,0) so that
            // in the cases this statement is irrelevant, the access range for the bus is in the proper direction.
            pipelined_data[i] <= {stages[i-1], pipelined_data[i-1][mymax((i-1)*SECTION_SIZE - 1,0):0]};
          end
      end      
    end
  endgenerate  
  
  generate
    if (TOTAL_STAGES == 1)
      assign result = stages[TOTAL_STAGES-1];
   else
      always@(posedge clock) begin
        // Only latch the result once it's trickled through the pipeline
        if (pipelined_go[TOTAL_STAGES-1]) begin
          result <= {stages[TOTAL_STAGES-1], pipelined_data[TOTAL_STAGES-1][(TOTAL_STAGES-1)*SECTION_SIZE-1:0]};
        end
      end
  endgenerate
endmodule

`default_nettype wire
