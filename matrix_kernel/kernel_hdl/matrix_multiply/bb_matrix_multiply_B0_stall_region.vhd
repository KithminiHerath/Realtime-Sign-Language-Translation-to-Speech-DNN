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

-- VHDL created from bb_matrix_multiply_B0_stall_region
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

entity bb_matrix_multiply_B0_stall_region is
    port (
        in_acl_hw_wg_id : in std_logic_vector(31 downto 0);  -- ufix32
        in_global_id_0 : in std_logic_vector(31 downto 0);  -- ufix32
        in_valid_in : in std_logic_vector(0 downto 0);  -- ufix1
        out_acl_hw_wg_id : out std_logic_vector(31 downto 0);  -- ufix32
        out_c0_exe1 : out std_logic_vector(31 downto 0);  -- ufix32
        out_global_id_0 : out std_logic_vector(31 downto 0);  -- ufix32
        out_valid_out : out std_logic_vector(0 downto 0);  -- ufix1
        in_P : in std_logic_vector(31 downto 0);  -- ufix32
        in_stall_in : in std_logic_vector(0 downto 0);  -- ufix1
        out_stall_out : out std_logic_vector(0 downto 0);  -- ufix1
        clock : in std_logic;
        resetn : in std_logic
    );
end bb_matrix_multiply_B0_stall_region;

