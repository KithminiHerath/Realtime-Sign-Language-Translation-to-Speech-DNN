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

-- VHDL created from matrix_multiply_function_wrapper
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

entity matrix_multiply_function_wrapper is
    port (
        avm_unnamed_matrix_multiply0_readdata : in std_logic_vector(255 downto 0);  -- ufix256
        avm_unnamed_matrix_multiply0_readdatavalid : in std_logic_vector(0 downto 0);  -- ufix1
        avm_unnamed_matrix_multiply0_waitrequest : in std_logic_vector(0 downto 0);  -- ufix1
        avm_unnamed_matrix_multiply0_writeack : in std_logic_vector(0 downto 0);  -- ufix1
        avm_unnamed_matrix_multiply1_readdata : in std_logic_vector(255 downto 0);  -- ufix256
        avm_unnamed_matrix_multiply1_readdatavalid : in std_logic_vector(0 downto 0);  -- ufix1
        avm_unnamed_matrix_multiply1_waitrequest : in std_logic_vector(0 downto 0);  -- ufix1
        avm_unnamed_matrix_multiply1_writeack : in std_logic_vector(0 downto 0);  -- ufix1
        avm_unnamed_matrix_multiply2_readdata : in std_logic_vector(255 downto 0);  -- ufix256
        avm_unnamed_matrix_multiply2_readdatavalid : in std_logic_vector(0 downto 0);  -- ufix1
        avm_unnamed_matrix_multiply2_waitrequest : in std_logic_vector(0 downto 0);  -- ufix1
        avm_unnamed_matrix_multiply2_writeack : in std_logic_vector(0 downto 0);  -- ufix1
        avm_unnamed_matrix_multiply3_readdata : in std_logic_vector(255 downto 0);  -- ufix256
        avm_unnamed_matrix_multiply3_readdatavalid : in std_logic_vector(0 downto 0);  -- ufix1
        avm_unnamed_matrix_multiply3_waitrequest : in std_logic_vector(0 downto 0);  -- ufix1
        avm_unnamed_matrix_multiply3_writeack : in std_logic_vector(0 downto 0);  -- ufix1
        clock2x : in std_logic_vector(0 downto 0);  -- ufix1
        global_id_0 : in std_logic_vector(31 downto 0);  -- ufix32
        global_id_1 : in std_logic_vector(31 downto 0);  -- ufix32
        global_id_2 : in std_logic_vector(31 downto 0);  -- ufix32
        global_offset_0 : in std_logic_vector(31 downto 0);  -- ufix32
        global_offset_1 : in std_logic_vector(31 downto 0);  -- ufix32
        global_offset_2 : in std_logic_vector(31 downto 0);  -- ufix32
        global_size_0 : in std_logic_vector(31 downto 0);  -- ufix32
        global_size_1 : in std_logic_vector(31 downto 0);  -- ufix32
        global_size_2 : in std_logic_vector(31 downto 0);  -- ufix32
        group_id_0 : in std_logic_vector(31 downto 0);  -- ufix32
        group_id_1 : in std_logic_vector(31 downto 0);  -- ufix32
        group_id_2 : in std_logic_vector(31 downto 0);  -- ufix32
        kernel_arguments : in std_logic_vector(351 downto 0);  -- ufix352
        kernel_stall_in : in std_logic_vector(0 downto 0);  -- ufix1
        kernel_valid_in : in std_logic_vector(0 downto 0);  -- ufix1
        local_id_0 : in std_logic_vector(31 downto 0);  -- ufix32
        local_id_1 : in std_logic_vector(31 downto 0);  -- ufix32
        local_id_2 : in std_logic_vector(31 downto 0);  -- ufix32
        local_router_hang : in std_logic_vector(0 downto 0);  -- ufix1
        local_size_0 : in std_logic_vector(31 downto 0);  -- ufix32
        local_size_1 : in std_logic_vector(31 downto 0);  -- ufix32
        local_size_2 : in std_logic_vector(31 downto 0);  -- ufix32
        num_groups_0 : in std_logic_vector(31 downto 0);  -- ufix32
        num_groups_1 : in std_logic_vector(31 downto 0);  -- ufix32
        num_groups_2 : in std_logic_vector(31 downto 0);  -- ufix32
        stall_in : in std_logic_vector(0 downto 0);  -- ufix1
        start : in std_logic_vector(0 downto 0);  -- ufix1
        valid_in : in std_logic_vector(0 downto 0);  -- ufix1
        work_dim : in std_logic_vector(31 downto 0);  -- ufix32
        workgroup_size : in std_logic_vector(31 downto 0);  -- ufix32
        avm_unnamed_matrix_multiply0_address : out std_logic_vector(29 downto 0);  -- ufix30
        avm_unnamed_matrix_multiply0_burstcount : out std_logic_vector(4 downto 0);  -- ufix5
        avm_unnamed_matrix_multiply0_byteenable : out std_logic_vector(31 downto 0);  -- ufix32
        avm_unnamed_matrix_multiply0_enable : out std_logic_vector(0 downto 0);  -- ufix1
        avm_unnamed_matrix_multiply0_read : out std_logic_vector(0 downto 0);  -- ufix1
        avm_unnamed_matrix_multiply0_write : out std_logic_vector(0 downto 0);  -- ufix1
        avm_unnamed_matrix_multiply0_writedata : out std_logic_vector(255 downto 0);  -- ufix256
        avm_unnamed_matrix_multiply1_address : out std_logic_vector(29 downto 0);  -- ufix30
        avm_unnamed_matrix_multiply1_burstcount : out std_logic_vector(4 downto 0);  -- ufix5
        avm_unnamed_matrix_multiply1_byteenable : out std_logic_vector(31 downto 0);  -- ufix32
        avm_unnamed_matrix_multiply1_enable : out std_logic_vector(0 downto 0);  -- ufix1
        avm_unnamed_matrix_multiply1_read : out std_logic_vector(0 downto 0);  -- ufix1
        avm_unnamed_matrix_multiply1_write : out std_logic_vector(0 downto 0);  -- ufix1
        avm_unnamed_matrix_multiply1_writedata : out std_logic_vector(255 downto 0);  -- ufix256
        avm_unnamed_matrix_multiply2_address : out std_logic_vector(29 downto 0);  -- ufix30
        avm_unnamed_matrix_multiply2_burstcount : out std_logic_vector(4 downto 0);  -- ufix5
        avm_unnamed_matrix_multiply2_byteenable : out std_logic_vector(31 downto 0);  -- ufix32
        avm_unnamed_matrix_multiply2_enable : out std_logic_vector(0 downto 0);  -- ufix1
        avm_unnamed_matrix_multiply2_read : out std_logic_vector(0 downto 0);  -- ufix1
        avm_unnamed_matrix_multiply2_write : out std_logic_vector(0 downto 0);  -- ufix1
        avm_unnamed_matrix_multiply2_writedata : out std_logic_vector(255 downto 0);  -- ufix256
        avm_unnamed_matrix_multiply3_address : out std_logic_vector(29 downto 0);  -- ufix30
        avm_unnamed_matrix_multiply3_burstcount : out std_logic_vector(4 downto 0);  -- ufix5
        avm_unnamed_matrix_multiply3_byteenable : out std_logic_vector(31 downto 0);  -- ufix32
        avm_unnamed_matrix_multiply3_enable : out std_logic_vector(0 downto 0);  -- ufix1
        avm_unnamed_matrix_multiply3_read : out std_logic_vector(0 downto 0);  -- ufix1
        avm_unnamed_matrix_multiply3_write : out std_logic_vector(0 downto 0);  -- ufix1
        avm_unnamed_matrix_multiply3_writedata : out std_logic_vector(255 downto 0);  -- ufix256
        clock2x_output : out std_logic_vector(0 downto 0);  -- ufix1
        has_a_lsu_active : out std_logic_vector(0 downto 0);  -- ufix1
        has_a_write_pending : out std_logic_vector(0 downto 0);  -- ufix1
        kernel_stall_out : out std_logic_vector(0 downto 0);  -- ufix1
        kernel_valid_out : out std_logic_vector(0 downto 0);  -- ufix1
        clock : in std_logic;
        resetn : in std_logic
    );
