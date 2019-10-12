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

-- VHDL created from bb_matrix_multiply_B1_stall_region
-- VHDL created on Mon Oct 07 15:55:09 2019


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

entity bb_matrix_multiply_B1_stall_region is
    port (
        in_unnamed_matrix_multiply1_avm_readdata : in std_logic_vector(255 downto 0);  -- ufix256
        in_unnamed_matrix_multiply1_avm_writeack : in std_logic_vector(0 downto 0);  -- ufix1
        in_unnamed_matrix_multiply1_avm_waitrequest : in std_logic_vector(0 downto 0);  -- ufix1
        in_unnamed_matrix_multiply1_avm_readdatavalid : in std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_matrix_multiply1_avm_address : out std_logic_vector(29 downto 0);  -- ufix30
        out_unnamed_matrix_multiply1_avm_enable : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_matrix_multiply1_avm_read : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_matrix_multiply1_avm_write : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_matrix_multiply1_avm_writedata : out std_logic_vector(255 downto 0);  -- ufix256
        out_unnamed_matrix_multiply1_avm_byteenable : out std_logic_vector(31 downto 0);  -- ufix32
        out_unnamed_matrix_multiply1_avm_burstcount : out std_logic_vector(4 downto 0);  -- ufix5
        in_B : in std_logic_vector(63 downto 0);  -- ufix64
        in_C_value_02 : in std_logic_vector(63 downto 0);  -- float64_m52
        in_acl_hw_wg_id6 : in std_logic_vector(31 downto 0);  -- ufix32
        in_c0_exe11 : in std_logic_vector(31 downto 0);  -- ufix32
        in_global_id_04 : in std_logic_vector(31 downto 0);  -- ufix32
        in_k_03 : in std_logic_vector(31 downto 0);  -- ufix32
        in_valid_in : in std_logic_vector(0 downto 0);  -- ufix1
        out_acl_hw_wg_id6 : out std_logic_vector(31 downto 0);  -- ufix32
        out_c0_exe11 : out std_logic_vector(31 downto 0);  -- ufix32
        out_c0_exe110 : out std_logic_vector(63 downto 0);  -- float64_m52
        out_exitcond_GUARD_GUARD : out std_logic_vector(0 downto 0);  -- ufix1
        out_global_id_04 : out std_logic_vector(31 downto 0);  -- ufix32
        out_inc : out std_logic_vector(31 downto 0);  -- ufix32
        out_valid_out : out std_logic_vector(0 downto 0);  -- ufix1
        in_N : in std_logic_vector(31 downto 0);  -- ufix32
        in_P : in std_logic_vector(31 downto 0);  -- ufix32
        in_flush : in std_logic_vector(0 downto 0);  -- ufix1
        in_unnamed_matrix_multiply0_avm_readdata : in std_logic_vector(255 downto 0);  -- ufix256
        in_unnamed_matrix_multiply0_avm_writeack : in std_logic_vector(0 downto 0);  -- ufix1
        in_unnamed_matrix_multiply0_avm_waitrequest : in std_logic_vector(0 downto 0);  -- ufix1
        in_unnamed_matrix_multiply0_avm_readdatavalid : in std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_matrix_multiply0_avm_address : out std_logic_vector(29 downto 0);  -- ufix30
        out_unnamed_matrix_multiply0_avm_enable : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_matrix_multiply0_avm_read : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_matrix_multiply0_avm_write : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_matrix_multiply0_avm_writedata : out std_logic_vector(255 downto 0);  -- ufix256
        out_unnamed_matrix_multiply0_avm_byteenable : out std_logic_vector(31 downto 0);  -- ufix32
        out_unnamed_matrix_multiply0_avm_burstcount : out std_logic_vector(4 downto 0);  -- ufix5
        in_A : in std_logic_vector(63 downto 0);  -- ufix64
        in_stall_in : in std_logic_vector(0 downto 0);  -- ufix1
        out_stall_out : out std_logic_vector(0 downto 0);  -- ufix1
        clock : in std_logic;
        resetn : in std_logic
    );
end bb_matrix_multiply_B1_stall_region;

