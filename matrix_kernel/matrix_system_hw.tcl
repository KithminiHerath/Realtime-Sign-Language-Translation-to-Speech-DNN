package require -exact qsys 14.0
set_module_property NAME matrix_system
set_module_property VERSION 14.0
set_module_property INTERNAL false
set_module_property GROUP Accelerators
set_module_property DISPLAY_NAME matrix_system
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true

add_interface clock_reset clock end
set_interface_property clock_reset ENABLED true
add_interface_port clock_reset clock clk Input 1
add_interface_port clock_reset resetn reset_n Input 1
add_interface clock_reset2x clock end
set_interface_property clock_reset2x ENABLED true
add_interface_port clock_reset2x clock2x clk Input 1

#### Slave interface avs_matrix_multiply_cra
add_interface avs_matrix_multiply_cra avalon end
set_interface_property avs_matrix_multiply_cra ENABLED true
set_interface_property avs_matrix_multiply_cra associatedClock clock_reset
set_interface_property avs_matrix_multiply_cra addressAlignment DYNAMIC
set_interface_property avs_matrix_multiply_cra burstOnBurstBoundariesOnly false
set_interface_property avs_matrix_multiply_cra explicitAddressSpan 0
set_interface_property avs_matrix_multiply_cra holdTime 0
set_interface_property avs_matrix_multiply_cra isMemoryDevice false
set_interface_property avs_matrix_multiply_cra isNonVolatileStorage false
set_interface_property avs_matrix_multiply_cra linewrapBursts false
set_interface_property avs_matrix_multiply_cra maximumPendingReadTransactions 1
set_interface_property avs_matrix_multiply_cra printableDevice false
set_interface_property avs_matrix_multiply_cra readLatency 0
set_interface_property avs_matrix_multiply_cra readWaitTime 0
set_interface_property avs_matrix_multiply_cra setupTime 0
set_interface_property avs_matrix_multiply_cra timingUnits Cycles
set_interface_property avs_matrix_multiply_cra writeWaitTime 0
set_interface_assignment avs_matrix_multiply_cra hls.cosim.name {}
add_interface_port avs_matrix_multiply_cra avs_matrix_multiply_cra_read read input 1
add_interface_port avs_matrix_multiply_cra avs_matrix_multiply_cra_write write input 1
add_interface_port avs_matrix_multiply_cra avs_matrix_multiply_cra_address address input 5
add_interface_port avs_matrix_multiply_cra avs_matrix_multiply_cra_writedata writedata input 64
add_interface_port avs_matrix_multiply_cra avs_matrix_multiply_cra_byteenable byteenable input 8
add_interface_port avs_matrix_multiply_cra avs_matrix_multiply_cra_readdata readdata output 64
add_interface_port avs_matrix_multiply_cra avs_matrix_multiply_cra_readdatavalid readdatavalid output 1

#### IRQ interfaces kernel_irq
add_interface kernel_irq interrupt end
set_interface_property kernel_irq ENABLED true
set_interface_property kernel_irq associatedClock clock_reset
add_interface_port kernel_irq kernel_irq irq output 1

#### Master interface avm_mem_gmem0_port_0_0_rw with base address 0
add_interface avm_mem_gmem0_port_0_0_rw avalon start
set_interface_property avm_mem_gmem0_port_0_0_rw ENABLED true
set_interface_property avm_mem_gmem0_port_0_0_rw associatedClock clock_reset
set_interface_property avm_mem_gmem0_port_0_0_rw burstOnBurstBoundariesOnly false
set_interface_property avm_mem_gmem0_port_0_0_rw doStreamReads false
set_interface_property avm_mem_gmem0_port_0_0_rw doStreamWrites false
set_interface_property avm_mem_gmem0_port_0_0_rw linewrapBursts false
set_interface_property avm_mem_gmem0_port_0_0_rw readWaitTime 0
add_interface_port avm_mem_gmem0_port_0_0_rw avm_mem_gmem0_port_0_0_rw_address address output 30
add_interface_port avm_mem_gmem0_port_0_0_rw avm_mem_gmem0_port_0_0_rw_byteenable byteenable output 32
add_interface_port avm_mem_gmem0_port_0_0_rw avm_mem_gmem0_port_0_0_rw_readdatavalid readdatavalid input 1
add_interface_port avm_mem_gmem0_port_0_0_rw avm_mem_gmem0_port_0_0_rw_read read output 1
add_interface_port avm_mem_gmem0_port_0_0_rw avm_mem_gmem0_port_0_0_rw_readdata readdata input 256
add_interface_port avm_mem_gmem0_port_0_0_rw avm_mem_gmem0_port_0_0_rw_write write output 1
add_interface_port avm_mem_gmem0_port_0_0_rw avm_mem_gmem0_port_0_0_rw_writedata writedata output 256
add_interface_port avm_mem_gmem0_port_0_0_rw avm_mem_gmem0_port_0_0_rw_waitrequest waitrequest input 1
add_interface_port avm_mem_gmem0_port_0_0_rw avm_mem_gmem0_port_0_0_rw_burstcount burstcount output 5

add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL matrix_system
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
add_fileset_file acl_shift_register.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_shift_register.v TOP_LEVEL_FILE
add_fileset_file acl_work_group_dispatcher.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_work_group_dispatcher.v TOP_LEVEL_FILE
add_fileset_file acl_kernel_finish_detector.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_kernel_finish_detector.v TOP_LEVEL_FILE
add_fileset_file acl_multistage_accumulator.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_multistage_accumulator.v TOP_LEVEL_FILE
add_fileset_file acl_reset_handler.sv SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_reset_handler.sv TOP_LEVEL_FILE
add_fileset_file acl_std_synchronizer_nocut.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_std_synchronizer_nocut.v TOP_LEVEL_FILE
add_fileset_file acl_fanout_pipeline.sv SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_fanout_pipeline.sv TOP_LEVEL_FILE
add_fileset_file acl_id_iterator.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_id_iterator.v TOP_LEVEL_FILE
add_fileset_file acl_work_item_iterator.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_work_item_iterator.v TOP_LEVEL_FILE
add_fileset_file acl_multistage_adder.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_multistage_adder.v TOP_LEVEL_FILE
add_fileset_file acl_fifo.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_fifo.v TOP_LEVEL_FILE
add_fileset_file acl_fifo_stall_valid_lookahead.sv SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_fifo_stall_valid_lookahead.sv TOP_LEVEL_FILE
add_fileset_file matrix_system.v SYSTEM_VERILOG PATH matrix_system.v TOP_LEVEL_FILE
add_fileset_file dspba_library_package.vhd VHDL PATH $::env(INTELFPGAOCLSDKROOT)/windows64/lib/dspba/Libraries/vhdl/base/dspba_library_package.vhd TOP_LEVEL_FILE
add_fileset_file dspba_library.vhd VHDL PATH $::env(INTELFPGAOCLSDKROOT)/windows64/lib/dspba/Libraries/vhdl/base/dspba_library.vhd TOP_LEVEL_FILE
add_fileset_file acl_data_fifo.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_data_fifo.v TOP_LEVEL_FILE
add_fileset_file acl_ll_fifo.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_ll_fifo.v TOP_LEVEL_FILE
add_fileset_file acl_ll_ram_fifo.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_ll_ram_fifo.v TOP_LEVEL_FILE
add_fileset_file acl_valid_fifo_counter.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_valid_fifo_counter.v TOP_LEVEL_FILE
add_fileset_file acl_dspba_valid_fifo_counter.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_dspba_valid_fifo_counter.v TOP_LEVEL_FILE
add_fileset_file acl_staging_reg.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_staging_reg.v TOP_LEVEL_FILE
add_fileset_file hld_fifo.sv SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/hld_fifo.sv TOP_LEVEL_FILE
add_fileset_file hld_fifo_zero_width.sv SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/hld_fifo_zero_width.sv TOP_LEVEL_FILE
add_fileset_file acl_high_speed_fifo.sv SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_high_speed_fifo.sv TOP_LEVEL_FILE
add_fileset_file acl_low_latency_fifo.sv SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_low_latency_fifo.sv TOP_LEVEL_FILE
add_fileset_file acl_zero_latency_fifo.sv SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_zero_latency_fifo.sv TOP_LEVEL_FILE
add_fileset_file acl_tessellated_incr_decr_threshold.sv SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_tessellated_incr_decr_threshold.sv TOP_LEVEL_FILE
add_fileset_file acl_tessellated_incr_lookahead.sv SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_tessellated_incr_lookahead.sv TOP_LEVEL_FILE
add_fileset_file acl_lfsr.sv SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_lfsr.sv TOP_LEVEL_FILE
add_fileset_file acl_dspba_buffer.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_dspba_buffer.v TOP_LEVEL_FILE
add_fileset_file acl_full_detector.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_full_detector.v TOP_LEVEL_FILE
add_fileset_file lsu_top.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/lsu_top.v TOP_LEVEL_FILE
add_fileset_file lsu_permute_address.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/lsu_permute_address.v TOP_LEVEL_FILE
add_fileset_file lsu_pipelined.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/lsu_pipelined.v TOP_LEVEL_FILE
add_fileset_file lsu_enabled.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/lsu_enabled.v TOP_LEVEL_FILE
add_fileset_file lsu_basic_coalescer.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/lsu_basic_coalescer.v TOP_LEVEL_FILE
add_fileset_file lsu_simple.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/lsu_simple.v TOP_LEVEL_FILE
add_fileset_file lsu_streaming.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/lsu_streaming.v TOP_LEVEL_FILE
add_fileset_file lsu_burst_master.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/lsu_burst_master.v TOP_LEVEL_FILE
add_fileset_file lsu_bursting_load_stores.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/lsu_bursting_load_stores.v TOP_LEVEL_FILE
add_fileset_file lsu_non_aligned_write.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/lsu_non_aligned_write.v TOP_LEVEL_FILE
add_fileset_file lsu_read_cache.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/lsu_read_cache.v TOP_LEVEL_FILE
add_fileset_file lsu_atomic.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/lsu_atomic.v TOP_LEVEL_FILE
add_fileset_file lsu_prefetch_block.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/lsu_prefetch_block.v TOP_LEVEL_FILE
add_fileset_file lsu_wide_wrapper.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/lsu_wide_wrapper.v TOP_LEVEL_FILE
add_fileset_file lsu_streaming_prefetch.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/lsu_streaming_prefetch.v TOP_LEVEL_FILE
add_fileset_file acl_aligned_burst_coalesced_lsu.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_aligned_burst_coalesced_lsu.v TOP_LEVEL_FILE
add_fileset_file acl_toggle_detect.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_toggle_detect.v TOP_LEVEL_FILE
add_fileset_file acl_debug_mem.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_debug_mem.v TOP_LEVEL_FILE
add_fileset_file lsu_burst_coalesced_pipelined_write.sv SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/lsu_burst_coalesced_pipelined_write.sv TOP_LEVEL_FILE
add_fileset_file lsu_burst_coalesced_pipelined_read.sv SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/lsu_burst_coalesced_pipelined_read.sv TOP_LEVEL_FILE
add_fileset_file acl_loop_limiter.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_loop_limiter.v TOP_LEVEL_FILE
add_fileset_file acl_clock2x_holder.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_clock2x_holder.v TOP_LEVEL_FILE
add_fileset_file matrix_multiply_function_wrapper.vhd VHDL PATH kernel_hdl/matrix_multiply/matrix_multiply_function_wrapper.vhd TOP_LEVEL_FILE
add_fileset_file matrix_multiply_function.vhd VHDL PATH kernel_hdl/matrix_multiply/matrix_multiply_function.vhd TOP_LEVEL_FILE
add_fileset_file bb_matrix_multiply_B1_sr_0.vhd VHDL PATH kernel_hdl/matrix_multiply/bb_matrix_multiply_B1_sr_0.vhd TOP_LEVEL_FILE
add_fileset_file bb_matrix_multiply_B1_sr_1.vhd VHDL PATH kernel_hdl/matrix_multiply/bb_matrix_multiply_B1_sr_1.vhd TOP_LEVEL_FILE
add_fileset_file bb_matrix_multiply_B2_sr_0.vhd VHDL PATH kernel_hdl/matrix_multiply/bb_matrix_multiply_B2_sr_0.vhd TOP_LEVEL_FILE
add_fileset_file bb_matrix_multiply_B0.vhd VHDL PATH kernel_hdl/matrix_multiply/bb_matrix_multiply_B0.vhd TOP_LEVEL_FILE
add_fileset_file bb_matrix_multiply_B0_stall_region.vhd VHDL PATH kernel_hdl/matrix_multiply/bb_matrix_multiply_B0_stall_region.vhd TOP_LEVEL_FILE
add_fileset_file i_sfc_c0_entry_matrix_multiply_c0_enter_matrix_multiply.vhd VHDL PATH kernel_hdl/matrix_multiply/i_sfc_c0_entry_matrix_multiply_c0_enter_matrix_multiply.vhd TOP_LEVEL_FILE
add_fileset_file i_acl_sfc_exit_c0_entry_matrix_multiply_A0Zmatrix_multiply4.vhd VHDL PATH kernel_hdl/matrix_multiply/i_acl_sfc_exit_c0_entry_matrix_multiply_A0Zmatrix_multiply4.vhd TOP_LEVEL_FILE
add_fileset_file i_acl_sfc_exit_c0_entry_matrix_multiply_A0Ziply46_data_fifo.vhd VHDL PATH kernel_hdl/matrix_multiply/i_acl_sfc_exit_c0_entry_matrix_multiply_A0Ziply46_data_fifo.vhd TOP_LEVEL_FILE
add_fileset_file i_acl_sfc_exit_c0_entry_matrix_multiply_A0Zly_full_detector.vhd VHDL PATH kernel_hdl/matrix_multiply/i_acl_sfc_exit_c0_entry_matrix_multiply_A0Zly_full_detector.vhd TOP_LEVEL_FILE
add_fileset_file i_sfc_logic_c0_entry_matrix_multiply_c0_A0Zmatrix_multiply0.vhd VHDL PATH kernel_hdl/matrix_multiply/i_sfc_logic_c0_entry_matrix_multiply_c0_A0Zmatrix_multiply0.vhd TOP_LEVEL_FILE
add_fileset_file i_syncbuf_p_sync_buffer4_matrix_multiply2.vhd VHDL PATH kernel_hdl/matrix_multiply/i_syncbuf_p_sync_buffer4_matrix_multiply2.vhd TOP_LEVEL_FILE
add_fileset_file matrix_multiply_B0_merge_reg.vhd VHDL PATH kernel_hdl/matrix_multiply/matrix_multiply_B0_merge_reg.vhd TOP_LEVEL_FILE
add_fileset_file matrix_multiply_B0_branch.vhd VHDL PATH kernel_hdl/matrix_multiply/matrix_multiply_B0_branch.vhd TOP_LEVEL_FILE
add_fileset_file matrix_multiply_B0_merge.vhd VHDL PATH kernel_hdl/matrix_multiply/matrix_multiply_B0_merge.vhd TOP_LEVEL_FILE
add_fileset_file bb_matrix_multiply_B1.vhd VHDL PATH kernel_hdl/matrix_multiply/bb_matrix_multiply_B1.vhd TOP_LEVEL_FILE
add_fileset_file bb_matrix_multiply_B1_stall_region.vhd VHDL PATH kernel_hdl/matrix_multiply/bb_matrix_multiply_B1_stall_region.vhd TOP_LEVEL_FILE
add_fileset_file i_sfc_c0_for_body_matrix_multiply_c0_entA0Z_matrix_multiply.vhd VHDL PATH kernel_hdl/matrix_multiply/i_sfc_c0_for_body_matrix_multiply_c0_entA0Z_matrix_multiply.vhd TOP_LEVEL_FILE
add_fileset_file i_acl_sfc_exit_c0_for_body_matrix_multipA0Zatrix_multiply26.vhd VHDL PATH kernel_hdl/matrix_multiply/i_acl_sfc_exit_c0_for_body_matrix_multipA0Zatrix_multiply26.vhd TOP_LEVEL_FILE
add_fileset_file i_acl_sfc_exit_c0_for_body_matrix_multipA0Ziply48_data_fifo.vhd VHDL PATH kernel_hdl/matrix_multiply/i_acl_sfc_exit_c0_for_body_matrix_multipA0Ziply48_data_fifo.vhd TOP_LEVEL_FILE
add_fileset_file i_acl_sfc_exit_c0_for_body_matrix_multipA0Zly_full_detector.vhd VHDL PATH kernel_hdl/matrix_multiply/i_acl_sfc_exit_c0_for_body_matrix_multipA0Zly_full_detector.vhd TOP_LEVEL_FILE
add_fileset_file i_sfc_logic_c0_for_body_matrix_multiply_A0Zatrix_multiply24.vhd VHDL PATH kernel_hdl/matrix_multiply/i_sfc_logic_c0_for_body_matrix_multiply_A0Zatrix_multiply24.vhd TOP_LEVEL_FILE
add_fileset_file floatComponent_i_sfc_logic_c0_for_body_mA0Zcqp00j0ocqd0j60z.vhd VHDL PATH kernel_hdl/matrix_multiply/floatComponent_i_sfc_logic_c0_for_body_mA0Zcqp00j0ocqd0j60z.vhd TOP_LEVEL_FILE
add_fileset_file floatComponent_i_sfc_logic_c0_for_body_mA0Za0054c2a6342iyc5.vhd VHDL PATH kernel_hdl/matrix_multiply/floatComponent_i_sfc_logic_c0_for_body_mA0Za0054c2a6342iyc5.vhd TOP_LEVEL_FILE
add_fileset_file matrix_multiply_B1_merge_reg.vhd VHDL PATH kernel_hdl/matrix_multiply/matrix_multiply_B1_merge_reg.vhd TOP_LEVEL_FILE
add_fileset_file i_load_unnamed_matrix_multiply0_matrix_multiply20.vhd VHDL PATH kernel_hdl/matrix_multiply/i_load_unnamed_matrix_multiply0_matrix_multiply20.vhd TOP_LEVEL_FILE
add_fileset_file readdata_reg_unnamed_matrix_multiply0_matrix_multiply0.vhd VHDL PATH kernel_hdl/matrix_multiply/readdata_reg_unnamed_matrix_multiply0_matrix_multiply0.vhd TOP_LEVEL_FILE
add_fileset_file i_load_unnamed_matrix_multiply1_matrix_multiply22.vhd VHDL PATH kernel_hdl/matrix_multiply/i_load_unnamed_matrix_multiply1_matrix_multiply22.vhd TOP_LEVEL_FILE
add_fileset_file readdata_reg_unnamed_matrix_multiply1_matrix_multiply1.vhd VHDL PATH kernel_hdl/matrix_multiply/readdata_reg_unnamed_matrix_multiply1_matrix_multiply1.vhd TOP_LEVEL_FILE
add_fileset_file i_syncbuf_a_sync_buffer_matrix_multiply5.vhd VHDL PATH kernel_hdl/matrix_multiply/i_syncbuf_a_sync_buffer_matrix_multiply5.vhd TOP_LEVEL_FILE
add_fileset_file i_syncbuf_b_sync_buffer_matrix_multiply11.vhd VHDL PATH kernel_hdl/matrix_multiply/i_syncbuf_b_sync_buffer_matrix_multiply11.vhd TOP_LEVEL_FILE
add_fileset_file i_syncbuf_n_sync_buffer_matrix_multiply9.vhd VHDL PATH kernel_hdl/matrix_multiply/i_syncbuf_n_sync_buffer_matrix_multiply9.vhd TOP_LEVEL_FILE
add_fileset_file i_syncbuf_p_sync_buffer3_matrix_multiply13.vhd VHDL PATH kernel_hdl/matrix_multiply/i_syncbuf_p_sync_buffer3_matrix_multiply13.vhd TOP_LEVEL_FILE
add_fileset_file i_syncbuf_p_sync_buffer_matrix_multiply7.vhd VHDL PATH kernel_hdl/matrix_multiply/i_syncbuf_p_sync_buffer_matrix_multiply7.vhd TOP_LEVEL_FILE
add_fileset_file matrix_multiply_B1_branch.vhd VHDL PATH kernel_hdl/matrix_multiply/matrix_multiply_B1_branch.vhd TOP_LEVEL_FILE
add_fileset_file matrix_multiply_B1_merge.vhd VHDL PATH kernel_hdl/matrix_multiply/matrix_multiply_B1_merge.vhd TOP_LEVEL_FILE
add_fileset_file bb_matrix_multiply_B2.vhd VHDL PATH kernel_hdl/matrix_multiply/bb_matrix_multiply_B2.vhd TOP_LEVEL_FILE
add_fileset_file bb_matrix_multiply_B2_stall_region.vhd VHDL PATH kernel_hdl/matrix_multiply/bb_matrix_multiply_B2_stall_region.vhd TOP_LEVEL_FILE
add_fileset_file i_sfc_c0_for_end_loopexit_matrix_multiplA0Z_matrix_multiply.vhd VHDL PATH kernel_hdl/matrix_multiply/i_sfc_c0_for_end_loopexit_matrix_multiplA0Z_matrix_multiply.vhd TOP_LEVEL_FILE
add_fileset_file i_acl_sfc_exit_c0_for_end_loopexit_matriA0Zatrix_multiply43.vhd VHDL PATH kernel_hdl/matrix_multiply/i_acl_sfc_exit_c0_for_end_loopexit_matriA0Zatrix_multiply43.vhd TOP_LEVEL_FILE
add_fileset_file i_acl_sfc_exit_c0_for_end_loopexit_matriA0Ziply50_data_fifo.vhd VHDL PATH kernel_hdl/matrix_multiply/i_acl_sfc_exit_c0_for_end_loopexit_matriA0Ziply50_data_fifo.vhd TOP_LEVEL_FILE
add_fileset_file i_acl_sfc_exit_c0_for_end_loopexit_matriA0Zly_full_detector.vhd VHDL PATH kernel_hdl/matrix_multiply/i_acl_sfc_exit_c0_for_end_loopexit_matriA0Zly_full_detector.vhd TOP_LEVEL_FILE
add_fileset_file i_sfc_logic_c0_for_end_loopexit_matrix_mA0Zatrix_multiply38.vhd VHDL PATH kernel_hdl/matrix_multiply/i_sfc_logic_c0_for_end_loopexit_matrix_mA0Zatrix_multiply38.vhd TOP_LEVEL_FILE
add_fileset_file floatComponent_i_sfc_logic_c0_for_end_loA0Zd0j60ocqd006ou0z.vhd VHDL PATH kernel_hdl/matrix_multiply/floatComponent_i_sfc_logic_c0_for_end_loA0Zd0j60ocqd006ou0z.vhd TOP_LEVEL_FILE
add_fileset_file i_syncbuf_p_sync_buffer2_matrix_multiply40.vhd VHDL PATH kernel_hdl/matrix_multiply/i_syncbuf_p_sync_buffer2_matrix_multiply40.vhd TOP_LEVEL_FILE
add_fileset_file i_load_unnamed_matrix_multiply2_matrix_multiply36.vhd VHDL PATH kernel_hdl/matrix_multiply/i_load_unnamed_matrix_multiply2_matrix_multiply36.vhd TOP_LEVEL_FILE
add_fileset_file readdata_reg_unnamed_matrix_multiply2_matrix_multiply2.vhd VHDL PATH kernel_hdl/matrix_multiply/readdata_reg_unnamed_matrix_multiply2_matrix_multiply2.vhd TOP_LEVEL_FILE
add_fileset_file i_store_unnamed_matrix_multiply3_matrix_multiply44.vhd VHDL PATH kernel_hdl/matrix_multiply/i_store_unnamed_matrix_multiply3_matrix_multiply44.vhd TOP_LEVEL_FILE
add_fileset_file i_syncbuf_c_sync_buffer_matrix_multiply31.vhd VHDL PATH kernel_hdl/matrix_multiply/i_syncbuf_c_sync_buffer_matrix_multiply31.vhd TOP_LEVEL_FILE
add_fileset_file i_syncbuf_d_sync_buffer_matrix_multiply29.vhd VHDL PATH kernel_hdl/matrix_multiply/i_syncbuf_d_sync_buffer_matrix_multiply29.vhd TOP_LEVEL_FILE
add_fileset_file i_syncbuf_n_sync_buffer1_matrix_multiply27.vhd VHDL PATH kernel_hdl/matrix_multiply/i_syncbuf_n_sync_buffer1_matrix_multiply27.vhd TOP_LEVEL_FILE
add_fileset_file matrix_multiply_B2_branch.vhd VHDL PATH kernel_hdl/matrix_multiply/matrix_multiply_B2_branch.vhd TOP_LEVEL_FILE
add_fileset_file matrix_multiply_B2_merge.vhd VHDL PATH kernel_hdl/matrix_multiply/matrix_multiply_B2_merge.vhd TOP_LEVEL_FILE
add_fileset_file loop_limiter_matrix_multiply0.vhd VHDL PATH kernel_hdl/matrix_multiply/loop_limiter_matrix_multiply0.vhd TOP_LEVEL_FILE
add_fileset_file matrix_multiply_function_cra_slave.vhd VHDL PATH kernel_hdl/matrix_multiply/matrix_multiply_function_cra_slave.vhd TOP_LEVEL_FILE
add_fileset_file acl_start_signal_chain_element.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_start_signal_chain_element.v TOP_LEVEL_FILE
add_fileset_file acl_avm_to_ic.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_avm_to_ic.v TOP_LEVEL_FILE
add_fileset_file acl_ic_master_endpoint.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_ic_master_endpoint.v TOP_LEVEL_FILE
add_fileset_file acl_arb_intf.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_arb_intf.v TOP_LEVEL_FILE
add_fileset_file acl_ic_intf.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_ic_intf.v TOP_LEVEL_FILE
add_fileset_file acl_ic_slave_endpoint.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_ic_slave_endpoint.v TOP_LEVEL_FILE
add_fileset_file acl_ic_slave_rrp.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_ic_slave_rrp.v TOP_LEVEL_FILE
add_fileset_file acl_ic_slave_wrp.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_ic_slave_wrp.v TOP_LEVEL_FILE
add_fileset_file acl_ic_mem_router.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_ic_mem_router.v TOP_LEVEL_FILE
add_fileset_file acl_arb2.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_arb2.v TOP_LEVEL_FILE
add_fileset_file acl_ic_to_avm.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_ic_to_avm.v TOP_LEVEL_FILE


add_fileset SIM_VERILOG SIM_VERILOG "" ""
set_fileset_property SIM_VERILOG TOP_LEVEL matrix_system
add_fileset_file acl_shift_register.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_shift_register.v TOP_LEVEL_FILE
add_fileset_file acl_work_group_dispatcher.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_work_group_dispatcher.v TOP_LEVEL_FILE
add_fileset_file acl_kernel_finish_detector.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_kernel_finish_detector.v TOP_LEVEL_FILE
add_fileset_file acl_multistage_accumulator.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_multistage_accumulator.v TOP_LEVEL_FILE
add_fileset_file acl_reset_handler.sv SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_reset_handler.sv TOP_LEVEL_FILE
add_fileset_file acl_std_synchronizer_nocut.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_std_synchronizer_nocut.v TOP_LEVEL_FILE
add_fileset_file acl_fanout_pipeline.sv SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_fanout_pipeline.sv TOP_LEVEL_FILE
add_fileset_file acl_id_iterator.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_id_iterator.v TOP_LEVEL_FILE
add_fileset_file acl_work_item_iterator.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_work_item_iterator.v TOP_LEVEL_FILE
add_fileset_file acl_multistage_adder.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_multistage_adder.v TOP_LEVEL_FILE
add_fileset_file acl_fifo.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_fifo.v TOP_LEVEL_FILE
add_fileset_file acl_fifo_stall_valid_lookahead.sv SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_fifo_stall_valid_lookahead.sv TOP_LEVEL_FILE
add_fileset_file matrix_system.v SYSTEM_VERILOG PATH matrix_system.v TOP_LEVEL_FILE
add_fileset_file dspba_library_package.vhd VHDL PATH $::env(INTELFPGAOCLSDKROOT)/windows64/lib/dspba/Libraries/vhdl/base/dspba_library_package.vhd TOP_LEVEL_FILE
add_fileset_file dspba_library.vhd VHDL PATH $::env(INTELFPGAOCLSDKROOT)/windows64/lib/dspba/Libraries/vhdl/base/dspba_library.vhd TOP_LEVEL_FILE
add_fileset_file acl_data_fifo.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_data_fifo.v TOP_LEVEL_FILE
add_fileset_file acl_ll_fifo.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_ll_fifo.v TOP_LEVEL_FILE
add_fileset_file acl_ll_ram_fifo.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_ll_ram_fifo.v TOP_LEVEL_FILE
add_fileset_file acl_valid_fifo_counter.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_valid_fifo_counter.v TOP_LEVEL_FILE
add_fileset_file acl_dspba_valid_fifo_counter.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_dspba_valid_fifo_counter.v TOP_LEVEL_FILE
add_fileset_file acl_staging_reg.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_staging_reg.v TOP_LEVEL_FILE
add_fileset_file hld_fifo.sv SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/hld_fifo.sv TOP_LEVEL_FILE
add_fileset_file hld_fifo_zero_width.sv SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/hld_fifo_zero_width.sv TOP_LEVEL_FILE
add_fileset_file acl_high_speed_fifo.sv SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_high_speed_fifo.sv TOP_LEVEL_FILE
add_fileset_file acl_low_latency_fifo.sv SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_low_latency_fifo.sv TOP_LEVEL_FILE
add_fileset_file acl_zero_latency_fifo.sv SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_zero_latency_fifo.sv TOP_LEVEL_FILE
add_fileset_file acl_tessellated_incr_decr_threshold.sv SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_tessellated_incr_decr_threshold.sv TOP_LEVEL_FILE
add_fileset_file acl_tessellated_incr_lookahead.sv SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_tessellated_incr_lookahead.sv TOP_LEVEL_FILE
add_fileset_file acl_lfsr.sv SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_lfsr.sv TOP_LEVEL_FILE
add_fileset_file acl_dspba_buffer.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_dspba_buffer.v TOP_LEVEL_FILE
add_fileset_file acl_full_detector.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_full_detector.v TOP_LEVEL_FILE
add_fileset_file lsu_top.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/lsu_top.v TOP_LEVEL_FILE
add_fileset_file lsu_permute_address.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/lsu_permute_address.v TOP_LEVEL_FILE
add_fileset_file lsu_pipelined.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/lsu_pipelined.v TOP_LEVEL_FILE
add_fileset_file lsu_enabled.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/lsu_enabled.v TOP_LEVEL_FILE
add_fileset_file lsu_basic_coalescer.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/lsu_basic_coalescer.v TOP_LEVEL_FILE
add_fileset_file lsu_simple.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/lsu_simple.v TOP_LEVEL_FILE
add_fileset_file lsu_streaming.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/lsu_streaming.v TOP_LEVEL_FILE
add_fileset_file lsu_burst_master.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/lsu_burst_master.v TOP_LEVEL_FILE
add_fileset_file lsu_bursting_load_stores.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/lsu_bursting_load_stores.v TOP_LEVEL_FILE
add_fileset_file lsu_non_aligned_write.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/lsu_non_aligned_write.v TOP_LEVEL_FILE
add_fileset_file lsu_read_cache.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/lsu_read_cache.v TOP_LEVEL_FILE
add_fileset_file lsu_atomic.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/lsu_atomic.v TOP_LEVEL_FILE
add_fileset_file lsu_prefetch_block.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/lsu_prefetch_block.v TOP_LEVEL_FILE
add_fileset_file lsu_wide_wrapper.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/lsu_wide_wrapper.v TOP_LEVEL_FILE
add_fileset_file lsu_streaming_prefetch.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/lsu_streaming_prefetch.v TOP_LEVEL_FILE
add_fileset_file acl_aligned_burst_coalesced_lsu.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_aligned_burst_coalesced_lsu.v TOP_LEVEL_FILE
add_fileset_file acl_toggle_detect.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_toggle_detect.v TOP_LEVEL_FILE
add_fileset_file acl_debug_mem.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_debug_mem.v TOP_LEVEL_FILE
add_fileset_file lsu_burst_coalesced_pipelined_write.sv SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/lsu_burst_coalesced_pipelined_write.sv TOP_LEVEL_FILE
add_fileset_file lsu_burst_coalesced_pipelined_read.sv SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/lsu_burst_coalesced_pipelined_read.sv TOP_LEVEL_FILE
add_fileset_file acl_loop_limiter.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_loop_limiter.v TOP_LEVEL_FILE
add_fileset_file acl_clock2x_holder.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_clock2x_holder.v TOP_LEVEL_FILE
add_fileset_file matrix_multiply_function_wrapper.vhd VHDL PATH kernel_hdl/matrix_multiply/matrix_multiply_function_wrapper.vhd TOP_LEVEL_FILE
add_fileset_file matrix_multiply_function.vhd VHDL PATH kernel_hdl/matrix_multiply/matrix_multiply_function.vhd TOP_LEVEL_FILE
add_fileset_file bb_matrix_multiply_B1_sr_0.vhd VHDL PATH kernel_hdl/matrix_multiply/bb_matrix_multiply_B1_sr_0.vhd TOP_LEVEL_FILE
add_fileset_file bb_matrix_multiply_B1_sr_1.vhd VHDL PATH kernel_hdl/matrix_multiply/bb_matrix_multiply_B1_sr_1.vhd TOP_LEVEL_FILE
add_fileset_file bb_matrix_multiply_B2_sr_0.vhd VHDL PATH kernel_hdl/matrix_multiply/bb_matrix_multiply_B2_sr_0.vhd TOP_LEVEL_FILE
add_fileset_file bb_matrix_multiply_B0.vhd VHDL PATH kernel_hdl/matrix_multiply/bb_matrix_multiply_B0.vhd TOP_LEVEL_FILE
add_fileset_file bb_matrix_multiply_B0_stall_region.vhd VHDL PATH kernel_hdl/matrix_multiply/bb_matrix_multiply_B0_stall_region.vhd TOP_LEVEL_FILE
add_fileset_file i_sfc_c0_entry_matrix_multiply_c0_enter_matrix_multiply.vhd VHDL PATH kernel_hdl/matrix_multiply/i_sfc_c0_entry_matrix_multiply_c0_enter_matrix_multiply.vhd TOP_LEVEL_FILE
add_fileset_file i_acl_sfc_exit_c0_entry_matrix_multiply_A0Zmatrix_multiply4.vhd VHDL PATH kernel_hdl/matrix_multiply/i_acl_sfc_exit_c0_entry_matrix_multiply_A0Zmatrix_multiply4.vhd TOP_LEVEL_FILE
add_fileset_file i_acl_sfc_exit_c0_entry_matrix_multiply_A0Ziply46_data_fifo.vhd VHDL PATH kernel_hdl/matrix_multiply/i_acl_sfc_exit_c0_entry_matrix_multiply_A0Ziply46_data_fifo.vhd TOP_LEVEL_FILE
add_fileset_file i_acl_sfc_exit_c0_entry_matrix_multiply_A0Zly_full_detector.vhd VHDL PATH kernel_hdl/matrix_multiply/i_acl_sfc_exit_c0_entry_matrix_multiply_A0Zly_full_detector.vhd TOP_LEVEL_FILE
add_fileset_file i_sfc_logic_c0_entry_matrix_multiply_c0_A0Zmatrix_multiply0.vhd VHDL PATH kernel_hdl/matrix_multiply/i_sfc_logic_c0_entry_matrix_multiply_c0_A0Zmatrix_multiply0.vhd TOP_LEVEL_FILE
add_fileset_file i_syncbuf_p_sync_buffer4_matrix_multiply2.vhd VHDL PATH kernel_hdl/matrix_multiply/i_syncbuf_p_sync_buffer4_matrix_multiply2.vhd TOP_LEVEL_FILE
add_fileset_file matrix_multiply_B0_merge_reg.vhd VHDL PATH kernel_hdl/matrix_multiply/matrix_multiply_B0_merge_reg.vhd TOP_LEVEL_FILE
add_fileset_file matrix_multiply_B0_branch.vhd VHDL PATH kernel_hdl/matrix_multiply/matrix_multiply_B0_branch.vhd TOP_LEVEL_FILE
add_fileset_file matrix_multiply_B0_merge.vhd VHDL PATH kernel_hdl/matrix_multiply/matrix_multiply_B0_merge.vhd TOP_LEVEL_FILE
add_fileset_file bb_matrix_multiply_B1.vhd VHDL PATH kernel_hdl/matrix_multiply/bb_matrix_multiply_B1.vhd TOP_LEVEL_FILE
add_fileset_file bb_matrix_multiply_B1_stall_region.vhd VHDL PATH kernel_hdl/matrix_multiply/bb_matrix_multiply_B1_stall_region.vhd TOP_LEVEL_FILE
add_fileset_file i_sfc_c0_for_body_matrix_multiply_c0_entA0Z_matrix_multiply.vhd VHDL PATH kernel_hdl/matrix_multiply/i_sfc_c0_for_body_matrix_multiply_c0_entA0Z_matrix_multiply.vhd TOP_LEVEL_FILE
add_fileset_file i_acl_sfc_exit_c0_for_body_matrix_multipA0Zatrix_multiply26.vhd VHDL PATH kernel_hdl/matrix_multiply/i_acl_sfc_exit_c0_for_body_matrix_multipA0Zatrix_multiply26.vhd TOP_LEVEL_FILE
add_fileset_file i_acl_sfc_exit_c0_for_body_matrix_multipA0Ziply48_data_fifo.vhd VHDL PATH kernel_hdl/matrix_multiply/i_acl_sfc_exit_c0_for_body_matrix_multipA0Ziply48_data_fifo.vhd TOP_LEVEL_FILE
add_fileset_file i_acl_sfc_exit_c0_for_body_matrix_multipA0Zly_full_detector.vhd VHDL PATH kernel_hdl/matrix_multiply/i_acl_sfc_exit_c0_for_body_matrix_multipA0Zly_full_detector.vhd TOP_LEVEL_FILE
add_fileset_file i_sfc_logic_c0_for_body_matrix_multiply_A0Zatrix_multiply24.vhd VHDL PATH kernel_hdl/matrix_multiply/i_sfc_logic_c0_for_body_matrix_multiply_A0Zatrix_multiply24.vhd TOP_LEVEL_FILE
add_fileset_file floatComponent_i_sfc_logic_c0_for_body_mA0Zcqp00j0ocqd0j60z.vhd VHDL PATH kernel_hdl/matrix_multiply/floatComponent_i_sfc_logic_c0_for_body_mA0Zcqp00j0ocqd0j60z.vhd TOP_LEVEL_FILE
add_fileset_file floatComponent_i_sfc_logic_c0_for_body_mA0Za0054c2a6342iyc5.vhd VHDL PATH kernel_hdl/matrix_multiply/floatComponent_i_sfc_logic_c0_for_body_mA0Za0054c2a6342iyc5.vhd TOP_LEVEL_FILE
add_fileset_file matrix_multiply_B1_merge_reg.vhd VHDL PATH kernel_hdl/matrix_multiply/matrix_multiply_B1_merge_reg.vhd TOP_LEVEL_FILE
add_fileset_file i_load_unnamed_matrix_multiply0_matrix_multiply20.vhd VHDL PATH kernel_hdl/matrix_multiply/i_load_unnamed_matrix_multiply0_matrix_multiply20.vhd TOP_LEVEL_FILE
add_fileset_file readdata_reg_unnamed_matrix_multiply0_matrix_multiply0.vhd VHDL PATH kernel_hdl/matrix_multiply/readdata_reg_unnamed_matrix_multiply0_matrix_multiply0.vhd TOP_LEVEL_FILE
add_fileset_file i_load_unnamed_matrix_multiply1_matrix_multiply22.vhd VHDL PATH kernel_hdl/matrix_multiply/i_load_unnamed_matrix_multiply1_matrix_multiply22.vhd TOP_LEVEL_FILE
add_fileset_file readdata_reg_unnamed_matrix_multiply1_matrix_multiply1.vhd VHDL PATH kernel_hdl/matrix_multiply/readdata_reg_unnamed_matrix_multiply1_matrix_multiply1.vhd TOP_LEVEL_FILE
add_fileset_file i_syncbuf_a_sync_buffer_matrix_multiply5.vhd VHDL PATH kernel_hdl/matrix_multiply/i_syncbuf_a_sync_buffer_matrix_multiply5.vhd TOP_LEVEL_FILE
add_fileset_file i_syncbuf_b_sync_buffer_matrix_multiply11.vhd VHDL PATH kernel_hdl/matrix_multiply/i_syncbuf_b_sync_buffer_matrix_multiply11.vhd TOP_LEVEL_FILE
add_fileset_file i_syncbuf_n_sync_buffer_matrix_multiply9.vhd VHDL PATH kernel_hdl/matrix_multiply/i_syncbuf_n_sync_buffer_matrix_multiply9.vhd TOP_LEVEL_FILE
add_fileset_file i_syncbuf_p_sync_buffer3_matrix_multiply13.vhd VHDL PATH kernel_hdl/matrix_multiply/i_syncbuf_p_sync_buffer3_matrix_multiply13.vhd TOP_LEVEL_FILE
add_fileset_file i_syncbuf_p_sync_buffer_matrix_multiply7.vhd VHDL PATH kernel_hdl/matrix_multiply/i_syncbuf_p_sync_buffer_matrix_multiply7.vhd TOP_LEVEL_FILE
add_fileset_file matrix_multiply_B1_branch.vhd VHDL PATH kernel_hdl/matrix_multiply/matrix_multiply_B1_branch.vhd TOP_LEVEL_FILE
add_fileset_file matrix_multiply_B1_merge.vhd VHDL PATH kernel_hdl/matrix_multiply/matrix_multiply_B1_merge.vhd TOP_LEVEL_FILE
add_fileset_file bb_matrix_multiply_B2.vhd VHDL PATH kernel_hdl/matrix_multiply/bb_matrix_multiply_B2.vhd TOP_LEVEL_FILE
add_fileset_file bb_matrix_multiply_B2_stall_region.vhd VHDL PATH kernel_hdl/matrix_multiply/bb_matrix_multiply_B2_stall_region.vhd TOP_LEVEL_FILE
add_fileset_file i_sfc_c0_for_end_loopexit_matrix_multiplA0Z_matrix_multiply.vhd VHDL PATH kernel_hdl/matrix_multiply/i_sfc_c0_for_end_loopexit_matrix_multiplA0Z_matrix_multiply.vhd TOP_LEVEL_FILE
add_fileset_file i_acl_sfc_exit_c0_for_end_loopexit_matriA0Zatrix_multiply43.vhd VHDL PATH kernel_hdl/matrix_multiply/i_acl_sfc_exit_c0_for_end_loopexit_matriA0Zatrix_multiply43.vhd TOP_LEVEL_FILE
add_fileset_file i_acl_sfc_exit_c0_for_end_loopexit_matriA0Ziply50_data_fifo.vhd VHDL PATH kernel_hdl/matrix_multiply/i_acl_sfc_exit_c0_for_end_loopexit_matriA0Ziply50_data_fifo.vhd TOP_LEVEL_FILE
add_fileset_file i_acl_sfc_exit_c0_for_end_loopexit_matriA0Zly_full_detector.vhd VHDL PATH kernel_hdl/matrix_multiply/i_acl_sfc_exit_c0_for_end_loopexit_matriA0Zly_full_detector.vhd TOP_LEVEL_FILE
add_fileset_file i_sfc_logic_c0_for_end_loopexit_matrix_mA0Zatrix_multiply38.vhd VHDL PATH kernel_hdl/matrix_multiply/i_sfc_logic_c0_for_end_loopexit_matrix_mA0Zatrix_multiply38.vhd TOP_LEVEL_FILE
add_fileset_file floatComponent_i_sfc_logic_c0_for_end_loA0Zd0j60ocqd006ou0z.vhd VHDL PATH kernel_hdl/matrix_multiply/floatComponent_i_sfc_logic_c0_for_end_loA0Zd0j60ocqd006ou0z.vhd TOP_LEVEL_FILE
add_fileset_file i_syncbuf_p_sync_buffer2_matrix_multiply40.vhd VHDL PATH kernel_hdl/matrix_multiply/i_syncbuf_p_sync_buffer2_matrix_multiply40.vhd TOP_LEVEL_FILE
add_fileset_file i_load_unnamed_matrix_multiply2_matrix_multiply36.vhd VHDL PATH kernel_hdl/matrix_multiply/i_load_unnamed_matrix_multiply2_matrix_multiply36.vhd TOP_LEVEL_FILE
add_fileset_file readdata_reg_unnamed_matrix_multiply2_matrix_multiply2.vhd VHDL PATH kernel_hdl/matrix_multiply/readdata_reg_unnamed_matrix_multiply2_matrix_multiply2.vhd TOP_LEVEL_FILE
add_fileset_file i_store_unnamed_matrix_multiply3_matrix_multiply44.vhd VHDL PATH kernel_hdl/matrix_multiply/i_store_unnamed_matrix_multiply3_matrix_multiply44.vhd TOP_LEVEL_FILE
add_fileset_file i_syncbuf_c_sync_buffer_matrix_multiply31.vhd VHDL PATH kernel_hdl/matrix_multiply/i_syncbuf_c_sync_buffer_matrix_multiply31.vhd TOP_LEVEL_FILE
add_fileset_file i_syncbuf_d_sync_buffer_matrix_multiply29.vhd VHDL PATH kernel_hdl/matrix_multiply/i_syncbuf_d_sync_buffer_matrix_multiply29.vhd TOP_LEVEL_FILE
add_fileset_file i_syncbuf_n_sync_buffer1_matrix_multiply27.vhd VHDL PATH kernel_hdl/matrix_multiply/i_syncbuf_n_sync_buffer1_matrix_multiply27.vhd TOP_LEVEL_FILE
add_fileset_file matrix_multiply_B2_branch.vhd VHDL PATH kernel_hdl/matrix_multiply/matrix_multiply_B2_branch.vhd TOP_LEVEL_FILE
add_fileset_file matrix_multiply_B2_merge.vhd VHDL PATH kernel_hdl/matrix_multiply/matrix_multiply_B2_merge.vhd TOP_LEVEL_FILE
add_fileset_file loop_limiter_matrix_multiply0.vhd VHDL PATH kernel_hdl/matrix_multiply/loop_limiter_matrix_multiply0.vhd TOP_LEVEL_FILE
add_fileset_file matrix_multiply_function_cra_slave.vhd VHDL PATH kernel_hdl/matrix_multiply/matrix_multiply_function_cra_slave.vhd TOP_LEVEL_FILE
add_fileset_file acl_start_signal_chain_element.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_start_signal_chain_element.v TOP_LEVEL_FILE
add_fileset_file acl_avm_to_ic.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_avm_to_ic.v TOP_LEVEL_FILE
add_fileset_file acl_ic_master_endpoint.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_ic_master_endpoint.v TOP_LEVEL_FILE
add_fileset_file acl_arb_intf.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_arb_intf.v TOP_LEVEL_FILE
add_fileset_file acl_ic_intf.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_ic_intf.v TOP_LEVEL_FILE
add_fileset_file acl_ic_slave_endpoint.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_ic_slave_endpoint.v TOP_LEVEL_FILE
add_fileset_file acl_ic_slave_rrp.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_ic_slave_rrp.v TOP_LEVEL_FILE
add_fileset_file acl_ic_slave_wrp.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_ic_slave_wrp.v TOP_LEVEL_FILE
add_fileset_file acl_ic_mem_router.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_ic_mem_router.v TOP_LEVEL_FILE
add_fileset_file acl_arb2.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_arb2.v TOP_LEVEL_FILE
add_fileset_file acl_ic_to_avm.v SYSTEM_VERILOG PATH $::env(INTELFPGAOCLSDKROOT)/ip/acl_ic_to_avm.v TOP_LEVEL_FILE