end matrix_multiply_function_wrapper;

architecture normal of matrix_multiply_function_wrapper is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    component acl_clock2x_holder is
        port (
            clock2x : in std_logic;
            myout : out std_logic;
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component matrix_multiply_function is
        port (
            in_arg_A : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_arg_B : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_arg_C : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_arg_D : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_arg_M : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_arg_N : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_arg_P : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_arg_acl_hw_wg_id : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_arg_global_id_0 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_arg_global_size_0 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_arg_global_size_1 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_arg_global_size_2 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_arg_local_size_0 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_arg_local_size_1 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_arg_local_size_2 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_start : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_matrix_multiply0_avm_readdata : in std_logic_vector(255 downto 0);  -- Fixed Point
            in_unnamed_matrix_multiply0_avm_readdatavalid : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_matrix_multiply0_avm_waitrequest : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_matrix_multiply0_avm_writeack : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_matrix_multiply1_avm_readdata : in std_logic_vector(255 downto 0);  -- Fixed Point
            in_unnamed_matrix_multiply1_avm_readdatavalid : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_matrix_multiply1_avm_waitrequest : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_matrix_multiply1_avm_writeack : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_matrix_multiply2_avm_readdata : in std_logic_vector(255 downto 0);  -- Fixed Point
            in_unnamed_matrix_multiply2_avm_readdatavalid : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_matrix_multiply2_avm_waitrequest : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_matrix_multiply2_avm_writeack : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_matrix_multiply3_avm_readdata : in std_logic_vector(255 downto 0);  -- Fixed Point
            in_unnamed_matrix_multiply3_avm_readdatavalid : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_matrix_multiply3_avm_waitrequest : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_matrix_multiply3_avm_writeack : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_acl_hw_wg_id5 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_o_active_unnamed_matrix_multiply3 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply0_avm_address : out std_logic_vector(29 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply0_avm_burstcount : out std_logic_vector(4 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply0_avm_byteenable : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply0_avm_enable : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply0_avm_read : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply0_avm_write : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply0_avm_writedata : out std_logic_vector(255 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply1_avm_address : out std_logic_vector(29 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply1_avm_burstcount : out std_logic_vector(4 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply1_avm_byteenable : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply1_avm_enable : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply1_avm_read : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply1_avm_write : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply1_avm_writedata : out std_logic_vector(255 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply2_avm_address : out std_logic_vector(29 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply2_avm_burstcount : out std_logic_vector(4 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply2_avm_byteenable : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply2_avm_enable : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply2_avm_read : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply2_avm_write : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply2_avm_writedata : out std_logic_vector(255 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply3_avm_address : out std_logic_vector(29 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply3_avm_burstcount : out std_logic_vector(4 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply3_avm_byteenable : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply3_avm_enable : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply3_avm_read : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply3_avm_write : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_matrix_multiply3_avm_writedata : out std_logic_vector(255 downto 0);  -- Fixed Point
            out_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal dupName_0_ip_dsdk_adapt_cast_x_b : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_1_ip_dsdk_adapt_cast_x_b : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_2_ip_dsdk_adapt_cast_x_b : STD_LOGIC_VECTOR (63 downto 0);
    signal dupName_3_ip_dsdk_adapt_cast_x_b : STD_LOGIC_VECTOR (63 downto 0);
    signal dupName_4_ip_dsdk_adapt_cast_x_b : STD_LOGIC_VECTOR (63 downto 0);
    signal dupName_5_ip_dsdk_adapt_cast_x_b : STD_LOGIC_VECTOR (63 downto 0);
    signal acl_clock2x_dummy_consumer_clock2x : STD_LOGIC_VECTOR (0 downto 0);
    signal acl_clock2x_dummy_consumer_clock2x_bitsignaltemp : std_logic;
    signal acl_clock2x_dummy_consumer_myout : STD_LOGIC_VECTOR (0 downto 0);
    signal acl_clock2x_dummy_consumer_myout_bitsignaltemp : std_logic;
    signal arg_A_select_b : STD_LOGIC_VECTOR (63 downto 0);
    signal arg_B_select_b : STD_LOGIC_VECTOR (63 downto 0);
    signal arg_C_select_b : STD_LOGIC_VECTOR (63 downto 0);
    signal arg_D_select_b : STD_LOGIC_VECTOR (63 downto 0);
    signal arg_M_select_b : STD_LOGIC_VECTOR (31 downto 0);
    signal arg_N_select_b : STD_LOGIC_VECTOR (31 downto 0);
    signal arg_P_select_b : STD_LOGIC_VECTOR (31 downto 0);
    signal const_32_bit_zero_q : STD_LOGIC_VECTOR (31 downto 0);
    signal ip_dsdk_adapt_cast_b : STD_LOGIC_VECTOR (31 downto 0);
    signal matrix_multiply_function_out_o_active_unnamed_matrix_multiply3 : STD_LOGIC_VECTOR (0 downto 0);
    signal matrix_multiply_function_out_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal matrix_multiply_function_out_unnamed_matrix_multiply0_avm_address : STD_LOGIC_VECTOR (29 downto 0);
    signal matrix_multiply_function_out_unnamed_matrix_multiply0_avm_burstcount : STD_LOGIC_VECTOR (4 downto 0);
    signal matrix_multiply_function_out_unnamed_matrix_multiply0_avm_byteenable : STD_LOGIC_VECTOR (31 downto 0);
    signal matrix_multiply_function_out_unnamed_matrix_multiply0_avm_enable : STD_LOGIC_VECTOR (0 downto 0);
    signal matrix_multiply_function_out_unnamed_matrix_multiply0_avm_read : STD_LOGIC_VECTOR (0 downto 0);
    signal matrix_multiply_function_out_unnamed_matrix_multiply0_avm_write : STD_LOGIC_VECTOR (0 downto 0);
    signal matrix_multiply_function_out_unnamed_matrix_multiply0_avm_writedata : STD_LOGIC_VECTOR (255 downto 0);
    signal matrix_multiply_function_out_unnamed_matrix_multiply1_avm_address : STD_LOGIC_VECTOR (29 downto 0);
    signal matrix_multiply_function_out_unnamed_matrix_multiply1_avm_burstcount : STD_LOGIC_VECTOR (4 downto 0);
    signal matrix_multiply_function_out_unnamed_matrix_multiply1_avm_byteenable : STD_LOGIC_VECTOR (31 downto 0);
    signal matrix_multiply_function_out_unnamed_matrix_multiply1_avm_enable : STD_LOGIC_VECTOR (0 downto 0);
    signal matrix_multiply_function_out_unnamed_matrix_multiply1_avm_read : STD_LOGIC_VECTOR (0 downto 0);
    signal matrix_multiply_function_out_unnamed_matrix_multiply1_avm_write : STD_LOGIC_VECTOR (0 downto 0);
    signal matrix_multiply_function_out_unnamed_matrix_multiply1_avm_writedata : STD_LOGIC_VECTOR (255 downto 0);
    signal matrix_multiply_function_out_unnamed_matrix_multiply2_avm_address : STD_LOGIC_VECTOR (29 downto 0);
    signal matrix_multiply_function_out_unnamed_matrix_multiply2_avm_burstcount : STD_LOGIC_VECTOR (4 downto 0);
    signal matrix_multiply_function_out_unnamed_matrix_multiply2_avm_byteenable : STD_LOGIC_VECTOR (31 downto 0);
    signal matrix_multiply_function_out_unnamed_matrix_multiply2_avm_enable : STD_LOGIC_VECTOR (0 downto 0);
    signal matrix_multiply_function_out_unnamed_matrix_multiply2_avm_read : STD_LOGIC_VECTOR (0 downto 0);
    signal matrix_multiply_function_out_unnamed_matrix_multiply2_avm_write : STD_LOGIC_VECTOR (0 downto 0);
    signal matrix_multiply_function_out_unnamed_matrix_multiply2_avm_writedata : STD_LOGIC_VECTOR (255 downto 0);
    signal matrix_multiply_function_out_unnamed_matrix_multiply3_avm_address : STD_LOGIC_VECTOR (29 downto 0);
    signal matrix_multiply_function_out_unnamed_matrix_multiply3_avm_burstcount : STD_LOGIC_VECTOR (4 downto 0);
    signal matrix_multiply_function_out_unnamed_matrix_multiply3_avm_byteenable : STD_LOGIC_VECTOR (31 downto 0);
    signal matrix_multiply_function_out_unnamed_matrix_multiply3_avm_enable : STD_LOGIC_VECTOR (0 downto 0);
    signal matrix_multiply_function_out_unnamed_matrix_multiply3_avm_read : STD_LOGIC_VECTOR (0 downto 0);
    signal matrix_multiply_function_out_unnamed_matrix_multiply3_avm_write : STD_LOGIC_VECTOR (0 downto 0);
    signal matrix_multiply_function_out_unnamed_matrix_multiply3_avm_writedata : STD_LOGIC_VECTOR (255 downto 0);
    signal matrix_multiply_function_out_valid_out : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- const_32_bit_zero(CONSTANT,17)
    const_32_bit_zero_q <= "00000000000000000000000000000000";

    -- arg_P_select(BITSELECT,15)
    arg_P_select_b <= kernel_arguments(95 downto 64);

    -- dupName_1_ip_dsdk_adapt_cast_x(BITSELECT,3)
    dupName_1_ip_dsdk_adapt_cast_x_b <= arg_P_select_b(31 downto 0);

    -- arg_N_select(BITSELECT,14)
    arg_N_select_b <= kernel_arguments(63 downto 32);

    -- dupName_0_ip_dsdk_adapt_cast_x(BITSELECT,2)
    dupName_0_ip_dsdk_adapt_cast_x_b <= arg_N_select_b(31 downto 0);

    -- arg_M_select(BITSELECT,13)
    arg_M_select_b <= kernel_arguments(31 downto 0);

    -- ip_dsdk_adapt_cast(BITSELECT,65)
    ip_dsdk_adapt_cast_b <= arg_M_select_b(31 downto 0);

    -- arg_D_select(BITSELECT,12)
    arg_D_select_b <= kernel_arguments(351 downto 288);

    -- dupName_5_ip_dsdk_adapt_cast_x(BITSELECT,7)
    dupName_5_ip_dsdk_adapt_cast_x_b <= arg_D_select_b(63 downto 0);

    -- arg_C_select(BITSELECT,11)
    arg_C_select_b <= kernel_arguments(287 downto 224);

    -- dupName_4_ip_dsdk_adapt_cast_x(BITSELECT,6)
    dupName_4_ip_dsdk_adapt_cast_x_b <= arg_C_select_b(63 downto 0);

    -- arg_B_select(BITSELECT,10)
    arg_B_select_b <= kernel_arguments(223 downto 160);

    -- dupName_3_ip_dsdk_adapt_cast_x(BITSELECT,5)
    dupName_3_ip_dsdk_adapt_cast_x_b <= arg_B_select_b(63 downto 0);

    -- arg_A_select(BITSELECT,9)
    arg_A_select_b <= kernel_arguments(159 downto 96);

    -- dupName_2_ip_dsdk_adapt_cast_x(BITSELECT,4)
    dupName_2_ip_dsdk_adapt_cast_x_b <= arg_A_select_b(63 downto 0);

    -- matrix_multiply_function(BLACKBOX,66)
    thematrix_multiply_function : matrix_multiply_function
    PORT MAP (
        in_arg_A => dupName_2_ip_dsdk_adapt_cast_x_b,
        in_arg_B => dupName_3_ip_dsdk_adapt_cast_x_b,
        in_arg_C => dupName_4_ip_dsdk_adapt_cast_x_b,
        in_arg_D => dupName_5_ip_dsdk_adapt_cast_x_b,
        in_arg_M => ip_dsdk_adapt_cast_b,
        in_arg_N => dupName_0_ip_dsdk_adapt_cast_x_b,
        in_arg_P => dupName_1_ip_dsdk_adapt_cast_x_b,
        in_arg_acl_hw_wg_id => const_32_bit_zero_q,
        in_arg_global_id_0 => global_id_0,
        in_arg_global_size_0 => global_size_0,
        in_arg_global_size_1 => global_size_1,
        in_arg_global_size_2 => global_size_2,
        in_arg_local_size_0 => local_size_0,
        in_arg_local_size_1 => local_size_1,
        in_arg_local_size_2 => local_size_2,
        in_stall_in => GND_q,
        in_start => start,
        in_unnamed_matrix_multiply0_avm_readdata => avm_unnamed_matrix_multiply0_readdata,
        in_unnamed_matrix_multiply0_avm_readdatavalid => avm_unnamed_matrix_multiply0_readdatavalid,
        in_unnamed_matrix_multiply0_avm_waitrequest => avm_unnamed_matrix_multiply0_waitrequest,
        in_unnamed_matrix_multiply0_avm_writeack => avm_unnamed_matrix_multiply0_writeack,
        in_unnamed_matrix_multiply1_avm_readdata => avm_unnamed_matrix_multiply1_readdata,
        in_unnamed_matrix_multiply1_avm_readdatavalid => avm_unnamed_matrix_multiply1_readdatavalid,
        in_unnamed_matrix_multiply1_avm_waitrequest => avm_unnamed_matrix_multiply1_waitrequest,
        in_unnamed_matrix_multiply1_avm_writeack => avm_unnamed_matrix_multiply1_writeack,
        in_unnamed_matrix_multiply2_avm_readdata => avm_unnamed_matrix_multiply2_readdata,
        in_unnamed_matrix_multiply2_avm_readdatavalid => avm_unnamed_matrix_multiply2_readdatavalid,
        in_unnamed_matrix_multiply2_avm_waitrequest => avm_unnamed_matrix_multiply2_waitrequest,
        in_unnamed_matrix_multiply2_avm_writeack => avm_unnamed_matrix_multiply2_writeack,
        in_unnamed_matrix_multiply3_avm_readdata => avm_unnamed_matrix_multiply3_readdata,
        in_unnamed_matrix_multiply3_avm_readdatavalid => avm_unnamed_matrix_multiply3_readdatavalid,
        in_unnamed_matrix_multiply3_avm_waitrequest => avm_unnamed_matrix_multiply3_waitrequest,
        in_unnamed_matrix_multiply3_avm_writeack => avm_unnamed_matrix_multiply3_writeack,
        in_valid_in => kernel_valid_in,
        out_o_active_unnamed_matrix_multiply3 => matrix_multiply_function_out_o_active_unnamed_matrix_multiply3,
        out_stall_out => matrix_multiply_function_out_stall_out,
        out_unnamed_matrix_multiply0_avm_address => matrix_multiply_function_out_unnamed_matrix_multiply0_avm_address,
        out_unnamed_matrix_multiply0_avm_burstcount => matrix_multiply_function_out_unnamed_matrix_multiply0_avm_burstcount,
        out_unnamed_matrix_multiply0_avm_byteenable => matrix_multiply_function_out_unnamed_matrix_multiply0_avm_byteenable,
        out_unnamed_matrix_multiply0_avm_enable => matrix_multiply_function_out_unnamed_matrix_multiply0_avm_enable,
        out_unnamed_matrix_multiply0_avm_read => matrix_multiply_function_out_unnamed_matrix_multiply0_avm_read,
        out_unnamed_matrix_multiply0_avm_write => matrix_multiply_function_out_unnamed_matrix_multiply0_avm_write,
        out_unnamed_matrix_multiply0_avm_writedata => matrix_multiply_function_out_unnamed_matrix_multiply0_avm_writedata,
        out_unnamed_matrix_multiply1_avm_address => matrix_multiply_function_out_unnamed_matrix_multiply1_avm_address,
        out_unnamed_matrix_multiply1_avm_burstcount => matrix_multiply_function_out_unnamed_matrix_multiply1_avm_burstcount,
        out_unnamed_matrix_multiply1_avm_byteenable => matrix_multiply_function_out_unnamed_matrix_multiply1_avm_byteenable,
        out_unnamed_matrix_multiply1_avm_enable => matrix_multiply_function_out_unnamed_matrix_multiply1_avm_enable,
        out_unnamed_matrix_multiply1_avm_read => matrix_multiply_function_out_unnamed_matrix_multiply1_avm_read,
        out_unnamed_matrix_multiply1_avm_write => matrix_multiply_function_out_unnamed_matrix_multiply1_avm_write,
        out_unnamed_matrix_multiply1_avm_writedata => matrix_multiply_function_out_unnamed_matrix_multiply1_avm_writedata,
        out_unnamed_matrix_multiply2_avm_address => matrix_multiply_function_out_unnamed_matrix_multiply2_avm_address,
        out_unnamed_matrix_multiply2_avm_burstcount => matrix_multiply_function_out_unnamed_matrix_multiply2_avm_burstcount,
        out_unnamed_matrix_multiply2_avm_byteenable => matrix_multiply_function_out_unnamed_matrix_multiply2_avm_byteenable,
        out_unnamed_matrix_multiply2_avm_enable => matrix_multiply_function_out_unnamed_matrix_multiply2_avm_enable,
        out_unnamed_matrix_multiply2_avm_read => matrix_multiply_function_out_unnamed_matrix_multiply2_avm_read,
        out_unnamed_matrix_multiply2_avm_write => matrix_multiply_function_out_unnamed_matrix_multiply2_avm_write,
        out_unnamed_matrix_multiply2_avm_writedata => matrix_multiply_function_out_unnamed_matrix_multiply2_avm_writedata,
        out_unnamed_matrix_multiply3_avm_address => matrix_multiply_function_out_unnamed_matrix_multiply3_avm_address,
        out_unnamed_matrix_multiply3_avm_burstcount => matrix_multiply_function_out_unnamed_matrix_multiply3_avm_burstcount,
        out_unnamed_matrix_multiply3_avm_byteenable => matrix_multiply_function_out_unnamed_matrix_multiply3_avm_byteenable,
        out_unnamed_matrix_multiply3_avm_enable => matrix_multiply_function_out_unnamed_matrix_multiply3_avm_enable,
        out_unnamed_matrix_multiply3_avm_read => matrix_multiply_function_out_unnamed_matrix_multiply3_avm_read,
        out_unnamed_matrix_multiply3_avm_write => matrix_multiply_function_out_unnamed_matrix_multiply3_avm_write,
        out_unnamed_matrix_multiply3_avm_writedata => matrix_multiply_function_out_unnamed_matrix_multiply3_avm_writedata,
        out_valid_out => matrix_multiply_function_out_valid_out,
        clock => clock,
        resetn => resetn
    );

    -- avm_unnamed_matrix_multiply0_address(GPOUT,67)
    avm_unnamed_matrix_multiply0_address <= matrix_multiply_function_out_unnamed_matrix_multiply0_avm_address;

    -- avm_unnamed_matrix_multiply0_burstcount(GPOUT,68)
    avm_unnamed_matrix_multiply0_burstcount <= matrix_multiply_function_out_unnamed_matrix_multiply0_avm_burstcount;

    -- avm_unnamed_matrix_multiply0_byteenable(GPOUT,69)
    avm_unnamed_matrix_multiply0_byteenable <= matrix_multiply_function_out_unnamed_matrix_multiply0_avm_byteenable;

    -- avm_unnamed_matrix_multiply0_enable(GPOUT,70)
    avm_unnamed_matrix_multiply0_enable <= matrix_multiply_function_out_unnamed_matrix_multiply0_avm_enable;

    -- avm_unnamed_matrix_multiply0_read(GPOUT,71)
    avm_unnamed_matrix_multiply0_read <= matrix_multiply_function_out_unnamed_matrix_multiply0_avm_read;

    -- avm_unnamed_matrix_multiply0_write(GPOUT,72)
    avm_unnamed_matrix_multiply0_write <= matrix_multiply_function_out_unnamed_matrix_multiply0_avm_write;

    -- avm_unnamed_matrix_multiply0_writedata(GPOUT,73)
    avm_unnamed_matrix_multiply0_writedata <= matrix_multiply_function_out_unnamed_matrix_multiply0_avm_writedata;

    -- avm_unnamed_matrix_multiply1_address(GPOUT,74)
    avm_unnamed_matrix_multiply1_address <= matrix_multiply_function_out_unnamed_matrix_multiply1_avm_address;

    -- avm_unnamed_matrix_multiply1_burstcount(GPOUT,75)
    avm_unnamed_matrix_multiply1_burstcount <= matrix_multiply_function_out_unnamed_matrix_multiply1_avm_burstcount;

    -- avm_unnamed_matrix_multiply1_byteenable(GPOUT,76)
    avm_unnamed_matrix_multiply1_byteenable <= matrix_multiply_function_out_unnamed_matrix_multiply1_avm_byteenable;

    -- avm_unnamed_matrix_multiply1_enable(GPOUT,77)
    avm_unnamed_matrix_multiply1_enable <= matrix_multiply_function_out_unnamed_matrix_multiply1_avm_enable;

    -- avm_unnamed_matrix_multiply1_read(GPOUT,78)
    avm_unnamed_matrix_multiply1_read <= matrix_multiply_function_out_unnamed_matrix_multiply1_avm_read;

    -- avm_unnamed_matrix_multiply1_write(GPOUT,79)
    avm_unnamed_matrix_multiply1_write <= matrix_multiply_function_out_unnamed_matrix_multiply1_avm_write;

    -- avm_unnamed_matrix_multiply1_writedata(GPOUT,80)
    avm_unnamed_matrix_multiply1_writedata <= matrix_multiply_function_out_unnamed_matrix_multiply1_avm_writedata;

    -- avm_unnamed_matrix_multiply2_address(GPOUT,81)
    avm_unnamed_matrix_multiply2_address <= matrix_multiply_function_out_unnamed_matrix_multiply2_avm_address;

    -- avm_unnamed_matrix_multiply2_burstcount(GPOUT,82)
    avm_unnamed_matrix_multiply2_burstcount <= matrix_multiply_function_out_unnamed_matrix_multiply2_avm_burstcount;

    -- avm_unnamed_matrix_multiply2_byteenable(GPOUT,83)
    avm_unnamed_matrix_multiply2_byteenable <= matrix_multiply_function_out_unnamed_matrix_multiply2_avm_byteenable;

    -- avm_unnamed_matrix_multiply2_enable(GPOUT,84)
    avm_unnamed_matrix_multiply2_enable <= matrix_multiply_function_out_unnamed_matrix_multiply2_avm_enable;

    -- avm_unnamed_matrix_multiply2_read(GPOUT,85)
    avm_unnamed_matrix_multiply2_read <= matrix_multiply_function_out_unnamed_matrix_multiply2_avm_read;

    -- avm_unnamed_matrix_multiply2_write(GPOUT,86)
    avm_unnamed_matrix_multiply2_write <= matrix_multiply_function_out_unnamed_matrix_multiply2_avm_write;

    -- avm_unnamed_matrix_multiply2_writedata(GPOUT,87)
    avm_unnamed_matrix_multiply2_writedata <= matrix_multiply_function_out_unnamed_matrix_multiply2_avm_writedata;

    -- avm_unnamed_matrix_multiply3_address(GPOUT,88)
    avm_unnamed_matrix_multiply3_address <= matrix_multiply_function_out_unnamed_matrix_multiply3_avm_address;

    -- avm_unnamed_matrix_multiply3_burstcount(GPOUT,89)
    avm_unnamed_matrix_multiply3_burstcount <= matrix_multiply_function_out_unnamed_matrix_multiply3_avm_burstcount;

    -- avm_unnamed_matrix_multiply3_byteenable(GPOUT,90)
    avm_unnamed_matrix_multiply3_byteenable <= matrix_multiply_function_out_unnamed_matrix_multiply3_avm_byteenable;

    -- avm_unnamed_matrix_multiply3_enable(GPOUT,91)
    avm_unnamed_matrix_multiply3_enable <= matrix_multiply_function_out_unnamed_matrix_multiply3_avm_enable;

    -- avm_unnamed_matrix_multiply3_read(GPOUT,92)
    avm_unnamed_matrix_multiply3_read <= matrix_multiply_function_out_unnamed_matrix_multiply3_avm_read;

    -- avm_unnamed_matrix_multiply3_write(GPOUT,93)
    avm_unnamed_matrix_multiply3_write <= matrix_multiply_function_out_unnamed_matrix_multiply3_avm_write;

    -- avm_unnamed_matrix_multiply3_writedata(GPOUT,94)
    avm_unnamed_matrix_multiply3_writedata <= matrix_multiply_function_out_unnamed_matrix_multiply3_avm_writedata;

    -- acl_clock2x_dummy_consumer(EXTIFACE,8)
    acl_clock2x_dummy_consumer_clock2x <= clock2x;
    acl_clock2x_dummy_consumer_clock2x_bitsignaltemp <= acl_clock2x_dummy_consumer_clock2x(0);
    acl_clock2x_dummy_consumer_myout(0) <= acl_clock2x_dummy_consumer_myout_bitsignaltemp;
    theacl_clock2x_dummy_consumer : acl_clock2x_holder
    PORT MAP (
        clock2x => acl_clock2x_dummy_consumer_clock2x_bitsignaltemp,
        myout => acl_clock2x_dummy_consumer_myout_bitsignaltemp,
        clock => clock,
        resetn => resetn
    );

    -- clock2x_output(GPOUT,95)
    clock2x_output <= acl_clock2x_dummy_consumer_myout;

    -- has_a_lsu_active(GPOUT,96)
    has_a_lsu_active <= matrix_multiply_function_out_o_active_unnamed_matrix_multiply3;

    -- has_a_write_pending(GPOUT,97)
    has_a_write_pending <= matrix_multiply_function_out_o_active_unnamed_matrix_multiply3;

    -- kernel_stall_out(GPOUT,98)
    kernel_stall_out <= matrix_multiply_function_out_stall_out;

    -- kernel_valid_out(GPOUT,99)
    kernel_valid_out <= matrix_multiply_function_out_valid_out;

END normal;
