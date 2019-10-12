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

-- VHDL created from i_sfc_logic_c1_entry_reluactivation_c1_enter_reluactivation16
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

entity i_sfc_logic_c1_entry_reluactivation_c1_enter_reluactivation16 is
    port (
        in_c1_eni2_0 : in std_logic_vector(0 downto 0);  -- ufix1
        in_c1_eni2_1 : in std_logic_vector(63 downto 0);  -- float64_m52
        in_c1_eni2_2 : in std_logic_vector(0 downto 0);  -- ufix1
        in_i_valid : in std_logic_vector(0 downto 0);  -- ufix1
        out_c1_exi1_0 : out std_logic_vector(0 downto 0);  -- ufix1
        out_c1_exi1_1 : out std_logic_vector(63 downto 0);  -- float64_m52
        out_o_valid : out std_logic_vector(0 downto 0);  -- ufix1
        clock : in std_logic;
        resetn : in std_logic
    );
end i_sfc_logic_c1_entry_reluactivation_c1_enter_reluactivation16;

architecture normal of i_sfc_logic_c1_entry_reluactivation_c1_enter_reluactivation16 is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal c_double_0_000000e_00_q : STD_LOGIC_VECTOR (63 downto 0);
    signal i_acl_2_reluactivation_s : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_2_reluactivation_q : STD_LOGIC_VECTOR (63 downto 0);
    signal i_acl_reluactivation_q : STD_LOGIC_VECTOR (0 downto 0);
    signal cstAllOWE_uid10_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (10 downto 0);
    signal cstZeroWF_uid11_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (51 downto 0);
    signal cstAllZWE_uid12_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (10 downto 0);
    signal exp_x_uid13_i_cmp2_reluactivation_b : STD_LOGIC_VECTOR (10 downto 0);
    signal frac_x_uid14_i_cmp2_reluactivation_b : STD_LOGIC_VECTOR (51 downto 0);
    signal expXIsZero_uid15_i_cmp2_reluactivation_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal expXIsZero_uid15_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expXIsMax_uid16_i_cmp2_reluactivation_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal expXIsMax_uid16_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsNotZero_uid18_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excZ_x_uid19_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excN_x_uid21_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (0 downto 0);
    signal exp_y_uid30_i_cmp2_reluactivation_b : STD_LOGIC_VECTOR (10 downto 0);
    signal frac_y_uid31_i_cmp2_reluactivation_b : STD_LOGIC_VECTOR (51 downto 0);
    signal expXIsZero_uid32_i_cmp2_reluactivation_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal expXIsZero_uid32_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expXIsMax_uid33_i_cmp2_reluactivation_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal expXIsMax_uid33_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsNotZero_uid35_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excZ_y_uid36_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excN_y_uid38_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (0 downto 0);
    signal oneIsNaN_uid44_i_cmp2_reluactivation_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal oneIsNaN_uid44_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expFracX_uid49_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (62 downto 0);
    signal expFracY_uid51_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (62 downto 0);
    signal efxGTefy_uid53_i_cmp2_reluactivation_a : STD_LOGIC_VECTOR (64 downto 0);
    signal efxGTefy_uid53_i_cmp2_reluactivation_b : STD_LOGIC_VECTOR (64 downto 0);
    signal efxGTefy_uid53_i_cmp2_reluactivation_o : STD_LOGIC_VECTOR (64 downto 0);
    signal efxGTefy_uid53_i_cmp2_reluactivation_c : STD_LOGIC_VECTOR (0 downto 0);
    signal efxLTefy_uid54_i_cmp2_reluactivation_a : STD_LOGIC_VECTOR (64 downto 0);
    signal efxLTefy_uid54_i_cmp2_reluactivation_b : STD_LOGIC_VECTOR (64 downto 0);
    signal efxLTefy_uid54_i_cmp2_reluactivation_o : STD_LOGIC_VECTOR (64 downto 0);
    signal efxLTefy_uid54_i_cmp2_reluactivation_c : STD_LOGIC_VECTOR (0 downto 0);
    signal signX_uid58_i_cmp2_reluactivation_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signY_uid59_i_cmp2_reluactivation_b : STD_LOGIC_VECTOR (0 downto 0);
    signal two_uid60_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (1 downto 0);
    signal concSXSY_uid61_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (1 downto 0);
    signal sxLTsy_uid62_i_cmp2_reluactivation_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal sxLTsy_uid62_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (0 downto 0);
    signal xorSigns_uid63_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (0 downto 0);
    signal sxEQsy_uid64_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expFracCompMux_uid65_i_cmp2_reluactivation_s : STD_LOGIC_VECTOR (0 downto 0);
    signal expFracCompMux_uid65_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (0 downto 0);
    signal invExcYZ_uid66_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (0 downto 0);
    signal invExcXZ_uid67_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (0 downto 0);
    signal oneNonZero_uid68_i_cmp2_reluactivation_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal oneNonZero_uid68_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (0 downto 0);
    signal rc2_uid69_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (0 downto 0);
    signal sxEQsyExpFracCompMux_uid70_i_cmp2_reluactivation_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal sxEQsyExpFracCompMux_uid70_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (0 downto 0);
    signal r_uid71_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (0 downto 0);
    signal rPostExc_uid72_i_cmp2_reluactivation_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal rPostExc_uid72_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq0_uid76_fracXIsZero_uid17_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq1_uid79_fracXIsZero_uid17_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq2_uid82_fracXIsZero_uid17_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq3_uid85_fracXIsZero_uid17_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq4_uid88_fracXIsZero_uid17_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq5_uid91_fracXIsZero_uid17_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq6_uid94_fracXIsZero_uid17_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq7_uid97_fracXIsZero_uid17_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq8_uid100_fracXIsZero_uid17_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (0 downto 0);
    signal and_lev0_uid101_fracXIsZero_uid17_i_cmp2_reluactivation_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal and_lev0_uid101_fracXIsZero_uid17_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (0 downto 0);
    signal and_lev0_uid102_fracXIsZero_uid17_i_cmp2_reluactivation_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal and_lev0_uid102_fracXIsZero_uid17_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (0 downto 0);
    signal and_lev1_uid103_fracXIsZero_uid17_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq0_uid106_fracXIsZero_uid34_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq1_uid109_fracXIsZero_uid34_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq2_uid112_fracXIsZero_uid34_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq3_uid115_fracXIsZero_uid34_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq4_uid118_fracXIsZero_uid34_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq5_uid121_fracXIsZero_uid34_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq6_uid124_fracXIsZero_uid34_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq7_uid127_fracXIsZero_uid34_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq8_uid130_fracXIsZero_uid34_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (0 downto 0);
    signal and_lev0_uid131_fracXIsZero_uid34_i_cmp2_reluactivation_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal and_lev0_uid131_fracXIsZero_uid34_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (0 downto 0);
    signal and_lev0_uid132_fracXIsZero_uid34_i_cmp2_reluactivation_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal and_lev0_uid132_fracXIsZero_uid34_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (0 downto 0);
    signal and_lev1_uid133_fracXIsZero_uid34_i_cmp2_reluactivation_q : STD_LOGIC_VECTOR (0 downto 0);
    signal c0_uid75_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_b : STD_LOGIC_VECTOR (5 downto 0);
    signal c0_uid75_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_c : STD_LOGIC_VECTOR (5 downto 0);
    signal c0_uid75_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_d : STD_LOGIC_VECTOR (5 downto 0);
    signal c0_uid75_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_e : STD_LOGIC_VECTOR (5 downto 0);
    signal c0_uid75_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_f : STD_LOGIC_VECTOR (5 downto 0);
    signal c0_uid75_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_g : STD_LOGIC_VECTOR (5 downto 0);
    signal c0_uid75_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_h : STD_LOGIC_VECTOR (5 downto 0);
    signal c0_uid75_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_i : STD_LOGIC_VECTOR (5 downto 0);
    signal c0_uid75_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_j : STD_LOGIC_VECTOR (3 downto 0);
    signal z0_uid74_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_b : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid74_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_c : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid74_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_d : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid74_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_e : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid74_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_f : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid74_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_g : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid74_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_h : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid74_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_i : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid74_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_j : STD_LOGIC_VECTOR (3 downto 0);
    signal z0_uid104_fracXIsZero_uid34_i_cmp2_reluactivation_merged_bit_select_b : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid104_fracXIsZero_uid34_i_cmp2_reluactivation_merged_bit_select_c : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid104_fracXIsZero_uid34_i_cmp2_reluactivation_merged_bit_select_d : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid104_fracXIsZero_uid34_i_cmp2_reluactivation_merged_bit_select_e : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid104_fracXIsZero_uid34_i_cmp2_reluactivation_merged_bit_select_f : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid104_fracXIsZero_uid34_i_cmp2_reluactivation_merged_bit_select_g : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid104_fracXIsZero_uid34_i_cmp2_reluactivation_merged_bit_select_h : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid104_fracXIsZero_uid34_i_cmp2_reluactivation_merged_bit_select_i : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid104_fracXIsZero_uid34_i_cmp2_reluactivation_merged_bit_select_j : STD_LOGIC_VECTOR (3 downto 0);
    signal redist0_sync_in_aunroll_x_in_c1_eni2_1_1_q : STD_LOGIC_VECTOR (63 downto 0);
    signal redist1_sync_in_aunroll_x_in_c1_eni2_1_3_q : STD_LOGIC_VECTOR (63 downto 0);
    signal redist2_sync_in_aunroll_x_in_c1_eni2_2_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist3_sync_in_aunroll_x_in_i_valid_3_q : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- redist3_sync_in_aunroll_x_in_i_valid_3(DELAY,139)
    redist3_sync_in_aunroll_x_in_i_valid_3 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => in_i_valid, xout => redist3_sync_in_aunroll_x_in_i_valid_3_q, clk => clock, aclr => resetn );

    -- redist0_sync_in_aunroll_x_in_c1_eni2_1_1(DELAY,136)
    redist0_sync_in_aunroll_x_in_c1_eni2_1_1 : dspba_delay
    GENERIC MAP ( width => 64, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => in_c1_eni2_1, xout => redist0_sync_in_aunroll_x_in_c1_eni2_1_1_q, clk => clock, aclr => resetn );

    -- redist1_sync_in_aunroll_x_in_c1_eni2_1_3(DELAY,137)
    redist1_sync_in_aunroll_x_in_c1_eni2_1_3 : dspba_delay
    GENERIC MAP ( width => 64, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist0_sync_in_aunroll_x_in_c1_eni2_1_1_q, xout => redist1_sync_in_aunroll_x_in_c1_eni2_1_3_q, clk => clock, aclr => resetn );

    -- c_double_0_000000e_00(FLOATCONSTANT,4)
    c_double_0_000000e_00_q <= "0000000000000000000000000000000000000000000000000000000000000000";

    -- cstZeroWF_uid11_i_cmp2_reluactivation(CONSTANT,10)
    cstZeroWF_uid11_i_cmp2_reluactivation_q <= "0000000000000000000000000000000000000000000000000000";

    -- c0_uid75_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select(BITSELECT,133)
    c0_uid75_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_b <= cstZeroWF_uid11_i_cmp2_reluactivation_q(5 downto 0);
    c0_uid75_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_c <= cstZeroWF_uid11_i_cmp2_reluactivation_q(11 downto 6);
    c0_uid75_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_d <= cstZeroWF_uid11_i_cmp2_reluactivation_q(17 downto 12);
    c0_uid75_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_e <= cstZeroWF_uid11_i_cmp2_reluactivation_q(23 downto 18);
    c0_uid75_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_f <= cstZeroWF_uid11_i_cmp2_reluactivation_q(29 downto 24);
    c0_uid75_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_g <= cstZeroWF_uid11_i_cmp2_reluactivation_q(35 downto 30);
    c0_uid75_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_h <= cstZeroWF_uid11_i_cmp2_reluactivation_q(41 downto 36);
    c0_uid75_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_i <= cstZeroWF_uid11_i_cmp2_reluactivation_q(47 downto 42);
    c0_uid75_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_j <= cstZeroWF_uid11_i_cmp2_reluactivation_q(51 downto 48);

    -- frac_y_uid31_i_cmp2_reluactivation(BITSELECT,30)@142
    frac_y_uid31_i_cmp2_reluactivation_b <= in_c1_eni2_1(51 downto 0);

    -- z0_uid104_fracXIsZero_uid34_i_cmp2_reluactivation_merged_bit_select(BITSELECT,135)@142
    z0_uid104_fracXIsZero_uid34_i_cmp2_reluactivation_merged_bit_select_b <= frac_y_uid31_i_cmp2_reluactivation_b(5 downto 0);
    z0_uid104_fracXIsZero_uid34_i_cmp2_reluactivation_merged_bit_select_c <= frac_y_uid31_i_cmp2_reluactivation_b(11 downto 6);
    z0_uid104_fracXIsZero_uid34_i_cmp2_reluactivation_merged_bit_select_d <= frac_y_uid31_i_cmp2_reluactivation_b(17 downto 12);
    z0_uid104_fracXIsZero_uid34_i_cmp2_reluactivation_merged_bit_select_e <= frac_y_uid31_i_cmp2_reluactivation_b(23 downto 18);
    z0_uid104_fracXIsZero_uid34_i_cmp2_reluactivation_merged_bit_select_f <= frac_y_uid31_i_cmp2_reluactivation_b(29 downto 24);
    z0_uid104_fracXIsZero_uid34_i_cmp2_reluactivation_merged_bit_select_g <= frac_y_uid31_i_cmp2_reluactivation_b(35 downto 30);
    z0_uid104_fracXIsZero_uid34_i_cmp2_reluactivation_merged_bit_select_h <= frac_y_uid31_i_cmp2_reluactivation_b(41 downto 36);
    z0_uid104_fracXIsZero_uid34_i_cmp2_reluactivation_merged_bit_select_i <= frac_y_uid31_i_cmp2_reluactivation_b(47 downto 42);
    z0_uid104_fracXIsZero_uid34_i_cmp2_reluactivation_merged_bit_select_j <= frac_y_uid31_i_cmp2_reluactivation_b(51 downto 48);

    -- eq8_uid130_fracXIsZero_uid34_i_cmp2_reluactivation(LOGICAL,129)@142
    eq8_uid130_fracXIsZero_uid34_i_cmp2_reluactivation_q <= "1" WHEN z0_uid104_fracXIsZero_uid34_i_cmp2_reluactivation_merged_bit_select_j = c0_uid75_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_j ELSE "0";

    -- eq7_uid127_fracXIsZero_uid34_i_cmp2_reluactivation(LOGICAL,126)@142
    eq7_uid127_fracXIsZero_uid34_i_cmp2_reluactivation_q <= "1" WHEN z0_uid104_fracXIsZero_uid34_i_cmp2_reluactivation_merged_bit_select_i = c0_uid75_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_i ELSE "0";

    -- eq6_uid124_fracXIsZero_uid34_i_cmp2_reluactivation(LOGICAL,123)@142
    eq6_uid124_fracXIsZero_uid34_i_cmp2_reluactivation_q <= "1" WHEN z0_uid104_fracXIsZero_uid34_i_cmp2_reluactivation_merged_bit_select_h = c0_uid75_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_h ELSE "0";

    -- and_lev0_uid132_fracXIsZero_uid34_i_cmp2_reluactivation(LOGICAL,131)@142 + 1
    and_lev0_uid132_fracXIsZero_uid34_i_cmp2_reluactivation_qi <= eq6_uid124_fracXIsZero_uid34_i_cmp2_reluactivation_q and eq7_uid127_fracXIsZero_uid34_i_cmp2_reluactivation_q and eq8_uid130_fracXIsZero_uid34_i_cmp2_reluactivation_q;
    and_lev0_uid132_fracXIsZero_uid34_i_cmp2_reluactivation_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => and_lev0_uid132_fracXIsZero_uid34_i_cmp2_reluactivation_qi, xout => and_lev0_uid132_fracXIsZero_uid34_i_cmp2_reluactivation_q, clk => clock, aclr => resetn );

    -- eq5_uid121_fracXIsZero_uid34_i_cmp2_reluactivation(LOGICAL,120)@142
    eq5_uid121_fracXIsZero_uid34_i_cmp2_reluactivation_q <= "1" WHEN z0_uid104_fracXIsZero_uid34_i_cmp2_reluactivation_merged_bit_select_g = c0_uid75_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_g ELSE "0";

    -- eq4_uid118_fracXIsZero_uid34_i_cmp2_reluactivation(LOGICAL,117)@142
    eq4_uid118_fracXIsZero_uid34_i_cmp2_reluactivation_q <= "1" WHEN z0_uid104_fracXIsZero_uid34_i_cmp2_reluactivation_merged_bit_select_f = c0_uid75_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_f ELSE "0";

    -- eq3_uid115_fracXIsZero_uid34_i_cmp2_reluactivation(LOGICAL,114)@142
    eq3_uid115_fracXIsZero_uid34_i_cmp2_reluactivation_q <= "1" WHEN z0_uid104_fracXIsZero_uid34_i_cmp2_reluactivation_merged_bit_select_e = c0_uid75_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_e ELSE "0";

    -- eq2_uid112_fracXIsZero_uid34_i_cmp2_reluactivation(LOGICAL,111)@142
    eq2_uid112_fracXIsZero_uid34_i_cmp2_reluactivation_q <= "1" WHEN z0_uid104_fracXIsZero_uid34_i_cmp2_reluactivation_merged_bit_select_d = c0_uid75_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_d ELSE "0";

    -- eq1_uid109_fracXIsZero_uid34_i_cmp2_reluactivation(LOGICAL,108)@142
    eq1_uid109_fracXIsZero_uid34_i_cmp2_reluactivation_q <= "1" WHEN z0_uid104_fracXIsZero_uid34_i_cmp2_reluactivation_merged_bit_select_c = c0_uid75_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_c ELSE "0";

    -- eq0_uid106_fracXIsZero_uid34_i_cmp2_reluactivation(LOGICAL,105)@142
    eq0_uid106_fracXIsZero_uid34_i_cmp2_reluactivation_q <= "1" WHEN z0_uid104_fracXIsZero_uid34_i_cmp2_reluactivation_merged_bit_select_b = c0_uid75_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_b ELSE "0";

    -- and_lev0_uid131_fracXIsZero_uid34_i_cmp2_reluactivation(LOGICAL,130)@142 + 1
    and_lev0_uid131_fracXIsZero_uid34_i_cmp2_reluactivation_qi <= eq0_uid106_fracXIsZero_uid34_i_cmp2_reluactivation_q and eq1_uid109_fracXIsZero_uid34_i_cmp2_reluactivation_q and eq2_uid112_fracXIsZero_uid34_i_cmp2_reluactivation_q and eq3_uid115_fracXIsZero_uid34_i_cmp2_reluactivation_q and eq4_uid118_fracXIsZero_uid34_i_cmp2_reluactivation_q and eq5_uid121_fracXIsZero_uid34_i_cmp2_reluactivation_q;
    and_lev0_uid131_fracXIsZero_uid34_i_cmp2_reluactivation_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => and_lev0_uid131_fracXIsZero_uid34_i_cmp2_reluactivation_qi, xout => and_lev0_uid131_fracXIsZero_uid34_i_cmp2_reluactivation_q, clk => clock, aclr => resetn );

    -- and_lev1_uid133_fracXIsZero_uid34_i_cmp2_reluactivation(LOGICAL,132)@143
    and_lev1_uid133_fracXIsZero_uid34_i_cmp2_reluactivation_q <= and_lev0_uid131_fracXIsZero_uid34_i_cmp2_reluactivation_q and and_lev0_uid132_fracXIsZero_uid34_i_cmp2_reluactivation_q;

    -- fracXIsNotZero_uid35_i_cmp2_reluactivation(LOGICAL,34)@143
    fracXIsNotZero_uid35_i_cmp2_reluactivation_q <= not (and_lev1_uid133_fracXIsZero_uid34_i_cmp2_reluactivation_q);

    -- cstAllOWE_uid10_i_cmp2_reluactivation(CONSTANT,9)
    cstAllOWE_uid10_i_cmp2_reluactivation_q <= "11111111111";

    -- exp_y_uid30_i_cmp2_reluactivation(BITSELECT,29)@142
    exp_y_uid30_i_cmp2_reluactivation_b <= in_c1_eni2_1(62 downto 52);

    -- expXIsMax_uid33_i_cmp2_reluactivation(LOGICAL,32)@142 + 1
    expXIsMax_uid33_i_cmp2_reluactivation_qi <= "1" WHEN exp_y_uid30_i_cmp2_reluactivation_b = cstAllOWE_uid10_i_cmp2_reluactivation_q ELSE "0";
    expXIsMax_uid33_i_cmp2_reluactivation_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => expXIsMax_uid33_i_cmp2_reluactivation_qi, xout => expXIsMax_uid33_i_cmp2_reluactivation_q, clk => clock, aclr => resetn );

    -- excN_y_uid38_i_cmp2_reluactivation(LOGICAL,37)@143
    excN_y_uid38_i_cmp2_reluactivation_q <= expXIsMax_uid33_i_cmp2_reluactivation_q and fracXIsNotZero_uid35_i_cmp2_reluactivation_q;

    -- frac_x_uid14_i_cmp2_reluactivation(BITSELECT,13)@142
    frac_x_uid14_i_cmp2_reluactivation_b <= c_double_0_000000e_00_q(51 downto 0);

    -- z0_uid74_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select(BITSELECT,134)@142
    z0_uid74_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_b <= frac_x_uid14_i_cmp2_reluactivation_b(5 downto 0);
    z0_uid74_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_c <= frac_x_uid14_i_cmp2_reluactivation_b(11 downto 6);
    z0_uid74_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_d <= frac_x_uid14_i_cmp2_reluactivation_b(17 downto 12);
    z0_uid74_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_e <= frac_x_uid14_i_cmp2_reluactivation_b(23 downto 18);
    z0_uid74_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_f <= frac_x_uid14_i_cmp2_reluactivation_b(29 downto 24);
    z0_uid74_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_g <= frac_x_uid14_i_cmp2_reluactivation_b(35 downto 30);
    z0_uid74_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_h <= frac_x_uid14_i_cmp2_reluactivation_b(41 downto 36);
    z0_uid74_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_i <= frac_x_uid14_i_cmp2_reluactivation_b(47 downto 42);
    z0_uid74_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_j <= frac_x_uid14_i_cmp2_reluactivation_b(51 downto 48);

    -- eq8_uid100_fracXIsZero_uid17_i_cmp2_reluactivation(LOGICAL,99)@142
    eq8_uid100_fracXIsZero_uid17_i_cmp2_reluactivation_q <= "1" WHEN z0_uid74_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_j = c0_uid75_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_j ELSE "0";

    -- eq7_uid97_fracXIsZero_uid17_i_cmp2_reluactivation(LOGICAL,96)@142
    eq7_uid97_fracXIsZero_uid17_i_cmp2_reluactivation_q <= "1" WHEN z0_uid74_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_i = c0_uid75_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_i ELSE "0";

    -- eq6_uid94_fracXIsZero_uid17_i_cmp2_reluactivation(LOGICAL,93)@142
    eq6_uid94_fracXIsZero_uid17_i_cmp2_reluactivation_q <= "1" WHEN z0_uid74_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_h = c0_uid75_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_h ELSE "0";

    -- and_lev0_uid102_fracXIsZero_uid17_i_cmp2_reluactivation(LOGICAL,101)@142 + 1
    and_lev0_uid102_fracXIsZero_uid17_i_cmp2_reluactivation_qi <= eq6_uid94_fracXIsZero_uid17_i_cmp2_reluactivation_q and eq7_uid97_fracXIsZero_uid17_i_cmp2_reluactivation_q and eq8_uid100_fracXIsZero_uid17_i_cmp2_reluactivation_q;
    and_lev0_uid102_fracXIsZero_uid17_i_cmp2_reluactivation_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => and_lev0_uid102_fracXIsZero_uid17_i_cmp2_reluactivation_qi, xout => and_lev0_uid102_fracXIsZero_uid17_i_cmp2_reluactivation_q, clk => clock, aclr => resetn );

    -- eq5_uid91_fracXIsZero_uid17_i_cmp2_reluactivation(LOGICAL,90)@142
    eq5_uid91_fracXIsZero_uid17_i_cmp2_reluactivation_q <= "1" WHEN z0_uid74_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_g = c0_uid75_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_g ELSE "0";

    -- eq4_uid88_fracXIsZero_uid17_i_cmp2_reluactivation(LOGICAL,87)@142
    eq4_uid88_fracXIsZero_uid17_i_cmp2_reluactivation_q <= "1" WHEN z0_uid74_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_f = c0_uid75_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_f ELSE "0";

    -- eq3_uid85_fracXIsZero_uid17_i_cmp2_reluactivation(LOGICAL,84)@142
    eq3_uid85_fracXIsZero_uid17_i_cmp2_reluactivation_q <= "1" WHEN z0_uid74_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_e = c0_uid75_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_e ELSE "0";

    -- eq2_uid82_fracXIsZero_uid17_i_cmp2_reluactivation(LOGICAL,81)@142
    eq2_uid82_fracXIsZero_uid17_i_cmp2_reluactivation_q <= "1" WHEN z0_uid74_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_d = c0_uid75_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_d ELSE "0";

    -- eq1_uid79_fracXIsZero_uid17_i_cmp2_reluactivation(LOGICAL,78)@142
    eq1_uid79_fracXIsZero_uid17_i_cmp2_reluactivation_q <= "1" WHEN z0_uid74_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_c = c0_uid75_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_c ELSE "0";

    -- eq0_uid76_fracXIsZero_uid17_i_cmp2_reluactivation(LOGICAL,75)@142
    eq0_uid76_fracXIsZero_uid17_i_cmp2_reluactivation_q <= "1" WHEN z0_uid74_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_b = c0_uid75_fracXIsZero_uid17_i_cmp2_reluactivation_merged_bit_select_b ELSE "0";

    -- and_lev0_uid101_fracXIsZero_uid17_i_cmp2_reluactivation(LOGICAL,100)@142 + 1
    and_lev0_uid101_fracXIsZero_uid17_i_cmp2_reluactivation_qi <= eq0_uid76_fracXIsZero_uid17_i_cmp2_reluactivation_q and eq1_uid79_fracXIsZero_uid17_i_cmp2_reluactivation_q and eq2_uid82_fracXIsZero_uid17_i_cmp2_reluactivation_q and eq3_uid85_fracXIsZero_uid17_i_cmp2_reluactivation_q and eq4_uid88_fracXIsZero_uid17_i_cmp2_reluactivation_q and eq5_uid91_fracXIsZero_uid17_i_cmp2_reluactivation_q;
    and_lev0_uid101_fracXIsZero_uid17_i_cmp2_reluactivation_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => and_lev0_uid101_fracXIsZero_uid17_i_cmp2_reluactivation_qi, xout => and_lev0_uid101_fracXIsZero_uid17_i_cmp2_reluactivation_q, clk => clock, aclr => resetn );

    -- and_lev1_uid103_fracXIsZero_uid17_i_cmp2_reluactivation(LOGICAL,102)@143
    and_lev1_uid103_fracXIsZero_uid17_i_cmp2_reluactivation_q <= and_lev0_uid101_fracXIsZero_uid17_i_cmp2_reluactivation_q and and_lev0_uid102_fracXIsZero_uid17_i_cmp2_reluactivation_q;

    -- fracXIsNotZero_uid18_i_cmp2_reluactivation(LOGICAL,17)@143
    fracXIsNotZero_uid18_i_cmp2_reluactivation_q <= not (and_lev1_uid103_fracXIsZero_uid17_i_cmp2_reluactivation_q);

    -- exp_x_uid13_i_cmp2_reluactivation(BITSELECT,12)@142
    exp_x_uid13_i_cmp2_reluactivation_b <= c_double_0_000000e_00_q(62 downto 52);

    -- expXIsMax_uid16_i_cmp2_reluactivation(LOGICAL,15)@142 + 1
    expXIsMax_uid16_i_cmp2_reluactivation_qi <= "1" WHEN exp_x_uid13_i_cmp2_reluactivation_b = cstAllOWE_uid10_i_cmp2_reluactivation_q ELSE "0";
    expXIsMax_uid16_i_cmp2_reluactivation_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => expXIsMax_uid16_i_cmp2_reluactivation_qi, xout => expXIsMax_uid16_i_cmp2_reluactivation_q, clk => clock, aclr => resetn );

    -- excN_x_uid21_i_cmp2_reluactivation(LOGICAL,20)@143
    excN_x_uid21_i_cmp2_reluactivation_q <= expXIsMax_uid16_i_cmp2_reluactivation_q and fracXIsNotZero_uid18_i_cmp2_reluactivation_q;

    -- oneIsNaN_uid44_i_cmp2_reluactivation(LOGICAL,43)@143 + 1
    oneIsNaN_uid44_i_cmp2_reluactivation_qi <= excN_x_uid21_i_cmp2_reluactivation_q or excN_y_uid38_i_cmp2_reluactivation_q;
    oneIsNaN_uid44_i_cmp2_reluactivation_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => oneIsNaN_uid44_i_cmp2_reluactivation_qi, xout => oneIsNaN_uid44_i_cmp2_reluactivation_q, clk => clock, aclr => resetn );

    -- cstAllZWE_uid12_i_cmp2_reluactivation(CONSTANT,11)
    cstAllZWE_uid12_i_cmp2_reluactivation_q <= "00000000000";

    -- expXIsZero_uid32_i_cmp2_reluactivation(LOGICAL,31)@142 + 1
    expXIsZero_uid32_i_cmp2_reluactivation_qi <= "1" WHEN exp_y_uid30_i_cmp2_reluactivation_b = cstAllZWE_uid12_i_cmp2_reluactivation_q ELSE "0";
    expXIsZero_uid32_i_cmp2_reluactivation_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => expXIsZero_uid32_i_cmp2_reluactivation_qi, xout => expXIsZero_uid32_i_cmp2_reluactivation_q, clk => clock, aclr => resetn );

    -- excZ_y_uid36_i_cmp2_reluactivation(LOGICAL,35)@143
    excZ_y_uid36_i_cmp2_reluactivation_q <= expXIsZero_uid32_i_cmp2_reluactivation_q and and_lev1_uid133_fracXIsZero_uid34_i_cmp2_reluactivation_q;

    -- invExcYZ_uid66_i_cmp2_reluactivation(LOGICAL,65)@143
    invExcYZ_uid66_i_cmp2_reluactivation_q <= not (excZ_y_uid36_i_cmp2_reluactivation_q);

    -- expXIsZero_uid15_i_cmp2_reluactivation(LOGICAL,14)@142 + 1
    expXIsZero_uid15_i_cmp2_reluactivation_qi <= "1" WHEN exp_x_uid13_i_cmp2_reluactivation_b = cstAllZWE_uid12_i_cmp2_reluactivation_q ELSE "0";
    expXIsZero_uid15_i_cmp2_reluactivation_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => expXIsZero_uid15_i_cmp2_reluactivation_qi, xout => expXIsZero_uid15_i_cmp2_reluactivation_q, clk => clock, aclr => resetn );

    -- excZ_x_uid19_i_cmp2_reluactivation(LOGICAL,18)@143
    excZ_x_uid19_i_cmp2_reluactivation_q <= expXIsZero_uid15_i_cmp2_reluactivation_q and and_lev1_uid103_fracXIsZero_uid17_i_cmp2_reluactivation_q;

    -- invExcXZ_uid67_i_cmp2_reluactivation(LOGICAL,66)@143
    invExcXZ_uid67_i_cmp2_reluactivation_q <= not (excZ_x_uid19_i_cmp2_reluactivation_q);

    -- oneNonZero_uid68_i_cmp2_reluactivation(LOGICAL,67)@143 + 1
    oneNonZero_uid68_i_cmp2_reluactivation_qi <= invExcXZ_uid67_i_cmp2_reluactivation_q or invExcYZ_uid66_i_cmp2_reluactivation_q;
    oneNonZero_uid68_i_cmp2_reluactivation_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => oneNonZero_uid68_i_cmp2_reluactivation_qi, xout => oneNonZero_uid68_i_cmp2_reluactivation_q, clk => clock, aclr => resetn );

    -- two_uid60_i_cmp2_reluactivation(CONSTANT,59)
    two_uid60_i_cmp2_reluactivation_q <= "10";

    -- signX_uid58_i_cmp2_reluactivation(BITSELECT,57)@143
    signX_uid58_i_cmp2_reluactivation_b <= STD_LOGIC_VECTOR(c_double_0_000000e_00_q(63 downto 63));

    -- signY_uid59_i_cmp2_reluactivation(BITSELECT,58)@143
    signY_uid59_i_cmp2_reluactivation_b <= STD_LOGIC_VECTOR(redist0_sync_in_aunroll_x_in_c1_eni2_1_1_q(63 downto 63));

    -- concSXSY_uid61_i_cmp2_reluactivation(BITJOIN,60)@143
    concSXSY_uid61_i_cmp2_reluactivation_q <= signX_uid58_i_cmp2_reluactivation_b & signY_uid59_i_cmp2_reluactivation_b;

    -- sxLTsy_uid62_i_cmp2_reluactivation(LOGICAL,61)@143 + 1
    sxLTsy_uid62_i_cmp2_reluactivation_qi <= "1" WHEN concSXSY_uid61_i_cmp2_reluactivation_q = two_uid60_i_cmp2_reluactivation_q ELSE "0";
    sxLTsy_uid62_i_cmp2_reluactivation_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => sxLTsy_uid62_i_cmp2_reluactivation_qi, xout => sxLTsy_uid62_i_cmp2_reluactivation_q, clk => clock, aclr => resetn );

    -- rc2_uid69_i_cmp2_reluactivation(LOGICAL,68)@144
    rc2_uid69_i_cmp2_reluactivation_q <= sxLTsy_uid62_i_cmp2_reluactivation_q and oneNonZero_uid68_i_cmp2_reluactivation_q;

    -- expFracX_uid49_i_cmp2_reluactivation(BITJOIN,48)@142
    expFracX_uid49_i_cmp2_reluactivation_q <= exp_x_uid13_i_cmp2_reluactivation_b & frac_x_uid14_i_cmp2_reluactivation_b;

    -- expFracY_uid51_i_cmp2_reluactivation(BITJOIN,50)@142
    expFracY_uid51_i_cmp2_reluactivation_q <= exp_y_uid30_i_cmp2_reluactivation_b & frac_y_uid31_i_cmp2_reluactivation_b;

    -- efxGTefy_uid53_i_cmp2_reluactivation(COMPARE,52)@142 + 1
    efxGTefy_uid53_i_cmp2_reluactivation_a <= STD_LOGIC_VECTOR("00" & expFracY_uid51_i_cmp2_reluactivation_q);
    efxGTefy_uid53_i_cmp2_reluactivation_b <= STD_LOGIC_VECTOR("00" & expFracX_uid49_i_cmp2_reluactivation_q);
    efxGTefy_uid53_i_cmp2_reluactivation_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            efxGTefy_uid53_i_cmp2_reluactivation_o <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            efxGTefy_uid53_i_cmp2_reluactivation_o <= STD_LOGIC_VECTOR(UNSIGNED(efxGTefy_uid53_i_cmp2_reluactivation_a) - UNSIGNED(efxGTefy_uid53_i_cmp2_reluactivation_b));
        END IF;
    END PROCESS;
    efxGTefy_uid53_i_cmp2_reluactivation_c(0) <= efxGTefy_uid53_i_cmp2_reluactivation_o(64);

    -- efxLTefy_uid54_i_cmp2_reluactivation(COMPARE,53)@142 + 1
    efxLTefy_uid54_i_cmp2_reluactivation_a <= STD_LOGIC_VECTOR("00" & expFracX_uid49_i_cmp2_reluactivation_q);
    efxLTefy_uid54_i_cmp2_reluactivation_b <= STD_LOGIC_VECTOR("00" & expFracY_uid51_i_cmp2_reluactivation_q);
    efxLTefy_uid54_i_cmp2_reluactivation_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            efxLTefy_uid54_i_cmp2_reluactivation_o <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            efxLTefy_uid54_i_cmp2_reluactivation_o <= STD_LOGIC_VECTOR(UNSIGNED(efxLTefy_uid54_i_cmp2_reluactivation_a) - UNSIGNED(efxLTefy_uid54_i_cmp2_reluactivation_b));
        END IF;
    END PROCESS;
    efxLTefy_uid54_i_cmp2_reluactivation_c(0) <= efxLTefy_uid54_i_cmp2_reluactivation_o(64);

    -- expFracCompMux_uid65_i_cmp2_reluactivation(MUX,64)@143
    expFracCompMux_uid65_i_cmp2_reluactivation_s <= signX_uid58_i_cmp2_reluactivation_b;
    expFracCompMux_uid65_i_cmp2_reluactivation_combproc: PROCESS (expFracCompMux_uid65_i_cmp2_reluactivation_s, efxLTefy_uid54_i_cmp2_reluactivation_c, efxGTefy_uid53_i_cmp2_reluactivation_c)
    BEGIN
        CASE (expFracCompMux_uid65_i_cmp2_reluactivation_s) IS
            WHEN "0" => expFracCompMux_uid65_i_cmp2_reluactivation_q <= efxLTefy_uid54_i_cmp2_reluactivation_c;
            WHEN "1" => expFracCompMux_uid65_i_cmp2_reluactivation_q <= efxGTefy_uid53_i_cmp2_reluactivation_c;
            WHEN OTHERS => expFracCompMux_uid65_i_cmp2_reluactivation_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- xorSigns_uid63_i_cmp2_reluactivation(LOGICAL,62)@143
    xorSigns_uid63_i_cmp2_reluactivation_q <= signX_uid58_i_cmp2_reluactivation_b xor signY_uid59_i_cmp2_reluactivation_b;

    -- sxEQsy_uid64_i_cmp2_reluactivation(LOGICAL,63)@143
    sxEQsy_uid64_i_cmp2_reluactivation_q <= not (xorSigns_uid63_i_cmp2_reluactivation_q);

    -- sxEQsyExpFracCompMux_uid70_i_cmp2_reluactivation(LOGICAL,69)@143 + 1
    sxEQsyExpFracCompMux_uid70_i_cmp2_reluactivation_qi <= sxEQsy_uid64_i_cmp2_reluactivation_q and expFracCompMux_uid65_i_cmp2_reluactivation_q;
    sxEQsyExpFracCompMux_uid70_i_cmp2_reluactivation_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => sxEQsyExpFracCompMux_uid70_i_cmp2_reluactivation_qi, xout => sxEQsyExpFracCompMux_uid70_i_cmp2_reluactivation_q, clk => clock, aclr => resetn );

    -- r_uid71_i_cmp2_reluactivation(LOGICAL,70)@144
    r_uid71_i_cmp2_reluactivation_q <= sxEQsyExpFracCompMux_uid70_i_cmp2_reluactivation_q or rc2_uid69_i_cmp2_reluactivation_q;

    -- rPostExc_uid72_i_cmp2_reluactivation(LOGICAL,71)@144 + 1
    rPostExc_uid72_i_cmp2_reluactivation_qi <= r_uid71_i_cmp2_reluactivation_q or oneIsNaN_uid44_i_cmp2_reluactivation_q;
    rPostExc_uid72_i_cmp2_reluactivation_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => rPostExc_uid72_i_cmp2_reluactivation_qi, xout => rPostExc_uid72_i_cmp2_reluactivation_q, clk => clock, aclr => resetn );

    -- redist2_sync_in_aunroll_x_in_c1_eni2_2_3(DELAY,138)
    redist2_sync_in_aunroll_x_in_c1_eni2_2_3 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => in_c1_eni2_2, xout => redist2_sync_in_aunroll_x_in_c1_eni2_2_3_q, clk => clock, aclr => resetn );

    -- i_acl_reluactivation(LOGICAL,7)@145
    i_acl_reluactivation_q <= redist2_sync_in_aunroll_x_in_c1_eni2_2_3_q and rPostExc_uid72_i_cmp2_reluactivation_q;

    -- i_acl_2_reluactivation(MUX,6)@145
    i_acl_2_reluactivation_s <= i_acl_reluactivation_q;
    i_acl_2_reluactivation_combproc: PROCESS (i_acl_2_reluactivation_s, c_double_0_000000e_00_q, redist1_sync_in_aunroll_x_in_c1_eni2_1_3_q)
    BEGIN
        CASE (i_acl_2_reluactivation_s) IS
            WHEN "0" => i_acl_2_reluactivation_q <= c_double_0_000000e_00_q;
            WHEN "1" => i_acl_2_reluactivation_q <= redist1_sync_in_aunroll_x_in_c1_eni2_1_3_q;
            WHEN OTHERS => i_acl_2_reluactivation_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- sync_out_aunroll_x(GPOUT,3)@145
    out_c1_exi1_0 <= GND_q;
    out_c1_exi1_1 <= i_acl_2_reluactivation_q;
    out_o_valid <= redist3_sync_in_aunroll_x_in_i_valid_3_q;

END normal;
