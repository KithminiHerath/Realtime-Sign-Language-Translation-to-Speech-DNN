-- ------------------------------------------------------------------------- 
-- High Level Design Compiler for Intel(R) FPGAs Version 18.1 (Release Build #625)
-- 
-- Legal Notice: Copyright 2018 Intel Corporation.  All rights reserved.
-- Your use of  Intel Corporation's design tools,  logic functions and other
-- software and  tools, and its AMPP partner logic functions, and any output
-- files any  of the foregoing (including  device programming  or simulation
-- files), and  any associated  documentation  or information  are expressly
-- subject  to the terms and  conditions of the  Intel FPGA Software License
-- Agreement, Intel MegaCore Function License Agreement, or other applicable
-- license agreement,  including,  without limitation,  that your use is for
-- the  sole  purpose of  programming  logic devices  manufactured by  Intel
-- and  sold by Intel  or its authorized  distributors. Please refer  to the
-- applicable agreement for further details.
-- ---------------------------------------------------------------------------

-- VHDL created from bb_matrix_multiply_B2_stall_region
-- VHDL created on Mon Oct 07 15:55:10 2019


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.MATH_REAL.all;
use std.TextIO.all;
use work.dspba_library_package.all;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;
LIBRARY altera_lnsim;
USE altera_lnsim.altera_lnsim_components.altera_syncram;
LIBRARY lpm;
USE lpm.lpm_components.all;

entity bb_matrix_multiply_B2_stall_region is
    port (
        in_unnamed_matrix_multiply3_avm_readdata : in std_logic_vector(255 downto 0);  -- ufix256
        in_unnamed_matrix_multiply3_avm_writeack : in std_logic_vector(0 downto 0);  -- ufix1
        in_unnamed_matrix_multiply3_avm_waitrequest : in std_logic_vector(0 downto 0);  -- ufix1
        in_unnamed_matrix_multiply3_avm_readdatavalid : in std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_matrix_multiply3_avm_address : out std_logic_vector(29 downto 0);  -- ufix30
        out_unnamed_matrix_multiply3_avm_enable : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_matrix_multiply3_avm_read : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_matrix_multiply3_avm_write : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_matrix_multiply3_avm_writedata : out std_logic_vector(255 downto 0);  -- ufix256
        out_unnamed_matrix_multiply3_avm_byteenable : out std_logic_vector(31 downto 0);  -- ufix32
        out_unnamed_matrix_multiply3_avm_burstcount : out std_logic_vector(4 downto 0);  -- ufix5
        in_D : in std_logic_vector(63 downto 0);  -- ufix64
        in_acl_hw_wg_id5 : in std_logic_vector(31 downto 0);  -- ufix32
        in_c0_exe1102 : in std_logic_vector(63 downto 0);  -- float64_m52
        in_global_id_03 : in std_logic_vector(31 downto 0);  -- ufix32
        in_valid_in : in std_logic_vector(0 downto 0);  -- ufix1
        out_acl_hw_wg_id5 : out std_logic_vector(31 downto 0);  -- ufix32
        out_valid_out : out std_logic_vector(0 downto 0);  -- ufix1
        out_lsu_unnamed_matrix_multiply3_o_active : out std_logic_vector(0 downto 0);  -- ufix1
        in_N : in std_logic_vector(31 downto 0);  -- ufix32
        in_P : in std_logic_vector(31 downto 0);  -- ufix32
        in_flush : in std_logic_vector(0 downto 0);  -- ufix1
        in_unnamed_matrix_multiply2_avm_readdata : in std_logic_vector(255 downto 0);  -- ufix256
        in_unnamed_matrix_multiply2_avm_writeack : in std_logic_vector(0 downto 0);  -- ufix1
        in_unnamed_matrix_multiply2_avm_waitrequest : in std_logic_vector(0 downto 0);  -- ufix1
        in_unnamed_matrix_multiply2_avm_readdatavalid : in std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_matrix_multiply2_avm_address : out std_logic_vector(29 downto 0);  -- ufix30
        out_unnamed_matrix_multiply2_avm_enable : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_matrix_multiply2_avm_read : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_matrix_multiply2_avm_write : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_matrix_multiply2_avm_writedata : out std_logic_vector(255 downto 0);  -- ufix256
        out_unnamed_matrix_multiply2_avm_byteenable : out std_logic_vector(31 downto 0);  -- ufix32
        out_unnamed_matrix_multiply2_avm_burstcount : out std_logic_vector(4 downto 0);  -- ufix5
        in_C : in std_logic_vector(63 downto 0);  -- ufix64
        in_stall_in : in std_logic_vector(0 downto 0);  -- ufix1
        out_stall_out : out std_logic_vector(0 downto 0);  -- ufix1
        clock : in std_logic;
        resetn : in std_logic
    );
end bb_matrix_multiply_B2_stall_region;

architecture normal of bb_matrix_multiply_B2_stall_region is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    component i_sfc_c0_for_end_loopexit_matrix_multiply_c0_enter14_matrix_multiply is
        port (
            in_c0_eni313_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_c0_eni313_1 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_c0_eni313_2 : in std_logic_vector(63 downto 0);  -- Floating Point
            in_c0_eni313_3 : in std_logic_vector(63 downto 0);  -- Floating Point
            in_P : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_i_stall : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_valid : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exit19_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exit19_1 : out std_logic_vector(63 downto 0);  -- Floating Point
            out_o_stall : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_valid : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_load_unnamed_matrix_multiply2_matrix_multiply36 is
        port (
            in_flush : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_address : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_i_predicate : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_stall : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_valid : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_matrix_multiply2_avm_readdata : in std_logic_vector(255 downto 0);  -- Fixed Point
            in_unnamed_matrix_multiply2_avm_readdatavalid : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_matrix_multiply2_avm_waitrequest : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_matrix_multiply2_avm_writeack : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_readdata : out std_logic_vector(63 downto 0);  -- Floating Point
            out_o_stall : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_valid : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply2_avm_address : out std_logic_vector(29 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply2_avm_burstcount : out std_logic_vector(4 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply2_avm_byteenable : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply2_avm_enable : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply2_avm_read : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply2_avm_write : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply2_avm_writedata : out std_logic_vector(255 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_store_unnamed_matrix_multiply3_matrix_multiply44 is
        port (
            in_flush : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_address : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_i_predicate : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_stall : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_valid : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_writedata : in std_logic_vector(63 downto 0);  -- Floating Point
            in_unnamed_matrix_multiply3_avm_readdata : in std_logic_vector(255 downto 0);  -- Fixed Point
            in_unnamed_matrix_multiply3_avm_readdatavalid : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_matrix_multiply3_avm_waitrequest : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_matrix_multiply3_avm_writeack : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_lsu_unnamed_matrix_multiply3_o_active : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_stall : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_valid : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply3_avm_address : out std_logic_vector(29 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply3_avm_burstcount : out std_logic_vector(4 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply3_avm_byteenable : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply3_avm_enable : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply3_avm_read : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply3_avm_write : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply3_avm_writedata : out std_logic_vector(255 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_syncbuf_c_sync_buffer_matrix_multiply31 is
        port (
            in_buffer_in : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_i_dependence : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_buffer_out : out std_logic_vector(63 downto 0);  -- Fixed Point
            out_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_syncbuf_d_sync_buffer_matrix_multiply29 is
        port (
            in_buffer_in : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_i_dependence : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_buffer_out : out std_logic_vector(63 downto 0);  -- Fixed Point
            out_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_syncbuf_n_sync_buffer1_matrix_multiply27 is
        port (
            in_buffer_in : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_i_dependence : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_buffer_out : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component acl_data_fifo is
        generic (
            DEPTH : INTEGER := 0;
            DATA_WIDTH : INTEGER := 32;
            STRICT_DEPTH : INTEGER := 0;
            ALLOW_FULL_WRITE : INTEGER := 0;
            IMPL : STRING := "ram"
        );
        port (
            clock : in std_logic;
            resetn : in std_logic;
            valid_in : in std_logic;
            stall_in : in std_logic;
            data_in : in std_logic_vector(DATA_WIDTH - 1 downto 0);
            valid_out : out std_logic;
            stall_out : out std_logic;
            data_out : out std_logic_vector(DATA_WIDTH - 1 downto 0);
            full : out std_logic;
            almost_full : out std_logic
        );
    end component;






    component acl_valid_fifo_counter is
        generic (
            DEPTH : INTEGER := 0;
            ASYNC_RESET : INTEGER := 1;
            STRICT_DEPTH : INTEGER := 0;
            ALLOW_FULL_WRITE : INTEGER := 0
        );
        port (
            clock : in std_logic;
            resetn : in std_logic;
            valid_in : in std_logic;
            stall_in : in std_logic;
            valid_out : out std_logic;
            stall_out : out std_logic;
            full : out std_logic
        );
    end component;



    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b : STD_LOGIC_VECTOR (63 downto 0);
    signal i_arrayidx12_matrix_multiply_matrix_multiply35_mult_extender_x_q : STD_LOGIC_VECTOR (127 downto 0);
    signal i_arrayidx12_matrix_multiply_matrix_multiply35_mult_multconst_x_q : STD_LOGIC_VECTOR (59 downto 0);
    signal i_arrayidx12_matrix_multiply_matrix_multiply35_trunc_sel_x_b : STD_LOGIC_VECTOR (63 downto 0);
    signal i_arrayidx12_matrix_multiply_matrix_multiply35_add_x_a : STD_LOGIC_VECTOR (64 downto 0);
    signal i_arrayidx12_matrix_multiply_matrix_multiply35_add_x_b : STD_LOGIC_VECTOR (64 downto 0);
    signal i_arrayidx12_matrix_multiply_matrix_multiply35_add_x_o : STD_LOGIC_VECTOR (64 downto 0);
    signal i_arrayidx12_matrix_multiply_matrix_multiply35_add_x_q : STD_LOGIC_VECTOR (64 downto 0);
    signal i_arrayidx9_matrix_multiply_matrix_multiply34_dupName_0_trunc_sel_x_b : STD_LOGIC_VECTOR (63 downto 0);
    signal i_arrayidx9_matrix_multiply_matrix_multiply34_mult_extender_x_q : STD_LOGIC_VECTOR (127 downto 0);
    signal i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b : STD_LOGIC_VECTOR (63 downto 0);
    signal i_arrayidx9_matrix_multiply_matrix_multiply34_add_x_a : STD_LOGIC_VECTOR (64 downto 0);
    signal i_arrayidx9_matrix_multiply_matrix_multiply34_add_x_b : STD_LOGIC_VECTOR (64 downto 0);
    signal i_arrayidx9_matrix_multiply_matrix_multiply34_add_x_o : STD_LOGIC_VECTOR (64 downto 0);
    signal i_arrayidx9_matrix_multiply_matrix_multiply34_add_x_q : STD_LOGIC_VECTOR (64 downto 0);
    signal i_idxprom8_matrix_multiply_sel_x_b : STD_LOGIC_VECTOR (63 downto 0);
    signal i_sfc_c0_for_end_loopexit_matrix_multiply_c0_enter14_matrix_multiply_aunroll_x_out_c0_exit19_1 : STD_LOGIC_VECTOR (63 downto 0);
    signal i_sfc_c0_for_end_loopexit_matrix_multiply_c0_enter14_matrix_multiply_aunroll_x_out_o_stall : STD_LOGIC_VECTOR (0 downto 0);
    signal i_sfc_c0_for_end_loopexit_matrix_multiply_c0_enter14_matrix_multiply_aunroll_x_out_o_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal i_cmp_neg_rm17_matrix_multiply_q : STD_LOGIC_VECTOR (0 downto 0);
    signal i_cmp_rm15_matrix_multiply_a : STD_LOGIC_VECTOR (33 downto 0);
    signal i_cmp_rm15_matrix_multiply_b : STD_LOGIC_VECTOR (33 downto 0);
    signal i_cmp_rm15_matrix_multiply_o : STD_LOGIC_VECTOR (33 downto 0);
    signal i_cmp_rm15_matrix_multiply_c : STD_LOGIC_VECTOR (0 downto 0);
    signal i_load_unnamed_matrix_multiply2_matrix_multiply_out_o_readdata : STD_LOGIC_VECTOR (63 downto 0);
    signal i_load_unnamed_matrix_multiply2_matrix_multiply_out_o_stall : STD_LOGIC_VECTOR (0 downto 0);
    signal i_load_unnamed_matrix_multiply2_matrix_multiply_out_o_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal i_load_unnamed_matrix_multiply2_matrix_multiply_out_unnamed_matrix_multiply2_avm_address : STD_LOGIC_VECTOR (29 downto 0);
    signal i_load_unnamed_matrix_multiply2_matrix_multiply_out_unnamed_matrix_multiply2_avm_burstcount : STD_LOGIC_VECTOR (4 downto 0);
    signal i_load_unnamed_matrix_multiply2_matrix_multiply_out_unnamed_matrix_multiply2_avm_byteenable : STD_LOGIC_VECTOR (31 downto 0);
    signal i_load_unnamed_matrix_multiply2_matrix_multiply_out_unnamed_matrix_multiply2_avm_enable : STD_LOGIC_VECTOR (0 downto 0);
    signal i_load_unnamed_matrix_multiply2_matrix_multiply_out_unnamed_matrix_multiply2_avm_read : STD_LOGIC_VECTOR (0 downto 0);
    signal i_load_unnamed_matrix_multiply2_matrix_multiply_out_unnamed_matrix_multiply2_avm_write : STD_LOGIC_VECTOR (0 downto 0);
    signal i_load_unnamed_matrix_multiply2_matrix_multiply_out_unnamed_matrix_multiply2_avm_writedata : STD_LOGIC_VECTOR (255 downto 0);
    signal i_store_unnamed_matrix_multiply3_matrix_multiply_out_lsu_unnamed_matrix_multiply3_o_active : STD_LOGIC_VECTOR (0 downto 0);
    signal i_store_unnamed_matrix_multiply3_matrix_multiply_out_o_stall : STD_LOGIC_VECTOR (0 downto 0);
    signal i_store_unnamed_matrix_multiply3_matrix_multiply_out_o_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal i_store_unnamed_matrix_multiply3_matrix_multiply_out_unnamed_matrix_multiply3_avm_address : STD_LOGIC_VECTOR (29 downto 0);
    signal i_store_unnamed_matrix_multiply3_matrix_multiply_out_unnamed_matrix_multiply3_avm_burstcount : STD_LOGIC_VECTOR (4 downto 0);
    signal i_store_unnamed_matrix_multiply3_matrix_multiply_out_unnamed_matrix_multiply3_avm_byteenable : STD_LOGIC_VECTOR (31 downto 0);
    signal i_store_unnamed_matrix_multiply3_matrix_multiply_out_unnamed_matrix_multiply3_avm_enable : STD_LOGIC_VECTOR (0 downto 0);
    signal i_store_unnamed_matrix_multiply3_matrix_multiply_out_unnamed_matrix_multiply3_avm_read : STD_LOGIC_VECTOR (0 downto 0);
    signal i_store_unnamed_matrix_multiply3_matrix_multiply_out_unnamed_matrix_multiply3_avm_write : STD_LOGIC_VECTOR (0 downto 0);
    signal i_store_unnamed_matrix_multiply3_matrix_multiply_out_unnamed_matrix_multiply3_avm_writedata : STD_LOGIC_VECTOR (255 downto 0);
    signal i_syncbuf_c_sync_buffer_matrix_multiply_out_buffer_out : STD_LOGIC_VECTOR (63 downto 0);
    signal i_syncbuf_c_sync_buffer_matrix_multiply_out_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_syncbuf_c_sync_buffer_matrix_multiply_out_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_syncbuf_d_sync_buffer_matrix_multiply_out_buffer_out : STD_LOGIC_VECTOR (63 downto 0);
    signal i_syncbuf_d_sync_buffer_matrix_multiply_out_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_syncbuf_d_sync_buffer_matrix_multiply_out_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_syncbuf_n_sync_buffer1_matrix_multiply_out_buffer_out : STD_LOGIC_VECTOR (31 downto 0);
    signal i_syncbuf_n_sync_buffer1_matrix_multiply_out_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_syncbuf_n_sync_buffer1_matrix_multiply_out_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_align_12_q : STD_LOGIC_VECTOR (35 downto 0);
    signal i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_align_12_qint : STD_LOGIC_VECTOR (35 downto 0);
    signal i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_join_13_q : STD_LOGIC_VECTOR (57 downto 0);
    signal i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_align_14_q : STD_LOGIC_VECTOR (39 downto 0);
    signal i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_align_14_qint : STD_LOGIC_VECTOR (39 downto 0);
    signal i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_align_15_q : STD_LOGIC_VECTOR (27 downto 0);
    signal i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_align_15_qint : STD_LOGIC_VECTOR (27 downto 0);
    signal i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_join_16_q : STD_LOGIC_VECTOR (67 downto 0);
    signal i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_result_add_0_0_a : STD_LOGIC_VECTOR (68 downto 0);
    signal i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_result_add_0_0_b : STD_LOGIC_VECTOR (68 downto 0);
    signal i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_result_add_0_0_o : STD_LOGIC_VECTOR (68 downto 0);
    signal i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_result_add_0_0_q : STD_LOGIC_VECTOR (68 downto 0);
    signal i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_align_12_q : STD_LOGIC_VECTOR (35 downto 0);
    signal i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_align_12_qint : STD_LOGIC_VECTOR (35 downto 0);
    signal i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_join_13_q : STD_LOGIC_VECTOR (57 downto 0);
    signal i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_align_14_q : STD_LOGIC_VECTOR (39 downto 0);
    signal i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_align_14_qint : STD_LOGIC_VECTOR (39 downto 0);
    signal i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_align_15_q : STD_LOGIC_VECTOR (27 downto 0);
    signal i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_align_15_qint : STD_LOGIC_VECTOR (27 downto 0);
    signal i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_join_16_q : STD_LOGIC_VECTOR (67 downto 0);
    signal i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_result_add_0_0_a : STD_LOGIC_VECTOR (68 downto 0);
    signal i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_result_add_0_0_b : STD_LOGIC_VECTOR (68 downto 0);
    signal i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_result_add_0_0_o : STD_LOGIC_VECTOR (68 downto 0);
    signal i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_result_add_0_0_q : STD_LOGIC_VECTOR (68 downto 0);
    signal i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_im0_shift0_q : STD_LOGIC_VECTOR (20 downto 0);
    signal i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_im0_shift0_qint : STD_LOGIC_VECTOR (20 downto 0);
    signal i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_im3_shift0_q : STD_LOGIC_VECTOR (12 downto 0);
    signal i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_im3_shift0_qint : STD_LOGIC_VECTOR (12 downto 0);
    signal i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_im6_shift0_q : STD_LOGIC_VECTOR (20 downto 0);
    signal i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_im6_shift0_qint : STD_LOGIC_VECTOR (20 downto 0);
    signal i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_im9_shift0_q : STD_LOGIC_VECTOR (20 downto 0);
    signal i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_im9_shift0_qint : STD_LOGIC_VECTOR (20 downto 0);
    signal i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_im0_shift0_q : STD_LOGIC_VECTOR (20 downto 0);
    signal i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_im0_shift0_qint : STD_LOGIC_VECTOR (20 downto 0);
    signal i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_im3_shift0_q : STD_LOGIC_VECTOR (12 downto 0);
    signal i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_im3_shift0_qint : STD_LOGIC_VECTOR (12 downto 0);
    signal i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_im6_shift0_q : STD_LOGIC_VECTOR (20 downto 0);
    signal i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_im6_shift0_qint : STD_LOGIC_VECTOR (20 downto 0);
    signal i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_im9_shift0_q : STD_LOGIC_VECTOR (20 downto 0);
    signal i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_im9_shift0_qint : STD_LOGIC_VECTOR (20 downto 0);
    signal i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_bs1_merged_bit_select_b : STD_LOGIC_VECTOR (17 downto 0);
    signal i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_bs1_merged_bit_select_c : STD_LOGIC_VECTOR (9 downto 0);
    signal i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_bs1_merged_bit_select_d : STD_LOGIC_VECTOR (17 downto 0);
    signal i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_bs1_merged_bit_select_e : STD_LOGIC_VECTOR (17 downto 0);
    signal redist0_stall_entry_o4_147_fifo_valid_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_stall_entry_o4_147_fifo_valid_in_bitsignaltemp : std_logic;
    signal redist0_stall_entry_o4_147_fifo_stall_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_stall_entry_o4_147_fifo_stall_in_bitsignaltemp : std_logic;
    signal redist0_stall_entry_o4_147_fifo_data_in : STD_LOGIC_VECTOR (31 downto 0);
    signal redist0_stall_entry_o4_147_fifo_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_stall_entry_o4_147_fifo_valid_out_bitsignaltemp : std_logic;
    signal redist0_stall_entry_o4_147_fifo_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_stall_entry_o4_147_fifo_stall_out_bitsignaltemp : std_logic;
    signal redist0_stall_entry_o4_147_fifo_data_out : STD_LOGIC_VECTOR (31 downto 0);
    signal redist1_stall_entry_o5_120_fifo_valid_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist1_stall_entry_o5_120_fifo_valid_in_bitsignaltemp : std_logic;
    signal redist1_stall_entry_o5_120_fifo_stall_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist1_stall_entry_o5_120_fifo_stall_in_bitsignaltemp : std_logic;
    signal redist1_stall_entry_o5_120_fifo_data_in : STD_LOGIC_VECTOR (63 downto 0);
    signal redist1_stall_entry_o5_120_fifo_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist1_stall_entry_o5_120_fifo_valid_out_bitsignaltemp : std_logic;
    signal redist1_stall_entry_o5_120_fifo_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist1_stall_entry_o5_120_fifo_stall_out_bitsignaltemp : std_logic;
    signal redist1_stall_entry_o5_120_fifo_data_out : STD_LOGIC_VECTOR (63 downto 0);
    signal redist2_stall_entry_o6_1_0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_valid_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_valid_in_bitsignaltemp : std_logic;
    signal redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_stall_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_stall_in_bitsignaltemp : std_logic;
    signal redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_data_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_valid_out_bitsignaltemp : std_logic;
    signal redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_stall_out_bitsignaltemp : std_logic;
    signal redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_data_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist4_i_cmp_neg_rm17_matrix_multiply_q_143_fifo_valid_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist4_i_cmp_neg_rm17_matrix_multiply_q_143_fifo_valid_in_bitsignaltemp : std_logic;
    signal redist4_i_cmp_neg_rm17_matrix_multiply_q_143_fifo_stall_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist4_i_cmp_neg_rm17_matrix_multiply_q_143_fifo_stall_in_bitsignaltemp : std_logic;
    signal redist4_i_cmp_neg_rm17_matrix_multiply_q_143_fifo_data_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist4_i_cmp_neg_rm17_matrix_multiply_q_143_fifo_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist4_i_cmp_neg_rm17_matrix_multiply_q_143_fifo_valid_out_bitsignaltemp : std_logic;
    signal redist4_i_cmp_neg_rm17_matrix_multiply_q_143_fifo_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist4_i_cmp_neg_rm17_matrix_multiply_q_143_fifo_stall_out_bitsignaltemp : std_logic;
    signal redist4_i_cmp_neg_rm17_matrix_multiply_q_143_fifo_data_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_q : STD_LOGIC_VECTOR (63 downto 0);
    signal redist6_i_arrayidx12_matrix_multiply_matrix_multiply35_trunc_sel_x_b_1_0_q : STD_LOGIC_VECTOR (63 downto 0);
    signal redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_valid_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_valid_in_bitsignaltemp : std_logic;
    signal redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_stall_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_stall_in_bitsignaltemp : std_logic;
    signal redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_data_in : STD_LOGIC_VECTOR (63 downto 0);
    signal redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_valid_out_bitsignaltemp : std_logic;
    signal redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_stall_out_bitsignaltemp : std_logic;
    signal redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_data_out : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_join_i_sfc_c0_for_end_loopexit_matrix_multiply_c0_enter14_matrix_multiply_aunroll_x_q : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_select_i_sfc_c0_for_end_loopexit_matrix_multiply_c0_enter14_matrix_multiply_aunroll_x_b : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_join_i_load_unnamed_matrix_multiply2_matrix_multiply_q : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_select_i_load_unnamed_matrix_multiply2_matrix_multiply_b : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_join_i_syncbuf_c_sync_buffer_matrix_multiply_q : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_select_i_syncbuf_c_sync_buffer_matrix_multiply_b : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_join_i_syncbuf_d_sync_buffer_matrix_multiply_q : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_select_i_syncbuf_d_sync_buffer_matrix_multiply_b : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_join_i_syncbuf_n_sync_buffer1_matrix_multiply_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_i_syncbuf_n_sync_buffer1_matrix_multiply_b : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_join_stall_entry_q : STD_LOGIC_VECTOR (127 downto 0);
    signal bubble_select_stall_entry_b : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_stall_entry_c : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_select_stall_entry_d : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_join_redist0_stall_entry_o4_147_fifo_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_redist0_stall_entry_o4_147_fifo_b : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_join_redist1_stall_entry_o5_120_fifo_q : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_select_redist1_stall_entry_o5_120_fifo_b : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_join_redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_q : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_select_redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_b : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_join_redist4_i_cmp_neg_rm17_matrix_multiply_q_143_fifo_q : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_select_redist4_i_cmp_neg_rm17_matrix_multiply_q_143_fifo_b : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_join_redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_q : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_select_redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_b : STD_LOGIC_VECTOR (63 downto 0);
    signal SE_i_cmp_rm15_matrix_multiply_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp_rm15_matrix_multiply_R_v_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp_rm15_matrix_multiply_R_v_2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp_rm15_matrix_multiply_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp_rm15_matrix_multiply_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp_rm15_matrix_multiply_s_tv_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp_rm15_matrix_multiply_s_tv_2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp_rm15_matrix_multiply_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp_rm15_matrix_multiply_or0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp_rm15_matrix_multiply_or1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp_rm15_matrix_multiply_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp_rm15_matrix_multiply_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp_rm15_matrix_multiply_V1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp_rm15_matrix_multiply_V2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_c_sync_buffer_matrix_multiply_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_c_sync_buffer_matrix_multiply_and0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_c_sync_buffer_matrix_multiply_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_c_sync_buffer_matrix_multiply_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_n_sync_buffer1_matrix_multiply_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_n_sync_buffer1_matrix_multiply_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_n_sync_buffer1_matrix_multiply_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_wireStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_StallValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_toReg0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_fromReg0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_consumed0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_toReg1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_fromReg1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_consumed1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_toReg2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_fromReg2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_consumed2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_toReg3 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_fromReg3 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_consumed3 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_toReg4 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_fromReg4 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_consumed4 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_or0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_or1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_or2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_or3 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_V1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_V2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_V3 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_V4 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist0_stall_entry_o4_147_fifo_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist0_stall_entry_o4_147_fifo_and0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist0_stall_entry_o4_147_fifo_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist0_stall_entry_o4_147_fifo_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_stall_entry_o6_1_0_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_stall_entry_o6_1_0_R_v_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_stall_entry_o6_1_0_R_v_2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_stall_entry_o6_1_0_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_stall_entry_o6_1_0_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_stall_entry_o6_1_0_s_tv_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_stall_entry_o6_1_0_s_tv_2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_stall_entry_o6_1_0_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_stall_entry_o6_1_0_or0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_stall_entry_o6_1_0_or1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_stall_entry_o6_1_0_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_stall_entry_o6_1_0_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_stall_entry_o6_1_0_V1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_stall_entry_o6_1_0_V2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_and0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_and1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_R_v_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_s_tv_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_or0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_V1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_and0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_and1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_stall_entry_2_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_stall_entry_2_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_stall_entry_2_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_stall_entry_3_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_stall_entry_3_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_stall_entry_3_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_stall_entry_2_reg_valid_in : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_stall_entry_2_reg_valid_in_bitsignaltemp : std_logic;
    signal bubble_out_stall_entry_2_reg_stall_in : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_stall_entry_2_reg_stall_in_bitsignaltemp : std_logic;
    signal bubble_out_stall_entry_2_reg_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_stall_entry_2_reg_valid_out_bitsignaltemp : std_logic;
    signal bubble_out_stall_entry_2_reg_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_stall_entry_2_reg_stall_out_bitsignaltemp : std_logic;
    signal bubble_out_stall_entry_3_reg_valid_in : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_stall_entry_3_reg_valid_in_bitsignaltemp : std_logic;
    signal bubble_out_stall_entry_3_reg_stall_in : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_stall_entry_3_reg_stall_in_bitsignaltemp : std_logic;
    signal bubble_out_stall_entry_3_reg_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_stall_entry_3_reg_valid_out_bitsignaltemp : std_logic;
    signal bubble_out_stall_entry_3_reg_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_stall_entry_3_reg_stall_out_bitsignaltemp : std_logic;
    signal SR_SE_redist2_stall_entry_o6_1_0_i_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist2_stall_entry_o6_1_0_r_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist2_stall_entry_o6_1_0_r_data0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist2_stall_entry_o6_1_0_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist2_stall_entry_o6_1_0_V : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist2_stall_entry_o6_1_0_D0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_i_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_r_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_r_data0 : STD_LOGIC_VECTOR (63 downto 0);
    signal SR_SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_r_data1 : STD_LOGIC_VECTOR (63 downto 0);
    signal SR_SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_V : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_D0 : STD_LOGIC_VECTOR (63 downto 0);
    signal SR_SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_D1 : STD_LOGIC_VECTOR (63 downto 0);
    signal SR_SE_i_cmp_rm15_matrix_multiply_i_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_cmp_rm15_matrix_multiply_r_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_cmp_rm15_matrix_multiply_and0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_cmp_rm15_matrix_multiply_r_data0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_i_cmp_rm15_matrix_multiply_r_data1 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_i_cmp_rm15_matrix_multiply_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_cmp_rm15_matrix_multiply_V : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_cmp_rm15_matrix_multiply_D0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_i_cmp_rm15_matrix_multiply_D1 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_i_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_r_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_and0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_and1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_r_data0 : STD_LOGIC_VECTOR (63 downto 0);
    signal SR_SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_r_data1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_V : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_D0 : STD_LOGIC_VECTOR (63 downto 0);
    signal SR_SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_D1 : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- SE_out_i_syncbuf_d_sync_buffer_matrix_multiply(STALLENABLE,187)
    -- Valid signal propagation
    SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_V0 <= SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_wireValid;
    -- Backward Stall generation
    SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_backStall <= i_load_unnamed_matrix_multiply2_matrix_multiply_out_o_stall or not (SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_wireValid);
    -- Computing multiple Valid(s)
    SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_wireValid <= SR_SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_V;

    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- i_syncbuf_n_sync_buffer1_matrix_multiply(BLACKBOX,57)@1
    -- in in_stall_in@20000000
    -- out out_stall_out@20000000
    thei_syncbuf_n_sync_buffer1_matrix_multiply : i_syncbuf_n_sync_buffer1_matrix_multiply27
    PORT MAP (
        in_buffer_in => in_N,
        in_i_dependence => GND_q,
        in_stall_in => SE_out_i_syncbuf_n_sync_buffer1_matrix_multiply_backStall,
        in_valid_in => SE_redist2_stall_entry_o6_1_0_V1,
        out_buffer_out => i_syncbuf_n_sync_buffer1_matrix_multiply_out_buffer_out,
        out_stall_out => i_syncbuf_n_sync_buffer1_matrix_multiply_out_stall_out,
        out_valid_out => i_syncbuf_n_sync_buffer1_matrix_multiply_out_valid_out,
        clock => clock,
        resetn => resetn
    );

    -- bubble_join_i_syncbuf_n_sync_buffer1_matrix_multiply(BITJOIN,144)
    bubble_join_i_syncbuf_n_sync_buffer1_matrix_multiply_q <= i_syncbuf_n_sync_buffer1_matrix_multiply_out_buffer_out;

    -- bubble_select_i_syncbuf_n_sync_buffer1_matrix_multiply(BITSELECT,145)
    bubble_select_i_syncbuf_n_sync_buffer1_matrix_multiply_b <= STD_LOGIC_VECTOR(bubble_join_i_syncbuf_n_sync_buffer1_matrix_multiply_q(31 downto 0));

    -- bubble_join_stall_entry(BITJOIN,147)
    bubble_join_stall_entry_q <= in_global_id_03 & in_c0_exe1102 & in_acl_hw_wg_id5;

    -- bubble_select_stall_entry(BITSELECT,148)
    bubble_select_stall_entry_b <= STD_LOGIC_VECTOR(bubble_join_stall_entry_q(31 downto 0));
    bubble_select_stall_entry_c <= STD_LOGIC_VECTOR(bubble_join_stall_entry_q(95 downto 32));
    bubble_select_stall_entry_d <= STD_LOGIC_VECTOR(bubble_join_stall_entry_q(127 downto 96));

    -- redist0_stall_entry_o4_147_fifo(STALLFIFO,122)
    redist0_stall_entry_o4_147_fifo_valid_in <= SE_stall_entry_V3;
    redist0_stall_entry_o4_147_fifo_stall_in <= SE_out_redist0_stall_entry_o4_147_fifo_backStall;
    redist0_stall_entry_o4_147_fifo_data_in <= bubble_select_stall_entry_b;
    redist0_stall_entry_o4_147_fifo_valid_in_bitsignaltemp <= redist0_stall_entry_o4_147_fifo_valid_in(0);
    redist0_stall_entry_o4_147_fifo_stall_in_bitsignaltemp <= redist0_stall_entry_o4_147_fifo_stall_in(0);
    redist0_stall_entry_o4_147_fifo_valid_out(0) <= redist0_stall_entry_o4_147_fifo_valid_out_bitsignaltemp;
    redist0_stall_entry_o4_147_fifo_stall_out(0) <= redist0_stall_entry_o4_147_fifo_stall_out_bitsignaltemp;
    theredist0_stall_entry_o4_147_fifo : acl_data_fifo
    GENERIC MAP (
        DEPTH => 148,
        STRICT_DEPTH => 0,
        ALLOW_FULL_WRITE => 0,
        DATA_WIDTH => 32,
        IMPL => "ram"
    )
    PORT MAP (
        valid_in => redist0_stall_entry_o4_147_fifo_valid_in_bitsignaltemp,
        stall_in => redist0_stall_entry_o4_147_fifo_stall_in_bitsignaltemp,
        data_in => bubble_select_stall_entry_b,
        valid_out => redist0_stall_entry_o4_147_fifo_valid_out_bitsignaltemp,
        stall_out => redist0_stall_entry_o4_147_fifo_stall_out_bitsignaltemp,
        data_out => redist0_stall_entry_o4_147_fifo_data_out,
        clock => clock,
        resetn => resetn
    );

    -- i_arrayidx12_matrix_multiply_matrix_multiply35_mult_multconst_x(CONSTANT,25)
    i_arrayidx12_matrix_multiply_matrix_multiply35_mult_multconst_x_q <= "000000000000000000000000000000000000000000000000000000000000";

    -- i_idxprom8_matrix_multiply_sel_x(BITSELECT,41)@1
    i_idxprom8_matrix_multiply_sel_x_b <= STD_LOGIC_VECTOR(std_logic_vector(resize(signed(redist2_stall_entry_o6_1_0_q(31 downto 0)), 64)));

    -- i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_bs1_merged_bit_select(BITSELECT,113)@1
    i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_bs1_merged_bit_select_b <= i_idxprom8_matrix_multiply_sel_x_b(17 downto 0);
    i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_bs1_merged_bit_select_c <= i_idxprom8_matrix_multiply_sel_x_b(63 downto 54);
    i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_bs1_merged_bit_select_d <= i_idxprom8_matrix_multiply_sel_x_b(35 downto 18);
    i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_bs1_merged_bit_select_e <= i_idxprom8_matrix_multiply_sel_x_b(53 downto 36);

    -- i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_im3_shift0(BITSHIFT,106)@1
    i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_im3_shift0_qint <= i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_bs1_merged_bit_select_c & "000";
    i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_im3_shift0_q <= i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_im3_shift0_qint(12 downto 0);

    -- i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_align_15(BITSHIFT,83)@1
    i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_align_15_qint <= STD_LOGIC_VECTOR("0" & i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_im3_shift0_q) & "00000000000000";
    i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_align_15_q <= i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_align_15_qint(27 downto 0);

    -- i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_im6_shift0(BITSHIFT,107)@1
    i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_im6_shift0_qint <= i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_bs1_merged_bit_select_d & "000";
    i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_im6_shift0_q <= i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_im6_shift0_qint(20 downto 0);

    -- i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_align_14(BITSHIFT,82)@1
    i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_align_14_qint <= STD_LOGIC_VECTOR("0" & i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_im6_shift0_q) & "000000000000000000";
    i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_align_14_q <= i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_align_14_qint(39 downto 0);

    -- i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_join_16(BITJOIN,84)@1
    i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_join_16_q <= i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_align_15_q & i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_align_14_q;

    -- i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_im9_shift0(BITSHIFT,108)@1
    i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_im9_shift0_qint <= i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_bs1_merged_bit_select_e & "000";
    i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_im9_shift0_q <= i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_im9_shift0_qint(20 downto 0);

    -- i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_align_12(BITSHIFT,80)@1
    i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_align_12_qint <= STD_LOGIC_VECTOR("0" & i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_im9_shift0_q) & "00000000000000";
    i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_align_12_q <= i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_align_12_qint(35 downto 0);

    -- i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_im0_shift0(BITSHIFT,105)@1
    i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_im0_shift0_qint <= i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_bs1_merged_bit_select_b & "000";
    i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_im0_shift0_q <= i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_im0_shift0_qint(20 downto 0);

    -- i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_join_13(BITJOIN,81)@1
    i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_join_13_q <= i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_align_12_q & STD_LOGIC_VECTOR("0" & i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_im0_shift0_q);

    -- i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_result_add_0_0(ADD,85)@1
    i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_result_add_0_0_a <= STD_LOGIC_VECTOR("00000000000" & i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_join_13_q);
    i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_result_add_0_0_b <= STD_LOGIC_VECTOR("0" & i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_join_16_q);
    i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_result_add_0_0_o <= STD_LOGIC_VECTOR(UNSIGNED(i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_result_add_0_0_a) + UNSIGNED(i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_result_add_0_0_b));
    i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_result_add_0_0_q <= i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_result_add_0_0_o(68 downto 0);

    -- i_arrayidx12_matrix_multiply_matrix_multiply35_mult_extender_x(BITJOIN,24)@1
    i_arrayidx12_matrix_multiply_matrix_multiply35_mult_extender_x_q <= i_arrayidx12_matrix_multiply_matrix_multiply35_mult_multconst_x_q & i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_result_add_0_0_q(67 downto 0);

    -- i_arrayidx12_matrix_multiply_matrix_multiply35_trunc_sel_x(BITSELECT,26)@1
    i_arrayidx12_matrix_multiply_matrix_multiply35_trunc_sel_x_b <= i_arrayidx12_matrix_multiply_matrix_multiply35_mult_extender_x_q(63 downto 0);

    -- i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_im3_shift0(BITSHIFT,110)@1
    i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_im3_shift0_qint <= i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_bs1_merged_bit_select_c & "000";
    i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_im3_shift0_q <= i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_im3_shift0_qint(12 downto 0);

    -- i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_align_15(BITSHIFT,101)@1
    i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_align_15_qint <= STD_LOGIC_VECTOR("0" & i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_im3_shift0_q) & "00000000000000";
    i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_align_15_q <= i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_align_15_qint(27 downto 0);

    -- i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_im6_shift0(BITSHIFT,111)@1
    i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_im6_shift0_qint <= i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_bs1_merged_bit_select_d & "000";
    i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_im6_shift0_q <= i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_im6_shift0_qint(20 downto 0);

    -- i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_align_14(BITSHIFT,100)@1
    i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_align_14_qint <= STD_LOGIC_VECTOR("0" & i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_im6_shift0_q) & "000000000000000000";
    i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_align_14_q <= i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_align_14_qint(39 downto 0);

    -- i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_join_16(BITJOIN,102)@1
    i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_join_16_q <= i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_align_15_q & i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_align_14_q;

    -- i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_im9_shift0(BITSHIFT,112)@1
    i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_im9_shift0_qint <= i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_bs1_merged_bit_select_e & "000";
    i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_im9_shift0_q <= i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_im9_shift0_qint(20 downto 0);

    -- i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_align_12(BITSHIFT,98)@1
    i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_align_12_qint <= STD_LOGIC_VECTOR("0" & i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_im9_shift0_q) & "00000000000000";
    i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_align_12_q <= i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_align_12_qint(35 downto 0);

    -- i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_im0_shift0(BITSHIFT,109)@1
    i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_im0_shift0_qint <= i_arrayidx12_matrix_multiply_matrix_multiply35_mult_x_bs1_merged_bit_select_b & "000";
    i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_im0_shift0_q <= i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_im0_shift0_qint(20 downto 0);

    -- i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_join_13(BITJOIN,99)@1
    i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_join_13_q <= i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_align_12_q & STD_LOGIC_VECTOR("0" & i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_im0_shift0_q);

    -- i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_result_add_0_0(ADD,103)@1
    i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_result_add_0_0_a <= STD_LOGIC_VECTOR("00000000000" & i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_join_13_q);
    i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_result_add_0_0_b <= STD_LOGIC_VECTOR("0" & i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_join_16_q);
    i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_result_add_0_0_o <= STD_LOGIC_VECTOR(UNSIGNED(i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_result_add_0_0_a) + UNSIGNED(i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_result_add_0_0_b));
    i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_result_add_0_0_q <= i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_result_add_0_0_o(68 downto 0);

    -- i_arrayidx9_matrix_multiply_matrix_multiply34_mult_extender_x(BITJOIN,34)@1
    i_arrayidx9_matrix_multiply_matrix_multiply34_mult_extender_x_q <= i_arrayidx12_matrix_multiply_matrix_multiply35_mult_multconst_x_q & i_arrayidx9_matrix_multiply_matrix_multiply34_mult_x_result_add_0_0_q(67 downto 0);

    -- i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x(BITSELECT,36)@1
    i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b <= i_arrayidx9_matrix_multiply_matrix_multiply34_mult_extender_x_q(63 downto 0);

    -- SR_SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0(STALLREG,282)
    SR_SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SR_SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_r_valid <= (others => '0');
            SR_SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_r_data0 <= (others => '-');
            SR_SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_r_data1 <= (others => '-');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Valid
            SR_SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_r_valid <= SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_backStall and (SR_SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_r_valid or SR_SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_i_valid);

            IF (SR_SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_r_valid = "0") THEN
                -- Data(s)
                SR_SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_r_data0 <= STD_LOGIC_VECTOR(i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b);
                SR_SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_r_data1 <= STD_LOGIC_VECTOR(i_arrayidx12_matrix_multiply_matrix_multiply35_trunc_sel_x_b);
            END IF;

        END IF;
    END PROCESS;
    -- Computing multiple Valid(s)
    SR_SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_i_valid <= SE_redist2_stall_entry_o6_1_0_V2;
    -- Stall signal propagation
    SR_SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_backStall <= SR_SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_r_valid or not (SR_SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_i_valid);

    -- Valid
    SR_SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_V <= SR_SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_r_valid WHEN SR_SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_r_valid = "1" ELSE SR_SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_i_valid;

    -- Data0
    SR_SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_D0 <= SR_SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_r_data0 WHEN SR_SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_r_valid = "1" ELSE i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b;
    -- Data1
    SR_SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_D1 <= SR_SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_r_data1 WHEN SR_SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_r_valid = "1" ELSE i_arrayidx12_matrix_multiply_matrix_multiply35_trunc_sel_x_b;

    -- redist6_i_arrayidx12_matrix_multiply_matrix_multiply35_trunc_sel_x_b_1_0(REG,128)
    redist6_i_arrayidx12_matrix_multiply_matrix_multiply35_trunc_sel_x_b_1_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist6_i_arrayidx12_matrix_multiply_matrix_multiply35_trunc_sel_x_b_1_0_q <= "0000000000000000000000000000000000000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_backEN = "1") THEN
                redist6_i_arrayidx12_matrix_multiply_matrix_multiply35_trunc_sel_x_b_1_0_q <= STD_LOGIC_VECTOR(SR_SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_D1);
            END IF;
        END IF;
    END PROCESS;

    -- bubble_join_i_syncbuf_c_sync_buffer_matrix_multiply(BITJOIN,138)
    bubble_join_i_syncbuf_c_sync_buffer_matrix_multiply_q <= i_syncbuf_c_sync_buffer_matrix_multiply_out_buffer_out;

    -- bubble_select_i_syncbuf_c_sync_buffer_matrix_multiply(BITSELECT,139)
    bubble_select_i_syncbuf_c_sync_buffer_matrix_multiply_b <= STD_LOGIC_VECTOR(bubble_join_i_syncbuf_c_sync_buffer_matrix_multiply_q(63 downto 0));

    -- i_arrayidx12_matrix_multiply_matrix_multiply35_add_x(ADD,27)@2
    i_arrayidx12_matrix_multiply_matrix_multiply35_add_x_a <= STD_LOGIC_VECTOR("0" & bubble_select_i_syncbuf_c_sync_buffer_matrix_multiply_b);
    i_arrayidx12_matrix_multiply_matrix_multiply35_add_x_b <= STD_LOGIC_VECTOR("0" & redist6_i_arrayidx12_matrix_multiply_matrix_multiply35_trunc_sel_x_b_1_0_q);
    i_arrayidx12_matrix_multiply_matrix_multiply35_add_x_o <= STD_LOGIC_VECTOR(UNSIGNED(i_arrayidx12_matrix_multiply_matrix_multiply35_add_x_a) + UNSIGNED(i_arrayidx12_matrix_multiply_matrix_multiply35_add_x_b));
    i_arrayidx12_matrix_multiply_matrix_multiply35_add_x_q <= i_arrayidx12_matrix_multiply_matrix_multiply35_add_x_o(64 downto 0);

    -- i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x(BITSELECT,21)@2
    i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b <= i_arrayidx12_matrix_multiply_matrix_multiply35_add_x_q(63 downto 0);

    -- redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo(STALLFIFO,129)
    redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_valid_in <= SE_out_i_syncbuf_c_sync_buffer_matrix_multiply_V0;
    redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_stall_in <= SE_out_redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_backStall;
    redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_data_in <= i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b;
    redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_valid_in_bitsignaltemp <= redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_valid_in(0);
    redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_stall_in_bitsignaltemp <= redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_stall_in(0);
    redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_valid_out(0) <= redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_valid_out_bitsignaltemp;
    redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_stall_out(0) <= redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_stall_out_bitsignaltemp;
    theredist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo : acl_data_fifo
    GENERIC MAP (
        DEPTH => 144,
        STRICT_DEPTH => 0,
        ALLOW_FULL_WRITE => 0,
        DATA_WIDTH => 64,
        IMPL => "ram"
    )
    PORT MAP (
        valid_in => redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_valid_in_bitsignaltemp,
        stall_in => redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_stall_in_bitsignaltemp,
        data_in => i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b,
        valid_out => redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_valid_out_bitsignaltemp,
        stall_out => redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_stall_out_bitsignaltemp,
        data_out => redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_data_out,
        clock => clock,
        resetn => resetn
    );

    -- SE_out_i_syncbuf_c_sync_buffer_matrix_multiply(STALLENABLE,185)
    -- Valid signal propagation
    SE_out_i_syncbuf_c_sync_buffer_matrix_multiply_V0 <= SE_out_i_syncbuf_c_sync_buffer_matrix_multiply_wireValid;
    -- Backward Stall generation
    SE_out_i_syncbuf_c_sync_buffer_matrix_multiply_backStall <= redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_stall_out or not (SE_out_i_syncbuf_c_sync_buffer_matrix_multiply_wireValid);
    -- Computing multiple Valid(s)
    SE_out_i_syncbuf_c_sync_buffer_matrix_multiply_and0 <= i_syncbuf_c_sync_buffer_matrix_multiply_out_valid_out;
    SE_out_i_syncbuf_c_sync_buffer_matrix_multiply_wireValid <= SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_V1 and SE_out_i_syncbuf_c_sync_buffer_matrix_multiply_and0;

    -- i_syncbuf_c_sync_buffer_matrix_multiply(BLACKBOX,55)@2
    -- in in_stall_in@20000000
    -- out out_stall_out@20000000
    thei_syncbuf_c_sync_buffer_matrix_multiply : i_syncbuf_c_sync_buffer_matrix_multiply31
    PORT MAP (
        in_buffer_in => in_C,
        in_i_dependence => GND_q,
        in_stall_in => SE_out_i_syncbuf_c_sync_buffer_matrix_multiply_backStall,
        in_valid_in => SE_out_bubble_out_stall_entry_3_V0,
        out_buffer_out => i_syncbuf_c_sync_buffer_matrix_multiply_out_buffer_out,
        out_stall_out => i_syncbuf_c_sync_buffer_matrix_multiply_out_stall_out,
        out_valid_out => i_syncbuf_c_sync_buffer_matrix_multiply_out_valid_out,
        clock => clock,
        resetn => resetn
    );

    -- SE_out_bubble_out_stall_entry_3(STALLENABLE,257)
    -- Valid signal propagation
    SE_out_bubble_out_stall_entry_3_V0 <= SE_out_bubble_out_stall_entry_3_wireValid;
    -- Backward Stall generation
    SE_out_bubble_out_stall_entry_3_backStall <= i_syncbuf_c_sync_buffer_matrix_multiply_out_stall_out or not (SE_out_bubble_out_stall_entry_3_wireValid);
    -- Computing multiple Valid(s)
    SE_out_bubble_out_stall_entry_3_wireValid <= bubble_out_stall_entry_3_reg_valid_out;

    -- bubble_out_stall_entry_3_reg(STALLFIFO,280)
    bubble_out_stall_entry_3_reg_valid_in <= SE_stall_entry_V1;
    bubble_out_stall_entry_3_reg_stall_in <= SE_out_bubble_out_stall_entry_3_backStall;
    bubble_out_stall_entry_3_reg_valid_in_bitsignaltemp <= bubble_out_stall_entry_3_reg_valid_in(0);
    bubble_out_stall_entry_3_reg_stall_in_bitsignaltemp <= bubble_out_stall_entry_3_reg_stall_in(0);
    bubble_out_stall_entry_3_reg_valid_out(0) <= bubble_out_stall_entry_3_reg_valid_out_bitsignaltemp;
    bubble_out_stall_entry_3_reg_stall_out(0) <= bubble_out_stall_entry_3_reg_stall_out_bitsignaltemp;
    thebubble_out_stall_entry_3_reg : acl_valid_fifo_counter
    GENERIC MAP (
        DEPTH => 3,
        STRICT_DEPTH => 0,
        ALLOW_FULL_WRITE => 0,
        ASYNC_RESET => 1
    )
    PORT MAP (
        valid_in => bubble_out_stall_entry_3_reg_valid_in_bitsignaltemp,
        stall_in => bubble_out_stall_entry_3_reg_stall_in_bitsignaltemp,
        valid_out => bubble_out_stall_entry_3_reg_valid_out_bitsignaltemp,
        stall_out => bubble_out_stall_entry_3_reg_stall_out_bitsignaltemp,
        clock => clock,
        resetn => resetn
    );

    -- SE_out_bubble_out_stall_entry_2(STALLENABLE,255)
    -- Valid signal propagation
    SE_out_bubble_out_stall_entry_2_V0 <= SE_out_bubble_out_stall_entry_2_wireValid;
    -- Backward Stall generation
    SE_out_bubble_out_stall_entry_2_backStall <= i_syncbuf_d_sync_buffer_matrix_multiply_out_stall_out or not (SE_out_bubble_out_stall_entry_2_wireValid);
    -- Computing multiple Valid(s)
    SE_out_bubble_out_stall_entry_2_wireValid <= bubble_out_stall_entry_2_reg_valid_out;

    -- bubble_out_stall_entry_2_reg(STALLFIFO,279)
    bubble_out_stall_entry_2_reg_valid_in <= SE_stall_entry_V0;
    bubble_out_stall_entry_2_reg_stall_in <= SE_out_bubble_out_stall_entry_2_backStall;
    bubble_out_stall_entry_2_reg_valid_in_bitsignaltemp <= bubble_out_stall_entry_2_reg_valid_in(0);
    bubble_out_stall_entry_2_reg_stall_in_bitsignaltemp <= bubble_out_stall_entry_2_reg_stall_in(0);
    bubble_out_stall_entry_2_reg_valid_out(0) <= bubble_out_stall_entry_2_reg_valid_out_bitsignaltemp;
    bubble_out_stall_entry_2_reg_stall_out(0) <= bubble_out_stall_entry_2_reg_stall_out_bitsignaltemp;
    thebubble_out_stall_entry_2_reg : acl_valid_fifo_counter
    GENERIC MAP (
        DEPTH => 3,
        STRICT_DEPTH => 0,
        ALLOW_FULL_WRITE => 0,
        ASYNC_RESET => 1
    )
    PORT MAP (
        valid_in => bubble_out_stall_entry_2_reg_valid_in_bitsignaltemp,
        stall_in => bubble_out_stall_entry_2_reg_stall_in_bitsignaltemp,
        valid_out => bubble_out_stall_entry_2_reg_valid_out_bitsignaltemp,
        stall_out => bubble_out_stall_entry_2_reg_stall_out_bitsignaltemp,
        clock => clock,
        resetn => resetn
    );

    -- SE_stall_entry(STALLENABLE,190)
    SE_stall_entry_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_stall_entry_fromReg0 <= (others => '0');
            SE_stall_entry_fromReg1 <= (others => '0');
            SE_stall_entry_fromReg2 <= (others => '0');
            SE_stall_entry_fromReg3 <= (others => '0');
            SE_stall_entry_fromReg4 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Succesor 0
            SE_stall_entry_fromReg0 <= SE_stall_entry_toReg0;
            -- Succesor 1
            SE_stall_entry_fromReg1 <= SE_stall_entry_toReg1;
            -- Succesor 2
            SE_stall_entry_fromReg2 <= SE_stall_entry_toReg2;
            -- Succesor 3
            SE_stall_entry_fromReg3 <= SE_stall_entry_toReg3;
            -- Succesor 4
            SE_stall_entry_fromReg4 <= SE_stall_entry_toReg4;
        END IF;
    END PROCESS;
    -- Input Stall processing
    SE_stall_entry_consumed0 <= (not (bubble_out_stall_entry_2_reg_stall_out) and SE_stall_entry_wireValid) or SE_stall_entry_fromReg0;
    SE_stall_entry_consumed1 <= (not (bubble_out_stall_entry_3_reg_stall_out) and SE_stall_entry_wireValid) or SE_stall_entry_fromReg1;
    SE_stall_entry_consumed2 <= (not (SR_SE_redist2_stall_entry_o6_1_0_backStall) and SE_stall_entry_wireValid) or SE_stall_entry_fromReg2;
    SE_stall_entry_consumed3 <= (not (redist0_stall_entry_o4_147_fifo_stall_out) and SE_stall_entry_wireValid) or SE_stall_entry_fromReg3;
    SE_stall_entry_consumed4 <= (not (redist1_stall_entry_o5_120_fifo_stall_out) and SE_stall_entry_wireValid) or SE_stall_entry_fromReg4;
    -- Consuming
    SE_stall_entry_StallValid <= SE_stall_entry_backStall and SE_stall_entry_wireValid;
    SE_stall_entry_toReg0 <= SE_stall_entry_StallValid and SE_stall_entry_consumed0;
    SE_stall_entry_toReg1 <= SE_stall_entry_StallValid and SE_stall_entry_consumed1;
    SE_stall_entry_toReg2 <= SE_stall_entry_StallValid and SE_stall_entry_consumed2;
    SE_stall_entry_toReg3 <= SE_stall_entry_StallValid and SE_stall_entry_consumed3;
    SE_stall_entry_toReg4 <= SE_stall_entry_StallValid and SE_stall_entry_consumed4;
    -- Backward Stall generation
    SE_stall_entry_or0 <= SE_stall_entry_consumed0;
    SE_stall_entry_or1 <= SE_stall_entry_consumed1 and SE_stall_entry_or0;
    SE_stall_entry_or2 <= SE_stall_entry_consumed2 and SE_stall_entry_or1;
    SE_stall_entry_or3 <= SE_stall_entry_consumed3 and SE_stall_entry_or2;
    SE_stall_entry_wireStall <= not (SE_stall_entry_consumed4 and SE_stall_entry_or3);
    SE_stall_entry_backStall <= SE_stall_entry_wireStall;
    -- Valid signal propagation
    SE_stall_entry_V0 <= SE_stall_entry_wireValid and not (SE_stall_entry_fromReg0);
    SE_stall_entry_V1 <= SE_stall_entry_wireValid and not (SE_stall_entry_fromReg1);
    SE_stall_entry_V2 <= SE_stall_entry_wireValid and not (SE_stall_entry_fromReg2);
    SE_stall_entry_V3 <= SE_stall_entry_wireValid and not (SE_stall_entry_fromReg3);
    SE_stall_entry_V4 <= SE_stall_entry_wireValid and not (SE_stall_entry_fromReg4);
    -- Computing multiple Valid(s)
    SE_stall_entry_wireValid <= in_valid_in;

    -- SR_SE_redist2_stall_entry_o6_1_0(STALLREG,281)
    SR_SE_redist2_stall_entry_o6_1_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SR_SE_redist2_stall_entry_o6_1_0_r_valid <= (others => '0');
            SR_SE_redist2_stall_entry_o6_1_0_r_data0 <= (others => '-');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Valid
            SR_SE_redist2_stall_entry_o6_1_0_r_valid <= SE_redist2_stall_entry_o6_1_0_backStall and (SR_SE_redist2_stall_entry_o6_1_0_r_valid or SR_SE_redist2_stall_entry_o6_1_0_i_valid);

            IF (SR_SE_redist2_stall_entry_o6_1_0_r_valid = "0") THEN
                -- Data(s)
                SR_SE_redist2_stall_entry_o6_1_0_r_data0 <= STD_LOGIC_VECTOR(bubble_select_stall_entry_d);
            END IF;

        END IF;
    END PROCESS;
    -- Computing multiple Valid(s)
    SR_SE_redist2_stall_entry_o6_1_0_i_valid <= SE_stall_entry_V2;
    -- Stall signal propagation
    SR_SE_redist2_stall_entry_o6_1_0_backStall <= SR_SE_redist2_stall_entry_o6_1_0_r_valid or not (SR_SE_redist2_stall_entry_o6_1_0_i_valid);

    -- Valid
    SR_SE_redist2_stall_entry_o6_1_0_V <= SR_SE_redist2_stall_entry_o6_1_0_r_valid WHEN SR_SE_redist2_stall_entry_o6_1_0_r_valid = "1" ELSE SR_SE_redist2_stall_entry_o6_1_0_i_valid;

    SR_SE_redist2_stall_entry_o6_1_0_D0 <= SR_SE_redist2_stall_entry_o6_1_0_r_data0 WHEN SR_SE_redist2_stall_entry_o6_1_0_r_valid = "1" ELSE bubble_select_stall_entry_d;

    -- redist2_stall_entry_o6_1_0(REG,124)
    redist2_stall_entry_o6_1_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist2_stall_entry_o6_1_0_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist2_stall_entry_o6_1_0_backEN = "1") THEN
                redist2_stall_entry_o6_1_0_q <= STD_LOGIC_VECTOR(SR_SE_redist2_stall_entry_o6_1_0_D0);
            END IF;
        END IF;
    END PROCESS;

    -- SE_out_i_syncbuf_n_sync_buffer1_matrix_multiply(STALLENABLE,189)
    -- Valid signal propagation
    SE_out_i_syncbuf_n_sync_buffer1_matrix_multiply_V0 <= SE_out_i_syncbuf_n_sync_buffer1_matrix_multiply_wireValid;
    -- Backward Stall generation
    SE_out_i_syncbuf_n_sync_buffer1_matrix_multiply_backStall <= SR_SE_i_cmp_rm15_matrix_multiply_backStall or not (SE_out_i_syncbuf_n_sync_buffer1_matrix_multiply_wireValid);
    -- Computing multiple Valid(s)
    SE_out_i_syncbuf_n_sync_buffer1_matrix_multiply_wireValid <= i_syncbuf_n_sync_buffer1_matrix_multiply_out_valid_out;

    -- SE_redist2_stall_entry_o6_1_0(STALLENABLE,217)
    -- Valid signal propagation
    SE_redist2_stall_entry_o6_1_0_V0 <= SE_redist2_stall_entry_o6_1_0_R_v_0;
    SE_redist2_stall_entry_o6_1_0_V1 <= SE_redist2_stall_entry_o6_1_0_R_v_1;
    SE_redist2_stall_entry_o6_1_0_V2 <= SE_redist2_stall_entry_o6_1_0_R_v_2;
    -- Stall signal propagation
    SE_redist2_stall_entry_o6_1_0_s_tv_0 <= SR_SE_i_cmp_rm15_matrix_multiply_backStall and SE_redist2_stall_entry_o6_1_0_R_v_0;
    SE_redist2_stall_entry_o6_1_0_s_tv_1 <= i_syncbuf_n_sync_buffer1_matrix_multiply_out_stall_out and SE_redist2_stall_entry_o6_1_0_R_v_1;
    SE_redist2_stall_entry_o6_1_0_s_tv_2 <= SR_SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_backStall and SE_redist2_stall_entry_o6_1_0_R_v_2;
    -- Backward Enable generation
    SE_redist2_stall_entry_o6_1_0_or0 <= SE_redist2_stall_entry_o6_1_0_s_tv_0;
    SE_redist2_stall_entry_o6_1_0_or1 <= SE_redist2_stall_entry_o6_1_0_s_tv_1 or SE_redist2_stall_entry_o6_1_0_or0;
    SE_redist2_stall_entry_o6_1_0_backEN <= not (SE_redist2_stall_entry_o6_1_0_s_tv_2 or SE_redist2_stall_entry_o6_1_0_or1);
    -- Determine whether to write valid data into the first register stage
    SE_redist2_stall_entry_o6_1_0_v_s_0 <= SE_redist2_stall_entry_o6_1_0_backEN and SR_SE_redist2_stall_entry_o6_1_0_V;
    -- Backward Stall generation
    SE_redist2_stall_entry_o6_1_0_backStall <= not (SE_redist2_stall_entry_o6_1_0_backEN);
    SE_redist2_stall_entry_o6_1_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_redist2_stall_entry_o6_1_0_R_v_0 <= (others => '0');
            SE_redist2_stall_entry_o6_1_0_R_v_1 <= (others => '0');
            SE_redist2_stall_entry_o6_1_0_R_v_2 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist2_stall_entry_o6_1_0_backEN = "0") THEN
                SE_redist2_stall_entry_o6_1_0_R_v_0 <= SE_redist2_stall_entry_o6_1_0_R_v_0 and SE_redist2_stall_entry_o6_1_0_s_tv_0;
            ELSE
                SE_redist2_stall_entry_o6_1_0_R_v_0 <= SE_redist2_stall_entry_o6_1_0_v_s_0;
            END IF;

            IF (SE_redist2_stall_entry_o6_1_0_backEN = "0") THEN
                SE_redist2_stall_entry_o6_1_0_R_v_1 <= SE_redist2_stall_entry_o6_1_0_R_v_1 and SE_redist2_stall_entry_o6_1_0_s_tv_1;
            ELSE
                SE_redist2_stall_entry_o6_1_0_R_v_1 <= SE_redist2_stall_entry_o6_1_0_v_s_0;
            END IF;

            IF (SE_redist2_stall_entry_o6_1_0_backEN = "0") THEN
                SE_redist2_stall_entry_o6_1_0_R_v_2 <= SE_redist2_stall_entry_o6_1_0_R_v_2 and SE_redist2_stall_entry_o6_1_0_s_tv_2;
            ELSE
                SE_redist2_stall_entry_o6_1_0_R_v_2 <= SE_redist2_stall_entry_o6_1_0_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SR_SE_i_cmp_rm15_matrix_multiply(STALLREG,283)
    SR_SE_i_cmp_rm15_matrix_multiply_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SR_SE_i_cmp_rm15_matrix_multiply_r_valid <= (others => '0');
            SR_SE_i_cmp_rm15_matrix_multiply_r_data0 <= (others => '-');
            SR_SE_i_cmp_rm15_matrix_multiply_r_data1 <= (others => '-');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Valid
            SR_SE_i_cmp_rm15_matrix_multiply_r_valid <= SE_i_cmp_rm15_matrix_multiply_backStall and (SR_SE_i_cmp_rm15_matrix_multiply_r_valid or SR_SE_i_cmp_rm15_matrix_multiply_i_valid);

            IF (SR_SE_i_cmp_rm15_matrix_multiply_r_valid = "0") THEN
                -- Data(s)
                SR_SE_i_cmp_rm15_matrix_multiply_r_data0 <= STD_LOGIC_VECTOR(redist2_stall_entry_o6_1_0_q);
                SR_SE_i_cmp_rm15_matrix_multiply_r_data1 <= STD_LOGIC_VECTOR(bubble_select_i_syncbuf_n_sync_buffer1_matrix_multiply_b);
            END IF;

        END IF;
    END PROCESS;
    -- Computing multiple Valid(s)
    SR_SE_i_cmp_rm15_matrix_multiply_and0 <= SE_redist2_stall_entry_o6_1_0_V0;
    SR_SE_i_cmp_rm15_matrix_multiply_i_valid <= SE_out_i_syncbuf_n_sync_buffer1_matrix_multiply_V0 and SR_SE_i_cmp_rm15_matrix_multiply_and0;
    -- Stall signal propagation
    SR_SE_i_cmp_rm15_matrix_multiply_backStall <= SR_SE_i_cmp_rm15_matrix_multiply_r_valid or not (SR_SE_i_cmp_rm15_matrix_multiply_i_valid);

    -- Valid
    SR_SE_i_cmp_rm15_matrix_multiply_V <= SR_SE_i_cmp_rm15_matrix_multiply_r_valid WHEN SR_SE_i_cmp_rm15_matrix_multiply_r_valid = "1" ELSE SR_SE_i_cmp_rm15_matrix_multiply_i_valid;

    -- Data0
    SR_SE_i_cmp_rm15_matrix_multiply_D0 <= SR_SE_i_cmp_rm15_matrix_multiply_r_data0 WHEN SR_SE_i_cmp_rm15_matrix_multiply_r_valid = "1" ELSE redist2_stall_entry_o6_1_0_q;
    -- Data1
    SR_SE_i_cmp_rm15_matrix_multiply_D1 <= SR_SE_i_cmp_rm15_matrix_multiply_r_data1 WHEN SR_SE_i_cmp_rm15_matrix_multiply_r_valid = "1" ELSE bubble_select_i_syncbuf_n_sync_buffer1_matrix_multiply_b;

    -- i_cmp_rm15_matrix_multiply(COMPARE,50)@1 + 1
    i_cmp_rm15_matrix_multiply_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 32 => SR_SE_i_cmp_rm15_matrix_multiply_D0(31)) & SR_SE_i_cmp_rm15_matrix_multiply_D0));
    i_cmp_rm15_matrix_multiply_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 32 => SR_SE_i_cmp_rm15_matrix_multiply_D1(31)) & SR_SE_i_cmp_rm15_matrix_multiply_D1));
    i_cmp_rm15_matrix_multiply_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            i_cmp_rm15_matrix_multiply_o <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_i_cmp_rm15_matrix_multiply_backEN = "1") THEN
                i_cmp_rm15_matrix_multiply_o <= STD_LOGIC_VECTOR(SIGNED(i_cmp_rm15_matrix_multiply_a) - SIGNED(i_cmp_rm15_matrix_multiply_b));
            END IF;
        END IF;
    END PROCESS;
    i_cmp_rm15_matrix_multiply_c(0) <= i_cmp_rm15_matrix_multiply_o(33);

    -- i_cmp_neg_rm17_matrix_multiply(LOGICAL,49)@2
    i_cmp_neg_rm17_matrix_multiply_q <= i_cmp_rm15_matrix_multiply_c xor VCC_q;

    -- redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0(REG,127)
    redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_q <= "0000000000000000000000000000000000000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_backEN = "1") THEN
                redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_q <= STD_LOGIC_VECTOR(SR_SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_D0);
            END IF;
        END IF;
    END PROCESS;

    -- bubble_join_i_syncbuf_d_sync_buffer_matrix_multiply(BITJOIN,141)
    bubble_join_i_syncbuf_d_sync_buffer_matrix_multiply_q <= i_syncbuf_d_sync_buffer_matrix_multiply_out_buffer_out;

    -- bubble_select_i_syncbuf_d_sync_buffer_matrix_multiply(BITSELECT,142)
    bubble_select_i_syncbuf_d_sync_buffer_matrix_multiply_b <= STD_LOGIC_VECTOR(bubble_join_i_syncbuf_d_sync_buffer_matrix_multiply_q(63 downto 0));

    -- i_arrayidx9_matrix_multiply_matrix_multiply34_add_x(ADD,37)@2
    i_arrayidx9_matrix_multiply_matrix_multiply34_add_x_a <= STD_LOGIC_VECTOR("0" & bubble_select_i_syncbuf_d_sync_buffer_matrix_multiply_b);
    i_arrayidx9_matrix_multiply_matrix_multiply34_add_x_b <= STD_LOGIC_VECTOR("0" & redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_q);
    i_arrayidx9_matrix_multiply_matrix_multiply34_add_x_o <= STD_LOGIC_VECTOR(UNSIGNED(i_arrayidx9_matrix_multiply_matrix_multiply34_add_x_a) + UNSIGNED(i_arrayidx9_matrix_multiply_matrix_multiply34_add_x_b));
    i_arrayidx9_matrix_multiply_matrix_multiply34_add_x_q <= i_arrayidx9_matrix_multiply_matrix_multiply34_add_x_o(64 downto 0);

    -- i_arrayidx9_matrix_multiply_matrix_multiply34_dupName_0_trunc_sel_x(BITSELECT,31)@2
    i_arrayidx9_matrix_multiply_matrix_multiply34_dupName_0_trunc_sel_x_b <= i_arrayidx9_matrix_multiply_matrix_multiply34_add_x_q(63 downto 0);

    -- redist4_i_cmp_neg_rm17_matrix_multiply_q_143_fifo(STALLFIFO,126)
    redist4_i_cmp_neg_rm17_matrix_multiply_q_143_fifo_valid_in <= SE_i_cmp_rm15_matrix_multiply_V2;
    redist4_i_cmp_neg_rm17_matrix_multiply_q_143_fifo_stall_in <= SE_out_redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_backStall;
    redist4_i_cmp_neg_rm17_matrix_multiply_q_143_fifo_data_in <= i_cmp_neg_rm17_matrix_multiply_q;
    redist4_i_cmp_neg_rm17_matrix_multiply_q_143_fifo_valid_in_bitsignaltemp <= redist4_i_cmp_neg_rm17_matrix_multiply_q_143_fifo_valid_in(0);
    redist4_i_cmp_neg_rm17_matrix_multiply_q_143_fifo_stall_in_bitsignaltemp <= redist4_i_cmp_neg_rm17_matrix_multiply_q_143_fifo_stall_in(0);
    redist4_i_cmp_neg_rm17_matrix_multiply_q_143_fifo_valid_out(0) <= redist4_i_cmp_neg_rm17_matrix_multiply_q_143_fifo_valid_out_bitsignaltemp;
    redist4_i_cmp_neg_rm17_matrix_multiply_q_143_fifo_stall_out(0) <= redist4_i_cmp_neg_rm17_matrix_multiply_q_143_fifo_stall_out_bitsignaltemp;
    theredist4_i_cmp_neg_rm17_matrix_multiply_q_143_fifo : acl_data_fifo
    GENERIC MAP (
        DEPTH => 144,
        STRICT_DEPTH => 0,
        ALLOW_FULL_WRITE => 0,
        DATA_WIDTH => 1,
        IMPL => "ram"
    )
    PORT MAP (
        valid_in => redist4_i_cmp_neg_rm17_matrix_multiply_q_143_fifo_valid_in_bitsignaltemp,
        stall_in => redist4_i_cmp_neg_rm17_matrix_multiply_q_143_fifo_stall_in_bitsignaltemp,
        data_in => i_cmp_neg_rm17_matrix_multiply_q,
        valid_out => redist4_i_cmp_neg_rm17_matrix_multiply_q_143_fifo_valid_out_bitsignaltemp,
        stall_out => redist4_i_cmp_neg_rm17_matrix_multiply_q_143_fifo_stall_out_bitsignaltemp,
        data_out => redist4_i_cmp_neg_rm17_matrix_multiply_q_143_fifo_data_out,
        clock => clock,
        resetn => resetn
    );

    -- SE_i_cmp_rm15_matrix_multiply(STALLENABLE,179)
    -- Valid signal propagation
    SE_i_cmp_rm15_matrix_multiply_V0 <= SE_i_cmp_rm15_matrix_multiply_R_v_0;
    SE_i_cmp_rm15_matrix_multiply_V1 <= SE_i_cmp_rm15_matrix_multiply_R_v_1;
    SE_i_cmp_rm15_matrix_multiply_V2 <= SE_i_cmp_rm15_matrix_multiply_R_v_2;
    -- Stall signal propagation
    SE_i_cmp_rm15_matrix_multiply_s_tv_0 <= SR_SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_backStall and SE_i_cmp_rm15_matrix_multiply_R_v_0;
    SE_i_cmp_rm15_matrix_multiply_s_tv_1 <= redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_stall_out and SE_i_cmp_rm15_matrix_multiply_R_v_1;
    SE_i_cmp_rm15_matrix_multiply_s_tv_2 <= redist4_i_cmp_neg_rm17_matrix_multiply_q_143_fifo_stall_out and SE_i_cmp_rm15_matrix_multiply_R_v_2;
    -- Backward Enable generation
    SE_i_cmp_rm15_matrix_multiply_or0 <= SE_i_cmp_rm15_matrix_multiply_s_tv_0;
    SE_i_cmp_rm15_matrix_multiply_or1 <= SE_i_cmp_rm15_matrix_multiply_s_tv_1 or SE_i_cmp_rm15_matrix_multiply_or0;
    SE_i_cmp_rm15_matrix_multiply_backEN <= not (SE_i_cmp_rm15_matrix_multiply_s_tv_2 or SE_i_cmp_rm15_matrix_multiply_or1);
    -- Determine whether to write valid data into the first register stage
    SE_i_cmp_rm15_matrix_multiply_v_s_0 <= SE_i_cmp_rm15_matrix_multiply_backEN and SR_SE_i_cmp_rm15_matrix_multiply_V;
    -- Backward Stall generation
    SE_i_cmp_rm15_matrix_multiply_backStall <= not (SE_i_cmp_rm15_matrix_multiply_backEN);
    SE_i_cmp_rm15_matrix_multiply_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_i_cmp_rm15_matrix_multiply_R_v_0 <= (others => '0');
            SE_i_cmp_rm15_matrix_multiply_R_v_1 <= (others => '0');
            SE_i_cmp_rm15_matrix_multiply_R_v_2 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_i_cmp_rm15_matrix_multiply_backEN = "0") THEN
                SE_i_cmp_rm15_matrix_multiply_R_v_0 <= SE_i_cmp_rm15_matrix_multiply_R_v_0 and SE_i_cmp_rm15_matrix_multiply_s_tv_0;
            ELSE
                SE_i_cmp_rm15_matrix_multiply_R_v_0 <= SE_i_cmp_rm15_matrix_multiply_v_s_0;
            END IF;

            IF (SE_i_cmp_rm15_matrix_multiply_backEN = "0") THEN
                SE_i_cmp_rm15_matrix_multiply_R_v_1 <= SE_i_cmp_rm15_matrix_multiply_R_v_1 and SE_i_cmp_rm15_matrix_multiply_s_tv_1;
            ELSE
                SE_i_cmp_rm15_matrix_multiply_R_v_1 <= SE_i_cmp_rm15_matrix_multiply_v_s_0;
            END IF;

            IF (SE_i_cmp_rm15_matrix_multiply_backEN = "0") THEN
                SE_i_cmp_rm15_matrix_multiply_R_v_2 <= SE_i_cmp_rm15_matrix_multiply_R_v_2 and SE_i_cmp_rm15_matrix_multiply_s_tv_2;
            ELSE
                SE_i_cmp_rm15_matrix_multiply_R_v_2 <= SE_i_cmp_rm15_matrix_multiply_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0(STALLENABLE,222)
    -- Valid signal propagation
    SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_V0 <= SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_R_v_0;
    SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_V1 <= SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_R_v_1;
    -- Stall signal propagation
    SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_s_tv_0 <= SR_SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_backStall and SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_R_v_0;
    SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_s_tv_1 <= SE_out_i_syncbuf_c_sync_buffer_matrix_multiply_backStall and SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_R_v_1;
    -- Backward Enable generation
    SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_or0 <= SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_s_tv_0;
    SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_backEN <= not (SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_s_tv_1 or SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_or0);
    -- Determine whether to write valid data into the first register stage
    SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_v_s_0 <= SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_backEN and SR_SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_V;
    -- Backward Stall generation
    SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_backStall <= not (SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_backEN);
    SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_R_v_0 <= (others => '0');
            SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_R_v_1 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_backEN = "0") THEN
                SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_R_v_0 <= SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_R_v_0 and SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_s_tv_0;
            ELSE
                SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_R_v_0 <= SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_v_s_0;
            END IF;

            IF (SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_backEN = "0") THEN
                SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_R_v_1 <= SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_R_v_1 and SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_s_tv_1;
            ELSE
                SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_R_v_1 <= SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- i_syncbuf_d_sync_buffer_matrix_multiply(BLACKBOX,56)@2
    -- in in_stall_in@20000000
    -- out out_stall_out@20000000
    thei_syncbuf_d_sync_buffer_matrix_multiply : i_syncbuf_d_sync_buffer_matrix_multiply29
    PORT MAP (
        in_buffer_in => in_D,
        in_i_dependence => GND_q,
        in_stall_in => SR_SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_backStall,
        in_valid_in => SE_out_bubble_out_stall_entry_2_V0,
        out_buffer_out => i_syncbuf_d_sync_buffer_matrix_multiply_out_buffer_out,
        out_stall_out => i_syncbuf_d_sync_buffer_matrix_multiply_out_stall_out,
        out_valid_out => i_syncbuf_d_sync_buffer_matrix_multiply_out_valid_out,
        clock => clock,
        resetn => resetn
    );

    -- SR_SE_out_i_syncbuf_d_sync_buffer_matrix_multiply(STALLREG,284)
    SR_SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SR_SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_r_valid <= (others => '0');
            SR_SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_r_data0 <= (others => '-');
            SR_SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_r_data1 <= (others => '-');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Valid
            SR_SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_r_valid <= SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_backStall and (SR_SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_r_valid or SR_SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_i_valid);

            IF (SR_SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_r_valid = "0") THEN
                -- Data(s)
                SR_SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_r_data0 <= i_arrayidx9_matrix_multiply_matrix_multiply34_dupName_0_trunc_sel_x_b;
                SR_SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_r_data1 <= i_cmp_neg_rm17_matrix_multiply_q;
            END IF;

        END IF;
    END PROCESS;
    -- Computing multiple Valid(s)
    SR_SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_and0 <= i_syncbuf_d_sync_buffer_matrix_multiply_out_valid_out;
    SR_SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_and1 <= SE_redist5_i_arrayidx9_matrix_multiply_matrix_multiply34_trunc_sel_x_b_1_0_V0 and SR_SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_and0;
    SR_SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_i_valid <= SE_i_cmp_rm15_matrix_multiply_V0 and SR_SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_and1;
    -- Stall signal propagation
    SR_SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_backStall <= SR_SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_r_valid or not (SR_SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_i_valid);

    -- Valid
    SR_SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_V <= SR_SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_r_valid WHEN SR_SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_r_valid = "1" ELSE SR_SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_i_valid;

    -- Data0
    SR_SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_D0 <= SR_SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_r_data0 WHEN SR_SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_r_valid = "1" ELSE i_arrayidx9_matrix_multiply_matrix_multiply34_dupName_0_trunc_sel_x_b;
    -- Data1
    SR_SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_D1 <= SR_SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_r_data1 WHEN SR_SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_r_valid = "1" ELSE i_cmp_neg_rm17_matrix_multiply_q;

    -- i_load_unnamed_matrix_multiply2_matrix_multiply(BLACKBOX,53)@2
    -- in in_i_stall@20000000
    -- out out_o_readdata@120
    -- out out_o_stall@20000000
    -- out out_o_valid@120
    -- out out_unnamed_matrix_multiply2_avm_address@20000000
    -- out out_unnamed_matrix_multiply2_avm_burstcount@20000000
    -- out out_unnamed_matrix_multiply2_avm_byteenable@20000000
    -- out out_unnamed_matrix_multiply2_avm_enable@20000000
    -- out out_unnamed_matrix_multiply2_avm_read@20000000
    -- out out_unnamed_matrix_multiply2_avm_write@20000000
    -- out out_unnamed_matrix_multiply2_avm_writedata@20000000
    thei_load_unnamed_matrix_multiply2_matrix_multiply : i_load_unnamed_matrix_multiply2_matrix_multiply36
    PORT MAP (
        in_flush => in_flush,
        in_i_address => SR_SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_D0,
        in_i_predicate => SR_SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_D1,
        in_i_stall => SE_out_redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_backStall,
        in_i_valid => SE_out_i_syncbuf_d_sync_buffer_matrix_multiply_V0,
        in_unnamed_matrix_multiply2_avm_readdata => in_unnamed_matrix_multiply2_avm_readdata,
        in_unnamed_matrix_multiply2_avm_readdatavalid => in_unnamed_matrix_multiply2_avm_readdatavalid,
        in_unnamed_matrix_multiply2_avm_waitrequest => in_unnamed_matrix_multiply2_avm_waitrequest,
        in_unnamed_matrix_multiply2_avm_writeack => in_unnamed_matrix_multiply2_avm_writeack,
        out_o_readdata => i_load_unnamed_matrix_multiply2_matrix_multiply_out_o_readdata,
        out_o_stall => i_load_unnamed_matrix_multiply2_matrix_multiply_out_o_stall,
        out_o_valid => i_load_unnamed_matrix_multiply2_matrix_multiply_out_o_valid,
        out_unnamed_matrix_multiply2_avm_address => i_load_unnamed_matrix_multiply2_matrix_multiply_out_unnamed_matrix_multiply2_avm_address,
        out_unnamed_matrix_multiply2_avm_burstcount => i_load_unnamed_matrix_multiply2_matrix_multiply_out_unnamed_matrix_multiply2_avm_burstcount,
        out_unnamed_matrix_multiply2_avm_byteenable => i_load_unnamed_matrix_multiply2_matrix_multiply_out_unnamed_matrix_multiply2_avm_byteenable,
        out_unnamed_matrix_multiply2_avm_enable => i_load_unnamed_matrix_multiply2_matrix_multiply_out_unnamed_matrix_multiply2_avm_enable,
        out_unnamed_matrix_multiply2_avm_read => i_load_unnamed_matrix_multiply2_matrix_multiply_out_unnamed_matrix_multiply2_avm_read,
        out_unnamed_matrix_multiply2_avm_write => i_load_unnamed_matrix_multiply2_matrix_multiply_out_unnamed_matrix_multiply2_avm_write,
        out_unnamed_matrix_multiply2_avm_writedata => i_load_unnamed_matrix_multiply2_matrix_multiply_out_unnamed_matrix_multiply2_avm_writedata,
        clock => clock,
        resetn => resetn
    );

    -- redist1_stall_entry_o5_120_fifo(STALLFIFO,123)
    redist1_stall_entry_o5_120_fifo_valid_in <= SE_stall_entry_V4;
    redist1_stall_entry_o5_120_fifo_stall_in <= SE_out_redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_backStall;
    redist1_stall_entry_o5_120_fifo_data_in <= bubble_select_stall_entry_c;
    redist1_stall_entry_o5_120_fifo_valid_in_bitsignaltemp <= redist1_stall_entry_o5_120_fifo_valid_in(0);
    redist1_stall_entry_o5_120_fifo_stall_in_bitsignaltemp <= redist1_stall_entry_o5_120_fifo_stall_in(0);
    redist1_stall_entry_o5_120_fifo_valid_out(0) <= redist1_stall_entry_o5_120_fifo_valid_out_bitsignaltemp;
    redist1_stall_entry_o5_120_fifo_stall_out(0) <= redist1_stall_entry_o5_120_fifo_stall_out_bitsignaltemp;
    theredist1_stall_entry_o5_120_fifo : acl_data_fifo
    GENERIC MAP (
        DEPTH => 121,
        STRICT_DEPTH => 0,
        ALLOW_FULL_WRITE => 0,
        DATA_WIDTH => 64,
        IMPL => "ram"
    )
    PORT MAP (
        valid_in => redist1_stall_entry_o5_120_fifo_valid_in_bitsignaltemp,
        stall_in => redist1_stall_entry_o5_120_fifo_stall_in_bitsignaltemp,
        data_in => bubble_select_stall_entry_c,
        valid_out => redist1_stall_entry_o5_120_fifo_valid_out_bitsignaltemp,
        stall_out => redist1_stall_entry_o5_120_fifo_stall_out_bitsignaltemp,
        data_out => redist1_stall_entry_o5_120_fifo_data_out,
        clock => clock,
        resetn => resetn
    );

    -- redist3_i_cmp_rm15_matrix_multiply_c_119_fifo(STALLFIFO,125)
    redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_valid_in <= SE_i_cmp_rm15_matrix_multiply_V1;
    redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_stall_in <= SE_out_redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_backStall;
    redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_data_in <= i_cmp_rm15_matrix_multiply_c;
    redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_valid_in_bitsignaltemp <= redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_valid_in(0);
    redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_stall_in_bitsignaltemp <= redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_stall_in(0);
    redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_valid_out(0) <= redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_valid_out_bitsignaltemp;
    redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_stall_out(0) <= redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_stall_out_bitsignaltemp;
    theredist3_i_cmp_rm15_matrix_multiply_c_119_fifo : acl_data_fifo
    GENERIC MAP (
        DEPTH => 119,
        STRICT_DEPTH => 0,
        ALLOW_FULL_WRITE => 0,
        DATA_WIDTH => 1,
        IMPL => "ram"
    )
    PORT MAP (
        valid_in => redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_valid_in_bitsignaltemp,
        stall_in => redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_stall_in_bitsignaltemp,
        data_in => i_cmp_rm15_matrix_multiply_c,
        valid_out => redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_valid_out_bitsignaltemp,
        stall_out => redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_stall_out_bitsignaltemp,
        data_out => redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_data_out,
        clock => clock,
        resetn => resetn
    );

    -- SE_out_redist3_i_cmp_rm15_matrix_multiply_c_119_fifo(STALLENABLE,219)
    -- Valid signal propagation
    SE_out_redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_V0 <= SE_out_redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_wireValid;
    -- Backward Stall generation
    SE_out_redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_backStall <= i_sfc_c0_for_end_loopexit_matrix_multiply_c0_enter14_matrix_multiply_aunroll_x_out_o_stall or not (SE_out_redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_wireValid);
    -- Computing multiple Valid(s)
    SE_out_redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_and0 <= redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_valid_out;
    SE_out_redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_and1 <= redist1_stall_entry_o5_120_fifo_valid_out and SE_out_redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_and0;
    SE_out_redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_wireValid <= i_load_unnamed_matrix_multiply2_matrix_multiply_out_o_valid and SE_out_redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_and1;

    -- bubble_join_i_load_unnamed_matrix_multiply2_matrix_multiply(BITJOIN,134)
    bubble_join_i_load_unnamed_matrix_multiply2_matrix_multiply_q <= i_load_unnamed_matrix_multiply2_matrix_multiply_out_o_readdata;

    -- bubble_select_i_load_unnamed_matrix_multiply2_matrix_multiply(BITSELECT,135)
    bubble_select_i_load_unnamed_matrix_multiply2_matrix_multiply_b <= STD_LOGIC_VECTOR(bubble_join_i_load_unnamed_matrix_multiply2_matrix_multiply_q(63 downto 0));

    -- bubble_join_redist1_stall_entry_o5_120_fifo(BITJOIN,156)
    bubble_join_redist1_stall_entry_o5_120_fifo_q <= redist1_stall_entry_o5_120_fifo_data_out;

    -- bubble_select_redist1_stall_entry_o5_120_fifo(BITSELECT,157)
    bubble_select_redist1_stall_entry_o5_120_fifo_b <= STD_LOGIC_VECTOR(bubble_join_redist1_stall_entry_o5_120_fifo_q(63 downto 0));

    -- bubble_join_redist3_i_cmp_rm15_matrix_multiply_c_119_fifo(BITJOIN,159)
    bubble_join_redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_q <= redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_data_out;

    -- bubble_select_redist3_i_cmp_rm15_matrix_multiply_c_119_fifo(BITSELECT,160)
    bubble_select_redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_b <= STD_LOGIC_VECTOR(bubble_join_redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_q(0 downto 0));

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- i_sfc_c0_for_end_loopexit_matrix_multiply_c0_enter14_matrix_multiply_aunroll_x(BLACKBOX,42)@120
    -- in in_i_stall@20000000
    -- out out_c0_exit19_0@145
    -- out out_c0_exit19_1@145
    -- out out_o_stall@20000000
    -- out out_o_valid@145
    thei_sfc_c0_for_end_loopexit_matrix_multiply_c0_enter14_matrix_multiply_aunroll_x : i_sfc_c0_for_end_loopexit_matrix_multiply_c0_enter14_matrix_multiply
    PORT MAP (
        in_c0_eni313_0 => GND_q,
        in_c0_eni313_1 => bubble_select_redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_b,
        in_c0_eni313_2 => bubble_select_redist1_stall_entry_o5_120_fifo_b,
        in_c0_eni313_3 => bubble_select_i_load_unnamed_matrix_multiply2_matrix_multiply_b,
        in_P => in_P,
        in_i_stall => SE_out_redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_backStall,
        in_i_valid => SE_out_redist3_i_cmp_rm15_matrix_multiply_c_119_fifo_V0,
        out_c0_exit19_1 => i_sfc_c0_for_end_loopexit_matrix_multiply_c0_enter14_matrix_multiply_aunroll_x_out_c0_exit19_1,
        out_o_stall => i_sfc_c0_for_end_loopexit_matrix_multiply_c0_enter14_matrix_multiply_aunroll_x_out_o_stall,
        out_o_valid => i_sfc_c0_for_end_loopexit_matrix_multiply_c0_enter14_matrix_multiply_aunroll_x_out_o_valid,
        clock => clock,
        resetn => resetn
    );

    -- bubble_join_i_sfc_c0_for_end_loopexit_matrix_multiply_c0_enter14_matrix_multiply_aunroll_x(BITJOIN,131)
    bubble_join_i_sfc_c0_for_end_loopexit_matrix_multiply_c0_enter14_matrix_multiply_aunroll_x_q <= i_sfc_c0_for_end_loopexit_matrix_multiply_c0_enter14_matrix_multiply_aunroll_x_out_c0_exit19_1;

    -- bubble_select_i_sfc_c0_for_end_loopexit_matrix_multiply_c0_enter14_matrix_multiply_aunroll_x(BITSELECT,132)
    bubble_select_i_sfc_c0_for_end_loopexit_matrix_multiply_c0_enter14_matrix_multiply_aunroll_x_b <= STD_LOGIC_VECTOR(bubble_join_i_sfc_c0_for_end_loopexit_matrix_multiply_c0_enter14_matrix_multiply_aunroll_x_q(63 downto 0));

    -- SE_out_redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo(STALLENABLE,225)
    -- Valid signal propagation
    SE_out_redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_V0 <= SE_out_redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_wireValid;
    -- Backward Stall generation
    SE_out_redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_backStall <= i_store_unnamed_matrix_multiply3_matrix_multiply_out_o_stall or not (SE_out_redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_wireValid);
    -- Computing multiple Valid(s)
    SE_out_redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_and0 <= redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_valid_out;
    SE_out_redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_and1 <= redist4_i_cmp_neg_rm17_matrix_multiply_q_143_fifo_valid_out and SE_out_redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_and0;
    SE_out_redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_wireValid <= i_sfc_c0_for_end_loopexit_matrix_multiply_c0_enter14_matrix_multiply_aunroll_x_out_o_valid and SE_out_redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_and1;

    -- SE_out_redist0_stall_entry_o4_147_fifo(STALLENABLE,214)
    -- Valid signal propagation
    SE_out_redist0_stall_entry_o4_147_fifo_V0 <= SE_out_redist0_stall_entry_o4_147_fifo_wireValid;
    -- Backward Stall generation
    SE_out_redist0_stall_entry_o4_147_fifo_backStall <= in_stall_in or not (SE_out_redist0_stall_entry_o4_147_fifo_wireValid);
    -- Computing multiple Valid(s)
    SE_out_redist0_stall_entry_o4_147_fifo_and0 <= redist0_stall_entry_o4_147_fifo_valid_out;
    SE_out_redist0_stall_entry_o4_147_fifo_wireValid <= i_store_unnamed_matrix_multiply3_matrix_multiply_out_o_valid and SE_out_redist0_stall_entry_o4_147_fifo_and0;

    -- bubble_join_redist4_i_cmp_neg_rm17_matrix_multiply_q_143_fifo(BITJOIN,162)
    bubble_join_redist4_i_cmp_neg_rm17_matrix_multiply_q_143_fifo_q <= redist4_i_cmp_neg_rm17_matrix_multiply_q_143_fifo_data_out;

    -- bubble_select_redist4_i_cmp_neg_rm17_matrix_multiply_q_143_fifo(BITSELECT,163)
    bubble_select_redist4_i_cmp_neg_rm17_matrix_multiply_q_143_fifo_b <= STD_LOGIC_VECTOR(bubble_join_redist4_i_cmp_neg_rm17_matrix_multiply_q_143_fifo_q(0 downto 0));

    -- bubble_join_redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo(BITJOIN,165)
    bubble_join_redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_q <= redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_data_out;

    -- bubble_select_redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo(BITSELECT,166)
    bubble_select_redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_b <= STD_LOGIC_VECTOR(bubble_join_redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_q(63 downto 0));

    -- i_store_unnamed_matrix_multiply3_matrix_multiply(BLACKBOX,54)@145
    -- in in_i_stall@20000000
    -- out out_lsu_unnamed_matrix_multiply3_o_active@20000000
    -- out out_o_stall@20000000
    -- out out_o_valid@147
    -- out out_unnamed_matrix_multiply3_avm_address@20000000
    -- out out_unnamed_matrix_multiply3_avm_burstcount@20000000
    -- out out_unnamed_matrix_multiply3_avm_byteenable@20000000
    -- out out_unnamed_matrix_multiply3_avm_enable@20000000
    -- out out_unnamed_matrix_multiply3_avm_read@20000000
    -- out out_unnamed_matrix_multiply3_avm_write@20000000
    -- out out_unnamed_matrix_multiply3_avm_writedata@20000000
    thei_store_unnamed_matrix_multiply3_matrix_multiply : i_store_unnamed_matrix_multiply3_matrix_multiply44
    PORT MAP (
        in_flush => in_flush,
        in_i_address => bubble_select_redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_b,
        in_i_predicate => bubble_select_redist4_i_cmp_neg_rm17_matrix_multiply_q_143_fifo_b,
        in_i_stall => SE_out_redist0_stall_entry_o4_147_fifo_backStall,
        in_i_valid => SE_out_redist7_i_arrayidx12_matrix_multiply_matrix_multiply35_dupName_0_trunc_sel_x_b_143_fifo_V0,
        in_i_writedata => bubble_select_i_sfc_c0_for_end_loopexit_matrix_multiply_c0_enter14_matrix_multiply_aunroll_x_b,
        in_unnamed_matrix_multiply3_avm_readdata => in_unnamed_matrix_multiply3_avm_readdata,
        in_unnamed_matrix_multiply3_avm_readdatavalid => in_unnamed_matrix_multiply3_avm_readdatavalid,
        in_unnamed_matrix_multiply3_avm_waitrequest => in_unnamed_matrix_multiply3_avm_waitrequest,
        in_unnamed_matrix_multiply3_avm_writeack => in_unnamed_matrix_multiply3_avm_writeack,
        out_lsu_unnamed_matrix_multiply3_o_active => i_store_unnamed_matrix_multiply3_matrix_multiply_out_lsu_unnamed_matrix_multiply3_o_active,
        out_o_stall => i_store_unnamed_matrix_multiply3_matrix_multiply_out_o_stall,
        out_o_valid => i_store_unnamed_matrix_multiply3_matrix_multiply_out_o_valid,
        out_unnamed_matrix_multiply3_avm_address => i_store_unnamed_matrix_multiply3_matrix_multiply_out_unnamed_matrix_multiply3_avm_address,
        out_unnamed_matrix_multiply3_avm_burstcount => i_store_unnamed_matrix_multiply3_matrix_multiply_out_unnamed_matrix_multiply3_avm_burstcount,
        out_unnamed_matrix_multiply3_avm_byteenable => i_store_unnamed_matrix_multiply3_matrix_multiply_out_unnamed_matrix_multiply3_avm_byteenable,
        out_unnamed_matrix_multiply3_avm_enable => i_store_unnamed_matrix_multiply3_matrix_multiply_out_unnamed_matrix_multiply3_avm_enable,
        out_unnamed_matrix_multiply3_avm_read => i_store_unnamed_matrix_multiply3_matrix_multiply_out_unnamed_matrix_multiply3_avm_read,
        out_unnamed_matrix_multiply3_avm_write => i_store_unnamed_matrix_multiply3_matrix_multiply_out_unnamed_matrix_multiply3_avm_write,
        out_unnamed_matrix_multiply3_avm_writedata => i_store_unnamed_matrix_multiply3_matrix_multiply_out_unnamed_matrix_multiply3_avm_writedata,
        clock => clock,
        resetn => resetn
    );

    -- dupName_0_ext_sig_sync_out_x(GPOUT,3)
    out_unnamed_matrix_multiply3_avm_address <= i_store_unnamed_matrix_multiply3_matrix_multiply_out_unnamed_matrix_multiply3_avm_address;
    out_unnamed_matrix_multiply3_avm_enable <= i_store_unnamed_matrix_multiply3_matrix_multiply_out_unnamed_matrix_multiply3_avm_enable;
    out_unnamed_matrix_multiply3_avm_read <= i_store_unnamed_matrix_multiply3_matrix_multiply_out_unnamed_matrix_multiply3_avm_read;
    out_unnamed_matrix_multiply3_avm_write <= i_store_unnamed_matrix_multiply3_matrix_multiply_out_unnamed_matrix_multiply3_avm_write;
    out_unnamed_matrix_multiply3_avm_writedata <= i_store_unnamed_matrix_multiply3_matrix_multiply_out_unnamed_matrix_multiply3_avm_writedata;
    out_unnamed_matrix_multiply3_avm_byteenable <= i_store_unnamed_matrix_multiply3_matrix_multiply_out_unnamed_matrix_multiply3_avm_byteenable;
    out_unnamed_matrix_multiply3_avm_burstcount <= i_store_unnamed_matrix_multiply3_matrix_multiply_out_unnamed_matrix_multiply3_avm_burstcount;

    -- bubble_join_redist0_stall_entry_o4_147_fifo(BITJOIN,153)
    bubble_join_redist0_stall_entry_o4_147_fifo_q <= redist0_stall_entry_o4_147_fifo_data_out;

    -- bubble_select_redist0_stall_entry_o4_147_fifo(BITSELECT,154)
    bubble_select_redist0_stall_entry_o4_147_fifo_b <= STD_LOGIC_VECTOR(bubble_join_redist0_stall_entry_o4_147_fifo_q(31 downto 0));

    -- dupName_0_sync_out_x(GPOUT,8)@147
    out_acl_hw_wg_id5 <= bubble_select_redist0_stall_entry_o4_147_fifo_b;
    out_valid_out <= SE_out_redist0_stall_entry_o4_147_fifo_V0;

    -- dupName_1_ext_sig_sync_out_x(GPOUT,9)
    out_lsu_unnamed_matrix_multiply3_o_active <= i_store_unnamed_matrix_multiply3_matrix_multiply_out_lsu_unnamed_matrix_multiply3_o_active;

    -- ext_sig_sync_out(GPOUT,48)
    out_unnamed_matrix_multiply2_avm_address <= i_load_unnamed_matrix_multiply2_matrix_multiply_out_unnamed_matrix_multiply2_avm_address;
    out_unnamed_matrix_multiply2_avm_enable <= i_load_unnamed_matrix_multiply2_matrix_multiply_out_unnamed_matrix_multiply2_avm_enable;
    out_unnamed_matrix_multiply2_avm_read <= i_load_unnamed_matrix_multiply2_matrix_multiply_out_unnamed_matrix_multiply2_avm_read;
    out_unnamed_matrix_multiply2_avm_write <= i_load_unnamed_matrix_multiply2_matrix_multiply_out_unnamed_matrix_multiply2_avm_write;
    out_unnamed_matrix_multiply2_avm_writedata <= i_load_unnamed_matrix_multiply2_matrix_multiply_out_unnamed_matrix_multiply2_avm_writedata;
    out_unnamed_matrix_multiply2_avm_byteenable <= i_load_unnamed_matrix_multiply2_matrix_multiply_out_unnamed_matrix_multiply2_avm_byteenable;
    out_unnamed_matrix_multiply2_avm_burstcount <= i_load_unnamed_matrix_multiply2_matrix_multiply_out_unnamed_matrix_multiply2_avm_burstcount;

    -- sync_out(GPOUT,67)@0
    out_stall_out <= SE_stall_entry_backStall;

END normal;
