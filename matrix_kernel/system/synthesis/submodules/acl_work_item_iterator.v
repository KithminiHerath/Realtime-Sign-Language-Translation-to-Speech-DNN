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


// Generates global and local ids for given set of group ids.
// Need one of these for each kernel instance.
//
// This block accepts a workgroup id along with the global id that corresponds with the first item of that workgroup id.  It 
// then issues local/workgroup/global ids to the kernel.
// 
//    - Items for the same workgroup are issued contiguously.
//      That is, items from different workgroups are never interleaved.
//
//    - Subject to the previous constraint, we make the lower 
//      order ids (e.g. local_id[0]) iterate faster than 
//      higher order (e.g. local_id[2])
//
//    - Id values start at zero and only increase.
//
//    - Behaviour is unspecified if too many workgroups are dispatched
//      (global_id[0] * global_id[1] * global_id[2] times) between times
//      that "start" is asserted.

// There are 2 versions of the code, one for families prior to Stratix10 and another for Stratix10 (and later)

module acl_work_item_iterator
#(
  parameter WIDTH = 32,                      // width of all the id outputs
  parameter LOCAL_WIDTH_X = 32,              // internal width of local_id[0] counter
  parameter LOCAL_WIDTH_Y = 32,              // internal width of local_id[1] counter
  parameter LOCAL_WIDTH_Z = 32,              // internal width of local_id[2] counter
  parameter VALID_OUT_LOOKAHEAD_COUNT = 3,   // de-assert valid_out_lookahead when there are this many consecutive VALID signals available
  parameter ENABLE_TESSELLATION = 0,
  parameter FAMILY = "Arria 10"            // "Cyclone V" | "Stratix V" | "Arria 10" | "Stratix 10", any unrecognized value is assumed to be a newer family and will be treated as Stratix 10
)

