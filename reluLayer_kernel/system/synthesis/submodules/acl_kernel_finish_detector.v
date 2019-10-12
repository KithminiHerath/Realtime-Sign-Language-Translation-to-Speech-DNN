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

// acl_kernel_finish_detector
// 
// This module generates the finish signal for the entire kernel.
// It essentially counts valids (ie. work items) coming out of the kernel and compares against the number of work items dispatched to the kernel (calculated by 
// counting the number of work groups dispatched to the kernel).

// Reset can be synchronous or asynchronous (based on ASYNC_RESET parameter).  For synchronous reset, resetn must be held asserted for
// a minimum of (INPUT_PIPE_DEPTH + TOTAL_STAGES + 5) clock cycles to clear out the dispatched_all_group pipelines.

// There are two main ports on this module:
//  1. From work-group dispatcher: to detect when a work-GROUP is issued
//     It is ASSUMED that the work-group dispatcher issues at most one work-group
//     per cycle.
//  2. From exit points of each kernel copy: to detect when a work-ITEM is completed.

// Required files:
//    acl_reset_handler.sv
//    acl_std_synchronizer_nocut.v
//    acl_fanout_pipeline.sv
//    acl_multistage_accumulator.v

module acl_kernel_finish_detector #(
  parameter integer NUM_COPIES = 1,       // >0, number of kernel copies
  parameter integer WG_SIZE_W = 1,        // >0, width of wg_size port (typically 32 bits)
  parameter integer GLOBAL_ID_W = 32,     // >0, number of bits for one global id dimension. MUST be set to 32 when HYPER_PIPELINE is enabled
  parameter integer TESSELLATION_SIZE = 0,  // If using the tessellation feature of the accumulators, this specifies the number of bits that should be in each section.
  parameter integer ASYNC_RESET = 1,         // 1 - resetn is applied asynchronously, 0 - resetn is applied synchronously.  Either way, resetn is assumed to be asserted asynchronously and will be synchronized to clk inside this block
  parameter integer SYNCHRONIZE_RESET = 0,   // 1 - resetn is passed through a synchronizer before use, 0 - resetn is used directly (should be synchronized outside this block)
  parameter integer HYPER_PIPELINE = 0       // set to 1 to enable additional pipelining targeting very high FMAX in HIPI architectures  such as S10
)
(
  input wire  clock,
  input wire  resetn,                                 // Reset input. Applied synchronously or asynchronously based on ASYNC_RESET parameter. Must be asserted for at least (INPUT_PIPE_DEPTH + TOTAL_STAGES + 5) cycles. This is needed to clear out the dispatched_all_group pipelines. The +5 is for some margin.

  input wire  start,                                  // Start signal, level-triggered, used to reset control logic and clear out pipelines. Must be asserted before work-items are dispatched.
  input wire  [WG_SIZE_W-1:0] wg_size,                // Work-group size (ie. # of work items in a work group)

  // From work-group dispatcher. It is ASSUMED that
  // at most one work-group is dispatched per cycle.
  input wire  [NUM_COPIES-1:0] wg_dispatch_valid_out,
  input wire  [NUM_COPIES-1:0] wg_dispatch_stall_in,
  input wire  dispatched_all_groups,                  // Assumed to be zero after reset.

  // From copies of the kernel pipeline.
  input wire  [NUM_COPIES-1:0] kernel_copy_valid_out,
  input wire  [NUM_COPIES-1:0] kernel_copy_stall_in,

  input wire  pending_writes,                       // From the kernel

  // The finish signal is a single-cycle pulse.
  output logic finish
);
  localparam NUM_GLOBAL_DIMS = 3; // Must be set to 3 when HYPER_PIPELINE is enabled
  localparam MAX_NDRANGE_SIZE_W = NUM_GLOBAL_DIMS * GLOBAL_ID_W;                                                  // Width of the NDRange counter
  localparam SECTION_SIZE = (TESSELLATION_SIZE == 0) ? MAX_NDRANGE_SIZE_W : TESSELLATION_SIZE;
  localparam INPUT_PIPE_DEPTH = (HYPER_PIPELINE == 0) ? 0 : 6; // Add extra pipeline stages to high-fanout control inputs for improved performance when HYPER_PIPELINE is enabled
  localparam WG_SIZE_INPUT_PIPE_DEPTH = (HYPER_PIPELINE == 0) ? 0 : 3;

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

  // Count the total number of work-items in the entire ND-range. This count
  // is incremented as work-groups are issued.
  // This value is not final until dispatched_all_groups has been asserted.
  localparam REG_RANGE_PIPE_DEPTH = 3;
  // 2 for the initial funnel of the pipeline that breaks up the comparison into 8-bit chunks.
  // HYPER_PIPELINE enabled has 1 more stage of pipelining for improved performance
  localparam COMPARISON_LATENCY = (HYPER_PIPELINE == 0) ? 2 : 3;
  localparam TOTAL_STAGES = COMPARISON_LATENCY + stage_count(MAX_NDRANGE_SIZE_W, SECTION_SIZE);
  
  logic [MAX_NDRANGE_SIZE_W-1:0] ndrange_items;
  logic wg_dispatched;
  
  // Pipeline the dispatched_all_groups by the same amount as you pipeline the ndrange_items.
  logic [TOTAL_STAGES-1:0] pipelined_dispatched_all_groups;
  
  // Internal copies of a few inputs, used to implement pipelining.
  logic [WG_SIZE_W-1:0] wg_size_internal;
  logic start_internal;
  logic [NUM_COPIES-1:0] kernel_copy_valid_out_internal;
  logic [NUM_COPIES-1:0] kernel_copy_stall_in_internal;
  logic [NUM_COPIES-1:0] wg_dispatch_valid_out_internal;
  logic [NUM_COPIES-1:0] wg_dispatch_stall_in_internal;
  logic dispatched_all_groups_internal;

  // asynchronous/synchronous reset logic
  localparam                    NUM_RESET_COPIES = 1;
  localparam                    RESET_PIPE_DEPTH = 1;
  logic                         aclrn;
  logic [NUM_RESET_COPIES-1:0]  sclrn;
  logic                         resetn_synchronized;
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
     .o_resetn_synchronized  (resetn_synchronized)
  );
  
  
  
  // Optionally pipeline some latency-insensitive inputs, for performance.
  generate
    if (INPUT_PIPE_DEPTH==0) begin // No pipeline, so connect input signals directly.      
      
      assign wg_size_internal               = wg_size;
      assign start_internal                 = start;
      assign kernel_copy_valid_out_internal = kernel_copy_valid_out;
      assign kernel_copy_stall_in_internal  = kernel_copy_stall_in;
      assign wg_dispatch_valid_out_internal = wg_dispatch_valid_out;
      assign wg_dispatch_stall_in_internal  = wg_dispatch_stall_in;
      assign dispatched_all_groups_internal = dispatched_all_groups;

    end else begin // Otherwise, implement a pipeline
      
      logic [WG_SIZE_INPUT_PIPE_DEPTH:1][WG_SIZE_W-1:0]   wg_size_pipe;
      logic [INPUT_PIPE_DEPTH:1]                  start_pipe;
      logic [INPUT_PIPE_DEPTH:1][NUM_COPIES-1:0]  kernel_copy_valid_out_pipe;
      logic [INPUT_PIPE_DEPTH:1][NUM_COPIES-1:0]  kernel_copy_stall_in_pipe;
      logic [INPUT_PIPE_DEPTH:1][NUM_COPIES-1:0]  wg_dispatch_valid_out_pipe;
      logic [INPUT_PIPE_DEPTH:1][NUM_COPIES-1:0]  wg_dispatch_stall_in_pipe;
      logic [INPUT_PIPE_DEPTH:1]                  dispatched_all_groups_pipe;

      always@(posedge clock) begin
        wg_size_pipe[1]                 <= wg_size;
        start_pipe[1]                   <= start;
        kernel_copy_valid_out_pipe[1]   <= kernel_copy_valid_out;
        kernel_copy_stall_in_pipe[1]    <= kernel_copy_stall_in;
        wg_dispatch_valid_out_pipe[1]   <= wg_dispatch_valid_out;
        wg_dispatch_stall_in_pipe[1]    <= wg_dispatch_stall_in;
        dispatched_all_groups_pipe[1]   <= dispatched_all_groups;
        // wg_size is not as deeply pipelined as the rest. It's not necessary for performance so 
        // this saves registers since it's a wide signal.
        for (int i=2;i<=WG_SIZE_INPUT_PIPE_DEPTH;i++) begin
          wg_size_pipe[i]               <= wg_size_pipe[i-1];
        end        
        for (int i=2;i<=INPUT_PIPE_DEPTH;i++) begin
          start_pipe[i]                 <= start_pipe[i-1];
          wg_dispatch_valid_out_pipe[i] <= wg_dispatch_valid_out_pipe[i-1];
          wg_dispatch_stall_in_pipe[i]  <= wg_dispatch_stall_in_pipe[i-1];
          kernel_copy_valid_out_pipe[i] <= kernel_copy_valid_out_pipe[i-1];
          kernel_copy_stall_in_pipe[i]  <= kernel_copy_stall_in_pipe[i-1];
          dispatched_all_groups_pipe[i] <= dispatched_all_groups_pipe[i-1];
        end
      end

      assign wg_size_internal               = wg_size_pipe[WG_SIZE_INPUT_PIPE_DEPTH];
      assign start_internal                 = start_pipe[INPUT_PIPE_DEPTH];
      assign kernel_copy_valid_out_internal = kernel_copy_valid_out_pipe[INPUT_PIPE_DEPTH];
      assign kernel_copy_stall_in_internal  = kernel_copy_stall_in_pipe[INPUT_PIPE_DEPTH];
      assign wg_dispatch_valid_out_internal = wg_dispatch_valid_out_pipe[INPUT_PIPE_DEPTH];
      assign wg_dispatch_stall_in_internal  = wg_dispatch_stall_in_pipe[INPUT_PIPE_DEPTH];
      assign dispatched_all_groups_internal = dispatched_all_groups_pipe[INPUT_PIPE_DEPTH];

    end
  endgenerate
  
  // Here we ASSUME that at most one work-group is dispatched per cycle.
  // This depends on the acl_work_group_dispatcher.
  assign wg_dispatched = |(wg_dispatch_valid_out_internal & ~wg_dispatch_stall_in_internal);

  generate
  if (TOTAL_STAGES == 1)
  begin
    // This portion of the code should never be used unless someone changes
    // COMPARISON_LATENCY to 0, and correspondingly adjusts the logic for comparison of two numbers to
    // be latency 0. This is a possible optimization if we stop looking at such large ND ranges,
    // and optimize our code for smaller ones when appropriate.    

    // This pipeline delays dispatched_all_groups by TOTAL_STAGES to allow for the latency through the 
    // multistage_accumulators and the section_compare_result comparison pipeline. This handles the case
    // where the outputs of both accumulators are zero in the very beginning and therefore it falsely seems like 
    // all of the work items have exited the kernel.
    always@(posedge clock)
    begin
     if (start_internal)
     begin
       pipelined_dispatched_all_groups <= 1'b0;   
     end
     else
     begin
       pipelined_dispatched_all_groups <= dispatched_all_groups_internal;
     end
   end
  end
  else
  begin
    always@(posedge clock)
    begin
     if (start_internal)
     begin
       pipelined_dispatched_all_groups <= {{TOTAL_STAGES}{1'b0}};   
     end
     else
     begin
       pipelined_dispatched_all_groups[TOTAL_STAGES-1:1] <= pipelined_dispatched_all_groups[TOTAL_STAGES-2:0];
       pipelined_dispatched_all_groups[0] <= dispatched_all_groups_internal;
     end
   end
  end  
  endgenerate
  
  // I am breaking up the computation of ndrange_items into several clock cycles. The wg_dispatched will
  // be pipelined as well to drive each stage of the computation as needed. Effectively I am tessellating the
  // adder by hand.
  // ASSUME: start_internal and wg_dispatched are mutually exclusive
  acl_multistage_accumulator ndrange_sum(
    .clock(clock),
    .resetn(resetn_synchronized),
    .clear(start_internal),
    .result(ndrange_items),
    .increment(wg_size_internal),
    .go(wg_dispatched));
    defparam ndrange_sum.ACCUMULATOR_WIDTH = MAX_NDRANGE_SIZE_W;
    defparam ndrange_sum.INCREMENT_WIDTH = WG_SIZE_W; 
    defparam ndrange_sum.SECTION_SIZE = SECTION_SIZE;
    defparam ndrange_sum.ASYNC_RESET = ASYNC_RESET;    

  // Count the number of work-items that have exited all kernel pipelines.
  logic [NUM_COPIES-1:0] kernel_copy_item_exit;
  logic [MAX_NDRANGE_SIZE_W-1:0] completed_items;
  logic [$clog2(NUM_COPIES+1)-1:0] completed_items_incr_comb, completed_items_incr;
  
  // This is not the best representation, but hopefully synthesis will do something
  // intelligent here (e.g. use compressors?).
  always @(*)
  begin
    completed_items_incr_comb = '0;
    for( integer j = 0; j < NUM_COPIES; ++j )
      completed_items_incr_comb = completed_items_incr_comb + kernel_copy_item_exit[j];
  end
  
  always @(posedge clock or negedge aclrn)
  begin
    if( ~aclrn ) begin // Async reset
      kernel_copy_item_exit <= '0;
      completed_items_incr <= '0;
    end else begin
      if (~sclrn[0]) begin // Sync reset
        kernel_copy_item_exit <= '0;
        completed_items_incr <= '0;
      end else begin
        kernel_copy_item_exit <= kernel_copy_valid_out_internal & ~kernel_copy_stall_in_internal;
        completed_items_incr <= completed_items_incr_comb;      
      end;
    end
  end

  acl_multistage_accumulator ndrange_completed(
    .clock(clock),
    .resetn(resetn_synchronized),
    .clear(start_internal),
    .result(completed_items),
    .increment(completed_items_incr),
    .go(1'b1));
    defparam ndrange_completed.ACCUMULATOR_WIDTH = MAX_NDRANGE_SIZE_W;
    defparam ndrange_completed.INCREMENT_WIDTH = $clog2(NUM_COPIES+1); 
    defparam ndrange_completed.SECTION_SIZE = mymax(SECTION_SIZE, $clog2(NUM_COPIES+1));
    defparam ndrange_completed.ASYNC_RESET = ASYNC_RESET;

  // Determine if the ND-range has completed. This is true when
  // the ndrange_items counter is complete (i.e. dispatched_all_groups)
  // and the completed_items counter is equal to the ndrang_items counter.
  // The following code is essentially a pipelined comparison, comparing
  // smaller ranges of ndrange_items/completed_items separately.
  logic ndrange_done;
  logic range_eq_completed;
  
  // Do 3-bit compares when HYPER_PIPELINE is enabled (so they fit into one LUT)
  localparam COMPARE_WIDTH = (HYPER_PIPELINE==0) ? 8 : 3;
  // These wires are declared to have a width that is an integer multiple of COMPARE_WIDTH.
  // The extra MSBs are set to 0. This is done to keep the indexing in the below for-loops clean.
  wire [((MAX_NDRANGE_SIZE_W/COMPARE_WIDTH)+1)*COMPARE_WIDTH: 0] ndr_wire = {{{((MAX_NDRANGE_SIZE_W/COMPARE_WIDTH)+1)*COMPARE_WIDTH - MAX_NDRANGE_SIZE_W}{1'b0}},ndrange_items};
  wire [((MAX_NDRANGE_SIZE_W/COMPARE_WIDTH)+1)*COMPARE_WIDTH: 0] completed_wire = {{{((MAX_NDRANGE_SIZE_W/COMPARE_WIDTH)+1)*COMPARE_WIDTH - MAX_NDRANGE_SIZE_W}{1'b0}},completed_items};
  
  genvar k;
  generate
    if (MAX_NDRANGE_SIZE_W <= 8)
    begin
      assign range_eq_completed = (ndrange_items == completed_items);
    end
    else if (HYPER_PIPELINE == 0) begin
      
      // Break up the compare into 8-bit sections
      reg [MAX_NDRANGE_SIZE_W/8 : 0] section_compare_result;
      
      for (k=0;k<=(MAX_NDRANGE_SIZE_W/8); k=k+1)
      begin: k_loop
        always@(posedge clock or negedge aclrn)
        begin
          if (~aclrn) begin
            section_compare_result[k] <= 1'b0;
          end else begin
            if (start)
              section_compare_result[k] <= 1'b0;
            else
              section_compare_result[k] <= (ndr_wire[(k*8+7) : k*8] == completed_wire[(k*8+7):k*8]);
          end
        end
      end
      
      reg cmp_result_reg;
      always@(posedge clock or negedge aclrn)
      begin
        if (~aclrn) begin
          cmp_result_reg <= 1'b0;
        end else begin
          if (start)
            cmp_result_reg <= 1'b0;
          else
            cmp_result_reg <= &section_compare_result; // Bit-wise AND all the results
        end
      end
      
      assign range_eq_completed = cmp_result_reg;

    end
    else // Stratix 10 and beyond
    begin
      // Break up the compare into 3-bit comparisons so they fit into one LUT
      // It is assumed that MAX_NDRANGE_SIZE_W = 96 (ie. that GLOBAL_ID_W=32 and number of dimensions = 3).
      // This significantly simplifies the code (writing it fully generically is much more complex)

      // This is like an assertion that tests that MAX_NDRANGE_SIZE_W==96.
      // Asserts are not supported by Quartus Pro so this is the suggested workaround from the Synthesis team. This will cause a synthesis error.
      initial begin
        if (MAX_NDRANGE_SIZE_W!=96)
          $error("When HYPER_PIPELINE==1, MAX_NDRANGE_SIZE_W must be 96. This implies that NUM_GLOBAL_DIMS==3 and GLOBAL_ID_W==32.");
      end
      
      // section_compare_result[] stores the result of the 3-bit compares. The 96-bit compare is broken up into 32 x 3-bit compares, 
      // but this register is declared as 36-bits wide to make it a multiple of 6. This simplifies the indexing below in the 6-input
      // bitwise AND.
      reg [35:0] section_compare_result;  
      reg [5:0] bitwise_and_stage_1;  // Stores the results of the 6 x 6-bit bitwise ANDs

      assign section_compare_result[35:32] = '1; // Upper bits are not used, they are there to simplify the indexing below, so set them to 1 so they don't zero the bit-wise AND below
      
      // Break up the 96-bit compare into 32 x 3-bit sections and store the results
      for (k=0;k<=31; k=k+1)
      begin: k_loop
        always@(posedge clock)
        begin
          section_compare_result[k] <= (ndr_wire[(k*3+2) : k*3] == completed_wire[(k*3+2):k*3]);
        end
      end
      
      // First stage of bit-wise AND.
      // Break up section_compare_result[] into 6 x 6-bit bitwise ANDs.
      for (k=0;k<=5; k=k+1)
      begin: and_stage_1
        always@(posedge clock)
        begin          
          bitwise_and_stage_1[k] <= &section_compare_result[(k*6+5):k*6];
        end
      end

      // Second stage of bit-wise AND
      reg cmp_result_reg;
      always@(posedge clock)
      begin
        cmp_result_reg <= &bitwise_and_stage_1[5:0];
      end
      
      assign range_eq_completed = cmp_result_reg;
    end 
  endgenerate

  always @(posedge clock or negedge aclrn)
  begin
    if( ~aclrn ) begin
      ndrange_done <= 1'b0;
    end else begin
      if( ~sclrn[0] || start_internal )
        ndrange_done <= 1'b0;
      else
      begin
        ndrange_done <= pipelined_dispatched_all_groups[TOTAL_STAGES-1] & (range_eq_completed);
      end
    end      
  end

  // The finish output needs to be a one-cycle pulse when the ndrange is completed
  // AND there are no pending writes.
  logic finish_asserted;

  always @(posedge clock or negedge aclrn)
  begin
    if( ~aclrn ) begin // Async reset
      finish <= 1'b0;
    end else begin
      if (~sclrn[0]) begin // Sync reset     
        finish <= 1'b0;
      end else begin
        finish <= ~finish_asserted & ndrange_done & ~pending_writes;  
      end
    end
  end

  always @(posedge clock or negedge aclrn)
  begin
    if( ~aclrn ) begin
      finish_asserted <= 1'b0;
    end else begin
      if( ~sclrn[0] || start_internal )
        finish_asserted <= 1'b0;
      else if( finish )
        finish_asserted <= 1'b1;
    end
  end

endmodule

`default_nettype wire