architecture normal of bb_matrix_multiply_B1_stall_region is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    component i_sfc_c0_for_body_matrix_multiply_c0_enter6_matrix_multiply is
        port (
            in_c0_eni3_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_c0_eni3_1 : in std_logic_vector(63 downto 0);  -- Floating Point
            in_c0_eni3_2 : in std_logic_vector(63 downto 0);  -- Floating Point
            in_c0_eni3_3 : in std_logic_vector(63 downto 0);  -- Floating Point
            in_i_stall : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_valid : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exit9_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exit9_1 : out std_logic_vector(63 downto 0);  -- Floating Point
            out_o_stall : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_valid : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component matrix_multiply_B1_merge_reg is
        port (
            in_data_in_0 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_data_in_1 : in std_logic_vector(63 downto 0);  -- Floating Point
            in_data_in_2 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_data_in_3 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_data_in_4 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_data_out_0 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_data_out_1 : out std_logic_vector(63 downto 0);  -- Floating Point
            out_data_out_2 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_data_out_3 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_data_out_4 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_load_unnamed_matrix_multiply0_matrix_multiply20 is
        port (
            in_flush : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_address : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_i_predicate : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_stall : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_valid : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_matrix_multiply0_avm_readdata : in std_logic_vector(255 downto 0);  -- Fixed Point
            in_unnamed_matrix_multiply0_avm_readdatavalid : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_matrix_multiply0_avm_waitrequest : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_matrix_multiply0_avm_writeack : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_readdata : out std_logic_vector(63 downto 0);  -- Floating Point
            out_o_stall : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_valid : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply0_avm_address : out std_logic_vector(29 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply0_avm_burstcount : out std_logic_vector(4 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply0_avm_byteenable : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply0_avm_enable : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply0_avm_read : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply0_avm_write : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply0_avm_writedata : out std_logic_vector(255 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_load_unnamed_matrix_multiply1_matrix_multiply22 is
        port (
            in_flush : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_address : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_i_predicate : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_stall : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_valid : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_matrix_multiply1_avm_readdata : in std_logic_vector(255 downto 0);  -- Fixed Point
            in_unnamed_matrix_multiply1_avm_readdatavalid : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_matrix_multiply1_avm_waitrequest : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_matrix_multiply1_avm_writeack : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_readdata : out std_logic_vector(63 downto 0);  -- Floating Point
            out_o_stall : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_valid : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply1_avm_address : out std_logic_vector(29 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply1_avm_burstcount : out std_logic_vector(4 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply1_avm_byteenable : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply1_avm_enable : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply1_avm_read : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply1_avm_write : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply1_avm_writedata : out std_logic_vector(255 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_syncbuf_a_sync_buffer_matrix_multiply5 is
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


    component i_syncbuf_b_sync_buffer_matrix_multiply11 is
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


    component i_syncbuf_n_sync_buffer_matrix_multiply9 is
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


    component i_syncbuf_p_sync_buffer3_matrix_multiply13 is
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


    component i_syncbuf_p_sync_buffer_matrix_multiply7 is
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
    signal bgTrunc_i_add_matrix_multiply_sel_x_b : STD_LOGIC_VECTOR (31 downto 0);
    signal bgTrunc_i_inc_matrix_multiply_sel_x_b : STD_LOGIC_VECTOR (31 downto 0);
    signal i_arrayidx5_matrix_multiply_matrix_multiply17_dupName_0_trunc_sel_x_b : STD_LOGIC_VECTOR (63 downto 0);
    signal i_arrayidx5_matrix_multiply_matrix_multiply17_mult_extender_x_q : STD_LOGIC_VECTOR (127 downto 0);
    signal i_arrayidx5_matrix_multiply_matrix_multiply17_mult_multconst_x_q : STD_LOGIC_VECTOR (59 downto 0);
    signal i_arrayidx5_matrix_multiply_matrix_multiply17_trunc_sel_x_b : STD_LOGIC_VECTOR (63 downto 0);
    signal i_arrayidx5_matrix_multiply_matrix_multiply17_add_x_a : STD_LOGIC_VECTOR (64 downto 0);
    signal i_arrayidx5_matrix_multiply_matrix_multiply17_add_x_b : STD_LOGIC_VECTOR (64 downto 0);
    signal i_arrayidx5_matrix_multiply_matrix_multiply17_add_x_o : STD_LOGIC_VECTOR (64 downto 0);
    signal i_arrayidx5_matrix_multiply_matrix_multiply17_add_x_q : STD_LOGIC_VECTOR (64 downto 0);
    signal i_arrayidx_matrix_multiply_matrix_multiply19_dupName_0_trunc_sel_x_b : STD_LOGIC_VECTOR (63 downto 0);
    signal i_arrayidx_matrix_multiply_matrix_multiply19_mult_extender_x_q : STD_LOGIC_VECTOR (127 downto 0);
    signal i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b : STD_LOGIC_VECTOR (63 downto 0);
    signal i_arrayidx_matrix_multiply_matrix_multiply19_add_x_a : STD_LOGIC_VECTOR (64 downto 0);
    signal i_arrayidx_matrix_multiply_matrix_multiply19_add_x_b : STD_LOGIC_VECTOR (64 downto 0);
    signal i_arrayidx_matrix_multiply_matrix_multiply19_add_x_o : STD_LOGIC_VECTOR (64 downto 0);
    signal i_arrayidx_matrix_multiply_matrix_multiply19_add_x_q : STD_LOGIC_VECTOR (64 downto 0);
    signal i_idxprom4_matrix_multiply_sel_x_b : STD_LOGIC_VECTOR (63 downto 0);
    signal i_idxprom_matrix_multiply_sel_x_b : STD_LOGIC_VECTOR (63 downto 0);
    signal i_sfc_c0_for_body_matrix_multiply_c0_enter6_matrix_multiply_aunroll_x_out_c0_exit9_1 : STD_LOGIC_VECTOR (63 downto 0);
    signal i_sfc_c0_for_body_matrix_multiply_c0_enter6_matrix_multiply_aunroll_x_out_o_stall : STD_LOGIC_VECTOR (0 downto 0);
    signal i_sfc_c0_for_body_matrix_multiply_c0_enter6_matrix_multiply_aunroll_x_out_o_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0 : STD_LOGIC_VECTOR (31 downto 0);
    signal matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1 : STD_LOGIC_VECTOR (63 downto 0);
    signal matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_2 : STD_LOGIC_VECTOR (31 downto 0);
    signal matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_3 : STD_LOGIC_VECTOR (31 downto 0);
    signal matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_4 : STD_LOGIC_VECTOR (31 downto 0);
    signal matrix_multiply_B1_merge_reg_aunroll_x_out_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal matrix_multiply_B1_merge_reg_aunroll_x_out_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal c_i32_1gr_q : STD_LOGIC_VECTOR (31 downto 0);
    signal i_add_matrix_multiply_a : STD_LOGIC_VECTOR (32 downto 0);
    signal i_add_matrix_multiply_b : STD_LOGIC_VECTOR (32 downto 0);
    signal i_add_matrix_multiply_o : STD_LOGIC_VECTOR (32 downto 0);
    signal i_add_matrix_multiply_q : STD_LOGIC_VECTOR (32 downto 0);
    signal i_cmp21_neg_rm_matrix_multiply_a : STD_LOGIC_VECTOR (33 downto 0);
    signal i_cmp21_neg_rm_matrix_multiply_b : STD_LOGIC_VECTOR (33 downto 0);
    signal i_cmp21_neg_rm_matrix_multiply_o : STD_LOGIC_VECTOR (33 downto 0);
    signal i_cmp21_neg_rm_matrix_multiply_c : STD_LOGIC_VECTOR (0 downto 0);
    signal i_cmp_neg_or_rm_matrix_multiply_q : STD_LOGIC_VECTOR (0 downto 0);
    signal i_cmp_neg_rm_matrix_multiply_a : STD_LOGIC_VECTOR (33 downto 0);
    signal i_cmp_neg_rm_matrix_multiply_b : STD_LOGIC_VECTOR (33 downto 0);
    signal i_cmp_neg_rm_matrix_multiply_o : STD_LOGIC_VECTOR (33 downto 0);
    signal i_cmp_neg_rm_matrix_multiply_n : STD_LOGIC_VECTOR (0 downto 0);
    signal i_exitcond_guard_guard_matrix_multiply_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal i_exitcond_guard_guard_matrix_multiply_q : STD_LOGIC_VECTOR (0 downto 0);
    signal i_exitcond_guard_matrix_multiply_q : STD_LOGIC_VECTOR (0 downto 0);
    signal i_inc_matrix_multiply_a : STD_LOGIC_VECTOR (32 downto 0);
    signal i_inc_matrix_multiply_b : STD_LOGIC_VECTOR (32 downto 0);
    signal i_inc_matrix_multiply_o : STD_LOGIC_VECTOR (32 downto 0);
    signal i_inc_matrix_multiply_q : STD_LOGIC_VECTOR (32 downto 0);
    signal i_load_unnamed_matrix_multiply0_matrix_multiply_out_o_readdata : STD_LOGIC_VECTOR (63 downto 0);
    signal i_load_unnamed_matrix_multiply0_matrix_multiply_out_o_stall : STD_LOGIC_VECTOR (0 downto 0);
    signal i_load_unnamed_matrix_multiply0_matrix_multiply_out_o_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal i_load_unnamed_matrix_multiply0_matrix_multiply_out_unnamed_matrix_multiply0_avm_address : STD_LOGIC_VECTOR (29 downto 0);
    signal i_load_unnamed_matrix_multiply0_matrix_multiply_out_unnamed_matrix_multiply0_avm_burstcount : STD_LOGIC_VECTOR (4 downto 0);
    signal i_load_unnamed_matrix_multiply0_matrix_multiply_out_unnamed_matrix_multiply0_avm_byteenable : STD_LOGIC_VECTOR (31 downto 0);
    signal i_load_unnamed_matrix_multiply0_matrix_multiply_out_unnamed_matrix_multiply0_avm_enable : STD_LOGIC_VECTOR (0 downto 0);
    signal i_load_unnamed_matrix_multiply0_matrix_multiply_out_unnamed_matrix_multiply0_avm_read : STD_LOGIC_VECTOR (0 downto 0);
    signal i_load_unnamed_matrix_multiply0_matrix_multiply_out_unnamed_matrix_multiply0_avm_write : STD_LOGIC_VECTOR (0 downto 0);
    signal i_load_unnamed_matrix_multiply0_matrix_multiply_out_unnamed_matrix_multiply0_avm_writedata : STD_LOGIC_VECTOR (255 downto 0);
    signal i_load_unnamed_matrix_multiply1_matrix_multiply_out_o_readdata : STD_LOGIC_VECTOR (63 downto 0);
    signal i_load_unnamed_matrix_multiply1_matrix_multiply_out_o_stall : STD_LOGIC_VECTOR (0 downto 0);
    signal i_load_unnamed_matrix_multiply1_matrix_multiply_out_o_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal i_load_unnamed_matrix_multiply1_matrix_multiply_out_unnamed_matrix_multiply1_avm_address : STD_LOGIC_VECTOR (29 downto 0);
    signal i_load_unnamed_matrix_multiply1_matrix_multiply_out_unnamed_matrix_multiply1_avm_burstcount : STD_LOGIC_VECTOR (4 downto 0);
    signal i_load_unnamed_matrix_multiply1_matrix_multiply_out_unnamed_matrix_multiply1_avm_byteenable : STD_LOGIC_VECTOR (31 downto 0);
    signal i_load_unnamed_matrix_multiply1_matrix_multiply_out_unnamed_matrix_multiply1_avm_enable : STD_LOGIC_VECTOR (0 downto 0);
    signal i_load_unnamed_matrix_multiply1_matrix_multiply_out_unnamed_matrix_multiply1_avm_read : STD_LOGIC_VECTOR (0 downto 0);
    signal i_load_unnamed_matrix_multiply1_matrix_multiply_out_unnamed_matrix_multiply1_avm_write : STD_LOGIC_VECTOR (0 downto 0);
    signal i_load_unnamed_matrix_multiply1_matrix_multiply_out_unnamed_matrix_multiply1_avm_writedata : STD_LOGIC_VECTOR (255 downto 0);
    signal i_syncbuf_a_sync_buffer_matrix_multiply_out_buffer_out : STD_LOGIC_VECTOR (63 downto 0);
    signal i_syncbuf_a_sync_buffer_matrix_multiply_out_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_syncbuf_a_sync_buffer_matrix_multiply_out_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_syncbuf_b_sync_buffer_matrix_multiply_out_buffer_out : STD_LOGIC_VECTOR (63 downto 0);
    signal i_syncbuf_b_sync_buffer_matrix_multiply_out_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_syncbuf_b_sync_buffer_matrix_multiply_out_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_syncbuf_n_sync_buffer_matrix_multiply_out_buffer_out : STD_LOGIC_VECTOR (31 downto 0);
    signal i_syncbuf_n_sync_buffer_matrix_multiply_out_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_syncbuf_n_sync_buffer_matrix_multiply_out_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_syncbuf_p_sync_buffer3_matrix_multiply_out_buffer_out : STD_LOGIC_VECTOR (31 downto 0);
    signal i_syncbuf_p_sync_buffer3_matrix_multiply_out_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_syncbuf_p_sync_buffer3_matrix_multiply_out_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_syncbuf_p_sync_buffer_matrix_multiply_out_buffer_out : STD_LOGIC_VECTOR (31 downto 0);
    signal i_syncbuf_p_sync_buffer_matrix_multiply_out_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_syncbuf_p_sync_buffer_matrix_multiply_out_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_align_12_q : STD_LOGIC_VECTOR (35 downto 0);
    signal i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_align_12_qint : STD_LOGIC_VECTOR (35 downto 0);
    signal i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_join_13_q : STD_LOGIC_VECTOR (57 downto 0);
    signal i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_align_14_q : STD_LOGIC_VECTOR (39 downto 0);
    signal i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_align_14_qint : STD_LOGIC_VECTOR (39 downto 0);
    signal i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_align_15_q : STD_LOGIC_VECTOR (27 downto 0);
    signal i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_align_15_qint : STD_LOGIC_VECTOR (27 downto 0);
    signal i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_join_16_q : STD_LOGIC_VECTOR (67 downto 0);
    signal i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_result_add_0_0_a : STD_LOGIC_VECTOR (68 downto 0);
    signal i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_result_add_0_0_b : STD_LOGIC_VECTOR (68 downto 0);
    signal i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_result_add_0_0_o : STD_LOGIC_VECTOR (68 downto 0);
    signal i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_result_add_0_0_q : STD_LOGIC_VECTOR (68 downto 0);
    signal i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_align_12_q : STD_LOGIC_VECTOR (35 downto 0);
    signal i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_align_12_qint : STD_LOGIC_VECTOR (35 downto 0);
    signal i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_join_13_q : STD_LOGIC_VECTOR (57 downto 0);
    signal i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_align_14_q : STD_LOGIC_VECTOR (39 downto 0);
    signal i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_align_14_qint : STD_LOGIC_VECTOR (39 downto 0);
    signal i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_align_15_q : STD_LOGIC_VECTOR (27 downto 0);
    signal i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_align_15_qint : STD_LOGIC_VECTOR (27 downto 0);
    signal i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_join_16_q : STD_LOGIC_VECTOR (67 downto 0);
    signal i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_result_add_0_0_a : STD_LOGIC_VECTOR (68 downto 0);
    signal i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_result_add_0_0_b : STD_LOGIC_VECTOR (68 downto 0);
    signal i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_result_add_0_0_o : STD_LOGIC_VECTOR (68 downto 0);
    signal i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_result_add_0_0_q : STD_LOGIC_VECTOR (68 downto 0);
    signal x0_uid133_i_exitcond_matrix_multiply_in : STD_LOGIC_VECTOR (15 downto 0);
    signal x0_uid133_i_exitcond_matrix_multiply_b : STD_LOGIC_VECTOR (15 downto 0);
    signal y0_uid134_i_exitcond_matrix_multiply_in : STD_LOGIC_VECTOR (15 downto 0);
    signal y0_uid134_i_exitcond_matrix_multiply_b : STD_LOGIC_VECTOR (15 downto 0);
    signal eq0_uid135_i_exitcond_matrix_multiply_q : STD_LOGIC_VECTOR (0 downto 0);
    signal x1_uid136_i_exitcond_matrix_multiply_b : STD_LOGIC_VECTOR (15 downto 0);
    signal y1_uid137_i_exitcond_matrix_multiply_b : STD_LOGIC_VECTOR (15 downto 0);
    signal eq1_uid138_i_exitcond_matrix_multiply_q : STD_LOGIC_VECTOR (0 downto 0);
    signal andEq_uid139_i_exitcond_matrix_multiply_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal andEq_uid139_i_exitcond_matrix_multiply_q : STD_LOGIC_VECTOR (0 downto 0);
    signal i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_im0_shift0_q : STD_LOGIC_VECTOR (20 downto 0);
    signal i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_im0_shift0_qint : STD_LOGIC_VECTOR (20 downto 0);
    signal i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_im3_shift0_q : STD_LOGIC_VECTOR (12 downto 0);
    signal i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_im3_shift0_qint : STD_LOGIC_VECTOR (12 downto 0);
    signal i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_im6_shift0_q : STD_LOGIC_VECTOR (20 downto 0);
    signal i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_im6_shift0_qint : STD_LOGIC_VECTOR (20 downto 0);
    signal i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_im9_shift0_q : STD_LOGIC_VECTOR (20 downto 0);
    signal i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_im9_shift0_qint : STD_LOGIC_VECTOR (20 downto 0);
    signal i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_im0_shift0_q : STD_LOGIC_VECTOR (20 downto 0);
    signal i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_im0_shift0_qint : STD_LOGIC_VECTOR (20 downto 0);
    signal i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_im3_shift0_q : STD_LOGIC_VECTOR (12 downto 0);
    signal i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_im3_shift0_qint : STD_LOGIC_VECTOR (12 downto 0);
    signal i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_im6_shift0_q : STD_LOGIC_VECTOR (20 downto 0);
    signal i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_im6_shift0_qint : STD_LOGIC_VECTOR (20 downto 0);
    signal i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_im9_shift0_q : STD_LOGIC_VECTOR (20 downto 0);
    signal i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_im9_shift0_qint : STD_LOGIC_VECTOR (20 downto 0);
    signal i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_bs1_merged_bit_select_b : STD_LOGIC_VECTOR (17 downto 0);
    signal i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_bs1_merged_bit_select_c : STD_LOGIC_VECTOR (9 downto 0);
    signal i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_bs1_merged_bit_select_d : STD_LOGIC_VECTOR (17 downto 0);
    signal i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_bs1_merged_bit_select_e : STD_LOGIC_VECTOR (17 downto 0);
    signal i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_bs1_merged_bit_select_b : STD_LOGIC_VECTOR (17 downto 0);
    signal i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_bs1_merged_bit_select_c : STD_LOGIC_VECTOR (9 downto 0);
    signal i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_bs1_merged_bit_select_d : STD_LOGIC_VECTOR (17 downto 0);
    signal i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_bs1_merged_bit_select_e : STD_LOGIC_VECTOR (17 downto 0);
    signal redist0_i_exitcond_guard_guard_matrix_multiply_q_167_fifo_valid_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_i_exitcond_guard_guard_matrix_multiply_q_167_fifo_valid_in_bitsignaltemp : std_logic;
    signal redist0_i_exitcond_guard_guard_matrix_multiply_q_167_fifo_stall_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_i_exitcond_guard_guard_matrix_multiply_q_167_fifo_stall_in_bitsignaltemp : std_logic;
    signal redist0_i_exitcond_guard_guard_matrix_multiply_q_167_fifo_data_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_i_exitcond_guard_guard_matrix_multiply_q_167_fifo_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_i_exitcond_guard_guard_matrix_multiply_q_167_fifo_valid_out_bitsignaltemp : std_logic;
    signal redist0_i_exitcond_guard_guard_matrix_multiply_q_167_fifo_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_i_exitcond_guard_guard_matrix_multiply_q_167_fifo_stall_out_bitsignaltemp : std_logic;
    signal redist0_i_exitcond_guard_guard_matrix_multiply_q_167_fifo_data_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_valid_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_valid_in_bitsignaltemp : std_logic;
    signal redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_stall_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_stall_in_bitsignaltemp : std_logic;
    signal redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_data_in : STD_LOGIC_VECTOR (63 downto 0);
    signal redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_valid_out_bitsignaltemp : std_logic;
    signal redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_stall_out_bitsignaltemp : std_logic;
    signal redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_data_out : STD_LOGIC_VECTOR (63 downto 0);
    signal redist5_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_2_170_fifo_valid_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist5_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_2_170_fifo_valid_in_bitsignaltemp : std_logic;
    signal redist5_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_2_170_fifo_stall_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist5_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_2_170_fifo_stall_in_bitsignaltemp : std_logic;
    signal redist5_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_2_170_fifo_data_in : STD_LOGIC_VECTOR (31 downto 0);
    signal redist5_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_2_170_fifo_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist5_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_2_170_fifo_valid_out_bitsignaltemp : std_logic;
    signal redist5_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_2_170_fifo_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist5_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_2_170_fifo_stall_out_bitsignaltemp : std_logic;
    signal redist5_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_2_170_fifo_data_out : STD_LOGIC_VECTOR (31 downto 0);
    signal redist6_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_3_1_0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist7_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_3_170_fifo_valid_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist7_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_3_170_fifo_valid_in_bitsignaltemp : std_logic;
    signal redist7_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_3_170_fifo_stall_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist7_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_3_170_fifo_stall_in_bitsignaltemp : std_logic;
    signal redist7_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_3_170_fifo_data_in : STD_LOGIC_VECTOR (31 downto 0);
    signal redist7_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_3_170_fifo_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist7_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_3_170_fifo_valid_out_bitsignaltemp : std_logic;
    signal redist7_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_3_170_fifo_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist7_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_3_170_fifo_stall_out_bitsignaltemp : std_logic;
    signal redist7_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_3_170_fifo_data_out : STD_LOGIC_VECTOR (31 downto 0);
    signal redist8_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_4_170_fifo_valid_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist8_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_4_170_fifo_valid_in_bitsignaltemp : std_logic;
    signal redist8_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_4_170_fifo_stall_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist8_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_4_170_fifo_stall_in_bitsignaltemp : std_logic;
    signal redist8_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_4_170_fifo_data_in : STD_LOGIC_VECTOR (31 downto 0);
    signal redist8_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_4_170_fifo_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist8_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_4_170_fifo_valid_out_bitsignaltemp : std_logic;
    signal redist8_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_4_170_fifo_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist8_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_4_170_fifo_stall_out_bitsignaltemp : std_logic;
    signal redist8_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_4_170_fifo_data_out : STD_LOGIC_VECTOR (31 downto 0);
    signal redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_q : STD_LOGIC_VECTOR (63 downto 0);
    signal redist10_i_arrayidx5_matrix_multiply_matrix_multiply17_trunc_sel_x_b_1_0_q : STD_LOGIC_VECTOR (63 downto 0);
    signal redist11_bgTrunc_i_inc_matrix_multiply_sel_x_b_1_0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist12_bgTrunc_i_inc_matrix_multiply_sel_x_b_169_fifo_valid_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist12_bgTrunc_i_inc_matrix_multiply_sel_x_b_169_fifo_valid_in_bitsignaltemp : std_logic;
    signal redist12_bgTrunc_i_inc_matrix_multiply_sel_x_b_169_fifo_stall_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist12_bgTrunc_i_inc_matrix_multiply_sel_x_b_169_fifo_stall_in_bitsignaltemp : std_logic;
    signal redist12_bgTrunc_i_inc_matrix_multiply_sel_x_b_169_fifo_data_in : STD_LOGIC_VECTOR (31 downto 0);
    signal redist12_bgTrunc_i_inc_matrix_multiply_sel_x_b_169_fifo_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist12_bgTrunc_i_inc_matrix_multiply_sel_x_b_169_fifo_valid_out_bitsignaltemp : std_logic;
    signal redist12_bgTrunc_i_inc_matrix_multiply_sel_x_b_169_fifo_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist12_bgTrunc_i_inc_matrix_multiply_sel_x_b_169_fifo_stall_out_bitsignaltemp : std_logic;
    signal redist12_bgTrunc_i_inc_matrix_multiply_sel_x_b_169_fifo_data_out : STD_LOGIC_VECTOR (31 downto 0);
    signal redist13_bgTrunc_i_add_matrix_multiply_sel_x_b_1_0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_join_i_sfc_c0_for_body_matrix_multiply_c0_enter6_matrix_multiply_aunroll_x_q : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_select_i_sfc_c0_for_body_matrix_multiply_c0_enter6_matrix_multiply_aunroll_x_b : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_join_matrix_multiply_B1_merge_reg_aunroll_x_q : STD_LOGIC_VECTOR (191 downto 0);
    signal bubble_select_matrix_multiply_B1_merge_reg_aunroll_x_b : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_matrix_multiply_B1_merge_reg_aunroll_x_c : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_select_matrix_multiply_B1_merge_reg_aunroll_x_d : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_matrix_multiply_B1_merge_reg_aunroll_x_e : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_matrix_multiply_B1_merge_reg_aunroll_x_f : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_join_i_load_unnamed_matrix_multiply0_matrix_multiply_q : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_select_i_load_unnamed_matrix_multiply0_matrix_multiply_b : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_join_i_load_unnamed_matrix_multiply1_matrix_multiply_q : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_select_i_load_unnamed_matrix_multiply1_matrix_multiply_b : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_join_i_syncbuf_a_sync_buffer_matrix_multiply_q : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_select_i_syncbuf_a_sync_buffer_matrix_multiply_b : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_join_i_syncbuf_b_sync_buffer_matrix_multiply_q : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_select_i_syncbuf_b_sync_buffer_matrix_multiply_b : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_join_i_syncbuf_n_sync_buffer_matrix_multiply_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_i_syncbuf_n_sync_buffer_matrix_multiply_b : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_join_i_syncbuf_p_sync_buffer3_matrix_multiply_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_i_syncbuf_p_sync_buffer3_matrix_multiply_b : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_join_i_syncbuf_p_sync_buffer_matrix_multiply_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_i_syncbuf_p_sync_buffer_matrix_multiply_b : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_join_stall_entry_q : STD_LOGIC_VECTOR (191 downto 0);
    signal bubble_select_stall_entry_b : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_select_stall_entry_c : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_stall_entry_d : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_stall_entry_e : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_stall_entry_f : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_join_redist0_i_exitcond_guard_guard_matrix_multiply_q_167_fifo_q : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_select_redist0_i_exitcond_guard_guard_matrix_multiply_q_167_fifo_b : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_join_redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_q : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_select_redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_b : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_join_redist5_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_2_170_fifo_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_redist5_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_2_170_fifo_b : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_join_redist7_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_3_170_fifo_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_redist7_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_3_170_fifo_b : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_join_redist8_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_4_170_fifo_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_redist8_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_4_170_fifo_b : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_join_redist12_bgTrunc_i_inc_matrix_multiply_sel_x_b_169_fifo_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_redist12_bgTrunc_i_inc_matrix_multiply_sel_x_b_169_fifo_b : STD_LOGIC_VECTOR (31 downto 0);
    signal SE_out_matrix_multiply_B1_merge_reg_aunroll_x_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_matrix_multiply_B1_merge_reg_aunroll_x_wireStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_matrix_multiply_B1_merge_reg_aunroll_x_StallValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_matrix_multiply_B1_merge_reg_aunroll_x_toReg0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_matrix_multiply_B1_merge_reg_aunroll_x_fromReg0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_matrix_multiply_B1_merge_reg_aunroll_x_consumed0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_matrix_multiply_B1_merge_reg_aunroll_x_toReg1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_matrix_multiply_B1_merge_reg_aunroll_x_fromReg1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_matrix_multiply_B1_merge_reg_aunroll_x_consumed1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_matrix_multiply_B1_merge_reg_aunroll_x_toReg2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_matrix_multiply_B1_merge_reg_aunroll_x_fromReg2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_matrix_multiply_B1_merge_reg_aunroll_x_consumed2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_matrix_multiply_B1_merge_reg_aunroll_x_toReg3 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_matrix_multiply_B1_merge_reg_aunroll_x_fromReg3 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_matrix_multiply_B1_merge_reg_aunroll_x_consumed3 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_matrix_multiply_B1_merge_reg_aunroll_x_toReg4 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_matrix_multiply_B1_merge_reg_aunroll_x_fromReg4 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_matrix_multiply_B1_merge_reg_aunroll_x_consumed4 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_matrix_multiply_B1_merge_reg_aunroll_x_toReg5 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_matrix_multiply_B1_merge_reg_aunroll_x_fromReg5 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_matrix_multiply_B1_merge_reg_aunroll_x_consumed5 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_matrix_multiply_B1_merge_reg_aunroll_x_toReg6 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_matrix_multiply_B1_merge_reg_aunroll_x_fromReg6 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_matrix_multiply_B1_merge_reg_aunroll_x_consumed6 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_matrix_multiply_B1_merge_reg_aunroll_x_or0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_matrix_multiply_B1_merge_reg_aunroll_x_or1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_matrix_multiply_B1_merge_reg_aunroll_x_or2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_matrix_multiply_B1_merge_reg_aunroll_x_or3 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_matrix_multiply_B1_merge_reg_aunroll_x_or4 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_matrix_multiply_B1_merge_reg_aunroll_x_or5 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_matrix_multiply_B1_merge_reg_aunroll_x_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_matrix_multiply_B1_merge_reg_aunroll_x_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_matrix_multiply_B1_merge_reg_aunroll_x_V1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_matrix_multiply_B1_merge_reg_aunroll_x_V2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_matrix_multiply_B1_merge_reg_aunroll_x_V3 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_matrix_multiply_B1_merge_reg_aunroll_x_V4 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_matrix_multiply_B1_merge_reg_aunroll_x_V5 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_matrix_multiply_B1_merge_reg_aunroll_x_V6 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp21_neg_rm_matrix_multiply_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp21_neg_rm_matrix_multiply_R_v_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp21_neg_rm_matrix_multiply_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp21_neg_rm_matrix_multiply_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp21_neg_rm_matrix_multiply_s_tv_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp21_neg_rm_matrix_multiply_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp21_neg_rm_matrix_multiply_or0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp21_neg_rm_matrix_multiply_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp21_neg_rm_matrix_multiply_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp21_neg_rm_matrix_multiply_V1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp_neg_or_rm_matrix_multiply_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp_neg_or_rm_matrix_multiply_wireStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp_neg_or_rm_matrix_multiply_StallValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp_neg_or_rm_matrix_multiply_toReg0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp_neg_or_rm_matrix_multiply_fromReg0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp_neg_or_rm_matrix_multiply_consumed0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp_neg_or_rm_matrix_multiply_toReg1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp_neg_or_rm_matrix_multiply_fromReg1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp_neg_or_rm_matrix_multiply_consumed1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp_neg_or_rm_matrix_multiply_and0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp_neg_or_rm_matrix_multiply_or0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp_neg_or_rm_matrix_multiply_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp_neg_or_rm_matrix_multiply_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp_neg_or_rm_matrix_multiply_V1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp_neg_rm_matrix_multiply_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp_neg_rm_matrix_multiply_R_v_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp_neg_rm_matrix_multiply_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp_neg_rm_matrix_multiply_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp_neg_rm_matrix_multiply_s_tv_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp_neg_rm_matrix_multiply_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp_neg_rm_matrix_multiply_or0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp_neg_rm_matrix_multiply_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp_neg_rm_matrix_multiply_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_cmp_neg_rm_matrix_multiply_V1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_exitcond_guard_guard_matrix_multiply_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_exitcond_guard_guard_matrix_multiply_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_exitcond_guard_guard_matrix_multiply_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_exitcond_guard_guard_matrix_multiply_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_exitcond_guard_guard_matrix_multiply_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_exitcond_guard_guard_matrix_multiply_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_exitcond_guard_matrix_multiply_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_exitcond_guard_matrix_multiply_and0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_exitcond_guard_matrix_multiply_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_i_exitcond_guard_matrix_multiply_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_n_sync_buffer_matrix_multiply_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_n_sync_buffer_matrix_multiply_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_n_sync_buffer_matrix_multiply_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_wireStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_StallValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_toReg0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_fromReg0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_consumed0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_toReg1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_fromReg1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_consumed1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_or0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_V1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_p_sync_buffer_matrix_multiply_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_p_sync_buffer_matrix_multiply_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_p_sync_buffer_matrix_multiply_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_y0_uid134_i_exitcond_matrix_multiply_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_y0_uid134_i_exitcond_matrix_multiply_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_y0_uid134_i_exitcond_matrix_multiply_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_andEq_uid139_i_exitcond_matrix_multiply_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_andEq_uid139_i_exitcond_matrix_multiply_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_andEq_uid139_i_exitcond_matrix_multiply_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_andEq_uid139_i_exitcond_matrix_multiply_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_andEq_uid139_i_exitcond_matrix_multiply_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_andEq_uid139_i_exitcond_matrix_multiply_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_R_v_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_R_v_2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_R_v_3 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_R_v_4 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_s_tv_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_s_tv_2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_s_tv_3 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_s_tv_4 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_or0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_or1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_or2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_or3 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_V1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_V2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_V3 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_V4 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_and0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_and1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_R_v_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_R_v_2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_R_v_3 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_s_tv_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_s_tv_2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_s_tv_3 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_or0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_or1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_or2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_V1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_V2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_V3 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_1_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_1_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_1_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_4_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_4_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_4_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_5_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_5_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_5_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_and0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_and1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_and2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_and3 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_and4 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_and5 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_1_reg_valid_in : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_1_reg_valid_in_bitsignaltemp : std_logic;
    signal bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_1_reg_stall_in : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_1_reg_stall_in_bitsignaltemp : std_logic;
    signal bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_1_reg_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_1_reg_valid_out_bitsignaltemp : std_logic;
    signal bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_1_reg_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_1_reg_stall_out_bitsignaltemp : std_logic;
    signal bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_4_reg_valid_in : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_4_reg_valid_in_bitsignaltemp : std_logic;
    signal bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_4_reg_stall_in : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_4_reg_stall_in_bitsignaltemp : std_logic;
    signal bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_4_reg_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_4_reg_valid_out_bitsignaltemp : std_logic;
    signal bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_4_reg_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_4_reg_stall_out_bitsignaltemp : std_logic;
    signal bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_5_reg_valid_in : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_5_reg_valid_in_bitsignaltemp : std_logic;
    signal bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_5_reg_stall_in : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_5_reg_stall_in_bitsignaltemp : std_logic;
    signal bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_5_reg_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_5_reg_valid_out_bitsignaltemp : std_logic;
    signal bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_5_reg_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_5_reg_stall_out_bitsignaltemp : std_logic;
    signal bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_reg_valid_in : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_reg_valid_in_bitsignaltemp : std_logic;
    signal bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_reg_stall_in : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_reg_stall_in_bitsignaltemp : std_logic;
    signal bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_reg_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_reg_valid_out_bitsignaltemp : std_logic;
    signal bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_reg_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_reg_stall_out_bitsignaltemp : std_logic;
    signal SR_SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_i_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_r_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_r_data0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_r_data1 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_r_data2 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_V : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_D0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_D1 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_D2 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_i_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_r_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_r_data0 : STD_LOGIC_VECTOR (63 downto 0);
    signal SR_SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_r_data1 : STD_LOGIC_VECTOR (63 downto 0);
    signal SR_SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_r_data2 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_V : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_D0 : STD_LOGIC_VECTOR (63 downto 0);
    signal SR_SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_D1 : STD_LOGIC_VECTOR (63 downto 0);
    signal SR_SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_D2 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_y0_uid134_i_exitcond_matrix_multiply_i_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_y0_uid134_i_exitcond_matrix_multiply_r_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_y0_uid134_i_exitcond_matrix_multiply_and0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_y0_uid134_i_exitcond_matrix_multiply_r_data0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_y0_uid134_i_exitcond_matrix_multiply_r_data1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_y0_uid134_i_exitcond_matrix_multiply_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_y0_uid134_i_exitcond_matrix_multiply_V : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_y0_uid134_i_exitcond_matrix_multiply_D0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_y0_uid134_i_exitcond_matrix_multiply_D1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_i_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_r_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_r_data0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_V : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_D0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_cmp_neg_rm_matrix_multiply_i_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_cmp_neg_rm_matrix_multiply_r_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_cmp_neg_rm_matrix_multiply_and0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_cmp_neg_rm_matrix_multiply_r_data0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_i_cmp_neg_rm_matrix_multiply_r_data1 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_i_cmp_neg_rm_matrix_multiply_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_cmp_neg_rm_matrix_multiply_V : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_cmp_neg_rm_matrix_multiply_D0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_i_cmp_neg_rm_matrix_multiply_D1 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_i_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_r_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_r_data0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_V : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_D0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_exitcond_guard_guard_matrix_multiply_i_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_exitcond_guard_guard_matrix_multiply_r_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_exitcond_guard_guard_matrix_multiply_and0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_exitcond_guard_guard_matrix_multiply_r_data0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_exitcond_guard_guard_matrix_multiply_r_data1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_exitcond_guard_guard_matrix_multiply_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_exitcond_guard_guard_matrix_multiply_V : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_exitcond_guard_guard_matrix_multiply_D0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_i_exitcond_guard_guard_matrix_multiply_D1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_i_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_r_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_and0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_and1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_r_data0 : STD_LOGIC_VECTOR (63 downto 0);
    signal SR_SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_r_data1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_V : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_D0 : STD_LOGIC_VECTOR (63 downto 0);
    signal SR_SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_D1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_i_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_r_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_and0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_and1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_r_data0 : STD_LOGIC_VECTOR (63 downto 0);
    signal SR_SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_r_data1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_V : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_D0 : STD_LOGIC_VECTOR (63 downto 0);
    signal SR_SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_D1 : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- SE_out_i_syncbuf_a_sync_buffer_matrix_multiply(STALLENABLE,263)
    -- Valid signal propagation
    SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_V0 <= SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_wireValid;
    -- Backward Stall generation
    SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_backStall <= i_load_unnamed_matrix_multiply1_matrix_multiply_out_o_stall or not (SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_wireValid);
    -- Computing multiple Valid(s)
    SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_wireValid <= SR_SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_V;

    -- i_syncbuf_n_sync_buffer_matrix_multiply(BLACKBOX,77)@2
    -- in in_stall_in@20000000
    -- out out_stall_out@20000000
    thei_syncbuf_n_sync_buffer_matrix_multiply : i_syncbuf_n_sync_buffer_matrix_multiply9
    PORT MAP (
        in_buffer_in => in_N,
        in_i_dependence => GND_q,
        in_stall_in => SE_out_i_syncbuf_n_sync_buffer_matrix_multiply_backStall,
        in_valid_in => SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_V3,
        out_buffer_out => i_syncbuf_n_sync_buffer_matrix_multiply_out_buffer_out,
        out_stall_out => i_syncbuf_n_sync_buffer_matrix_multiply_out_stall_out,
        out_valid_out => i_syncbuf_n_sync_buffer_matrix_multiply_out_valid_out,
        clock => clock,
        resetn => resetn
    );

    -- bubble_join_i_syncbuf_n_sync_buffer_matrix_multiply(BITJOIN,204)
    bubble_join_i_syncbuf_n_sync_buffer_matrix_multiply_q <= i_syncbuf_n_sync_buffer_matrix_multiply_out_buffer_out;

    -- bubble_select_i_syncbuf_n_sync_buffer_matrix_multiply(BITSELECT,205)
    bubble_select_i_syncbuf_n_sync_buffer_matrix_multiply_b <= STD_LOGIC_VECTOR(bubble_join_i_syncbuf_n_sync_buffer_matrix_multiply_q(31 downto 0));

    -- i_add_matrix_multiply(ADD,61)@1
    i_add_matrix_multiply_a <= STD_LOGIC_VECTOR("0" & bubble_select_matrix_multiply_B1_merge_reg_aunroll_x_b);
    i_add_matrix_multiply_b <= STD_LOGIC_VECTOR("0" & bubble_select_matrix_multiply_B1_merge_reg_aunroll_x_d);
    i_add_matrix_multiply_o <= STD_LOGIC_VECTOR(UNSIGNED(i_add_matrix_multiply_a) + UNSIGNED(i_add_matrix_multiply_b));
    i_add_matrix_multiply_q <= i_add_matrix_multiply_o(32 downto 0);

    -- bgTrunc_i_add_matrix_multiply_sel_x(BITSELECT,2)@1
    bgTrunc_i_add_matrix_multiply_sel_x_b <= i_add_matrix_multiply_q(31 downto 0);

    -- SE_stall_entry(STALLENABLE,272)
    -- Valid signal propagation
    SE_stall_entry_V0 <= SE_stall_entry_wireValid;
    -- Backward Stall generation
    SE_stall_entry_backStall <= matrix_multiply_B1_merge_reg_aunroll_x_out_stall_out or not (SE_stall_entry_wireValid);
    -- Computing multiple Valid(s)
    SE_stall_entry_wireValid <= in_valid_in;

    -- bubble_join_stall_entry(BITJOIN,214)
    bubble_join_stall_entry_q <= in_k_03 & in_global_id_04 & in_c0_exe11 & in_acl_hw_wg_id6 & in_C_value_02;

    -- bubble_select_stall_entry(BITSELECT,215)
    bubble_select_stall_entry_b <= STD_LOGIC_VECTOR(bubble_join_stall_entry_q(63 downto 0));
    bubble_select_stall_entry_c <= STD_LOGIC_VECTOR(bubble_join_stall_entry_q(95 downto 64));
    bubble_select_stall_entry_d <= STD_LOGIC_VECTOR(bubble_join_stall_entry_q(127 downto 96));
    bubble_select_stall_entry_e <= STD_LOGIC_VECTOR(bubble_join_stall_entry_q(159 downto 128));
    bubble_select_stall_entry_f <= STD_LOGIC_VECTOR(bubble_join_stall_entry_q(191 downto 160));

    -- matrix_multiply_B1_merge_reg_aunroll_x(BLACKBOX,52)@0
    -- in in_stall_in@20000000
    -- out out_data_out_0@1
    -- out out_data_out_1@1
    -- out out_data_out_2@1
    -- out out_data_out_3@1
    -- out out_data_out_4@1
    -- out out_stall_out@20000000
    -- out out_valid_out@1
    thematrix_multiply_B1_merge_reg_aunroll_x : matrix_multiply_B1_merge_reg
    PORT MAP (
        in_data_in_0 => bubble_select_stall_entry_f,
        in_data_in_1 => bubble_select_stall_entry_b,
        in_data_in_2 => bubble_select_stall_entry_d,
        in_data_in_3 => bubble_select_stall_entry_e,
        in_data_in_4 => bubble_select_stall_entry_c,
        in_stall_in => SE_out_matrix_multiply_B1_merge_reg_aunroll_x_backStall,
        in_valid_in => SE_stall_entry_V0,
        out_data_out_0 => matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0,
        out_data_out_1 => matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1,
        out_data_out_2 => matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_2,
        out_data_out_3 => matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_3,
        out_data_out_4 => matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_4,
        out_stall_out => matrix_multiply_B1_merge_reg_aunroll_x_out_stall_out,
        out_valid_out => matrix_multiply_B1_merge_reg_aunroll_x_out_valid_out,
        clock => clock,
        resetn => resetn
    );

    -- bubble_join_matrix_multiply_B1_merge_reg_aunroll_x(BITJOIN,184)
    bubble_join_matrix_multiply_B1_merge_reg_aunroll_x_q <= matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_4 & matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_3 & matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_2 & matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1 & matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0;

    -- bubble_select_matrix_multiply_B1_merge_reg_aunroll_x(BITSELECT,185)
    bubble_select_matrix_multiply_B1_merge_reg_aunroll_x_b <= STD_LOGIC_VECTOR(bubble_join_matrix_multiply_B1_merge_reg_aunroll_x_q(31 downto 0));
    bubble_select_matrix_multiply_B1_merge_reg_aunroll_x_c <= STD_LOGIC_VECTOR(bubble_join_matrix_multiply_B1_merge_reg_aunroll_x_q(95 downto 32));
    bubble_select_matrix_multiply_B1_merge_reg_aunroll_x_d <= STD_LOGIC_VECTOR(bubble_join_matrix_multiply_B1_merge_reg_aunroll_x_q(127 downto 96));
    bubble_select_matrix_multiply_B1_merge_reg_aunroll_x_e <= STD_LOGIC_VECTOR(bubble_join_matrix_multiply_B1_merge_reg_aunroll_x_q(159 downto 128));
    bubble_select_matrix_multiply_B1_merge_reg_aunroll_x_f <= STD_LOGIC_VECTOR(bubble_join_matrix_multiply_B1_merge_reg_aunroll_x_q(191 downto 160));

    -- bubble_join_i_syncbuf_p_sync_buffer3_matrix_multiply(BITJOIN,207)
    bubble_join_i_syncbuf_p_sync_buffer3_matrix_multiply_q <= i_syncbuf_p_sync_buffer3_matrix_multiply_out_buffer_out;

    -- bubble_select_i_syncbuf_p_sync_buffer3_matrix_multiply(BITSELECT,208)
    bubble_select_i_syncbuf_p_sync_buffer3_matrix_multiply_b <= STD_LOGIC_VECTOR(bubble_join_i_syncbuf_p_sync_buffer3_matrix_multiply_q(31 downto 0));

    -- y1_uid137_i_exitcond_matrix_multiply(BITSELECT,136)@3
    y1_uid137_i_exitcond_matrix_multiply_b <= STD_LOGIC_VECTOR(bubble_select_i_syncbuf_p_sync_buffer3_matrix_multiply_b(31 downto 16));

    -- c_i32_1gr(CONSTANT,56)
    c_i32_1gr_q <= "00000000000000000000000000000001";

    -- redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0(REG,168)
    redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_backEN = "1") THEN
                redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_q <= STD_LOGIC_VECTOR(SR_SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_D0);
            END IF;
        END IF;
    END PROCESS;

    -- i_inc_matrix_multiply(ADD,72)@2
    i_inc_matrix_multiply_a <= STD_LOGIC_VECTOR("0" & redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_q);
    i_inc_matrix_multiply_b <= STD_LOGIC_VECTOR("0" & c_i32_1gr_q);
    i_inc_matrix_multiply_o <= STD_LOGIC_VECTOR(UNSIGNED(i_inc_matrix_multiply_a) + UNSIGNED(i_inc_matrix_multiply_b));
    i_inc_matrix_multiply_q <= i_inc_matrix_multiply_o(32 downto 0);

    -- bgTrunc_i_inc_matrix_multiply_sel_x(BITSELECT,3)@2
    bgTrunc_i_inc_matrix_multiply_sel_x_b <= i_inc_matrix_multiply_q(31 downto 0);

    -- i_arrayidx5_matrix_multiply_matrix_multiply17_mult_multconst_x(CONSTANT,33)
    i_arrayidx5_matrix_multiply_matrix_multiply17_mult_multconst_x_q <= "000000000000000000000000000000000000000000000000000000000000";

    -- i_idxprom4_matrix_multiply_sel_x(BITSELECT,49)@2
    i_idxprom4_matrix_multiply_sel_x_b <= STD_LOGIC_VECTOR(std_logic_vector(resize(signed(redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_q(31 downto 0)), 64)));

    -- i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_bs1_merged_bit_select(BITSELECT,149)@2
    i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_bs1_merged_bit_select_b <= i_idxprom4_matrix_multiply_sel_x_b(17 downto 0);
    i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_bs1_merged_bit_select_c <= i_idxprom4_matrix_multiply_sel_x_b(63 downto 54);
    i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_bs1_merged_bit_select_d <= i_idxprom4_matrix_multiply_sel_x_b(35 downto 18);
    i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_bs1_merged_bit_select_e <= i_idxprom4_matrix_multiply_sel_x_b(53 downto 36);

    -- i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_im3_shift0(BITSHIFT,142)@2
    i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_im3_shift0_qint <= i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_bs1_merged_bit_select_c & "000";
    i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_im3_shift0_q <= i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_im3_shift0_qint(12 downto 0);

    -- i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_align_15(BITSHIFT,109)@2
    i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_align_15_qint <= STD_LOGIC_VECTOR("0" & i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_im3_shift0_q) & "00000000000000";
    i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_align_15_q <= i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_align_15_qint(27 downto 0);

    -- i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_im6_shift0(BITSHIFT,143)@2
    i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_im6_shift0_qint <= i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_bs1_merged_bit_select_d & "000";
    i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_im6_shift0_q <= i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_im6_shift0_qint(20 downto 0);

    -- i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_align_14(BITSHIFT,108)@2
    i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_align_14_qint <= STD_LOGIC_VECTOR("0" & i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_im6_shift0_q) & "000000000000000000";
    i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_align_14_q <= i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_align_14_qint(39 downto 0);

    -- i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_join_16(BITJOIN,110)@2
    i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_join_16_q <= i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_align_15_q & i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_align_14_q;

    -- i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_im9_shift0(BITSHIFT,144)@2
    i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_im9_shift0_qint <= i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_bs1_merged_bit_select_e & "000";
    i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_im9_shift0_q <= i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_im9_shift0_qint(20 downto 0);

    -- i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_align_12(BITSHIFT,106)@2
    i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_align_12_qint <= STD_LOGIC_VECTOR("0" & i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_im9_shift0_q) & "00000000000000";
    i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_align_12_q <= i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_align_12_qint(35 downto 0);

    -- i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_im0_shift0(BITSHIFT,141)@2
    i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_im0_shift0_qint <= i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_bs1_merged_bit_select_b & "000";
    i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_im0_shift0_q <= i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_im0_shift0_qint(20 downto 0);

    -- i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_join_13(BITJOIN,107)@2
    i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_join_13_q <= i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_align_12_q & STD_LOGIC_VECTOR("0" & i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_im0_shift0_q);

    -- i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_result_add_0_0(ADD,111)@2
    i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_result_add_0_0_a <= STD_LOGIC_VECTOR("00000000000" & i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_join_13_q);
    i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_result_add_0_0_b <= STD_LOGIC_VECTOR("0" & i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_join_16_q);
    i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_result_add_0_0_o <= STD_LOGIC_VECTOR(UNSIGNED(i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_result_add_0_0_a) + UNSIGNED(i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_result_add_0_0_b));
    i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_result_add_0_0_q <= i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_result_add_0_0_o(68 downto 0);

    -- i_arrayidx5_matrix_multiply_matrix_multiply17_mult_extender_x(BITJOIN,32)@2
    i_arrayidx5_matrix_multiply_matrix_multiply17_mult_extender_x_q <= i_arrayidx5_matrix_multiply_matrix_multiply17_mult_multconst_x_q & i_arrayidx5_matrix_multiply_matrix_multiply17_mult_x_result_add_0_0_q(67 downto 0);

    -- i_arrayidx5_matrix_multiply_matrix_multiply17_trunc_sel_x(BITSELECT,34)@2
    i_arrayidx5_matrix_multiply_matrix_multiply17_trunc_sel_x_b <= i_arrayidx5_matrix_multiply_matrix_multiply17_mult_extender_x_q(63 downto 0);

    -- redist13_bgTrunc_i_add_matrix_multiply_sel_x_b_1_0(REG,178)
    redist13_bgTrunc_i_add_matrix_multiply_sel_x_b_1_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist13_bgTrunc_i_add_matrix_multiply_sel_x_b_1_0_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_backEN = "1") THEN
                redist13_bgTrunc_i_add_matrix_multiply_sel_x_b_1_0_q <= STD_LOGIC_VECTOR(SR_SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_D2);
            END IF;
        END IF;
    END PROCESS;

    -- i_idxprom_matrix_multiply_sel_x(BITSELECT,50)@2
    i_idxprom_matrix_multiply_sel_x_b <= STD_LOGIC_VECTOR(std_logic_vector(resize(signed(redist13_bgTrunc_i_add_matrix_multiply_sel_x_b_1_0_q(31 downto 0)), 64)));

    -- i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_bs1_merged_bit_select(BITSELECT,150)@2
    i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_bs1_merged_bit_select_b <= i_idxprom_matrix_multiply_sel_x_b(17 downto 0);
    i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_bs1_merged_bit_select_c <= i_idxprom_matrix_multiply_sel_x_b(63 downto 54);
    i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_bs1_merged_bit_select_d <= i_idxprom_matrix_multiply_sel_x_b(35 downto 18);
    i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_bs1_merged_bit_select_e <= i_idxprom_matrix_multiply_sel_x_b(53 downto 36);

    -- i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_im3_shift0(BITSHIFT,146)@2
    i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_im3_shift0_qint <= i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_bs1_merged_bit_select_c & "000";
    i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_im3_shift0_q <= i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_im3_shift0_qint(12 downto 0);

    -- i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_align_15(BITSHIFT,127)@2
    i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_align_15_qint <= STD_LOGIC_VECTOR("0" & i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_im3_shift0_q) & "00000000000000";
    i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_align_15_q <= i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_align_15_qint(27 downto 0);

    -- i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_im6_shift0(BITSHIFT,147)@2
    i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_im6_shift0_qint <= i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_bs1_merged_bit_select_d & "000";
    i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_im6_shift0_q <= i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_im6_shift0_qint(20 downto 0);

    -- i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_align_14(BITSHIFT,126)@2
    i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_align_14_qint <= STD_LOGIC_VECTOR("0" & i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_im6_shift0_q) & "000000000000000000";
    i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_align_14_q <= i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_align_14_qint(39 downto 0);

    -- i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_join_16(BITJOIN,128)@2
    i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_join_16_q <= i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_align_15_q & i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_align_14_q;

    -- i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_im9_shift0(BITSHIFT,148)@2
    i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_im9_shift0_qint <= i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_bs1_merged_bit_select_e & "000";
    i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_im9_shift0_q <= i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_im9_shift0_qint(20 downto 0);

    -- i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_align_12(BITSHIFT,124)@2
    i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_align_12_qint <= STD_LOGIC_VECTOR("0" & i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_im9_shift0_q) & "00000000000000";
    i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_align_12_q <= i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_align_12_qint(35 downto 0);

    -- i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_im0_shift0(BITSHIFT,145)@2
    i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_im0_shift0_qint <= i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_bs1_merged_bit_select_b & "000";
    i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_im0_shift0_q <= i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_im0_shift0_qint(20 downto 0);

    -- i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_join_13(BITJOIN,125)@2
    i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_join_13_q <= i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_align_12_q & STD_LOGIC_VECTOR("0" & i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_im0_shift0_q);

    -- i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_result_add_0_0(ADD,129)@2
    i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_result_add_0_0_a <= STD_LOGIC_VECTOR("00000000000" & i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_join_13_q);
    i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_result_add_0_0_b <= STD_LOGIC_VECTOR("0" & i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_join_16_q);
    i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_result_add_0_0_o <= STD_LOGIC_VECTOR(UNSIGNED(i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_result_add_0_0_a) + UNSIGNED(i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_result_add_0_0_b));
    i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_result_add_0_0_q <= i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_result_add_0_0_o(68 downto 0);

    -- i_arrayidx_matrix_multiply_matrix_multiply19_mult_extender_x(BITJOIN,42)@2
    i_arrayidx_matrix_multiply_matrix_multiply19_mult_extender_x_q <= i_arrayidx5_matrix_multiply_matrix_multiply17_mult_multconst_x_q & i_arrayidx_matrix_multiply_matrix_multiply19_mult_x_result_add_0_0_q(67 downto 0);

    -- i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x(BITSELECT,44)@2
    i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b <= i_arrayidx_matrix_multiply_matrix_multiply19_mult_extender_x_q(63 downto 0);

    -- SR_SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0(STALLREG,410)
    SR_SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SR_SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_r_valid <= (others => '0');
            SR_SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_r_data0 <= (others => '-');
            SR_SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_r_data1 <= (others => '-');
            SR_SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_r_data2 <= (others => '-');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Valid
            SR_SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_r_valid <= SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_backStall and (SR_SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_r_valid or SR_SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_i_valid);

            IF (SR_SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_r_valid = "0") THEN
                -- Data(s)
                SR_SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_r_data0 <= STD_LOGIC_VECTOR(i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b);
                SR_SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_r_data1 <= STD_LOGIC_VECTOR(i_arrayidx5_matrix_multiply_matrix_multiply17_trunc_sel_x_b);
                SR_SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_r_data2 <= STD_LOGIC_VECTOR(bgTrunc_i_inc_matrix_multiply_sel_x_b);
            END IF;

        END IF;
    END PROCESS;
    -- Computing multiple Valid(s)
    SR_SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_i_valid <= SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_V4;
    -- Stall signal propagation
    SR_SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_backStall <= SR_SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_r_valid or not (SR_SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_i_valid);

    -- Valid
    SR_SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_V <= SR_SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_r_valid WHEN SR_SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_r_valid = "1" ELSE SR_SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_i_valid;

    -- Data0
    SR_SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_D0 <= SR_SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_r_data0 WHEN SR_SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_r_valid = "1" ELSE i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b;
    -- Data1
    SR_SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_D1 <= SR_SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_r_data1 WHEN SR_SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_r_valid = "1" ELSE i_arrayidx5_matrix_multiply_matrix_multiply17_trunc_sel_x_b;
    -- Data2
    SR_SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_D2 <= SR_SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_r_data2 WHEN SR_SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_r_valid = "1" ELSE bgTrunc_i_inc_matrix_multiply_sel_x_b;

    -- redist11_bgTrunc_i_inc_matrix_multiply_sel_x_b_1_0(REG,176)
    redist11_bgTrunc_i_inc_matrix_multiply_sel_x_b_1_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist11_bgTrunc_i_inc_matrix_multiply_sel_x_b_1_0_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_backEN = "1") THEN
                redist11_bgTrunc_i_inc_matrix_multiply_sel_x_b_1_0_q <= STD_LOGIC_VECTOR(SR_SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_D2);
            END IF;
        END IF;
    END PROCESS;

    -- x1_uid136_i_exitcond_matrix_multiply(BITSELECT,135)@3
    x1_uid136_i_exitcond_matrix_multiply_b <= STD_LOGIC_VECTOR(redist11_bgTrunc_i_inc_matrix_multiply_sel_x_b_1_0_q(31 downto 16));

    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- eq1_uid138_i_exitcond_matrix_multiply(LOGICAL,137)@3
    eq1_uid138_i_exitcond_matrix_multiply_q <= "1" WHEN x1_uid136_i_exitcond_matrix_multiply_b = y1_uid137_i_exitcond_matrix_multiply_b ELSE "0";

    -- y0_uid134_i_exitcond_matrix_multiply(BITSELECT,133)@3
    y0_uid134_i_exitcond_matrix_multiply_in <= bubble_select_i_syncbuf_p_sync_buffer3_matrix_multiply_b(15 downto 0);
    y0_uid134_i_exitcond_matrix_multiply_b <= y0_uid134_i_exitcond_matrix_multiply_in(15 downto 0);

    -- x0_uid133_i_exitcond_matrix_multiply(BITSELECT,132)@3
    x0_uid133_i_exitcond_matrix_multiply_in <= redist11_bgTrunc_i_inc_matrix_multiply_sel_x_b_1_0_q(15 downto 0);
    x0_uid133_i_exitcond_matrix_multiply_b <= x0_uid133_i_exitcond_matrix_multiply_in(15 downto 0);

    -- eq0_uid135_i_exitcond_matrix_multiply(LOGICAL,134)@3
    eq0_uid135_i_exitcond_matrix_multiply_q <= "1" WHEN x0_uid133_i_exitcond_matrix_multiply_b = y0_uid134_i_exitcond_matrix_multiply_b ELSE "0";

    -- SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0(STALLENABLE,306)
    -- Valid signal propagation
    SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_V0 <= SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_R_v_0;
    -- Stall signal propagation
    SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_s_tv_0 <= SE_i_exitcond_guard_matrix_multiply_backStall and SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_R_v_0;
    -- Backward Enable generation
    SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_backEN <= not (SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_v_s_0 <= SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_backEN and SR_SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_V;
    -- Backward Stall generation
    SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_backStall <= not (SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_backEN);
    SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_backEN = "0") THEN
                SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_R_v_0 <= SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_R_v_0 and SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_s_tv_0;
            ELSE
                SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_R_v_0 <= SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SR_SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0(STALLREG,412)
    SR_SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SR_SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_r_valid <= (others => '0');
            SR_SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_r_data0 <= (others => '-');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Valid
            SR_SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_r_valid <= SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_backStall and (SR_SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_r_valid or SR_SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_i_valid);

            IF (SR_SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_r_valid = "0") THEN
                -- Data(s)
                SR_SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_r_data0 <= STD_LOGIC_VECTOR(i_cmp21_neg_rm_matrix_multiply_c);
            END IF;

        END IF;
    END PROCESS;
    -- Computing multiple Valid(s)
    SR_SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_i_valid <= SE_i_cmp21_neg_rm_matrix_multiply_V1;
    -- Stall signal propagation
    SR_SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_backStall <= SR_SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_r_valid or not (SR_SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_i_valid);

    -- Valid
    SR_SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_V <= SR_SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_r_valid WHEN SR_SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_r_valid = "1" ELSE SR_SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_i_valid;

    SR_SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_D0 <= SR_SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_r_data0 WHEN SR_SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_r_valid = "1" ELSE i_cmp21_neg_rm_matrix_multiply_c;

    -- i_syncbuf_p_sync_buffer_matrix_multiply(BLACKBOX,79)@2
    -- in in_stall_in@20000000
    -- out out_stall_out@20000000
    thei_syncbuf_p_sync_buffer_matrix_multiply : i_syncbuf_p_sync_buffer_matrix_multiply7
    PORT MAP (
        in_buffer_in => in_P,
        in_i_dependence => GND_q,
        in_stall_in => SE_out_i_syncbuf_p_sync_buffer_matrix_multiply_backStall,
        in_valid_in => SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_V2,
        out_buffer_out => i_syncbuf_p_sync_buffer_matrix_multiply_out_buffer_out,
        out_stall_out => i_syncbuf_p_sync_buffer_matrix_multiply_out_stall_out,
        out_valid_out => i_syncbuf_p_sync_buffer_matrix_multiply_out_valid_out,
        clock => clock,
        resetn => resetn
    );

    -- SE_out_i_syncbuf_p_sync_buffer_matrix_multiply(STALLENABLE,271)
    -- Valid signal propagation
    SE_out_i_syncbuf_p_sync_buffer_matrix_multiply_V0 <= SE_out_i_syncbuf_p_sync_buffer_matrix_multiply_wireValid;
    -- Backward Stall generation
    SE_out_i_syncbuf_p_sync_buffer_matrix_multiply_backStall <= SE_i_cmp21_neg_rm_matrix_multiply_backStall or not (SE_out_i_syncbuf_p_sync_buffer_matrix_multiply_wireValid);
    -- Computing multiple Valid(s)
    SE_out_i_syncbuf_p_sync_buffer_matrix_multiply_wireValid <= i_syncbuf_p_sync_buffer_matrix_multiply_out_valid_out;

    -- SE_i_cmp21_neg_rm_matrix_multiply(STALLENABLE,252)
    -- Valid signal propagation
    SE_i_cmp21_neg_rm_matrix_multiply_V0 <= SE_i_cmp21_neg_rm_matrix_multiply_R_v_0;
    SE_i_cmp21_neg_rm_matrix_multiply_V1 <= SE_i_cmp21_neg_rm_matrix_multiply_R_v_1;
    -- Stall signal propagation
    SE_i_cmp21_neg_rm_matrix_multiply_s_tv_0 <= SE_i_cmp_neg_or_rm_matrix_multiply_backStall and SE_i_cmp21_neg_rm_matrix_multiply_R_v_0;
    SE_i_cmp21_neg_rm_matrix_multiply_s_tv_1 <= SR_SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_backStall and SE_i_cmp21_neg_rm_matrix_multiply_R_v_1;
    -- Backward Enable generation
    SE_i_cmp21_neg_rm_matrix_multiply_or0 <= SE_i_cmp21_neg_rm_matrix_multiply_s_tv_0;
    SE_i_cmp21_neg_rm_matrix_multiply_backEN <= not (SE_i_cmp21_neg_rm_matrix_multiply_s_tv_1 or SE_i_cmp21_neg_rm_matrix_multiply_or0);
    -- Determine whether to write valid data into the first register stage
    SE_i_cmp21_neg_rm_matrix_multiply_v_s_0 <= SE_i_cmp21_neg_rm_matrix_multiply_backEN and SE_out_i_syncbuf_p_sync_buffer_matrix_multiply_V0;
    -- Backward Stall generation
    SE_i_cmp21_neg_rm_matrix_multiply_backStall <= not (SE_i_cmp21_neg_rm_matrix_multiply_v_s_0);
    SE_i_cmp21_neg_rm_matrix_multiply_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_i_cmp21_neg_rm_matrix_multiply_R_v_0 <= (others => '0');
            SE_i_cmp21_neg_rm_matrix_multiply_R_v_1 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_i_cmp21_neg_rm_matrix_multiply_backEN = "0") THEN
                SE_i_cmp21_neg_rm_matrix_multiply_R_v_0 <= SE_i_cmp21_neg_rm_matrix_multiply_R_v_0 and SE_i_cmp21_neg_rm_matrix_multiply_s_tv_0;
            ELSE
                SE_i_cmp21_neg_rm_matrix_multiply_R_v_0 <= SE_i_cmp21_neg_rm_matrix_multiply_v_s_0;
            END IF;

            IF (SE_i_cmp21_neg_rm_matrix_multiply_backEN = "0") THEN
                SE_i_cmp21_neg_rm_matrix_multiply_R_v_1 <= SE_i_cmp21_neg_rm_matrix_multiply_R_v_1 and SE_i_cmp21_neg_rm_matrix_multiply_s_tv_1;
            ELSE
                SE_i_cmp21_neg_rm_matrix_multiply_R_v_1 <= SE_i_cmp21_neg_rm_matrix_multiply_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- bubble_join_i_syncbuf_p_sync_buffer_matrix_multiply(BITJOIN,211)
    bubble_join_i_syncbuf_p_sync_buffer_matrix_multiply_q <= i_syncbuf_p_sync_buffer_matrix_multiply_out_buffer_out;

    -- bubble_select_i_syncbuf_p_sync_buffer_matrix_multiply(BITSELECT,212)
    bubble_select_i_syncbuf_p_sync_buffer_matrix_multiply_b <= STD_LOGIC_VECTOR(bubble_join_i_syncbuf_p_sync_buffer_matrix_multiply_q(31 downto 0));

    -- i_cmp21_neg_rm_matrix_multiply(COMPARE,62)@2 + 1
    i_cmp21_neg_rm_matrix_multiply_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 32 => bubble_select_i_syncbuf_p_sync_buffer_matrix_multiply_b(31)) & bubble_select_i_syncbuf_p_sync_buffer_matrix_multiply_b));
    i_cmp21_neg_rm_matrix_multiply_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 32 => c_i32_1gr_q(31)) & c_i32_1gr_q));
    i_cmp21_neg_rm_matrix_multiply_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            i_cmp21_neg_rm_matrix_multiply_o <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_i_cmp21_neg_rm_matrix_multiply_backEN = "1") THEN
                i_cmp21_neg_rm_matrix_multiply_o <= STD_LOGIC_VECTOR(SIGNED(i_cmp21_neg_rm_matrix_multiply_a) - SIGNED(i_cmp21_neg_rm_matrix_multiply_b));
            END IF;
        END IF;
    END PROCESS;
    i_cmp21_neg_rm_matrix_multiply_c(0) <= i_cmp21_neg_rm_matrix_multiply_o(33);

    -- i_cmp_neg_or_rm_matrix_multiply(LOGICAL,63)@3
    i_cmp_neg_or_rm_matrix_multiply_q <= i_cmp21_neg_rm_matrix_multiply_c or i_cmp_neg_rm_matrix_multiply_n;

    -- redist10_i_arrayidx5_matrix_multiply_matrix_multiply17_trunc_sel_x_b_1_0(REG,175)
    redist10_i_arrayidx5_matrix_multiply_matrix_multiply17_trunc_sel_x_b_1_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist10_i_arrayidx5_matrix_multiply_matrix_multiply17_trunc_sel_x_b_1_0_q <= "0000000000000000000000000000000000000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_backEN = "1") THEN
                redist10_i_arrayidx5_matrix_multiply_matrix_multiply17_trunc_sel_x_b_1_0_q <= STD_LOGIC_VECTOR(SR_SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_D1);
            END IF;
        END IF;
    END PROCESS;

    -- bubble_join_i_syncbuf_b_sync_buffer_matrix_multiply(BITJOIN,201)
    bubble_join_i_syncbuf_b_sync_buffer_matrix_multiply_q <= i_syncbuf_b_sync_buffer_matrix_multiply_out_buffer_out;

    -- bubble_select_i_syncbuf_b_sync_buffer_matrix_multiply(BITSELECT,202)
    bubble_select_i_syncbuf_b_sync_buffer_matrix_multiply_b <= STD_LOGIC_VECTOR(bubble_join_i_syncbuf_b_sync_buffer_matrix_multiply_q(63 downto 0));

    -- i_arrayidx5_matrix_multiply_matrix_multiply17_add_x(ADD,35)@3
    i_arrayidx5_matrix_multiply_matrix_multiply17_add_x_a <= STD_LOGIC_VECTOR("0" & bubble_select_i_syncbuf_b_sync_buffer_matrix_multiply_b);
    i_arrayidx5_matrix_multiply_matrix_multiply17_add_x_b <= STD_LOGIC_VECTOR("0" & redist10_i_arrayidx5_matrix_multiply_matrix_multiply17_trunc_sel_x_b_1_0_q);
    i_arrayidx5_matrix_multiply_matrix_multiply17_add_x_o <= STD_LOGIC_VECTOR(UNSIGNED(i_arrayidx5_matrix_multiply_matrix_multiply17_add_x_a) + UNSIGNED(i_arrayidx5_matrix_multiply_matrix_multiply17_add_x_b));
    i_arrayidx5_matrix_multiply_matrix_multiply17_add_x_q <= i_arrayidx5_matrix_multiply_matrix_multiply17_add_x_o(64 downto 0);

    -- i_arrayidx5_matrix_multiply_matrix_multiply17_dupName_0_trunc_sel_x(BITSELECT,29)@3
    i_arrayidx5_matrix_multiply_matrix_multiply17_dupName_0_trunc_sel_x_b <= i_arrayidx5_matrix_multiply_matrix_multiply17_add_x_q(63 downto 0);

    -- SE_i_cmp_neg_or_rm_matrix_multiply(STALLENABLE,253)
    SE_i_cmp_neg_or_rm_matrix_multiply_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_i_cmp_neg_or_rm_matrix_multiply_fromReg0 <= (others => '0');
            SE_i_cmp_neg_or_rm_matrix_multiply_fromReg1 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Succesor 0
            SE_i_cmp_neg_or_rm_matrix_multiply_fromReg0 <= SE_i_cmp_neg_or_rm_matrix_multiply_toReg0;
            -- Succesor 1
            SE_i_cmp_neg_or_rm_matrix_multiply_fromReg1 <= SE_i_cmp_neg_or_rm_matrix_multiply_toReg1;
        END IF;
    END PROCESS;
    -- Input Stall processing
    SE_i_cmp_neg_or_rm_matrix_multiply_consumed0 <= (not (SR_SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_backStall) and SE_i_cmp_neg_or_rm_matrix_multiply_wireValid) or SE_i_cmp_neg_or_rm_matrix_multiply_fromReg0;
    SE_i_cmp_neg_or_rm_matrix_multiply_consumed1 <= (not (SR_SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_backStall) and SE_i_cmp_neg_or_rm_matrix_multiply_wireValid) or SE_i_cmp_neg_or_rm_matrix_multiply_fromReg1;
    -- Consuming
    SE_i_cmp_neg_or_rm_matrix_multiply_StallValid <= SE_i_cmp_neg_or_rm_matrix_multiply_backStall and SE_i_cmp_neg_or_rm_matrix_multiply_wireValid;
    SE_i_cmp_neg_or_rm_matrix_multiply_toReg0 <= SE_i_cmp_neg_or_rm_matrix_multiply_StallValid and SE_i_cmp_neg_or_rm_matrix_multiply_consumed0;
    SE_i_cmp_neg_or_rm_matrix_multiply_toReg1 <= SE_i_cmp_neg_or_rm_matrix_multiply_StallValid and SE_i_cmp_neg_or_rm_matrix_multiply_consumed1;
    -- Backward Stall generation
    SE_i_cmp_neg_or_rm_matrix_multiply_or0 <= SE_i_cmp_neg_or_rm_matrix_multiply_consumed0;
    SE_i_cmp_neg_or_rm_matrix_multiply_wireStall <= not (SE_i_cmp_neg_or_rm_matrix_multiply_consumed1 and SE_i_cmp_neg_or_rm_matrix_multiply_or0);
    SE_i_cmp_neg_or_rm_matrix_multiply_backStall <= SE_i_cmp_neg_or_rm_matrix_multiply_wireStall;
    -- Valid signal propagation
    SE_i_cmp_neg_or_rm_matrix_multiply_V0 <= SE_i_cmp_neg_or_rm_matrix_multiply_wireValid and not (SE_i_cmp_neg_or_rm_matrix_multiply_fromReg0);
    SE_i_cmp_neg_or_rm_matrix_multiply_V1 <= SE_i_cmp_neg_or_rm_matrix_multiply_wireValid and not (SE_i_cmp_neg_or_rm_matrix_multiply_fromReg1);
    -- Computing multiple Valid(s)
    SE_i_cmp_neg_or_rm_matrix_multiply_and0 <= SE_i_cmp21_neg_rm_matrix_multiply_V0;
    SE_i_cmp_neg_or_rm_matrix_multiply_wireValid <= SE_i_cmp_neg_rm_matrix_multiply_V0 and SE_i_cmp_neg_or_rm_matrix_multiply_and0;

    -- SE_out_bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_4(STALLENABLE,340)
    -- Valid signal propagation
    SE_out_bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_4_V0 <= SE_out_bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_4_wireValid;
    -- Backward Stall generation
    SE_out_bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_4_backStall <= i_syncbuf_b_sync_buffer_matrix_multiply_out_stall_out or not (SE_out_bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_4_wireValid);
    -- Computing multiple Valid(s)
    SE_out_bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_4_wireValid <= bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_4_reg_valid_out;

    -- i_syncbuf_b_sync_buffer_matrix_multiply(BLACKBOX,76)@3
    -- in in_stall_in@20000000
    -- out out_stall_out@20000000
    thei_syncbuf_b_sync_buffer_matrix_multiply : i_syncbuf_b_sync_buffer_matrix_multiply11
    PORT MAP (
        in_buffer_in => in_B,
        in_i_dependence => GND_q,
        in_stall_in => SR_SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_backStall,
        in_valid_in => SE_out_bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_4_V0,
        out_buffer_out => i_syncbuf_b_sync_buffer_matrix_multiply_out_buffer_out,
        out_stall_out => i_syncbuf_b_sync_buffer_matrix_multiply_out_stall_out,
        out_valid_out => i_syncbuf_b_sync_buffer_matrix_multiply_out_valid_out,
        clock => clock,
        resetn => resetn
    );

    -- SE_out_i_syncbuf_b_sync_buffer_matrix_multiply(STALLENABLE,265)
    -- Valid signal propagation
    SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_V0 <= SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_wireValid;
    -- Backward Stall generation
    SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_backStall <= i_load_unnamed_matrix_multiply0_matrix_multiply_out_o_stall or not (SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_wireValid);
    -- Computing multiple Valid(s)
    SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_wireValid <= SR_SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_V;

    -- SR_SE_out_i_syncbuf_b_sync_buffer_matrix_multiply(STALLREG,417)
    SR_SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SR_SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_r_valid <= (others => '0');
            SR_SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_r_data0 <= (others => '-');
            SR_SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_r_data1 <= (others => '-');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Valid
            SR_SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_r_valid <= SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_backStall and (SR_SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_r_valid or SR_SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_i_valid);

            IF (SR_SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_r_valid = "0") THEN
                -- Data(s)
                SR_SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_r_data0 <= i_arrayidx5_matrix_multiply_matrix_multiply17_dupName_0_trunc_sel_x_b;
                SR_SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_r_data1 <= i_cmp_neg_or_rm_matrix_multiply_q;
            END IF;

        END IF;
    END PROCESS;
    -- Computing multiple Valid(s)
    SR_SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_and0 <= i_syncbuf_b_sync_buffer_matrix_multiply_out_valid_out;
    SR_SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_and1 <= SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_V1 and SR_SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_and0;
    SR_SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_i_valid <= SE_i_cmp_neg_or_rm_matrix_multiply_V0 and SR_SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_and1;
    -- Stall signal propagation
    SR_SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_backStall <= SR_SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_r_valid or not (SR_SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_i_valid);

    -- Valid
    SR_SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_V <= SR_SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_r_valid WHEN SR_SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_r_valid = "1" ELSE SR_SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_i_valid;

    -- Data0
    SR_SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_D0 <= SR_SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_r_data0 WHEN SR_SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_r_valid = "1" ELSE i_arrayidx5_matrix_multiply_matrix_multiply17_dupName_0_trunc_sel_x_b;
    -- Data1
    SR_SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_D1 <= SR_SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_r_data1 WHEN SR_SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_r_valid = "1" ELSE i_cmp_neg_or_rm_matrix_multiply_q;

    -- SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0(STALLENABLE,317)
    -- Valid signal propagation
    SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_V0 <= SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_R_v_0;
    SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_V1 <= SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_R_v_1;
    SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_V2 <= SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_R_v_2;
    SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_V3 <= SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_R_v_3;
    -- Stall signal propagation
    SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_s_tv_0 <= SR_SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_backStall and SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_R_v_0;
    SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_s_tv_1 <= SR_SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_backStall and SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_R_v_1;
    SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_s_tv_2 <= SR_SE_y0_uid134_i_exitcond_matrix_multiply_backStall and SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_R_v_2;
    SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_s_tv_3 <= redist12_bgTrunc_i_inc_matrix_multiply_sel_x_b_169_fifo_stall_out and SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_R_v_3;
    -- Backward Enable generation
    SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_or0 <= SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_s_tv_0;
    SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_or1 <= SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_s_tv_1 or SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_or0;
    SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_or2 <= SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_s_tv_2 or SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_or1;
    SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_backEN <= not (SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_s_tv_3 or SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_or2);
    -- Determine whether to write valid data into the first register stage
    SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_v_s_0 <= SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_backEN and SR_SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_V;
    -- Backward Stall generation
    SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_backStall <= not (SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_backEN);
    SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_R_v_0 <= (others => '0');
            SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_R_v_1 <= (others => '0');
            SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_R_v_2 <= (others => '0');
            SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_R_v_3 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_backEN = "0") THEN
                SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_R_v_0 <= SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_R_v_0 and SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_s_tv_0;
            ELSE
                SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_R_v_0 <= SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_v_s_0;
            END IF;

            IF (SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_backEN = "0") THEN
                SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_R_v_1 <= SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_R_v_1 and SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_s_tv_1;
            ELSE
                SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_R_v_1 <= SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_v_s_0;
            END IF;

            IF (SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_backEN = "0") THEN
                SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_R_v_2 <= SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_R_v_2 and SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_s_tv_2;
            ELSE
                SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_R_v_2 <= SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_v_s_0;
            END IF;

            IF (SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_backEN = "0") THEN
                SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_R_v_3 <= SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_R_v_3 and SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_s_tv_3;
            ELSE
                SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_R_v_3 <= SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SE_andEq_uid139_i_exitcond_matrix_multiply(STALLENABLE,292)
    -- Valid signal propagation
    SE_andEq_uid139_i_exitcond_matrix_multiply_V0 <= SE_andEq_uid139_i_exitcond_matrix_multiply_R_v_0;
    -- Stall signal propagation
    SE_andEq_uid139_i_exitcond_matrix_multiply_s_tv_0 <= SE_i_exitcond_guard_matrix_multiply_backStall and SE_andEq_uid139_i_exitcond_matrix_multiply_R_v_0;
    -- Backward Enable generation
    SE_andEq_uid139_i_exitcond_matrix_multiply_backEN <= not (SE_andEq_uid139_i_exitcond_matrix_multiply_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_andEq_uid139_i_exitcond_matrix_multiply_v_s_0 <= SE_andEq_uid139_i_exitcond_matrix_multiply_backEN and SE_y0_uid134_i_exitcond_matrix_multiply_V0;
    -- Backward Stall generation
    SE_andEq_uid139_i_exitcond_matrix_multiply_backStall <= not (SE_andEq_uid139_i_exitcond_matrix_multiply_v_s_0);
    SE_andEq_uid139_i_exitcond_matrix_multiply_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_andEq_uid139_i_exitcond_matrix_multiply_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_andEq_uid139_i_exitcond_matrix_multiply_backEN = "0") THEN
                SE_andEq_uid139_i_exitcond_matrix_multiply_R_v_0 <= SE_andEq_uid139_i_exitcond_matrix_multiply_R_v_0 and SE_andEq_uid139_i_exitcond_matrix_multiply_s_tv_0;
            ELSE
                SE_andEq_uid139_i_exitcond_matrix_multiply_R_v_0 <= SE_andEq_uid139_i_exitcond_matrix_multiply_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SE_y0_uid134_i_exitcond_matrix_multiply(STALLENABLE,287)
    -- Valid signal propagation
    SE_y0_uid134_i_exitcond_matrix_multiply_V0 <= SE_y0_uid134_i_exitcond_matrix_multiply_wireValid;
    -- Backward Stall generation
    SE_y0_uid134_i_exitcond_matrix_multiply_backStall <= SE_andEq_uid139_i_exitcond_matrix_multiply_backStall or not (SE_y0_uid134_i_exitcond_matrix_multiply_wireValid);
    -- Computing multiple Valid(s)
    SE_y0_uid134_i_exitcond_matrix_multiply_wireValid <= SR_SE_y0_uid134_i_exitcond_matrix_multiply_V;

    -- SR_SE_y0_uid134_i_exitcond_matrix_multiply(STALLREG,411)
    SR_SE_y0_uid134_i_exitcond_matrix_multiply_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SR_SE_y0_uid134_i_exitcond_matrix_multiply_r_valid <= (others => '0');
            SR_SE_y0_uid134_i_exitcond_matrix_multiply_r_data0 <= (others => '-');
            SR_SE_y0_uid134_i_exitcond_matrix_multiply_r_data1 <= (others => '-');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Valid
            SR_SE_y0_uid134_i_exitcond_matrix_multiply_r_valid <= SE_y0_uid134_i_exitcond_matrix_multiply_backStall and (SR_SE_y0_uid134_i_exitcond_matrix_multiply_r_valid or SR_SE_y0_uid134_i_exitcond_matrix_multiply_i_valid);

            IF (SR_SE_y0_uid134_i_exitcond_matrix_multiply_r_valid = "0") THEN
                -- Data(s)
                SR_SE_y0_uid134_i_exitcond_matrix_multiply_r_data0 <= eq0_uid135_i_exitcond_matrix_multiply_q;
                SR_SE_y0_uid134_i_exitcond_matrix_multiply_r_data1 <= eq1_uid138_i_exitcond_matrix_multiply_q;
            END IF;

        END IF;
    END PROCESS;
    -- Computing multiple Valid(s)
    SR_SE_y0_uid134_i_exitcond_matrix_multiply_and0 <= SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_V1;
    SR_SE_y0_uid134_i_exitcond_matrix_multiply_i_valid <= SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_V2 and SR_SE_y0_uid134_i_exitcond_matrix_multiply_and0;
    -- Stall signal propagation
    SR_SE_y0_uid134_i_exitcond_matrix_multiply_backStall <= SR_SE_y0_uid134_i_exitcond_matrix_multiply_r_valid or not (SR_SE_y0_uid134_i_exitcond_matrix_multiply_i_valid);

    -- Valid
    SR_SE_y0_uid134_i_exitcond_matrix_multiply_V <= SR_SE_y0_uid134_i_exitcond_matrix_multiply_r_valid WHEN SR_SE_y0_uid134_i_exitcond_matrix_multiply_r_valid = "1" ELSE SR_SE_y0_uid134_i_exitcond_matrix_multiply_i_valid;

    -- Data0
    SR_SE_y0_uid134_i_exitcond_matrix_multiply_D0 <= SR_SE_y0_uid134_i_exitcond_matrix_multiply_r_data0 WHEN SR_SE_y0_uid134_i_exitcond_matrix_multiply_r_valid = "1" ELSE eq0_uid135_i_exitcond_matrix_multiply_q;
    -- Data1
    SR_SE_y0_uid134_i_exitcond_matrix_multiply_D1 <= SR_SE_y0_uid134_i_exitcond_matrix_multiply_r_data1 WHEN SR_SE_y0_uid134_i_exitcond_matrix_multiply_r_valid = "1" ELSE eq1_uid138_i_exitcond_matrix_multiply_q;

    -- SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply(STALLENABLE,269)
    SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_fromReg0 <= (others => '0');
            SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_fromReg1 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Succesor 0
            SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_fromReg0 <= SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_toReg0;
            -- Succesor 1
            SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_fromReg1 <= SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_toReg1;
        END IF;
    END PROCESS;
    -- Input Stall processing
    SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_consumed0 <= (not (bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_reg_stall_out) and SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_wireValid) or SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_fromReg0;
    SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_consumed1 <= (not (SR_SE_y0_uid134_i_exitcond_matrix_multiply_backStall) and SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_wireValid) or SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_fromReg1;
    -- Consuming
    SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_StallValid <= SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_backStall and SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_wireValid;
    SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_toReg0 <= SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_StallValid and SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_consumed0;
    SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_toReg1 <= SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_StallValid and SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_consumed1;
    -- Backward Stall generation
    SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_or0 <= SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_consumed0;
    SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_wireStall <= not (SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_consumed1 and SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_or0);
    SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_backStall <= SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_wireStall;
    -- Valid signal propagation
    SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_V0 <= SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_wireValid and not (SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_fromReg0);
    SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_V1 <= SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_wireValid and not (SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_fromReg1);
    -- Computing multiple Valid(s)
    SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_wireValid <= i_syncbuf_p_sync_buffer3_matrix_multiply_out_valid_out;

    -- i_syncbuf_p_sync_buffer3_matrix_multiply(BLACKBOX,78)@3
    -- in in_stall_in@20000000
    -- out out_stall_out@20000000
    thei_syncbuf_p_sync_buffer3_matrix_multiply : i_syncbuf_p_sync_buffer3_matrix_multiply13
    PORT MAP (
        in_buffer_in => in_P,
        in_i_dependence => GND_q,
        in_stall_in => SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_backStall,
        in_valid_in => SE_out_bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_5_V0,
        out_buffer_out => i_syncbuf_p_sync_buffer3_matrix_multiply_out_buffer_out,
        out_stall_out => i_syncbuf_p_sync_buffer3_matrix_multiply_out_stall_out,
        out_valid_out => i_syncbuf_p_sync_buffer3_matrix_multiply_out_valid_out,
        clock => clock,
        resetn => resetn
    );

    -- SE_out_bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_5(STALLENABLE,342)
    -- Valid signal propagation
    SE_out_bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_5_V0 <= SE_out_bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_5_wireValid;
    -- Backward Stall generation
    SE_out_bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_5_backStall <= i_syncbuf_p_sync_buffer3_matrix_multiply_out_stall_out or not (SE_out_bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_5_wireValid);
    -- Computing multiple Valid(s)
    SE_out_bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_5_wireValid <= bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_5_reg_valid_out;

    -- bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_5_reg(STALLFIFO,407)
    bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_5_reg_valid_in <= SE_out_matrix_multiply_B1_merge_reg_aunroll_x_V2;
    bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_5_reg_stall_in <= SE_out_bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_5_backStall;
    bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_5_reg_valid_in_bitsignaltemp <= bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_5_reg_valid_in(0);
    bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_5_reg_stall_in_bitsignaltemp <= bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_5_reg_stall_in(0);
    bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_5_reg_valid_out(0) <= bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_5_reg_valid_out_bitsignaltemp;
    bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_5_reg_stall_out(0) <= bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_5_reg_stall_out_bitsignaltemp;
    thebubble_out_matrix_multiply_B1_merge_reg_aunroll_x_5_reg : acl_valid_fifo_counter
    GENERIC MAP (
        DEPTH => 3,
        STRICT_DEPTH => 0,
        ALLOW_FULL_WRITE => 0,
        ASYNC_RESET => 1
    )
    PORT MAP (
        valid_in => bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_5_reg_valid_in_bitsignaltemp,
        stall_in => bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_5_reg_stall_in_bitsignaltemp,
        valid_out => bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_5_reg_valid_out_bitsignaltemp,
        stall_out => bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_5_reg_stall_out_bitsignaltemp,
        clock => clock,
        resetn => resetn
    );

    -- bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_4_reg(STALLFIFO,406)
    bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_4_reg_valid_in <= SE_out_matrix_multiply_B1_merge_reg_aunroll_x_V1;
    bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_4_reg_stall_in <= SE_out_bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_4_backStall;
    bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_4_reg_valid_in_bitsignaltemp <= bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_4_reg_valid_in(0);
    bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_4_reg_stall_in_bitsignaltemp <= bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_4_reg_stall_in(0);
    bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_4_reg_valid_out(0) <= bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_4_reg_valid_out_bitsignaltemp;
    bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_4_reg_stall_out(0) <= bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_4_reg_stall_out_bitsignaltemp;
    thebubble_out_matrix_multiply_B1_merge_reg_aunroll_x_4_reg : acl_valid_fifo_counter
    GENERIC MAP (
        DEPTH => 3,
        STRICT_DEPTH => 0,
        ALLOW_FULL_WRITE => 0,
        ASYNC_RESET => 1
    )
    PORT MAP (
        valid_in => bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_4_reg_valid_in_bitsignaltemp,
        stall_in => bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_4_reg_stall_in_bitsignaltemp,
        valid_out => bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_4_reg_valid_out_bitsignaltemp,
        stall_out => bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_4_reg_stall_out_bitsignaltemp,
        clock => clock,
        resetn => resetn
    );

    -- i_syncbuf_a_sync_buffer_matrix_multiply(BLACKBOX,75)@3
    -- in in_stall_in@20000000
    -- out out_stall_out@20000000
    thei_syncbuf_a_sync_buffer_matrix_multiply : i_syncbuf_a_sync_buffer_matrix_multiply5
    PORT MAP (
        in_buffer_in => in_A,
        in_i_dependence => GND_q,
        in_stall_in => SR_SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_backStall,
        in_valid_in => SE_out_bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_1_V0,
        out_buffer_out => i_syncbuf_a_sync_buffer_matrix_multiply_out_buffer_out,
        out_stall_out => i_syncbuf_a_sync_buffer_matrix_multiply_out_stall_out,
        out_valid_out => i_syncbuf_a_sync_buffer_matrix_multiply_out_valid_out,
        clock => clock,
        resetn => resetn
    );

    -- SE_out_bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_1(STALLENABLE,334)
    -- Valid signal propagation
    SE_out_bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_1_V0 <= SE_out_bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_1_wireValid;
    -- Backward Stall generation
    SE_out_bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_1_backStall <= i_syncbuf_a_sync_buffer_matrix_multiply_out_stall_out or not (SE_out_bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_1_wireValid);
    -- Computing multiple Valid(s)
    SE_out_bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_1_wireValid <= bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_1_reg_valid_out;

    -- bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_1_reg(STALLFIFO,403)
    bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_1_reg_valid_in <= SE_out_matrix_multiply_B1_merge_reg_aunroll_x_V0;
    bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_1_reg_stall_in <= SE_out_bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_1_backStall;
    bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_1_reg_valid_in_bitsignaltemp <= bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_1_reg_valid_in(0);
    bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_1_reg_stall_in_bitsignaltemp <= bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_1_reg_stall_in(0);
    bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_1_reg_valid_out(0) <= bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_1_reg_valid_out_bitsignaltemp;
    bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_1_reg_stall_out(0) <= bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_1_reg_stall_out_bitsignaltemp;
    thebubble_out_matrix_multiply_B1_merge_reg_aunroll_x_1_reg : acl_valid_fifo_counter
    GENERIC MAP (
        DEPTH => 3,
        STRICT_DEPTH => 0,
        ALLOW_FULL_WRITE => 0,
        ASYNC_RESET => 1
    )
    PORT MAP (
        valid_in => bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_1_reg_valid_in_bitsignaltemp,
        stall_in => bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_1_reg_stall_in_bitsignaltemp,
        valid_out => bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_1_reg_valid_out_bitsignaltemp,
        stall_out => bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_1_reg_stall_out_bitsignaltemp,
        clock => clock,
        resetn => resetn
    );

    -- SE_out_matrix_multiply_B1_merge_reg_aunroll_x(STALLENABLE,250)
    SE_out_matrix_multiply_B1_merge_reg_aunroll_x_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_out_matrix_multiply_B1_merge_reg_aunroll_x_fromReg0 <= (others => '0');
            SE_out_matrix_multiply_B1_merge_reg_aunroll_x_fromReg1 <= (others => '0');
            SE_out_matrix_multiply_B1_merge_reg_aunroll_x_fromReg2 <= (others => '0');
            SE_out_matrix_multiply_B1_merge_reg_aunroll_x_fromReg3 <= (others => '0');
            SE_out_matrix_multiply_B1_merge_reg_aunroll_x_fromReg4 <= (others => '0');
            SE_out_matrix_multiply_B1_merge_reg_aunroll_x_fromReg5 <= (others => '0');
            SE_out_matrix_multiply_B1_merge_reg_aunroll_x_fromReg6 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Succesor 0
            SE_out_matrix_multiply_B1_merge_reg_aunroll_x_fromReg0 <= SE_out_matrix_multiply_B1_merge_reg_aunroll_x_toReg0;
            -- Succesor 1
            SE_out_matrix_multiply_B1_merge_reg_aunroll_x_fromReg1 <= SE_out_matrix_multiply_B1_merge_reg_aunroll_x_toReg1;
            -- Succesor 2
            SE_out_matrix_multiply_B1_merge_reg_aunroll_x_fromReg2 <= SE_out_matrix_multiply_B1_merge_reg_aunroll_x_toReg2;
            -- Succesor 3
            SE_out_matrix_multiply_B1_merge_reg_aunroll_x_fromReg3 <= SE_out_matrix_multiply_B1_merge_reg_aunroll_x_toReg3;
            -- Succesor 4
            SE_out_matrix_multiply_B1_merge_reg_aunroll_x_fromReg4 <= SE_out_matrix_multiply_B1_merge_reg_aunroll_x_toReg4;
            -- Succesor 5
            SE_out_matrix_multiply_B1_merge_reg_aunroll_x_fromReg5 <= SE_out_matrix_multiply_B1_merge_reg_aunroll_x_toReg5;
            -- Succesor 6
            SE_out_matrix_multiply_B1_merge_reg_aunroll_x_fromReg6 <= SE_out_matrix_multiply_B1_merge_reg_aunroll_x_toReg6;
        END IF;
    END PROCESS;
    -- Input Stall processing
    SE_out_matrix_multiply_B1_merge_reg_aunroll_x_consumed0 <= (not (bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_1_reg_stall_out) and SE_out_matrix_multiply_B1_merge_reg_aunroll_x_wireValid) or SE_out_matrix_multiply_B1_merge_reg_aunroll_x_fromReg0;
    SE_out_matrix_multiply_B1_merge_reg_aunroll_x_consumed1 <= (not (bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_4_reg_stall_out) and SE_out_matrix_multiply_B1_merge_reg_aunroll_x_wireValid) or SE_out_matrix_multiply_B1_merge_reg_aunroll_x_fromReg1;
    SE_out_matrix_multiply_B1_merge_reg_aunroll_x_consumed2 <= (not (bubble_out_matrix_multiply_B1_merge_reg_aunroll_x_5_reg_stall_out) and SE_out_matrix_multiply_B1_merge_reg_aunroll_x_wireValid) or SE_out_matrix_multiply_B1_merge_reg_aunroll_x_fromReg2;
    SE_out_matrix_multiply_B1_merge_reg_aunroll_x_consumed3 <= (not (SR_SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_backStall) and SE_out_matrix_multiply_B1_merge_reg_aunroll_x_wireValid) or SE_out_matrix_multiply_B1_merge_reg_aunroll_x_fromReg3;
    SE_out_matrix_multiply_B1_merge_reg_aunroll_x_consumed4 <= (not (redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_stall_out) and SE_out_matrix_multiply_B1_merge_reg_aunroll_x_wireValid) or SE_out_matrix_multiply_B1_merge_reg_aunroll_x_fromReg4;
    SE_out_matrix_multiply_B1_merge_reg_aunroll_x_consumed5 <= (not (redist5_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_2_170_fifo_stall_out) and SE_out_matrix_multiply_B1_merge_reg_aunroll_x_wireValid) or SE_out_matrix_multiply_B1_merge_reg_aunroll_x_fromReg5;
    SE_out_matrix_multiply_B1_merge_reg_aunroll_x_consumed6 <= (not (redist8_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_4_170_fifo_stall_out) and SE_out_matrix_multiply_B1_merge_reg_aunroll_x_wireValid) or SE_out_matrix_multiply_B1_merge_reg_aunroll_x_fromReg6;
    -- Consuming
    SE_out_matrix_multiply_B1_merge_reg_aunroll_x_StallValid <= SE_out_matrix_multiply_B1_merge_reg_aunroll_x_backStall and SE_out_matrix_multiply_B1_merge_reg_aunroll_x_wireValid;
    SE_out_matrix_multiply_B1_merge_reg_aunroll_x_toReg0 <= SE_out_matrix_multiply_B1_merge_reg_aunroll_x_StallValid and SE_out_matrix_multiply_B1_merge_reg_aunroll_x_consumed0;
    SE_out_matrix_multiply_B1_merge_reg_aunroll_x_toReg1 <= SE_out_matrix_multiply_B1_merge_reg_aunroll_x_StallValid and SE_out_matrix_multiply_B1_merge_reg_aunroll_x_consumed1;
    SE_out_matrix_multiply_B1_merge_reg_aunroll_x_toReg2 <= SE_out_matrix_multiply_B1_merge_reg_aunroll_x_StallValid and SE_out_matrix_multiply_B1_merge_reg_aunroll_x_consumed2;
    SE_out_matrix_multiply_B1_merge_reg_aunroll_x_toReg3 <= SE_out_matrix_multiply_B1_merge_reg_aunroll_x_StallValid and SE_out_matrix_multiply_B1_merge_reg_aunroll_x_consumed3;
    SE_out_matrix_multiply_B1_merge_reg_aunroll_x_toReg4 <= SE_out_matrix_multiply_B1_merge_reg_aunroll_x_StallValid and SE_out_matrix_multiply_B1_merge_reg_aunroll_x_consumed4;
    SE_out_matrix_multiply_B1_merge_reg_aunroll_x_toReg5 <= SE_out_matrix_multiply_B1_merge_reg_aunroll_x_StallValid and SE_out_matrix_multiply_B1_merge_reg_aunroll_x_consumed5;
    SE_out_matrix_multiply_B1_merge_reg_aunroll_x_toReg6 <= SE_out_matrix_multiply_B1_merge_reg_aunroll_x_StallValid and SE_out_matrix_multiply_B1_merge_reg_aunroll_x_consumed6;
    -- Backward Stall generation
    SE_out_matrix_multiply_B1_merge_reg_aunroll_x_or0 <= SE_out_matrix_multiply_B1_merge_reg_aunroll_x_consumed0;
    SE_out_matrix_multiply_B1_merge_reg_aunroll_x_or1 <= SE_out_matrix_multiply_B1_merge_reg_aunroll_x_consumed1 and SE_out_matrix_multiply_B1_merge_reg_aunroll_x_or0;
    SE_out_matrix_multiply_B1_merge_reg_aunroll_x_or2 <= SE_out_matrix_multiply_B1_merge_reg_aunroll_x_consumed2 and SE_out_matrix_multiply_B1_merge_reg_aunroll_x_or1;
    SE_out_matrix_multiply_B1_merge_reg_aunroll_x_or3 <= SE_out_matrix_multiply_B1_merge_reg_aunroll_x_consumed3 and SE_out_matrix_multiply_B1_merge_reg_aunroll_x_or2;
    SE_out_matrix_multiply_B1_merge_reg_aunroll_x_or4 <= SE_out_matrix_multiply_B1_merge_reg_aunroll_x_consumed4 and SE_out_matrix_multiply_B1_merge_reg_aunroll_x_or3;
    SE_out_matrix_multiply_B1_merge_reg_aunroll_x_or5 <= SE_out_matrix_multiply_B1_merge_reg_aunroll_x_consumed5 and SE_out_matrix_multiply_B1_merge_reg_aunroll_x_or4;
    SE_out_matrix_multiply_B1_merge_reg_aunroll_x_wireStall <= not (SE_out_matrix_multiply_B1_merge_reg_aunroll_x_consumed6 and SE_out_matrix_multiply_B1_merge_reg_aunroll_x_or5);
    SE_out_matrix_multiply_B1_merge_reg_aunroll_x_backStall <= SE_out_matrix_multiply_B1_merge_reg_aunroll_x_wireStall;
    -- Valid signal propagation
    SE_out_matrix_multiply_B1_merge_reg_aunroll_x_V0 <= SE_out_matrix_multiply_B1_merge_reg_aunroll_x_wireValid and not (SE_out_matrix_multiply_B1_merge_reg_aunroll_x_fromReg0);
    SE_out_matrix_multiply_B1_merge_reg_aunroll_x_V1 <= SE_out_matrix_multiply_B1_merge_reg_aunroll_x_wireValid and not (SE_out_matrix_multiply_B1_merge_reg_aunroll_x_fromReg1);
    SE_out_matrix_multiply_B1_merge_reg_aunroll_x_V2 <= SE_out_matrix_multiply_B1_merge_reg_aunroll_x_wireValid and not (SE_out_matrix_multiply_B1_merge_reg_aunroll_x_fromReg2);
    SE_out_matrix_multiply_B1_merge_reg_aunroll_x_V3 <= SE_out_matrix_multiply_B1_merge_reg_aunroll_x_wireValid and not (SE_out_matrix_multiply_B1_merge_reg_aunroll_x_fromReg3);
    SE_out_matrix_multiply_B1_merge_reg_aunroll_x_V4 <= SE_out_matrix_multiply_B1_merge_reg_aunroll_x_wireValid and not (SE_out_matrix_multiply_B1_merge_reg_aunroll_x_fromReg4);
    SE_out_matrix_multiply_B1_merge_reg_aunroll_x_V5 <= SE_out_matrix_multiply_B1_merge_reg_aunroll_x_wireValid and not (SE_out_matrix_multiply_B1_merge_reg_aunroll_x_fromReg5);
    SE_out_matrix_multiply_B1_merge_reg_aunroll_x_V6 <= SE_out_matrix_multiply_B1_merge_reg_aunroll_x_wireValid and not (SE_out_matrix_multiply_B1_merge_reg_aunroll_x_fromReg6);
    -- Computing multiple Valid(s)
    SE_out_matrix_multiply_B1_merge_reg_aunroll_x_wireValid <= matrix_multiply_B1_merge_reg_aunroll_x_out_valid_out;

    -- SR_SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0(STALLREG,409)
    SR_SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SR_SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_r_valid <= (others => '0');
            SR_SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_r_data0 <= (others => '-');
            SR_SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_r_data1 <= (others => '-');
            SR_SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_r_data2 <= (others => '-');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Valid
            SR_SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_r_valid <= SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_backStall and (SR_SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_r_valid or SR_SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_i_valid);

            IF (SR_SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_r_valid = "0") THEN
                -- Data(s)
                SR_SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_r_data0 <= STD_LOGIC_VECTOR(bubble_select_matrix_multiply_B1_merge_reg_aunroll_x_b);
                SR_SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_r_data1 <= STD_LOGIC_VECTOR(bubble_select_matrix_multiply_B1_merge_reg_aunroll_x_e);
                SR_SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_r_data2 <= STD_LOGIC_VECTOR(bgTrunc_i_add_matrix_multiply_sel_x_b);
            END IF;

        END IF;
    END PROCESS;
    -- Computing multiple Valid(s)
    SR_SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_i_valid <= SE_out_matrix_multiply_B1_merge_reg_aunroll_x_V3;
    -- Stall signal propagation
    SR_SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_backStall <= SR_SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_r_valid or not (SR_SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_i_valid);

    -- Valid
    SR_SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_V <= SR_SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_r_valid WHEN SR_SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_r_valid = "1" ELSE SR_SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_i_valid;

    -- Data0
    SR_SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_D0 <= SR_SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_r_data0 WHEN SR_SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_r_valid = "1" ELSE bubble_select_matrix_multiply_B1_merge_reg_aunroll_x_b;
    -- Data1
    SR_SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_D1 <= SR_SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_r_data1 WHEN SR_SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_r_valid = "1" ELSE bubble_select_matrix_multiply_B1_merge_reg_aunroll_x_e;
    -- Data2
    SR_SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_D2 <= SR_SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_r_data2 WHEN SR_SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_r_valid = "1" ELSE bgTrunc_i_add_matrix_multiply_sel_x_b;

    -- redist6_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_3_1_0(REG,171)
    redist6_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_3_1_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist6_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_3_1_0_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_backEN = "1") THEN
                redist6_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_3_1_0_q <= STD_LOGIC_VECTOR(SR_SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_D1);
            END IF;
        END IF;
    END PROCESS;

    -- SE_out_i_syncbuf_n_sync_buffer_matrix_multiply(STALLENABLE,267)
    -- Valid signal propagation
    SE_out_i_syncbuf_n_sync_buffer_matrix_multiply_V0 <= SE_out_i_syncbuf_n_sync_buffer_matrix_multiply_wireValid;
    -- Backward Stall generation
    SE_out_i_syncbuf_n_sync_buffer_matrix_multiply_backStall <= SR_SE_i_cmp_neg_rm_matrix_multiply_backStall or not (SE_out_i_syncbuf_n_sync_buffer_matrix_multiply_wireValid);
    -- Computing multiple Valid(s)
    SE_out_i_syncbuf_n_sync_buffer_matrix_multiply_wireValid <= i_syncbuf_n_sync_buffer_matrix_multiply_out_valid_out;

    -- SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0(STALLENABLE,307)
    -- Valid signal propagation
    SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_V0 <= SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_R_v_0;
    SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_V1 <= SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_R_v_1;
    SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_V2 <= SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_R_v_2;
    SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_V3 <= SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_R_v_3;
    SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_V4 <= SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_R_v_4;
    -- Stall signal propagation
    SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_s_tv_0 <= SR_SE_i_cmp_neg_rm_matrix_multiply_backStall and SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_R_v_0;
    SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_s_tv_1 <= redist7_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_3_170_fifo_stall_out and SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_R_v_1;
    SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_s_tv_2 <= i_syncbuf_p_sync_buffer_matrix_multiply_out_stall_out and SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_R_v_2;
    SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_s_tv_3 <= i_syncbuf_n_sync_buffer_matrix_multiply_out_stall_out and SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_R_v_3;
    SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_s_tv_4 <= SR_SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_backStall and SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_R_v_4;
    -- Backward Enable generation
    SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_or0 <= SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_s_tv_0;
    SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_or1 <= SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_s_tv_1 or SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_or0;
    SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_or2 <= SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_s_tv_2 or SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_or1;
    SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_or3 <= SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_s_tv_3 or SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_or2;
    SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_backEN <= not (SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_s_tv_4 or SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_or3);
    -- Determine whether to write valid data into the first register stage
    SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_v_s_0 <= SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_backEN and SR_SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_V;
    -- Backward Stall generation
    SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_backStall <= not (SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_backEN);
    SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_R_v_0 <= (others => '0');
            SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_R_v_1 <= (others => '0');
            SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_R_v_2 <= (others => '0');
            SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_R_v_3 <= (others => '0');
            SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_R_v_4 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_backEN = "0") THEN
                SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_R_v_0 <= SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_R_v_0 and SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_s_tv_0;
            ELSE
                SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_R_v_0 <= SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_v_s_0;
            END IF;

            IF (SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_backEN = "0") THEN
                SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_R_v_1 <= SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_R_v_1 and SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_s_tv_1;
            ELSE
                SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_R_v_1 <= SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_v_s_0;
            END IF;

            IF (SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_backEN = "0") THEN
                SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_R_v_2 <= SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_R_v_2 and SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_s_tv_2;
            ELSE
                SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_R_v_2 <= SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_v_s_0;
            END IF;

            IF (SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_backEN = "0") THEN
                SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_R_v_3 <= SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_R_v_3 and SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_s_tv_3;
            ELSE
                SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_R_v_3 <= SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_v_s_0;
            END IF;

            IF (SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_backEN = "0") THEN
                SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_R_v_4 <= SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_R_v_4 and SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_s_tv_4;
            ELSE
                SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_R_v_4 <= SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SR_SE_i_cmp_neg_rm_matrix_multiply(STALLREG,413)
    SR_SE_i_cmp_neg_rm_matrix_multiply_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SR_SE_i_cmp_neg_rm_matrix_multiply_r_valid <= (others => '0');
            SR_SE_i_cmp_neg_rm_matrix_multiply_r_data0 <= (others => '-');
            SR_SE_i_cmp_neg_rm_matrix_multiply_r_data1 <= (others => '-');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Valid
            SR_SE_i_cmp_neg_rm_matrix_multiply_r_valid <= SE_i_cmp_neg_rm_matrix_multiply_backStall and (SR_SE_i_cmp_neg_rm_matrix_multiply_r_valid or SR_SE_i_cmp_neg_rm_matrix_multiply_i_valid);

            IF (SR_SE_i_cmp_neg_rm_matrix_multiply_r_valid = "0") THEN
                -- Data(s)
                SR_SE_i_cmp_neg_rm_matrix_multiply_r_data0 <= STD_LOGIC_VECTOR(redist6_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_3_1_0_q);
                SR_SE_i_cmp_neg_rm_matrix_multiply_r_data1 <= STD_LOGIC_VECTOR(bubble_select_i_syncbuf_n_sync_buffer_matrix_multiply_b);
            END IF;

        END IF;
    END PROCESS;
    -- Computing multiple Valid(s)
    SR_SE_i_cmp_neg_rm_matrix_multiply_and0 <= SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_V0;
    SR_SE_i_cmp_neg_rm_matrix_multiply_i_valid <= SE_out_i_syncbuf_n_sync_buffer_matrix_multiply_V0 and SR_SE_i_cmp_neg_rm_matrix_multiply_and0;
    -- Stall signal propagation
    SR_SE_i_cmp_neg_rm_matrix_multiply_backStall <= SR_SE_i_cmp_neg_rm_matrix_multiply_r_valid or not (SR_SE_i_cmp_neg_rm_matrix_multiply_i_valid);

    -- Valid
    SR_SE_i_cmp_neg_rm_matrix_multiply_V <= SR_SE_i_cmp_neg_rm_matrix_multiply_r_valid WHEN SR_SE_i_cmp_neg_rm_matrix_multiply_r_valid = "1" ELSE SR_SE_i_cmp_neg_rm_matrix_multiply_i_valid;

    -- Data0
    SR_SE_i_cmp_neg_rm_matrix_multiply_D0 <= SR_SE_i_cmp_neg_rm_matrix_multiply_r_data0 WHEN SR_SE_i_cmp_neg_rm_matrix_multiply_r_valid = "1" ELSE redist6_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_3_1_0_q;
    -- Data1
    SR_SE_i_cmp_neg_rm_matrix_multiply_D1 <= SR_SE_i_cmp_neg_rm_matrix_multiply_r_data1 WHEN SR_SE_i_cmp_neg_rm_matrix_multiply_r_valid = "1" ELSE bubble_select_i_syncbuf_n_sync_buffer_matrix_multiply_b;

    -- i_cmp_neg_rm_matrix_multiply(COMPARE,64)@2 + 1
    i_cmp_neg_rm_matrix_multiply_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 32 => SR_SE_i_cmp_neg_rm_matrix_multiply_D0(31)) & SR_SE_i_cmp_neg_rm_matrix_multiply_D0));
    i_cmp_neg_rm_matrix_multiply_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 32 => SR_SE_i_cmp_neg_rm_matrix_multiply_D1(31)) & SR_SE_i_cmp_neg_rm_matrix_multiply_D1));
    i_cmp_neg_rm_matrix_multiply_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            i_cmp_neg_rm_matrix_multiply_o <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_i_cmp_neg_rm_matrix_multiply_backEN = "1") THEN
                i_cmp_neg_rm_matrix_multiply_o <= STD_LOGIC_VECTOR(SIGNED(i_cmp_neg_rm_matrix_multiply_a) - SIGNED(i_cmp_neg_rm_matrix_multiply_b));
            END IF;
        END IF;
    END PROCESS;
    i_cmp_neg_rm_matrix_multiply_n(0) <= not (i_cmp_neg_rm_matrix_multiply_o(33));

    -- SE_i_cmp_neg_rm_matrix_multiply(STALLENABLE,254)
    -- Valid signal propagation
    SE_i_cmp_neg_rm_matrix_multiply_V0 <= SE_i_cmp_neg_rm_matrix_multiply_R_v_0;
    SE_i_cmp_neg_rm_matrix_multiply_V1 <= SE_i_cmp_neg_rm_matrix_multiply_R_v_1;
    -- Stall signal propagation
    SE_i_cmp_neg_rm_matrix_multiply_s_tv_0 <= SE_i_cmp_neg_or_rm_matrix_multiply_backStall and SE_i_cmp_neg_rm_matrix_multiply_R_v_0;
    SE_i_cmp_neg_rm_matrix_multiply_s_tv_1 <= SR_SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_backStall and SE_i_cmp_neg_rm_matrix_multiply_R_v_1;
    -- Backward Enable generation
    SE_i_cmp_neg_rm_matrix_multiply_or0 <= SE_i_cmp_neg_rm_matrix_multiply_s_tv_0;
    SE_i_cmp_neg_rm_matrix_multiply_backEN <= not (SE_i_cmp_neg_rm_matrix_multiply_s_tv_1 or SE_i_cmp_neg_rm_matrix_multiply_or0);
    -- Determine whether to write valid data into the first register stage
    SE_i_cmp_neg_rm_matrix_multiply_v_s_0 <= SE_i_cmp_neg_rm_matrix_multiply_backEN and SR_SE_i_cmp_neg_rm_matrix_multiply_V;
    -- Backward Stall generation
    SE_i_cmp_neg_rm_matrix_multiply_backStall <= not (SE_i_cmp_neg_rm_matrix_multiply_backEN);
    SE_i_cmp_neg_rm_matrix_multiply_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_i_cmp_neg_rm_matrix_multiply_R_v_0 <= (others => '0');
            SE_i_cmp_neg_rm_matrix_multiply_R_v_1 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_i_cmp_neg_rm_matrix_multiply_backEN = "0") THEN
                SE_i_cmp_neg_rm_matrix_multiply_R_v_0 <= SE_i_cmp_neg_rm_matrix_multiply_R_v_0 and SE_i_cmp_neg_rm_matrix_multiply_s_tv_0;
            ELSE
                SE_i_cmp_neg_rm_matrix_multiply_R_v_0 <= SE_i_cmp_neg_rm_matrix_multiply_v_s_0;
            END IF;

            IF (SE_i_cmp_neg_rm_matrix_multiply_backEN = "0") THEN
                SE_i_cmp_neg_rm_matrix_multiply_R_v_1 <= SE_i_cmp_neg_rm_matrix_multiply_R_v_1 and SE_i_cmp_neg_rm_matrix_multiply_s_tv_1;
            ELSE
                SE_i_cmp_neg_rm_matrix_multiply_R_v_1 <= SE_i_cmp_neg_rm_matrix_multiply_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SR_SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0(STALLREG,414)
    SR_SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SR_SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_r_valid <= (others => '0');
            SR_SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_r_data0 <= (others => '-');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Valid
            SR_SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_r_valid <= SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_backStall and (SR_SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_r_valid or SR_SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_i_valid);

            IF (SR_SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_r_valid = "0") THEN
                -- Data(s)
                SR_SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_r_data0 <= STD_LOGIC_VECTOR(i_cmp_neg_rm_matrix_multiply_n);
            END IF;

        END IF;
    END PROCESS;
    -- Computing multiple Valid(s)
    SR_SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_i_valid <= SE_i_cmp_neg_rm_matrix_multiply_V1;
    -- Stall signal propagation
    SR_SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_backStall <= SR_SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_r_valid or not (SR_SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_i_valid);

    -- Valid
    SR_SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_V <= SR_SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_r_valid WHEN SR_SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_r_valid = "1" ELSE SR_SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_i_valid;

    SR_SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_D0 <= SR_SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_r_data0 WHEN SR_SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_r_valid = "1" ELSE i_cmp_neg_rm_matrix_multiply_n;

    -- redist1_i_cmp_neg_rm_matrix_multiply_n_2_0(REG,166)
    redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_q <= "0";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_backEN = "1") THEN
                redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_q <= STD_LOGIC_VECTOR(SR_SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_D0);
            END IF;
        END IF;
    END PROCESS;

    -- redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0(REG,167)
    redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_q <= "0";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_backEN = "1") THEN
                redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_q <= STD_LOGIC_VECTOR(SR_SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_D0);
            END IF;
        END IF;
    END PROCESS;

    -- andEq_uid139_i_exitcond_matrix_multiply(LOGICAL,138)@3 + 1
    andEq_uid139_i_exitcond_matrix_multiply_qi <= SR_SE_y0_uid134_i_exitcond_matrix_multiply_D0 and SR_SE_y0_uid134_i_exitcond_matrix_multiply_D1;
    andEq_uid139_i_exitcond_matrix_multiply_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => andEq_uid139_i_exitcond_matrix_multiply_qi, xout => andEq_uid139_i_exitcond_matrix_multiply_q, ena => SE_andEq_uid139_i_exitcond_matrix_multiply_backEN(0), clk => clock, aclr => resetn );

    -- i_exitcond_guard_matrix_multiply(LOGICAL,66)@4
    i_exitcond_guard_matrix_multiply_q <= andEq_uid139_i_exitcond_matrix_multiply_q or redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_q;

    -- SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0(STALLENABLE,305)
    -- Valid signal propagation
    SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_V0 <= SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_R_v_0;
    -- Stall signal propagation
    SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_s_tv_0 <= SR_SE_i_exitcond_guard_guard_matrix_multiply_backStall and SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_R_v_0;
    -- Backward Enable generation
    SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_backEN <= not (SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_v_s_0 <= SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_backEN and SR_SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_V;
    -- Backward Stall generation
    SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_backStall <= not (SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_backEN);
    SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_backEN = "0") THEN
                SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_R_v_0 <= SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_R_v_0 and SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_s_tv_0;
            ELSE
                SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_R_v_0 <= SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SE_i_exitcond_guard_matrix_multiply(STALLENABLE,256)
    -- Valid signal propagation
    SE_i_exitcond_guard_matrix_multiply_V0 <= SE_i_exitcond_guard_matrix_multiply_wireValid;
    -- Backward Stall generation
    SE_i_exitcond_guard_matrix_multiply_backStall <= SR_SE_i_exitcond_guard_guard_matrix_multiply_backStall or not (SE_i_exitcond_guard_matrix_multiply_wireValid);
    -- Computing multiple Valid(s)
    SE_i_exitcond_guard_matrix_multiply_and0 <= SE_andEq_uid139_i_exitcond_matrix_multiply_V0;
    SE_i_exitcond_guard_matrix_multiply_wireValid <= SE_redist2_i_cmp21_neg_rm_matrix_multiply_c_2_0_V0 and SE_i_exitcond_guard_matrix_multiply_and0;

    -- SR_SE_i_exitcond_guard_guard_matrix_multiply(STALLREG,415)
    SR_SE_i_exitcond_guard_guard_matrix_multiply_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SR_SE_i_exitcond_guard_guard_matrix_multiply_r_valid <= (others => '0');
            SR_SE_i_exitcond_guard_guard_matrix_multiply_r_data0 <= (others => '-');
            SR_SE_i_exitcond_guard_guard_matrix_multiply_r_data1 <= (others => '-');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Valid
            SR_SE_i_exitcond_guard_guard_matrix_multiply_r_valid <= SE_i_exitcond_guard_guard_matrix_multiply_backStall and (SR_SE_i_exitcond_guard_guard_matrix_multiply_r_valid or SR_SE_i_exitcond_guard_guard_matrix_multiply_i_valid);

            IF (SR_SE_i_exitcond_guard_guard_matrix_multiply_r_valid = "0") THEN
                -- Data(s)
                SR_SE_i_exitcond_guard_guard_matrix_multiply_r_data0 <= i_exitcond_guard_matrix_multiply_q;
                SR_SE_i_exitcond_guard_guard_matrix_multiply_r_data1 <= redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_q;
            END IF;

        END IF;
    END PROCESS;
    -- Computing multiple Valid(s)
    SR_SE_i_exitcond_guard_guard_matrix_multiply_and0 <= SE_i_exitcond_guard_matrix_multiply_V0;
    SR_SE_i_exitcond_guard_guard_matrix_multiply_i_valid <= SE_redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_V0 and SR_SE_i_exitcond_guard_guard_matrix_multiply_and0;
    -- Stall signal propagation
    SR_SE_i_exitcond_guard_guard_matrix_multiply_backStall <= SR_SE_i_exitcond_guard_guard_matrix_multiply_r_valid or not (SR_SE_i_exitcond_guard_guard_matrix_multiply_i_valid);

    -- Valid
    SR_SE_i_exitcond_guard_guard_matrix_multiply_V <= SR_SE_i_exitcond_guard_guard_matrix_multiply_r_valid WHEN SR_SE_i_exitcond_guard_guard_matrix_multiply_r_valid = "1" ELSE SR_SE_i_exitcond_guard_guard_matrix_multiply_i_valid;

    -- Data0
    SR_SE_i_exitcond_guard_guard_matrix_multiply_D0 <= SR_SE_i_exitcond_guard_guard_matrix_multiply_r_data0 WHEN SR_SE_i_exitcond_guard_guard_matrix_multiply_r_valid = "1" ELSE i_exitcond_guard_matrix_multiply_q;
    -- Data1
    SR_SE_i_exitcond_guard_guard_matrix_multiply_D1 <= SR_SE_i_exitcond_guard_guard_matrix_multiply_r_data1 WHEN SR_SE_i_exitcond_guard_guard_matrix_multiply_r_valid = "1" ELSE redist1_i_cmp_neg_rm_matrix_multiply_n_2_0_q;

    -- i_exitcond_guard_guard_matrix_multiply(LOGICAL,65)@4 + 1
    i_exitcond_guard_guard_matrix_multiply_qi <= SR_SE_i_exitcond_guard_guard_matrix_multiply_D0 or SR_SE_i_exitcond_guard_guard_matrix_multiply_D1;
    i_exitcond_guard_guard_matrix_multiply_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => i_exitcond_guard_guard_matrix_multiply_qi, xout => i_exitcond_guard_guard_matrix_multiply_q, ena => SE_i_exitcond_guard_guard_matrix_multiply_backEN(0), clk => clock, aclr => resetn );

    -- SE_i_exitcond_guard_guard_matrix_multiply(STALLENABLE,255)
    -- Valid signal propagation
    SE_i_exitcond_guard_guard_matrix_multiply_V0 <= SE_i_exitcond_guard_guard_matrix_multiply_R_v_0;
    -- Stall signal propagation
    SE_i_exitcond_guard_guard_matrix_multiply_s_tv_0 <= redist0_i_exitcond_guard_guard_matrix_multiply_q_167_fifo_stall_out and SE_i_exitcond_guard_guard_matrix_multiply_R_v_0;
    -- Backward Enable generation
    SE_i_exitcond_guard_guard_matrix_multiply_backEN <= not (SE_i_exitcond_guard_guard_matrix_multiply_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_i_exitcond_guard_guard_matrix_multiply_v_s_0 <= SE_i_exitcond_guard_guard_matrix_multiply_backEN and SR_SE_i_exitcond_guard_guard_matrix_multiply_V;
    -- Backward Stall generation
    SE_i_exitcond_guard_guard_matrix_multiply_backStall <= not (SE_i_exitcond_guard_guard_matrix_multiply_backEN);
    SE_i_exitcond_guard_guard_matrix_multiply_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_i_exitcond_guard_guard_matrix_multiply_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_i_exitcond_guard_guard_matrix_multiply_backEN = "0") THEN
                SE_i_exitcond_guard_guard_matrix_multiply_R_v_0 <= SE_i_exitcond_guard_guard_matrix_multiply_R_v_0 and SE_i_exitcond_guard_guard_matrix_multiply_s_tv_0;
            ELSE
                SE_i_exitcond_guard_guard_matrix_multiply_R_v_0 <= SE_i_exitcond_guard_guard_matrix_multiply_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- redist0_i_exitcond_guard_guard_matrix_multiply_q_167_fifo(STALLFIFO,165)
    redist0_i_exitcond_guard_guard_matrix_multiply_q_167_fifo_valid_in <= SE_i_exitcond_guard_guard_matrix_multiply_V0;
    redist0_i_exitcond_guard_guard_matrix_multiply_q_167_fifo_stall_in <= SE_out_bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_backStall;
    redist0_i_exitcond_guard_guard_matrix_multiply_q_167_fifo_data_in <= i_exitcond_guard_guard_matrix_multiply_q;
    redist0_i_exitcond_guard_guard_matrix_multiply_q_167_fifo_valid_in_bitsignaltemp <= redist0_i_exitcond_guard_guard_matrix_multiply_q_167_fifo_valid_in(0);
    redist0_i_exitcond_guard_guard_matrix_multiply_q_167_fifo_stall_in_bitsignaltemp <= redist0_i_exitcond_guard_guard_matrix_multiply_q_167_fifo_stall_in(0);
    redist0_i_exitcond_guard_guard_matrix_multiply_q_167_fifo_valid_out(0) <= redist0_i_exitcond_guard_guard_matrix_multiply_q_167_fifo_valid_out_bitsignaltemp;
    redist0_i_exitcond_guard_guard_matrix_multiply_q_167_fifo_stall_out(0) <= redist0_i_exitcond_guard_guard_matrix_multiply_q_167_fifo_stall_out_bitsignaltemp;
    theredist0_i_exitcond_guard_guard_matrix_multiply_q_167_fifo : acl_data_fifo
    GENERIC MAP (
        DEPTH => 167,
        STRICT_DEPTH => 0,
        ALLOW_FULL_WRITE => 0,
        DATA_WIDTH => 1,
        IMPL => "ram"
    )
    PORT MAP (
        valid_in => redist0_i_exitcond_guard_guard_matrix_multiply_q_167_fifo_valid_in_bitsignaltemp,
        stall_in => redist0_i_exitcond_guard_guard_matrix_multiply_q_167_fifo_stall_in_bitsignaltemp,
        data_in => i_exitcond_guard_guard_matrix_multiply_q,
        valid_out => redist0_i_exitcond_guard_guard_matrix_multiply_q_167_fifo_valid_out_bitsignaltemp,
        stall_out => redist0_i_exitcond_guard_guard_matrix_multiply_q_167_fifo_stall_out_bitsignaltemp,
        data_out => redist0_i_exitcond_guard_guard_matrix_multiply_q_167_fifo_data_out,
        clock => clock,
        resetn => resetn
    );

    -- redist5_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_2_170_fifo(STALLFIFO,170)
    redist5_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_2_170_fifo_valid_in <= SE_out_matrix_multiply_B1_merge_reg_aunroll_x_V5;
    redist5_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_2_170_fifo_stall_in <= SE_out_bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_backStall;
    redist5_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_2_170_fifo_data_in <= bubble_select_matrix_multiply_B1_merge_reg_aunroll_x_d;
    redist5_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_2_170_fifo_valid_in_bitsignaltemp <= redist5_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_2_170_fifo_valid_in(0);
    redist5_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_2_170_fifo_stall_in_bitsignaltemp <= redist5_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_2_170_fifo_stall_in(0);
    redist5_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_2_170_fifo_valid_out(0) <= redist5_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_2_170_fifo_valid_out_bitsignaltemp;
    redist5_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_2_170_fifo_stall_out(0) <= redist5_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_2_170_fifo_stall_out_bitsignaltemp;
    theredist5_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_2_170_fifo : acl_data_fifo
    GENERIC MAP (
        DEPTH => 171,
        STRICT_DEPTH => 0,
        ALLOW_FULL_WRITE => 0,
        DATA_WIDTH => 32,
        IMPL => "ram"
    )
    PORT MAP (
        valid_in => redist5_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_2_170_fifo_valid_in_bitsignaltemp,
        stall_in => redist5_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_2_170_fifo_stall_in_bitsignaltemp,
        data_in => bubble_select_matrix_multiply_B1_merge_reg_aunroll_x_d,
        valid_out => redist5_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_2_170_fifo_valid_out_bitsignaltemp,
        stall_out => redist5_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_2_170_fifo_stall_out_bitsignaltemp,
        data_out => redist5_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_2_170_fifo_data_out,
        clock => clock,
        resetn => resetn
    );

    -- redist7_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_3_170_fifo(STALLFIFO,172)
    redist7_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_3_170_fifo_valid_in <= SE_redist3_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_0_1_0_V1;
    redist7_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_3_170_fifo_stall_in <= SE_out_bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_backStall;
    redist7_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_3_170_fifo_data_in <= redist6_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_3_1_0_q;
    redist7_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_3_170_fifo_valid_in_bitsignaltemp <= redist7_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_3_170_fifo_valid_in(0);
    redist7_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_3_170_fifo_stall_in_bitsignaltemp <= redist7_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_3_170_fifo_stall_in(0);
    redist7_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_3_170_fifo_valid_out(0) <= redist7_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_3_170_fifo_valid_out_bitsignaltemp;
    redist7_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_3_170_fifo_stall_out(0) <= redist7_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_3_170_fifo_stall_out_bitsignaltemp;
    theredist7_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_3_170_fifo : acl_data_fifo
    GENERIC MAP (
        DEPTH => 170,
        STRICT_DEPTH => 0,
        ALLOW_FULL_WRITE => 0,
        DATA_WIDTH => 32,
        IMPL => "ram"
    )
    PORT MAP (
        valid_in => redist7_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_3_170_fifo_valid_in_bitsignaltemp,
        stall_in => redist7_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_3_170_fifo_stall_in_bitsignaltemp,
        data_in => redist6_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_3_1_0_q,
        valid_out => redist7_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_3_170_fifo_valid_out_bitsignaltemp,
        stall_out => redist7_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_3_170_fifo_stall_out_bitsignaltemp,
        data_out => redist7_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_3_170_fifo_data_out,
        clock => clock,
        resetn => resetn
    );

    -- redist8_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_4_170_fifo(STALLFIFO,173)
    redist8_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_4_170_fifo_valid_in <= SE_out_matrix_multiply_B1_merge_reg_aunroll_x_V6;
    redist8_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_4_170_fifo_stall_in <= SE_out_bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_backStall;
    redist8_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_4_170_fifo_data_in <= bubble_select_matrix_multiply_B1_merge_reg_aunroll_x_f;
    redist8_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_4_170_fifo_valid_in_bitsignaltemp <= redist8_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_4_170_fifo_valid_in(0);
    redist8_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_4_170_fifo_stall_in_bitsignaltemp <= redist8_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_4_170_fifo_stall_in(0);
    redist8_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_4_170_fifo_valid_out(0) <= redist8_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_4_170_fifo_valid_out_bitsignaltemp;
    redist8_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_4_170_fifo_stall_out(0) <= redist8_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_4_170_fifo_stall_out_bitsignaltemp;
    theredist8_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_4_170_fifo : acl_data_fifo
    GENERIC MAP (
        DEPTH => 171,
        STRICT_DEPTH => 0,
        ALLOW_FULL_WRITE => 0,
        DATA_WIDTH => 32,
        IMPL => "ram"
    )
    PORT MAP (
        valid_in => redist8_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_4_170_fifo_valid_in_bitsignaltemp,
        stall_in => redist8_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_4_170_fifo_stall_in_bitsignaltemp,
        data_in => bubble_select_matrix_multiply_B1_merge_reg_aunroll_x_f,
        valid_out => redist8_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_4_170_fifo_valid_out_bitsignaltemp,
        stall_out => redist8_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_4_170_fifo_stall_out_bitsignaltemp,
        data_out => redist8_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_4_170_fifo_data_out,
        clock => clock,
        resetn => resetn
    );

    -- redist12_bgTrunc_i_inc_matrix_multiply_sel_x_b_169_fifo(STALLFIFO,177)
    redist12_bgTrunc_i_inc_matrix_multiply_sel_x_b_169_fifo_valid_in <= SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_V3;
    redist12_bgTrunc_i_inc_matrix_multiply_sel_x_b_169_fifo_stall_in <= SE_out_bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_backStall;
    redist12_bgTrunc_i_inc_matrix_multiply_sel_x_b_169_fifo_data_in <= redist11_bgTrunc_i_inc_matrix_multiply_sel_x_b_1_0_q;
    redist12_bgTrunc_i_inc_matrix_multiply_sel_x_b_169_fifo_valid_in_bitsignaltemp <= redist12_bgTrunc_i_inc_matrix_multiply_sel_x_b_169_fifo_valid_in(0);
    redist12_bgTrunc_i_inc_matrix_multiply_sel_x_b_169_fifo_stall_in_bitsignaltemp <= redist12_bgTrunc_i_inc_matrix_multiply_sel_x_b_169_fifo_stall_in(0);
    redist12_bgTrunc_i_inc_matrix_multiply_sel_x_b_169_fifo_valid_out(0) <= redist12_bgTrunc_i_inc_matrix_multiply_sel_x_b_169_fifo_valid_out_bitsignaltemp;
    redist12_bgTrunc_i_inc_matrix_multiply_sel_x_b_169_fifo_stall_out(0) <= redist12_bgTrunc_i_inc_matrix_multiply_sel_x_b_169_fifo_stall_out_bitsignaltemp;
    theredist12_bgTrunc_i_inc_matrix_multiply_sel_x_b_169_fifo : acl_data_fifo
    GENERIC MAP (
        DEPTH => 169,
        STRICT_DEPTH => 0,
        ALLOW_FULL_WRITE => 0,
        DATA_WIDTH => 32,
        IMPL => "ram"
    )
    PORT MAP (
        valid_in => redist12_bgTrunc_i_inc_matrix_multiply_sel_x_b_169_fifo_valid_in_bitsignaltemp,
        stall_in => redist12_bgTrunc_i_inc_matrix_multiply_sel_x_b_169_fifo_stall_in_bitsignaltemp,
        data_in => redist11_bgTrunc_i_inc_matrix_multiply_sel_x_b_1_0_q,
        valid_out => redist12_bgTrunc_i_inc_matrix_multiply_sel_x_b_169_fifo_valid_out_bitsignaltemp,
        stall_out => redist12_bgTrunc_i_inc_matrix_multiply_sel_x_b_169_fifo_stall_out_bitsignaltemp,
        data_out => redist12_bgTrunc_i_inc_matrix_multiply_sel_x_b_169_fifo_data_out,
        clock => clock,
        resetn => resetn
    );

    -- bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_reg(STALLFIFO,408)
    bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_reg_valid_in <= SE_out_i_syncbuf_p_sync_buffer3_matrix_multiply_V0;
    bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_reg_stall_in <= SE_out_bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_backStall;
    bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_reg_valid_in_bitsignaltemp <= bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_reg_valid_in(0);
    bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_reg_stall_in_bitsignaltemp <= bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_reg_stall_in(0);
    bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_reg_valid_out(0) <= bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_reg_valid_out_bitsignaltemp;
    bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_reg_stall_out(0) <= bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_reg_stall_out_bitsignaltemp;
    thebubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_reg : acl_valid_fifo_counter
    GENERIC MAP (
        DEPTH => 169,
        STRICT_DEPTH => 0,
        ALLOW_FULL_WRITE => 0,
        ASYNC_RESET => 1
    )
    PORT MAP (
        valid_in => bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_reg_valid_in_bitsignaltemp,
        stall_in => bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_reg_stall_in_bitsignaltemp,
        valid_out => bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_reg_valid_out_bitsignaltemp,
        stall_out => bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_reg_stall_out_bitsignaltemp,
        clock => clock,
        resetn => resetn
    );

    -- SE_out_bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1(STALLENABLE,368)
    -- Valid signal propagation
    SE_out_bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_V0 <= SE_out_bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_wireValid;
    -- Backward Stall generation
    SE_out_bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_backStall <= in_stall_in or not (SE_out_bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_wireValid);
    -- Computing multiple Valid(s)
    SE_out_bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_and0 <= bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_reg_valid_out;
    SE_out_bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_and1 <= redist12_bgTrunc_i_inc_matrix_multiply_sel_x_b_169_fifo_valid_out and SE_out_bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_and0;
    SE_out_bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_and2 <= redist8_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_4_170_fifo_valid_out and SE_out_bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_and1;
    SE_out_bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_and3 <= redist7_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_3_170_fifo_valid_out and SE_out_bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_and2;
    SE_out_bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_and4 <= redist5_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_2_170_fifo_valid_out and SE_out_bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_and3;
    SE_out_bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_and5 <= redist0_i_exitcond_guard_guard_matrix_multiply_q_167_fifo_valid_out and SE_out_bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_and4;
    SE_out_bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_wireValid <= i_sfc_c0_for_body_matrix_multiply_c0_enter6_matrix_multiply_aunroll_x_out_o_valid and SE_out_bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_and5;

    -- bubble_join_redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo(BITJOIN,221)
    bubble_join_redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_q <= redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_data_out;

    -- bubble_select_redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo(BITSELECT,222)
    bubble_select_redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_b <= STD_LOGIC_VECTOR(bubble_join_redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_q(63 downto 0));

    -- bubble_join_i_load_unnamed_matrix_multiply0_matrix_multiply(BITJOIN,192)
    bubble_join_i_load_unnamed_matrix_multiply0_matrix_multiply_q <= i_load_unnamed_matrix_multiply0_matrix_multiply_out_o_readdata;

    -- bubble_select_i_load_unnamed_matrix_multiply0_matrix_multiply(BITSELECT,193)
    bubble_select_i_load_unnamed_matrix_multiply0_matrix_multiply_b <= STD_LOGIC_VECTOR(bubble_join_i_load_unnamed_matrix_multiply0_matrix_multiply_q(63 downto 0));

    -- bubble_join_i_load_unnamed_matrix_multiply1_matrix_multiply(BITJOIN,195)
    bubble_join_i_load_unnamed_matrix_multiply1_matrix_multiply_q <= i_load_unnamed_matrix_multiply1_matrix_multiply_out_o_readdata;

    -- bubble_select_i_load_unnamed_matrix_multiply1_matrix_multiply(BITSELECT,196)
    bubble_select_i_load_unnamed_matrix_multiply1_matrix_multiply_b <= STD_LOGIC_VECTOR(bubble_join_i_load_unnamed_matrix_multiply1_matrix_multiply_q(63 downto 0));

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- i_sfc_c0_for_body_matrix_multiply_c0_enter6_matrix_multiply_aunroll_x(BLACKBOX,51)@121
    -- in in_i_stall@20000000
    -- out out_c0_exit9_0@171
    -- out out_c0_exit9_1@171
    -- out out_o_stall@20000000
    -- out out_o_valid@171
    thei_sfc_c0_for_body_matrix_multiply_c0_enter6_matrix_multiply_aunroll_x : i_sfc_c0_for_body_matrix_multiply_c0_enter6_matrix_multiply
    PORT MAP (
        in_c0_eni3_0 => GND_q,
        in_c0_eni3_1 => bubble_select_i_load_unnamed_matrix_multiply1_matrix_multiply_b,
        in_c0_eni3_2 => bubble_select_i_load_unnamed_matrix_multiply0_matrix_multiply_b,
        in_c0_eni3_3 => bubble_select_redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_b,
        in_i_stall => SE_out_bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_backStall,
        in_i_valid => SE_out_redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_V0,
        out_c0_exit9_1 => i_sfc_c0_for_body_matrix_multiply_c0_enter6_matrix_multiply_aunroll_x_out_c0_exit9_1,
        out_o_stall => i_sfc_c0_for_body_matrix_multiply_c0_enter6_matrix_multiply_aunroll_x_out_o_stall,
        out_o_valid => i_sfc_c0_for_body_matrix_multiply_c0_enter6_matrix_multiply_aunroll_x_out_o_valid,
        clock => clock,
        resetn => resetn
    );

    -- i_load_unnamed_matrix_multiply0_matrix_multiply(BLACKBOX,73)@3
    -- in in_i_stall@20000000
    -- out out_o_readdata@121
    -- out out_o_stall@20000000
    -- out out_o_valid@121
    -- out out_unnamed_matrix_multiply0_avm_address@20000000
    -- out out_unnamed_matrix_multiply0_avm_burstcount@20000000
    -- out out_unnamed_matrix_multiply0_avm_byteenable@20000000
    -- out out_unnamed_matrix_multiply0_avm_enable@20000000
    -- out out_unnamed_matrix_multiply0_avm_read@20000000
    -- out out_unnamed_matrix_multiply0_avm_write@20000000
    -- out out_unnamed_matrix_multiply0_avm_writedata@20000000
    thei_load_unnamed_matrix_multiply0_matrix_multiply : i_load_unnamed_matrix_multiply0_matrix_multiply20
    PORT MAP (
        in_flush => in_flush,
        in_i_address => SR_SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_D0,
        in_i_predicate => SR_SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_D1,
        in_i_stall => SE_out_redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_backStall,
        in_i_valid => SE_out_i_syncbuf_b_sync_buffer_matrix_multiply_V0,
        in_unnamed_matrix_multiply0_avm_readdata => in_unnamed_matrix_multiply0_avm_readdata,
        in_unnamed_matrix_multiply0_avm_readdatavalid => in_unnamed_matrix_multiply0_avm_readdatavalid,
        in_unnamed_matrix_multiply0_avm_waitrequest => in_unnamed_matrix_multiply0_avm_waitrequest,
        in_unnamed_matrix_multiply0_avm_writeack => in_unnamed_matrix_multiply0_avm_writeack,
        out_o_readdata => i_load_unnamed_matrix_multiply0_matrix_multiply_out_o_readdata,
        out_o_stall => i_load_unnamed_matrix_multiply0_matrix_multiply_out_o_stall,
        out_o_valid => i_load_unnamed_matrix_multiply0_matrix_multiply_out_o_valid,
        out_unnamed_matrix_multiply0_avm_address => i_load_unnamed_matrix_multiply0_matrix_multiply_out_unnamed_matrix_multiply0_avm_address,
        out_unnamed_matrix_multiply0_avm_burstcount => i_load_unnamed_matrix_multiply0_matrix_multiply_out_unnamed_matrix_multiply0_avm_burstcount,
        out_unnamed_matrix_multiply0_avm_byteenable => i_load_unnamed_matrix_multiply0_matrix_multiply_out_unnamed_matrix_multiply0_avm_byteenable,
        out_unnamed_matrix_multiply0_avm_enable => i_load_unnamed_matrix_multiply0_matrix_multiply_out_unnamed_matrix_multiply0_avm_enable,
        out_unnamed_matrix_multiply0_avm_read => i_load_unnamed_matrix_multiply0_matrix_multiply_out_unnamed_matrix_multiply0_avm_read,
        out_unnamed_matrix_multiply0_avm_write => i_load_unnamed_matrix_multiply0_matrix_multiply_out_unnamed_matrix_multiply0_avm_write,
        out_unnamed_matrix_multiply0_avm_writedata => i_load_unnamed_matrix_multiply0_matrix_multiply_out_unnamed_matrix_multiply0_avm_writedata,
        clock => clock,
        resetn => resetn
    );

    -- redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo(STALLFIFO,169)
    redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_valid_in <= SE_out_matrix_multiply_B1_merge_reg_aunroll_x_V4;
    redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_stall_in <= SE_out_redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_backStall;
    redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_data_in <= bubble_select_matrix_multiply_B1_merge_reg_aunroll_x_c;
    redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_valid_in_bitsignaltemp <= redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_valid_in(0);
    redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_stall_in_bitsignaltemp <= redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_stall_in(0);
    redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_valid_out(0) <= redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_valid_out_bitsignaltemp;
    redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_stall_out(0) <= redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_stall_out_bitsignaltemp;
    theredist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo : acl_data_fifo
    GENERIC MAP (
        DEPTH => 121,
        STRICT_DEPTH => 0,
        ALLOW_FULL_WRITE => 0,
        DATA_WIDTH => 64,
        IMPL => "ram"
    )
    PORT MAP (
        valid_in => redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_valid_in_bitsignaltemp,
        stall_in => redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_stall_in_bitsignaltemp,
        data_in => bubble_select_matrix_multiply_B1_merge_reg_aunroll_x_c,
        valid_out => redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_valid_out_bitsignaltemp,
        stall_out => redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_stall_out_bitsignaltemp,
        data_out => redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_data_out,
        clock => clock,
        resetn => resetn
    );

    -- SE_out_redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo(STALLENABLE,309)
    -- Valid signal propagation
    SE_out_redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_V0 <= SE_out_redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_wireValid;
    -- Backward Stall generation
    SE_out_redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_backStall <= i_sfc_c0_for_body_matrix_multiply_c0_enter6_matrix_multiply_aunroll_x_out_o_stall or not (SE_out_redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_wireValid);
    -- Computing multiple Valid(s)
    SE_out_redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_and0 <= redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_valid_out;
    SE_out_redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_and1 <= i_load_unnamed_matrix_multiply1_matrix_multiply_out_o_valid and SE_out_redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_and0;
    SE_out_redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_wireValid <= i_load_unnamed_matrix_multiply0_matrix_multiply_out_o_valid and SE_out_redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_and1;

    -- redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0(REG,174)
    redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_q <= "0000000000000000000000000000000000000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_backEN = "1") THEN
                redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_q <= STD_LOGIC_VECTOR(SR_SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_D0);
            END IF;
        END IF;
    END PROCESS;

    -- bubble_join_i_syncbuf_a_sync_buffer_matrix_multiply(BITJOIN,198)
    bubble_join_i_syncbuf_a_sync_buffer_matrix_multiply_q <= i_syncbuf_a_sync_buffer_matrix_multiply_out_buffer_out;

    -- bubble_select_i_syncbuf_a_sync_buffer_matrix_multiply(BITSELECT,199)
    bubble_select_i_syncbuf_a_sync_buffer_matrix_multiply_b <= STD_LOGIC_VECTOR(bubble_join_i_syncbuf_a_sync_buffer_matrix_multiply_q(63 downto 0));

    -- i_arrayidx_matrix_multiply_matrix_multiply19_add_x(ADD,45)@3
    i_arrayidx_matrix_multiply_matrix_multiply19_add_x_a <= STD_LOGIC_VECTOR("0" & bubble_select_i_syncbuf_a_sync_buffer_matrix_multiply_b);
    i_arrayidx_matrix_multiply_matrix_multiply19_add_x_b <= STD_LOGIC_VECTOR("0" & redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_q);
    i_arrayidx_matrix_multiply_matrix_multiply19_add_x_o <= STD_LOGIC_VECTOR(UNSIGNED(i_arrayidx_matrix_multiply_matrix_multiply19_add_x_a) + UNSIGNED(i_arrayidx_matrix_multiply_matrix_multiply19_add_x_b));
    i_arrayidx_matrix_multiply_matrix_multiply19_add_x_q <= i_arrayidx_matrix_multiply_matrix_multiply19_add_x_o(64 downto 0);

    -- i_arrayidx_matrix_multiply_matrix_multiply19_dupName_0_trunc_sel_x(BITSELECT,39)@3
    i_arrayidx_matrix_multiply_matrix_multiply19_dupName_0_trunc_sel_x_b <= i_arrayidx_matrix_multiply_matrix_multiply19_add_x_q(63 downto 0);

    -- SR_SE_out_i_syncbuf_a_sync_buffer_matrix_multiply(STALLREG,416)
    SR_SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SR_SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_r_valid <= (others => '0');
            SR_SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_r_data0 <= (others => '-');
            SR_SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_r_data1 <= (others => '-');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Valid
            SR_SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_r_valid <= SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_backStall and (SR_SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_r_valid or SR_SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_i_valid);

            IF (SR_SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_r_valid = "0") THEN
                -- Data(s)
                SR_SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_r_data0 <= i_arrayidx_matrix_multiply_matrix_multiply19_dupName_0_trunc_sel_x_b;
                SR_SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_r_data1 <= i_cmp_neg_or_rm_matrix_multiply_q;
            END IF;

        END IF;
    END PROCESS;
    -- Computing multiple Valid(s)
    SR_SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_and0 <= i_syncbuf_a_sync_buffer_matrix_multiply_out_valid_out;
    SR_SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_and1 <= SE_redist9_i_arrayidx_matrix_multiply_matrix_multiply19_trunc_sel_x_b_1_0_V0 and SR_SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_and0;
    SR_SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_i_valid <= SE_i_cmp_neg_or_rm_matrix_multiply_V1 and SR_SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_and1;
    -- Stall signal propagation
    SR_SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_backStall <= SR_SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_r_valid or not (SR_SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_i_valid);

    -- Valid
    SR_SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_V <= SR_SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_r_valid WHEN SR_SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_r_valid = "1" ELSE SR_SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_i_valid;

    -- Data0
    SR_SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_D0 <= SR_SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_r_data0 WHEN SR_SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_r_valid = "1" ELSE i_arrayidx_matrix_multiply_matrix_multiply19_dupName_0_trunc_sel_x_b;
    -- Data1
    SR_SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_D1 <= SR_SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_r_data1 WHEN SR_SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_r_valid = "1" ELSE i_cmp_neg_or_rm_matrix_multiply_q;

    -- i_load_unnamed_matrix_multiply1_matrix_multiply(BLACKBOX,74)@3
    -- in in_i_stall@20000000
    -- out out_o_readdata@121
    -- out out_o_stall@20000000
    -- out out_o_valid@121
    -- out out_unnamed_matrix_multiply1_avm_address@20000000
    -- out out_unnamed_matrix_multiply1_avm_burstcount@20000000
    -- out out_unnamed_matrix_multiply1_avm_byteenable@20000000
    -- out out_unnamed_matrix_multiply1_avm_enable@20000000
    -- out out_unnamed_matrix_multiply1_avm_read@20000000
    -- out out_unnamed_matrix_multiply1_avm_write@20000000
    -- out out_unnamed_matrix_multiply1_avm_writedata@20000000
    thei_load_unnamed_matrix_multiply1_matrix_multiply : i_load_unnamed_matrix_multiply1_matrix_multiply22
    PORT MAP (
        in_flush => in_flush,
        in_i_address => SR_SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_D0,
        in_i_predicate => SR_SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_D1,
        in_i_stall => SE_out_redist4_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_1_120_fifo_backStall,
        in_i_valid => SE_out_i_syncbuf_a_sync_buffer_matrix_multiply_V0,
        in_unnamed_matrix_multiply1_avm_readdata => in_unnamed_matrix_multiply1_avm_readdata,
        in_unnamed_matrix_multiply1_avm_readdatavalid => in_unnamed_matrix_multiply1_avm_readdatavalid,
        in_unnamed_matrix_multiply1_avm_waitrequest => in_unnamed_matrix_multiply1_avm_waitrequest,
        in_unnamed_matrix_multiply1_avm_writeack => in_unnamed_matrix_multiply1_avm_writeack,
        out_o_readdata => i_load_unnamed_matrix_multiply1_matrix_multiply_out_o_readdata,
        out_o_stall => i_load_unnamed_matrix_multiply1_matrix_multiply_out_o_stall,
        out_o_valid => i_load_unnamed_matrix_multiply1_matrix_multiply_out_o_valid,
        out_unnamed_matrix_multiply1_avm_address => i_load_unnamed_matrix_multiply1_matrix_multiply_out_unnamed_matrix_multiply1_avm_address,
        out_unnamed_matrix_multiply1_avm_burstcount => i_load_unnamed_matrix_multiply1_matrix_multiply_out_unnamed_matrix_multiply1_avm_burstcount,
        out_unnamed_matrix_multiply1_avm_byteenable => i_load_unnamed_matrix_multiply1_matrix_multiply_out_unnamed_matrix_multiply1_avm_byteenable,
        out_unnamed_matrix_multiply1_avm_enable => i_load_unnamed_matrix_multiply1_matrix_multiply_out_unnamed_matrix_multiply1_avm_enable,
        out_unnamed_matrix_multiply1_avm_read => i_load_unnamed_matrix_multiply1_matrix_multiply_out_unnamed_matrix_multiply1_avm_read,
        out_unnamed_matrix_multiply1_avm_write => i_load_unnamed_matrix_multiply1_matrix_multiply_out_unnamed_matrix_multiply1_avm_write,
        out_unnamed_matrix_multiply1_avm_writedata => i_load_unnamed_matrix_multiply1_matrix_multiply_out_unnamed_matrix_multiply1_avm_writedata,
        clock => clock,
        resetn => resetn
    );

    -- dupName_0_ext_sig_sync_out_x(GPOUT,5)
    out_unnamed_matrix_multiply1_avm_address <= i_load_unnamed_matrix_multiply1_matrix_multiply_out_unnamed_matrix_multiply1_avm_address;
    out_unnamed_matrix_multiply1_avm_enable <= i_load_unnamed_matrix_multiply1_matrix_multiply_out_unnamed_matrix_multiply1_avm_enable;
    out_unnamed_matrix_multiply1_avm_read <= i_load_unnamed_matrix_multiply1_matrix_multiply_out_unnamed_matrix_multiply1_avm_read;
    out_unnamed_matrix_multiply1_avm_write <= i_load_unnamed_matrix_multiply1_matrix_multiply_out_unnamed_matrix_multiply1_avm_write;
    out_unnamed_matrix_multiply1_avm_writedata <= i_load_unnamed_matrix_multiply1_matrix_multiply_out_unnamed_matrix_multiply1_avm_writedata;
    out_unnamed_matrix_multiply1_avm_byteenable <= i_load_unnamed_matrix_multiply1_matrix_multiply_out_unnamed_matrix_multiply1_avm_byteenable;
    out_unnamed_matrix_multiply1_avm_burstcount <= i_load_unnamed_matrix_multiply1_matrix_multiply_out_unnamed_matrix_multiply1_avm_burstcount;

    -- bubble_join_redist12_bgTrunc_i_inc_matrix_multiply_sel_x_b_169_fifo(BITJOIN,233)
    bubble_join_redist12_bgTrunc_i_inc_matrix_multiply_sel_x_b_169_fifo_q <= redist12_bgTrunc_i_inc_matrix_multiply_sel_x_b_169_fifo_data_out;

    -- bubble_select_redist12_bgTrunc_i_inc_matrix_multiply_sel_x_b_169_fifo(BITSELECT,234)
    bubble_select_redist12_bgTrunc_i_inc_matrix_multiply_sel_x_b_169_fifo_b <= STD_LOGIC_VECTOR(bubble_join_redist12_bgTrunc_i_inc_matrix_multiply_sel_x_b_169_fifo_q(31 downto 0));

    -- bubble_join_redist7_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_3_170_fifo(BITJOIN,227)
    bubble_join_redist7_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_3_170_fifo_q <= redist7_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_3_170_fifo_data_out;

    -- bubble_select_redist7_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_3_170_fifo(BITSELECT,228)
    bubble_select_redist7_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_3_170_fifo_b <= STD_LOGIC_VECTOR(bubble_join_redist7_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_3_170_fifo_q(31 downto 0));

    -- bubble_join_redist0_i_exitcond_guard_guard_matrix_multiply_q_167_fifo(BITJOIN,218)
    bubble_join_redist0_i_exitcond_guard_guard_matrix_multiply_q_167_fifo_q <= redist0_i_exitcond_guard_guard_matrix_multiply_q_167_fifo_data_out;

    -- bubble_select_redist0_i_exitcond_guard_guard_matrix_multiply_q_167_fifo(BITSELECT,219)
    bubble_select_redist0_i_exitcond_guard_guard_matrix_multiply_q_167_fifo_b <= STD_LOGIC_VECTOR(bubble_join_redist0_i_exitcond_guard_guard_matrix_multiply_q_167_fifo_q(0 downto 0));

    -- bubble_join_i_sfc_c0_for_body_matrix_multiply_c0_enter6_matrix_multiply_aunroll_x(BITJOIN,180)
    bubble_join_i_sfc_c0_for_body_matrix_multiply_c0_enter6_matrix_multiply_aunroll_x_q <= i_sfc_c0_for_body_matrix_multiply_c0_enter6_matrix_multiply_aunroll_x_out_c0_exit9_1;

    -- bubble_select_i_sfc_c0_for_body_matrix_multiply_c0_enter6_matrix_multiply_aunroll_x(BITSELECT,181)
    bubble_select_i_sfc_c0_for_body_matrix_multiply_c0_enter6_matrix_multiply_aunroll_x_b <= STD_LOGIC_VECTOR(bubble_join_i_sfc_c0_for_body_matrix_multiply_c0_enter6_matrix_multiply_aunroll_x_q(63 downto 0));

    -- bubble_join_redist5_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_2_170_fifo(BITJOIN,224)
    bubble_join_redist5_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_2_170_fifo_q <= redist5_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_2_170_fifo_data_out;

    -- bubble_select_redist5_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_2_170_fifo(BITSELECT,225)
    bubble_select_redist5_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_2_170_fifo_b <= STD_LOGIC_VECTOR(bubble_join_redist5_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_2_170_fifo_q(31 downto 0));

    -- bubble_join_redist8_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_4_170_fifo(BITJOIN,230)
    bubble_join_redist8_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_4_170_fifo_q <= redist8_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_4_170_fifo_data_out;

    -- bubble_select_redist8_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_4_170_fifo(BITSELECT,231)
    bubble_select_redist8_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_4_170_fifo_b <= STD_LOGIC_VECTOR(bubble_join_redist8_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_4_170_fifo_q(31 downto 0));

    -- dupName_0_sync_out_x(GPOUT,11)@171
    out_acl_hw_wg_id6 <= bubble_select_redist8_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_4_170_fifo_b;
    out_c0_exe11 <= bubble_select_redist5_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_2_170_fifo_b;
    out_c0_exe110 <= bubble_select_i_sfc_c0_for_body_matrix_multiply_c0_enter6_matrix_multiply_aunroll_x_b;
    out_exitcond_GUARD_GUARD <= bubble_select_redist0_i_exitcond_guard_guard_matrix_multiply_q_167_fifo_b;
    out_global_id_04 <= bubble_select_redist7_matrix_multiply_B1_merge_reg_aunroll_x_out_data_out_3_170_fifo_b;
    out_inc <= bubble_select_redist12_bgTrunc_i_inc_matrix_multiply_sel_x_b_169_fifo_b;
    out_valid_out <= SE_out_bubble_out_i_syncbuf_p_sync_buffer3_matrix_multiply_1_V0;

    -- ext_sig_sync_out(GPOUT,60)
    out_unnamed_matrix_multiply0_avm_address <= i_load_unnamed_matrix_multiply0_matrix_multiply_out_unnamed_matrix_multiply0_avm_address;
    out_unnamed_matrix_multiply0_avm_enable <= i_load_unnamed_matrix_multiply0_matrix_multiply_out_unnamed_matrix_multiply0_avm_enable;
    out_unnamed_matrix_multiply0_avm_read <= i_load_unnamed_matrix_multiply0_matrix_multiply_out_unnamed_matrix_multiply0_avm_read;
    out_unnamed_matrix_multiply0_avm_write <= i_load_unnamed_matrix_multiply0_matrix_multiply_out_unnamed_matrix_multiply0_avm_write;
    out_unnamed_matrix_multiply0_avm_writedata <= i_load_unnamed_matrix_multiply0_matrix_multiply_out_unnamed_matrix_multiply0_avm_writedata;
    out_unnamed_matrix_multiply0_avm_byteenable <= i_load_unnamed_matrix_multiply0_matrix_multiply_out_unnamed_matrix_multiply0_avm_byteenable;
    out_unnamed_matrix_multiply0_avm_burstcount <= i_load_unnamed_matrix_multiply0_matrix_multiply_out_unnamed_matrix_multiply0_avm_burstcount;

    -- sync_out(GPOUT,93)@0
    out_stall_out <= SE_stall_entry_backStall;

END normal;
