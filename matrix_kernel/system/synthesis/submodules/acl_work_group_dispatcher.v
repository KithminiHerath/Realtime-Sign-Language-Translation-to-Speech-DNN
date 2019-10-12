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


/*
This module dispatches group IDs to one or more work item iterators.
There are 2 versions of the code, one for families prior to Stratix10 and another for Stratix10 (and later)
The S10 version contains optimizations for performance. See the S10 section for comments on what's different.
*/

module acl_work_group_dispatcher
#(
  parameter WIDTH = 32,       // width of all the counters
  parameter NUM_COPIES = 1,   // number of kernel copies to manage
  parameter RUN_FOREVER = 0,   // flag for infinitely running kernel
  parameter FAMILY = "Arria 10"  // "Cyclone V" | "Stratix V" | "Arria 10" | "Stratix 10", any unrecognized value is assumed to be a newer family and will be treated as Stratix 10
)
(
   input clock,
   input resetn,              // Reset input. Asynchronous for families prior to Stratix 10, Synchronous for Stratix 10 and later
   input start,               // Rising-edge restarts this module

   // Populated during kernel startup, assumed to be static (ie. unchanging) until next start.
   input [WIDTH-1:0] num_groups[2:0],
   input [WIDTH-1:0] local_size[2:0],
   
   // Handshaking with iterators for each kernel copy
   input [NUM_COPIES-1:0] stall_in, // Not used
   input [NUM_COPIES-1:0] stall_in_lookahead,
   output reg [NUM_COPIES-1:0] valid_out,
   
   // Export group_id to iterators.
   output reg [WIDTH-1:0] group_id_out[2:0],
   output reg [WIDTH-1:0] global_id_base_out[2:0],
   output start_out,
   
   // High when all groups have been dispatched to id iterators
   output reg dispatched_all_groups
);


   generate
      /**********************************************************************
         Cyclone V / Stratix V / Arria 10
      ***********************************************************************/      
      if ((FAMILY=="Cyclone V") || (FAMILY=="Stratix V") || (FAMILY=="Arria 10")) begin
         //////////////////////////////////
         // Group id register updates.
         reg started;         // one cycle delayed after start goes high. stays high
         reg delayed_start;   // two cycles delayed after start goes high. stays high
         reg [WIDTH-1:0] max_group_id[2:0];
         reg [WIDTH-1:0] group_id[2:0];
         wire last_group_id[2:0];
         assign last_group_id[0] = (group_id[0] == max_group_id[0] );
         assign last_group_id[1] = (group_id[1] == max_group_id[1] );
         assign last_group_id[2] = (group_id[2] == max_group_id[2] );
         wire last_group = last_group_id[0] & last_group_id[1] & last_group_id[2];
         wire group_id_ready;

         wire bump_group_id[2:0];
         assign bump_group_id[0] = 1'b1;
         assign bump_group_id[1] = last_group_id[0];
         assign bump_group_id[2] = last_group_id[0] && last_group_id[1];

         always @(posedge clock or negedge resetn) begin
            if ( ~resetn ) begin
               group_id[0] <= {WIDTH{1'b0}};
               group_id[1] <= {WIDTH{1'b0}};
               group_id[2] <= {WIDTH{1'b0}};
               global_id_base_out[0] <= {WIDTH{1'b0}};
               global_id_base_out[1] <= {WIDTH{1'b0}};
               global_id_base_out[2] <= {WIDTH{1'b0}};
               max_group_id[0] <= {WIDTH{1'b0}};
               max_group_id[1] <= {WIDTH{1'b0}};
               max_group_id[2] <= {WIDTH{1'b0}};
               started <= 1'b0;
               delayed_start <= 1'b0;
               dispatched_all_groups <= 1'b0;
            end else if ( start ) begin
               group_id[0] <= {WIDTH{1'b0}};
               group_id[1] <= {WIDTH{1'b0}};
               group_id[2] <= {WIDTH{1'b0}};
               global_id_base_out[0] <= {WIDTH{1'b0}};
               global_id_base_out[1] <= {WIDTH{1'b0}};
               global_id_base_out[2] <= {WIDTH{1'b0}};
               max_group_id[0] <= num_groups[0] - 2'b01;    
               max_group_id[1] <= num_groups[1] - 2'b01;    
               max_group_id[2] <= num_groups[2] - 2'b01;
               started <= 1'b1;
               delayed_start <= started;
               dispatched_all_groups <= 1'b0;
            end else // We presume that start and issue are mutually exclusive.
            begin
               if ( started & stall_in != {NUM_COPIES{1'b1}} & ~dispatched_all_groups ) begin
                  if ( bump_group_id[0] ) group_id[0] <= last_group_id[0] ? {WIDTH{1'b0}} : (group_id[0] + 2'b01);
                  if ( bump_group_id[1] ) group_id[1] <= last_group_id[1] ? {WIDTH{1'b0}} : (group_id[1] + 2'b01);
                  if ( bump_group_id[2] ) group_id[2] <= last_group_id[2] ? {WIDTH{1'b0}} : (group_id[2] + 2'b01);
                  
                  // increment global_id_base here so it's always equal to 
                  //     group_id x local_size.
                  // without using any multipliers.
                  if ( bump_group_id[0] ) global_id_base_out[0] <= last_group_id[0] ? {WIDTH{1'b0}} : (global_id_base_out[0] + local_size[0]);
                  if ( bump_group_id[1] ) global_id_base_out[1] <= last_group_id[1] ? {WIDTH{1'b0}} : (global_id_base_out[1] + local_size[1]);
                  if ( bump_group_id[2] ) global_id_base_out[2] <= last_group_id[2] ? {WIDTH{1'b0}} : (global_id_base_out[2] + local_size[2]);
                  
                  if ( last_group && RUN_FOREVER == 0 )
                     dispatched_all_groups <= 1'b1;
               end
               
               // reset these registers so that next kernel invocation will work.
               if ( dispatched_all_groups ) begin
                 started <= 1'b0;
                 delayed_start <= 1'b0;
               end
            end
         end


         // will have 1 at the lowest position where stall_in has 0.
         wire [NUM_COPIES-1:0] single_one_from_stall_in = ~stall_in & (stall_in + 1'b1);
         assign group_id_ready = delayed_start & ~dispatched_all_groups;

         assign start_out = start;
         assign group_id_out = group_id;
         assign valid_out = single_one_from_stall_in & {NUM_COPIES{group_id_ready}};


      end else begin
         /**********************************************************************
            Stratix 10 (and later)
         ***********************************************************************/         
         /* 
         The output has 1 pipeline stage and therefore valid_out only de-asserts 1 cycle after stall_in_lookahead asserts.
         stall_in_lookahead is typically generated using the almost_full signal from a downstream FIFO.

         A non-zero value is required on num_groups. If num_groups[i]==0, this block will not run. This check is performed
         to address a known issue in an automatically-inferred Qsys clock domain crossing block (altera_avalon_st_clock_crosser)
         where it can issue a spurious valid after only one of its clock domains is reset. In certain regtests this has translated
         into a spurious START reaching this block with num_groups==0. This block will ignore such an event.

         The following is a list of performance optimizations that have been made. This should help make sense of the code.
         * Removed all aclrs, using sclrs only where necessary.
         * Use a downcounter (of size WIDTH+1) to determine the upcounter rollover conditions, instead of using a comparator.
         * Look ahead on the downcounter by 1 count so the rollover signal (MSB) can be pipelined.
         * Pipeline the 'run' signal (which feeds high fanout clken logic)
         * Pipeline num_groups and local_size (these are static inputs into adders)
         * Pipeline resetn (which is used as an sclr and has a high fanout)
         * Pipeline the ID outputs and valid_out
         */

         localparam INPUT_PIPE_DEPTH = 1;       // The number of pipeline stages used on various inputs. This can be adjusted to boost performance at the expense of area.
         localparam RUN_PIPE_DEPTH = 5;         // Use a deeper pipeline on the run signal to allow time for num_groups_invalid_reg to be calculated and clear the run pipeline if needed.
         // Input pipeline registers (only certain inputs)
         reg [WIDTH-1:0] num_groups_reg[INPUT_PIPE_DEPTH-1:0][2:0];
         reg [WIDTH-1:0] local_size_reg[INPUT_PIPE_DEPTH-1:0][2:0];
         reg start_reg[INPUT_PIPE_DEPTH-1:0];
         reg resetn_in[INPUT_PIPE_DEPTH-1:0];   // Pipeline the resetn input since it's used an sclr and has a high fanout.

         // Output pipeline registers
         reg [NUM_COPIES-1:0] valid_out_internal;
         reg [WIDTH-1:0] group_id[2:0];
         reg [WIDTH-1:0] global_id_base[2:0];
         reg dispatched_all_groups_internal;

         reg start_delay;                       // Used for edge-detect
         reg [RUN_PIPE_DEPTH-1:0]run;         // Controls if this block runs at all (triggered by start).

         reg [WIDTH:0] group_id_downcount[2:0]; // This downcounter counts from {num_groups-3} downto -2. It has 1 extra bit to allow the count to go negative.
         reg last_group_id[2:0];                // Indicates when each group_id counter is on its last group.
         wire last_group;                       // Flag to indicate when the very last group is being dispatched.
         wire group_id_ready;                   // Internal signal to indicate when the first group_id is ready to be output as valid.
         wire incr_id_counter[2:0];             // Control signal to determine when each ID counter should be incremented

         // Registers to detect num_groups==0
         reg [2:0]num_groups_invalid;
         reg num_groups_invalid_reg;
         
         // Registers to detect num_groups==1
         reg [1:0][2:0]num_groups_equals_one;

         /*--------------------------------------------------
            Pipelining of (some) Input Signals
         --------------------------------------------------*/
         // Pipeline stages on some inputs to help with performance. No resets.
         always @(posedge clock) begin
            // Assign to first stage
            resetn_in[0]         <= resetn;
            start_reg[0]         <= start;
            num_groups_reg[0][0] <= num_groups[0];
            num_groups_reg[0][1] <= num_groups[1];
            num_groups_reg[0][2] <= num_groups[2];
            local_size_reg[0][0] <= local_size[0];
            local_size_reg[0][1] <= local_size[1];
            local_size_reg[0][2] <= local_size[2];

            // Assign remaining stages.
            for (int i=1;i<INPUT_PIPE_DEPTH;i=i+1) begin  
               num_groups_reg[i] <= num_groups_reg[i-1];
               local_size_reg[i] <= local_size_reg[i-1];
               resetn_in[i]      <= resetn_in[i-1];
               start_reg[i]      <= start_reg[i-1];
            end
         end

         /*--------------------------------------------------
            Register the start input so we can do an edge-detect
         --------------------------------------------------*/
         always @(posedge clock) begin
            if (~resetn_in[INPUT_PIPE_DEPTH-1]) begin   
               start_delay    <= 1'b1;    // Pre-bias the edge-detect (ie. reset to '1' in case start==1 when resetn is de-asserted and we misinterpret that as a rising edge).
            end else begin
               start_delay    <= start_reg[INPUT_PIPE_DEPTH-1];   // Used for rising edge detection on start input
            end
         end

         /*--------------------------------------------------
            Detect num_groups==0
         --------------------------------------------------*/

         always @(posedge clock) begin
            // Need to reset these signals on a start condition since the downcount is only reloaded after a start.
            if (~resetn_in[INPUT_PIPE_DEPTH-1] || (~start_delay && start_reg[INPUT_PIPE_DEPTH-1])) begin
               num_groups_invalid      <= '0;
               num_groups_invalid_reg  <= 1'b0;
            end else begin
               // Check for num_groups==0.
               // Rather than directly check for num_groups==0 (which would be a WIDTH-bit compare), we check
               // if the downcount==-3 (since this calculation must already be done) to determine if num_groups==0.
               // Check for -3 using only 2 bits.
               num_groups_invalid[2] <= group_id_downcount[2][WIDTH] & ~group_id_downcount[2][1];
               num_groups_invalid[1] <= group_id_downcount[1][WIDTH] & ~group_id_downcount[1][1];
               num_groups_invalid[0] <= group_id_downcount[0][WIDTH] & ~group_id_downcount[0][1];
              
               // OR the bits together
               num_groups_invalid_reg <= |num_groups_invalid;
            end
         end

         /*--------------------------------------------------
            Detect num_groups==1
         --------------------------------------------------*/
         always @(posedge clock) begin
            for (int i=0;i<3;i=i+1) begin
               num_groups_equals_one[0][i] <= (num_groups_reg[INPUT_PIPE_DEPTH-1][i] == 1);
               num_groups_equals_one[1][i] <= num_groups_equals_one[0][i];  // 1 stage of pipeline. The ==1 compare has LUT-depth 3 so this register should get retimed back to break it into depth 2.
            end
         end

         /*--------------------------------------------------
            Detect the Start Condition
         --------------------------------------------------*/
         // The run signal is triggered by a rising-edge on start.
         // The run signal is like the on/off switch for this module.
         // We stop running once all the groups have been dispatched and then wait for the next start.
         // It is pipelined since it feeds the clken of many other registers.
         // This If statement is coded with the necessary priority.
         always @(posedge clock) begin
            if (~resetn_in[INPUT_PIPE_DEPTH-1]) begin
               run         <= '0;
            end else if (~start_delay && start_reg[INPUT_PIPE_DEPTH-1]) begin // Load the run pipeline on a rising edge of start.
               run[0]      <= 1'b1; 
            // Stop running when all groups have been dispatched. Wait for next start signal. Relying on dispatched_all_groups being cleared on a rising edge of start (see code below).
            // Also immediately clear the run pipeline if num_groups==0.
            end else if (dispatched_all_groups_internal || num_groups_invalid_reg) begin 
               run         <= '0;
            end else begin
               for (int i=1;i<RUN_PIPE_DEPTH;i=i+1) begin
                  run[i]   <= run[i-1];   // Assign remaining pipeline stages
               end     
            end
         end
         
         /*--------------------------------------------------
            ID Counters and Downcounters
         --------------------------------------------------*/
         // Increment each ID counter when all of the lower dimension counters are rolling over.
         assign incr_id_counter[0] = 1'b1;               // Always increment counter-0
         assign incr_id_counter[1] = last_group_id[0];   
         assign incr_id_counter[2] = last_group_id[0] && last_group_id[1];
         assign last_group = last_group_id[0] & last_group_id[1] & last_group_id[2];  // Detect when we're on the very last group_id 

         always @(posedge clock) begin
            if ( ~start_delay && start_reg[INPUT_PIPE_DEPTH-1] ) begin   // Check for rising-edge on start. On start, load the counters with their starting values.
               group_id[0]             <= {WIDTH{1'b0}};
               group_id[1]             <= {WIDTH{1'b0}};
               group_id[2]             <= {WIDTH{1'b0}};
               global_id_base[0]       <= {WIDTH{1'b0}};
               global_id_base[1]       <= {WIDTH{1'b0}};
               global_id_base[2]       <= {WIDTH{1'b0}};
               group_id_downcount[0]   <= {1'b0,num_groups_reg[INPUT_PIPE_DEPTH-1][0]}-3;
               group_id_downcount[1]   <= {1'b0,num_groups_reg[INPUT_PIPE_DEPTH-1][1]}-3;
               group_id_downcount[2]   <= {1'b0,num_groups_reg[INPUT_PIPE_DEPTH-1][2]}-3;

               // Special case for num_groups == 1. The downcounter lookahead logic checks for when its value is -1, which does not occur when num_groups==1.
               for (int i=0;i<3;i=i+1) begin
                  if (num_groups_equals_one[1][i]) begin 
                     last_group_id[i] <= 1'b1;
                  end else begin
                     last_group_id[i] <= 1'b0;
                  end
               end
            end else
            begin
               // We increment/decrement the counters when this block should be running, when at least one kernel copy is unstalling us (ie. it can accept a new group), and as long as there are still groups to dispatch.
               if ( run[RUN_PIPE_DEPTH-1] & stall_in_lookahead != {NUM_COPIES{1'b1}} & ~dispatched_all_groups_internal ) begin

                  /*--------------------------------------------------
                     Detect Counter Rollover Conditions
                  --------------------------------------------------*/
                  // The downcounters count from {num_groups-3} downto -2. When they reach -2, the ID counters should rollover or increment as appropriate.
                  // We actually lookahead on the downcount by checking for when downcount == -1. This is to provide 1 pipeline stage 
                  // on last_group_id since it feeds a high fanout clken. We check when downcount == -1 by checking for when the MSB and LSB are both 1 (rather than just
                  // the MSB) to avoid a false detection when the counter reaches -2. In each case, we implement a special case for when num_groups == 1 where we load 
                  // last_group_id with 1 to indicate we're always on the last group. There is also a special case if the size of all lower dimensions is 1, 
                  // in which case we check for downcount == -1 since we'll be decrementing on every unstalled cycle. Otherwise check for -2.

                  // last_group_id[0]
                  if (num_groups_equals_one[1][0]) begin     // If num_groups == 1, then we're always on the last group.
                     last_group_id[0] <= 1'b1;
                  end else begin
                     last_group_id[0] <= group_id_downcount[0][WIDTH] & group_id_downcount[0][0]; // Check for -1 (using MSB and LSB)
                  end

                  // last_group_id[1]
                  if (num_groups_equals_one[1][1]) begin  // If num_groups == 1, then we're always on the last group
                     last_group_id[1] <= 1'b1;
                  end else if (num_groups_equals_one[1][0]) begin // Special case for lower dimensions
                     last_group_id[1] <= group_id_downcount[1][WIDTH] & group_id_downcount[1][0];  // Check for -1
                  end else begin
                     last_group_id[1] <= group_id_downcount[1][WIDTH] & ~group_id_downcount[1][0]; // Check for -2
                  end

                  // last_group_id[2]
                  if (num_groups_equals_one[1][2]) begin // If num_groups == 1, then we're always on the last group
                     last_group_id[2] <= 1'b1;
                  end else if ((num_groups_equals_one[1][0]) && (num_groups_equals_one[1][1])) begin  // Special case for lower dimensions
                     last_group_id[2] <= group_id_downcount[2][WIDTH] & group_id_downcount[2][0];  // Check for -1
                  end else begin
                     last_group_id[2] <= group_id_downcount[2][WIDTH] & ~group_id_downcount[2][0]; // Check for -2
                  end

                  /*--------------------------------------------------
                     Increment/Decrement the counters
                  --------------------------------------------------*/
                  // Each time a group_id counter is incremented, decrement its corresponding downcounter.
                  // Each time a group_id counter rolls over, also roll over its corresponding downcounter.
                  // Increment global_id_base so it's always equal to group_id * local_size.
                  for (int i=0;i<3;i=i+1) begin
                     if (incr_id_counter[i]) begin    // Check if we should increment each ID counter. This occurs when the lower dimension counters are rolling over.
                        if (last_group_id[i]) begin   // Check if each ID counter should roll over (as indicated by the downcounters)
                           group_id[i]                <= {WIDTH{1'b0}};
                           group_id_downcount[i]      <= {1'b0,num_groups_reg[INPUT_PIPE_DEPTH-1][i]}-3;
                           global_id_base[i]          <= {WIDTH{1'b0}};
                        end else begin                // Otherwise, increment each ID counter
                           group_id[i]                <= group_id[i] + 2'b01;
                           group_id_downcount[i]      <= group_id_downcount[i] - 2'b01;
                           global_id_base[i]          <= global_id_base[i] + local_size_reg[INPUT_PIPE_DEPTH-1][i];
                        end
                     end
                  end

               end
            end
         end

         /*--------------------------------------------------
            Generate dispatched_all_groups
         --------------------------------------------------*/
         // dispatched_all_groups is typically fed to the acl_kernel_finish_detector
         always @(posedge clock) begin
            // Reset to 0 immediately on start without waiting for start to trickle through its input pipeline -- this is expected by acl_kernel_finish_detector.
            if ( ~resetn_in[INPUT_PIPE_DEPTH-1] || (~start_reg[0] && start) ) begin 
               dispatched_all_groups_internal   <= 1'b0;
            end else begin
               // Assert when the last group is being output
               if ( run[RUN_PIPE_DEPTH-1] & stall_in_lookahead != {NUM_COPIES{1'b1}} & ~dispatched_all_groups_internal ) begin
                  if ( last_group && RUN_FOREVER == 0 ) begin
                     dispatched_all_groups_internal <= 1'b1;
                  end
               end
            end
         end

         assign group_id_ready = run[RUN_PIPE_DEPTH-1] & ~dispatched_all_groups_internal;  // Indicates when the first group_id is ready to be output

         /*--------------------------------------------------
            Outputs
         --------------------------------------------------*/   
         assign start_out = start;

         // valid_out_internal is asserted only in the lowest position where stall_in_lookahead is 0.
         // This has the effect of always keeping the lowest kernel copy busy before dispatching to the next copy.
         assign valid_out_internal = (~stall_in_lookahead & (stall_in_lookahead + 1'b1)) & {NUM_COPIES{group_id_ready}};

         always @(posedge clock) begin
            if (~resetn_in[INPUT_PIPE_DEPTH-1]) begin
               valid_out            <= 0;
            end else begin
               valid_out            <= valid_out_internal;
            end
         end

         // Output pipeline stages
         always @(posedge clock) begin
            group_id_out            <= group_id;
            global_id_base_out      <= global_id_base;
            dispatched_all_groups   <= dispatched_all_groups_internal;
         end

      end
   endgenerate

endmodule


// vim:set filetype=verilog:

