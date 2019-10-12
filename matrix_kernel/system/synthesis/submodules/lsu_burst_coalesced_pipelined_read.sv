//// (C) 1992-2018 Intel Corporation.                            
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


// This module implements a burst-coalesced read LSU with extensive pipelining
// to acheive the best possible Fmax.  This module has been designed with a
// HyperFlex architecture in mind.
//
// An LSU is a 'load store unit'.  Since this is a Read LSU, it is really a
// load unit, meaning it fetches data from global memory for a kernel.  An LSU
// is essentially an adapter between the kernel side interface and the Avalon
// bus that connects to the memory interconnect.  
//
// The LSU also needs to pass valid signals (each valid is also called a 
// 'thread') on to the Kernel.  Every thread which enters the LSU must leave 
// the LSU.  For a read LSU, every thread is associated with a word of data.
//
// Along with the 'valid' signal, each incoming thread has a 'predicate' signal.
// NOTE: the 'predicate' signal in this interface should actually be called
// 'predicate_n', since a '0' on this signal means the transaction is
// predicated (should generate a write to memory), and a '1' on this signal
// means the transaction is NOT predicated (should not generate any transaction
// to the memory).
//
// The 'coalescing' part of this LSU involves taking the addresses from several
// threads and grouping them together.  Data sent to the kernel are
// called 'kernel words', and data from the memory through the Avalon
// interface are called 'memory words'.  Kernel words may be smaller than or
// the same width as memory words.  There are two levels of coalescing, both
// of which are supported by this LSU.  Within-word coalescing involves taking
// several kernel words which all map to a single (larger) memory word and
// sending them as a single memory word read.  Burst coalescing invlovles
// taking several (possible within-word coalesced) adjacent memory words
// and grouping them together into a single Avalon burst.
//
// Required files:
//    acl_reset_handler.sv
//    acl_std_synchronizer_nocut.v
//    acl_fanout_pipeline.sv
//    acl_fifo_stall_valid_lookahead.sv
//    acl_high_speed_fifo.sv
//    acl_lfsr.sv
//    acl_tessellated_incr_decr_threshold.sv