architecture normal of bb_matrix_multiply_B0_stall_region is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    component i_sfc_c0_entry_matrix_multiply_c0_enter_matrix_multiply is
        port (
            in_c0_eni1_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_c0_eni1_1 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_P : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_i_stall : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_valid : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exit_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exit_1 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_o_stall : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_valid : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component matrix_multiply_B0_merge_reg is
        port (
            in_data_in_0 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_data_in_1 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_data_out_0 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_data_out_1 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal i_sfc_c0_entry_matrix_multiply_c0_enter_matrix_multiply_aunroll_x_out_c0_exit_1 : STD_LOGIC_VECTOR (31 downto 0);
    signal i_sfc_c0_entry_matrix_multiply_c0_enter_matrix_multiply_aunroll_x_out_o_stall : STD_LOGIC_VECTOR (0 downto 0);
    signal i_sfc_c0_entry_matrix_multiply_c0_enter_matrix_multiply_aunroll_x_out_o_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0 : STD_LOGIC_VECTOR (31 downto 0);
    signal matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_1 : STD_LOGIC_VECTOR (31 downto 0);
    signal matrix_multiply_B0_merge_reg_aunroll_x_out_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal matrix_multiply_B0_merge_reg_aunroll_x_out_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_3_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_5_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist1_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_1_6_0_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist1_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_1_6_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist1_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_1_6_2_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist1_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_1_6_3_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist1_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_1_6_4_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist1_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_1_6_5_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_join_i_sfc_c0_entry_matrix_multiply_c0_enter_matrix_multiply_aunroll_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_i_sfc_c0_entry_matrix_multiply_c0_enter_matrix_multiply_aunroll_x_b : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_join_matrix_multiply_B0_merge_reg_aunroll_x_q : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_select_matrix_multiply_B0_merge_reg_aunroll_x_b : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_matrix_multiply_B0_merge_reg_aunroll_x_c : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_join_stall_entry_q : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_select_stall_entry_b : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_stall_entry_c : STD_LOGIC_VECTOR (31 downto 0);
    signal SE_out_i_sfc_c0_entry_matrix_multiply_c0_enter_matrix_multiply_aunroll_x_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_sfc_c0_entry_matrix_multiply_c0_enter_matrix_multiply_aunroll_x_and0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_sfc_c0_entry_matrix_multiply_c0_enter_matrix_multiply_aunroll_x_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_sfc_c0_entry_matrix_multiply_c0_enter_matrix_multiply_aunroll_x_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_matrix_multiply_B0_merge_reg_aunroll_x_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_matrix_multiply_B0_merge_reg_aunroll_x_wireStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_matrix_multiply_B0_merge_reg_aunroll_x_StallValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_matrix_multiply_B0_merge_reg_aunroll_x_toReg0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_matrix_multiply_B0_merge_reg_aunroll_x_fromReg0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_matrix_multiply_B0_merge_reg_aunroll_x_consumed0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_matrix_multiply_B0_merge_reg_aunroll_x_toReg1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_matrix_multiply_B0_merge_reg_aunroll_x_fromReg1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_matrix_multiply_B0_merge_reg_aunroll_x_consumed1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_matrix_multiply_B0_merge_reg_aunroll_x_or0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_matrix_multiply_B0_merge_reg_aunroll_x_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_matrix_multiply_B0_merge_reg_aunroll_x_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_matrix_multiply_B0_merge_reg_aunroll_x_V1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_0_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_0_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_0_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_0_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_0_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_0_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_1_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_1_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_1_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_1_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_1_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_1_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_3_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_3_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_3_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_3_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_3_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_3_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_5_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_5_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_5_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_5_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_5_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_5_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_i_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_r_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_r_data0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_r_data1 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_V : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_D0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_D1 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_i_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_r_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_r_data0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_r_data1 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_V : STD_LOGIC_VECTOR (0 downto 0);
    signal SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_D0 : STD_LOGIC_VECTOR (31 downto 0);
    signal SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_D1 : STD_LOGIC_VECTOR (31 downto 0);

begin


    -- SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2(STALLENABLE,51)
    -- Valid signal propagation
    SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_V0 <= SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_R_v_0;
    -- Stall signal propagation
    SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_s_tv_0 <= SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_3_backStall and SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_R_v_0;
    -- Backward Enable generation
    SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_backEN <= not (SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_v_s_0 <= SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_backEN and SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_V;
    -- Backward Stall generation
    SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_backStall <= not (SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_backEN);
    SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_backEN = "0") THEN
                SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_R_v_0 <= SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_R_v_0 and SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_s_tv_0;
            ELSE
                SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_R_v_0 <= SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SE_stall_entry(STALLENABLE,47)
    -- Valid signal propagation
    SE_stall_entry_V0 <= SE_stall_entry_wireValid;
    -- Backward Stall generation
    SE_stall_entry_backStall <= matrix_multiply_B0_merge_reg_aunroll_x_out_stall_out or not (SE_stall_entry_wireValid);
    -- Computing multiple Valid(s)
    SE_stall_entry_wireValid <= in_valid_in;

    -- bubble_join_stall_entry(BITJOIN,40)
    bubble_join_stall_entry_q <= in_global_id_0 & in_acl_hw_wg_id;

    -- bubble_select_stall_entry(BITSELECT,41)
    bubble_select_stall_entry_b <= STD_LOGIC_VECTOR(bubble_join_stall_entry_q(31 downto 0));
    bubble_select_stall_entry_c <= STD_LOGIC_VECTOR(bubble_join_stall_entry_q(63 downto 32));

    -- matrix_multiply_B0_merge_reg_aunroll_x(BLACKBOX,7)@0
    -- in in_stall_in@20000000
    -- out out_data_out_0@1
    -- out out_data_out_1@1
    -- out out_stall_out@20000000
    -- out out_valid_out@1
    thematrix_multiply_B0_merge_reg_aunroll_x : matrix_multiply_B0_merge_reg
    PORT MAP (
        in_data_in_0 => bubble_select_stall_entry_c,
        in_data_in_1 => bubble_select_stall_entry_b,
        in_stall_in => SE_out_matrix_multiply_B0_merge_reg_aunroll_x_backStall,
        in_valid_in => SE_stall_entry_V0,
        out_data_out_0 => matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0,
        out_data_out_1 => matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_1,
        out_stall_out => matrix_multiply_B0_merge_reg_aunroll_x_out_stall_out,
        out_valid_out => matrix_multiply_B0_merge_reg_aunroll_x_out_valid_out,
        clock => clock,
        resetn => resetn
    );

    -- SE_out_matrix_multiply_B0_merge_reg_aunroll_x(STALLENABLE,46)
    SE_out_matrix_multiply_B0_merge_reg_aunroll_x_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_out_matrix_multiply_B0_merge_reg_aunroll_x_fromReg0 <= (others => '0');
            SE_out_matrix_multiply_B0_merge_reg_aunroll_x_fromReg1 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Succesor 0
            SE_out_matrix_multiply_B0_merge_reg_aunroll_x_fromReg0 <= SE_out_matrix_multiply_B0_merge_reg_aunroll_x_toReg0;
            -- Succesor 1
            SE_out_matrix_multiply_B0_merge_reg_aunroll_x_fromReg1 <= SE_out_matrix_multiply_B0_merge_reg_aunroll_x_toReg1;
        END IF;
    END PROCESS;
    -- Input Stall processing
    SE_out_matrix_multiply_B0_merge_reg_aunroll_x_consumed0 <= (not (SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_0_backStall) and SE_out_matrix_multiply_B0_merge_reg_aunroll_x_wireValid) or SE_out_matrix_multiply_B0_merge_reg_aunroll_x_fromReg0;
    SE_out_matrix_multiply_B0_merge_reg_aunroll_x_consumed1 <= (not (i_sfc_c0_entry_matrix_multiply_c0_enter_matrix_multiply_aunroll_x_out_o_stall) and SE_out_matrix_multiply_B0_merge_reg_aunroll_x_wireValid) or SE_out_matrix_multiply_B0_merge_reg_aunroll_x_fromReg1;
    -- Consuming
    SE_out_matrix_multiply_B0_merge_reg_aunroll_x_StallValid <= SE_out_matrix_multiply_B0_merge_reg_aunroll_x_backStall and SE_out_matrix_multiply_B0_merge_reg_aunroll_x_wireValid;
    SE_out_matrix_multiply_B0_merge_reg_aunroll_x_toReg0 <= SE_out_matrix_multiply_B0_merge_reg_aunroll_x_StallValid and SE_out_matrix_multiply_B0_merge_reg_aunroll_x_consumed0;
    SE_out_matrix_multiply_B0_merge_reg_aunroll_x_toReg1 <= SE_out_matrix_multiply_B0_merge_reg_aunroll_x_StallValid and SE_out_matrix_multiply_B0_merge_reg_aunroll_x_consumed1;
    -- Backward Stall generation
    SE_out_matrix_multiply_B0_merge_reg_aunroll_x_or0 <= SE_out_matrix_multiply_B0_merge_reg_aunroll_x_consumed0;
    SE_out_matrix_multiply_B0_merge_reg_aunroll_x_wireStall <= not (SE_out_matrix_multiply_B0_merge_reg_aunroll_x_consumed1 and SE_out_matrix_multiply_B0_merge_reg_aunroll_x_or0);
    SE_out_matrix_multiply_B0_merge_reg_aunroll_x_backStall <= SE_out_matrix_multiply_B0_merge_reg_aunroll_x_wireStall;
    -- Valid signal propagation
    SE_out_matrix_multiply_B0_merge_reg_aunroll_x_V0 <= SE_out_matrix_multiply_B0_merge_reg_aunroll_x_wireValid and not (SE_out_matrix_multiply_B0_merge_reg_aunroll_x_fromReg0);
    SE_out_matrix_multiply_B0_merge_reg_aunroll_x_V1 <= SE_out_matrix_multiply_B0_merge_reg_aunroll_x_wireValid and not (SE_out_matrix_multiply_B0_merge_reg_aunroll_x_fromReg1);
    -- Computing multiple Valid(s)
    SE_out_matrix_multiply_B0_merge_reg_aunroll_x_wireValid <= matrix_multiply_B0_merge_reg_aunroll_x_out_valid_out;

    -- SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_0(STALLENABLE,49)
    -- Valid signal propagation
    SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_0_V0 <= SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_0_R_v_0;
    -- Stall signal propagation
    SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_0_s_tv_0 <= SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_1_backStall and SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_0_R_v_0;
    -- Backward Enable generation
    SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_0_backEN <= not (SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_0_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_0_v_s_0 <= SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_0_backEN and SE_out_matrix_multiply_B0_merge_reg_aunroll_x_V0;
    -- Backward Stall generation
    SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_0_backStall <= not (SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_0_v_s_0);
    SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_0_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_0_backEN = "0") THEN
                SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_0_R_v_0 <= SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_0_R_v_0 and SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_0_s_tv_0;
            ELSE
                SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_0_R_v_0 <= SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_0_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- bubble_join_matrix_multiply_B0_merge_reg_aunroll_x(BITJOIN,37)
    bubble_join_matrix_multiply_B0_merge_reg_aunroll_x_q <= matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_1 & matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0;

    -- bubble_select_matrix_multiply_B0_merge_reg_aunroll_x(BITSELECT,38)
    bubble_select_matrix_multiply_B0_merge_reg_aunroll_x_b <= STD_LOGIC_VECTOR(bubble_join_matrix_multiply_B0_merge_reg_aunroll_x_q(31 downto 0));
    bubble_select_matrix_multiply_B0_merge_reg_aunroll_x_c <= STD_LOGIC_VECTOR(bubble_join_matrix_multiply_B0_merge_reg_aunroll_x_q(63 downto 32));

    -- redist1_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_1_6_0(REG,26)
    redist1_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_1_6_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist1_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_1_6_0_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_0_backEN = "1") THEN
                redist1_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_1_6_0_q <= STD_LOGIC_VECTOR(bubble_select_matrix_multiply_B0_merge_reg_aunroll_x_c);
            END IF;
        END IF;
    END PROCESS;

    -- redist1_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_1_6_1(REG,27)
    redist1_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_1_6_1_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist1_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_1_6_1_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_1_backEN = "1") THEN
                redist1_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_1_6_1_q <= STD_LOGIC_VECTOR(redist1_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_1_6_0_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_0(REG,20)
    redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_0_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_0_backEN = "1") THEN
                redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_0_q <= STD_LOGIC_VECTOR(bubble_select_matrix_multiply_B0_merge_reg_aunroll_x_b);
            END IF;
        END IF;
    END PROCESS;

    -- redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_1(REG,21)
    redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_1_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_1_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_1_backEN = "1") THEN
                redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_1_q <= STD_LOGIC_VECTOR(redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_0_q);
            END IF;
        END IF;
    END PROCESS;

    -- SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_1(STALLENABLE,50)
    -- Valid signal propagation
    SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_1_V0 <= SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_1_R_v_0;
    -- Stall signal propagation
    SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_1_s_tv_0 <= SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_backStall and SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_1_R_v_0;
    -- Backward Enable generation
    SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_1_backEN <= not (SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_1_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_1_v_s_0 <= SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_1_backEN and SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_0_V0;
    -- Backward Stall generation
    SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_1_backStall <= not (SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_1_v_s_0);
    SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_1_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_1_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_1_backEN = "0") THEN
                SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_1_R_v_0 <= SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_1_R_v_0 and SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_1_s_tv_0;
            ELSE
                SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_1_R_v_0 <= SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_1_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2(STALLREG,77)
    SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_r_valid <= (others => '0');
            SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_r_data0 <= (others => '-');
            SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_r_data1 <= (others => '-');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Valid
            SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_r_valid <= SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_backStall and (SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_r_valid or SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_i_valid);

            IF (SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_r_valid = "0") THEN
                -- Data(s)
                SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_r_data0 <= STD_LOGIC_VECTOR(redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_1_q);
                SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_r_data1 <= STD_LOGIC_VECTOR(redist1_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_1_6_1_q);
            END IF;

        END IF;
    END PROCESS;
    -- Computing multiple Valid(s)
    SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_i_valid <= SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_1_V0;
    -- Stall signal propagation
    SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_backStall <= SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_r_valid or not (SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_i_valid);

    -- Valid
    SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_V <= SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_r_valid WHEN SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_r_valid = "1" ELSE SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_i_valid;

    -- Data0
    SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_D0 <= SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_r_data0 WHEN SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_r_valid = "1" ELSE redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_1_q;
    -- Data1
    SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_D1 <= SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_r_data1 WHEN SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_r_valid = "1" ELSE redist1_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_1_6_1_q;

    -- redist1_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_1_6_2(REG,28)
    redist1_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_1_6_2_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist1_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_1_6_2_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_backEN = "1") THEN
                redist1_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_1_6_2_q <= STD_LOGIC_VECTOR(SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_D1);
            END IF;
        END IF;
    END PROCESS;

    -- redist1_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_1_6_3(REG,29)
    redist1_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_1_6_3_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist1_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_1_6_3_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_3_backEN = "1") THEN
                redist1_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_1_6_3_q <= STD_LOGIC_VECTOR(redist1_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_1_6_2_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2(REG,22)
    redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_backEN = "1") THEN
                redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_q <= STD_LOGIC_VECTOR(SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_D0);
            END IF;
        END IF;
    END PROCESS;

    -- redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_3(REG,23)
    redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_3_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_3_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_3_backEN = "1") THEN
                redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_3_q <= STD_LOGIC_VECTOR(redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_q);
            END IF;
        END IF;
    END PROCESS;

    -- SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_3(STALLENABLE,52)
    -- Valid signal propagation
    SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_3_V0 <= SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_3_R_v_0;
    -- Stall signal propagation
    SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_3_s_tv_0 <= SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_backStall and SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_3_R_v_0;
    -- Backward Enable generation
    SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_3_backEN <= not (SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_3_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_3_v_s_0 <= SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_3_backEN and SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_2_V0;
    -- Backward Stall generation
    SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_3_backStall <= not (SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_3_v_s_0);
    SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_3_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_3_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_3_backEN = "0") THEN
                SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_3_R_v_0 <= SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_3_R_v_0 and SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_3_s_tv_0;
            ELSE
                SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_3_R_v_0 <= SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_3_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4(STALLREG,78)
    SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_r_valid <= (others => '0');
            SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_r_data0 <= (others => '-');
            SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_r_data1 <= (others => '-');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Valid
            SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_r_valid <= SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_backStall and (SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_r_valid or SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_i_valid);

            IF (SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_r_valid = "0") THEN
                -- Data(s)
                SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_r_data0 <= STD_LOGIC_VECTOR(redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_3_q);
                SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_r_data1 <= STD_LOGIC_VECTOR(redist1_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_1_6_3_q);
            END IF;

        END IF;
    END PROCESS;
    -- Computing multiple Valid(s)
    SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_i_valid <= SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_3_V0;
    -- Stall signal propagation
    SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_backStall <= SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_r_valid or not (SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_i_valid);

    -- Valid
    SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_V <= SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_r_valid WHEN SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_r_valid = "1" ELSE SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_i_valid;

    -- Data0
    SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_D0 <= SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_r_data0 WHEN SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_r_valid = "1" ELSE redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_3_q;
    -- Data1
    SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_D1 <= SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_r_data1 WHEN SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_r_valid = "1" ELSE redist1_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_1_6_3_q;

    -- SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4(STALLENABLE,53)
    -- Valid signal propagation
    SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_V0 <= SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_R_v_0;
    -- Stall signal propagation
    SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_s_tv_0 <= SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_5_backStall and SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_R_v_0;
    -- Backward Enable generation
    SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_backEN <= not (SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_v_s_0 <= SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_backEN and SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_V;
    -- Backward Stall generation
    SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_backStall <= not (SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_backEN);
    SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_backEN = "0") THEN
                SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_R_v_0 <= SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_R_v_0 and SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_s_tv_0;
            ELSE
                SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_R_v_0 <= SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_5(STALLENABLE,54)
    -- Valid signal propagation
    SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_5_V0 <= SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_5_R_v_0;
    -- Stall signal propagation
    SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_5_s_tv_0 <= SE_out_i_sfc_c0_entry_matrix_multiply_c0_enter_matrix_multiply_aunroll_x_backStall and SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_5_R_v_0;
    -- Backward Enable generation
    SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_5_backEN <= not (SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_5_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_5_v_s_0 <= SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_5_backEN and SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_V0;
    -- Backward Stall generation
    SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_5_backStall <= not (SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_5_v_s_0);
    SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_5_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_5_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_5_backEN = "0") THEN
                SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_5_R_v_0 <= SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_5_R_v_0 and SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_5_s_tv_0;
            ELSE
                SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_5_R_v_0 <= SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_5_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- i_sfc_c0_entry_matrix_multiply_c0_enter_matrix_multiply_aunroll_x(BLACKBOX,6)@1
    -- in in_i_stall@20000000
    -- out out_c0_exit_0@7
    -- out out_c0_exit_1@7
    -- out out_o_stall@20000000
    -- out out_o_valid@7
    thei_sfc_c0_entry_matrix_multiply_c0_enter_matrix_multiply_aunroll_x : i_sfc_c0_entry_matrix_multiply_c0_enter_matrix_multiply
    PORT MAP (
        in_c0_eni1_0 => GND_q,
        in_c0_eni1_1 => bubble_select_matrix_multiply_B0_merge_reg_aunroll_x_b,
        in_P => in_P,
        in_i_stall => SE_out_i_sfc_c0_entry_matrix_multiply_c0_enter_matrix_multiply_aunroll_x_backStall,
        in_i_valid => SE_out_matrix_multiply_B0_merge_reg_aunroll_x_V1,
        out_c0_exit_1 => i_sfc_c0_entry_matrix_multiply_c0_enter_matrix_multiply_aunroll_x_out_c0_exit_1,
        out_o_stall => i_sfc_c0_entry_matrix_multiply_c0_enter_matrix_multiply_aunroll_x_out_o_stall,
        out_o_valid => i_sfc_c0_entry_matrix_multiply_c0_enter_matrix_multiply_aunroll_x_out_o_valid,
        clock => clock,
        resetn => resetn
    );

    -- SE_out_i_sfc_c0_entry_matrix_multiply_c0_enter_matrix_multiply_aunroll_x(STALLENABLE,44)
    -- Valid signal propagation
    SE_out_i_sfc_c0_entry_matrix_multiply_c0_enter_matrix_multiply_aunroll_x_V0 <= SE_out_i_sfc_c0_entry_matrix_multiply_c0_enter_matrix_multiply_aunroll_x_wireValid;
    -- Backward Stall generation
    SE_out_i_sfc_c0_entry_matrix_multiply_c0_enter_matrix_multiply_aunroll_x_backStall <= in_stall_in or not (SE_out_i_sfc_c0_entry_matrix_multiply_c0_enter_matrix_multiply_aunroll_x_wireValid);
    -- Computing multiple Valid(s)
    SE_out_i_sfc_c0_entry_matrix_multiply_c0_enter_matrix_multiply_aunroll_x_and0 <= i_sfc_c0_entry_matrix_multiply_c0_enter_matrix_multiply_aunroll_x_out_o_valid;
    SE_out_i_sfc_c0_entry_matrix_multiply_c0_enter_matrix_multiply_aunroll_x_wireValid <= SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_5_V0 and SE_out_i_sfc_c0_entry_matrix_multiply_c0_enter_matrix_multiply_aunroll_x_and0;

    -- redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4(REG,24)
    redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_backEN = "1") THEN
                redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_q <= STD_LOGIC_VECTOR(SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_D0);
            END IF;
        END IF;
    END PROCESS;

    -- redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_5(REG,25)
    redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_5_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_5_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_5_backEN = "1") THEN
                redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_5_q <= STD_LOGIC_VECTOR(redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_q);
            END IF;
        END IF;
    END PROCESS;

    -- bubble_join_i_sfc_c0_entry_matrix_multiply_c0_enter_matrix_multiply_aunroll_x(BITJOIN,33)
    bubble_join_i_sfc_c0_entry_matrix_multiply_c0_enter_matrix_multiply_aunroll_x_q <= i_sfc_c0_entry_matrix_multiply_c0_enter_matrix_multiply_aunroll_x_out_c0_exit_1;

    -- bubble_select_i_sfc_c0_entry_matrix_multiply_c0_enter_matrix_multiply_aunroll_x(BITSELECT,34)
    bubble_select_i_sfc_c0_entry_matrix_multiply_c0_enter_matrix_multiply_aunroll_x_b <= STD_LOGIC_VECTOR(bubble_join_i_sfc_c0_entry_matrix_multiply_c0_enter_matrix_multiply_aunroll_x_q(31 downto 0));

    -- redist1_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_1_6_4(REG,30)
    redist1_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_1_6_4_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist1_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_1_6_4_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_backEN = "1") THEN
                redist1_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_1_6_4_q <= STD_LOGIC_VECTOR(SR_SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_4_D1);
            END IF;
        END IF;
    END PROCESS;

    -- redist1_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_1_6_5(REG,31)
    redist1_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_1_6_5_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist1_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_1_6_5_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_5_backEN = "1") THEN
                redist1_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_1_6_5_q <= STD_LOGIC_VECTOR(redist1_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_1_6_4_q);
            END IF;
        END IF;
    END PROCESS;

    -- dupName_0_sync_out_x(GPOUT,5)@7
    out_acl_hw_wg_id <= redist1_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_1_6_5_q;
    out_c0_exe1 <= bubble_select_i_sfc_c0_entry_matrix_multiply_c0_enter_matrix_multiply_aunroll_x_b;
    out_global_id_0 <= redist0_matrix_multiply_B0_merge_reg_aunroll_x_out_data_out_0_6_5_q;
    out_valid_out <= SE_out_i_sfc_c0_entry_matrix_multiply_c0_enter_matrix_multiply_aunroll_x_V0;

    -- sync_out(GPOUT,17)@0
    out_stall_out <= SE_stall_entry_backStall;

END normal;