(
  /******************************
    Ports common across families
  ******************************/
  input clock,
  input resetn,                              // Reset input. Asynchronous for families prior to Stratix 10, Synchronous for Stratix 10 and later
  input start,                               // asserted to restart (reset) the iterator
  
  // kernel parameters from the higher level (assumed stable between assertions of 'start' signal)
  input [WIDTH-1:0] local_size[2:0],         // size of each workgroup
  input [WIDTH-1:0] global_size[2:0],        // Used only for debugging, not synthesized.

  // actual outputs, qualified with valid_out/stall_in
  output [WIDTH-1:0] local_id[2:0],
  output reg [WIDTH-1:0] global_id[2:0],

  /******************************
    Ports specific to Cyclone V / Stratix V / Arria 10
  ******************************/
  input issue,         // Assert to issue another item, i.e. advance the counters
  input input_enable,
  // inputs from id_iterator
  input [WIDTH-1:0] global_id_base[2:0],
  // output to id_iterator
  output last_in_group,

  /******************************
    Ports specific to Stratix 10
  ******************************/
  // handshaking with acl_id_iterator
  input valid_in,
  input valid_in_lookahead,
  output reg stall_out,
  
  // handshaking with kernel instance
  input stall_in,
  output valid_out,
  output valid_out_lookahead,
  
  // comes from group dispatcher, qualified with valid_in/stall_out
  input [WIDTH-1:0] group_id_in[2:0],
  input [WIDTH-1:0] global_id_base_in[2:0],
  
  output [WIDTH-1:0] group_id[2:0]
);
  
  genvar i;
  generate
    /**********************************************************************
       Cyclone V / Stratix V / Arria 10
    ***********************************************************************/      
    if ((FAMILY=="Cyclone V") || (FAMILY=="Stratix V") || (FAMILY=="Arria 10")) begin
      reg [LOCAL_WIDTH_X-1:0] local_id_0;
      reg [LOCAL_WIDTH_Y-1:0] local_id_1;
      reg [LOCAL_WIDTH_Z-1:0] local_id_2;

      assign local_id[0] = {{(WIDTH-LOCAL_WIDTH_X){1'b0}}, local_id_0};
      assign local_id[1] = {{(WIDTH-LOCAL_WIDTH_Y){1'b0}}, local_id_1};
      assign local_id[2] = {{(WIDTH-LOCAL_WIDTH_Z){1'b0}}, local_id_2};

      // This is the invariant relationship between the various ids.
      // Keep these around for debugging.
      wire [WIDTH-1:0] global_total = global_id[0] + global_size[0] * ( global_id[1] + global_size[1] * global_id[2] );
      wire [WIDTH-1:0] local_total = local_id[0] + local_size[0] * ( local_id[1] + local_size[1] * local_id[2] );



      function [WIDTH-1:0] incr_lid ( input [WIDTH-1:0] old_lid, input to_incr, input last );
         if ( to_incr )
            if ( last )
               incr_lid = {WIDTH{1'b0}};
            else 
               incr_lid = old_lid + 2'b01;
         else 
            incr_lid = old_lid;
      endfunction


      //////////////////////////////////
      // Handle local ids.
      reg [LOCAL_WIDTH_X-1:0] max_local_id_0;
      reg [LOCAL_WIDTH_Y-1:0] max_local_id_1;
      reg [LOCAL_WIDTH_Z-1:0] max_local_id_2;

      wire last_local_id[2:0];
      assign last_local_id[0] = (local_id_0 == max_local_id_0);
      assign last_local_id[1] = (local_id_1 == max_local_id_1);
      assign last_local_id[2] = (local_id_2 == max_local_id_2);

      assign last_in_group = last_local_id[0] & last_local_id[1] & last_local_id[2];

      wire bump_local_id[2:0];
      wire bump_local_id_reg[2:0];
      assign bump_local_id[0] = (max_local_id_0 != 0);
      assign bump_local_id[1] = (max_local_id_1 != 0) && last_local_id[0];
      assign bump_local_id[2] = (max_local_id_2 != 0) && last_local_id[0] && last_local_id[1];

      // Local id register updates.
      always @(posedge clock or negedge resetn) begin
         if ( ~resetn ) begin
            local_id_0 <= {LOCAL_WIDTH_X{1'b0}};
            local_id_1 <= {LOCAL_WIDTH_Y{1'b0}};
            local_id_2 <= {LOCAL_WIDTH_Z{1'b0}};
            max_local_id_0 <= {LOCAL_WIDTH_X{1'b0}};
            max_local_id_1 <= {LOCAL_WIDTH_Y{1'b0}};
            max_local_id_2 <= {LOCAL_WIDTH_Z{1'b0}};    
         end else if ( start ) begin
            local_id_0 <= {LOCAL_WIDTH_X{1'b0}};
            local_id_1 <= {LOCAL_WIDTH_Y{1'b0}};
            local_id_2 <= {LOCAL_WIDTH_Z{1'b0}};
            max_local_id_0 <= local_size[0][LOCAL_WIDTH_X-1:0]- 1;
            max_local_id_1 <= local_size[1][LOCAL_WIDTH_Y-1:0]- 1;
            max_local_id_2 <= local_size[2][LOCAL_WIDTH_Z-1:0]- 1;    
         end else // We presume that start and issue are mutually exclusive.
         begin
            if ( issue ) begin
               local_id_0 <= incr_lid (local_id_0, bump_local_id[0], last_local_id[0]);
               local_id_1 <= incr_lid (local_id_1, bump_local_id[1], last_local_id[1]);
               local_id_2 <= incr_lid (local_id_2, bump_local_id[2], last_local_id[2]);
            end
         end
      end


        
        // goes high one cycle after last_in_group. stays high until
        // next cycle where 'issue' is high.
        reg just_seen_last_in_group;
        always @(posedge clock or negedge resetn) begin
          if ( ~resetn )
            just_seen_last_in_group <= 1'b1;
          else if ( start )
            just_seen_last_in_group <= 1'b1;
          else if (last_in_group & issue)
            just_seen_last_in_group <= 1'b1;
          else if (issue)
            just_seen_last_in_group <= 1'b0;
          else
            just_seen_last_in_group <= just_seen_last_in_group;
        end
            
      //////////////////////////////////
      // Handle global ids.

      wire [2:0] enable_mux;
      wire [2:0] enable_mux_reg;
      wire [WIDTH-1:0] global_id_mux[2:0];
      wire [WIDTH-1:0] global_id_mux_reg[2:0];
      wire [WIDTH-1:0] local_id_operand_mux[2:0];
      wire [WIDTH-1:0] local_id_operand_mux_reg[2:0];
      wire [WIDTH-1:0] bump_add[2:0];
      wire [WIDTH-1:0] bump_add_reg[2:0];
      wire just_seen_last_in_group_reg;
      wire [WIDTH-1:0] global_id_base_reg[2:0];

      wire [WIDTH-1:0] max_local_id[2:0];

      assign max_local_id[0] = {{(WIDTH-LOCAL_WIDTH_X){1'b0}}, max_local_id_0};
      assign max_local_id[1] = {{(WIDTH-LOCAL_WIDTH_Y){1'b0}}, max_local_id_1};
      assign max_local_id[2] = {{(WIDTH-LOCAL_WIDTH_Z){1'b0}}, max_local_id_2};

      

      if (ENABLE_TESSELLATION) begin

        acl_shift_register #(.WIDTH(WIDTH),.STAGES(3) )
           jsl ( .clock(clock),.resetn(resetn),.clear(start),.enable(input_enable),.Q(just_seen_last_in_group_reg), .D(just_seen_last_in_group) );

        for (i=0;i<3;i = i+1) begin : tesilate_block
           assign enable_mux[i] = issue & !last_in_group & (just_seen_last_in_group | bump_local_id[i]);
              
           acl_shift_register #(.WIDTH(WIDTH),.STAGES(1) )
              global_id_base_sr ( .clock(clock),.resetn(resetn),.clear(start),.enable(input_enable),.Q(global_id_base_reg[i]), .D(global_id_base[i]) );
           acl_shift_register #(.WIDTH(1),.STAGES(1) )
              bump_local_id_sr ( .clock(clock),.resetn(resetn),.clear(start),.enable(input_enable),.Q(bump_local_id_reg[i]), .D( bump_local_id[i] ) );

           acl_multistage_adder #(.WIDTH(WIDTH) )
              bump_add_acl (.clock(clock),.resetn(resetn),.clear(start),.enable(input_enable),.add_sub(1'b0), .result(bump_add_reg[i]), .dataa(global_id_base_reg[i]), .datab( {{(WIDTH-1){1'b0}},{bump_local_id_reg[i]}} ) );
           acl_shift_register #(.WIDTH(WIDTH),.STAGES(3))
              local_id_op (.clock(clock),.resetn(resetn),.clear(start),.enable(input_enable),.Q(local_id_operand_mux_reg[i]), .D(local_id_operand_mux[i]) );
           acl_shift_register #(.WIDTH(1),.STAGES(3))
              enable_inst (.clock(clock),.resetn(resetn),.clear(start),.enable(input_enable),.Q(enable_mux_reg[i]), .D(enable_mux[i]) );

           assign local_id_operand_mux[i] = last_local_id[i] ?  -max_local_id[i] : 2'b01;
           assign global_id_mux[i] = just_seen_last_in_group_reg ? (bump_add_reg[i]) : (global_id[i] + local_id_operand_mux_reg[i]) ;

           always @(posedge clock or negedge resetn) begin
              if ( ~resetn ) begin
                 global_id[i] <= {WIDTH{1'b0}};
              end else if ( start ) begin
                 global_id[i] <= {WIDTH{1'b0}};
              end else if (enable_mux_reg[i] & input_enable)
              begin
                 global_id[i] <= global_id_mux[i];
              end
           end

        end

      end else begin

        always @(posedge clock or negedge resetn) begin
           if ( ~resetn ) begin
              global_id[0] <= {WIDTH{1'b0}};
              global_id[1] <= {WIDTH{1'b0}};
              global_id[2] <= {WIDTH{1'b0}};
           end else if ( start ) begin
              global_id[0] <= {WIDTH{1'b0}};
              global_id[1] <= {WIDTH{1'b0}};
              global_id[2] <= {WIDTH{1'b0}};
           end else // We presume that start and issue are mutually exclusive.
           begin
              if ( issue ) begin
                 if ( !last_in_group ) begin
                    if ( just_seen_last_in_group ) begin
                       // get new global_id starting point from dispatcher.
                       // global_id_base will be one cycle late, so get it on the next cycle
                       // after encountering last element in previous group.
                       // id iterator will know to ignore the global id value on that cycle.
                       global_id[0] <= global_id_base[0] + bump_local_id[0];
                       global_id[1] <= global_id_base[1] + bump_local_id[1];
                       global_id[2] <= global_id_base[2] + bump_local_id[2];
                    end else begin
                       if ( bump_local_id[0] ) global_id[0] <= (last_local_id[0] ? (global_id[0] - max_local_id[0]) : (global_id[0] + 2'b01));
                       if ( bump_local_id[1] ) global_id[1] <= (last_local_id[1] ? (global_id[1] - max_local_id[1]) : (global_id[1] + 2'b01));
                       if ( bump_local_id[2] ) global_id[2] <= (last_local_id[2] ? (global_id[2] - max_local_id[2]) : (global_id[2] + 2'b01));
                    end
                 end
              end
           end
        end

      end

    end else begin
       /**********************************************************************
          Stratix 10 (and later)
       ***********************************************************************/         
       localparam PIPELINE_DEPTH                 = 2;                       // number of pipeline stages between local ID counters and the output FIFO

       // parameters used when instantiating the output FIFO
       localparam FIFO_WIDTH                     = LOCAL_WIDTH_X+LOCAL_WIDTH_Y+LOCAL_WIDTH_Z+(3 * 2 * WIDTH);   // store local_id, global_id, and workgroup_id, each is 3 words wide
       localparam FIFO_DEPTH                     = 16;                      // number of words to store, needs to be deep enough so that when ALMOST_EMPTY first deasserts, there are enough words to supply the kernel while new words come through the pipeline and the FIFO latency
       // stall_out_lookahead_count must be large enough to account for both the time it takes to respond to stall_out_lookahead asserting (2 cycles)
       // as well as the output pipeline depth (PIPELINE_DEPTH)
       localparam FIFO_STALL_OUT_LOOKAHEAD_COUNT = PIPELINE_DEPTH+2;
       
       // determine the number of bits from each local_size[] input to use, normally will need LOCAL_WIDTH_<X|Y|Z> +1 bits (from LOCAL_WIDTH_<X|Y|Z> .. 0), unless LOCAL_WIDTH=32, then just use the full range of local_size
       // LOCAL_WIDTH values are the widths required for the ID counters to count from 0..local_size-1, thus local_size may require 1 extra bit, when it is exactly a power of 2 (thus the + 1)
       localparam MAX_LOCAL_SIZE_INDEX_X         = LOCAL_WIDTH_X==WIDTH ? WIDTH-1 : LOCAL_WIDTH_X;
       localparam MAX_LOCAL_SIZE_INDEX_Y         = LOCAL_WIDTH_X==WIDTH ? WIDTH-1 : LOCAL_WIDTH_Y;
       localparam MAX_LOCAL_SIZE_INDEX_Z         = LOCAL_WIDTH_X==WIDTH ? WIDTH-1 : LOCAL_WIDTH_Z;

       // counter state machine
       reg [1:0]                  counter_state;                                  // always takes on one of the following COUNTER_STATE_... values
       localparam                 COUNTER_STATE_WAIT_VALID_WORKGROUP  = 2'b00;
       localparam                 COUNTER_STATE_WAIT_OUTPUT_FIFO      = 2'b01;
       localparam                 COUNTER_STATE_ENABLED               = 2'b10;

       // counter and related control signals to disable the state machine during startup
       localparam                 HOLD_COUNT_WIDTH = 3;
       localparam                 START_HOLD_NUM_CYCLES = 2;
       reg                        start_hold;
       reg                        start_received;
       reg [HOLD_COUNT_WIDTH:0]   start_hold_count;

       // combinatorial signals
       wire                       count_rollover_comb;       // combinatorial signal - all three local id counters are ready to roll over
       
       wire                       output_fifo_stall_out_lookahead;
       reg                        output_fifo_stall_out_lookahead_reg;

       // capture group id and global id base when they are issued
       reg [WIDTH-1:0]            group_id_store[2:0];
       reg [WIDTH-1:0]            global_id_base_store[2:0];

       // current value of local id
       reg [LOCAL_WIDTH_X-1:0]    local_id_0; 
       reg [LOCAL_WIDTH_Y-1:0]    local_id_1;
       reg [LOCAL_WIDTH_Z-1:0]    local_id_2;

       // local id iteration counters, used to determine when the local_id counters should wrap around back to 0
       // these counters count down from a starting value to -1, so that the msb indicates they have reached the appropriate count value
       // counters have to be an extra bit wide so that the msb is only set to 1 when the value is negative (indicating the desired value has been reached)
       reg [LOCAL_WIDTH_X:0]      local_id_iter_count_0; 
       reg [LOCAL_WIDTH_Y:0]      local_id_iter_count_1;
       reg [LOCAL_WIDTH_Z:0]      local_id_iter_count_2;

       // value of local size - 2, these values are used to load the local_id_iter_count values
       // note that values of 0 and -1 are valid, and produce the desired results
       reg [LOCAL_WIDTH_X:0]      local_size_minus_two_0; 
       reg [LOCAL_WIDTH_Y:0]      local_size_minus_two_1;
       reg [LOCAL_WIDTH_Z:0]      local_size_minus_two_2;

       // pipeline registers
       reg [LOCAL_WIDTH_X-1:0]    local_id_0_pipe      [1:PIPELINE_DEPTH];
       reg [LOCAL_WIDTH_Y-1:0]    local_id_1_pipe      [1:PIPELINE_DEPTH];
       reg [LOCAL_WIDTH_Z-1:0]    local_id_2_pipe      [1:PIPELINE_DEPTH];
       reg                        valid_pipe           [1:PIPELINE_DEPTH];
       reg [WIDTH-1:0]            global_id_0_pipe     [2:PIPELINE_DEPTH];
       reg [WIDTH-1:0]            global_id_1_pipe     [2:PIPELINE_DEPTH];
       reg [WIDTH-1:0]            global_id_2_pipe     [2:PIPELINE_DEPTH];
       reg [WIDTH-1:0]            group_id_0_pipe      [2:PIPELINE_DEPTH];
       reg [WIDTH-1:0]            group_id_1_pipe      [2:PIPELINE_DEPTH];
       reg [WIDTH-1:0]            group_id_2_pipe      [2:PIPELINE_DEPTH];
       
       
       // instantiate a FIFO at the output of this block
       // outputs of the FIFO connect directly to the top-level block outputs
       acl_fifo_stall_valid_lookahead #(
          .DATA_WIDTH(FIFO_WIDTH),
          .DEPTH(FIFO_DEPTH),
          .STALL_OUT_LOOKAHEAD_COUNT(FIFO_STALL_OUT_LOOKAHEAD_COUNT),
          .VALID_OUT_LOOKAHEAD_COUNT(VALID_OUT_LOOKAHEAD_COUNT)
       ) output_fifo (
          .clock(clock),
          .resetn(resetn),
          .valid_in(valid_pipe[PIPELINE_DEPTH]),
          .stall_out(),     // not used, we use the lookahead version instead
          .stall_out_lookahead(output_fifo_stall_out_lookahead),      // this signal will be registered before being used
          .data_in ({ global_id_0_pipe[PIPELINE_DEPTH], global_id_1_pipe[PIPELINE_DEPTH], global_id_2_pipe[PIPELINE_DEPTH], 
                      group_id_0_pipe[PIPELINE_DEPTH], group_id_1_pipe[PIPELINE_DEPTH], group_id_2_pipe[PIPELINE_DEPTH],
                      local_id_0_pipe[PIPELINE_DEPTH], local_id_1_pipe[PIPELINE_DEPTH], local_id_2_pipe[PIPELINE_DEPTH] }),
          .valid_out(valid_out),
          .valid_out_lookahead(valid_out_lookahead),
          .stall_in(stall_in),
          .data_out({ global_id[0], global_id[1], global_id[2],
                      group_id[0], group_id[1], group_id[2],
                      local_id[0][LOCAL_WIDTH_X-1:0], local_id[1][LOCAL_WIDTH_Y-1:0], local_id[2][LOCAL_WIDTH_Z-1:0] })
       );
       
       // tie off unused upper bits of local_id busses
      if (LOCAL_WIDTH_X<WIDTH) begin
        assign local_id[0][WIDTH-1:LOCAL_WIDTH_X] = '0;
      end
      if (LOCAL_WIDTH_Y<WIDTH) begin
        assign local_id[1][WIDTH-1:LOCAL_WIDTH_Y] = '0;
      end
      if (LOCAL_WIDTH_Z<WIDTH) begin
        assign local_id[2][WIDTH-1:LOCAL_WIDTH_Z] = '0;
      end

       
       // determine when all three counters are going to roll-over (which indicates a new workgroup will be required)
       assign count_rollover_comb = local_id_iter_count_0[LOCAL_WIDTH_X] & local_id_iter_count_1[LOCAL_WIDTH_Y] & local_id_iter_count_2[LOCAL_WIDTH_Z];

       
       // clocked signals (note no async reset)
       always_ff @(posedge clock) begin
       
          // 
          if (~resetn) begin
             start_hold <= 1'b1;
             start_hold_count <= START_HOLD_NUM_CYCLES;
             start_received <= 1'b0;
          end else begin
             if (start) begin
                start_received <= 1'b1;                // assert start_received when start is asserted
                start_hold <= 1'b1;
                start_hold_count <= START_HOLD_NUM_CYCLES;
             end 
             if (start_received & ~start) begin        // only start counting down when start has been received, and start signal has been de-asserted
                if (start_hold_count[HOLD_COUNT_WIDTH]==1'b0) begin   // counter has not yet 'overflowed' to -1
                   start_hold_count <= start_hold_count - 1;             // decrement counter until it reaches -1
                end
             end
             start_hold <= ~start_hold_count[HOLD_COUNT_WIDTH];       // hold start_hold asserted until start_hold_count counter rolls over to -1
          end
       
          // register the stall_out_lookahead signal from the FIFO for better performance (just need to adjust the STALL_OUT_LOOKAHEAD_COUNT to adjust for the extra delay)
          // this register is also used to force the counter state machine to 'pause' after a start signal is received to allow all pre-calculated values to be determined
          output_fifo_stall_out_lookahead_reg <= output_fifo_stall_out_lookahead | start_hold;
       
          // state machine that controls the counters, and handles stalls and valids
          if (~resetn) begin
             // To avoid a dedicated RESET state, we start in the WAIT_VALID_WORKGROUP state, where we are stuck until there is a workgroup available AND output_fifo_stall_out_lookahead_reg is deasserted
             // We hold output_fifo_stall_out_lookahead_reg asserted artificially after reset and at power-up until the start signal is received
             counter_state <= COUNTER_STATE_WAIT_VALID_WORKGROUP;
             stall_out <= 1'b1;         // don't accept any new workgroups while resetting
          end else begin
             case (counter_state) 
                COUNTER_STATE_WAIT_VALID_WORKGROUP: begin    // waiting for one (or more) workgroups to be available, and for output fifo to have free space
                   if (~output_fifo_stall_out_lookahead_reg) begin          // if the output fifo is almost full, we just wait in this state
                      if (valid_in) begin                          // at least one valid workgroup is available, process that one 
                         counter_state <= COUNTER_STATE_ENABLED;
                         stall_out <= 1'b0;                           // accept a new workgroup
                      end else begin
                         counter_state <= COUNTER_STATE_WAIT_VALID_WORKGROUP;
                         stall_out <= 1'b1;
                      end
                   end else begin
                      counter_state <= COUNTER_STATE_WAIT_VALID_WORKGROUP;
                      stall_out <= 1'b1;
                   end
                end
                COUNTER_STATE_WAIT_OUTPUT_FIFO: begin        // waiting for space in the output FIFO, will not arrive here if a new workgroup is required
                   if (~output_fifo_stall_out_lookahead_reg) begin
                      counter_state <= COUNTER_STATE_ENABLED;
                   end else begin
                      counter_state <= COUNTER_STATE_WAIT_OUTPUT_FIFO;
                   end
                   stall_out <= 1'b1;
                end
                COUNTER_STATE_ENABLED: begin                 // normal counter operation, we know there is room in the output fifo and multiple workgroups available
                   if (count_rollover_comb) begin               // counters are about to roll over, will consume a workgroup
                      if (~valid_in_lookahead) begin               // one or fewer workgroups are available, must pause to give valid_in time to be accurate
                         counter_state <= COUNTER_STATE_WAIT_VALID_WORKGROUP;
                         stall_out <= 1'b1;
                      end else if (output_fifo_stall_out_lookahead_reg) begin     // workgroups are available, but need to stop generating new outputs due to output fifo
                         counter_state <= COUNTER_STATE_WAIT_OUTPUT_FIFO;
                         stall_out <= 1'b0;
                      end else begin
                         counter_state <= COUNTER_STATE_ENABLED;
                         stall_out <= 1'b0;
                      end
                   end else if (output_fifo_stall_out_lookahead_reg) begin     // need to stop generating new outputs 
                      counter_state <= COUNTER_STATE_WAIT_OUTPUT_FIFO;
                      stall_out <= 1'b1;
                   end else begin                                  // normal operation, keep generating new outputs
                      counter_state <= COUNTER_STATE_ENABLED;
                      stall_out <= 1'b1;
                   end
                end
             endcase
          end
          
          // calculate local size - 2 for each dimension of local size (no need to reset these values)
          // this calculation could be pipelined if necessary with no functional penalty, as it is only calculated during startup
          local_size_minus_two_0 <= local_size[0][MAX_LOCAL_SIZE_INDEX_X:0] - 3'd2;
          local_size_minus_two_1 <= local_size[1][MAX_LOCAL_SIZE_INDEX_Y:0] - 3'd2;
          local_size_minus_two_2 <= local_size[2][MAX_LOCAL_SIZE_INDEX_Z:0] - 3'd2;
        
          // calculate local id counters and iteration counters
          if (counter_state==COUNTER_STATE_WAIT_VALID_WORKGROUP) begin      // waiting for a valid workgroup, counters can always be reset in this state (this state also used as the reset/startup state)
             local_id_0 <= '0;
             local_id_1 <= '0;
             local_id_2 <= '0;
             local_id_iter_count_0 <= local_size_minus_two_0;
             local_id_iter_count_1 <= local_size_minus_two_1;
             local_id_iter_count_2 <= local_size_minus_two_2;
          end else if (counter_state==COUNTER_STATE_WAIT_OUTPUT_FIFO) begin // hold current counter values
             // do nothing
          end else begin                                                    // increment counters
             // local id 0 increments or wraps on every cycle enable is asserted
             if (local_id_iter_count_0[LOCAL_WIDTH_X]) begin
                local_id_0 <= '0;
                local_id_iter_count_0 <= local_size_minus_two_0;
             end else begin
                local_id_0 <= local_id_0 + 2'b01;
                local_id_iter_count_0 <= local_id_iter_count_0 - 1;
             end
             // local id 1 increments or wraps when local id 0 wraps and enable is asserted
             if (local_id_iter_count_0[LOCAL_WIDTH_X]) begin
                if (local_id_iter_count_1[LOCAL_WIDTH_Y]) begin
                   local_id_1 <= '0;
                   local_id_iter_count_1 <= local_size_minus_two_1;
                end else begin
                   local_id_1 <= local_id_1 + 2'b01;
                   local_id_iter_count_1 <= local_id_iter_count_1 - 1;
                end
             end
             // local id 2 increments or wraps when local id 0 and 1 both wrap and enable is asserted
             if (local_id_iter_count_0[LOCAL_WIDTH_X] && local_id_iter_count_1[LOCAL_WIDTH_Y]) begin
                if (local_id_iter_count_2[LOCAL_WIDTH_Z]) begin
                   local_id_2 <= '0;
                   local_id_iter_count_2 <= local_size_minus_two_2;
                end else begin
                   local_id_2 <= local_id_2 + 2'b01;
                   local_id_iter_count_2 <= local_id_iter_count_2 - 1;
                end
             end
          end
          
          // store group id and global id base inputs
          if (valid_in && ~stall_out) begin
             global_id_base_store <= global_id_base_in;
             group_id_store <= group_id_in;
          end
          
          // output pipeline for local id values
          local_id_0_pipe[1] <= local_id_0;
          local_id_1_pipe[1] <= local_id_1;
          local_id_2_pipe[1] <= local_id_2;
          for (int i=2;i<=PIPELINE_DEPTH;i++) begin
             local_id_0_pipe[i] <= local_id_0_pipe[i-1];
             local_id_1_pipe[i] <= local_id_1_pipe[i-1];
             local_id_2_pipe[i] <= local_id_2_pipe[i-1];
          end

          // output pipeline for workgroup and global ids starts one stage later than local id pipeline, due to delay when storing inputs from the upstream block
          global_id_0_pipe[2] <= global_id_base_store[0] + {{(WIDTH-LOCAL_WIDTH_X){1'b0}}, local_id_0_pipe[1]};
          global_id_1_pipe[2] <= global_id_base_store[1] + {{(WIDTH-LOCAL_WIDTH_Y){1'b0}}, local_id_1_pipe[1]};
          global_id_2_pipe[2] <= global_id_base_store[2] + {{(WIDTH-LOCAL_WIDTH_Z){1'b0}}, local_id_2_pipe[1]};
          group_id_0_pipe[2] <= group_id_store[0];
          group_id_1_pipe[2] <= group_id_store[1];
          group_id_2_pipe[2] <= group_id_store[2];
          for (int i=3;i<=PIPELINE_DEPTH;i++) begin
             global_id_0_pipe[i] <= global_id_0_pipe[i-1];
             global_id_1_pipe[i] <= global_id_1_pipe[i-1];
             global_id_2_pipe[i] <= global_id_2_pipe[i-1];
             group_id_0_pipe[i] <= group_id_0_pipe[i-1];
             group_id_1_pipe[i] <= group_id_1_pipe[i-1];
             group_id_2_pipe[i] <= group_id_2_pipe[i-1];
          end
       
          // generate valid signal and pipeline
          if (~resetn) begin
             valid_pipe[1] <= 1'b0;
          end else begin
             if (counter_state==COUNTER_STATE_ENABLED) begin
                valid_pipe[1] <= 1'b1;
             end else begin
                valid_pipe[1] <= 1'b0;
             end
          end
          for (int i=2;i<=PIPELINE_DEPTH;i++) begin
             if (~resetn) begin            // reset the entire pipeline, this is probably not required as reset will be held asserted long enough to flush out any unwanted valids, but is safer this way
                valid_pipe[i] <= 1'b0;
             end else begin
                valid_pipe[i] <= valid_pipe[i-1];
             end
          end

       end

    end
  endgenerate

endmodule

// vim:set filetype=verilog:

