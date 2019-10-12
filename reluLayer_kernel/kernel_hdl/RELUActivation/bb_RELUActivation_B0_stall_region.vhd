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

-- VHDL created from bb_RELUActivation_B0_stall_region
-- VHDL created on Mon Oct 07 17:35:18 2019


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

entity bb_RELUActivation_B0_stall_region is
    port (
        in_unnamed_RELUActivation1_avm_readdata : in std_logic_vector(255 downto 0);  -- ufix256
        in_unnamed_RELUActivation1_avm_writeack : in std_logic_vector(0 downto 0);  -- ufix1
        in_unnamed_RELUActivation1_avm_waitrequest : in std_logic_vector(0 downto 0);  -- ufix1
        in_unnamed_RELUActivation1_avm_readdatavalid : in std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_RELUActivation1_avm_address : out std_logic_vector(29 downto 0);  -- ufix30
        out_unnamed_RELUActivation1_avm_enable : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_RELUActivation1_avm_read : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_RELUActivation1_avm_write : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_RELUActivation1_avm_writedata : out std_logic_vector(255 downto 0);  -- ufix256
        out_unnamed_RELUActivation1_avm_byteenable : out std_logic_vector(31 downto 0);  -- ufix32
        out_unnamed_RELUActivation1_avm_burstcount : out std_logic_vector(4 downto 0);  -- ufix5
        in_Z : in std_logic_vector(63 downto 0);  -- ufix64
        in_global_id_0 : in std_logic_vector(31 downto 0);  -- ufix32
        in_valid_in : in std_logic_vector(0 downto 0);  -- ufix1
        out_valid_out : out std_logic_vector(0 downto 0);  -- ufix1
        out_lsu_unnamed_RELUActivation1_o_active : out std_logic_vector(0 downto 0);  -- ufix1
        in_Z_x_dim : in std_logic_vector(31 downto 0);  -- ufix32
        in_Z_y_dim : in std_logic_vector(31 downto 0);  -- ufix32
        in_flush : in std_logic_vector(0 downto 0);  -- ufix1
        in_unnamed_RELUActivation0_avm_readdata : in std_logic_vector(255 downto 0);  -- ufix256
        in_unnamed_RELUActivation0_avm_writeack : in std_logic_vector(0 downto 0);  -- ufix1
        in_unnamed_RELUActivation0_avm_waitrequest : in std_logic_vector(0 downto 0);  -- ufix1
        in_unnamed_RELUActivation0_avm_readdatavalid : in std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_RELUActivation0_avm_address : out std_logic_vector(29 downto 0);  -- ufix30
        out_unnamed_RELUActivation0_avm_enable : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_RELUActivation0_avm_read : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_RELUActivation0_avm_write : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_RELUActivation0_avm_writedata : out std_logic_vector(255 downto 0);  -- ufix256
        out_unnamed_RELUActivation0_avm_byteenable : out std_logic_vector(31 downto 0);  -- ufix32
        out_unnamed_RELUActivation0_avm_burstcount : out std_logic_vector(4 downto 0);  -- ufix5
        in_A : in std_logic_vector(63 downto 0);  -- ufix64
        in_stall_in : in std_logic_vector(0 downto 0);  -- ufix1
        out_stall_out : out std_logic_vector(0 downto 0);  -- ufix1
        clock : in std_logic;
        resetn : in std_logic
    );
end bb_RELUActivation_B0_stall_region;