`default_nettype none

module lsu_burst_coalesced_pipelined_read #(
   parameter AWIDTH                    = 32,             // Address width of the Kernel and Avalon memory interfaces (address busses are byte based, not word based, so address bus widths are the same)

   parameter ALIGNMENT_ABITS           = 5,              // Kernel memory requests are guaranteed to have this many lower-order address bits set to '0'
                                                         // If ALIGNMENT_ABITS >= log2(WIDTH_BYTES), then this is an 'aligned' LSU, with all accesses aligned (no need for separate 'ALIGNED' parameter)
   parameter WIDTH_BYTES               = 4,              // Width of the Kernel memory data bus in bytes, must be a power of 2
                                                         // (really should be called 'KWIDTH_BYTES', but leaving it as is for historical reasons)
   parameter MWIDTH_BYTES              = 64,             // Width of the Avalon memory data bus in bytes, must be a power of 2
   parameter BURSTCOUNT_WIDTH          = 5,              // Size of Avalon burst count port
   parameter MAX_THREADS_PER_BURST_LOG2            = $clog2( ((MWIDTH_BYTES/WIDTH_BYTES) * 2**(BURSTCOUNT_WIDTH-1) * 2) ), // 2^MAX_THREADS_PER_BURST_LOG2 is the maximum number of threads to coalesce into a single burst
   parameter END_BURST_MWORD_BOUNDRY_THREADS_LOG2  = MAX_THREADS_PER_BURST_LOG2-1,                                         // if a new MWORD starts and the burst has 2^END_BURST_MWORD_BOUNDRY_THREADS_LOG2 or more threads, the burst will terminate
                                                                                                                           // the purpose of this is to encourage bursts to end on MWORD boundries when we get close to the maximum number of threads
   parameter TIMEOUT                   = 16,             // Number of consecutive clock cycles without a new valid transaction in before coalescing will be forced to end
   parameter USECACHING                = 0,              // TODO caching not currently supported
   parameter CACHE_DEPTH               = 1024,           // depth of cache (width is WIDTH_BYTES)
   parameter MIN_THREAD_CAPACITY       = 128,            // minimum number of threads this block must be able to accept when backpressured (stall_in asserted).  Note that this block may still stall before reaching this capacity if the Avalon bus stalls
   parameter MIN_MEMORY_BUFFER_DEPTH   = 256,            // minimum depth of the coalescing FIFOs.  Previous versions of the coalescing LSU increased the final multiplier to 3 when MWIDTH_BYTES == WIDTH_BYTES.
   parameter ACL_PROFILE               = 0,              // set to 1 to enable profiling
   parameter ASYNC_RESET               = 1,              // 1:i_resetn is used as an asynchonous reset, and resets all registers, 0:i_resetn is used as a synchronous reset, and resets only registers which require a reset 
   parameter SYNCHRONIZE_RESET         = 0,              // 1 - add a local synchronizer to the incoming reset signal
//*************************************************
// NOTE: STALL_LATENCY is currently NON-FUNCTIONAL!
//*************************************************
   parameter USE_STALL_LATENCY         = 0,              // 0 - legacy stall/valid protocol, 1 - enable stall latency protocol
   parameter UPSTREAM_STALL_LATENCY    = 0,              // round trip latency for the upstream (i_valid/o_stall) port, from o_stall being asserted to i_valid guaranteed deasserted.  Must be 0 if USE_STALL_LATENCY=0.
   parameter ALMOST_EMPTY_THRESH       = 1               // almost empty threshold, o_almost_empty asserts if the number of available thread is LESS THAN this number, only applies if USE_STALL_LATENCY=1
) (
   input  wire                            clock,               // all inputs/outputs are synchronous with clock
   input  wire                            i_resetn,             // reset input, must be synchronized to clock, can be used as a synchronous or an asynchronous reset depending on the value of ASYNC_RESET
                                                               // i_resetn must be held asserted for at least 16 (to be conservative) clock cycles to completely reset this module
      
   // Kernel input interface  
   input  wire                            i_valid,             // stall/valid behaviour determined by USE_STALL_LATENCY
   output logic                           o_stall,             
   input  wire                            i_predicate,         // when asserted with i_valid, indicates a valid thread that should NOT generate a memory transaction (the thread should just pass through this module)
   input  wire    [AWIDTH-1:0]            i_address,           // byte address for the write, validated by i_valid
   input  wire                            i_flush,             // force the cache (if enabled) to flush
 
   // Kernel output interface 
   output logic                           o_valid,             // stall/valid behaviour determined by USE_STALL_LATENCY
   input  wire                            i_stall,             
   output logic                           o_empty,             // empty/almost_empty only enabled when USE_STALL_LATENCY=1
   output logic                           o_almost_empty,
   output logic   [(WIDTH_BYTES*8)-1:0]   o_readdata,          // data read from the global memory, qualified by o_valid/i_stall
   output logic                           o_active,            // only de-asserted when this module is completely idle (no active threads or pending transactions)
   
   // Avalon interface  
   output logic                           avm_read,            // when avm_write is asserted and avm_waitrequest is not, a write transaction occurs, asserted for every data word transferred
   input  wire                            avm_waitrequest,     // asserted by the downstream block to prevent a new transaction TODO: add pipelining to this signal when "WAITREQUEST LATENCY" feature has been implemented in the interconnect
   output logic  [AWIDTH-1:0]             avm_address,         // byte address of the start of the burst
   output logic  [BURSTCOUNT_WIDTH-1:0]   avm_burstcount,      // number of words in the burst (note that this will NOT decrement as the burst progresses)
   output logic  [MWIDTH_BYTES-1:0]       avm_byteenable,      // byte enables
   input  wire   [(MWIDTH_BYTES*8)-1:0]   avm_readdata,        // data word
   input  wire                            avm_readdatavalid,   // asserted to indicate incoming read data is valid
   output logic                           extra_unaligned_reqs,   // TODO profiling signal, not relevant since this LSU currently only supports aligned accesses
   output logic                           req_cache_hit_count     // TODO profiling signal, not relevant since this LSU currently doesn't support caching
);

   localparam                    GENERATE_DEBUG_CODE = 0;                                    // when true, generate extra circuits useful for debug

   // Parameters used across multiple internal blocks
   localparam                    KERNEL_WORD_ABITS = ($clog2(MWIDTH_BYTES/WIDTH_BYTES));     // number of address bits to select the position of the Kernel memory word within the Avalon memory word (if MWIDTH_BYTES==WIDTH_BYTES, this is 0, meaning no address bits are needed)
   localparam                    BYTE_ABITS = ($clog2(WIDTH_BYTES));                         // number of address bits to select the byte within the kernel memory word
   localparam                    MWORD_ABITS = ($clog2(MWIDTH_BYTES));                       // number of address bits to select byte position with the Avalon memory word, these bits are not needed by the Avalon interface

   // signals used for feedback
   // most signals are feed-forward only, and so are declared as needed below, but these stall lookahead signals feed backwards to stall the pipeline
   logic                         fifo_stall_out_lookahead;                             // signal indicating FIFO buffers are almost full, so must stop generating new valid words
   
   ///////////////////////////////////////
   // Reset signal replication and pipelining
   //
   // In order to ensure that the reset signal is not a limiting factor when 
   // doing retiming, we create multiple copies of the reset signal and 
   // pipeline each adequately.
   ///////////////////////////////////////
   localparam                    NUM_RESET_COPIES = 1;
   localparam                    RESET_PIPE_DEPTH = 3;
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
      .i_resetn               (i_resetn),
      .o_aclrn                (aclrn),
      .o_sclrn                (sclrn),
      .o_resetn_synchronized  (resetn_synchronized)
   );

   
   ///////////////////////////////////////
   // Input block
   //
   // Capture incoming threads and data, generate stalls when necessary, and pre-calculate control signals for use later in the pipeline.
   ///////////////////////////////////////

   // Pipelined signals use the unpacked dimension to indicate location in the pipe.
   // Pipeline index N feeds into index N+1, and 1 is the first index used.
   // All signals at pipeline location N are co-timed with each other, so some signals will start later than
   // stage 1, and some will not persist for the full depth of the pipeline.
   localparam                    INPUT_PIPE_DEPTH = 3;                                       // if this number is to be changed to add additional pipelining, other code changes will also be required
   localparam                    INPUT_STALL_REACTION_CYCLES = 4;                            // this setting is conservative, indicates the number of additional valid threads that can pass through after the 'sloppy' stall signal is asserted
   logic                         valid_ipipe                [1:INPUT_PIPE_DEPTH];            // valid signal from the kernel, this signal qualifies all other signals in the (stall free) pipeline
   (* dont_merge *) logic        stall_out_ipipe            [0:1];                           // this is a bit backwards, stage 0 drives the o_stall signal, stage 1 is one clock delayed from stage 0
   logic                         predicate_ipipe            [1:INPUT_PIPE_DEPTH];  
   logic [AWIDTH-1:0]            address_ipipe              [1:INPUT_PIPE_DEPTH];
   logic [AWIDTH-1:MWORD_ABITS]  next_mword_address_ipipe   [2:INPUT_PIPE_DEPTH];            // address of the memory word after the current memory word (so current memory word address + 1)
                                                                                             // pre-calculated here for use later in the coalescer

   always_ff @(posedge clock or negedge aclrn) begin
   
      if (~aclrn) begin
      
         for (int i=1; i<=INPUT_PIPE_DEPTH; i++) begin
            valid_ipipe                [i]      <= '0;
            predicate_ipipe            [i]      <= '0;
            address_ipipe              [i]      <= '0;
         end
         for (int i=0; i<=1; i++) begin
            stall_out_ipipe            [i]      <= '0;
         end
         for (int i=2; i<=INPUT_PIPE_DEPTH; i++) begin
            next_mword_address_ipipe      [i]   <= '0;
         end
         o_stall                                <= '0;
      
      end else begin
      
         // valid pipeline, register the raw input then combine with the stall signal at the earliest opportunity
         // only the first stage of the valid pipeline is reset, the 0 will then propogate through the rest of the valid chain as long as i_resetn is held asserted long enough
         if (~sclrn[0]) begin
            valid_ipipe[1] <= 1'b0;
         end else begin
            if (USE_STALL_LATENCY) begin
               // when stall latency protocol is enabled, every valid MUST be accepted, regardless of state of o_stall
               valid_ipipe[1] <= i_valid;
            end else begin
               // when legacy stall/valid protocol is enabled, a thread is accepted only when o_stall=0 and i_valid=1
               valid_ipipe[1] <= i_valid & ~stall_out_ipipe[0];
            end
         end
         for (int i=2; i<=INPUT_PIPE_DEPTH; ++i) begin
            valid_ipipe[i] <= valid_ipipe[i-1];
         end
         
         // stall output and pipeline
         // the stall signal is an output, but we then capture it as part of the input pipeline to combine it with valid
         // stall_out_ipipe[0] is a copy of o_stall
         if (~sclrn[0]) begin
            stall_out_ipipe[0] <= 1'b1;         // assert o_stall during reset, so no threads can be lost if other blocks come out of reset before we do
            o_stall <= 1'b1;                    // duplicate of stall_out_ipipe[0], use the duplicate to allow internal retiming of stall_out_ipipe[0]
         end else begin
            // stall is generated from the same signals regardless of value of USE_STALL_LATENCY
            // when stall latency protocol is enabled, it changes the thresholds at which the 'stall_out_lookahed' signals are generated
            stall_out_ipipe[0] <= fifo_stall_out_lookahead;    // we implement a 'sloppy' stall, where the stall-free pipeline will continue to flush after this signal asserts (which is why it is a 'lookahead' signals)
            o_stall <= fifo_stall_out_lookahead;               // duplicate of stall_out_ipipe[0], use the duplicate to allow internal retiming of stall_out_ipipe[0]
         end
         stall_out_ipipe[1] <= stall_out_ipipe[0];
         
         // address pipelines
         // for predicated and invalid words, hold the previous value of address (and next mword address)
         // this makes processing downstream (where we are comparing to the last 'valid' address) easier
         address_ipipe[1]     <= i_address;
         if (valid_ipipe[1] & ~predicate_ipipe[1]) begin
            address_ipipe[2]     <= address_ipipe[1];
            next_mword_address_ipipe[2] <= address_ipipe[1][AWIDTH-1:MWORD_ABITS] + 1;
         end
         for ( int i=3; i<=INPUT_PIPE_DEPTH; ++i ) begin
            address_ipipe[i]              <= address_ipipe[i-1] ;
            next_mword_address_ipipe[i]   <= next_mword_address_ipipe[i-1] ;
         end
         
         // predicate and data signals just shift down the pipeline, no special cases
         predicate_ipipe[1]    <= i_predicate; 
         for ( int i=2; i<=INPUT_PIPE_DEPTH; ++i ) begin
            predicate_ipipe[i]    <= predicate_ipipe[i-1] ;
         end

      end
         
   end
   
   // generate the input_active signal
   logic                         input_active;                                               // asserted if there are any active threads in the input pipeline
   logic                         input_active_comb;                                          // combinatorial version of input_active, used to drive the input_active register
   always_comb begin
      input_active_comb = 1'b0;
      for( int i=1; i<=INPUT_PIPE_DEPTH; i++ ) begin
         input_active_comb = input_active_comb | valid_ipipe[i];
      end
   end
   always_ff @(posedge clock) begin
      input_active <= input_active_comb;
   end
 

   ///////////////////////////////////////
   // Coalescer (full burst coalescing)
   //
   // Coalesce incoming threads as long as their address is in range to be part of the same burst, otherwise push out the current read burst and 
   // start coalescing with the new thread.
   // A timeout (too long between valid incoming threads) can also cause a burst to be pushed out to the Avalon interface.
   ///////////////////////////////////////

   localparam                          COALESCER_PIPE_DEPTH = 5;                                         // if this number is to be changed, other code changes will also be required
   localparam                          TIMEOUT_CNT_WIDTH = ($clog2(TIMEOUT)+1);                          // number of bits for the timeout counter, extra bit (+1) is because the counter counts down from TIMEOUT-1 to -1
   logic                               valid_cpipe                [1:4];                                          // valid signal from the kernel, this signal qualifies all other signals in the (stall free) pipeline
   logic                               predicate_cpipe            [1:COALESCER_PIPE_DEPTH];                       // predicate, indicates no Avalon read required for this thread  
   logic [AWIDTH-1:MWORD_ABITS]        mword_address_cpipe        [1:COALESCER_PIPE_DEPTH];                       // address bits that specify the memory word address (lower bits that specify position within memory word not stored here)
   logic [MWORD_ABITS-ALIGNMENT_ABITS:0] kword_address_cpipe      [1:COALESCER_PIPE_DEPTH];                       // address bits that specify the position of the kernel word within the memory (Avalon) data word
                                                                                                                  // This bus has an extra msb so that even when ALIGNMENT_ABITS==MWORD_ABITS, this will still be a valid variable
                                                                                                                  // The one extra msb will be set to 0
   logic [AWIDTH-1:MWORD_ABITS]        next_mword_address_cpipe   [1:1];                                          // address of the memory word after the current memory word (so current memory word address + 1)
   logic                               same_mword_as_prev_cpipe   [1:1];                                          // asserted when this address lies within the same memory word as the previous address
   logic                               next_mword_to_prev_cpipe   [1:1];                                          // asserted when this address lies within the memory word of the previous address + 1
   logic                               cross_burst_boundary_cpipe [1:1];                                          // if next_mword_to_prev is asserted, then this signal indicates that we have crossed a burst boundary (otherwise this signal must be ignored)
   logic [TIMEOUT_CNT_WIDTH-1:0]       timeout_cnt_cpipe          [1:1];                                          // timeout counter, counts down to -1
   logic                               new_mword_cpipe            [2:3];                                          // asserted to indicate that this word should be the start of a new memory word (so burst_count will need to increment)
   logic                               new_burst_cpipe            [2:3];                                          // asserted to indicate that this word should be the start of a new memory word (so burst_count will need to increment)
   logic                               avalon_valid_cpipe         [4:4];
   logic [MAX_THREADS_PER_BURST_LOG2:0]   thread_count_cpipe      [4:4];                                          // number of threads coalesced into the current burst
   logic [BURSTCOUNT_WIDTH-1:0]        burst_count_cpipe          [4:COALESCER_PIPE_DEPTH];                       // number of words in the coalesced Avalon burst
   logic                               last_thread_in_mword_cpipe [COALESCER_PIPE_DEPTH:COALESCER_PIPE_DEPTH];    // indicates that the next thread requires data from a new readdata memory word
   logic                               write_thread_fifo_cpipe    [COALESCER_PIPE_DEPTH:COALESCER_PIPE_DEPTH];    // write to the thread FIFO
   logic                               write_avalon_fifo_cpipe    [COALESCER_PIPE_DEPTH:COALESCER_PIPE_DEPTH];    // write to the avalon FIFO
   
                                                                              
   // select the address bits that determine the location of the Kernel word within the Memory word
   generate
      if (MWORD_ABITS-ALIGNMENT_ABITS == 0 ) begin  : GENBLK_ABITS_EQ_0    // alignment of kernel word equals memory word size, kword_address is just one bit wide, and is forced to 0
         always_ff @(posedge clock) begin
            kword_address_cpipe[1] <= 1'b0;
         end
      end else begin                      : GENBLK_ABITS_NE_0     // alignment of kernel word is smaller than memory word size, kernel_word_addr selects proper bits from the addr bus and tacks a '0' on as the msb
         always_ff @(posedge clock or negedge aclrn) begin
            if (~aclrn) begin
               kword_address_cpipe[1] <= '0;
            end else begin
               kword_address_cpipe[1] <= { 1'b0, address_ipipe[INPUT_PIPE_DEPTH][MWORD_ABITS-1:ALIGNMENT_ABITS] };
            end
         end
      end
   endgenerate
   
   // implement the Coalescer pipeline
   always_ff @(posedge clock or negedge aclrn) begin
   
      if (~aclrn) begin
      
         for (int i=1; i<=COALESCER_PIPE_DEPTH; i++) begin
            predicate_cpipe            [i]         <= '0;
            mword_address_cpipe        [i]         <= '0;
         end
         for (int i=2; i<=COALESCER_PIPE_DEPTH; i++) begin
            kword_address_cpipe        [i]         <= '0;
         end
         for (int i=1; i<=4; i++) begin
            valid_cpipe                [i]         <= '0;
         end
         for (int i=4; i<=COALESCER_PIPE_DEPTH; i++) begin
            burst_count_cpipe          [i]         <= '0;
         end
         for (int i=2; i<=3; i++) begin
            new_mword_cpipe            [i]         <= '0;
            new_burst_cpipe            [i]         <= '0;
         end
         next_mword_address_cpipe      [1]         <= '0;
         same_mword_as_prev_cpipe      [1]         <= '0;
         next_mword_to_prev_cpipe      [1]         <= '0;
         cross_burst_boundary_cpipe    [1]         <= '0;
         timeout_cnt_cpipe             [1]         <= '0;
         avalon_valid_cpipe            [4]         <= '0;
         thread_count_cpipe            [4]         <= '0;
         last_thread_in_mword_cpipe [COALESCER_PIPE_DEPTH]  <= '0;
         write_thread_fifo_cpipe    [COALESCER_PIPE_DEPTH]  <= '0;
         write_avalon_fifo_cpipe    [COALESCER_PIPE_DEPTH]  <= '0;

      end else begin

         ///////////////////////////////
         // Pipeline Stage 1

         valid_cpipe[1]                <= valid_ipipe[INPUT_PIPE_DEPTH]; 
         predicate_cpipe[1]            <= predicate_ipipe[INPUT_PIPE_DEPTH];
         
         // address and next_mword_address are 'held' at the last valid, non-predicated value in the input pipeline stage, so we can just pass them straight through here
         mword_address_cpipe[1]        <= address_ipipe[INPUT_PIPE_DEPTH][AWIDTH-1:MWORD_ABITS];
         // kword_address_cpipe[1] is set in the generate statement above
         next_mword_address_cpipe[1]   <= next_mword_address_ipipe[INPUT_PIPE_DEPTH];
         
         // determine if this address can be coalesced with the last valid address to enter the pipeline
         // note that this could be a very large comparison plus the predicate check, but the retimer should have lots of registers to pull in from the input pipe where address simply gets shifted along
         // TODO this is a potential performance bottleneck, but at the moment the retimer seems to handle it well
         if (  (address_ipipe[INPUT_PIPE_DEPTH][AWIDTH-1:MWORD_ABITS] == mword_address_cpipe[1]) || 
               (predicate_ipipe[INPUT_PIPE_DEPTH] == 1'b1) 
         ) begin
            same_mword_as_prev_cpipe[1] <= 1'b1;
         end else begin
            same_mword_as_prev_cpipe[1] <= 1'b0;
         end

         // determine if this address is in the memory word immediately after the current word, and therefore could be coalesced into a larger burst
         // note that this could be a very large comparison, but the retimer should have lots of registers to pull in from the input pipe where address simply gets shifted along
         // no need to check predicate here, if predicate=1, same_mword will be set, so next_mword is not relevant
         // TODO this is a potential performance bottleneck, but at the moment the retimer seems to handle it well
         if ( address_ipipe[INPUT_PIPE_DEPTH][AWIDTH-1:MWORD_ABITS] == next_mword_address_cpipe[1] ) begin 
            next_mword_to_prev_cpipe[1] <= 1'b1;
         end else begin
            next_mword_to_prev_cpipe[1] <= 1'b0;
         end
         
         // determine if the transition from the previous memory word to this one will cross a burst boundary
         // Note that this signal is only valid when next_mword_to_prev is asserted (in other words it is only valid for consecutive addresses)
         // The convoluted logic below selects the appropriate bits to see if they are 0, when BURSTCOUNT_WIDTH == 1, the statement below always evaluates 
         // to 'true' so cross_burst_boundary_cpipe is always set to 1, as it should be
         if ( (address_ipipe[INPUT_PIPE_DEPTH] & { {(AWIDTH-(MWORD_ABITS+BURSTCOUNT_WIDTH-1)){1'b0}}, {(BURSTCOUNT_WIDTH-1){1'b1}}, {(MWORD_ABITS){1'b0}} }) == {(AWIDTH){1'b0}} ) begin
            cross_burst_boundary_cpipe[1] <= 1'b1;
         end else begin
            cross_burst_boundary_cpipe[1] <= 1'b0;
         end
         
         // timeout counter
         // counts down from TIMEOUT-1 to -1, counter is reset by any incoming valid signal
         // counter will continue to count and will roll-over if no incoming valids are received, but additional timeouts with no valid data will be ignored
         if ( valid_ipipe[INPUT_PIPE_DEPTH]  ) begin
            timeout_cnt_cpipe[1] <= TIMEOUT-1;
         end else begin
            timeout_cnt_cpipe[1] <= timeout_cnt_cpipe[1]-1;
         end


         ///////////////////////////////
         // Pipeline Stage 2
         //
         // Partial determination of new_mword and new_burst signals (remainder of logic happens in the next pipeline stage)

         // straight passthrough signals
         valid_cpipe[2]                <= valid_cpipe[1]; 
         predicate_cpipe[2]            <= predicate_cpipe[1];
         mword_address_cpipe[2]        <= mword_address_cpipe[1];
         kword_address_cpipe[2]        <= kword_address_cpipe[1];

         // determine if this thread will be the start of a new memory word (not yet taking into account the number of threads that have been coalesced)
         new_mword_cpipe[2] <= (
            ( timeout_cnt_cpipe[1][TIMEOUT_CNT_WIDTH-1] ) |                                        // timeout has occured
            ( valid_cpipe[1] & ~same_mword_as_prev_cpipe[1] ) );                                   // this thread is not part of the same memory word (predicated threads will be considered part of the same word)
            
         // deterime if this thread will be the start of a new burst (not yet taking into account the number of threads that have been coalesced)
         new_burst_cpipe[2] <= (
            ( timeout_cnt_cpipe[1][TIMEOUT_CNT_WIDTH-1] ) |                                        // timeout has occured
            ( valid_cpipe[1] & ~same_mword_as_prev_cpipe[1] & ~next_mword_to_prev_cpipe[1] ) |     // starting a new MWORD that is not at a sequential MWORD address
            ( valid_cpipe[1] & ~same_mword_as_prev_cpipe[1] & 
              next_mword_to_prev_cpipe[1] & cross_burst_boundary_cpipe[1] ) );                     // starting a new MWORD that crosses a burst boundry
         
         ///////////////////////////////
         // Pipeline Stage 3
         
         // straight passthrough signals
         valid_cpipe[3]                <= valid_cpipe[2]; 
         predicate_cpipe[3]            <= predicate_cpipe[2];
         mword_address_cpipe[3]        <= mword_address_cpipe[2];
         kword_address_cpipe[3]        <= kword_address_cpipe[2];
         
         // combine new_mword signal with information about thread_count
         new_mword_cpipe[3] <= (
            ( new_mword_cpipe[2] ) |                                                               // already determined this will be the start of a new mword, regardless of thread_count
            ( valid_cpipe[2] & thread_count_cpipe[4][MAX_THREADS_PER_BURST_LOG2] ) );              // forcing a new burst because we've reached the maximum thread count

         // combine new_burst signal with information about thread count
         new_burst_cpipe[3] <= (
            ( new_burst_cpipe[2] ) |                                                               // already determined this will be the start of a new burst, regardless of thread_count
            ( valid_cpipe[2] & thread_count_cpipe[4][MAX_THREADS_PER_BURST_LOG2] ) |               // forcing a new burst because we've reached the maximum thread count
            ( valid_cpipe[2] & new_mword_cpipe[2] & 
              thread_count_cpipe[4][END_BURST_MWORD_BOUNDRY_THREADS_LOG2] ) );                     // starting a new MWORD and we have reached the threshold in threads in a burst where we will terminate on an MWORD boundry

         ///////////////////////////////
         // Pipeline Stage 4
         // 
         // This stage of the pipeline holds some state and is not purely feed-forward, so some resets are introduced here.

         // Signals that feed the thread FIFO
         // A thread will be held here (at pipeline stage 4) until a new (valid) thread comes along to push it out, or
         // some other event causes the current burst to terminate (timeout or max thread count reached)
         if ( valid_cpipe[3] | new_burst_cpipe[3] ) begin
            valid_cpipe[4] <= valid_cpipe[3];
            predicate_cpipe[4] <= predicate_cpipe[3];
            kword_address_cpipe[4] <= kword_address_cpipe[3];
         end
         if ( ~sclrn[0] ) begin                // reset this valid, since it has feedback and might not flush properly just by setting the incoming valid signal to 0
            valid_cpipe[4] <= 1'b0;
            // values of predicate and address are irrelevant if valid==0, so no need to reset them
         end
         
         // avalon_valid depends on incoming valid from previous state or can hold its current state while coalescing is occuring
         if ( new_burst_cpipe[3] ) begin           // if we are stopping coalescing, load the new valid bit
            avalon_valid_cpipe[4] <= valid_cpipe[3] & ~predicate_cpipe[3];    // predicated threads do not lead to any avalon transaction
         end else begin                            // not starting a new burst, combine incoming valid/predicate bits with current bit (so valid will get set when a new burst begins)
            avalon_valid_cpipe[4] <= avalon_valid_cpipe[4] | (valid_cpipe[3] & ~predicate_cpipe[3]);
         end
         if ( ~sclrn[0] ) begin             // reset this valid, since it has feedback and might not flush properly just by setting the incoming valid signal to 0
            avalon_valid_cpipe[4] <= 1'b0;
         end

         // count the number of threads within the coalesced burst
         // This counter is implemented in a 'sloppy' way that results in some variablility as to exactly when a burst will
         // be terminated.  First, it will include predicated threads that come before the actual coalescing begins, even though
         // these threads will not be 'waiting' for the result of any read.  Second, this counter is used back in pipeline stage
         // 3, but is not calculated until pipeline stage 4, so it is slightly 'stale' when used.  This may result in one
         // more threads than the 'maximum' number being coalesced into the burst.
         if ( new_burst_cpipe[3] ) begin              // set the counter to 1 (if a valid thread comes with the new mword) or 0 (if no valid thread is incoming)
            thread_count_cpipe[4] <= { {(MAX_THREADS_PER_BURST_LOG2-1){1'b0}}, valid_cpipe[3] };
         end else begin                               // not starting a new burst, increment the counter for each valid thread
            thread_count_cpipe[4] <= thread_count_cpipe[4] + { {(MAX_THREADS_PER_BURST_LOG2-1){1'b0}}, valid_cpipe[3] };
         end
         if ( ~sclrn[0] ) begin
            thread_count_cpipe[4] <= '0;                 // reset the counter to 0
         end
         
         // generate burst_count and memory address (which does not change as we coalesce a burst)
         // Note that we rely on detection of crossing a burst boundary to end burst coalescing, which eliminates the need to check the actual burst count
         // NOTE the RESET assignment happens AFTER this logic
         if ( new_burst_cpipe[3] | ~avalon_valid_cpipe[4] ) begin    // incoming thread is the start of a new burst (or potentially the start of a new burst, since no valid burst has started yet)
            burst_count_cpipe[4] <= {{(BURSTCOUNT_WIDTH-1){1'b0}},{1'b1}};       // reset the burst counter to 1
            mword_address_cpipe[4] <= mword_address_cpipe[3];                    // load the new address value
         end else if ( new_mword_cpipe[3] ) begin                    // incoming thread is the start of a new memory word within the same burst
            burst_count_cpipe[4] <= burst_count_cpipe[4] + 1;                    // increment the burst counter   
            mword_address_cpipe[4] <= mword_address_cpipe[4];                    // hold the current address value (which is the address of the start of the burst)
         end
         if ( ~sclrn[0] ) begin    // if reset is asserted, this assignment overrides the assignment above
            burst_count_cpipe[4] <= {{(BURSTCOUNT_WIDTH-1){1'b0}},{1'b1}};       // reset the counter to 1
         end
         

            
         ///////////////////////////////
         // Final Pipeline Stage
         
         // straight passthrough signals
         predicate_cpipe            [COALESCER_PIPE_DEPTH] <= predicate_cpipe          [4];
         burst_count_cpipe          [COALESCER_PIPE_DEPTH] <= burst_count_cpipe        [4];
         kword_address_cpipe        [COALESCER_PIPE_DEPTH] <= kword_address_cpipe      [4];
         mword_address_cpipe        [COALESCER_PIPE_DEPTH] <= mword_address_cpipe      [4];

         
         // if the incoming thread (valid or not) to the previous stage represents a new MWORD, then the current thread must be the last thread in the current MWORD, UNLESS
         // the current thread is not associated with an MWORD (as indicated by avalon_valid == 0) - this case can happen when a predicated thread is received when no burst is being actively coalesced
         // this signal essentially 'skips' a pipeline stage, which changes it's meaing from 'new mword' (this is the first thread in an mword) to 'last_thread' (this is the LAST thread in an mword)
         last_thread_in_mword_cpipe[COALESCER_PIPE_DEPTH] <= new_mword_cpipe[3] & avalon_valid_cpipe[4];

         // determine when to write to the thread FIFO
         // write when there is a valid thread sitting in the previous stage, AND that thread is being forced out by a new incoming thread or some other reason for terminating a burst (such as a timeout)
         write_thread_fifo_cpipe[COALESCER_PIPE_DEPTH] <= valid_cpipe[4] & (valid_cpipe[3] | new_burst_cpipe[3]);
         
         // determine when to write to the Avalon FIFO
         // write when there is a valid burst sitting in the previous stage, AND that burst is being forced out by a new incoming burst
         write_avalon_fifo_cpipe[COALESCER_PIPE_DEPTH] <= avalon_valid_cpipe[4] & new_burst_cpipe[3];

      end
         
   end
   
   
   // generate the coalescer_active signal
   logic                               coalescer_active;                      // asserted if there are any active threads in the coalescer pipeline
   logic                               coalescer_active_comb;                 // combinatorial version of coalascer_active, used to drive the coalescer_active register
   always_comb begin
      coalescer_active_comb = write_thread_fifo_cpipe[COALESCER_PIPE_DEPTH] | write_avalon_fifo_cpipe[COALESCER_PIPE_DEPTH];
      for( int i=1; i<COALESCER_PIPE_DEPTH; i++ ) begin
         coalescer_active_comb = coalescer_active_comb | valid_cpipe[i];
      end
   end
   always_ff @(posedge clock or negedge aclrn) begin
      if (~aclrn) begin
         coalescer_active <= '0;
      end else begin
         coalescer_active <= coalescer_active_comb;
      end
   end

   
   ///////////////////////////////////////
   // FIFO Buffers
   //
   // There are three FIFOs, one for threads waiting for data (thread_fifo), one for Avalon 
   // transactions waiting to be sent to the global memory interconnect (avalon_fifo), and
   // one to store returned read data (readdata_fifo).
   // 
   // The stall_lookahead (almost_full) flag from the thread FIFO is fed back to the input 
   // block to stop the flow of new threads.  The stall_lookahead threshold is set to 
   // ensure the FIFO will have enough room to accept all words in the pipeline when the 
   // signal asserts.  There will be at least one thread per avalon transaction and at least
   // one thread per returned data word, so the other fifos are guaranteed to fill up no sooner
   // than the thread_fifo, thus their almost_full flags can be safely ignored.
   ///////////////////////////////////////

   localparam  TOTAL_UPSTREAM_STALL_LATENCY = INPUT_PIPE_DEPTH + COALESCER_PIPE_DEPTH + UPSTREAM_STALL_LATENCY + INPUT_STALL_REACTION_CYCLES;   // latency from when a stall is asserted to when the last valid thread will be received
   localparam  MIN_FIFO_DEPTH_FOR_PIPELINE = (2 * TOTAL_UPSTREAM_STALL_LATENCY );                                                               // make sure FIFO will not have time to empty after stall de-asserted before new valid threads reach it
   localparam  MIN_FIFO_DEPTH = MIN_MEMORY_BUFFER_DEPTH > MIN_FIFO_DEPTH_FOR_PIPELINE ? MIN_MEMORY_BUFFER_DEPTH : MIN_FIFO_DEPTH_FOR_PIPELINE;  // choose the larger of the two minimums
   localparam  FIFO_DEPTH_LOG2 = $clog2(MIN_FIFO_DEPTH);
   localparam  FIFO_DEPTH = (2**FIFO_DEPTH_LOG2);                                                     // round the FIFO depth up to the nearest power of 2
   localparam  THREAD_FIFO_WIDTH = ((MWORD_ABITS-ALIGNMENT_ABITS+1)+1+1);                             // address bits to determine kernel word position within the memory word, predicate bit, and last_thread_in_mword bit
   localparam  AVALON_FIFO_WIDTH = ((AWIDTH-MWORD_ABITS)+ BURSTCOUNT_WIDTH);                          // address bits to specify location of memory word, and burstcount bits
   localparam  FIFO_STALL_OUT_LOOKAHEAD_COUNT = TOTAL_UPSTREAM_STALL_LATENCY;                        // must provide space in the FIFO for the pipeline feeding the FIFO to completely flush, including time for the input circuit to react

   // connections to the thread_fifo
   logic                               thread_fifo_valid_out;
   logic                               thread_fifo_stall_in;
   logic [MWORD_ABITS-ALIGNMENT_ABITS:0]  kword_address_thread_fifo;
   logic                               predicate_thread_fifo;
   logic                               last_word_in_mword_thread_fifo;
   
   // connections to the avalon_fifo
   logic                               avalon_fifo_valid_out;
   logic                               avalon_fifo_stall_in;
   logic [AWIDTH-1:0]                  address_avalon_fifo;       // lower bits are hard-coded to 0
   logic [BURSTCOUNT_WIDTH-1:0]        burst_count_avalon_fifo;
   
   // connections to the readdata_fifo
   logic                               readdata_fifo_valid_out;
   logic                               readdata_fifo_stall_in;
   logic [MWIDTH_BYTES*8-1:0]          dout_readdata_fifo;

   // thread_fifo
   acl_fifo_stall_valid_lookahead #(
      .DATA_WIDTH(THREAD_FIFO_WIDTH),
      .DEPTH(FIFO_DEPTH),
      .STALL_OUT_LOOKAHEAD_COUNT(FIFO_STALL_OUT_LOOKAHEAD_COUNT),
      .VALID_OUT_LOOKAHEAD_COUNT(3),                           // not used
      .REGISTERED_DATA_OUT_COUNT(2),                           // only register the last_word_in_mword bit and predicate_thread bit
      .IMPL("acl_highspeed")
   ) 
   thread_fifo 
   (
      .clock(clock),
      .resetn(resetn_synchronized),
      .valid_in(write_thread_fifo_cpipe[COALESCER_PIPE_DEPTH]),
      .stall_out(),                                            // use stall_out_lookahead instead of stall_out
      .stall_out_lookahead(fifo_stall_out_lookahead),          // this signal is fed back to stall the input section before the FIFO(s) can overflow
      .data_in( {kword_address_cpipe[COALESCER_PIPE_DEPTH], predicate_cpipe[COALESCER_PIPE_DEPTH], last_thread_in_mword_cpipe[COALESCER_PIPE_DEPTH]} ),
      .valid_out(thread_fifo_valid_out),
      .valid_out_lookahead(),                                  // not used
      .stall_in(thread_fifo_stall_in),                         // drive low to read a word from the FIFO
      .data_out( {kword_address_thread_fifo, predicate_thread_fifo, last_word_in_mword_thread_fifo} )
   );
   
   // avalon_fifo
   acl_fifo_stall_valid_lookahead #(
      .DATA_WIDTH(AVALON_FIFO_WIDTH),
      .DEPTH(FIFO_DEPTH),
      .STALL_OUT_LOOKAHEAD_COUNT(FIFO_STALL_OUT_LOOKAHEAD_COUNT),    // not used (we rely on the stall_out_lookahead from the thread_fifo to determine when to stall)
      .VALID_OUT_LOOKAHEAD_COUNT(3),                                 // unused
      .REGISTERED_DATA_OUT_COUNT(0),                                 // all outputs feed into registers, no need to register outputs
      .IMPL("acl_highspeed")
   ) 
   avalon_fifo
   (
      .clock(clock),
      .resetn(resetn_synchronized),
      .valid_in(write_avalon_fifo_cpipe[COALESCER_PIPE_DEPTH]),
      .stall_out(),                                            // use stall_out_lookahead instead of stall_out
      .stall_out_lookahead(),                                  // not used (we rely on the stall_out_lookahead from the thread_fifo to determine when to stall)
      .data_in( {mword_address_cpipe[COALESCER_PIPE_DEPTH], burst_count_cpipe[COALESCER_PIPE_DEPTH]} ),
      .valid_out(avalon_fifo_valid_out),
      .valid_out_lookahead(),                                  // not used
      .stall_in(avalon_fifo_stall_in),                         // drive low to read a word from the FIFO
      .data_out( {address_avalon_fifo[AWIDTH-1:MWORD_ABITS], burst_count_avalon_fifo} )
   );
   assign address_avalon_fifo[MWORD_ABITS-1:0] = '0;      // these address bits unused at this point, carry them around for simplicity in connecting ports

   // readdata_fifo
   acl_fifo_stall_valid_lookahead #(
      .DATA_WIDTH(MWIDTH_BYTES*8),
      .DEPTH(FIFO_DEPTH),
      .STALL_OUT_LOOKAHEAD_COUNT(FIFO_STALL_OUT_LOOKAHEAD_COUNT),    // not used (we rely on the stall_out_lookahead from the thread_fifo to determine when to stall)
      .VALID_OUT_LOOKAHEAD_COUNT(3),                                 // unused
      .REGISTERED_DATA_OUT_COUNT(0),                                 // all outputs feed into registers, no need to register outputs
      .IMPL("acl_highspeed")
   ) 
   readdata_fifo
   (
      .clock(clock),
      .resetn(resetn_synchronized),
      .valid_in(avm_readdatavalid),
      .stall_out(),                                            // incoming read data can't be stalled
      .stall_out_lookahead(),                                  // not used (we rely on the stall_out_lookahead from the thread_fifo to determine when to stall)
      .data_in(avm_readdata),
      .valid_out(readdata_fifo_valid_out),
      .valid_out_lookahead(),                                  // not used
      .stall_in(readdata_fifo_stall_in),                       // drive low to read a word from the FIFO
      .data_out( dout_readdata_fifo )
   );
   
   
   
   // generate the fifo_active signal
   // can't simply use the empty signal from the FIFO, since there could be high latency between a new write and empty being de-asserted
   // only can be inactive if empty is asserted N clock cycles after the last write, where N is the latency from write to empty
   localparam                          FIFO_WRITE_TO_EMPTY_LATENCY = 5;       // This is conservative for SCFIFO, accurate for acl_highspeed_fifo
   localparam                          FIFO_EMPTY_CNT_WIDTH = ($clog2(FIFO_WRITE_TO_EMPTY_LATENCY+1) + 1);     // counter counts down to -1, so need an extra bit of width
   logic [FIFO_EMPTY_CNT_WIDTH-1:0]    fifo_empty_counter;                    // count down from time of last write to the FIFO to determine when EMPTY flag can be trusted
   logic                               fifo_active;                           // asserted if there are any pending memory transactions in the FIFO
   
   always_ff @(posedge clock or negedge aclrn) begin
   
      if (~aclrn) begin
      
         fifo_empty_counter      <= '0;
         fifo_active             <= '0;
      
      end else begin
      
         // implement a counter that compensates for the latency between writing to the FIFO and the valid output (~empty) being asserted
         if( ~sclrn[0] ) begin
            fifo_empty_counter <= {{FIFO_EMPTY_CNT_WIDTH}{1'b1}};       // initialize the counter to -1, indicating no pending memory transactions in the FIFO
         end else begin
            if( write_thread_fifo_cpipe[COALESCER_PIPE_DEPTH] ) begin   // writing a new word into the FIFO
               fifo_empty_counter <= FIFO_WRITE_TO_EMPTY_LATENCY - 1;      // load the counter to begin a countdown
            end else begin
               if( ~fifo_empty_counter[FIFO_EMPTY_CNT_WIDTH-1] ) begin     // only count down until counter rolls over to -1
                  fifo_empty_counter <= fifo_empty_counter - 1;
               end
            end
         end
         
         // generate the fifo_active signal
         // assert if there is valid data in the fifo, or a new word is being written to the FIFO, or the counter to compensate for FIFO latency has not yet counted down to -1
         if( thread_fifo_valid_out | write_thread_fifo_cpipe[COALESCER_PIPE_DEPTH] | ~fifo_empty_counter[FIFO_EMPTY_CNT_WIDTH-1] ) begin
            fifo_active <= 1'b1;
         end else begin
            fifo_active <= 1'b0;
         end
      
      end
      
   end



   ///////////////////////////////////////
   // Avalon Interface
   //
   // Reads commands out of the FIFO Buffer and sends them as avalon read commands.
   // At the moment, this interface is simply direct connections to the avalon_fifo.  Pipelining
   // may be added in the future, especially to deal with unaligned reads.
   ///////////////////////////////////////

   localparam                          AVALON_PIPE_DEPTH = 0;  // currently no pipeline needed here

   assign avm_read = avalon_fifo_valid_out;
   assign avalon_fifo_stall_in = avm_waitrequest;
   assign avm_address = address_avalon_fifo;
   assign avm_burstcount = burst_count_avalon_fifo;
   assign avm_byteenable = '1;                                 // unused for reads, set all bits to 1

   // generate the avalon_active signal
   logic                               avalon_active;                         // asserted if there are any active threads in the avalon pipeline
   assign avalon_active = 1'b0;                                               // this signal not used at the moment
   
   
   ///////////////////////////////////////
   // Data Pipeline
   //
   // Pull read data from the readdata_fifo, and threads from the thread_fifo,
   // and combine them to write into the output_fifo.  This pipeline only stalls
   // when the output fifo signals almost full.
   //
   // TODO: If the zero-cycle stall interface is replaced with the stall latency scheme
   //       (or something similar), we can do away with the final output FIFO.
   ///////////////////////////////////////
   
   localparam                          DATA_PIPE_DEPTH = 3;    // TODO make this a function of the size of the mux required?
   
   logic                               data_pipe_stall_out_lookahead;                        // stall from the FIFO at the end of the data pipe, TODO can be replaced with incoming stall if stall_latency supported in the future
   logic                               valid_dpipe                   [1:DATA_PIPE_DEPTH];    // valid signal at each stage of the pipeline
   logic [MWORD_ABITS-ALIGNMENT_ABITS:0]  kword_address_dpipe        [1:1];
   logic [MWIDTH_BYTES*8-1:0]          mword_data_dpipe              [1:1];
   logic [WIDTH_BYTES*8-1:0]           kword_data_dpipe              [2:DATA_PIPE_DEPTH];
   
   // Determine when to stall the readdata_fifo
   // If we are stalling from downstream, then always stall
   // Othrwise, if the thread leaving the thread fifo is NOT the last thread in this MWORD, then stall.
   // If the readdata_fifo does not have valid data, then state of stall is irrelevant.  If it DOES have
   // valid data, then we know the thread fifo will also have valid data (threads will always reach the
   // FIFOs before returned readdata), so no need to check the valid signals from either FIFO.
   assign readdata_fifo_stall_in = data_pipe_stall_out_lookahead | ~last_word_in_mword_thread_fifo;
   
   // Determine when to stall the thread_fifo.
   // If we are stalling from downstream, then always stall
   // Otherwise, don't stall if the current thread is predicated (no need to wait for readdata) or if
   // readdata is available.  If the thread fifo does not have valid data, then the state of stall is
   // irrelevant, so no need to check the thread_fifo valid output.
   assign thread_fifo_stall_in = data_pipe_stall_out_lookahead | (~predicate_thread_fifo & ~readdata_fifo_valid_out);
   
   always_ff @(posedge clock or negedge aclrn) begin
   
      if (~aclrn) begin

         for (int i=1; i<=DATA_PIPE_DEPTH;i++) begin
            valid_dpipe                   [i]   <= '0;
         end
         kword_data_dpipe                 [3]   <= '0;
         kword_address_dpipe              [1]   <= '0;
         mword_data_dpipe                 [1]   <= '0;
      
      end else begin
      
         ///////////////////////////////
         // Pipeline Stage 1
         
         // determine when a valid thread has entered the pipeline
         if ( ~data_pipe_stall_out_lookahead ) begin                       // when stalling due to downstream FIFO, do not accept any new theads into the pipeline
            valid_dpipe[1] <= (
               ( thread_fifo_valid_out & predicate_thread_fifo ) |            // a valid predicated thread is available, it doesn't have to wait for readdata
               ( readdata_fifo_valid_out )                                    // valid read data is available (threads will always reach the thread_fifo before readdata is available, so no need to check valid out of thread fifo here)
            );                                 
         end else begin
            valid_dpipe[1] <= 1'b0;
         end
         
         // signals that just pass straight through
         kword_address_dpipe[1]  <= kword_address_thread_fifo;
         mword_data_dpipe[1]     <= dout_readdata_fifo;
         
         
         ///////////////////////////////
         // Pipeline Stage 2
         
         // valid is just passed along
         valid_dpipe[2]          <= valid_dpipe[1];
         
         // implement the mux to select the appropriate data bits here in this pipeline stage
         // mux is implemented below in a generate statement
         // rely on the retimer to push register stages into the muxes as required

         ///////////////////////////////
         // Pipeline Stage 3
         
         // all signals simply pass through
         // this stage exists to provide the retimer with extra registers for implementing the mux to
         // select the appropriate data signals
         valid_dpipe[3]          <= valid_dpipe[2];
         kword_data_dpipe[3]     <= kword_data_dpipe[2];
         
      end
      
   end
   
   // This generate statement is part of Pipeline stage 2
   // create a MUX to select the proper bits from the memory word data
   // This uses a generate statement, so has to be outside the always block above
   generate
      if (MWORD_ABITS-ALIGNMENT_ABITS == 0 ) begin  : GENBLK_NOMUX   // alignment of kernel word equals memory word size
         always_ff @(posedge clock or negedge aclrn) begin
            if (~aclrn) begin
               kword_data_dpipe[2] <= '0;
            end else begin
               kword_data_dpipe[2] <= mword_data_dpipe[1][WIDTH_BYTES*8-1:0];
            end
         end
      end else begin                      : GENBLK_GENMUX            // alignment of kernel word is smaller than memory word size
         always_ff @(posedge clock or negedge aclrn) begin
            if (~aclrn) begin
               kword_data_dpipe[2] <= '0;
            end else begin
               kword_data_dpipe[2] <= mword_data_dpipe[1][ ( ( (kword_address_dpipe[1][MWORD_ABITS-ALIGNMENT_ABITS-1:0]) << ALIGNMENT_ABITS ) * 8 ) +: WIDTH_BYTES*8 ];
            end
         end
      end
   endgenerate
   
   // output FIFO for final readdata 
   acl_fifo_stall_valid_lookahead #(
      .DATA_WIDTH(WIDTH_BYTES*8),                                 // data bits
      .DEPTH(32),                                                 // Only a small FIFO is required here, enough to ensure constant data flow without introducing bubbles
      .STALL_OUT_LOOKAHEAD_COUNT(DATA_PIPE_DEPTH+2),              // need to be able to accept all data in the data pipe after asserting stall_lookahead
      .VALID_OUT_LOOKAHEAD_COUNT(3),                              // not used
      .REGISTERED_DATA_OUT_COUNT(0),                              // assume all outputs feed into registers, no need to register outputs
      .IMPL("acl_highspeed")
   ) 
   dout_fifo 
   (
      .clock(clock),
      .resetn(resetn_synchronized),
      .valid_in(valid_dpipe[DATA_PIPE_DEPTH]),
      .stall_out(),                                            // use stall_out_lookahead instead of stall_out
      .stall_out_lookahead(data_pipe_stall_out_lookahead),     // this signal is fed back to the start of the data pipeline
      .data_in( kword_data_dpipe[DATA_PIPE_DEPTH] ),
      .valid_out(o_valid),
      .valid_out_lookahead(),                                  // not used
      .stall_in(i_stall),
      .data_out( o_readdata )
   );

   // generate the dpipe_active signal
   // can't simply use the empty signal from the FIFO, since there could be high latency between a new write and empty being de-asserted
   // only can be inactive if empty is asserted N clock cycles after the last write, where N is the latency from write to empty
   logic [FIFO_EMPTY_CNT_WIDTH-1:0]    dfifo_empty_counter;                   // count down from time of last write to the FIFO to determine when EMPTY flag can be trusted
   logic                               dfifo_active;                          // asserted if there are any pending memory transactions in the FIFO
   logic                               dpipe_active_comb;
   logic                               dpipe_active;

   always_ff @(posedge clock or negedge aclrn) begin
   
      if (~aclrn) begin
      
         dfifo_empty_counter  <= '0;
         dfifo_active         <= '0;
         dpipe_active         <= '0;
      
      end else begin
      
         // implement a counter that compensates for the latency between writing to the FIFO and the valid output (~empty) being asserted
         if( ~sclrn[0] ) begin
            dfifo_empty_counter <= {{FIFO_EMPTY_CNT_WIDTH}{1'b1}};      // initialize the counter to -1, indicating no pending memory transactions in the FIFO
         end else begin
            if( valid_dpipe[DATA_PIPE_DEPTH] ) begin   // writing a new word into the FIFO
               dfifo_empty_counter <= FIFO_WRITE_TO_EMPTY_LATENCY - 1;      // load the counter to begin a countdown
            end else begin
               if( ~dfifo_empty_counter[FIFO_EMPTY_CNT_WIDTH-1] ) begin     // only count down until counter rolls over to -1
                  dfifo_empty_counter <= dfifo_empty_counter - 1;
               end
            end
         end
         
         if( o_valid | valid_dpipe[DATA_PIPE_DEPTH] | ~dfifo_empty_counter[FIFO_EMPTY_CNT_WIDTH-1] ) begin
            dfifo_active <= 1'b1;
         end else begin
            dfifo_active <= 1'b0;
         end
         
         dpipe_active <= dpipe_active_comb;
        
      end
      
   end
   
   always_comb begin
      dpipe_active_comb = dfifo_active;
      for (int i=1; i<=DATA_PIPE_DEPTH; i++) begin
         dpipe_active_comb = dpipe_active_comb | valid_dpipe[i];
      end
   end

   
   ///////////////////////////////////////
   // output active signal, combine active signals from other blocks
   // no dedicated active signal needed for valid generator, o_active is only relevant after all threads have already passed through the valid generator
   ///////////////////////////////////////
   always_ff @(posedge clock or negedge aclrn) begin
      if (~aclrn) begin
         o_active <= '0;
      end else begin
         o_active <= input_active | coalescer_active | fifo_active | avalon_active | dpipe_active;      
      end
   end

   // Temporary code to generate o_empty and o_almost_empty, NON-FUNCTIONAL
   assign o_empty = ~o_valid;
   assign o_almost_empty = ~o_valid;   
   
endmodule

  
`default_nettype wire