architecture normal of bb_RELUActivation_B0_stall_region is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    component RELUActivation_B0_merge_reg is
        port (
            in_data_in_0 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_data_out_0 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_sfc_c0_entry_reluactivation_c0_enter_reluactivation is
        port (
            in_c0_eni1_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_c0_eni1_1 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_Z_x_dim : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_Z_y_dim : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_i_stall : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_valid : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exit_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exit_1 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exit_2 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_stall : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_valid : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_sfc_c1_entry_reluactivation_c1_enter_reluactivation is
        port (
            in_c1_eni2_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_c1_eni2_1 : in std_logic_vector(63 downto 0);  -- Floating Point
            in_c1_eni2_2 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_stall : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_valid : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_c1_exit_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_c1_exit_1 : out std_logic_vector(63 downto 0);  -- Floating Point
            out_o_stall : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_valid : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_load_unnamed_reluactivation0_reluactivation14 is
        port (
            in_flush : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_address : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_i_predicate : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_stall : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_valid : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_RELUActivation0_avm_readdata : in std_logic_vector(255 downto 0);  -- Fixed Point
            in_unnamed_RELUActivation0_avm_readdatavalid : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_RELUActivation0_avm_waitrequest : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_RELUActivation0_avm_writeack : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_readdata : out std_logic_vector(63 downto 0);  -- Floating Point
            out_o_stall : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_valid : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_RELUActivation0_avm_address : out std_logic_vector(29 downto 0);  -- Fixed Point
            out_unnamed_RELUActivation0_avm_burstcount : out std_logic_vector(4 downto 0);  -- Fixed Point
            out_unnamed_RELUActivation0_avm_byteenable : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_unnamed_RELUActivation0_avm_enable : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_RELUActivation0_avm_read : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_RELUActivation0_avm_write : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_RELUActivation0_avm_writedata : out std_logic_vector(255 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_store_unnamed_reluactivation1_reluactivation19 is
        port (
            in_flush : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_address : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_i_predicate : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_stall : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_valid : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_writedata : in std_logic_vector(63 downto 0);  -- Floating Point
            in_unnamed_RELUActivation1_avm_readdata : in std_logic_vector(255 downto 0);  -- Fixed Point
            in_unnamed_RELUActivation1_avm_readdatavalid : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_RELUActivation1_avm_waitrequest : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_RELUActivation1_avm_writeack : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_lsu_unnamed_RELUActivation1_o_active : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_stall : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_valid : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_RELUActivation1_avm_address : out std_logic_vector(29 downto 0);  -- Fixed Point
            out_unnamed_RELUActivation1_avm_burstcount : out std_logic_vector(4 downto 0);  -- Fixed Point
            out_unnamed_RELUActivation1_avm_byteenable : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_unnamed_RELUActivation1_avm_enable : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_RELUActivation1_avm_read : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_RELUActivation1_avm_write : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_RELUActivation1_avm_writedata : out std_logic_vector(255 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_syncbuf_a_sync_buffer_reluactivation10 is
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


    component i_syncbuf_z_sync_buffer_reluactivation8 is
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
    signal RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0 : STD_LOGIC_VECTOR (31 downto 0);
    signal RELUActivation_B0_merge_reg_aunroll_x_out_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal RELUActivation_B0_merge_reg_aunroll_x_out_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b : STD_LOGIC_VECTOR (63 downto 0);
    signal i_arrayidx10_reluactivation_reluactivation13_mult_extender_x_q : STD_LOGIC_VECTOR (127 downto 0);
    signal i_arrayidx10_reluactivation_reluactivation13_mult_multconst_x_q : STD_LOGIC_VECTOR (59 downto 0);
    signal i_arrayidx10_reluactivation_reluactivation13_trunc_sel_x_b : STD_LOGIC_VECTOR (63 downto 0);
    signal i_arrayidx10_reluactivation_reluactivation13_add_x_a : STD_LOGIC_VECTOR (64 downto 0);
    signal i_arrayidx10_reluactivation_reluactivation13_add_x_b : STD_LOGIC_VECTOR (64 downto 0);
    signal i_arrayidx10_reluactivation_reluactivation13_add_x_o : STD_LOGIC_VECTOR (64 downto 0);
    signal i_arrayidx10_reluactivation_reluactivation13_add_x_q : STD_LOGIC_VECTOR (64 downto 0);
    signal i_arrayidx_reluactivation_reluactivation12_dupName_0_trunc_sel_x_b : STD_LOGIC_VECTOR (63 downto 0);
    signal i_arrayidx_reluactivation_reluactivation12_mult_extender_x_q : STD_LOGIC_VECTOR (127 downto 0);
    signal i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b : STD_LOGIC_VECTOR (63 downto 0);
    signal i_arrayidx_reluactivation_reluactivation12_add_x_a : STD_LOGIC_VECTOR (64 downto 0);
    signal i_arrayidx_reluactivation_reluactivation12_add_x_b : STD_LOGIC_VECTOR (64 downto 0);
    signal i_arrayidx_reluactivation_reluactivation12_add_x_o : STD_LOGIC_VECTOR (64 downto 0);
    signal i_arrayidx_reluactivation_reluactivation12_add_x_q : STD_LOGIC_VECTOR (64 downto 0);
    signal i_idxprom_reluactivation_sel_x_b : STD_LOGIC_VECTOR (63 downto 0);
    signal i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_2 : STD_LOGIC_VECTOR (0 downto 0);
    signal i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_o_stall : STD_LOGIC_VECTOR (0 downto 0);
    signal i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_o_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal i_sfc_c1_entry_reluactivation_c1_enter_reluactivation_aunroll_x_out_c1_exit_1 : STD_LOGIC_VECTOR (63 downto 0);
    signal i_sfc_c1_entry_reluactivation_c1_enter_reluactivation_aunroll_x_out_o_stall : STD_LOGIC_VECTOR (0 downto 0);
    signal i_sfc_c1_entry_reluactivation_c1_enter_reluactivation_aunroll_x_out_o_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal i_load_unnamed_reluactivation0_reluactivation_out_o_readdata : STD_LOGIC_VECTOR (63 downto 0);
    signal i_load_unnamed_reluactivation0_reluactivation_out_o_stall : STD_LOGIC_VECTOR (0 downto 0);
    signal i_load_unnamed_reluactivation0_reluactivation_out_o_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal i_load_unnamed_reluactivation0_reluactivation_out_unnamed_RELUActivation0_avm_address : STD_LOGIC_VECTOR (29 downto 0);
    signal i_load_unnamed_reluactivation0_reluactivation_out_unnamed_RELUActivation0_avm_burstcount : STD_LOGIC_VECTOR (4 downto 0);
    signal i_load_unnamed_reluactivation0_reluactivation_out_unnamed_RELUActivation0_avm_byteenable : STD_LOGIC_VECTOR (31 downto 0);
    signal i_load_unnamed_reluactivation0_reluactivation_out_unnamed_RELUActivation0_avm_enable : STD_LOGIC_VECTOR (0 downto 0);
    signal i_load_unnamed_reluactivation0_reluactivation_out_unnamed_RELUActivation0_avm_read : STD_LOGIC_VECTOR (0 downto 0);
    signal i_load_unnamed_reluactivation0_reluactivation_out_unnamed_RELUActivation0_avm_write : STD_LOGIC_VECTOR (0 downto 0);
    signal i_load_unnamed_reluactivation0_reluactivation_out_unnamed_RELUActivation0_avm_writedata : STD_LOGIC_VECTOR (255 downto 0);
    signal i_store_unnamed_reluactivation1_reluactivation_out_lsu_unnamed_RELUActivation1_o_active : STD_LOGIC_VECTOR (0 downto 0);
    signal i_store_unnamed_reluactivation1_reluactivation_out_o_stall : STD_LOGIC_VECTOR (0 downto 0);
    signal i_store_unnamed_reluactivation1_reluactivation_out_o_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal i_store_unnamed_reluactivation1_reluactivation_out_unnamed_RELUActivation1_avm_address : STD_LOGIC_VECTOR (29 downto 0);
    signal i_store_unnamed_reluactivation1_reluactivation_out_unnamed_RELUActivation1_avm_burstcount : STD_LOGIC_VECTOR (4 downto 0);
    signal i_store_unnamed_reluactivation1_reluactivation_out_unnamed_RELUActivation1_avm_byteenable : STD_LOGIC_VECTOR (31 downto 0);
    signal i_store_unnamed_reluactivation1_reluactivation_out_unnamed_RELUActivation1_avm_enable : STD_LOGIC_VECTOR (0 downto 0);
    signal i_store_unnamed_reluactivation1_reluactivation_out_unnamed_RELUActivation1_avm_read : STD_LOGIC_VECTOR (0 downto 0);
    signal i_store_unnamed_reluactivation1_reluactivation_out_unnamed_RELUActivation1_avm_write : STD_LOGIC_VECTOR (0 downto 0);
    signal i_store_unnamed_reluactivation1_reluactivation_out_unnamed_RELUActivation1_avm_writedata : STD_LOGIC_VECTOR (255 downto 0);
    signal i_syncbuf_a_sync_buffer_reluactivation_out_buffer_out : STD_LOGIC_VECTOR (63 downto 0);
    signal i_syncbuf_a_sync_buffer_reluactivation_out_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_syncbuf_a_sync_buffer_reluactivation_out_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_syncbuf_z_sync_buffer_reluactivation_out_buffer_out : STD_LOGIC_VECTOR (63 downto 0);
    signal i_syncbuf_z_sync_buffer_reluactivation_out_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_syncbuf_z_sync_buffer_reluactivation_out_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_arrayidx10_reluactivation_reluactivation13_mult_x_align_12_q : STD_LOGIC_VECTOR (35 downto 0);
    signal i_arrayidx10_reluactivation_reluactivation13_mult_x_align_12_qint : STD_LOGIC_VECTOR (35 downto 0);
    signal i_arrayidx10_reluactivation_reluactivation13_mult_x_join_13_q : STD_LOGIC_VECTOR (57 downto 0);
    signal i_arrayidx10_reluactivation_reluactivation13_mult_x_align_14_q : STD_LOGIC_VECTOR (39 downto 0);
    signal i_arrayidx10_reluactivation_reluactivation13_mult_x_align_14_qint : STD_LOGIC_VECTOR (39 downto 0);
    signal i_arrayidx10_reluactivation_reluactivation13_mult_x_align_15_q : STD_LOGIC_VECTOR (27 downto 0);
    signal i_arrayidx10_reluactivation_reluactivation13_mult_x_align_15_qint : STD_LOGIC_VECTOR (27 downto 0);
    signal i_arrayidx10_reluactivation_reluactivation13_mult_x_join_16_q : STD_LOGIC_VECTOR (67 downto 0);
    signal i_arrayidx10_reluactivation_reluactivation13_mult_x_result_add_0_0_a : STD_LOGIC_VECTOR (68 downto 0);
    signal i_arrayidx10_reluactivation_reluactivation13_mult_x_result_add_0_0_b : STD_LOGIC_VECTOR (68 downto 0);
    signal i_arrayidx10_reluactivation_reluactivation13_mult_x_result_add_0_0_o : STD_LOGIC_VECTOR (68 downto 0);
    signal i_arrayidx10_reluactivation_reluactivation13_mult_x_result_add_0_0_q : STD_LOGIC_VECTOR (68 downto 0);
    signal i_arrayidx_reluactivation_reluactivation12_mult_x_align_12_q : STD_LOGIC_VECTOR (35 downto 0);
    signal i_arrayidx_reluactivation_reluactivation12_mult_x_align_12_qint : STD_LOGIC_VECTOR (35 downto 0);
    signal i_arrayidx_reluactivation_reluactivation12_mult_x_join_13_q : STD_LOGIC_VECTOR (57 downto 0);
    signal i_arrayidx_reluactivation_reluactivation12_mult_x_align_14_q : STD_LOGIC_VECTOR (39 downto 0);
    signal i_arrayidx_reluactivation_reluactivation12_mult_x_align_14_qint : STD_LOGIC_VECTOR (39 downto 0);
    signal i_arrayidx_reluactivation_reluactivation12_mult_x_align_15_q : STD_LOGIC_VECTOR (27 downto 0);
    signal i_arrayidx_reluactivation_reluactivation12_mult_x_align_15_qint : STD_LOGIC_VECTOR (27 downto 0);
    signal i_arrayidx_reluactivation_reluactivation12_mult_x_join_16_q : STD_LOGIC_VECTOR (67 downto 0);
    signal i_arrayidx_reluactivation_reluactivation12_mult_x_result_add_0_0_a : STD_LOGIC_VECTOR (68 downto 0);
    signal i_arrayidx_reluactivation_reluactivation12_mult_x_result_add_0_0_b : STD_LOGIC_VECTOR (68 downto 0);
    signal i_arrayidx_reluactivation_reluactivation12_mult_x_result_add_0_0_o : STD_LOGIC_VECTOR (68 downto 0);
    signal i_arrayidx_reluactivation_reluactivation12_mult_x_result_add_0_0_q : STD_LOGIC_VECTOR (68 downto 0);
    signal i_arrayidx10_reluactivation_reluactivation13_mult_x_im0_shift0_q : STD_LOGIC_VECTOR (20 downto 0);
    signal i_arrayidx10_reluactivation_reluactivation13_mult_x_im0_shift0_qint : STD_LOGIC_VECTOR (20 downto 0);
    signal i_arrayidx10_reluactivation_reluactivation13_mult_x_im3_shift0_q : STD_LOGIC_VECTOR (12 downto 0);
    signal i_arrayidx10_reluactivation_reluactivation13_mult_x_im3_shift0_qint : STD_LOGIC_VECTOR (12 downto 0);
    signal i_arrayidx10_reluactivation_reluactivation13_mult_x_im6_shift0_q : STD_LOGIC_VECTOR (20 downto 0);
    signal i_arrayidx10_reluactivation_reluactivation13_mult_x_im6_shift0_qint : STD_LOGIC_VECTOR (20 downto 0);
    signal i_arrayidx10_reluactivation_reluactivation13_mult_x_im9_shift0_q : STD_LOGIC_VECTOR (20 downto 0);
    signal i_arrayidx10_reluactivation_reluactivation13_mult_x_im9_shift0_qint : STD_LOGIC_VECTOR (20 downto 0);
    signal i_arrayidx_reluactivation_reluactivation12_mult_x_im0_shift0_q : STD_LOGIC_VECTOR (20 downto 0);
    signal i_arrayidx_reluactivation_reluactivation12_mult_x_im0_shift0_qint : STD_LOGIC_VECTOR (20 downto 0);
    signal i_arrayidx_reluactivation_reluactivation12_mult_x_im3_shift0_q : STD_LOGIC_VECTOR (12 downto 0);
    signal i_arrayidx_reluactivation_reluactivation12_mult_x_im3_shift0_qint : STD_LOGIC_VECTOR (12 downto 0);
    signal i_arrayidx_reluactivation_reluactivation12_mult_x_im6_shift0_q : STD_LOGIC_VECTOR (20 downto 0);
    signal i_arrayidx_reluactivation_reluactivation12_mult_x_im6_shift0_qint : STD_LOGIC_VECTOR (20 downto 0);
    signal i_arrayidx_reluactivation_reluactivation12_mult_x_im9_shift0_q : STD_LOGIC_VECTOR (20 downto 0);
    signal i_arrayidx_reluactivation_reluactivation12_mult_x_im9_shift0_qint : STD_LOGIC_VECTOR (20 downto 0);
    signal i_arrayidx10_reluactivation_reluactivation13_mult_x_bs1_merged_bit_select_b : STD_LOGIC_VECTOR (17 downto 0);
    signal i_arrayidx10_reluactivation_reluactivation13_mult_x_bs1_merged_bit_select_c : STD_LOGIC_VECTOR (9 downto 0);
    signal i_arrayidx10_reluactivation_reluactivation13_mult_x_bs1_merged_bit_select_d : STD_LOGIC_VECTOR (17 downto 0);
    signal i_arrayidx10_reluactivation_reluactivation13_mult_x_bs1_merged_bit_select_e : STD_LOGIC_VECTOR (17 downto 0);
    signal redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo_valid_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo_valid_in_bitsignaltemp : std_logic;
    signal redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo_stall_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo_stall_in_bitsignaltemp : std_logic;
    signal redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo_data_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo_valid_out_bitsignaltemp : std_logic;
    signal redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo_stall_out_bitsignaltemp : std_logic;
    signal redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo_data_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist1_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_2_140_fifo_valid_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist1_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_2_140_fifo_valid_in_bitsignaltemp : std_logic;
    signal redist1_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_2_140_fifo_stall_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist1_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_2_140_fifo_stall_in_bitsignaltemp : std_logic;
    signal redist1_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_2_140_fifo_data_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist1_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_2_140_fifo_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist1_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_2_140_fifo_valid_out_bitsignaltemp : std_logic;
    signal redist1_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_2_140_fifo_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist1_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_2_140_fifo_stall_out_bitsignaltemp : std_logic;
    signal redist1_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_2_140_fifo_data_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_q : STD_LOGIC_VECTOR (63 downto 0);
    signal redist3_i_arrayidx10_reluactivation_reluactivation13_trunc_sel_x_b_1_0_q : STD_LOGIC_VECTOR (63 downto 0);
    signal redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_valid_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_valid_in_bitsignaltemp : std_logic;
    signal redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_stall_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_stall_in_bitsignaltemp : std_logic;
    signal redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_data_in : STD_LOGIC_VECTOR (63 downto 0);
    signal redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_valid_out_bitsignaltemp : std_logic;
    signal redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_stall_out_bitsignaltemp : std_logic;
    signal redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_data_out : STD_LOGIC_VECTOR (63 downto 0);
    signal redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_join_RELUActivation_B0_merge_reg_aunroll_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_RELUActivation_B0_merge_reg_aunroll_x_b : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_join_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_q : STD_LOGIC_VECTOR (1 downto 0);
    signal bubble_select_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_b : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_select_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_c : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_join_i_sfc_c1_entry_reluactivation_c1_enter_reluactivation_aunroll_x_q : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_select_i_sfc_c1_entry_reluactivation_c1_enter_reluactivation_aunroll_x_b : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_join_i_load_unnamed_reluactivation0_reluactivation_q : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_select_i_load_unnamed_reluactivation0_reluactivation_b : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_join_i_syncbuf_a_sync_buffer_reluactivation_q : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_select_i_syncbuf_a_sync_buffer_reluactivation_b : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_join_i_syncbuf_z_sync_buffer_reluactivation_q : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_select_i_syncbuf_z_sync_buffer_reluactivation_b : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_join_stall_entry_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_stall_entry_b : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_join_redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo_q : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_select_redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo_b : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_join_redist1_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_2_140_fifo_q : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_select_redist1_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_2_140_fifo_b : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_join_redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_q : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_select_redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_b : STD_LOGIC_VECTOR (63 downto 0);
    signal SE_out_RELUActivation_B0_merge_reg_aunroll_x_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_RELUActivation_B0_merge_reg_aunroll_x_wireStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_RELUActivation_B0_merge_reg_aunroll_x_StallValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_RELUActivation_B0_merge_reg_aunroll_x_toReg0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_RELUActivation_B0_merge_reg_aunroll_x_fromReg0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_RELUActivation_B0_merge_reg_aunroll_x_consumed0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_RELUActivation_B0_merge_reg_aunroll_x_toReg1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_RELUActivation_B0_merge_reg_aunroll_x_fromReg1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_RELUActivation_B0_merge_reg_aunroll_x_consumed1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_RELUActivation_B0_merge_reg_aunroll_x_toReg2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_RELUActivation_B0_merge_reg_aunroll_x_fromReg2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_RELUActivation_B0_merge_reg_aunroll_x_consumed2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_RELUActivation_B0_merge_reg_aunroll_x_toReg3 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_RELUActivation_B0_merge_reg_aunroll_x_fromReg3 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_RELUActivation_B0_merge_reg_aunroll_x_consumed3 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_RELUActivation_B0_merge_reg_aunroll_x_or0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_RELUActivation_B0_merge_reg_aunroll_x_or1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_RELUActivation_B0_merge_reg_aunroll_x_or2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_RELUActivation_B0_merge_reg_aunroll_x_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_RELUActivation_B0_merge_reg_aunroll_x_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_RELUActivation_B0_merge_reg_aunroll_x_V1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_RELUActivation_B0_merge_reg_aunroll_x_V2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_RELUActivation_B0_merge_reg_aunroll_x_V3 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_wireStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_StallValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_toReg0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_fromReg0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_consumed0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_toReg1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_fromReg1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_consumed1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_toReg2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_fromReg2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_consumed2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_or0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_or1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_V1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_V2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_store_unnamed_reluactivation1_reluactivation_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_store_unnamed_reluactivation1_reluactivation_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_store_unnamed_reluactivation1_reluactivation_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_a_sync_buffer_reluactivation_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_a_sync_buffer_reluactivation_and0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_a_sync_buffer_reluactivation_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_a_sync_buffer_reluactivation_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_z_sync_buffer_reluactivation_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_z_sync_buffer_reluactivation_and0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_z_sync_buffer_reluactivation_and1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_z_sync_buffer_reluactivation_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_syncbuf_z_sync_buffer_reluactivation_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo_and0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_R_v_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_s_tv_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_or0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_V1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_and0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_and1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_RELUActivation_B0_merge_reg_aunroll_x_1_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_RELUActivation_B0_merge_reg_aunroll_x_1_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_RELUActivation_B0_merge_reg_aunroll_x_1_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_RELUActivation_B0_merge_reg_aunroll_x_2_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_RELUActivation_B0_merge_reg_aunroll_x_2_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_RELUActivation_B0_merge_reg_aunroll_x_2_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_RELUActivation_B0_merge_reg_aunroll_x_1_reg_valid_in : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_RELUActivation_B0_merge_reg_aunroll_x_1_reg_valid_in_bitsignaltemp : std_logic;
    signal bubble_out_RELUActivation_B0_merge_reg_aunroll_x_1_reg_stall_in : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_RELUActivation_B0_merge_reg_aunroll_x_1_reg_stall_in_bitsignaltemp : std_logic;
    signal bubble_out_RELUActivation_B0_merge_reg_aunroll_x_1_reg_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_RELUActivation_B0_merge_reg_aunroll_x_1_reg_valid_out_bitsignaltemp : std_logic;
    signal bubble_out_RELUActivation_B0_merge_reg_aunroll_x_1_reg_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_RELUActivation_B0_merge_reg_aunroll_x_1_reg_stall_out_bitsignaltemp : std_logic;
    signal bubble_out_RELUActivation_B0_merge_reg_aunroll_x_2_reg_valid_in : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_RELUActivation_B0_merge_reg_aunroll_x_2_reg_valid_in_bitsignaltemp : std_logic;
    signal bubble_out_RELUActivation_B0_merge_reg_aunroll_x_2_reg_stall_in : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_RELUActivation_B0_merge_reg_aunroll_x_2_reg_stall_in_bitsignaltemp : std_logic;
    signal bubble_out_RELUActivation_B0_merge_reg_aunroll_x_2_reg_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_RELUActivation_B0_merge_reg_aunroll_x_2_reg_valid_out_bitsignaltemp : std_logic;
    signal bubble_out_RELUActivation_B0_merge_reg_aunroll_x_2_reg_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_RELUActivation_B0_merge_reg_aunroll_x_2_reg_stall_out_bitsignaltemp : std_logic;
    signal SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_i_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_r_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_r_data0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_V : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_D0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_i_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_r_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_r_data0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_V : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_D0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_i_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_r_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_r_data0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_V : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_D0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_i_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_r_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_r_data0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_V : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_D0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_i_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_r_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_r_data0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_V : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_D0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_i_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_r_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_r_data0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_V : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_D0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_i_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_r_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_r_data0 : STD_LOGIC_VECTOR (63 downto 0);
    signal SR_SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_r_data1 : STD_LOGIC_VECTOR (63 downto 0);
    signal SR_SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_V : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_D0 : STD_LOGIC_VECTOR (63 downto 0);
    signal SR_SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_D1 : STD_LOGIC_VECTOR (63 downto 0);

begin


    -- redist1_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_2_140_fifo(STALLFIFO,119)
    redist1_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_2_140_fifo_valid_in <= SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_V2;
    redist1_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_2_140_fifo_stall_in <= SE_out_redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_backStall;
    redist1_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_2_140_fifo_data_in <= bubble_select_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_c;
    redist1_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_2_140_fifo_valid_in_bitsignaltemp <= redist1_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_2_140_fifo_valid_in(0);
    redist1_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_2_140_fifo_stall_in_bitsignaltemp <= redist1_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_2_140_fifo_stall_in(0);
    redist1_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_2_140_fifo_valid_out(0) <= redist1_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_2_140_fifo_valid_out_bitsignaltemp;
    redist1_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_2_140_fifo_stall_out(0) <= redist1_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_2_140_fifo_stall_out_bitsignaltemp;
    theredist1_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_2_140_fifo : acl_data_fifo
    GENERIC MAP (
        DEPTH => 141,
        STRICT_DEPTH => 0,
        ALLOW_FULL_WRITE => 0,
        DATA_WIDTH => 1,
        IMPL => "ram"
    )
    PORT MAP (
        valid_in => redist1_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_2_140_fifo_valid_in_bitsignaltemp,
        stall_in => redist1_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_2_140_fifo_stall_in_bitsignaltemp,
        data_in => bubble_select_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_c,
        valid_out => redist1_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_2_140_fifo_valid_out_bitsignaltemp,
        stall_out => redist1_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_2_140_fifo_stall_out_bitsignaltemp,
        data_out => redist1_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_2_140_fifo_data_out,
        clock => clock,
        resetn => resetn
    );

    -- redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0(REG,123)
    redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_backEN = "1") THEN
                redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_q <= STD_LOGIC_VECTOR(SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_D0);
            END IF;
        END IF;
    END PROCESS;

    -- redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1(REG,124)
    redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_backEN = "1") THEN
                redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_q <= STD_LOGIC_VECTOR(SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_D0);
            END IF;
        END IF;
    END PROCESS;

    -- redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2(REG,125)
    redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_backEN = "1") THEN
                redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_q <= STD_LOGIC_VECTOR(SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_D0);
            END IF;
        END IF;
    END PROCESS;

    -- redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3(REG,126)
    redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_backEN = "1") THEN
                redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_q <= STD_LOGIC_VECTOR(SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_D0);
            END IF;
        END IF;
    END PROCESS;

    -- redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4(REG,127)
    redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_backEN = "1") THEN
                redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_q <= STD_LOGIC_VECTOR(SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_D0);
            END IF;
        END IF;
    END PROCESS;

    -- i_arrayidx10_reluactivation_reluactivation13_mult_multconst_x(CONSTANT,28)
    i_arrayidx10_reluactivation_reluactivation13_mult_multconst_x_q <= "000000000000000000000000000000000000000000000000000000000000";

    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5(REG,128)
    redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_backEN = "1") THEN
                redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_q <= STD_LOGIC_VECTOR(SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_D0);
            END IF;
        END IF;
    END PROCESS;

    -- i_idxprom_reluactivation_sel_x(BITSELECT,44)@7
    i_idxprom_reluactivation_sel_x_b <= STD_LOGIC_VECTOR(std_logic_vector(resize(signed(redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_q(31 downto 0)), 64)));

    -- i_arrayidx10_reluactivation_reluactivation13_mult_x_bs1_merged_bit_select(BITSELECT,111)@7
    i_arrayidx10_reluactivation_reluactivation13_mult_x_bs1_merged_bit_select_b <= i_idxprom_reluactivation_sel_x_b(17 downto 0);
    i_arrayidx10_reluactivation_reluactivation13_mult_x_bs1_merged_bit_select_c <= i_idxprom_reluactivation_sel_x_b(63 downto 54);
    i_arrayidx10_reluactivation_reluactivation13_mult_x_bs1_merged_bit_select_d <= i_idxprom_reluactivation_sel_x_b(35 downto 18);
    i_arrayidx10_reluactivation_reluactivation13_mult_x_bs1_merged_bit_select_e <= i_idxprom_reluactivation_sel_x_b(53 downto 36);

    -- i_arrayidx10_reluactivation_reluactivation13_mult_x_im3_shift0(BITSHIFT,104)@7
    i_arrayidx10_reluactivation_reluactivation13_mult_x_im3_shift0_qint <= i_arrayidx10_reluactivation_reluactivation13_mult_x_bs1_merged_bit_select_c & "000";
    i_arrayidx10_reluactivation_reluactivation13_mult_x_im3_shift0_q <= i_arrayidx10_reluactivation_reluactivation13_mult_x_im3_shift0_qint(12 downto 0);

    -- i_arrayidx10_reluactivation_reluactivation13_mult_x_align_15(BITSHIFT,81)@7
    i_arrayidx10_reluactivation_reluactivation13_mult_x_align_15_qint <= STD_LOGIC_VECTOR("0" & i_arrayidx10_reluactivation_reluactivation13_mult_x_im3_shift0_q) & "00000000000000";
    i_arrayidx10_reluactivation_reluactivation13_mult_x_align_15_q <= i_arrayidx10_reluactivation_reluactivation13_mult_x_align_15_qint(27 downto 0);

    -- i_arrayidx10_reluactivation_reluactivation13_mult_x_im6_shift0(BITSHIFT,105)@7
    i_arrayidx10_reluactivation_reluactivation13_mult_x_im6_shift0_qint <= i_arrayidx10_reluactivation_reluactivation13_mult_x_bs1_merged_bit_select_d & "000";
    i_arrayidx10_reluactivation_reluactivation13_mult_x_im6_shift0_q <= i_arrayidx10_reluactivation_reluactivation13_mult_x_im6_shift0_qint(20 downto 0);

    -- i_arrayidx10_reluactivation_reluactivation13_mult_x_align_14(BITSHIFT,80)@7
    i_arrayidx10_reluactivation_reluactivation13_mult_x_align_14_qint <= STD_LOGIC_VECTOR("0" & i_arrayidx10_reluactivation_reluactivation13_mult_x_im6_shift0_q) & "000000000000000000";
    i_arrayidx10_reluactivation_reluactivation13_mult_x_align_14_q <= i_arrayidx10_reluactivation_reluactivation13_mult_x_align_14_qint(39 downto 0);

    -- i_arrayidx10_reluactivation_reluactivation13_mult_x_join_16(BITJOIN,82)@7
    i_arrayidx10_reluactivation_reluactivation13_mult_x_join_16_q <= i_arrayidx10_reluactivation_reluactivation13_mult_x_align_15_q & i_arrayidx10_reluactivation_reluactivation13_mult_x_align_14_q;

    -- i_arrayidx10_reluactivation_reluactivation13_mult_x_im9_shift0(BITSHIFT,106)@7
    i_arrayidx10_reluactivation_reluactivation13_mult_x_im9_shift0_qint <= i_arrayidx10_reluactivation_reluactivation13_mult_x_bs1_merged_bit_select_e & "000";
    i_arrayidx10_reluactivation_reluactivation13_mult_x_im9_shift0_q <= i_arrayidx10_reluactivation_reluactivation13_mult_x_im9_shift0_qint(20 downto 0);

    -- i_arrayidx10_reluactivation_reluactivation13_mult_x_align_12(BITSHIFT,78)@7
    i_arrayidx10_reluactivation_reluactivation13_mult_x_align_12_qint <= STD_LOGIC_VECTOR("0" & i_arrayidx10_reluactivation_reluactivation13_mult_x_im9_shift0_q) & "00000000000000";
    i_arrayidx10_reluactivation_reluactivation13_mult_x_align_12_q <= i_arrayidx10_reluactivation_reluactivation13_mult_x_align_12_qint(35 downto 0);

    -- i_arrayidx10_reluactivation_reluactivation13_mult_x_im0_shift0(BITSHIFT,103)@7
    i_arrayidx10_reluactivation_reluactivation13_mult_x_im0_shift0_qint <= i_arrayidx10_reluactivation_reluactivation13_mult_x_bs1_merged_bit_select_b & "000";
    i_arrayidx10_reluactivation_reluactivation13_mult_x_im0_shift0_q <= i_arrayidx10_reluactivation_reluactivation13_mult_x_im0_shift0_qint(20 downto 0);

    -- i_arrayidx10_reluactivation_reluactivation13_mult_x_join_13(BITJOIN,79)@7
    i_arrayidx10_reluactivation_reluactivation13_mult_x_join_13_q <= i_arrayidx10_reluactivation_reluactivation13_mult_x_align_12_q & STD_LOGIC_VECTOR("0" & i_arrayidx10_reluactivation_reluactivation13_mult_x_im0_shift0_q);

    -- i_arrayidx10_reluactivation_reluactivation13_mult_x_result_add_0_0(ADD,83)@7
    i_arrayidx10_reluactivation_reluactivation13_mult_x_result_add_0_0_a <= STD_LOGIC_VECTOR("00000000000" & i_arrayidx10_reluactivation_reluactivation13_mult_x_join_13_q);
    i_arrayidx10_reluactivation_reluactivation13_mult_x_result_add_0_0_b <= STD_LOGIC_VECTOR("0" & i_arrayidx10_reluactivation_reluactivation13_mult_x_join_16_q);
    i_arrayidx10_reluactivation_reluactivation13_mult_x_result_add_0_0_o <= STD_LOGIC_VECTOR(UNSIGNED(i_arrayidx10_reluactivation_reluactivation13_mult_x_result_add_0_0_a) + UNSIGNED(i_arrayidx10_reluactivation_reluactivation13_mult_x_result_add_0_0_b));
    i_arrayidx10_reluactivation_reluactivation13_mult_x_result_add_0_0_q <= i_arrayidx10_reluactivation_reluactivation13_mult_x_result_add_0_0_o(68 downto 0);

    -- i_arrayidx10_reluactivation_reluactivation13_mult_extender_x(BITJOIN,27)@7
    i_arrayidx10_reluactivation_reluactivation13_mult_extender_x_q <= i_arrayidx10_reluactivation_reluactivation13_mult_multconst_x_q & i_arrayidx10_reluactivation_reluactivation13_mult_x_result_add_0_0_q(67 downto 0);

    -- i_arrayidx10_reluactivation_reluactivation13_trunc_sel_x(BITSELECT,29)@7
    i_arrayidx10_reluactivation_reluactivation13_trunc_sel_x_b <= i_arrayidx10_reluactivation_reluactivation13_mult_extender_x_q(63 downto 0);

    -- i_arrayidx_reluactivation_reluactivation12_mult_x_im3_shift0(BITSHIFT,108)@7
    i_arrayidx_reluactivation_reluactivation12_mult_x_im3_shift0_qint <= i_arrayidx10_reluactivation_reluactivation13_mult_x_bs1_merged_bit_select_c & "000";
    i_arrayidx_reluactivation_reluactivation12_mult_x_im3_shift0_q <= i_arrayidx_reluactivation_reluactivation12_mult_x_im3_shift0_qint(12 downto 0);

    -- i_arrayidx_reluactivation_reluactivation12_mult_x_align_15(BITSHIFT,99)@7
    i_arrayidx_reluactivation_reluactivation12_mult_x_align_15_qint <= STD_LOGIC_VECTOR("0" & i_arrayidx_reluactivation_reluactivation12_mult_x_im3_shift0_q) & "00000000000000";
    i_arrayidx_reluactivation_reluactivation12_mult_x_align_15_q <= i_arrayidx_reluactivation_reluactivation12_mult_x_align_15_qint(27 downto 0);

    -- i_arrayidx_reluactivation_reluactivation12_mult_x_im6_shift0(BITSHIFT,109)@7
    i_arrayidx_reluactivation_reluactivation12_mult_x_im6_shift0_qint <= i_arrayidx10_reluactivation_reluactivation13_mult_x_bs1_merged_bit_select_d & "000";
    i_arrayidx_reluactivation_reluactivation12_mult_x_im6_shift0_q <= i_arrayidx_reluactivation_reluactivation12_mult_x_im6_shift0_qint(20 downto 0);

    -- i_arrayidx_reluactivation_reluactivation12_mult_x_align_14(BITSHIFT,98)@7
    i_arrayidx_reluactivation_reluactivation12_mult_x_align_14_qint <= STD_LOGIC_VECTOR("0" & i_arrayidx_reluactivation_reluactivation12_mult_x_im6_shift0_q) & "000000000000000000";
    i_arrayidx_reluactivation_reluactivation12_mult_x_align_14_q <= i_arrayidx_reluactivation_reluactivation12_mult_x_align_14_qint(39 downto 0);

    -- i_arrayidx_reluactivation_reluactivation12_mult_x_join_16(BITJOIN,100)@7
    i_arrayidx_reluactivation_reluactivation12_mult_x_join_16_q <= i_arrayidx_reluactivation_reluactivation12_mult_x_align_15_q & i_arrayidx_reluactivation_reluactivation12_mult_x_align_14_q;

    -- i_arrayidx_reluactivation_reluactivation12_mult_x_im9_shift0(BITSHIFT,110)@7
    i_arrayidx_reluactivation_reluactivation12_mult_x_im9_shift0_qint <= i_arrayidx10_reluactivation_reluactivation13_mult_x_bs1_merged_bit_select_e & "000";
    i_arrayidx_reluactivation_reluactivation12_mult_x_im9_shift0_q <= i_arrayidx_reluactivation_reluactivation12_mult_x_im9_shift0_qint(20 downto 0);

    -- i_arrayidx_reluactivation_reluactivation12_mult_x_align_12(BITSHIFT,96)@7
    i_arrayidx_reluactivation_reluactivation12_mult_x_align_12_qint <= STD_LOGIC_VECTOR("0" & i_arrayidx_reluactivation_reluactivation12_mult_x_im9_shift0_q) & "00000000000000";
    i_arrayidx_reluactivation_reluactivation12_mult_x_align_12_q <= i_arrayidx_reluactivation_reluactivation12_mult_x_align_12_qint(35 downto 0);

    -- i_arrayidx_reluactivation_reluactivation12_mult_x_im0_shift0(BITSHIFT,107)@7
    i_arrayidx_reluactivation_reluactivation12_mult_x_im0_shift0_qint <= i_arrayidx10_reluactivation_reluactivation13_mult_x_bs1_merged_bit_select_b & "000";
    i_arrayidx_reluactivation_reluactivation12_mult_x_im0_shift0_q <= i_arrayidx_reluactivation_reluactivation12_mult_x_im0_shift0_qint(20 downto 0);

    -- i_arrayidx_reluactivation_reluactivation12_mult_x_join_13(BITJOIN,97)@7
    i_arrayidx_reluactivation_reluactivation12_mult_x_join_13_q <= i_arrayidx_reluactivation_reluactivation12_mult_x_align_12_q & STD_LOGIC_VECTOR("0" & i_arrayidx_reluactivation_reluactivation12_mult_x_im0_shift0_q);

    -- i_arrayidx_reluactivation_reluactivation12_mult_x_result_add_0_0(ADD,101)@7
    i_arrayidx_reluactivation_reluactivation12_mult_x_result_add_0_0_a <= STD_LOGIC_VECTOR("00000000000" & i_arrayidx_reluactivation_reluactivation12_mult_x_join_13_q);
    i_arrayidx_reluactivation_reluactivation12_mult_x_result_add_0_0_b <= STD_LOGIC_VECTOR("0" & i_arrayidx_reluactivation_reluactivation12_mult_x_join_16_q);
    i_arrayidx_reluactivation_reluactivation12_mult_x_result_add_0_0_o <= STD_LOGIC_VECTOR(UNSIGNED(i_arrayidx_reluactivation_reluactivation12_mult_x_result_add_0_0_a) + UNSIGNED(i_arrayidx_reluactivation_reluactivation12_mult_x_result_add_0_0_b));
    i_arrayidx_reluactivation_reluactivation12_mult_x_result_add_0_0_q <= i_arrayidx_reluactivation_reluactivation12_mult_x_result_add_0_0_o(68 downto 0);

    -- i_arrayidx_reluactivation_reluactivation12_mult_extender_x(BITJOIN,37)@7
    i_arrayidx_reluactivation_reluactivation12_mult_extender_x_q <= i_arrayidx10_reluactivation_reluactivation13_mult_multconst_x_q & i_arrayidx_reluactivation_reluactivation12_mult_x_result_add_0_0_q(67 downto 0);

    -- i_arrayidx_reluactivation_reluactivation12_trunc_sel_x(BITSELECT,39)@7
    i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b <= i_arrayidx_reluactivation_reluactivation12_mult_extender_x_q(63 downto 0);

    -- SR_SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0(STALLREG,279)
    SR_SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SR_SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_r_valid <= (others => '0');
            SR_SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_r_data0 <= (others => '-');
            SR_SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_r_data1 <= (others => '-');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Valid
            SR_SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_r_valid <= SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_backStall and (SR_SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_r_valid or SR_SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_i_valid);

            IF (SR_SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_r_valid = "0") THEN
                -- Data(s)
                SR_SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_r_data0 <= STD_LOGIC_VECTOR(i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b);
                SR_SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_r_data1 <= STD_LOGIC_VECTOR(i_arrayidx10_reluactivation_reluactivation13_trunc_sel_x_b);
            END IF;

        END IF;
    END PROCESS;
    -- Computing multiple Valid(s)
    SR_SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_i_valid <= SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_V0;
    -- Stall signal propagation
    SR_SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_backStall <= SR_SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_r_valid or not (SR_SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_i_valid);

    -- Valid
    SR_SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_V <= SR_SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_r_valid WHEN SR_SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_r_valid = "1" ELSE SR_SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_i_valid;

    -- Data0
    SR_SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_D0 <= SR_SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_r_data0 WHEN SR_SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_r_valid = "1" ELSE i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b;
    -- Data1
    SR_SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_D1 <= SR_SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_r_data1 WHEN SR_SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_r_valid = "1" ELSE i_arrayidx10_reluactivation_reluactivation13_trunc_sel_x_b;

    -- SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5(STALLENABLE,222)
    -- Valid signal propagation
    SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_V0 <= SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_R_v_0;
    -- Stall signal propagation
    SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_s_tv_0 <= SR_SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_backStall and SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_R_v_0;
    -- Backward Enable generation
    SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_backEN <= not (SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_v_s_0 <= SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_backEN and SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_V;
    -- Backward Stall generation
    SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_backStall <= not (SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_backEN);
    SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_backEN = "0") THEN
                SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_R_v_0 <= SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_R_v_0 and SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_s_tv_0;
            ELSE
                SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_R_v_0 <= SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5(STALLREG,278)
    SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_r_valid <= (others => '0');
            SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_r_data0 <= (others => '-');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Valid
            SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_r_valid <= SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_backStall and (SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_r_valid or SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_i_valid);

            IF (SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_r_valid = "0") THEN
                -- Data(s)
                SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_r_data0 <= STD_LOGIC_VECTOR(redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_q);
            END IF;

        END IF;
    END PROCESS;
    -- Computing multiple Valid(s)
    SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_i_valid <= SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_V0;
    -- Stall signal propagation
    SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_backStall <= SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_r_valid or not (SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_i_valid);

    -- Valid
    SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_V <= SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_r_valid WHEN SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_r_valid = "1" ELSE SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_i_valid;

    SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_D0 <= SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_r_data0 WHEN SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_r_valid = "1" ELSE redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_q;

    -- SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4(STALLENABLE,221)
    -- Valid signal propagation
    SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_V0 <= SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_R_v_0;
    -- Stall signal propagation
    SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_s_tv_0 <= SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_5_backStall and SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_R_v_0;
    -- Backward Enable generation
    SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_backEN <= not (SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_v_s_0 <= SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_backEN and SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_V;
    -- Backward Stall generation
    SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_backStall <= not (SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_backEN);
    SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_backEN = "0") THEN
                SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_R_v_0 <= SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_R_v_0 and SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_s_tv_0;
            ELSE
                SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_R_v_0 <= SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4(STALLREG,277)
    SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_r_valid <= (others => '0');
            SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_r_data0 <= (others => '-');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Valid
            SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_r_valid <= SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_backStall and (SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_r_valid or SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_i_valid);

            IF (SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_r_valid = "0") THEN
                -- Data(s)
                SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_r_data0 <= STD_LOGIC_VECTOR(redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_q);
            END IF;

        END IF;
    END PROCESS;
    -- Computing multiple Valid(s)
    SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_i_valid <= SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_V0;
    -- Stall signal propagation
    SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_backStall <= SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_r_valid or not (SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_i_valid);

    -- Valid
    SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_V <= SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_r_valid WHEN SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_r_valid = "1" ELSE SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_i_valid;

    SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_D0 <= SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_r_data0 WHEN SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_r_valid = "1" ELSE redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_q;

    -- SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3(STALLENABLE,220)
    -- Valid signal propagation
    SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_V0 <= SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_R_v_0;
    -- Stall signal propagation
    SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_s_tv_0 <= SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_4_backStall and SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_R_v_0;
    -- Backward Enable generation
    SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_backEN <= not (SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_v_s_0 <= SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_backEN and SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_V;
    -- Backward Stall generation
    SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_backStall <= not (SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_backEN);
    SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_backEN = "0") THEN
                SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_R_v_0 <= SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_R_v_0 and SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_s_tv_0;
            ELSE
                SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_R_v_0 <= SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3(STALLREG,276)
    SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_r_valid <= (others => '0');
            SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_r_data0 <= (others => '-');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Valid
            SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_r_valid <= SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_backStall and (SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_r_valid or SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_i_valid);

            IF (SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_r_valid = "0") THEN
                -- Data(s)
                SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_r_data0 <= STD_LOGIC_VECTOR(redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_q);
            END IF;

        END IF;
    END PROCESS;
    -- Computing multiple Valid(s)
    SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_i_valid <= SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_V0;
    -- Stall signal propagation
    SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_backStall <= SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_r_valid or not (SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_i_valid);

    -- Valid
    SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_V <= SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_r_valid WHEN SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_r_valid = "1" ELSE SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_i_valid;

    SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_D0 <= SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_r_data0 WHEN SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_r_valid = "1" ELSE redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_q;

    -- SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2(STALLENABLE,219)
    -- Valid signal propagation
    SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_V0 <= SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_R_v_0;
    -- Stall signal propagation
    SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_s_tv_0 <= SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_3_backStall and SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_R_v_0;
    -- Backward Enable generation
    SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_backEN <= not (SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_v_s_0 <= SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_backEN and SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_V;
    -- Backward Stall generation
    SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_backStall <= not (SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_backEN);
    SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_backEN = "0") THEN
                SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_R_v_0 <= SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_R_v_0 and SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_s_tv_0;
            ELSE
                SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_R_v_0 <= SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2(STALLREG,275)
    SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_r_valid <= (others => '0');
            SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_r_data0 <= (others => '-');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Valid
            SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_r_valid <= SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_backStall and (SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_r_valid or SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_i_valid);

            IF (SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_r_valid = "0") THEN
                -- Data(s)
                SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_r_data0 <= STD_LOGIC_VECTOR(redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_q);
            END IF;

        END IF;
    END PROCESS;
    -- Computing multiple Valid(s)
    SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_i_valid <= SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_V0;
    -- Stall signal propagation
    SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_backStall <= SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_r_valid or not (SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_i_valid);

    -- Valid
    SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_V <= SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_r_valid WHEN SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_r_valid = "1" ELSE SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_i_valid;

    SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_D0 <= SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_r_data0 WHEN SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_r_valid = "1" ELSE redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_q;

    -- SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1(STALLENABLE,218)
    -- Valid signal propagation
    SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_V0 <= SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_R_v_0;
    -- Stall signal propagation
    SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_s_tv_0 <= SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_2_backStall and SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_R_v_0;
    -- Backward Enable generation
    SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_backEN <= not (SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_v_s_0 <= SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_backEN and SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_V;
    -- Backward Stall generation
    SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_backStall <= not (SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_backEN);
    SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_backEN = "0") THEN
                SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_R_v_0 <= SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_R_v_0 and SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_s_tv_0;
            ELSE
                SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_R_v_0 <= SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1(STALLREG,274)
    SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_r_valid <= (others => '0');
            SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_r_data0 <= (others => '-');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Valid
            SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_r_valid <= SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_backStall and (SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_r_valid or SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_i_valid);

            IF (SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_r_valid = "0") THEN
                -- Data(s)
                SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_r_data0 <= STD_LOGIC_VECTOR(redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_q);
            END IF;

        END IF;
    END PROCESS;
    -- Computing multiple Valid(s)
    SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_i_valid <= SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_V0;
    -- Stall signal propagation
    SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_backStall <= SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_r_valid or not (SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_i_valid);

    -- Valid
    SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_V <= SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_r_valid WHEN SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_r_valid = "1" ELSE SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_i_valid;

    SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_D0 <= SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_r_data0 WHEN SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_r_valid = "1" ELSE redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_q;

    -- SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0(STALLENABLE,217)
    -- Valid signal propagation
    SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_V0 <= SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_R_v_0;
    -- Stall signal propagation
    SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_s_tv_0 <= SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_1_backStall and SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_R_v_0;
    -- Backward Enable generation
    SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_backEN <= not (SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_v_s_0 <= SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_backEN and SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_V;
    -- Backward Stall generation
    SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_backStall <= not (SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_backEN);
    SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_backEN = "0") THEN
                SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_R_v_0 <= SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_R_v_0 and SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_s_tv_0;
            ELSE
                SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_R_v_0 <= SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0(STALLREG,273)
    SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_r_valid <= (others => '0');
            SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_r_data0 <= (others => '-');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Valid
            SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_r_valid <= SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_backStall and (SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_r_valid or SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_i_valid);

            IF (SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_r_valid = "0") THEN
                -- Data(s)
                SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_r_data0 <= STD_LOGIC_VECTOR(bubble_select_RELUActivation_B0_merge_reg_aunroll_x_b);
            END IF;

        END IF;
    END PROCESS;
    -- Computing multiple Valid(s)
    SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_i_valid <= SE_out_RELUActivation_B0_merge_reg_aunroll_x_V2;
    -- Stall signal propagation
    SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_backStall <= SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_r_valid or not (SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_i_valid);

    -- Valid
    SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_V <= SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_r_valid WHEN SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_r_valid = "1" ELSE SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_i_valid;

    SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_D0 <= SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_r_data0 WHEN SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_r_valid = "1" ELSE bubble_select_RELUActivation_B0_merge_reg_aunroll_x_b;

    -- redist3_i_arrayidx10_reluactivation_reluactivation13_trunc_sel_x_b_1_0(REG,121)
    redist3_i_arrayidx10_reluactivation_reluactivation13_trunc_sel_x_b_1_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist3_i_arrayidx10_reluactivation_reluactivation13_trunc_sel_x_b_1_0_q <= "0000000000000000000000000000000000000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_backEN = "1") THEN
                redist3_i_arrayidx10_reluactivation_reluactivation13_trunc_sel_x_b_1_0_q <= STD_LOGIC_VECTOR(SR_SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_D1);
            END IF;
        END IF;
    END PROCESS;

    -- bubble_join_i_syncbuf_a_sync_buffer_reluactivation(BITJOIN,145)
    bubble_join_i_syncbuf_a_sync_buffer_reluactivation_q <= i_syncbuf_a_sync_buffer_reluactivation_out_buffer_out;

    -- bubble_select_i_syncbuf_a_sync_buffer_reluactivation(BITSELECT,146)
    bubble_select_i_syncbuf_a_sync_buffer_reluactivation_b <= STD_LOGIC_VECTOR(bubble_join_i_syncbuf_a_sync_buffer_reluactivation_q(63 downto 0));

    -- i_arrayidx10_reluactivation_reluactivation13_add_x(ADD,30)@8
    i_arrayidx10_reluactivation_reluactivation13_add_x_a <= STD_LOGIC_VECTOR("0" & bubble_select_i_syncbuf_a_sync_buffer_reluactivation_b);
    i_arrayidx10_reluactivation_reluactivation13_add_x_b <= STD_LOGIC_VECTOR("0" & redist3_i_arrayidx10_reluactivation_reluactivation13_trunc_sel_x_b_1_0_q);
    i_arrayidx10_reluactivation_reluactivation13_add_x_o <= STD_LOGIC_VECTOR(UNSIGNED(i_arrayidx10_reluactivation_reluactivation13_add_x_a) + UNSIGNED(i_arrayidx10_reluactivation_reluactivation13_add_x_b));
    i_arrayidx10_reluactivation_reluactivation13_add_x_q <= i_arrayidx10_reluactivation_reluactivation13_add_x_o(64 downto 0);

    -- i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x(BITSELECT,24)@8
    i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b <= i_arrayidx10_reluactivation_reluactivation13_add_x_q(63 downto 0);

    -- redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo(STALLFIFO,122)
    redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_valid_in <= SE_out_i_syncbuf_a_sync_buffer_reluactivation_V0;
    redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_stall_in <= SE_out_redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_backStall;
    redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_data_in <= i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b;
    redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_valid_in_bitsignaltemp <= redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_valid_in(0);
    redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_stall_in_bitsignaltemp <= redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_stall_in(0);
    redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_valid_out(0) <= redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_valid_out_bitsignaltemp;
    redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_stall_out(0) <= redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_stall_out_bitsignaltemp;
    theredist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo : acl_data_fifo
    GENERIC MAP (
        DEPTH => 141,
        STRICT_DEPTH => 0,
        ALLOW_FULL_WRITE => 0,
        DATA_WIDTH => 64,
        IMPL => "ram"
    )
    PORT MAP (
        valid_in => redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_valid_in_bitsignaltemp,
        stall_in => redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_stall_in_bitsignaltemp,
        data_in => i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b,
        valid_out => redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_valid_out_bitsignaltemp,
        stall_out => redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_stall_out_bitsignaltemp,
        data_out => redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_data_out,
        clock => clock,
        resetn => resetn
    );

    -- SE_out_i_syncbuf_a_sync_buffer_reluactivation(STALLENABLE,183)
    -- Valid signal propagation
    SE_out_i_syncbuf_a_sync_buffer_reluactivation_V0 <= SE_out_i_syncbuf_a_sync_buffer_reluactivation_wireValid;
    -- Backward Stall generation
    SE_out_i_syncbuf_a_sync_buffer_reluactivation_backStall <= redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_stall_out or not (SE_out_i_syncbuf_a_sync_buffer_reluactivation_wireValid);
    -- Computing multiple Valid(s)
    SE_out_i_syncbuf_a_sync_buffer_reluactivation_and0 <= i_syncbuf_a_sync_buffer_reluactivation_out_valid_out;
    SE_out_i_syncbuf_a_sync_buffer_reluactivation_wireValid <= SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_V1 and SE_out_i_syncbuf_a_sync_buffer_reluactivation_and0;

    -- i_syncbuf_a_sync_buffer_reluactivation(BLACKBOX,56)@8
    -- in in_stall_in@20000000
    -- out out_stall_out@20000000
    thei_syncbuf_a_sync_buffer_reluactivation : i_syncbuf_a_sync_buffer_reluactivation10
    PORT MAP (
        in_buffer_in => in_A,
        in_i_dependence => GND_q,
        in_stall_in => SE_out_i_syncbuf_a_sync_buffer_reluactivation_backStall,
        in_valid_in => SE_out_bubble_out_RELUActivation_B0_merge_reg_aunroll_x_2_V0,
        out_buffer_out => i_syncbuf_a_sync_buffer_reluactivation_out_buffer_out,
        out_stall_out => i_syncbuf_a_sync_buffer_reluactivation_out_stall_out,
        out_valid_out => i_syncbuf_a_sync_buffer_reluactivation_out_valid_out,
        clock => clock,
        resetn => resetn
    );

    -- SE_out_bubble_out_RELUActivation_B0_merge_reg_aunroll_x_2(STALLENABLE,230)
    -- Valid signal propagation
    SE_out_bubble_out_RELUActivation_B0_merge_reg_aunroll_x_2_V0 <= SE_out_bubble_out_RELUActivation_B0_merge_reg_aunroll_x_2_wireValid;
    -- Backward Stall generation
    SE_out_bubble_out_RELUActivation_B0_merge_reg_aunroll_x_2_backStall <= i_syncbuf_a_sync_buffer_reluactivation_out_stall_out or not (SE_out_bubble_out_RELUActivation_B0_merge_reg_aunroll_x_2_wireValid);
    -- Computing multiple Valid(s)
    SE_out_bubble_out_RELUActivation_B0_merge_reg_aunroll_x_2_wireValid <= bubble_out_RELUActivation_B0_merge_reg_aunroll_x_2_reg_valid_out;

    -- bubble_out_RELUActivation_B0_merge_reg_aunroll_x_2_reg(STALLFIFO,272)
    bubble_out_RELUActivation_B0_merge_reg_aunroll_x_2_reg_valid_in <= SE_out_RELUActivation_B0_merge_reg_aunroll_x_V1;
    bubble_out_RELUActivation_B0_merge_reg_aunroll_x_2_reg_stall_in <= SE_out_bubble_out_RELUActivation_B0_merge_reg_aunroll_x_2_backStall;
    bubble_out_RELUActivation_B0_merge_reg_aunroll_x_2_reg_valid_in_bitsignaltemp <= bubble_out_RELUActivation_B0_merge_reg_aunroll_x_2_reg_valid_in(0);
    bubble_out_RELUActivation_B0_merge_reg_aunroll_x_2_reg_stall_in_bitsignaltemp <= bubble_out_RELUActivation_B0_merge_reg_aunroll_x_2_reg_stall_in(0);
    bubble_out_RELUActivation_B0_merge_reg_aunroll_x_2_reg_valid_out(0) <= bubble_out_RELUActivation_B0_merge_reg_aunroll_x_2_reg_valid_out_bitsignaltemp;
    bubble_out_RELUActivation_B0_merge_reg_aunroll_x_2_reg_stall_out(0) <= bubble_out_RELUActivation_B0_merge_reg_aunroll_x_2_reg_stall_out_bitsignaltemp;
    thebubble_out_RELUActivation_B0_merge_reg_aunroll_x_2_reg : acl_valid_fifo_counter
    GENERIC MAP (
        DEPTH => 8,
        STRICT_DEPTH => 0,
        ALLOW_FULL_WRITE => 0,
        ASYNC_RESET => 1
    )
    PORT MAP (
        valid_in => bubble_out_RELUActivation_B0_merge_reg_aunroll_x_2_reg_valid_in_bitsignaltemp,
        stall_in => bubble_out_RELUActivation_B0_merge_reg_aunroll_x_2_reg_stall_in_bitsignaltemp,
        valid_out => bubble_out_RELUActivation_B0_merge_reg_aunroll_x_2_reg_valid_out_bitsignaltemp,
        stall_out => bubble_out_RELUActivation_B0_merge_reg_aunroll_x_2_reg_stall_out_bitsignaltemp,
        clock => clock,
        resetn => resetn
    );

    -- SE_out_bubble_out_RELUActivation_B0_merge_reg_aunroll_x_1(STALLENABLE,228)
    -- Valid signal propagation
    SE_out_bubble_out_RELUActivation_B0_merge_reg_aunroll_x_1_V0 <= SE_out_bubble_out_RELUActivation_B0_merge_reg_aunroll_x_1_wireValid;
    -- Backward Stall generation
    SE_out_bubble_out_RELUActivation_B0_merge_reg_aunroll_x_1_backStall <= i_syncbuf_z_sync_buffer_reluactivation_out_stall_out or not (SE_out_bubble_out_RELUActivation_B0_merge_reg_aunroll_x_1_wireValid);
    -- Computing multiple Valid(s)
    SE_out_bubble_out_RELUActivation_B0_merge_reg_aunroll_x_1_wireValid <= bubble_out_RELUActivation_B0_merge_reg_aunroll_x_1_reg_valid_out;

    -- bubble_out_RELUActivation_B0_merge_reg_aunroll_x_1_reg(STALLFIFO,271)
    bubble_out_RELUActivation_B0_merge_reg_aunroll_x_1_reg_valid_in <= SE_out_RELUActivation_B0_merge_reg_aunroll_x_V0;
    bubble_out_RELUActivation_B0_merge_reg_aunroll_x_1_reg_stall_in <= SE_out_bubble_out_RELUActivation_B0_merge_reg_aunroll_x_1_backStall;
    bubble_out_RELUActivation_B0_merge_reg_aunroll_x_1_reg_valid_in_bitsignaltemp <= bubble_out_RELUActivation_B0_merge_reg_aunroll_x_1_reg_valid_in(0);
    bubble_out_RELUActivation_B0_merge_reg_aunroll_x_1_reg_stall_in_bitsignaltemp <= bubble_out_RELUActivation_B0_merge_reg_aunroll_x_1_reg_stall_in(0);
    bubble_out_RELUActivation_B0_merge_reg_aunroll_x_1_reg_valid_out(0) <= bubble_out_RELUActivation_B0_merge_reg_aunroll_x_1_reg_valid_out_bitsignaltemp;
    bubble_out_RELUActivation_B0_merge_reg_aunroll_x_1_reg_stall_out(0) <= bubble_out_RELUActivation_B0_merge_reg_aunroll_x_1_reg_stall_out_bitsignaltemp;
    thebubble_out_RELUActivation_B0_merge_reg_aunroll_x_1_reg : acl_valid_fifo_counter
    GENERIC MAP (
        DEPTH => 8,
        STRICT_DEPTH => 0,
        ALLOW_FULL_WRITE => 0,
        ASYNC_RESET => 1
    )
    PORT MAP (
        valid_in => bubble_out_RELUActivation_B0_merge_reg_aunroll_x_1_reg_valid_in_bitsignaltemp,
        stall_in => bubble_out_RELUActivation_B0_merge_reg_aunroll_x_1_reg_stall_in_bitsignaltemp,
        valid_out => bubble_out_RELUActivation_B0_merge_reg_aunroll_x_1_reg_valid_out_bitsignaltemp,
        stall_out => bubble_out_RELUActivation_B0_merge_reg_aunroll_x_1_reg_stall_out_bitsignaltemp,
        clock => clock,
        resetn => resetn
    );

    -- SE_stall_entry(STALLENABLE,186)
    -- Valid signal propagation
    SE_stall_entry_V0 <= SE_stall_entry_wireValid;
    -- Backward Stall generation
    SE_stall_entry_backStall <= RELUActivation_B0_merge_reg_aunroll_x_out_stall_out or not (SE_stall_entry_wireValid);
    -- Computing multiple Valid(s)
    SE_stall_entry_wireValid <= in_valid_in;

    -- bubble_join_stall_entry(BITJOIN,151)
    bubble_join_stall_entry_q <= in_global_id_0;

    -- bubble_select_stall_entry(BITSELECT,152)
    bubble_select_stall_entry_b <= STD_LOGIC_VECTOR(bubble_join_stall_entry_q(31 downto 0));

    -- RELUActivation_B0_merge_reg_aunroll_x(BLACKBOX,2)@0
    -- in in_stall_in@20000000
    -- out out_data_out_0@1
    -- out out_stall_out@20000000
    -- out out_valid_out@1
    theRELUActivation_B0_merge_reg_aunroll_x : RELUActivation_B0_merge_reg
    PORT MAP (
        in_data_in_0 => bubble_select_stall_entry_b,
        in_stall_in => SE_out_RELUActivation_B0_merge_reg_aunroll_x_backStall,
        in_valid_in => SE_stall_entry_V0,
        out_data_out_0 => RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0,
        out_stall_out => RELUActivation_B0_merge_reg_aunroll_x_out_stall_out,
        out_valid_out => RELUActivation_B0_merge_reg_aunroll_x_out_valid_out,
        clock => clock,
        resetn => resetn
    );

    -- SE_out_RELUActivation_B0_merge_reg_aunroll_x(STALLENABLE,164)
    SE_out_RELUActivation_B0_merge_reg_aunroll_x_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_out_RELUActivation_B0_merge_reg_aunroll_x_fromReg0 <= (others => '0');
            SE_out_RELUActivation_B0_merge_reg_aunroll_x_fromReg1 <= (others => '0');
            SE_out_RELUActivation_B0_merge_reg_aunroll_x_fromReg2 <= (others => '0');
            SE_out_RELUActivation_B0_merge_reg_aunroll_x_fromReg3 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Succesor 0
            SE_out_RELUActivation_B0_merge_reg_aunroll_x_fromReg0 <= SE_out_RELUActivation_B0_merge_reg_aunroll_x_toReg0;
            -- Succesor 1
            SE_out_RELUActivation_B0_merge_reg_aunroll_x_fromReg1 <= SE_out_RELUActivation_B0_merge_reg_aunroll_x_toReg1;
            -- Succesor 2
            SE_out_RELUActivation_B0_merge_reg_aunroll_x_fromReg2 <= SE_out_RELUActivation_B0_merge_reg_aunroll_x_toReg2;
            -- Succesor 3
            SE_out_RELUActivation_B0_merge_reg_aunroll_x_fromReg3 <= SE_out_RELUActivation_B0_merge_reg_aunroll_x_toReg3;
        END IF;
    END PROCESS;
    -- Input Stall processing
    SE_out_RELUActivation_B0_merge_reg_aunroll_x_consumed0 <= (not (bubble_out_RELUActivation_B0_merge_reg_aunroll_x_1_reg_stall_out) and SE_out_RELUActivation_B0_merge_reg_aunroll_x_wireValid) or SE_out_RELUActivation_B0_merge_reg_aunroll_x_fromReg0;
    SE_out_RELUActivation_B0_merge_reg_aunroll_x_consumed1 <= (not (bubble_out_RELUActivation_B0_merge_reg_aunroll_x_2_reg_stall_out) and SE_out_RELUActivation_B0_merge_reg_aunroll_x_wireValid) or SE_out_RELUActivation_B0_merge_reg_aunroll_x_fromReg1;
    SE_out_RELUActivation_B0_merge_reg_aunroll_x_consumed2 <= (not (SR_SE_redist5_RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0_6_0_backStall) and SE_out_RELUActivation_B0_merge_reg_aunroll_x_wireValid) or SE_out_RELUActivation_B0_merge_reg_aunroll_x_fromReg2;
    SE_out_RELUActivation_B0_merge_reg_aunroll_x_consumed3 <= (not (i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_o_stall) and SE_out_RELUActivation_B0_merge_reg_aunroll_x_wireValid) or SE_out_RELUActivation_B0_merge_reg_aunroll_x_fromReg3;
    -- Consuming
    SE_out_RELUActivation_B0_merge_reg_aunroll_x_StallValid <= SE_out_RELUActivation_B0_merge_reg_aunroll_x_backStall and SE_out_RELUActivation_B0_merge_reg_aunroll_x_wireValid;
    SE_out_RELUActivation_B0_merge_reg_aunroll_x_toReg0 <= SE_out_RELUActivation_B0_merge_reg_aunroll_x_StallValid and SE_out_RELUActivation_B0_merge_reg_aunroll_x_consumed0;
    SE_out_RELUActivation_B0_merge_reg_aunroll_x_toReg1 <= SE_out_RELUActivation_B0_merge_reg_aunroll_x_StallValid and SE_out_RELUActivation_B0_merge_reg_aunroll_x_consumed1;
    SE_out_RELUActivation_B0_merge_reg_aunroll_x_toReg2 <= SE_out_RELUActivation_B0_merge_reg_aunroll_x_StallValid and SE_out_RELUActivation_B0_merge_reg_aunroll_x_consumed2;
    SE_out_RELUActivation_B0_merge_reg_aunroll_x_toReg3 <= SE_out_RELUActivation_B0_merge_reg_aunroll_x_StallValid and SE_out_RELUActivation_B0_merge_reg_aunroll_x_consumed3;
    -- Backward Stall generation
    SE_out_RELUActivation_B0_merge_reg_aunroll_x_or0 <= SE_out_RELUActivation_B0_merge_reg_aunroll_x_consumed0;
    SE_out_RELUActivation_B0_merge_reg_aunroll_x_or1 <= SE_out_RELUActivation_B0_merge_reg_aunroll_x_consumed1 and SE_out_RELUActivation_B0_merge_reg_aunroll_x_or0;
    SE_out_RELUActivation_B0_merge_reg_aunroll_x_or2 <= SE_out_RELUActivation_B0_merge_reg_aunroll_x_consumed2 and SE_out_RELUActivation_B0_merge_reg_aunroll_x_or1;
    SE_out_RELUActivation_B0_merge_reg_aunroll_x_wireStall <= not (SE_out_RELUActivation_B0_merge_reg_aunroll_x_consumed3 and SE_out_RELUActivation_B0_merge_reg_aunroll_x_or2);
    SE_out_RELUActivation_B0_merge_reg_aunroll_x_backStall <= SE_out_RELUActivation_B0_merge_reg_aunroll_x_wireStall;
    -- Valid signal propagation
    SE_out_RELUActivation_B0_merge_reg_aunroll_x_V0 <= SE_out_RELUActivation_B0_merge_reg_aunroll_x_wireValid and not (SE_out_RELUActivation_B0_merge_reg_aunroll_x_fromReg0);
    SE_out_RELUActivation_B0_merge_reg_aunroll_x_V1 <= SE_out_RELUActivation_B0_merge_reg_aunroll_x_wireValid and not (SE_out_RELUActivation_B0_merge_reg_aunroll_x_fromReg1);
    SE_out_RELUActivation_B0_merge_reg_aunroll_x_V2 <= SE_out_RELUActivation_B0_merge_reg_aunroll_x_wireValid and not (SE_out_RELUActivation_B0_merge_reg_aunroll_x_fromReg2);
    SE_out_RELUActivation_B0_merge_reg_aunroll_x_V3 <= SE_out_RELUActivation_B0_merge_reg_aunroll_x_wireValid and not (SE_out_RELUActivation_B0_merge_reg_aunroll_x_fromReg3);
    -- Computing multiple Valid(s)
    SE_out_RELUActivation_B0_merge_reg_aunroll_x_wireValid <= RELUActivation_B0_merge_reg_aunroll_x_out_valid_out;

    -- bubble_join_RELUActivation_B0_merge_reg_aunroll_x(BITJOIN,130)
    bubble_join_RELUActivation_B0_merge_reg_aunroll_x_q <= RELUActivation_B0_merge_reg_aunroll_x_out_data_out_0;

    -- bubble_select_RELUActivation_B0_merge_reg_aunroll_x(BITSELECT,131)
    bubble_select_RELUActivation_B0_merge_reg_aunroll_x_b <= STD_LOGIC_VECTOR(bubble_join_RELUActivation_B0_merge_reg_aunroll_x_q(31 downto 0));

    -- i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x(BLACKBOX,45)@1
    -- in in_i_stall@20000000
    -- out out_c0_exit_0@8
    -- out out_c0_exit_1@8
    -- out out_c0_exit_2@8
    -- out out_o_stall@20000000
    -- out out_o_valid@8
    thei_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x : i_sfc_c0_entry_reluactivation_c0_enter_reluactivation
    PORT MAP (
        in_c0_eni1_0 => GND_q,
        in_c0_eni1_1 => bubble_select_RELUActivation_B0_merge_reg_aunroll_x_b,
        in_Z_x_dim => in_Z_x_dim,
        in_Z_y_dim => in_Z_y_dim,
        in_i_stall => SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_backStall,
        in_i_valid => SE_out_RELUActivation_B0_merge_reg_aunroll_x_V3,
        out_c0_exit_1 => i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1,
        out_c0_exit_2 => i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_2,
        out_o_stall => i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_o_stall,
        out_o_valid => i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_o_valid,
        clock => clock,
        resetn => resetn
    );

    -- SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x(STALLENABLE,175)
    SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_fromReg0 <= (others => '0');
            SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_fromReg1 <= (others => '0');
            SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_fromReg2 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Succesor 0
            SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_fromReg0 <= SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_toReg0;
            -- Succesor 1
            SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_fromReg1 <= SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_toReg1;
            -- Succesor 2
            SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_fromReg2 <= SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_toReg2;
        END IF;
    END PROCESS;
    -- Input Stall processing
    SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_consumed0 <= (not (SE_out_i_syncbuf_z_sync_buffer_reluactivation_backStall) and SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_wireValid) or SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_fromReg0;
    SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_consumed1 <= (not (redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo_stall_out) and SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_wireValid) or SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_fromReg1;
    SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_consumed2 <= (not (redist1_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_2_140_fifo_stall_out) and SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_wireValid) or SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_fromReg2;
    -- Consuming
    SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_StallValid <= SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_backStall and SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_wireValid;
    SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_toReg0 <= SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_StallValid and SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_consumed0;
    SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_toReg1 <= SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_StallValid and SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_consumed1;
    SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_toReg2 <= SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_StallValid and SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_consumed2;
    -- Backward Stall generation
    SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_or0 <= SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_consumed0;
    SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_or1 <= SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_consumed1 and SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_or0;
    SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_wireStall <= not (SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_consumed2 and SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_or1);
    SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_backStall <= SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_wireStall;
    -- Valid signal propagation
    SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_V0 <= SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_wireValid and not (SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_fromReg0);
    SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_V1 <= SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_wireValid and not (SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_fromReg1);
    SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_V2 <= SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_wireValid and not (SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_fromReg2);
    -- Computing multiple Valid(s)
    SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_wireValid <= i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_o_valid;

    -- SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0(STALLENABLE,213)
    -- Valid signal propagation
    SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_V0 <= SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_R_v_0;
    SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_V1 <= SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_R_v_1;
    -- Stall signal propagation
    SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_s_tv_0 <= SE_out_i_syncbuf_z_sync_buffer_reluactivation_backStall and SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_R_v_0;
    SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_s_tv_1 <= SE_out_i_syncbuf_a_sync_buffer_reluactivation_backStall and SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_R_v_1;
    -- Backward Enable generation
    SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_or0 <= SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_s_tv_0;
    SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_backEN <= not (SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_s_tv_1 or SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_or0);
    -- Determine whether to write valid data into the first register stage
    SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_v_s_0 <= SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_backEN and SR_SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_V;
    -- Backward Stall generation
    SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_backStall <= not (SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_backEN);
    SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_R_v_0 <= (others => '0');
            SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_R_v_1 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_backEN = "0") THEN
                SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_R_v_0 <= SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_R_v_0 and SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_s_tv_0;
            ELSE
                SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_R_v_0 <= SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_v_s_0;
            END IF;

            IF (SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_backEN = "0") THEN
                SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_R_v_1 <= SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_R_v_1 and SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_s_tv_1;
            ELSE
                SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_R_v_1 <= SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- i_syncbuf_z_sync_buffer_reluactivation(BLACKBOX,57)@8
    -- in in_stall_in@20000000
    -- out out_stall_out@20000000
    thei_syncbuf_z_sync_buffer_reluactivation : i_syncbuf_z_sync_buffer_reluactivation8
    PORT MAP (
        in_buffer_in => in_Z,
        in_i_dependence => GND_q,
        in_stall_in => SE_out_i_syncbuf_z_sync_buffer_reluactivation_backStall,
        in_valid_in => SE_out_bubble_out_RELUActivation_B0_merge_reg_aunroll_x_1_V0,
        out_buffer_out => i_syncbuf_z_sync_buffer_reluactivation_out_buffer_out,
        out_stall_out => i_syncbuf_z_sync_buffer_reluactivation_out_stall_out,
        out_valid_out => i_syncbuf_z_sync_buffer_reluactivation_out_valid_out,
        clock => clock,
        resetn => resetn
    );

    -- SE_out_i_syncbuf_z_sync_buffer_reluactivation(STALLENABLE,185)
    -- Valid signal propagation
    SE_out_i_syncbuf_z_sync_buffer_reluactivation_V0 <= SE_out_i_syncbuf_z_sync_buffer_reluactivation_wireValid;
    -- Backward Stall generation
    SE_out_i_syncbuf_z_sync_buffer_reluactivation_backStall <= i_load_unnamed_reluactivation0_reluactivation_out_o_stall or not (SE_out_i_syncbuf_z_sync_buffer_reluactivation_wireValid);
    -- Computing multiple Valid(s)
    SE_out_i_syncbuf_z_sync_buffer_reluactivation_and0 <= i_syncbuf_z_sync_buffer_reluactivation_out_valid_out;
    SE_out_i_syncbuf_z_sync_buffer_reluactivation_and1 <= SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_V0 and SE_out_i_syncbuf_z_sync_buffer_reluactivation_and0;
    SE_out_i_syncbuf_z_sync_buffer_reluactivation_wireValid <= SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_V0 and SE_out_i_syncbuf_z_sync_buffer_reluactivation_and1;

    -- bubble_join_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x(BITJOIN,135)
    bubble_join_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_q <= i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_2 & i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1;

    -- bubble_select_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x(BITSELECT,136)
    bubble_select_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_b <= STD_LOGIC_VECTOR(bubble_join_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_q(0 downto 0));
    bubble_select_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_c <= STD_LOGIC_VECTOR(bubble_join_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_q(1 downto 1));

    -- redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0(REG,120)
    redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_q <= "0000000000000000000000000000000000000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_backEN = "1") THEN
                redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_q <= STD_LOGIC_VECTOR(SR_SE_redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_D0);
            END IF;
        END IF;
    END PROCESS;

    -- bubble_join_i_syncbuf_z_sync_buffer_reluactivation(BITJOIN,148)
    bubble_join_i_syncbuf_z_sync_buffer_reluactivation_q <= i_syncbuf_z_sync_buffer_reluactivation_out_buffer_out;

    -- bubble_select_i_syncbuf_z_sync_buffer_reluactivation(BITSELECT,149)
    bubble_select_i_syncbuf_z_sync_buffer_reluactivation_b <= STD_LOGIC_VECTOR(bubble_join_i_syncbuf_z_sync_buffer_reluactivation_q(63 downto 0));

    -- i_arrayidx_reluactivation_reluactivation12_add_x(ADD,40)@8
    i_arrayidx_reluactivation_reluactivation12_add_x_a <= STD_LOGIC_VECTOR("0" & bubble_select_i_syncbuf_z_sync_buffer_reluactivation_b);
    i_arrayidx_reluactivation_reluactivation12_add_x_b <= STD_LOGIC_VECTOR("0" & redist2_i_arrayidx_reluactivation_reluactivation12_trunc_sel_x_b_1_0_q);
    i_arrayidx_reluactivation_reluactivation12_add_x_o <= STD_LOGIC_VECTOR(UNSIGNED(i_arrayidx_reluactivation_reluactivation12_add_x_a) + UNSIGNED(i_arrayidx_reluactivation_reluactivation12_add_x_b));
    i_arrayidx_reluactivation_reluactivation12_add_x_q <= i_arrayidx_reluactivation_reluactivation12_add_x_o(64 downto 0);

    -- i_arrayidx_reluactivation_reluactivation12_dupName_0_trunc_sel_x(BITSELECT,34)@8
    i_arrayidx_reluactivation_reluactivation12_dupName_0_trunc_sel_x_b <= i_arrayidx_reluactivation_reluactivation12_add_x_q(63 downto 0);

    -- i_load_unnamed_reluactivation0_reluactivation(BLACKBOX,54)@8
    -- in in_i_stall@20000000
    -- out out_o_readdata@142
    -- out out_o_stall@20000000
    -- out out_o_valid@142
    -- out out_unnamed_RELUActivation0_avm_address@20000000
    -- out out_unnamed_RELUActivation0_avm_burstcount@20000000
    -- out out_unnamed_RELUActivation0_avm_byteenable@20000000
    -- out out_unnamed_RELUActivation0_avm_enable@20000000
    -- out out_unnamed_RELUActivation0_avm_read@20000000
    -- out out_unnamed_RELUActivation0_avm_write@20000000
    -- out out_unnamed_RELUActivation0_avm_writedata@20000000
    thei_load_unnamed_reluactivation0_reluactivation : i_load_unnamed_reluactivation0_reluactivation14
    PORT MAP (
        in_flush => in_flush,
        in_i_address => i_arrayidx_reluactivation_reluactivation12_dupName_0_trunc_sel_x_b,
        in_i_predicate => bubble_select_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_c,
        in_i_stall => SE_out_redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo_backStall,
        in_i_valid => SE_out_i_syncbuf_z_sync_buffer_reluactivation_V0,
        in_unnamed_RELUActivation0_avm_readdata => in_unnamed_RELUActivation0_avm_readdata,
        in_unnamed_RELUActivation0_avm_readdatavalid => in_unnamed_RELUActivation0_avm_readdatavalid,
        in_unnamed_RELUActivation0_avm_waitrequest => in_unnamed_RELUActivation0_avm_waitrequest,
        in_unnamed_RELUActivation0_avm_writeack => in_unnamed_RELUActivation0_avm_writeack,
        out_o_readdata => i_load_unnamed_reluactivation0_reluactivation_out_o_readdata,
        out_o_stall => i_load_unnamed_reluactivation0_reluactivation_out_o_stall,
        out_o_valid => i_load_unnamed_reluactivation0_reluactivation_out_o_valid,
        out_unnamed_RELUActivation0_avm_address => i_load_unnamed_reluactivation0_reluactivation_out_unnamed_RELUActivation0_avm_address,
        out_unnamed_RELUActivation0_avm_burstcount => i_load_unnamed_reluactivation0_reluactivation_out_unnamed_RELUActivation0_avm_burstcount,
        out_unnamed_RELUActivation0_avm_byteenable => i_load_unnamed_reluactivation0_reluactivation_out_unnamed_RELUActivation0_avm_byteenable,
        out_unnamed_RELUActivation0_avm_enable => i_load_unnamed_reluactivation0_reluactivation_out_unnamed_RELUActivation0_avm_enable,
        out_unnamed_RELUActivation0_avm_read => i_load_unnamed_reluactivation0_reluactivation_out_unnamed_RELUActivation0_avm_read,
        out_unnamed_RELUActivation0_avm_write => i_load_unnamed_reluactivation0_reluactivation_out_unnamed_RELUActivation0_avm_write,
        out_unnamed_RELUActivation0_avm_writedata => i_load_unnamed_reluactivation0_reluactivation_out_unnamed_RELUActivation0_avm_writedata,
        clock => clock,
        resetn => resetn
    );

    -- redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo(STALLFIFO,118)
    redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo_valid_in <= SE_out_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_V1;
    redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo_stall_in <= SE_out_redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo_backStall;
    redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo_data_in <= bubble_select_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_b;
    redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo_valid_in_bitsignaltemp <= redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo_valid_in(0);
    redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo_stall_in_bitsignaltemp <= redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo_stall_in(0);
    redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo_valid_out(0) <= redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo_valid_out_bitsignaltemp;
    redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo_stall_out(0) <= redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo_stall_out_bitsignaltemp;
    theredist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo : acl_data_fifo
    GENERIC MAP (
        DEPTH => 135,
        STRICT_DEPTH => 0,
        ALLOW_FULL_WRITE => 0,
        DATA_WIDTH => 1,
        IMPL => "ram"
    )
    PORT MAP (
        valid_in => redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo_valid_in_bitsignaltemp,
        stall_in => redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo_stall_in_bitsignaltemp,
        data_in => bubble_select_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_b,
        valid_out => redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo_valid_out_bitsignaltemp,
        stall_out => redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo_stall_out_bitsignaltemp,
        data_out => redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo_data_out,
        clock => clock,
        resetn => resetn
    );

    -- SE_out_redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo(STALLENABLE,210)
    -- Valid signal propagation
    SE_out_redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo_V0 <= SE_out_redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo_wireValid;
    -- Backward Stall generation
    SE_out_redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo_backStall <= i_sfc_c1_entry_reluactivation_c1_enter_reluactivation_aunroll_x_out_o_stall or not (SE_out_redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo_wireValid);
    -- Computing multiple Valid(s)
    SE_out_redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo_and0 <= redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo_valid_out;
    SE_out_redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo_wireValid <= i_load_unnamed_reluactivation0_reluactivation_out_o_valid and SE_out_redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo_and0;

    -- bubble_join_redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo(BITJOIN,155)
    bubble_join_redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo_q <= redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo_data_out;

    -- bubble_select_redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo(BITSELECT,156)
    bubble_select_redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo_b <= STD_LOGIC_VECTOR(bubble_join_redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo_q(0 downto 0));

    -- bubble_join_i_load_unnamed_reluactivation0_reluactivation(BITJOIN,141)
    bubble_join_i_load_unnamed_reluactivation0_reluactivation_q <= i_load_unnamed_reluactivation0_reluactivation_out_o_readdata;

    -- bubble_select_i_load_unnamed_reluactivation0_reluactivation(BITSELECT,142)
    bubble_select_i_load_unnamed_reluactivation0_reluactivation_b <= STD_LOGIC_VECTOR(bubble_join_i_load_unnamed_reluactivation0_reluactivation_q(63 downto 0));

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- i_sfc_c1_entry_reluactivation_c1_enter_reluactivation_aunroll_x(BLACKBOX,46)@142
    -- in in_i_stall@20000000
    -- out out_c1_exit_0@148
    -- out out_c1_exit_1@148
    -- out out_o_stall@20000000
    -- out out_o_valid@148
    thei_sfc_c1_entry_reluactivation_c1_enter_reluactivation_aunroll_x : i_sfc_c1_entry_reluactivation_c1_enter_reluactivation
    PORT MAP (
        in_c1_eni2_0 => GND_q,
        in_c1_eni2_1 => bubble_select_i_load_unnamed_reluactivation0_reluactivation_b,
        in_c1_eni2_2 => bubble_select_redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo_b,
        in_i_stall => SE_out_redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_backStall,
        in_i_valid => SE_out_redist0_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_1_134_fifo_V0,
        out_c1_exit_1 => i_sfc_c1_entry_reluactivation_c1_enter_reluactivation_aunroll_x_out_c1_exit_1,
        out_o_stall => i_sfc_c1_entry_reluactivation_c1_enter_reluactivation_aunroll_x_out_o_stall,
        out_o_valid => i_sfc_c1_entry_reluactivation_c1_enter_reluactivation_aunroll_x_out_o_valid,
        clock => clock,
        resetn => resetn
    );

    -- bubble_join_i_sfc_c1_entry_reluactivation_c1_enter_reluactivation_aunroll_x(BITJOIN,138)
    bubble_join_i_sfc_c1_entry_reluactivation_c1_enter_reluactivation_aunroll_x_q <= i_sfc_c1_entry_reluactivation_c1_enter_reluactivation_aunroll_x_out_c1_exit_1;

    -- bubble_select_i_sfc_c1_entry_reluactivation_c1_enter_reluactivation_aunroll_x(BITSELECT,139)
    bubble_select_i_sfc_c1_entry_reluactivation_c1_enter_reluactivation_aunroll_x_b <= STD_LOGIC_VECTOR(bubble_join_i_sfc_c1_entry_reluactivation_c1_enter_reluactivation_aunroll_x_q(63 downto 0));

    -- SE_out_redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo(STALLENABLE,216)
    -- Valid signal propagation
    SE_out_redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_V0 <= SE_out_redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_wireValid;
    -- Backward Stall generation
    SE_out_redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_backStall <= i_store_unnamed_reluactivation1_reluactivation_out_o_stall or not (SE_out_redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_wireValid);
    -- Computing multiple Valid(s)
    SE_out_redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_and0 <= redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_valid_out;
    SE_out_redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_and1 <= redist1_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_2_140_fifo_valid_out and SE_out_redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_and0;
    SE_out_redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_wireValid <= i_sfc_c1_entry_reluactivation_c1_enter_reluactivation_aunroll_x_out_o_valid and SE_out_redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_and1;

    -- SE_out_i_store_unnamed_reluactivation1_reluactivation(STALLENABLE,181)
    -- Valid signal propagation
    SE_out_i_store_unnamed_reluactivation1_reluactivation_V0 <= SE_out_i_store_unnamed_reluactivation1_reluactivation_wireValid;
    -- Backward Stall generation
    SE_out_i_store_unnamed_reluactivation1_reluactivation_backStall <= in_stall_in or not (SE_out_i_store_unnamed_reluactivation1_reluactivation_wireValid);
    -- Computing multiple Valid(s)
    SE_out_i_store_unnamed_reluactivation1_reluactivation_wireValid <= i_store_unnamed_reluactivation1_reluactivation_out_o_valid;

    -- bubble_join_redist1_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_2_140_fifo(BITJOIN,158)
    bubble_join_redist1_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_2_140_fifo_q <= redist1_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_2_140_fifo_data_out;

    -- bubble_select_redist1_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_2_140_fifo(BITSELECT,159)
    bubble_select_redist1_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_2_140_fifo_b <= STD_LOGIC_VECTOR(bubble_join_redist1_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_2_140_fifo_q(0 downto 0));

    -- bubble_join_redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo(BITJOIN,161)
    bubble_join_redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_q <= redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_data_out;

    -- bubble_select_redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo(BITSELECT,162)
    bubble_select_redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_b <= STD_LOGIC_VECTOR(bubble_join_redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_q(63 downto 0));

    -- i_store_unnamed_reluactivation1_reluactivation(BLACKBOX,55)@148
    -- in in_i_stall@20000000
    -- out out_lsu_unnamed_RELUActivation1_o_active@20000000
    -- out out_o_stall@20000000
    -- out out_o_valid@150
    -- out out_unnamed_RELUActivation1_avm_address@20000000
    -- out out_unnamed_RELUActivation1_avm_burstcount@20000000
    -- out out_unnamed_RELUActivation1_avm_byteenable@20000000
    -- out out_unnamed_RELUActivation1_avm_enable@20000000
    -- out out_unnamed_RELUActivation1_avm_read@20000000
    -- out out_unnamed_RELUActivation1_avm_write@20000000
    -- out out_unnamed_RELUActivation1_avm_writedata@20000000
    thei_store_unnamed_reluactivation1_reluactivation : i_store_unnamed_reluactivation1_reluactivation19
    PORT MAP (
        in_flush => in_flush,
        in_i_address => bubble_select_redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_b,
        in_i_predicate => bubble_select_redist1_i_sfc_c0_entry_reluactivation_c0_enter_reluactivation_aunroll_x_out_c0_exit_2_140_fifo_b,
        in_i_stall => SE_out_i_store_unnamed_reluactivation1_reluactivation_backStall,
        in_i_valid => SE_out_redist4_i_arrayidx10_reluactivation_reluactivation13_dupName_0_trunc_sel_x_b_140_fifo_V0,
        in_i_writedata => bubble_select_i_sfc_c1_entry_reluactivation_c1_enter_reluactivation_aunroll_x_b,
        in_unnamed_RELUActivation1_avm_readdata => in_unnamed_RELUActivation1_avm_readdata,
        in_unnamed_RELUActivation1_avm_readdatavalid => in_unnamed_RELUActivation1_avm_readdatavalid,
        in_unnamed_RELUActivation1_avm_waitrequest => in_unnamed_RELUActivation1_avm_waitrequest,
        in_unnamed_RELUActivation1_avm_writeack => in_unnamed_RELUActivation1_avm_writeack,
        out_lsu_unnamed_RELUActivation1_o_active => i_store_unnamed_reluactivation1_reluactivation_out_lsu_unnamed_RELUActivation1_o_active,
        out_o_stall => i_store_unnamed_reluactivation1_reluactivation_out_o_stall,
        out_o_valid => i_store_unnamed_reluactivation1_reluactivation_out_o_valid,
        out_unnamed_RELUActivation1_avm_address => i_store_unnamed_reluactivation1_reluactivation_out_unnamed_RELUActivation1_avm_address,
        out_unnamed_RELUActivation1_avm_burstcount => i_store_unnamed_reluactivation1_reluactivation_out_unnamed_RELUActivation1_avm_burstcount,
        out_unnamed_RELUActivation1_avm_byteenable => i_store_unnamed_reluactivation1_reluactivation_out_unnamed_RELUActivation1_avm_byteenable,
        out_unnamed_RELUActivation1_avm_enable => i_store_unnamed_reluactivation1_reluactivation_out_unnamed_RELUActivation1_avm_enable,
        out_unnamed_RELUActivation1_avm_read => i_store_unnamed_reluactivation1_reluactivation_out_unnamed_RELUActivation1_avm_read,
        out_unnamed_RELUActivation1_avm_write => i_store_unnamed_reluactivation1_reluactivation_out_unnamed_RELUActivation1_avm_write,
        out_unnamed_RELUActivation1_avm_writedata => i_store_unnamed_reluactivation1_reluactivation_out_unnamed_RELUActivation1_avm_writedata,
        clock => clock,
        resetn => resetn
    );

    -- dupName_0_ext_sig_sync_out_x(GPOUT,4)
    out_unnamed_RELUActivation1_avm_address <= i_store_unnamed_reluactivation1_reluactivation_out_unnamed_RELUActivation1_avm_address;
    out_unnamed_RELUActivation1_avm_enable <= i_store_unnamed_reluactivation1_reluactivation_out_unnamed_RELUActivation1_avm_enable;
    out_unnamed_RELUActivation1_avm_read <= i_store_unnamed_reluactivation1_reluactivation_out_unnamed_RELUActivation1_avm_read;
    out_unnamed_RELUActivation1_avm_write <= i_store_unnamed_reluactivation1_reluactivation_out_unnamed_RELUActivation1_avm_write;
    out_unnamed_RELUActivation1_avm_writedata <= i_store_unnamed_reluactivation1_reluactivation_out_unnamed_RELUActivation1_avm_writedata;
    out_unnamed_RELUActivation1_avm_byteenable <= i_store_unnamed_reluactivation1_reluactivation_out_unnamed_RELUActivation1_avm_byteenable;
    out_unnamed_RELUActivation1_avm_burstcount <= i_store_unnamed_reluactivation1_reluactivation_out_unnamed_RELUActivation1_avm_burstcount;

    -- dupName_0_sync_out_x(GPOUT,9)@150
    out_valid_out <= SE_out_i_store_unnamed_reluactivation1_reluactivation_V0;

    -- dupName_1_ext_sig_sync_out_x(GPOUT,10)
    out_lsu_unnamed_RELUActivation1_o_active <= i_store_unnamed_reluactivation1_reluactivation_out_lsu_unnamed_RELUActivation1_o_active;

    -- ext_sig_sync_out(GPOUT,51)
    out_unnamed_RELUActivation0_avm_address <= i_load_unnamed_reluactivation0_reluactivation_out_unnamed_RELUActivation0_avm_address;
    out_unnamed_RELUActivation0_avm_enable <= i_load_unnamed_reluactivation0_reluactivation_out_unnamed_RELUActivation0_avm_enable;
    out_unnamed_RELUActivation0_avm_read <= i_load_unnamed_reluactivation0_reluactivation_out_unnamed_RELUActivation0_avm_read;
    out_unnamed_RELUActivation0_avm_write <= i_load_unnamed_reluactivation0_reluactivation_out_unnamed_RELUActivation0_avm_write;
    out_unnamed_RELUActivation0_avm_writedata <= i_load_unnamed_reluactivation0_reluactivation_out_unnamed_RELUActivation0_avm_writedata;
    out_unnamed_RELUActivation0_avm_byteenable <= i_load_unnamed_reluactivation0_reluactivation_out_unnamed_RELUActivation0_avm_byteenable;
    out_unnamed_RELUActivation0_avm_burstcount <= i_load_unnamed_reluactivation0_reluactivation_out_unnamed_RELUActivation0_avm_burstcount;

    -- sync_out(GPOUT,65)@0
    out_stall_out <= SE_stall_entry_backStall;

END normal;
