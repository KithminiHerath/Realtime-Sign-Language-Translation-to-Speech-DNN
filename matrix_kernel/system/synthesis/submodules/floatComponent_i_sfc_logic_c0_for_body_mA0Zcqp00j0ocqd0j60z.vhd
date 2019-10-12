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

-- VHDL created from floatComponent_i_sfc_logic_c0_for_body_matrix_multiply_c0_enter6_matrix_multiplyA0Z0j0ucqp00j0ocqd0j60z
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

entity floatComponent_i_sfc_logic_c0_for_body_matrix_multiply_c0_enter6_matrix_multiplyA0Z0j0ucqp00j0ocqd0j60z is
    port (
        in_0 : in std_logic_vector(63 downto 0);  -- float64_m52
        in_1 : in std_logic_vector(63 downto 0);  -- float64_m52
        out_primWireOut : out std_logic_vector(63 downto 0);  -- float64_m52
        clock : in std_logic;
        resetn : in std_logic
    );
end floatComponent_i_sfc_logic_c0_for_body_matrix_multiply_c0_enter6_matrix_multiplyA0Z0j0ucqp00j0ocqd0j60z;

architecture normal of floatComponent_i_sfc_logic_c0_for_body_matrix_multiply_c0_enter6_matrix_multiplyA0Z0j0ucqp00j0ocqd0j60z is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expFracX_uid7_block_rsrvd_fix_b : STD_LOGIC_VECTOR (62 downto 0);
    signal expFracY_uid8_block_rsrvd_fix_b : STD_LOGIC_VECTOR (62 downto 0);
    signal xGTEy_uid9_block_rsrvd_fix_a : STD_LOGIC_VECTOR (64 downto 0);
    signal xGTEy_uid9_block_rsrvd_fix_b : STD_LOGIC_VECTOR (64 downto 0);
    signal xGTEy_uid9_block_rsrvd_fix_o : STD_LOGIC_VECTOR (64 downto 0);
    signal xGTEy_uid9_block_rsrvd_fix_n : STD_LOGIC_VECTOR (0 downto 0);
    signal sigY_uid10_block_rsrvd_fix_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fracY_uid11_block_rsrvd_fix_b : STD_LOGIC_VECTOR (51 downto 0);
    signal expY_uid12_block_rsrvd_fix_b : STD_LOGIC_VECTOR (10 downto 0);
    signal ypn_uid13_block_rsrvd_fix_q : STD_LOGIC_VECTOR (63 downto 0);
    signal aSig_uid17_block_rsrvd_fix_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aSig_uid17_block_rsrvd_fix_q : STD_LOGIC_VECTOR (63 downto 0);
    signal bSig_uid18_block_rsrvd_fix_s : STD_LOGIC_VECTOR (0 downto 0);
    signal bSig_uid18_block_rsrvd_fix_q : STD_LOGIC_VECTOR (63 downto 0);
    signal cstAllOWE_uid19_block_rsrvd_fix_q : STD_LOGIC_VECTOR (10 downto 0);
    signal cstZeroWF_uid20_block_rsrvd_fix_q : STD_LOGIC_VECTOR (51 downto 0);
    signal cstAllZWE_uid21_block_rsrvd_fix_q : STD_LOGIC_VECTOR (10 downto 0);
    signal exp_aSig_uid22_block_rsrvd_fix_in : STD_LOGIC_VECTOR (62 downto 0);
    signal exp_aSig_uid22_block_rsrvd_fix_b : STD_LOGIC_VECTOR (10 downto 0);
    signal frac_aSig_uid23_block_rsrvd_fix_in : STD_LOGIC_VECTOR (51 downto 0);
    signal frac_aSig_uid23_block_rsrvd_fix_b : STD_LOGIC_VECTOR (51 downto 0);
    signal expXIsZero_uid24_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal expXIsZero_uid24_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expXIsMax_uid25_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsNotZero_uid27_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excZ_aSig_uid28_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excZ_aSig_uid28_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excI_aSig_uid29_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excI_aSig_uid29_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excN_aSig_uid30_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excN_aSig_uid30_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal invExpXIsMax_uid31_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal InvExpXIsZero_uid32_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excR_aSig_uid33_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excR_aSig_uid33_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excS_aSig_uid34_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal exp_bSig_uid39_block_rsrvd_fix_in : STD_LOGIC_VECTOR (62 downto 0);
    signal exp_bSig_uid39_block_rsrvd_fix_b : STD_LOGIC_VECTOR (10 downto 0);
    signal frac_bSig_uid40_block_rsrvd_fix_in : STD_LOGIC_VECTOR (51 downto 0);
    signal frac_bSig_uid40_block_rsrvd_fix_b : STD_LOGIC_VECTOR (51 downto 0);
    signal expXIsZero_uid41_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal expXIsZero_uid41_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expXIsMax_uid42_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal expXIsMax_uid42_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsNotZero_uid44_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excZ_bSig_uid45_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excI_bSig_uid46_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excI_bSig_uid46_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excN_bSig_uid47_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excN_bSig_uid47_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal invExpXIsMax_uid48_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal InvExpXIsZero_uid49_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excR_bSig_uid50_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excR_bSig_uid50_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excS_bSig_uid51_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal sigA_uid57_block_rsrvd_fix_b : STD_LOGIC_VECTOR (0 downto 0);
    signal sigB_uid58_block_rsrvd_fix_b : STD_LOGIC_VECTOR (0 downto 0);
    signal effSub_uid59_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracBz_uid63_block_rsrvd_fix_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fracBz_uid63_block_rsrvd_fix_q : STD_LOGIC_VECTOR (51 downto 0);
    signal oFracA_uid65_block_rsrvd_fix_q : STD_LOGIC_VECTOR (52 downto 0);
    signal oFracB_uid67_block_rsrvd_fix_q : STD_LOGIC_VECTOR (52 downto 0);
    signal expAmExpB_uid68_block_rsrvd_fix_a : STD_LOGIC_VECTOR (11 downto 0);
    signal expAmExpB_uid68_block_rsrvd_fix_b : STD_LOGIC_VECTOR (11 downto 0);
    signal expAmExpB_uid68_block_rsrvd_fix_o : STD_LOGIC_VECTOR (11 downto 0);
    signal expAmExpB_uid68_block_rsrvd_fix_q : STD_LOGIC_VECTOR (11 downto 0);
    signal oWE_uid69_block_rsrvd_fix_q : STD_LOGIC_VECTOR (11 downto 0);
    signal closePathA_uid70_block_rsrvd_fix_a : STD_LOGIC_VECTOR (13 downto 0);
    signal closePathA_uid70_block_rsrvd_fix_b : STD_LOGIC_VECTOR (13 downto 0);
    signal closePathA_uid70_block_rsrvd_fix_o : STD_LOGIC_VECTOR (13 downto 0);
    signal closePathA_uid70_block_rsrvd_fix_n : STD_LOGIC_VECTOR (0 downto 0);
    signal closePath_uid71_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal closePath_uid71_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal aZeroOrSubnorm_uid72_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal bZeroOrSubnorm_uid73_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal oFracAE_uid74_block_rsrvd_fix_q : STD_LOGIC_VECTOR (55 downto 0);
    signal oFracBR_uid76_block_rsrvd_fix_q : STD_LOGIC_VECTOR (55 downto 0);
    signal oFracBREX_uid77_block_rsrvd_fix_b : STD_LOGIC_VECTOR (55 downto 0);
    signal oFracBREX_uid77_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (55 downto 0);
    signal oFracBREX_uid77_block_rsrvd_fix_q : STD_LOGIC_VECTOR (55 downto 0);
    signal oFracBREXC2_uid78_block_rsrvd_fix_a : STD_LOGIC_VECTOR (56 downto 0);
    signal oFracBREXC2_uid78_block_rsrvd_fix_b : STD_LOGIC_VECTOR (56 downto 0);
    signal oFracBREXC2_uid78_block_rsrvd_fix_o : STD_LOGIC_VECTOR (56 downto 0);
    signal oFracBREXC2_uid78_block_rsrvd_fix_q : STD_LOGIC_VECTOR (56 downto 0);
    signal oFracBREXC2S_uid79_block_rsrvd_fix_in : STD_LOGIC_VECTOR (55 downto 0);
    signal oFracBREXC2S_uid79_block_rsrvd_fix_b : STD_LOGIC_VECTOR (55 downto 0);
    signal oFracBREXC2HighBits_uid81_block_rsrvd_fix_in : STD_LOGIC_VECTOR (55 downto 0);
    signal oFracBREXC2HighBits_uid81_block_rsrvd_fix_b : STD_LOGIC_VECTOR (54 downto 0);
    signal xMSB_uid82_block_rsrvd_fix_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fracBAlignLowCloseUR_uid84_block_rsrvd_fix_q : STD_LOGIC_VECTOR (55 downto 0);
    signal expAmExpBZ_uid86_block_rsrvd_fix_in : STD_LOGIC_VECTOR (0 downto 0);
    signal expAmExpBZ_uid86_block_rsrvd_fix_b : STD_LOGIC_VECTOR (0 downto 0);
    signal aIsNotASubnorm_uid87_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal aNormalBSubnormal_uid88_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal aNormalBSubnormal_uid88_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal aNormalBSubnromal_uid89_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal exponentDifferenceIsOneAndBNotSubnormal_uid90_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal exponentDifferenceIsOneAndBNotSubnormal_uid90_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal oFracBREXC2SPostAlign_uid91_block_rsrvd_fix_s : STD_LOGIC_VECTOR (0 downto 0);
    signal oFracBREXC2SPostAlign_uid91_block_rsrvd_fix_q : STD_LOGIC_VECTOR (55 downto 0);
    signal fracAddResult_closePath_uid92_block_rsrvd_fix_a : STD_LOGIC_VECTOR (56 downto 0);
    signal fracAddResult_closePath_uid92_block_rsrvd_fix_b : STD_LOGIC_VECTOR (56 downto 0);
    signal fracAddResult_closePath_uid92_block_rsrvd_fix_o : STD_LOGIC_VECTOR (56 downto 0);
    signal fracAddResult_closePath_uid92_block_rsrvd_fix_q : STD_LOGIC_VECTOR (56 downto 0);
    signal fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_in : STD_LOGIC_VECTOR (55 downto 0);
    signal fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b : STD_LOGIC_VECTOR (55 downto 0);
    signal case0_uid95_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expValueClosePath_Case0_uid96_block_rsrvd_fix_q : STD_LOGIC_VECTOR (10 downto 0);
    signal expAP1_uid97_block_rsrvd_fix_a : STD_LOGIC_VECTOR (11 downto 0);
    signal expAP1_uid97_block_rsrvd_fix_b : STD_LOGIC_VECTOR (11 downto 0);
    signal expAP1_uid97_block_rsrvd_fix_o : STD_LOGIC_VECTOR (11 downto 0);
    signal expAP1_uid97_block_rsrvd_fix_q : STD_LOGIC_VECTOR (11 downto 0);
    signal expValueClosePath_Case11_uid98_block_rsrvd_fix_in : STD_LOGIC_VECTOR (10 downto 0);
    signal expValueClosePath_Case11_uid98_block_rsrvd_fix_b : STD_LOGIC_VECTOR (10 downto 0);
    signal zExt_uid99_block_rsrvd_fix_q : STD_LOGIC_VECTOR (4 downto 0);
    signal expValueClosePath_Case12_uid100_block_rsrvd_fix_q : STD_LOGIC_VECTOR (10 downto 0);
    signal aNormalAndClosePath_uid101_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal aNormalAndClosePath_uid101_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal condCase11_uid102_block_rsrvd_fix_a : STD_LOGIC_VECTOR (13 downto 0);
    signal condCase11_uid102_block_rsrvd_fix_b : STD_LOGIC_VECTOR (13 downto 0);
    signal condCase11_uid102_block_rsrvd_fix_o : STD_LOGIC_VECTOR (13 downto 0);
    signal condCase11_uid102_block_rsrvd_fix_n : STD_LOGIC_VECTOR (0 downto 0);
    signal condCase12_uid103_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal case11_uid104_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal case12_uid105_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal case0Exponent_uid106_block_rsrvd_fix_b : STD_LOGIC_VECTOR (10 downto 0);
    signal case0Exponent_uid106_block_rsrvd_fix_q : STD_LOGIC_VECTOR (10 downto 0);
    signal case11Exponent_uid107_block_rsrvd_fix_b : STD_LOGIC_VECTOR (10 downto 0);
    signal case11Exponent_uid107_block_rsrvd_fix_q : STD_LOGIC_VECTOR (10 downto 0);
    signal case12Exponent_uid108_block_rsrvd_fix_b : STD_LOGIC_VECTOR (10 downto 0);
    signal case12Exponent_uid108_block_rsrvd_fix_q : STD_LOGIC_VECTOR (10 downto 0);
    signal expValueClosePathExt_uid109_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (10 downto 0);
    signal expValueClosePathExt_uid109_block_rsrvd_fix_q : STD_LOGIC_VECTOR (10 downto 0);
    signal shiftValC11_uid114_block_rsrvd_fix_b : STD_LOGIC_VECTOR (10 downto 0);
    signal shiftValC11_uid114_block_rsrvd_fix_q : STD_LOGIC_VECTOR (10 downto 0);
    signal shiftValueCloseAll_uid116_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (10 downto 0);
    signal shiftValueCloseAll_uid116_block_rsrvd_fix_q : STD_LOGIC_VECTOR (10 downto 0);
    signal fracPostNorm_closePath_uid119_block_rsrvd_fix_in : STD_LOGIC_VECTOR (54 downto 0);
    signal fracPostNorm_closePath_uid119_block_rsrvd_fix_b : STD_LOGIC_VECTOR (52 downto 0);
    signal cAmA_uid120_block_rsrvd_fix_q : STD_LOGIC_VECTOR (5 downto 0);
    signal aMinusA2_uid121_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal aMinusA2_uid121_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal aMinusA_uid122_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal cWFP2_uid123_block_rsrvd_fix_q : STD_LOGIC_VECTOR (5 downto 0);
    signal shiftedOut_uid125_block_rsrvd_fix_a : STD_LOGIC_VECTOR (13 downto 0);
    signal shiftedOut_uid125_block_rsrvd_fix_b : STD_LOGIC_VECTOR (13 downto 0);
    signal shiftedOut_uid125_block_rsrvd_fix_o : STD_LOGIC_VECTOR (13 downto 0);
    signal shiftedOut_uid125_block_rsrvd_fix_c : STD_LOGIC_VECTOR (0 downto 0);
    signal shiftOutConst_uid126_block_rsrvd_fix_q : STD_LOGIC_VECTOR (5 downto 0);
    signal expAmExpBm1_uid128_block_rsrvd_fix_a : STD_LOGIC_VECTOR (13 downto 0);
    signal expAmExpBm1_uid128_block_rsrvd_fix_b : STD_LOGIC_VECTOR (13 downto 0);
    signal expAmExpBm1_uid128_block_rsrvd_fix_o : STD_LOGIC_VECTOR (13 downto 0);
    signal expAmExpBm1_uid128_block_rsrvd_fix_q : STD_LOGIC_VECTOR (12 downto 0);
    signal expAmExpBm1RangeShift_uid129_block_rsrvd_fix_in : STD_LOGIC_VECTOR (5 downto 0);
    signal expAmExpBm1RangeShift_uid129_block_rsrvd_fix_b : STD_LOGIC_VECTOR (5 downto 0);
    signal expAmExpBRangeShift_uid130_block_rsrvd_fix_in : STD_LOGIC_VECTOR (5 downto 0);
    signal expAmExpBRangeShift_uid130_block_rsrvd_fix_b : STD_LOGIC_VECTOR (5 downto 0);
    signal shiftValue_farPathPreSat_uid131_block_rsrvd_fix_s : STD_LOGIC_VECTOR (0 downto 0);
    signal shiftValue_farPathPreSat_uid131_block_rsrvd_fix_q : STD_LOGIC_VECTOR (5 downto 0);
    signal shiftValue_farPath_uid132_block_rsrvd_fix_s : STD_LOGIC_VECTOR (0 downto 0);
    signal shiftValue_farPath_uid132_block_rsrvd_fix_q : STD_LOGIC_VECTOR (5 downto 0);
    signal padConst_uid133_block_rsrvd_fix_q : STD_LOGIC_VECTOR (54 downto 0);
    signal rightPaddedIn_uid134_block_rsrvd_fix_q : STD_LOGIC_VECTOR (110 downto 0);
    signal lowRangeB_uid138_block_rsrvd_fix_in : STD_LOGIC_VECTOR (54 downto 0);
    signal lowRangeB_uid138_block_rsrvd_fix_b : STD_LOGIC_VECTOR (54 downto 0);
    signal highBBits_uid139_block_rsrvd_fix_b : STD_LOGIC_VECTOR (55 downto 0);
    signal fracAddResult_farPathsumAHighB_uid140_block_rsrvd_fix_a : STD_LOGIC_VECTOR (56 downto 0);
    signal fracAddResult_farPathsumAHighB_uid140_block_rsrvd_fix_b : STD_LOGIC_VECTOR (56 downto 0);
    signal fracAddResult_farPathsumAHighB_uid140_block_rsrvd_fix_o : STD_LOGIC_VECTOR (56 downto 0);
    signal fracAddResult_farPathsumAHighB_uid140_block_rsrvd_fix_q : STD_LOGIC_VECTOR (56 downto 0);
    signal fracAddResult_farPath_uid141_block_rsrvd_fix_q : STD_LOGIC_VECTOR (111 downto 0);
    signal stickyTemp_uid142_block_rsrvd_fix_in : STD_LOGIC_VECTOR (54 downto 0);
    signal stickyTemp_uid142_block_rsrvd_fix_b : STD_LOGIC_VECTOR (54 downto 0);
    signal stickyPreMux_uid143_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal stickyPreMux_uid143_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal normBits_farPath_uid144_block_rsrvd_fix_in : STD_LOGIC_VECTOR (110 downto 0);
    signal normBits_farPath_uid144_block_rsrvd_fix_b : STD_LOGIC_VECTOR (1 downto 0);
    signal invNormBits_farPathInternal1_uid146_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal invNormBits_farPathInternal0_uid148_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal aAndBSubnormalsAndSubnormalRes_uid149_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal aAndBSubnormalsAndNormalRes_uid153_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal oneOnTwoBits_uid154_block_rsrvd_fix_q : STD_LOGIC_VECTOR (1 downto 0);
    signal normBits_farPathRnd_uid155_block_rsrvd_fix_s : STD_LOGIC_VECTOR (0 downto 0);
    signal normBits_farPathRnd_uid155_block_rsrvd_fix_q : STD_LOGIC_VECTOR (1 downto 0);
    signal aAndBSubnormal_uid156_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal threeOnTwoBits_uid157_block_rsrvd_fix_q : STD_LOGIC_VECTOR (1 downto 0);
    signal aAndBSubnormalCst_uid159_block_rsrvd_fix_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aAndBSubnormalCst_uid159_block_rsrvd_fix_q : STD_LOGIC_VECTOR (1 downto 0);
    signal normBits_farPathCnt_uid160_block_rsrvd_fix_s : STD_LOGIC_VECTOR (0 downto 0);
    signal normBits_farPathCnt_uid160_block_rsrvd_fix_q : STD_LOGIC_VECTOR (1 downto 0);
    signal fracPostNorm_farPath11_uid161_block_rsrvd_fix_in : STD_LOGIC_VECTOR (109 downto 0);
    signal fracPostNorm_farPath11_uid161_block_rsrvd_fix_b : STD_LOGIC_VECTOR (52 downto 0);
    signal fracPostNorm_farPath01_uid165_block_rsrvd_fix_in : STD_LOGIC_VECTOR (108 downto 0);
    signal fracPostNorm_farPath01_uid165_block_rsrvd_fix_b : STD_LOGIC_VECTOR (52 downto 0);
    signal fracPostNorm_farPath00_uid167_block_rsrvd_fix_in : STD_LOGIC_VECTOR (107 downto 0);
    signal fracPostNorm_farPath00_uid167_block_rsrvd_fix_b : STD_LOGIC_VECTOR (52 downto 0);
    signal fracPostNorm_farPath_uid169_block_rsrvd_fix_s : STD_LOGIC_VECTOR (1 downto 0);
    signal fracPostNorm_farPath_uid169_block_rsrvd_fix_q : STD_LOGIC_VECTOR (52 downto 0);
    signal cst2zeros_uid170_block_rsrvd_fix_q : STD_LOGIC_VECTOR (1 downto 0);
    signal extra11_uid172_block_rsrvd_fix_in : STD_LOGIC_VECTOR (56 downto 0);
    signal extra11_uid172_block_rsrvd_fix_b : STD_LOGIC_VECTOR (1 downto 0);
    signal extra01_uid176_block_rsrvd_fix_in : STD_LOGIC_VECTOR (55 downto 0);
    signal extra01_uid176_block_rsrvd_fix_b : STD_LOGIC_VECTOR (0 downto 0);
    signal m01_uid177_block_rsrvd_fix_q : STD_LOGIC_VECTOR (1 downto 0);
    signal stickyExtraBits_uid179_block_rsrvd_fix_s : STD_LOGIC_VECTOR (1 downto 0);
    signal stickyExtraBits_uid179_block_rsrvd_fix_q : STD_LOGIC_VECTOR (1 downto 0);
    signal stickyAllBits_uid180_block_rsrvd_fix_q : STD_LOGIC_VECTOR (2 downto 0);
    signal sticky_uid181_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal r11_uid182_block_rsrvd_fix_in : STD_LOGIC_VECTOR (57 downto 0);
    signal r11_uid182_block_rsrvd_fix_b : STD_LOGIC_VECTOR (0 downto 0);
    signal r01_uid186_block_rsrvd_fix_in : STD_LOGIC_VECTOR (56 downto 0);
    signal r01_uid186_block_rsrvd_fix_b : STD_LOGIC_VECTOR (0 downto 0);
    signal rBit_uid190_block_rsrvd_fix_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rBit_uid190_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal countValue_farPath00_uid194_block_rsrvd_fix_q : STD_LOGIC_VECTOR (10 downto 0);
    signal countValue_farPath_uid195_block_rsrvd_fix_s : STD_LOGIC_VECTOR (1 downto 0);
    signal countValue_farPath_uid195_block_rsrvd_fix_q : STD_LOGIC_VECTOR (10 downto 0);
    signal lBit_uid196_block_rsrvd_fix_in : STD_LOGIC_VECTOR (1 downto 0);
    signal lBit_uid196_block_rsrvd_fix_b : STD_LOGIC_VECTOR (0 downto 0);
    signal concBits_uid197_block_rsrvd_fix_q : STD_LOGIC_VECTOR (2 downto 0);
    signal cst2On3Bits_uid198_block_rsrvd_fix_q : STD_LOGIC_VECTOR (2 downto 0);
    signal IrndVal_uid199_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal IrndVal_uid199_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal rndVal_far_uid200_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal lsb2BitsClosePath_uid202_block_rsrvd_fix_in : STD_LOGIC_VECTOR (1 downto 0);
    signal lsb2BitsClosePath_uid202_block_rsrvd_fix_b : STD_LOGIC_VECTOR (1 downto 0);
    signal IrndVal_close_uid203_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal rndVal_close_uid204_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal countValue_uid205_block_rsrvd_fix_s : STD_LOGIC_VECTOR (0 downto 0);
    signal countValue_uid205_block_rsrvd_fix_q : STD_LOGIC_VECTOR (10 downto 0);
    signal expPostNorm_uid207_block_rsrvd_fix_a : STD_LOGIC_VECTOR (12 downto 0);
    signal expPostNorm_uid207_block_rsrvd_fix_b : STD_LOGIC_VECTOR (12 downto 0);
    signal expPostNorm_uid207_block_rsrvd_fix_o : STD_LOGIC_VECTOR (12 downto 0);
    signal expPostNorm_uid207_block_rsrvd_fix_q : STD_LOGIC_VECTOR (12 downto 0);
    signal fracPostNormPreRnd_uid210_block_rsrvd_fix_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fracPostNormPreRnd_uid210_block_rsrvd_fix_q : STD_LOGIC_VECTOR (52 downto 0);
    signal rndValue_uid211_block_rsrvd_fix_s : STD_LOGIC_VECTOR (0 downto 0);
    signal rndValue_uid211_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal countValFracPostNorm_uid212_block_rsrvd_fix_q : STD_LOGIC_VECTOR (65 downto 0);
    signal countValFracPostRnd_uid213_block_rsrvd_fix_a : STD_LOGIC_VECTOR (66 downto 0);
    signal countValFracPostRnd_uid213_block_rsrvd_fix_b : STD_LOGIC_VECTOR (66 downto 0);
    signal countValFracPostRnd_uid213_block_rsrvd_fix_o : STD_LOGIC_VECTOR (66 downto 0);
    signal countValFracPostRnd_uid213_block_rsrvd_fix_q : STD_LOGIC_VECTOR (66 downto 0);
    signal countValue_uid214_block_rsrvd_fix_in : STD_LOGIC_VECTOR (65 downto 0);
    signal countValue_uid214_block_rsrvd_fix_b : STD_LOGIC_VECTOR (12 downto 0);
    signal fracValue_uid215_block_rsrvd_fix_in : STD_LOGIC_VECTOR (52 downto 0);
    signal fracValue_uid215_block_rsrvd_fix_b : STD_LOGIC_VECTOR (51 downto 0);
    signal wEP2AllOwE_uid216_block_rsrvd_fix_q : STD_LOGIC_VECTOR (12 downto 0);
    signal rOvf_uid218_block_rsrvd_fix_a : STD_LOGIC_VECTOR (15 downto 0);
    signal rOvf_uid218_block_rsrvd_fix_b : STD_LOGIC_VECTOR (15 downto 0);
    signal rOvf_uid218_block_rsrvd_fix_o : STD_LOGIC_VECTOR (15 downto 0);
    signal rOvf_uid218_block_rsrvd_fix_n : STD_LOGIC_VECTOR (0 downto 0);
    signal expRPreExc_uid220_block_rsrvd_fix_in : STD_LOGIC_VECTOR (10 downto 0);
    signal expRPreExc_uid220_block_rsrvd_fix_b : STD_LOGIC_VECTOR (10 downto 0);
    signal regInputs_uid221_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal regInputs_uid221_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRZeroVInC_uid222_block_rsrvd_fix_q : STD_LOGIC_VECTOR (2 downto 0);
    signal excRZero_uid223_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal rInfOvf_uid224_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRInfVInC_uid225_block_rsrvd_fix_q : STD_LOGIC_VECTOR (5 downto 0);
    signal excRInf_uid226_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRNaN2_uid227_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excAIBISub_uid228_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRNaN_uid229_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal concExc_uid230_block_rsrvd_fix_q : STD_LOGIC_VECTOR (2 downto 0);
    signal excREnc_uid231_block_rsrvd_fix_q : STD_LOGIC_VECTOR (1 downto 0);
    signal aIsRegOrSubnorm_uid232_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal aIsRegOrSubnorm_uid232_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal bIsRegOrSubnorm_uid233_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal invAMinusA_uid234_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal signRReg_uid235_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal sigBBInf_uid236_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal sigAAInf_uid237_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal signRInf_uid238_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excAZBZSigASigB_uid239_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excBZARSigA_uid240_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal signRZero_uid241_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal signRInfRZRReg_uid242_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal signRInfRZRReg_uid242_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal invExcRNaN_uid243_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal signRPostExc_uid244_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal signRPostExc_uid244_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal oneFracRPostExc2_uid245_block_rsrvd_fix_q : STD_LOGIC_VECTOR (51 downto 0);
    signal fracRPostExc_uid248_block_rsrvd_fix_s : STD_LOGIC_VECTOR (1 downto 0);
    signal fracRPostExc_uid248_block_rsrvd_fix_q : STD_LOGIC_VECTOR (51 downto 0);
    signal expRPostExc_uid252_block_rsrvd_fix_s : STD_LOGIC_VECTOR (1 downto 0);
    signal expRPostExc_uid252_block_rsrvd_fix_q : STD_LOGIC_VECTOR (10 downto 0);
    signal R_uid253_block_rsrvd_fix_q : STD_LOGIC_VECTOR (63 downto 0);
    signal zs_uid255_countValue_closePathZ_uid94_block_rsrvd_fix_q : STD_LOGIC_VECTOR (31 downto 0);
    signal rVStage_uid256_countValue_closePathZ_uid94_block_rsrvd_fix_b : STD_LOGIC_VECTOR (31 downto 0);
    signal vCount_uid257_countValue_closePathZ_uid94_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal mO_uid258_countValue_closePathZ_uid94_block_rsrvd_fix_q : STD_LOGIC_VECTOR (7 downto 0);
    signal vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_in : STD_LOGIC_VECTOR (23 downto 0);
    signal vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b : STD_LOGIC_VECTOR (23 downto 0);
    signal cStage_uid260_countValue_closePathZ_uid94_block_rsrvd_fix_q : STD_LOGIC_VECTOR (31 downto 0);
    signal vStagei_uid262_countValue_closePathZ_uid94_block_rsrvd_fix_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid262_countValue_closePathZ_uid94_block_rsrvd_fix_q : STD_LOGIC_VECTOR (31 downto 0);
    signal zs_uid263_countValue_closePathZ_uid94_block_rsrvd_fix_q : STD_LOGIC_VECTOR (15 downto 0);
    signal vCount_uid265_countValue_closePathZ_uid94_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid268_countValue_closePathZ_uid94_block_rsrvd_fix_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid268_countValue_closePathZ_uid94_block_rsrvd_fix_q : STD_LOGIC_VECTOR (15 downto 0);
    signal zs_uid269_countValue_closePathZ_uid94_block_rsrvd_fix_q : STD_LOGIC_VECTOR (7 downto 0);
    signal vCount_uid271_countValue_closePathZ_uid94_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid274_countValue_closePathZ_uid94_block_rsrvd_fix_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid274_countValue_closePathZ_uid94_block_rsrvd_fix_q : STD_LOGIC_VECTOR (7 downto 0);
    signal zs_uid275_countValue_closePathZ_uid94_block_rsrvd_fix_q : STD_LOGIC_VECTOR (3 downto 0);
    signal vCount_uid277_countValue_closePathZ_uid94_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid280_countValue_closePathZ_uid94_block_rsrvd_fix_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid280_countValue_closePathZ_uid94_block_rsrvd_fix_q : STD_LOGIC_VECTOR (3 downto 0);
    signal vCount_uid283_countValue_closePathZ_uid94_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid286_countValue_closePathZ_uid94_block_rsrvd_fix_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid286_countValue_closePathZ_uid94_block_rsrvd_fix_q : STD_LOGIC_VECTOR (1 downto 0);
    signal rVStage_uid288_countValue_closePathZ_uid94_block_rsrvd_fix_b : STD_LOGIC_VECTOR (0 downto 0);
    signal vCount_uid289_countValue_closePathZ_uid94_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal r_uid290_countValue_closePathZ_uid94_block_rsrvd_fix_q : STD_LOGIC_VECTOR (5 downto 0);
    signal eq0_uid294_fracXIsZero_uid26_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq1_uid297_fracXIsZero_uid26_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq2_uid300_fracXIsZero_uid26_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq3_uid303_fracXIsZero_uid26_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq4_uid306_fracXIsZero_uid26_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq5_uid309_fracXIsZero_uid26_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq6_uid312_fracXIsZero_uid26_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq7_uid315_fracXIsZero_uid26_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq8_uid318_fracXIsZero_uid26_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal and_lev0_uid319_fracXIsZero_uid26_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal and_lev0_uid319_fracXIsZero_uid26_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal and_lev0_uid320_fracXIsZero_uid26_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal and_lev0_uid320_fracXIsZero_uid26_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal and_lev1_uid321_fracXIsZero_uid26_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq0_uid324_fracXIsZero_uid43_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal eq0_uid324_fracXIsZero_uid43_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq1_uid327_fracXIsZero_uid43_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal eq1_uid327_fracXIsZero_uid43_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq2_uid330_fracXIsZero_uid43_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal eq2_uid330_fracXIsZero_uid43_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq3_uid333_fracXIsZero_uid43_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal eq3_uid333_fracXIsZero_uid43_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq4_uid336_fracXIsZero_uid43_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal eq4_uid336_fracXIsZero_uid43_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq5_uid339_fracXIsZero_uid43_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal eq5_uid339_fracXIsZero_uid43_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq6_uid342_fracXIsZero_uid43_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal eq6_uid342_fracXIsZero_uid43_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq7_uid345_fracXIsZero_uid43_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal eq7_uid345_fracXIsZero_uid43_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq8_uid348_fracXIsZero_uid43_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal eq8_uid348_fracXIsZero_uid43_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal and_lev0_uid349_fracXIsZero_uid43_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal and_lev0_uid350_fracXIsZero_uid43_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal and_lev1_uid351_fracXIsZero_uid43_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal and_lev1_uid351_fracXIsZero_uid43_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal shiftedOut_uid355_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_a : STD_LOGIC_VECTOR (12 downto 0);
    signal shiftedOut_uid355_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_b : STD_LOGIC_VECTOR (12 downto 0);
    signal shiftedOut_uid355_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_o : STD_LOGIC_VECTOR (12 downto 0);
    signal shiftedOut_uid355_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_n : STD_LOGIC_VECTOR (0 downto 0);
    signal leftShiftStage0Idx1Rng16_uid357_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_in : STD_LOGIC_VECTOR (39 downto 0);
    signal leftShiftStage0Idx1Rng16_uid357_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_b : STD_LOGIC_VECTOR (39 downto 0);
    signal leftShiftStage0Idx1_uid358_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q : STD_LOGIC_VECTOR (55 downto 0);
    signal leftShiftStage0Idx2_uid361_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q : STD_LOGIC_VECTOR (55 downto 0);
    signal leftShiftStage0Idx3Pad48_uid362_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q : STD_LOGIC_VECTOR (47 downto 0);
    signal leftShiftStage0Idx3Rng48_uid363_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_in : STD_LOGIC_VECTOR (7 downto 0);
    signal leftShiftStage0Idx3Rng48_uid363_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_b : STD_LOGIC_VECTOR (7 downto 0);
    signal leftShiftStage0Idx3_uid364_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q : STD_LOGIC_VECTOR (55 downto 0);
    signal leftShiftStage0_uid366_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_s : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage0_uid366_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q : STD_LOGIC_VECTOR (55 downto 0);
    signal leftShiftStage1Idx1Rng4_uid368_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_in : STD_LOGIC_VECTOR (51 downto 0);
    signal leftShiftStage1Idx1Rng4_uid368_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_b : STD_LOGIC_VECTOR (51 downto 0);
    signal leftShiftStage1Idx1_uid369_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q : STD_LOGIC_VECTOR (55 downto 0);
    signal leftShiftStage1Idx2Rng8_uid371_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_in : STD_LOGIC_VECTOR (47 downto 0);
    signal leftShiftStage1Idx2Rng8_uid371_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_b : STD_LOGIC_VECTOR (47 downto 0);
    signal leftShiftStage1Idx2_uid372_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q : STD_LOGIC_VECTOR (55 downto 0);
    signal leftShiftStage1Idx3Pad12_uid373_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q : STD_LOGIC_VECTOR (11 downto 0);
    signal leftShiftStage1Idx3Rng12_uid374_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_in : STD_LOGIC_VECTOR (43 downto 0);
    signal leftShiftStage1Idx3Rng12_uid374_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_b : STD_LOGIC_VECTOR (43 downto 0);
    signal leftShiftStage1Idx3_uid375_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q : STD_LOGIC_VECTOR (55 downto 0);
    signal leftShiftStage1_uid377_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_s : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage1_uid377_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q : STD_LOGIC_VECTOR (55 downto 0);
    signal leftShiftStage2Idx1Rng1_uid379_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_in : STD_LOGIC_VECTOR (54 downto 0);
    signal leftShiftStage2Idx1Rng1_uid379_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_b : STD_LOGIC_VECTOR (54 downto 0);
    signal leftShiftStage2Idx1_uid380_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q : STD_LOGIC_VECTOR (55 downto 0);
    signal leftShiftStage2Idx2Rng2_uid382_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_in : STD_LOGIC_VECTOR (53 downto 0);
    signal leftShiftStage2Idx2Rng2_uid382_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_b : STD_LOGIC_VECTOR (53 downto 0);
    signal leftShiftStage2Idx2_uid383_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q : STD_LOGIC_VECTOR (55 downto 0);
    signal leftShiftStage2Idx3Pad3_uid384_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q : STD_LOGIC_VECTOR (2 downto 0);
    signal leftShiftStage2Idx3Rng3_uid385_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_in : STD_LOGIC_VECTOR (52 downto 0);
    signal leftShiftStage2Idx3Rng3_uid385_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_b : STD_LOGIC_VECTOR (52 downto 0);
    signal leftShiftStage2Idx3_uid386_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q : STD_LOGIC_VECTOR (55 downto 0);
    signal leftShiftStage2_uid388_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_s : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage2_uid388_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q : STD_LOGIC_VECTOR (55 downto 0);
    signal zeroOutCst_uid389_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q : STD_LOGIC_VECTOR (55 downto 0);
    signal r_uid390_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_s : STD_LOGIC_VECTOR (0 downto 0);
    signal r_uid390_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q : STD_LOGIC_VECTOR (55 downto 0);
    signal xMSB_uid392_alignmentShifter_uid133_block_rsrvd_fix_b : STD_LOGIC_VECTOR (0 downto 0);
    signal seMsb_to16_uid394_in : STD_LOGIC_VECTOR (15 downto 0);
    signal seMsb_to16_uid394_b : STD_LOGIC_VECTOR (15 downto 0);
    signal rightShiftStage0Idx1Rng16_uid395_alignmentShifter_uid133_block_rsrvd_fix_b : STD_LOGIC_VECTOR (94 downto 0);
    signal rightShiftStage0Idx1_uid396_alignmentShifter_uid133_block_rsrvd_fix_q : STD_LOGIC_VECTOR (110 downto 0);
    signal seMsb_to32_uid397_in : STD_LOGIC_VECTOR (31 downto 0);
    signal seMsb_to32_uid397_b : STD_LOGIC_VECTOR (31 downto 0);
    signal rightShiftStage0Idx2Rng32_uid398_alignmentShifter_uid133_block_rsrvd_fix_b : STD_LOGIC_VECTOR (78 downto 0);
    signal rightShiftStage0Idx2_uid399_alignmentShifter_uid133_block_rsrvd_fix_q : STD_LOGIC_VECTOR (110 downto 0);
    signal seMsb_to48_uid400_in : STD_LOGIC_VECTOR (47 downto 0);
    signal seMsb_to48_uid400_b : STD_LOGIC_VECTOR (47 downto 0);
    signal rightShiftStage0Idx3Rng48_uid401_alignmentShifter_uid133_block_rsrvd_fix_b : STD_LOGIC_VECTOR (62 downto 0);
    signal rightShiftStage0Idx3_uid402_alignmentShifter_uid133_block_rsrvd_fix_q : STD_LOGIC_VECTOR (110 downto 0);
    signal rightShiftStage0_uid404_alignmentShifter_uid133_block_rsrvd_fix_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage0_uid404_alignmentShifter_uid133_block_rsrvd_fix_q : STD_LOGIC_VECTOR (110 downto 0);
    signal seMsb_to4_uid405_in : STD_LOGIC_VECTOR (3 downto 0);
    signal seMsb_to4_uid405_b : STD_LOGIC_VECTOR (3 downto 0);
    signal rightShiftStage1Idx1Rng4_uid406_alignmentShifter_uid133_block_rsrvd_fix_b : STD_LOGIC_VECTOR (106 downto 0);
    signal rightShiftStage1Idx1_uid407_alignmentShifter_uid133_block_rsrvd_fix_q : STD_LOGIC_VECTOR (110 downto 0);
    signal seMsb_to8_uid408_in : STD_LOGIC_VECTOR (7 downto 0);
    signal seMsb_to8_uid408_b : STD_LOGIC_VECTOR (7 downto 0);
    signal rightShiftStage1Idx2Rng8_uid409_alignmentShifter_uid133_block_rsrvd_fix_b : STD_LOGIC_VECTOR (102 downto 0);
    signal rightShiftStage1Idx2_uid410_alignmentShifter_uid133_block_rsrvd_fix_q : STD_LOGIC_VECTOR (110 downto 0);
    signal seMsb_to12_uid411_in : STD_LOGIC_VECTOR (11 downto 0);
    signal seMsb_to12_uid411_b : STD_LOGIC_VECTOR (11 downto 0);
    signal rightShiftStage1Idx3Rng12_uid412_alignmentShifter_uid133_block_rsrvd_fix_b : STD_LOGIC_VECTOR (98 downto 0);
    signal rightShiftStage1Idx3_uid413_alignmentShifter_uid133_block_rsrvd_fix_q : STD_LOGIC_VECTOR (110 downto 0);
    signal rightShiftStage1_uid415_alignmentShifter_uid133_block_rsrvd_fix_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage1_uid415_alignmentShifter_uid133_block_rsrvd_fix_q : STD_LOGIC_VECTOR (110 downto 0);
    signal rightShiftStage2Idx1Rng1_uid416_alignmentShifter_uid133_block_rsrvd_fix_b : STD_LOGIC_VECTOR (109 downto 0);
    signal rightShiftStage2Idx1_uid417_alignmentShifter_uid133_block_rsrvd_fix_q : STD_LOGIC_VECTOR (110 downto 0);
    signal seMsb_to2_uid418_in : STD_LOGIC_VECTOR (1 downto 0);
    signal seMsb_to2_uid418_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage2Idx2Rng2_uid419_alignmentShifter_uid133_block_rsrvd_fix_b : STD_LOGIC_VECTOR (108 downto 0);
    signal rightShiftStage2Idx2_uid420_alignmentShifter_uid133_block_rsrvd_fix_q : STD_LOGIC_VECTOR (110 downto 0);
    signal seMsb_to3_uid421_in : STD_LOGIC_VECTOR (2 downto 0);
    signal seMsb_to3_uid421_b : STD_LOGIC_VECTOR (2 downto 0);
    signal rightShiftStage2Idx3Rng3_uid422_alignmentShifter_uid133_block_rsrvd_fix_b : STD_LOGIC_VECTOR (107 downto 0);
    signal rightShiftStage2Idx3_uid423_alignmentShifter_uid133_block_rsrvd_fix_q : STD_LOGIC_VECTOR (110 downto 0);
    signal rightShiftStage2_uid425_alignmentShifter_uid133_block_rsrvd_fix_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage2_uid425_alignmentShifter_uid133_block_rsrvd_fix_q : STD_LOGIC_VECTOR (110 downto 0);
    signal c0_uid293_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_b : STD_LOGIC_VECTOR (5 downto 0);
    signal c0_uid293_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_c : STD_LOGIC_VECTOR (5 downto 0);
    signal c0_uid293_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_d : STD_LOGIC_VECTOR (5 downto 0);
    signal c0_uid293_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_e : STD_LOGIC_VECTOR (5 downto 0);
    signal c0_uid293_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_f : STD_LOGIC_VECTOR (5 downto 0);
    signal c0_uid293_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_g : STD_LOGIC_VECTOR (5 downto 0);
    signal c0_uid293_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_h : STD_LOGIC_VECTOR (5 downto 0);
    signal c0_uid293_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_i : STD_LOGIC_VECTOR (5 downto 0);
    signal c0_uid293_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_j : STD_LOGIC_VECTOR (3 downto 0);
    signal z0_uid292_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_b : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid292_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_c : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid292_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_d : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid292_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_e : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid292_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_f : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid292_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_g : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid292_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_h : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid292_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_i : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid292_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_j : STD_LOGIC_VECTOR (3 downto 0);
    signal z0_uid322_fracXIsZero_uid43_block_rsrvd_fix_merged_bit_select_b : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid322_fracXIsZero_uid43_block_rsrvd_fix_merged_bit_select_c : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid322_fracXIsZero_uid43_block_rsrvd_fix_merged_bit_select_d : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid322_fracXIsZero_uid43_block_rsrvd_fix_merged_bit_select_e : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid322_fracXIsZero_uid43_block_rsrvd_fix_merged_bit_select_f : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid322_fracXIsZero_uid43_block_rsrvd_fix_merged_bit_select_g : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid322_fracXIsZero_uid43_block_rsrvd_fix_merged_bit_select_h : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid322_fracXIsZero_uid43_block_rsrvd_fix_merged_bit_select_i : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid322_fracXIsZero_uid43_block_rsrvd_fix_merged_bit_select_j : STD_LOGIC_VECTOR (3 downto 0);
    signal leftShiftStageSel5Dto4_uid365_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_merged_bit_select_in : STD_LOGIC_VECTOR (5 downto 0);
    signal leftShiftStageSel5Dto4_uid365_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_merged_bit_select_b : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStageSel5Dto4_uid365_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_merged_bit_select_c : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStageSel5Dto4_uid365_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_merged_bit_select_d : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStageSel5Dto4_uid403_alignmentShifter_uid133_block_rsrvd_fix_merged_bit_select_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStageSel5Dto4_uid403_alignmentShifter_uid133_block_rsrvd_fix_merged_bit_select_c : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStageSel5Dto4_uid403_alignmentShifter_uid133_block_rsrvd_fix_merged_bit_select_d : STD_LOGIC_VECTOR (1 downto 0);
    signal normBits_farPathInternal1_uid145_block_rsrvd_fix_merged_bit_select_b : STD_LOGIC_VECTOR (0 downto 0);
    signal normBits_farPathInternal1_uid145_block_rsrvd_fix_merged_bit_select_c : STD_LOGIC_VECTOR (0 downto 0);
    signal rVStage_uid264_countValue_closePathZ_uid94_block_rsrvd_fix_merged_bit_select_b : STD_LOGIC_VECTOR (15 downto 0);
    signal rVStage_uid264_countValue_closePathZ_uid94_block_rsrvd_fix_merged_bit_select_c : STD_LOGIC_VECTOR (15 downto 0);
    signal rVStage_uid270_countValue_closePathZ_uid94_block_rsrvd_fix_merged_bit_select_b : STD_LOGIC_VECTOR (7 downto 0);
    signal rVStage_uid270_countValue_closePathZ_uid94_block_rsrvd_fix_merged_bit_select_c : STD_LOGIC_VECTOR (7 downto 0);
    signal rVStage_uid276_countValue_closePathZ_uid94_block_rsrvd_fix_merged_bit_select_b : STD_LOGIC_VECTOR (3 downto 0);
    signal rVStage_uid276_countValue_closePathZ_uid94_block_rsrvd_fix_merged_bit_select_c : STD_LOGIC_VECTOR (3 downto 0);
    signal rVStage_uid282_countValue_closePathZ_uid94_block_rsrvd_fix_merged_bit_select_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rVStage_uid282_countValue_closePathZ_uid94_block_rsrvd_fix_merged_bit_select_c : STD_LOGIC_VECTOR (1 downto 0);
    signal redist0_rightShiftStageSel5Dto4_uid403_alignmentShifter_uid133_block_rsrvd_fix_merged_bit_select_c_1_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist1_rightShiftStageSel5Dto4_uid403_alignmentShifter_uid133_block_rsrvd_fix_merged_bit_select_d_2_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist2_leftShiftStageSel5Dto4_uid365_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_merged_bit_select_d_1_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist3_xMSB_uid392_alignmentShifter_uid133_block_rsrvd_fix_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist4_xMSB_uid392_alignmentShifter_uid133_block_rsrvd_fix_b_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist5_and_lev1_uid321_fracXIsZero_uid26_block_rsrvd_fix_q_5_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist6_r_uid290_countValue_closePathZ_uid94_block_rsrvd_fix_q_1_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist7_r_uid290_countValue_closePathZ_uid94_block_rsrvd_fix_q_2_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist8_vCount_uid277_countValue_closePathZ_uid94_block_rsrvd_fix_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist9_vCount_uid271_countValue_closePathZ_uid94_block_rsrvd_fix_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist10_vCount_uid265_countValue_closePathZ_uid94_block_rsrvd_fix_q_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist12_vCount_uid257_countValue_closePathZ_uid94_block_rsrvd_fix_q_4_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist13_signRInfRZRReg_uid242_block_rsrvd_fix_q_7_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist14_aIsRegOrSubnorm_uid232_block_rsrvd_fix_q_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist15_concExc_uid230_block_rsrvd_fix_q_1_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist16_excRZero_uid223_block_rsrvd_fix_q_7_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist17_regInputs_uid221_block_rsrvd_fix_q_7_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist18_expRPreExc_uid220_block_rsrvd_fix_b_2_q : STD_LOGIC_VECTOR (10 downto 0);
    signal redist19_fracValue_uid215_block_rsrvd_fix_b_3_q : STD_LOGIC_VECTOR (51 downto 0);
    signal redist20_countValue_uid214_block_rsrvd_fix_b_1_q : STD_LOGIC_VECTOR (12 downto 0);
    signal redist21_expPostNorm_uid207_block_rsrvd_fix_q_2_q : STD_LOGIC_VECTOR (12 downto 0);
    signal redist22_IrndVal_uid199_block_rsrvd_fix_q_6_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist24_normBits_farPathCnt_uid160_block_rsrvd_fix_q_5_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist25_fracAddResult_farPath_uid141_block_rsrvd_fix_q_1_q : STD_LOGIC_VECTOR (111 downto 0);
    signal redist26_highBBits_uid139_block_rsrvd_fix_b_1_q : STD_LOGIC_VECTOR (55 downto 0);
    signal redist27_lowRangeB_uid138_block_rsrvd_fix_b_2_q : STD_LOGIC_VECTOR (54 downto 0);
    signal redist28_expAmExpBRangeShift_uid130_block_rsrvd_fix_b_1_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist29_expAmExpBm1RangeShift_uid129_block_rsrvd_fix_b_1_q : STD_LOGIC_VECTOR (5 downto 0);
    signal redist30_fracPostNorm_closePath_uid119_block_rsrvd_fix_b_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist31_expAP1_uid97_block_rsrvd_fix_q_2_q : STD_LOGIC_VECTOR (11 downto 0);
    signal redist32_expAP1_uid97_block_rsrvd_fix_q_4_q : STD_LOGIC_VECTOR (11 downto 0);
    signal redist33_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_1_q : STD_LOGIC_VECTOR (55 downto 0);
    signal redist35_expAmExpBZ_uid86_block_rsrvd_fix_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist36_oFracAE_uid74_block_rsrvd_fix_q_2_q : STD_LOGIC_VECTOR (55 downto 0);
    signal redist37_aZeroOrSubnorm_uid72_block_rsrvd_fix_q_4_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist38_closePath_uid71_block_rsrvd_fix_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist39_closePath_uid71_block_rsrvd_fix_q_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist40_closePath_uid71_block_rsrvd_fix_q_5_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist41_closePathA_uid70_block_rsrvd_fix_n_8_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist42_effSub_uid59_block_rsrvd_fix_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist43_effSub_uid59_block_rsrvd_fix_q_8_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist44_effSub_uid59_block_rsrvd_fix_q_16_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist45_sigB_uid58_block_rsrvd_fix_b_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist46_sigB_uid58_block_rsrvd_fix_b_11_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist47_sigA_uid57_block_rsrvd_fix_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist48_sigA_uid57_block_rsrvd_fix_b_10_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist49_excS_bSig_uid51_block_rsrvd_fix_q_6_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist50_excS_bSig_uid51_block_rsrvd_fix_q_9_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist51_excR_bSig_uid50_block_rsrvd_fix_q_9_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist52_excN_bSig_uid47_block_rsrvd_fix_q_16_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist53_excI_bSig_uid46_block_rsrvd_fix_q_9_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist54_excI_bSig_uid46_block_rsrvd_fix_q_16_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist55_excZ_bSig_uid45_block_rsrvd_fix_q_6_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist56_excZ_bSig_uid45_block_rsrvd_fix_q_9_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist57_frac_bSig_uid40_block_rsrvd_fix_b_2_q : STD_LOGIC_VECTOR (51 downto 0);
    signal redist58_exp_bSig_uid39_block_rsrvd_fix_b_1_q : STD_LOGIC_VECTOR (10 downto 0);
    signal redist59_excS_aSig_uid34_block_rsrvd_fix_q_6_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist60_excR_aSig_uid33_block_rsrvd_fix_q_4_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist61_InvExpXIsZero_uid32_block_rsrvd_fix_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist62_excN_aSig_uid30_block_rsrvd_fix_q_11_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist63_excI_aSig_uid29_block_rsrvd_fix_q_4_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist64_excI_aSig_uid29_block_rsrvd_fix_q_11_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist65_excZ_aSig_uid28_block_rsrvd_fix_q_4_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist66_fracXIsNotZero_uid27_block_rsrvd_fix_q_5_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist67_expXIsZero_uid24_block_rsrvd_fix_q_4_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist68_expXIsZero_uid24_block_rsrvd_fix_q_6_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist69_frac_aSig_uid23_block_rsrvd_fix_b_4_q : STD_LOGIC_VECTOR (51 downto 0);
    signal redist71_exp_aSig_uid22_block_rsrvd_fix_b_9_q : STD_LOGIC_VECTOR (10 downto 0);
    signal redist72_exp_aSig_uid22_block_rsrvd_fix_b_11_q : STD_LOGIC_VECTOR (10 downto 0);
    signal redist73_in_1_in_1_1_q : STD_LOGIC_VECTOR (63 downto 0);
    signal redist74_in_0_in_0_1_q : STD_LOGIC_VECTOR (63 downto 0);
    signal redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_inputreg_q : STD_LOGIC_VECTOR (23 downto 0);
    signal redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_outputreg_q : STD_LOGIC_VECTOR (23 downto 0);
    signal redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_mem_reset0 : std_logic;
    signal redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_mem_ia : STD_LOGIC_VECTOR (23 downto 0);
    signal redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_mem_aa : STD_LOGIC_VECTOR (1 downto 0);
    signal redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_mem_ab : STD_LOGIC_VECTOR (1 downto 0);
    signal redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_mem_iq : STD_LOGIC_VECTOR (23 downto 0);
    signal redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_mem_q : STD_LOGIC_VECTOR (23 downto 0);
    signal redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_rdcnt_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_rdcnt_i : UNSIGNED (1 downto 0);
    attribute preserve : boolean;
    attribute preserve of redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_rdcnt_i : signal is true;
    signal redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_wraddr_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_mem_last_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_cmp_b : STD_LOGIC_VECTOR (2 downto 0);
    signal redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute dont_merge : boolean;
    attribute dont_merge of redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_sticky_ena_q : signal is true;
    signal redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist19_fracValue_uid215_block_rsrvd_fix_b_3_inputreg_q : STD_LOGIC_VECTOR (51 downto 0);
    signal redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_inputreg_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_outputreg_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_mem_reset0 : std_logic;
    signal redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_mem_ia : STD_LOGIC_VECTOR (52 downto 0);
    signal redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_mem_aa : STD_LOGIC_VECTOR (1 downto 0);
    signal redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_mem_ab : STD_LOGIC_VECTOR (1 downto 0);
    signal redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_mem_iq : STD_LOGIC_VECTOR (52 downto 0);
    signal redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_mem_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_rdcnt_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_rdcnt_i : UNSIGNED (1 downto 0);
    attribute preserve of redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_rdcnt_i : signal is true;
    signal redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_rdcnt_eq : std_logic;
    attribute preserve of redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_rdcnt_eq : signal is true;
    signal redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_wraddr_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_mem_last_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute dont_merge of redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_sticky_ena_q : signal is true;
    signal redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_inputreg_q : STD_LOGIC_VECTOR (55 downto 0);
    signal redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_outputreg_q : STD_LOGIC_VECTOR (55 downto 0);
    signal redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_mem_reset0 : std_logic;
    signal redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_mem_ia : STD_LOGIC_VECTOR (55 downto 0);
    signal redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_mem_aa : STD_LOGIC_VECTOR (1 downto 0);
    signal redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_mem_ab : STD_LOGIC_VECTOR (1 downto 0);
    signal redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_mem_iq : STD_LOGIC_VECTOR (55 downto 0);
    signal redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_mem_q : STD_LOGIC_VECTOR (55 downto 0);
    signal redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_rdcnt_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_rdcnt_i : UNSIGNED (1 downto 0);
    attribute preserve of redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_rdcnt_i : signal is true;
    signal redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_wraddr_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_mem_last_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_cmp_b : STD_LOGIC_VECTOR (2 downto 0);
    signal redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute dont_merge of redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_sticky_ena_q : signal is true;
    signal redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist69_frac_aSig_uid23_block_rsrvd_fix_b_4_inputreg_q : STD_LOGIC_VECTOR (51 downto 0);
    signal redist69_frac_aSig_uid23_block_rsrvd_fix_b_4_outputreg_q : STD_LOGIC_VECTOR (51 downto 0);
    signal redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_inputreg_q : STD_LOGIC_VECTOR (10 downto 0);
    signal redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_outputreg_q : STD_LOGIC_VECTOR (10 downto 0);
    signal redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_mem_reset0 : std_logic;
    signal redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_mem_ia : STD_LOGIC_VECTOR (10 downto 0);
    signal redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_mem_aa : STD_LOGIC_VECTOR (1 downto 0);
    signal redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_mem_ab : STD_LOGIC_VECTOR (1 downto 0);
    signal redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_mem_iq : STD_LOGIC_VECTOR (10 downto 0);
    signal redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_mem_q : STD_LOGIC_VECTOR (10 downto 0);
    signal redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_rdcnt_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_rdcnt_i : UNSIGNED (1 downto 0);
    attribute preserve of redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_rdcnt_i : signal is true;
    signal redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_rdcnt_eq : std_logic;
    attribute preserve of redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_rdcnt_eq : signal is true;
    signal redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_wraddr_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_mem_last_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute dont_merge of redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_sticky_ena_q : signal is true;
    signal redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- cAmA_uid120_block_rsrvd_fix(CONSTANT,119)
    cAmA_uid120_block_rsrvd_fix_q <= "111000";

    -- zs_uid255_countValue_closePathZ_uid94_block_rsrvd_fix(CONSTANT,254)
    zs_uid255_countValue_closePathZ_uid94_block_rsrvd_fix_q <= "00000000000000000000000000000000";

    -- xMSB_uid82_block_rsrvd_fix(BITSELECT,81)@5
    xMSB_uid82_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(oFracBREXC2S_uid79_block_rsrvd_fix_b(55 downto 55));

    -- redist73_in_1_in_1_1(DELAY,509)
    redist73_in_1_in_1_1 : dspba_delay
    GENERIC MAP ( width => 64, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => in_1, xout => redist73_in_1_in_1_1_q, clk => clock, aclr => resetn );

    -- sigY_uid10_block_rsrvd_fix(BITSELECT,9)@1
    sigY_uid10_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(redist73_in_1_in_1_1_q(63 downto 63));

    -- expY_uid12_block_rsrvd_fix(BITSELECT,11)@1
    expY_uid12_block_rsrvd_fix_b <= redist73_in_1_in_1_1_q(62 downto 52);

    -- fracY_uid11_block_rsrvd_fix(BITSELECT,10)@1
    fracY_uid11_block_rsrvd_fix_b <= redist73_in_1_in_1_1_q(51 downto 0);

    -- ypn_uid13_block_rsrvd_fix(BITJOIN,12)@1
    ypn_uid13_block_rsrvd_fix_q <= sigY_uid10_block_rsrvd_fix_b & expY_uid12_block_rsrvd_fix_b & fracY_uid11_block_rsrvd_fix_b;

    -- redist74_in_0_in_0_1(DELAY,510)
    redist74_in_0_in_0_1 : dspba_delay
    GENERIC MAP ( width => 64, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => in_0, xout => redist74_in_0_in_0_1_q, clk => clock, aclr => resetn );

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- expFracY_uid8_block_rsrvd_fix(BITSELECT,7)@0
    expFracY_uid8_block_rsrvd_fix_b <= in_1(62 downto 0);

    -- expFracX_uid7_block_rsrvd_fix(BITSELECT,6)@0
    expFracX_uid7_block_rsrvd_fix_b <= in_0(62 downto 0);

    -- xGTEy_uid9_block_rsrvd_fix(COMPARE,8)@0 + 1
    xGTEy_uid9_block_rsrvd_fix_a <= STD_LOGIC_VECTOR("00" & expFracX_uid7_block_rsrvd_fix_b);
    xGTEy_uid9_block_rsrvd_fix_b <= STD_LOGIC_VECTOR("00" & expFracY_uid8_block_rsrvd_fix_b);
    xGTEy_uid9_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            xGTEy_uid9_block_rsrvd_fix_o <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            xGTEy_uid9_block_rsrvd_fix_o <= STD_LOGIC_VECTOR(UNSIGNED(xGTEy_uid9_block_rsrvd_fix_a) - UNSIGNED(xGTEy_uid9_block_rsrvd_fix_b));
        END IF;
    END PROCESS;
    xGTEy_uid9_block_rsrvd_fix_n(0) <= not (xGTEy_uid9_block_rsrvd_fix_o(64));

    -- bSig_uid18_block_rsrvd_fix(MUX,17)@1
    bSig_uid18_block_rsrvd_fix_s <= xGTEy_uid9_block_rsrvd_fix_n;
    bSig_uid18_block_rsrvd_fix_combproc: PROCESS (bSig_uid18_block_rsrvd_fix_s, redist74_in_0_in_0_1_q, ypn_uid13_block_rsrvd_fix_q)
    BEGIN
        CASE (bSig_uid18_block_rsrvd_fix_s) IS
            WHEN "0" => bSig_uid18_block_rsrvd_fix_q <= redist74_in_0_in_0_1_q;
            WHEN "1" => bSig_uid18_block_rsrvd_fix_q <= ypn_uid13_block_rsrvd_fix_q;
            WHEN OTHERS => bSig_uid18_block_rsrvd_fix_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- sigB_uid58_block_rsrvd_fix(BITSELECT,57)@1
    sigB_uid58_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(bSig_uid18_block_rsrvd_fix_q(63 downto 63));

    -- redist45_sigB_uid58_block_rsrvd_fix_b_2(DELAY,481)
    redist45_sigB_uid58_block_rsrvd_fix_b_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => sigB_uid58_block_rsrvd_fix_b, xout => redist45_sigB_uid58_block_rsrvd_fix_b_2_q, clk => clock, aclr => resetn );

    -- aSig_uid17_block_rsrvd_fix(MUX,16)@1 + 1
    aSig_uid17_block_rsrvd_fix_s <= xGTEy_uid9_block_rsrvd_fix_n;
    aSig_uid17_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            aSig_uid17_block_rsrvd_fix_q <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            CASE (aSig_uid17_block_rsrvd_fix_s) IS
                WHEN "0" => aSig_uid17_block_rsrvd_fix_q <= ypn_uid13_block_rsrvd_fix_q;
                WHEN "1" => aSig_uid17_block_rsrvd_fix_q <= redist74_in_0_in_0_1_q;
                WHEN OTHERS => aSig_uid17_block_rsrvd_fix_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- sigA_uid57_block_rsrvd_fix(BITSELECT,56)@2
    sigA_uid57_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(aSig_uid17_block_rsrvd_fix_q(63 downto 63));

    -- redist47_sigA_uid57_block_rsrvd_fix_b_1(DELAY,483)
    redist47_sigA_uid57_block_rsrvd_fix_b_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => sigA_uid57_block_rsrvd_fix_b, xout => redist47_sigA_uid57_block_rsrvd_fix_b_1_q, clk => clock, aclr => resetn );

    -- effSub_uid59_block_rsrvd_fix(LOGICAL,58)@3
    effSub_uid59_block_rsrvd_fix_q <= redist47_sigA_uid57_block_rsrvd_fix_b_1_q xor redist45_sigB_uid58_block_rsrvd_fix_b_2_q;

    -- redist42_effSub_uid59_block_rsrvd_fix_q_1(DELAY,478)
    redist42_effSub_uid59_block_rsrvd_fix_q_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => effSub_uid59_block_rsrvd_fix_q, xout => redist42_effSub_uid59_block_rsrvd_fix_q_1_q, clk => clock, aclr => resetn );

    -- cstAllZWE_uid21_block_rsrvd_fix(CONSTANT,20)
    cstAllZWE_uid21_block_rsrvd_fix_q <= "00000000000";

    -- exp_bSig_uid39_block_rsrvd_fix(BITSELECT,38)@1
    exp_bSig_uid39_block_rsrvd_fix_in <= bSig_uid18_block_rsrvd_fix_q(62 downto 0);
    exp_bSig_uid39_block_rsrvd_fix_b <= exp_bSig_uid39_block_rsrvd_fix_in(62 downto 52);

    -- redist58_exp_bSig_uid39_block_rsrvd_fix_b_1(DELAY,494)
    redist58_exp_bSig_uid39_block_rsrvd_fix_b_1 : dspba_delay
    GENERIC MAP ( width => 11, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => exp_bSig_uid39_block_rsrvd_fix_b, xout => redist58_exp_bSig_uid39_block_rsrvd_fix_b_1_q, clk => clock, aclr => resetn );

    -- expXIsZero_uid41_block_rsrvd_fix(LOGICAL,40)@2 + 1
    expXIsZero_uid41_block_rsrvd_fix_qi <= "1" WHEN redist58_exp_bSig_uid39_block_rsrvd_fix_b_1_q = cstAllZWE_uid21_block_rsrvd_fix_q ELSE "0";
    expXIsZero_uid41_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => expXIsZero_uid41_block_rsrvd_fix_qi, xout => expXIsZero_uid41_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- InvExpXIsZero_uid49_block_rsrvd_fix(LOGICAL,48)@3
    InvExpXIsZero_uid49_block_rsrvd_fix_q <= not (expXIsZero_uid41_block_rsrvd_fix_q);

    -- cstZeroWF_uid20_block_rsrvd_fix(CONSTANT,19)
    cstZeroWF_uid20_block_rsrvd_fix_q <= "0000000000000000000000000000000000000000000000000000";

    -- frac_bSig_uid40_block_rsrvd_fix(BITSELECT,39)@1
    frac_bSig_uid40_block_rsrvd_fix_in <= bSig_uid18_block_rsrvd_fix_q(51 downto 0);
    frac_bSig_uid40_block_rsrvd_fix_b <= frac_bSig_uid40_block_rsrvd_fix_in(51 downto 0);

    -- redist57_frac_bSig_uid40_block_rsrvd_fix_b_2(DELAY,493)
    redist57_frac_bSig_uid40_block_rsrvd_fix_b_2 : dspba_delay
    GENERIC MAP ( width => 52, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => frac_bSig_uid40_block_rsrvd_fix_b, xout => redist57_frac_bSig_uid40_block_rsrvd_fix_b_2_q, clk => clock, aclr => resetn );

    -- c0_uid293_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select(BITSELECT,426)
    c0_uid293_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_b <= cstZeroWF_uid20_block_rsrvd_fix_q(5 downto 0);
    c0_uid293_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_c <= cstZeroWF_uid20_block_rsrvd_fix_q(11 downto 6);
    c0_uid293_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_d <= cstZeroWF_uid20_block_rsrvd_fix_q(17 downto 12);
    c0_uid293_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_e <= cstZeroWF_uid20_block_rsrvd_fix_q(23 downto 18);
    c0_uid293_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_f <= cstZeroWF_uid20_block_rsrvd_fix_q(29 downto 24);
    c0_uid293_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_g <= cstZeroWF_uid20_block_rsrvd_fix_q(35 downto 30);
    c0_uid293_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_h <= cstZeroWF_uid20_block_rsrvd_fix_q(41 downto 36);
    c0_uid293_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_i <= cstZeroWF_uid20_block_rsrvd_fix_q(47 downto 42);
    c0_uid293_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_j <= cstZeroWF_uid20_block_rsrvd_fix_q(51 downto 48);

    -- z0_uid322_fracXIsZero_uid43_block_rsrvd_fix_merged_bit_select(BITSELECT,428)@1
    z0_uid322_fracXIsZero_uid43_block_rsrvd_fix_merged_bit_select_b <= frac_bSig_uid40_block_rsrvd_fix_b(5 downto 0);
    z0_uid322_fracXIsZero_uid43_block_rsrvd_fix_merged_bit_select_c <= frac_bSig_uid40_block_rsrvd_fix_b(11 downto 6);
    z0_uid322_fracXIsZero_uid43_block_rsrvd_fix_merged_bit_select_d <= frac_bSig_uid40_block_rsrvd_fix_b(17 downto 12);
    z0_uid322_fracXIsZero_uid43_block_rsrvd_fix_merged_bit_select_e <= frac_bSig_uid40_block_rsrvd_fix_b(23 downto 18);
    z0_uid322_fracXIsZero_uid43_block_rsrvd_fix_merged_bit_select_f <= frac_bSig_uid40_block_rsrvd_fix_b(29 downto 24);
    z0_uid322_fracXIsZero_uid43_block_rsrvd_fix_merged_bit_select_g <= frac_bSig_uid40_block_rsrvd_fix_b(35 downto 30);
    z0_uid322_fracXIsZero_uid43_block_rsrvd_fix_merged_bit_select_h <= frac_bSig_uid40_block_rsrvd_fix_b(41 downto 36);
    z0_uid322_fracXIsZero_uid43_block_rsrvd_fix_merged_bit_select_i <= frac_bSig_uid40_block_rsrvd_fix_b(47 downto 42);
    z0_uid322_fracXIsZero_uid43_block_rsrvd_fix_merged_bit_select_j <= frac_bSig_uid40_block_rsrvd_fix_b(51 downto 48);

    -- eq8_uid348_fracXIsZero_uid43_block_rsrvd_fix(LOGICAL,347)@1 + 1
    eq8_uid348_fracXIsZero_uid43_block_rsrvd_fix_qi <= "1" WHEN z0_uid322_fracXIsZero_uid43_block_rsrvd_fix_merged_bit_select_j = c0_uid293_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_j ELSE "0";
    eq8_uid348_fracXIsZero_uid43_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => eq8_uid348_fracXIsZero_uid43_block_rsrvd_fix_qi, xout => eq8_uid348_fracXIsZero_uid43_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- eq7_uid345_fracXIsZero_uid43_block_rsrvd_fix(LOGICAL,344)@1 + 1
    eq7_uid345_fracXIsZero_uid43_block_rsrvd_fix_qi <= "1" WHEN z0_uid322_fracXIsZero_uid43_block_rsrvd_fix_merged_bit_select_i = c0_uid293_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_i ELSE "0";
    eq7_uid345_fracXIsZero_uid43_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => eq7_uid345_fracXIsZero_uid43_block_rsrvd_fix_qi, xout => eq7_uid345_fracXIsZero_uid43_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- eq6_uid342_fracXIsZero_uid43_block_rsrvd_fix(LOGICAL,341)@1 + 1
    eq6_uid342_fracXIsZero_uid43_block_rsrvd_fix_qi <= "1" WHEN z0_uid322_fracXIsZero_uid43_block_rsrvd_fix_merged_bit_select_h = c0_uid293_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_h ELSE "0";
    eq6_uid342_fracXIsZero_uid43_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => eq6_uid342_fracXIsZero_uid43_block_rsrvd_fix_qi, xout => eq6_uid342_fracXIsZero_uid43_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- and_lev0_uid350_fracXIsZero_uid43_block_rsrvd_fix(LOGICAL,349)@2
    and_lev0_uid350_fracXIsZero_uid43_block_rsrvd_fix_q <= eq6_uid342_fracXIsZero_uid43_block_rsrvd_fix_q and eq7_uid345_fracXIsZero_uid43_block_rsrvd_fix_q and eq8_uid348_fracXIsZero_uid43_block_rsrvd_fix_q;

    -- eq5_uid339_fracXIsZero_uid43_block_rsrvd_fix(LOGICAL,338)@1 + 1
    eq5_uid339_fracXIsZero_uid43_block_rsrvd_fix_qi <= "1" WHEN z0_uid322_fracXIsZero_uid43_block_rsrvd_fix_merged_bit_select_g = c0_uid293_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_g ELSE "0";
    eq5_uid339_fracXIsZero_uid43_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => eq5_uid339_fracXIsZero_uid43_block_rsrvd_fix_qi, xout => eq5_uid339_fracXIsZero_uid43_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- eq4_uid336_fracXIsZero_uid43_block_rsrvd_fix(LOGICAL,335)@1 + 1
    eq4_uid336_fracXIsZero_uid43_block_rsrvd_fix_qi <= "1" WHEN z0_uid322_fracXIsZero_uid43_block_rsrvd_fix_merged_bit_select_f = c0_uid293_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_f ELSE "0";
    eq4_uid336_fracXIsZero_uid43_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => eq4_uid336_fracXIsZero_uid43_block_rsrvd_fix_qi, xout => eq4_uid336_fracXIsZero_uid43_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- eq3_uid333_fracXIsZero_uid43_block_rsrvd_fix(LOGICAL,332)@1 + 1
    eq3_uid333_fracXIsZero_uid43_block_rsrvd_fix_qi <= "1" WHEN z0_uid322_fracXIsZero_uid43_block_rsrvd_fix_merged_bit_select_e = c0_uid293_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_e ELSE "0";
    eq3_uid333_fracXIsZero_uid43_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => eq3_uid333_fracXIsZero_uid43_block_rsrvd_fix_qi, xout => eq3_uid333_fracXIsZero_uid43_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- eq2_uid330_fracXIsZero_uid43_block_rsrvd_fix(LOGICAL,329)@1 + 1
    eq2_uid330_fracXIsZero_uid43_block_rsrvd_fix_qi <= "1" WHEN z0_uid322_fracXIsZero_uid43_block_rsrvd_fix_merged_bit_select_d = c0_uid293_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_d ELSE "0";
    eq2_uid330_fracXIsZero_uid43_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => eq2_uid330_fracXIsZero_uid43_block_rsrvd_fix_qi, xout => eq2_uid330_fracXIsZero_uid43_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- eq1_uid327_fracXIsZero_uid43_block_rsrvd_fix(LOGICAL,326)@1 + 1
    eq1_uid327_fracXIsZero_uid43_block_rsrvd_fix_qi <= "1" WHEN z0_uid322_fracXIsZero_uid43_block_rsrvd_fix_merged_bit_select_c = c0_uid293_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_c ELSE "0";
    eq1_uid327_fracXIsZero_uid43_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => eq1_uid327_fracXIsZero_uid43_block_rsrvd_fix_qi, xout => eq1_uid327_fracXIsZero_uid43_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- eq0_uid324_fracXIsZero_uid43_block_rsrvd_fix(LOGICAL,323)@1 + 1
    eq0_uid324_fracXIsZero_uid43_block_rsrvd_fix_qi <= "1" WHEN z0_uid322_fracXIsZero_uid43_block_rsrvd_fix_merged_bit_select_b = c0_uid293_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_b ELSE "0";
    eq0_uid324_fracXIsZero_uid43_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => eq0_uid324_fracXIsZero_uid43_block_rsrvd_fix_qi, xout => eq0_uid324_fracXIsZero_uid43_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- and_lev0_uid349_fracXIsZero_uid43_block_rsrvd_fix(LOGICAL,348)@2
    and_lev0_uid349_fracXIsZero_uid43_block_rsrvd_fix_q <= eq0_uid324_fracXIsZero_uid43_block_rsrvd_fix_q and eq1_uid327_fracXIsZero_uid43_block_rsrvd_fix_q and eq2_uid330_fracXIsZero_uid43_block_rsrvd_fix_q and eq3_uid333_fracXIsZero_uid43_block_rsrvd_fix_q and eq4_uid336_fracXIsZero_uid43_block_rsrvd_fix_q and eq5_uid339_fracXIsZero_uid43_block_rsrvd_fix_q;

    -- and_lev1_uid351_fracXIsZero_uid43_block_rsrvd_fix(LOGICAL,350)@2 + 1
    and_lev1_uid351_fracXIsZero_uid43_block_rsrvd_fix_qi <= and_lev0_uid349_fracXIsZero_uid43_block_rsrvd_fix_q and and_lev0_uid350_fracXIsZero_uid43_block_rsrvd_fix_q;
    and_lev1_uid351_fracXIsZero_uid43_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => and_lev1_uid351_fracXIsZero_uid43_block_rsrvd_fix_qi, xout => and_lev1_uid351_fracXIsZero_uid43_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- excZ_bSig_uid45_block_rsrvd_fix(LOGICAL,44)@3
    excZ_bSig_uid45_block_rsrvd_fix_q <= expXIsZero_uid41_block_rsrvd_fix_q and and_lev1_uid351_fracXIsZero_uid43_block_rsrvd_fix_q;

    -- fracBz_uid63_block_rsrvd_fix(MUX,62)@3
    fracBz_uid63_block_rsrvd_fix_s <= excZ_bSig_uid45_block_rsrvd_fix_q;
    fracBz_uid63_block_rsrvd_fix_combproc: PROCESS (fracBz_uid63_block_rsrvd_fix_s, redist57_frac_bSig_uid40_block_rsrvd_fix_b_2_q, cstZeroWF_uid20_block_rsrvd_fix_q)
    BEGIN
        CASE (fracBz_uid63_block_rsrvd_fix_s) IS
            WHEN "0" => fracBz_uid63_block_rsrvd_fix_q <= redist57_frac_bSig_uid40_block_rsrvd_fix_b_2_q;
            WHEN "1" => fracBz_uid63_block_rsrvd_fix_q <= cstZeroWF_uid20_block_rsrvd_fix_q;
            WHEN OTHERS => fracBz_uid63_block_rsrvd_fix_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- oFracB_uid67_block_rsrvd_fix(BITJOIN,66)@3
    oFracB_uid67_block_rsrvd_fix_q <= InvExpXIsZero_uid49_block_rsrvd_fix_q & fracBz_uid63_block_rsrvd_fix_q;

    -- oFracBR_uid76_block_rsrvd_fix(BITJOIN,75)@3
    oFracBR_uid76_block_rsrvd_fix_q <= GND_q & oFracB_uid67_block_rsrvd_fix_q & GND_q & GND_q;

    -- oFracBREX_uid77_block_rsrvd_fix(LOGICAL,76)@3 + 1
    oFracBREX_uid77_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((55 downto 1 => effSub_uid59_block_rsrvd_fix_q(0)) & effSub_uid59_block_rsrvd_fix_q));
    oFracBREX_uid77_block_rsrvd_fix_qi <= oFracBR_uid76_block_rsrvd_fix_q xor oFracBREX_uid77_block_rsrvd_fix_b;
    oFracBREX_uid77_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 56, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => oFracBREX_uid77_block_rsrvd_fix_qi, xout => oFracBREX_uid77_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- oFracBREXC2_uid78_block_rsrvd_fix(ADD,77)@4 + 1
    oFracBREXC2_uid78_block_rsrvd_fix_a <= STD_LOGIC_VECTOR("0" & oFracBREX_uid77_block_rsrvd_fix_q);
    oFracBREXC2_uid78_block_rsrvd_fix_b <= STD_LOGIC_VECTOR("00000000000000000000000000000000000000000000000000000000" & redist42_effSub_uid59_block_rsrvd_fix_q_1_q);
    oFracBREXC2_uid78_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            oFracBREXC2_uid78_block_rsrvd_fix_o <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            oFracBREXC2_uid78_block_rsrvd_fix_o <= STD_LOGIC_VECTOR(UNSIGNED(oFracBREXC2_uid78_block_rsrvd_fix_a) + UNSIGNED(oFracBREXC2_uid78_block_rsrvd_fix_b));
        END IF;
    END PROCESS;
    oFracBREXC2_uid78_block_rsrvd_fix_q <= oFracBREXC2_uid78_block_rsrvd_fix_o(56 downto 0);

    -- oFracBREXC2HighBits_uid81_block_rsrvd_fix(BITSELECT,80)@5
    oFracBREXC2HighBits_uid81_block_rsrvd_fix_in <= oFracBREXC2_uid78_block_rsrvd_fix_q(55 downto 0);
    oFracBREXC2HighBits_uid81_block_rsrvd_fix_b <= oFracBREXC2HighBits_uid81_block_rsrvd_fix_in(55 downto 1);

    -- fracBAlignLowCloseUR_uid84_block_rsrvd_fix(BITJOIN,83)@5
    fracBAlignLowCloseUR_uid84_block_rsrvd_fix_q <= xMSB_uid82_block_rsrvd_fix_b & oFracBREXC2HighBits_uid81_block_rsrvd_fix_b;

    -- oFracBREXC2S_uid79_block_rsrvd_fix(BITSELECT,78)@5
    oFracBREXC2S_uid79_block_rsrvd_fix_in <= STD_LOGIC_VECTOR(oFracBREXC2_uid78_block_rsrvd_fix_q(55 downto 0));
    oFracBREXC2S_uid79_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(oFracBREXC2S_uid79_block_rsrvd_fix_in(55 downto 0));

    -- fracXIsNotZero_uid44_block_rsrvd_fix(LOGICAL,43)@3
    fracXIsNotZero_uid44_block_rsrvd_fix_q <= not (and_lev1_uid351_fracXIsZero_uid43_block_rsrvd_fix_q);

    -- excS_bSig_uid51_block_rsrvd_fix(LOGICAL,50)@3
    excS_bSig_uid51_block_rsrvd_fix_q <= expXIsZero_uid41_block_rsrvd_fix_q and fracXIsNotZero_uid44_block_rsrvd_fix_q;

    -- frac_aSig_uid23_block_rsrvd_fix(BITSELECT,22)@2
    frac_aSig_uid23_block_rsrvd_fix_in <= aSig_uid17_block_rsrvd_fix_q(51 downto 0);
    frac_aSig_uid23_block_rsrvd_fix_b <= frac_aSig_uid23_block_rsrvd_fix_in(51 downto 0);

    -- z0_uid292_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select(BITSELECT,427)@2
    z0_uid292_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_b <= frac_aSig_uid23_block_rsrvd_fix_b(5 downto 0);
    z0_uid292_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_c <= frac_aSig_uid23_block_rsrvd_fix_b(11 downto 6);
    z0_uid292_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_d <= frac_aSig_uid23_block_rsrvd_fix_b(17 downto 12);
    z0_uid292_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_e <= frac_aSig_uid23_block_rsrvd_fix_b(23 downto 18);
    z0_uid292_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_f <= frac_aSig_uid23_block_rsrvd_fix_b(29 downto 24);
    z0_uid292_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_g <= frac_aSig_uid23_block_rsrvd_fix_b(35 downto 30);
    z0_uid292_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_h <= frac_aSig_uid23_block_rsrvd_fix_b(41 downto 36);
    z0_uid292_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_i <= frac_aSig_uid23_block_rsrvd_fix_b(47 downto 42);
    z0_uid292_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_j <= frac_aSig_uid23_block_rsrvd_fix_b(51 downto 48);

    -- eq8_uid318_fracXIsZero_uid26_block_rsrvd_fix(LOGICAL,317)@2
    eq8_uid318_fracXIsZero_uid26_block_rsrvd_fix_q <= "1" WHEN z0_uid292_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_j = c0_uid293_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_j ELSE "0";

    -- eq7_uid315_fracXIsZero_uid26_block_rsrvd_fix(LOGICAL,314)@2
    eq7_uid315_fracXIsZero_uid26_block_rsrvd_fix_q <= "1" WHEN z0_uid292_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_i = c0_uid293_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_i ELSE "0";

    -- eq6_uid312_fracXIsZero_uid26_block_rsrvd_fix(LOGICAL,311)@2
    eq6_uid312_fracXIsZero_uid26_block_rsrvd_fix_q <= "1" WHEN z0_uid292_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_h = c0_uid293_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_h ELSE "0";

    -- and_lev0_uid320_fracXIsZero_uid26_block_rsrvd_fix(LOGICAL,319)@2 + 1
    and_lev0_uid320_fracXIsZero_uid26_block_rsrvd_fix_qi <= eq6_uid312_fracXIsZero_uid26_block_rsrvd_fix_q and eq7_uid315_fracXIsZero_uid26_block_rsrvd_fix_q and eq8_uid318_fracXIsZero_uid26_block_rsrvd_fix_q;
    and_lev0_uid320_fracXIsZero_uid26_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => and_lev0_uid320_fracXIsZero_uid26_block_rsrvd_fix_qi, xout => and_lev0_uid320_fracXIsZero_uid26_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- eq5_uid309_fracXIsZero_uid26_block_rsrvd_fix(LOGICAL,308)@2
    eq5_uid309_fracXIsZero_uid26_block_rsrvd_fix_q <= "1" WHEN z0_uid292_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_g = c0_uid293_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_g ELSE "0";

    -- eq4_uid306_fracXIsZero_uid26_block_rsrvd_fix(LOGICAL,305)@2
    eq4_uid306_fracXIsZero_uid26_block_rsrvd_fix_q <= "1" WHEN z0_uid292_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_f = c0_uid293_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_f ELSE "0";

    -- eq3_uid303_fracXIsZero_uid26_block_rsrvd_fix(LOGICAL,302)@2
    eq3_uid303_fracXIsZero_uid26_block_rsrvd_fix_q <= "1" WHEN z0_uid292_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_e = c0_uid293_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_e ELSE "0";

    -- eq2_uid300_fracXIsZero_uid26_block_rsrvd_fix(LOGICAL,299)@2
    eq2_uid300_fracXIsZero_uid26_block_rsrvd_fix_q <= "1" WHEN z0_uid292_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_d = c0_uid293_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_d ELSE "0";

    -- eq1_uid297_fracXIsZero_uid26_block_rsrvd_fix(LOGICAL,296)@2
    eq1_uid297_fracXIsZero_uid26_block_rsrvd_fix_q <= "1" WHEN z0_uid292_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_c = c0_uid293_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_c ELSE "0";

    -- eq0_uid294_fracXIsZero_uid26_block_rsrvd_fix(LOGICAL,293)@2
    eq0_uid294_fracXIsZero_uid26_block_rsrvd_fix_q <= "1" WHEN z0_uid292_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_b = c0_uid293_fracXIsZero_uid26_block_rsrvd_fix_merged_bit_select_b ELSE "0";

    -- and_lev0_uid319_fracXIsZero_uid26_block_rsrvd_fix(LOGICAL,318)@2 + 1
    and_lev0_uid319_fracXIsZero_uid26_block_rsrvd_fix_qi <= eq0_uid294_fracXIsZero_uid26_block_rsrvd_fix_q and eq1_uid297_fracXIsZero_uid26_block_rsrvd_fix_q and eq2_uid300_fracXIsZero_uid26_block_rsrvd_fix_q and eq3_uid303_fracXIsZero_uid26_block_rsrvd_fix_q and eq4_uid306_fracXIsZero_uid26_block_rsrvd_fix_q and eq5_uid309_fracXIsZero_uid26_block_rsrvd_fix_q;
    and_lev0_uid319_fracXIsZero_uid26_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => and_lev0_uid319_fracXIsZero_uid26_block_rsrvd_fix_qi, xout => and_lev0_uid319_fracXIsZero_uid26_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- and_lev1_uid321_fracXIsZero_uid26_block_rsrvd_fix(LOGICAL,320)@3
    and_lev1_uid321_fracXIsZero_uid26_block_rsrvd_fix_q <= and_lev0_uid319_fracXIsZero_uid26_block_rsrvd_fix_q and and_lev0_uid320_fracXIsZero_uid26_block_rsrvd_fix_q;

    -- fracXIsNotZero_uid27_block_rsrvd_fix(LOGICAL,26)@3
    fracXIsNotZero_uid27_block_rsrvd_fix_q <= not (and_lev1_uid321_fracXIsZero_uid26_block_rsrvd_fix_q);

    -- exp_aSig_uid22_block_rsrvd_fix(BITSELECT,21)@2
    exp_aSig_uid22_block_rsrvd_fix_in <= aSig_uid17_block_rsrvd_fix_q(62 downto 0);
    exp_aSig_uid22_block_rsrvd_fix_b <= exp_aSig_uid22_block_rsrvd_fix_in(62 downto 52);

    -- expXIsZero_uid24_block_rsrvd_fix(LOGICAL,23)@2 + 1
    expXIsZero_uid24_block_rsrvd_fix_qi <= "1" WHEN exp_aSig_uid22_block_rsrvd_fix_b = cstAllZWE_uid21_block_rsrvd_fix_q ELSE "0";
    expXIsZero_uid24_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => expXIsZero_uid24_block_rsrvd_fix_qi, xout => expXIsZero_uid24_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- excS_aSig_uid34_block_rsrvd_fix(LOGICAL,33)@3
    excS_aSig_uid34_block_rsrvd_fix_q <= expXIsZero_uid24_block_rsrvd_fix_q and fracXIsNotZero_uid27_block_rsrvd_fix_q;

    -- aIsNotASubnorm_uid87_block_rsrvd_fix(LOGICAL,86)@3
    aIsNotASubnorm_uid87_block_rsrvd_fix_q <= not (excS_aSig_uid34_block_rsrvd_fix_q);

    -- aNormalBSubnormal_uid88_block_rsrvd_fix(LOGICAL,87)@3 + 1
    aNormalBSubnormal_uid88_block_rsrvd_fix_qi <= aIsNotASubnorm_uid87_block_rsrvd_fix_q and excS_bSig_uid51_block_rsrvd_fix_q;
    aNormalBSubnormal_uid88_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => aNormalBSubnormal_uid88_block_rsrvd_fix_qi, xout => aNormalBSubnormal_uid88_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- aNormalBSubnromal_uid89_block_rsrvd_fix(LOGICAL,88)@4
    aNormalBSubnromal_uid89_block_rsrvd_fix_q <= not (aNormalBSubnormal_uid88_block_rsrvd_fix_q);

    -- expAmExpB_uid68_block_rsrvd_fix(SUB,67)@2 + 1
    expAmExpB_uid68_block_rsrvd_fix_a <= STD_LOGIC_VECTOR("0" & exp_aSig_uid22_block_rsrvd_fix_b);
    expAmExpB_uid68_block_rsrvd_fix_b <= STD_LOGIC_VECTOR("0" & redist58_exp_bSig_uid39_block_rsrvd_fix_b_1_q);
    expAmExpB_uid68_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            expAmExpB_uid68_block_rsrvd_fix_o <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            expAmExpB_uid68_block_rsrvd_fix_o <= STD_LOGIC_VECTOR(UNSIGNED(expAmExpB_uid68_block_rsrvd_fix_a) - UNSIGNED(expAmExpB_uid68_block_rsrvd_fix_b));
        END IF;
    END PROCESS;
    expAmExpB_uid68_block_rsrvd_fix_q <= expAmExpB_uid68_block_rsrvd_fix_o(11 downto 0);

    -- expAmExpBZ_uid86_block_rsrvd_fix(BITSELECT,85)@3
    expAmExpBZ_uid86_block_rsrvd_fix_in <= STD_LOGIC_VECTOR(expAmExpB_uid68_block_rsrvd_fix_q(0 downto 0));
    expAmExpBZ_uid86_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(expAmExpBZ_uid86_block_rsrvd_fix_in(0 downto 0));

    -- redist35_expAmExpBZ_uid86_block_rsrvd_fix_b_1(DELAY,471)
    redist35_expAmExpBZ_uid86_block_rsrvd_fix_b_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => expAmExpBZ_uid86_block_rsrvd_fix_b, xout => redist35_expAmExpBZ_uid86_block_rsrvd_fix_b_1_q, clk => clock, aclr => resetn );

    -- exponentDifferenceIsOneAndBNotSubnormal_uid90_block_rsrvd_fix(LOGICAL,89)@4 + 1
    exponentDifferenceIsOneAndBNotSubnormal_uid90_block_rsrvd_fix_qi <= redist35_expAmExpBZ_uid86_block_rsrvd_fix_b_1_q and aNormalBSubnromal_uid89_block_rsrvd_fix_q;
    exponentDifferenceIsOneAndBNotSubnormal_uid90_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => exponentDifferenceIsOneAndBNotSubnormal_uid90_block_rsrvd_fix_qi, xout => exponentDifferenceIsOneAndBNotSubnormal_uid90_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- oFracBREXC2SPostAlign_uid91_block_rsrvd_fix(MUX,90)@5 + 1
    oFracBREXC2SPostAlign_uid91_block_rsrvd_fix_s <= exponentDifferenceIsOneAndBNotSubnormal_uid90_block_rsrvd_fix_q;
    oFracBREXC2SPostAlign_uid91_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            oFracBREXC2SPostAlign_uid91_block_rsrvd_fix_q <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            CASE (oFracBREXC2SPostAlign_uid91_block_rsrvd_fix_s) IS
                WHEN "0" => oFracBREXC2SPostAlign_uid91_block_rsrvd_fix_q <= oFracBREXC2S_uid79_block_rsrvd_fix_b;
                WHEN "1" => oFracBREXC2SPostAlign_uid91_block_rsrvd_fix_q <= fracBAlignLowCloseUR_uid84_block_rsrvd_fix_q;
                WHEN OTHERS => oFracBREXC2SPostAlign_uid91_block_rsrvd_fix_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- redist67_expXIsZero_uid24_block_rsrvd_fix_q_4(DELAY,503)
    redist67_expXIsZero_uid24_block_rsrvd_fix_q_4 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => expXIsZero_uid24_block_rsrvd_fix_q, xout => redist67_expXIsZero_uid24_block_rsrvd_fix_q_4_q, clk => clock, aclr => resetn );

    -- InvExpXIsZero_uid32_block_rsrvd_fix(LOGICAL,31)@6
    InvExpXIsZero_uid32_block_rsrvd_fix_q <= not (redist67_expXIsZero_uid24_block_rsrvd_fix_q_4_q);

    -- redist69_frac_aSig_uid23_block_rsrvd_fix_b_4_inputreg(DELAY,548)
    redist69_frac_aSig_uid23_block_rsrvd_fix_b_4_inputreg : dspba_delay
    GENERIC MAP ( width => 52, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => frac_aSig_uid23_block_rsrvd_fix_b, xout => redist69_frac_aSig_uid23_block_rsrvd_fix_b_4_inputreg_q, clk => clock, aclr => resetn );

    -- redist69_frac_aSig_uid23_block_rsrvd_fix_b_4(DELAY,505)
    redist69_frac_aSig_uid23_block_rsrvd_fix_b_4 : dspba_delay
    GENERIC MAP ( width => 52, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist69_frac_aSig_uid23_block_rsrvd_fix_b_4_inputreg_q, xout => redist69_frac_aSig_uid23_block_rsrvd_fix_b_4_q, clk => clock, aclr => resetn );

    -- redist69_frac_aSig_uid23_block_rsrvd_fix_b_4_outputreg(DELAY,549)
    redist69_frac_aSig_uid23_block_rsrvd_fix_b_4_outputreg : dspba_delay
    GENERIC MAP ( width => 52, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist69_frac_aSig_uid23_block_rsrvd_fix_b_4_q, xout => redist69_frac_aSig_uid23_block_rsrvd_fix_b_4_outputreg_q, clk => clock, aclr => resetn );

    -- oFracA_uid65_block_rsrvd_fix(BITJOIN,64)@6
    oFracA_uid65_block_rsrvd_fix_q <= InvExpXIsZero_uid32_block_rsrvd_fix_q & redist69_frac_aSig_uid23_block_rsrvd_fix_b_4_outputreg_q;

    -- oFracAE_uid74_block_rsrvd_fix(BITJOIN,73)@6
    oFracAE_uid74_block_rsrvd_fix_q <= GND_q & oFracA_uid65_block_rsrvd_fix_q & GND_q & GND_q;

    -- fracAddResult_closePath_uid92_block_rsrvd_fix(ADD,91)@6
    fracAddResult_closePath_uid92_block_rsrvd_fix_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((56 downto 56 => oFracAE_uid74_block_rsrvd_fix_q(55)) & oFracAE_uid74_block_rsrvd_fix_q));
    fracAddResult_closePath_uid92_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((56 downto 56 => oFracBREXC2SPostAlign_uid91_block_rsrvd_fix_q(55)) & oFracBREXC2SPostAlign_uid91_block_rsrvd_fix_q));
    fracAddResult_closePath_uid92_block_rsrvd_fix_o <= STD_LOGIC_VECTOR(SIGNED(fracAddResult_closePath_uid92_block_rsrvd_fix_a) + SIGNED(fracAddResult_closePath_uid92_block_rsrvd_fix_b));
    fracAddResult_closePath_uid92_block_rsrvd_fix_q <= fracAddResult_closePath_uid92_block_rsrvd_fix_o(56 downto 0);

    -- fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix(BITSELECT,92)@6
    fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_in <= fracAddResult_closePath_uid92_block_rsrvd_fix_q(55 downto 0);
    fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b <= fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_in(55 downto 0);

    -- redist33_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_1(DELAY,469)
    redist33_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_1 : dspba_delay
    GENERIC MAP ( width => 56, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b, xout => redist33_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_1_q, clk => clock, aclr => resetn );

    -- rVStage_uid256_countValue_closePathZ_uid94_block_rsrvd_fix(BITSELECT,255)@7
    rVStage_uid256_countValue_closePathZ_uid94_block_rsrvd_fix_b <= redist33_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_1_q(55 downto 24);

    -- vCount_uid257_countValue_closePathZ_uid94_block_rsrvd_fix(LOGICAL,256)@7
    vCount_uid257_countValue_closePathZ_uid94_block_rsrvd_fix_q <= "1" WHEN rVStage_uid256_countValue_closePathZ_uid94_block_rsrvd_fix_b = zs_uid255_countValue_closePathZ_uid94_block_rsrvd_fix_q ELSE "0";

    -- redist12_vCount_uid257_countValue_closePathZ_uid94_block_rsrvd_fix_q_4(DELAY,448)
    redist12_vCount_uid257_countValue_closePathZ_uid94_block_rsrvd_fix_q_4 : dspba_delay
    GENERIC MAP ( width => 1, depth => 4, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => vCount_uid257_countValue_closePathZ_uid94_block_rsrvd_fix_q, xout => redist12_vCount_uid257_countValue_closePathZ_uid94_block_rsrvd_fix_q_4_q, clk => clock, aclr => resetn );

    -- zs_uid263_countValue_closePathZ_uid94_block_rsrvd_fix(CONSTANT,262)
    zs_uid263_countValue_closePathZ_uid94_block_rsrvd_fix_q <= "0000000000000000";

    -- vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix(BITSELECT,258)@7
    vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_in <= redist33_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_1_q(23 downto 0);
    vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b <= vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_in(23 downto 0);

    -- mO_uid258_countValue_closePathZ_uid94_block_rsrvd_fix(CONSTANT,257)
    mO_uid258_countValue_closePathZ_uid94_block_rsrvd_fix_q <= "11111111";

    -- cStage_uid260_countValue_closePathZ_uid94_block_rsrvd_fix(BITJOIN,259)@7
    cStage_uid260_countValue_closePathZ_uid94_block_rsrvd_fix_q <= vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b & mO_uid258_countValue_closePathZ_uid94_block_rsrvd_fix_q;

    -- vStagei_uid262_countValue_closePathZ_uid94_block_rsrvd_fix(MUX,261)@7 + 1
    vStagei_uid262_countValue_closePathZ_uid94_block_rsrvd_fix_s <= vCount_uid257_countValue_closePathZ_uid94_block_rsrvd_fix_q;
    vStagei_uid262_countValue_closePathZ_uid94_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            vStagei_uid262_countValue_closePathZ_uid94_block_rsrvd_fix_q <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            CASE (vStagei_uid262_countValue_closePathZ_uid94_block_rsrvd_fix_s) IS
                WHEN "0" => vStagei_uid262_countValue_closePathZ_uid94_block_rsrvd_fix_q <= rVStage_uid256_countValue_closePathZ_uid94_block_rsrvd_fix_b;
                WHEN "1" => vStagei_uid262_countValue_closePathZ_uid94_block_rsrvd_fix_q <= cStage_uid260_countValue_closePathZ_uid94_block_rsrvd_fix_q;
                WHEN OTHERS => vStagei_uid262_countValue_closePathZ_uid94_block_rsrvd_fix_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- rVStage_uid264_countValue_closePathZ_uid94_block_rsrvd_fix_merged_bit_select(BITSELECT,432)@8
    rVStage_uid264_countValue_closePathZ_uid94_block_rsrvd_fix_merged_bit_select_b <= vStagei_uid262_countValue_closePathZ_uid94_block_rsrvd_fix_q(31 downto 16);
    rVStage_uid264_countValue_closePathZ_uid94_block_rsrvd_fix_merged_bit_select_c <= vStagei_uid262_countValue_closePathZ_uid94_block_rsrvd_fix_q(15 downto 0);

    -- vCount_uid265_countValue_closePathZ_uid94_block_rsrvd_fix(LOGICAL,264)@8
    vCount_uid265_countValue_closePathZ_uid94_block_rsrvd_fix_q <= "1" WHEN rVStage_uid264_countValue_closePathZ_uid94_block_rsrvd_fix_merged_bit_select_b = zs_uid263_countValue_closePathZ_uid94_block_rsrvd_fix_q ELSE "0";

    -- redist10_vCount_uid265_countValue_closePathZ_uid94_block_rsrvd_fix_q_3(DELAY,446)
    redist10_vCount_uid265_countValue_closePathZ_uid94_block_rsrvd_fix_q_3 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => vCount_uid265_countValue_closePathZ_uid94_block_rsrvd_fix_q, xout => redist10_vCount_uid265_countValue_closePathZ_uid94_block_rsrvd_fix_q_3_q, clk => clock, aclr => resetn );

    -- zs_uid269_countValue_closePathZ_uid94_block_rsrvd_fix(CONSTANT,268)
    zs_uid269_countValue_closePathZ_uid94_block_rsrvd_fix_q <= "00000000";

    -- vStagei_uid268_countValue_closePathZ_uid94_block_rsrvd_fix(MUX,267)@8 + 1
    vStagei_uid268_countValue_closePathZ_uid94_block_rsrvd_fix_s <= vCount_uid265_countValue_closePathZ_uid94_block_rsrvd_fix_q;
    vStagei_uid268_countValue_closePathZ_uid94_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            vStagei_uid268_countValue_closePathZ_uid94_block_rsrvd_fix_q <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            CASE (vStagei_uid268_countValue_closePathZ_uid94_block_rsrvd_fix_s) IS
                WHEN "0" => vStagei_uid268_countValue_closePathZ_uid94_block_rsrvd_fix_q <= rVStage_uid264_countValue_closePathZ_uid94_block_rsrvd_fix_merged_bit_select_b;
                WHEN "1" => vStagei_uid268_countValue_closePathZ_uid94_block_rsrvd_fix_q <= rVStage_uid264_countValue_closePathZ_uid94_block_rsrvd_fix_merged_bit_select_c;
                WHEN OTHERS => vStagei_uid268_countValue_closePathZ_uid94_block_rsrvd_fix_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- rVStage_uid270_countValue_closePathZ_uid94_block_rsrvd_fix_merged_bit_select(BITSELECT,433)@9
    rVStage_uid270_countValue_closePathZ_uid94_block_rsrvd_fix_merged_bit_select_b <= vStagei_uid268_countValue_closePathZ_uid94_block_rsrvd_fix_q(15 downto 8);
    rVStage_uid270_countValue_closePathZ_uid94_block_rsrvd_fix_merged_bit_select_c <= vStagei_uid268_countValue_closePathZ_uid94_block_rsrvd_fix_q(7 downto 0);

    -- vCount_uid271_countValue_closePathZ_uid94_block_rsrvd_fix(LOGICAL,270)@9
    vCount_uid271_countValue_closePathZ_uid94_block_rsrvd_fix_q <= "1" WHEN rVStage_uid270_countValue_closePathZ_uid94_block_rsrvd_fix_merged_bit_select_b = zs_uid269_countValue_closePathZ_uid94_block_rsrvd_fix_q ELSE "0";

    -- redist9_vCount_uid271_countValue_closePathZ_uid94_block_rsrvd_fix_q_2(DELAY,445)
    redist9_vCount_uid271_countValue_closePathZ_uid94_block_rsrvd_fix_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => vCount_uid271_countValue_closePathZ_uid94_block_rsrvd_fix_q, xout => redist9_vCount_uid271_countValue_closePathZ_uid94_block_rsrvd_fix_q_2_q, clk => clock, aclr => resetn );

    -- zs_uid275_countValue_closePathZ_uid94_block_rsrvd_fix(CONSTANT,274)
    zs_uid275_countValue_closePathZ_uid94_block_rsrvd_fix_q <= "0000";

    -- vStagei_uid274_countValue_closePathZ_uid94_block_rsrvd_fix(MUX,273)@9 + 1
    vStagei_uid274_countValue_closePathZ_uid94_block_rsrvd_fix_s <= vCount_uid271_countValue_closePathZ_uid94_block_rsrvd_fix_q;
    vStagei_uid274_countValue_closePathZ_uid94_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            vStagei_uid274_countValue_closePathZ_uid94_block_rsrvd_fix_q <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            CASE (vStagei_uid274_countValue_closePathZ_uid94_block_rsrvd_fix_s) IS
                WHEN "0" => vStagei_uid274_countValue_closePathZ_uid94_block_rsrvd_fix_q <= rVStage_uid270_countValue_closePathZ_uid94_block_rsrvd_fix_merged_bit_select_b;
                WHEN "1" => vStagei_uid274_countValue_closePathZ_uid94_block_rsrvd_fix_q <= rVStage_uid270_countValue_closePathZ_uid94_block_rsrvd_fix_merged_bit_select_c;
                WHEN OTHERS => vStagei_uid274_countValue_closePathZ_uid94_block_rsrvd_fix_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- rVStage_uid276_countValue_closePathZ_uid94_block_rsrvd_fix_merged_bit_select(BITSELECT,434)@10
    rVStage_uid276_countValue_closePathZ_uid94_block_rsrvd_fix_merged_bit_select_b <= vStagei_uid274_countValue_closePathZ_uid94_block_rsrvd_fix_q(7 downto 4);
    rVStage_uid276_countValue_closePathZ_uid94_block_rsrvd_fix_merged_bit_select_c <= vStagei_uid274_countValue_closePathZ_uid94_block_rsrvd_fix_q(3 downto 0);

    -- vCount_uid277_countValue_closePathZ_uid94_block_rsrvd_fix(LOGICAL,276)@10
    vCount_uid277_countValue_closePathZ_uid94_block_rsrvd_fix_q <= "1" WHEN rVStage_uid276_countValue_closePathZ_uid94_block_rsrvd_fix_merged_bit_select_b = zs_uid275_countValue_closePathZ_uid94_block_rsrvd_fix_q ELSE "0";

    -- redist8_vCount_uid277_countValue_closePathZ_uid94_block_rsrvd_fix_q_1(DELAY,444)
    redist8_vCount_uid277_countValue_closePathZ_uid94_block_rsrvd_fix_q_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => vCount_uid277_countValue_closePathZ_uid94_block_rsrvd_fix_q, xout => redist8_vCount_uid277_countValue_closePathZ_uid94_block_rsrvd_fix_q_1_q, clk => clock, aclr => resetn );

    -- cst2zeros_uid170_block_rsrvd_fix(CONSTANT,169)
    cst2zeros_uid170_block_rsrvd_fix_q <= "00";

    -- vStagei_uid280_countValue_closePathZ_uid94_block_rsrvd_fix(MUX,279)@10 + 1
    vStagei_uid280_countValue_closePathZ_uid94_block_rsrvd_fix_s <= vCount_uid277_countValue_closePathZ_uid94_block_rsrvd_fix_q;
    vStagei_uid280_countValue_closePathZ_uid94_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            vStagei_uid280_countValue_closePathZ_uid94_block_rsrvd_fix_q <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            CASE (vStagei_uid280_countValue_closePathZ_uid94_block_rsrvd_fix_s) IS
                WHEN "0" => vStagei_uid280_countValue_closePathZ_uid94_block_rsrvd_fix_q <= rVStage_uid276_countValue_closePathZ_uid94_block_rsrvd_fix_merged_bit_select_b;
                WHEN "1" => vStagei_uid280_countValue_closePathZ_uid94_block_rsrvd_fix_q <= rVStage_uid276_countValue_closePathZ_uid94_block_rsrvd_fix_merged_bit_select_c;
                WHEN OTHERS => vStagei_uid280_countValue_closePathZ_uid94_block_rsrvd_fix_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- rVStage_uid282_countValue_closePathZ_uid94_block_rsrvd_fix_merged_bit_select(BITSELECT,435)@11
    rVStage_uid282_countValue_closePathZ_uid94_block_rsrvd_fix_merged_bit_select_b <= vStagei_uid280_countValue_closePathZ_uid94_block_rsrvd_fix_q(3 downto 2);
    rVStage_uid282_countValue_closePathZ_uid94_block_rsrvd_fix_merged_bit_select_c <= vStagei_uid280_countValue_closePathZ_uid94_block_rsrvd_fix_q(1 downto 0);

    -- vCount_uid283_countValue_closePathZ_uid94_block_rsrvd_fix(LOGICAL,282)@11
    vCount_uid283_countValue_closePathZ_uid94_block_rsrvd_fix_q <= "1" WHEN rVStage_uid282_countValue_closePathZ_uid94_block_rsrvd_fix_merged_bit_select_b = cst2zeros_uid170_block_rsrvd_fix_q ELSE "0";

    -- vStagei_uid286_countValue_closePathZ_uid94_block_rsrvd_fix(MUX,285)@11
    vStagei_uid286_countValue_closePathZ_uid94_block_rsrvd_fix_s <= vCount_uid283_countValue_closePathZ_uid94_block_rsrvd_fix_q;
    vStagei_uid286_countValue_closePathZ_uid94_block_rsrvd_fix_combproc: PROCESS (vStagei_uid286_countValue_closePathZ_uid94_block_rsrvd_fix_s, rVStage_uid282_countValue_closePathZ_uid94_block_rsrvd_fix_merged_bit_select_b, rVStage_uid282_countValue_closePathZ_uid94_block_rsrvd_fix_merged_bit_select_c)
    BEGIN
        CASE (vStagei_uid286_countValue_closePathZ_uid94_block_rsrvd_fix_s) IS
            WHEN "0" => vStagei_uid286_countValue_closePathZ_uid94_block_rsrvd_fix_q <= rVStage_uid282_countValue_closePathZ_uid94_block_rsrvd_fix_merged_bit_select_b;
            WHEN "1" => vStagei_uid286_countValue_closePathZ_uid94_block_rsrvd_fix_q <= rVStage_uid282_countValue_closePathZ_uid94_block_rsrvd_fix_merged_bit_select_c;
            WHEN OTHERS => vStagei_uid286_countValue_closePathZ_uid94_block_rsrvd_fix_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid288_countValue_closePathZ_uid94_block_rsrvd_fix(BITSELECT,287)@11
    rVStage_uid288_countValue_closePathZ_uid94_block_rsrvd_fix_b <= vStagei_uid286_countValue_closePathZ_uid94_block_rsrvd_fix_q(1 downto 1);

    -- vCount_uid289_countValue_closePathZ_uid94_block_rsrvd_fix(LOGICAL,288)@11
    vCount_uid289_countValue_closePathZ_uid94_block_rsrvd_fix_q <= "1" WHEN rVStage_uid288_countValue_closePathZ_uid94_block_rsrvd_fix_b = GND_q ELSE "0";

    -- r_uid290_countValue_closePathZ_uid94_block_rsrvd_fix(BITJOIN,289)@11
    r_uid290_countValue_closePathZ_uid94_block_rsrvd_fix_q <= redist12_vCount_uid257_countValue_closePathZ_uid94_block_rsrvd_fix_q_4_q & redist10_vCount_uid265_countValue_closePathZ_uid94_block_rsrvd_fix_q_3_q & redist9_vCount_uid271_countValue_closePathZ_uid94_block_rsrvd_fix_q_2_q & redist8_vCount_uid277_countValue_closePathZ_uid94_block_rsrvd_fix_q_1_q & vCount_uid283_countValue_closePathZ_uid94_block_rsrvd_fix_q & vCount_uid289_countValue_closePathZ_uid94_block_rsrvd_fix_q;

    -- aMinusA2_uid121_block_rsrvd_fix(LOGICAL,120)@11 + 1
    aMinusA2_uid121_block_rsrvd_fix_qi <= "1" WHEN r_uid290_countValue_closePathZ_uid94_block_rsrvd_fix_q = cAmA_uid120_block_rsrvd_fix_q ELSE "0";
    aMinusA2_uid121_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => aMinusA2_uid121_block_rsrvd_fix_qi, xout => aMinusA2_uid121_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- redist43_effSub_uid59_block_rsrvd_fix_q_8(DELAY,479)
    redist43_effSub_uid59_block_rsrvd_fix_q_8 : dspba_delay
    GENERIC MAP ( width => 1, depth => 7, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist42_effSub_uid59_block_rsrvd_fix_q_1_q, xout => redist43_effSub_uid59_block_rsrvd_fix_q_8_q, clk => clock, aclr => resetn );

    -- oWE_uid69_block_rsrvd_fix(CONSTANT,68)
    oWE_uid69_block_rsrvd_fix_q <= "000000000001";

    -- closePathA_uid70_block_rsrvd_fix(COMPARE,69)@3 + 1
    closePathA_uid70_block_rsrvd_fix_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((13 downto 12 => oWE_uid69_block_rsrvd_fix_q(11)) & oWE_uid69_block_rsrvd_fix_q));
    closePathA_uid70_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((13 downto 12 => expAmExpB_uid68_block_rsrvd_fix_q(11)) & expAmExpB_uid68_block_rsrvd_fix_q));
    closePathA_uid70_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            closePathA_uid70_block_rsrvd_fix_o <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            closePathA_uid70_block_rsrvd_fix_o <= STD_LOGIC_VECTOR(SIGNED(closePathA_uid70_block_rsrvd_fix_a) - SIGNED(closePathA_uid70_block_rsrvd_fix_b));
        END IF;
    END PROCESS;
    closePathA_uid70_block_rsrvd_fix_n(0) <= not (closePathA_uid70_block_rsrvd_fix_o(13));

    -- redist41_closePathA_uid70_block_rsrvd_fix_n_8(DELAY,477)
    redist41_closePathA_uid70_block_rsrvd_fix_n_8 : dspba_delay
    GENERIC MAP ( width => 1, depth => 7, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => closePathA_uid70_block_rsrvd_fix_n, xout => redist41_closePathA_uid70_block_rsrvd_fix_n_8_q, clk => clock, aclr => resetn );

    -- closePath_uid71_block_rsrvd_fix(LOGICAL,70)@11 + 1
    closePath_uid71_block_rsrvd_fix_qi <= redist41_closePathA_uid70_block_rsrvd_fix_n_8_q and redist43_effSub_uid59_block_rsrvd_fix_q_8_q;
    closePath_uid71_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => closePath_uid71_block_rsrvd_fix_qi, xout => closePath_uid71_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- aMinusA_uid122_block_rsrvd_fix(LOGICAL,121)@12
    aMinusA_uid122_block_rsrvd_fix_q <= closePath_uid71_block_rsrvd_fix_q and aMinusA2_uid121_block_rsrvd_fix_q;

    -- invAMinusA_uid234_block_rsrvd_fix(LOGICAL,233)@12
    invAMinusA_uid234_block_rsrvd_fix_q <= not (aMinusA_uid122_block_rsrvd_fix_q);

    -- redist48_sigA_uid57_block_rsrvd_fix_b_10(DELAY,484)
    redist48_sigA_uid57_block_rsrvd_fix_b_10 : dspba_delay
    GENERIC MAP ( width => 1, depth => 9, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist47_sigA_uid57_block_rsrvd_fix_b_1_q, xout => redist48_sigA_uid57_block_rsrvd_fix_b_10_q, clk => clock, aclr => resetn );

    -- redist55_excZ_bSig_uid45_block_rsrvd_fix_q_6(DELAY,491)
    redist55_excZ_bSig_uid45_block_rsrvd_fix_q_6 : dspba_delay
    GENERIC MAP ( width => 1, depth => 6, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excZ_bSig_uid45_block_rsrvd_fix_q, xout => redist55_excZ_bSig_uid45_block_rsrvd_fix_q_6_q, clk => clock, aclr => resetn );

    -- redist56_excZ_bSig_uid45_block_rsrvd_fix_q_9(DELAY,492)
    redist56_excZ_bSig_uid45_block_rsrvd_fix_q_9 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist55_excZ_bSig_uid45_block_rsrvd_fix_q_6_q, xout => redist56_excZ_bSig_uid45_block_rsrvd_fix_q_9_q, clk => clock, aclr => resetn );

    -- redist49_excS_bSig_uid51_block_rsrvd_fix_q_6(DELAY,485)
    redist49_excS_bSig_uid51_block_rsrvd_fix_q_6 : dspba_delay
    GENERIC MAP ( width => 1, depth => 6, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excS_bSig_uid51_block_rsrvd_fix_q, xout => redist49_excS_bSig_uid51_block_rsrvd_fix_q_6_q, clk => clock, aclr => resetn );

    -- redist50_excS_bSig_uid51_block_rsrvd_fix_q_9(DELAY,486)
    redist50_excS_bSig_uid51_block_rsrvd_fix_q_9 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist49_excS_bSig_uid51_block_rsrvd_fix_q_6_q, xout => redist50_excS_bSig_uid51_block_rsrvd_fix_q_9_q, clk => clock, aclr => resetn );

    -- cstAllOWE_uid19_block_rsrvd_fix(CONSTANT,18)
    cstAllOWE_uid19_block_rsrvd_fix_q <= "11111111111";

    -- expXIsMax_uid42_block_rsrvd_fix(LOGICAL,41)@2 + 1
    expXIsMax_uid42_block_rsrvd_fix_qi <= "1" WHEN redist58_exp_bSig_uid39_block_rsrvd_fix_b_1_q = cstAllOWE_uid19_block_rsrvd_fix_q ELSE "0";
    expXIsMax_uid42_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => expXIsMax_uid42_block_rsrvd_fix_qi, xout => expXIsMax_uid42_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- invExpXIsMax_uid48_block_rsrvd_fix(LOGICAL,47)@3
    invExpXIsMax_uid48_block_rsrvd_fix_q <= not (expXIsMax_uid42_block_rsrvd_fix_q);

    -- excR_bSig_uid50_block_rsrvd_fix(LOGICAL,49)@3 + 1
    excR_bSig_uid50_block_rsrvd_fix_qi <= InvExpXIsZero_uid49_block_rsrvd_fix_q and invExpXIsMax_uid48_block_rsrvd_fix_q;
    excR_bSig_uid50_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excR_bSig_uid50_block_rsrvd_fix_qi, xout => excR_bSig_uid50_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- redist51_excR_bSig_uid50_block_rsrvd_fix_q_9(DELAY,487)
    redist51_excR_bSig_uid50_block_rsrvd_fix_q_9 : dspba_delay
    GENERIC MAP ( width => 1, depth => 8, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excR_bSig_uid50_block_rsrvd_fix_q, xout => redist51_excR_bSig_uid50_block_rsrvd_fix_q_9_q, clk => clock, aclr => resetn );

    -- bIsRegOrSubnorm_uid233_block_rsrvd_fix(LOGICAL,232)@12
    bIsRegOrSubnorm_uid233_block_rsrvd_fix_q <= redist51_excR_bSig_uid50_block_rsrvd_fix_q_9_q or redist50_excS_bSig_uid51_block_rsrvd_fix_q_9_q or redist56_excZ_bSig_uid45_block_rsrvd_fix_q_9_q;

    -- redist5_and_lev1_uid321_fracXIsZero_uid26_block_rsrvd_fix_q_5(DELAY,441)
    redist5_and_lev1_uid321_fracXIsZero_uid26_block_rsrvd_fix_q_5 : dspba_delay
    GENERIC MAP ( width => 1, depth => 5, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => and_lev1_uid321_fracXIsZero_uid26_block_rsrvd_fix_q, xout => redist5_and_lev1_uid321_fracXIsZero_uid26_block_rsrvd_fix_q_5_q, clk => clock, aclr => resetn );

    -- redist68_expXIsZero_uid24_block_rsrvd_fix_q_6(DELAY,504)
    redist68_expXIsZero_uid24_block_rsrvd_fix_q_6 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist67_expXIsZero_uid24_block_rsrvd_fix_q_4_q, xout => redist68_expXIsZero_uid24_block_rsrvd_fix_q_6_q, clk => clock, aclr => resetn );

    -- excZ_aSig_uid28_block_rsrvd_fix(LOGICAL,27)@8 + 1
    excZ_aSig_uid28_block_rsrvd_fix_qi <= redist68_expXIsZero_uid24_block_rsrvd_fix_q_6_q and redist5_and_lev1_uid321_fracXIsZero_uid26_block_rsrvd_fix_q_5_q;
    excZ_aSig_uid28_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excZ_aSig_uid28_block_rsrvd_fix_qi, xout => excZ_aSig_uid28_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- redist59_excS_aSig_uid34_block_rsrvd_fix_q_6(DELAY,495)
    redist59_excS_aSig_uid34_block_rsrvd_fix_q_6 : dspba_delay
    GENERIC MAP ( width => 1, depth => 6, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excS_aSig_uid34_block_rsrvd_fix_q, xout => redist59_excS_aSig_uid34_block_rsrvd_fix_q_6_q, clk => clock, aclr => resetn );

    -- redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_notEnable(LOGICAL,558)
    redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_nor(LOGICAL,559)
    redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_nor_q <= not (redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_notEnable_q or redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_sticky_ena_q);

    -- redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_mem_last(CONSTANT,555)
    redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_mem_last_q <= "01";

    -- redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_cmp(LOGICAL,556)
    redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_cmp_q <= "1" WHEN redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_mem_last_q = redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_rdcnt_q ELSE "0";

    -- redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_cmpReg(REG,557)
    redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_cmpReg_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_cmpReg_q <= "0";
        ELSIF (clock'EVENT AND clock = '1') THEN
            redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_cmpReg_q <= STD_LOGIC_VECTOR(redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_cmp_q);
        END IF;
    END PROCESS;

    -- redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_sticky_ena(REG,560)
    redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_sticky_ena_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_sticky_ena_q <= "0";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_nor_q = "1") THEN
                redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_sticky_ena_q <= STD_LOGIC_VECTOR(redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_enaAnd(LOGICAL,561)
    redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_enaAnd_q <= redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_sticky_ena_q and VCC_q;

    -- redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_rdcnt(COUNTER,553)
    -- low=0, high=2, step=1, init=0
    redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_rdcnt_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_rdcnt_i <= TO_UNSIGNED(0, 2);
            redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_rdcnt_eq <= '0';
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_rdcnt_i = TO_UNSIGNED(1, 2)) THEN
                redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_rdcnt_eq <= '1';
            ELSE
                redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_rdcnt_eq <= '0';
            END IF;
            IF (redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_rdcnt_eq = '1') THEN
                redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_rdcnt_i <= redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_rdcnt_i + 2;
            ELSE
                redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_rdcnt_i <= redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_rdcnt_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_rdcnt_i, 2)));

    -- redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_inputreg(DELAY,550)
    redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_inputreg : dspba_delay
    GENERIC MAP ( width => 11, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => exp_aSig_uid22_block_rsrvd_fix_b, xout => redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_inputreg_q, clk => clock, aclr => resetn );

    -- redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_wraddr(REG,554)
    redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_wraddr_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_wraddr_q <= "10";
        ELSIF (clock'EVENT AND clock = '1') THEN
            redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_wraddr_q <= STD_LOGIC_VECTOR(redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_rdcnt_q);
        END IF;
    END PROCESS;

    -- redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_mem(DUALMEM,552)
    redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_mem_ia <= STD_LOGIC_VECTOR(redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_inputreg_q);
    redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_mem_aa <= redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_wraddr_q;
    redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_mem_ab <= redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_rdcnt_q;
    redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_mem_reset0 <= not (resetn);
    redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 11,
        widthad_a => 2,
        numwords_a => 3,
        width_b => 11,
        widthad_b => 2,
        numwords_b => 3,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_aclr_b => "CLEAR1",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Cyclone V"
    )
    PORT MAP (
        clocken1 => redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_enaAnd_q(0),
        clocken0 => VCC_q(0),
        clock0 => clock,
        aclr1 => redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_mem_reset0,
        clock1 => clock,
        address_a => redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_mem_aa,
        data_a => redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_mem_ab,
        q_b => redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_mem_iq
    );
    redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_mem_q <= redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_mem_iq(10 downto 0);

    -- redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_outputreg(DELAY,551)
    redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_outputreg : dspba_delay
    GENERIC MAP ( width => 11, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_mem_q, xout => redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_outputreg_q, clk => clock, aclr => resetn );

    -- expXIsMax_uid25_block_rsrvd_fix(LOGICAL,24)@8
    expXIsMax_uid25_block_rsrvd_fix_q <= "1" WHEN redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_outputreg_q = cstAllOWE_uid19_block_rsrvd_fix_q ELSE "0";

    -- invExpXIsMax_uid31_block_rsrvd_fix(LOGICAL,30)@8
    invExpXIsMax_uid31_block_rsrvd_fix_q <= not (expXIsMax_uid25_block_rsrvd_fix_q);

    -- redist61_InvExpXIsZero_uid32_block_rsrvd_fix_q_2(DELAY,497)
    redist61_InvExpXIsZero_uid32_block_rsrvd_fix_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => InvExpXIsZero_uid32_block_rsrvd_fix_q, xout => redist61_InvExpXIsZero_uid32_block_rsrvd_fix_q_2_q, clk => clock, aclr => resetn );

    -- excR_aSig_uid33_block_rsrvd_fix(LOGICAL,32)@8 + 1
    excR_aSig_uid33_block_rsrvd_fix_qi <= redist61_InvExpXIsZero_uid32_block_rsrvd_fix_q_2_q and invExpXIsMax_uid31_block_rsrvd_fix_q;
    excR_aSig_uid33_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excR_aSig_uid33_block_rsrvd_fix_qi, xout => excR_aSig_uid33_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- aIsRegOrSubnorm_uid232_block_rsrvd_fix(LOGICAL,231)@9 + 1
    aIsRegOrSubnorm_uid232_block_rsrvd_fix_qi <= excR_aSig_uid33_block_rsrvd_fix_q or redist59_excS_aSig_uid34_block_rsrvd_fix_q_6_q or excZ_aSig_uid28_block_rsrvd_fix_q;
    aIsRegOrSubnorm_uid232_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => aIsRegOrSubnorm_uid232_block_rsrvd_fix_qi, xout => aIsRegOrSubnorm_uid232_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- redist14_aIsRegOrSubnorm_uid232_block_rsrvd_fix_q_3(DELAY,450)
    redist14_aIsRegOrSubnorm_uid232_block_rsrvd_fix_q_3 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => aIsRegOrSubnorm_uid232_block_rsrvd_fix_q, xout => redist14_aIsRegOrSubnorm_uid232_block_rsrvd_fix_q_3_q, clk => clock, aclr => resetn );

    -- signRReg_uid235_block_rsrvd_fix(LOGICAL,234)@12
    signRReg_uid235_block_rsrvd_fix_q <= redist14_aIsRegOrSubnorm_uid232_block_rsrvd_fix_q_3_q and bIsRegOrSubnorm_uid233_block_rsrvd_fix_q and redist48_sigA_uid57_block_rsrvd_fix_b_10_q and invAMinusA_uid234_block_rsrvd_fix_q;

    -- redist46_sigB_uid58_block_rsrvd_fix_b_11(DELAY,482)
    redist46_sigB_uid58_block_rsrvd_fix_b_11 : dspba_delay
    GENERIC MAP ( width => 1, depth => 9, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist45_sigB_uid58_block_rsrvd_fix_b_2_q, xout => redist46_sigB_uid58_block_rsrvd_fix_b_11_q, clk => clock, aclr => resetn );

    -- redist65_excZ_aSig_uid28_block_rsrvd_fix_q_4(DELAY,501)
    redist65_excZ_aSig_uid28_block_rsrvd_fix_q_4 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excZ_aSig_uid28_block_rsrvd_fix_q, xout => redist65_excZ_aSig_uid28_block_rsrvd_fix_q_4_q, clk => clock, aclr => resetn );

    -- excAZBZSigASigB_uid239_block_rsrvd_fix(LOGICAL,238)@12
    excAZBZSigASigB_uid239_block_rsrvd_fix_q <= redist65_excZ_aSig_uid28_block_rsrvd_fix_q_4_q and redist56_excZ_bSig_uid45_block_rsrvd_fix_q_9_q and redist48_sigA_uid57_block_rsrvd_fix_b_10_q and redist46_sigB_uid58_block_rsrvd_fix_b_11_q;

    -- redist60_excR_aSig_uid33_block_rsrvd_fix_q_4(DELAY,496)
    redist60_excR_aSig_uid33_block_rsrvd_fix_q_4 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excR_aSig_uid33_block_rsrvd_fix_q, xout => redist60_excR_aSig_uid33_block_rsrvd_fix_q_4_q, clk => clock, aclr => resetn );

    -- excBZARSigA_uid240_block_rsrvd_fix(LOGICAL,239)@12
    excBZARSigA_uid240_block_rsrvd_fix_q <= redist56_excZ_bSig_uid45_block_rsrvd_fix_q_9_q and redist60_excR_aSig_uid33_block_rsrvd_fix_q_4_q and redist48_sigA_uid57_block_rsrvd_fix_b_10_q;

    -- signRZero_uid241_block_rsrvd_fix(LOGICAL,240)@12
    signRZero_uid241_block_rsrvd_fix_q <= excBZARSigA_uid240_block_rsrvd_fix_q or excAZBZSigASigB_uid239_block_rsrvd_fix_q;

    -- excI_bSig_uid46_block_rsrvd_fix(LOGICAL,45)@3 + 1
    excI_bSig_uid46_block_rsrvd_fix_qi <= expXIsMax_uid42_block_rsrvd_fix_q and and_lev1_uid351_fracXIsZero_uid43_block_rsrvd_fix_q;
    excI_bSig_uid46_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excI_bSig_uid46_block_rsrvd_fix_qi, xout => excI_bSig_uid46_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- redist53_excI_bSig_uid46_block_rsrvd_fix_q_9(DELAY,489)
    redist53_excI_bSig_uid46_block_rsrvd_fix_q_9 : dspba_delay
    GENERIC MAP ( width => 1, depth => 8, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excI_bSig_uid46_block_rsrvd_fix_q, xout => redist53_excI_bSig_uid46_block_rsrvd_fix_q_9_q, clk => clock, aclr => resetn );

    -- sigBBInf_uid236_block_rsrvd_fix(LOGICAL,235)@12
    sigBBInf_uid236_block_rsrvd_fix_q <= redist46_sigB_uid58_block_rsrvd_fix_b_11_q and redist53_excI_bSig_uid46_block_rsrvd_fix_q_9_q;

    -- excI_aSig_uid29_block_rsrvd_fix(LOGICAL,28)@8 + 1
    excI_aSig_uid29_block_rsrvd_fix_qi <= expXIsMax_uid25_block_rsrvd_fix_q and redist5_and_lev1_uid321_fracXIsZero_uid26_block_rsrvd_fix_q_5_q;
    excI_aSig_uid29_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excI_aSig_uid29_block_rsrvd_fix_qi, xout => excI_aSig_uid29_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- redist63_excI_aSig_uid29_block_rsrvd_fix_q_4(DELAY,499)
    redist63_excI_aSig_uid29_block_rsrvd_fix_q_4 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excI_aSig_uid29_block_rsrvd_fix_q, xout => redist63_excI_aSig_uid29_block_rsrvd_fix_q_4_q, clk => clock, aclr => resetn );

    -- sigAAInf_uid237_block_rsrvd_fix(LOGICAL,236)@12
    sigAAInf_uid237_block_rsrvd_fix_q <= redist48_sigA_uid57_block_rsrvd_fix_b_10_q and redist63_excI_aSig_uid29_block_rsrvd_fix_q_4_q;

    -- signRInf_uid238_block_rsrvd_fix(LOGICAL,237)@12
    signRInf_uid238_block_rsrvd_fix_q <= sigAAInf_uid237_block_rsrvd_fix_q or sigBBInf_uid236_block_rsrvd_fix_q;

    -- signRInfRZRReg_uid242_block_rsrvd_fix(LOGICAL,241)@12 + 1
    signRInfRZRReg_uid242_block_rsrvd_fix_qi <= signRInf_uid238_block_rsrvd_fix_q or signRZero_uid241_block_rsrvd_fix_q or signRReg_uid235_block_rsrvd_fix_q;
    signRInfRZRReg_uid242_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => signRInfRZRReg_uid242_block_rsrvd_fix_qi, xout => signRInfRZRReg_uid242_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- redist13_signRInfRZRReg_uid242_block_rsrvd_fix_q_7(DELAY,449)
    redist13_signRInfRZRReg_uid242_block_rsrvd_fix_q_7 : dspba_delay
    GENERIC MAP ( width => 1, depth => 6, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => signRInfRZRReg_uid242_block_rsrvd_fix_q, xout => redist13_signRInfRZRReg_uid242_block_rsrvd_fix_q_7_q, clk => clock, aclr => resetn );

    -- excN_bSig_uid47_block_rsrvd_fix(LOGICAL,46)@3 + 1
    excN_bSig_uid47_block_rsrvd_fix_qi <= expXIsMax_uid42_block_rsrvd_fix_q and fracXIsNotZero_uid44_block_rsrvd_fix_q;
    excN_bSig_uid47_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excN_bSig_uid47_block_rsrvd_fix_qi, xout => excN_bSig_uid47_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- redist52_excN_bSig_uid47_block_rsrvd_fix_q_16(DELAY,488)
    redist52_excN_bSig_uid47_block_rsrvd_fix_q_16 : dspba_delay
    GENERIC MAP ( width => 1, depth => 15, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excN_bSig_uid47_block_rsrvd_fix_q, xout => redist52_excN_bSig_uid47_block_rsrvd_fix_q_16_q, clk => clock, aclr => resetn );

    -- redist66_fracXIsNotZero_uid27_block_rsrvd_fix_q_5(DELAY,502)
    redist66_fracXIsNotZero_uid27_block_rsrvd_fix_q_5 : dspba_delay
    GENERIC MAP ( width => 1, depth => 5, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => fracXIsNotZero_uid27_block_rsrvd_fix_q, xout => redist66_fracXIsNotZero_uid27_block_rsrvd_fix_q_5_q, clk => clock, aclr => resetn );

    -- excN_aSig_uid30_block_rsrvd_fix(LOGICAL,29)@8 + 1
    excN_aSig_uid30_block_rsrvd_fix_qi <= expXIsMax_uid25_block_rsrvd_fix_q and redist66_fracXIsNotZero_uid27_block_rsrvd_fix_q_5_q;
    excN_aSig_uid30_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excN_aSig_uid30_block_rsrvd_fix_qi, xout => excN_aSig_uid30_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- redist62_excN_aSig_uid30_block_rsrvd_fix_q_11(DELAY,498)
    redist62_excN_aSig_uid30_block_rsrvd_fix_q_11 : dspba_delay
    GENERIC MAP ( width => 1, depth => 10, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excN_aSig_uid30_block_rsrvd_fix_q, xout => redist62_excN_aSig_uid30_block_rsrvd_fix_q_11_q, clk => clock, aclr => resetn );

    -- excRNaN2_uid227_block_rsrvd_fix(LOGICAL,226)@19
    excRNaN2_uid227_block_rsrvd_fix_q <= redist62_excN_aSig_uid30_block_rsrvd_fix_q_11_q or redist52_excN_bSig_uid47_block_rsrvd_fix_q_16_q;

    -- redist44_effSub_uid59_block_rsrvd_fix_q_16(DELAY,480)
    redist44_effSub_uid59_block_rsrvd_fix_q_16 : dspba_delay
    GENERIC MAP ( width => 1, depth => 8, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist43_effSub_uid59_block_rsrvd_fix_q_8_q, xout => redist44_effSub_uid59_block_rsrvd_fix_q_16_q, clk => clock, aclr => resetn );

    -- redist54_excI_bSig_uid46_block_rsrvd_fix_q_16(DELAY,490)
    redist54_excI_bSig_uid46_block_rsrvd_fix_q_16 : dspba_delay
    GENERIC MAP ( width => 1, depth => 7, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist53_excI_bSig_uid46_block_rsrvd_fix_q_9_q, xout => redist54_excI_bSig_uid46_block_rsrvd_fix_q_16_q, clk => clock, aclr => resetn );

    -- redist64_excI_aSig_uid29_block_rsrvd_fix_q_11(DELAY,500)
    redist64_excI_aSig_uid29_block_rsrvd_fix_q_11 : dspba_delay
    GENERIC MAP ( width => 1, depth => 7, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist63_excI_aSig_uid29_block_rsrvd_fix_q_4_q, xout => redist64_excI_aSig_uid29_block_rsrvd_fix_q_11_q, clk => clock, aclr => resetn );

    -- excAIBISub_uid228_block_rsrvd_fix(LOGICAL,227)@19
    excAIBISub_uid228_block_rsrvd_fix_q <= redist64_excI_aSig_uid29_block_rsrvd_fix_q_11_q and redist54_excI_bSig_uid46_block_rsrvd_fix_q_16_q and redist44_effSub_uid59_block_rsrvd_fix_q_16_q;

    -- excRNaN_uid229_block_rsrvd_fix(LOGICAL,228)@19
    excRNaN_uid229_block_rsrvd_fix_q <= excAIBISub_uid228_block_rsrvd_fix_q or excRNaN2_uid227_block_rsrvd_fix_q;

    -- invExcRNaN_uid243_block_rsrvd_fix(LOGICAL,242)@19
    invExcRNaN_uid243_block_rsrvd_fix_q <= not (excRNaN_uid229_block_rsrvd_fix_q);

    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- signRPostExc_uid244_block_rsrvd_fix(LOGICAL,243)@19 + 1
    signRPostExc_uid244_block_rsrvd_fix_qi <= invExcRNaN_uid243_block_rsrvd_fix_q and redist13_signRInfRZRReg_uid242_block_rsrvd_fix_q_7_q;
    signRPostExc_uid244_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => signRPostExc_uid244_block_rsrvd_fix_qi, xout => signRPostExc_uid244_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- oneOnTwoBits_uid154_block_rsrvd_fix(CONSTANT,153)
    oneOnTwoBits_uid154_block_rsrvd_fix_q <= "01";

    -- zeroOutCst_uid389_fracPostNorm_closePathExt_uid118_block_rsrvd_fix(CONSTANT,388)
    zeroOutCst_uid389_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q <= "00000000000000000000000000000000000000000000000000000000";

    -- leftShiftStage2Idx3Rng3_uid385_fracPostNorm_closePathExt_uid118_block_rsrvd_fix(BITSELECT,384)@15
    leftShiftStage2Idx3Rng3_uid385_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_in <= leftShiftStage1_uid377_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q(52 downto 0);
    leftShiftStage2Idx3Rng3_uid385_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_b <= leftShiftStage2Idx3Rng3_uid385_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_in(52 downto 0);

    -- leftShiftStage2Idx3Pad3_uid384_fracPostNorm_closePathExt_uid118_block_rsrvd_fix(CONSTANT,383)
    leftShiftStage2Idx3Pad3_uid384_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q <= "000";

    -- leftShiftStage2Idx3_uid386_fracPostNorm_closePathExt_uid118_block_rsrvd_fix(BITJOIN,385)@15
    leftShiftStage2Idx3_uid386_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q <= leftShiftStage2Idx3Rng3_uid385_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_b & leftShiftStage2Idx3Pad3_uid384_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q;

    -- leftShiftStage2Idx2Rng2_uid382_fracPostNorm_closePathExt_uid118_block_rsrvd_fix(BITSELECT,381)@15
    leftShiftStage2Idx2Rng2_uid382_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_in <= leftShiftStage1_uid377_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q(53 downto 0);
    leftShiftStage2Idx2Rng2_uid382_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_b <= leftShiftStage2Idx2Rng2_uid382_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_in(53 downto 0);

    -- leftShiftStage2Idx2_uid383_fracPostNorm_closePathExt_uid118_block_rsrvd_fix(BITJOIN,382)@15
    leftShiftStage2Idx2_uid383_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q <= leftShiftStage2Idx2Rng2_uid382_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_b & cst2zeros_uid170_block_rsrvd_fix_q;

    -- leftShiftStage2Idx1Rng1_uid379_fracPostNorm_closePathExt_uid118_block_rsrvd_fix(BITSELECT,378)@15
    leftShiftStage2Idx1Rng1_uid379_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_in <= leftShiftStage1_uid377_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q(54 downto 0);
    leftShiftStage2Idx1Rng1_uid379_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_b <= leftShiftStage2Idx1Rng1_uid379_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_in(54 downto 0);

    -- leftShiftStage2Idx1_uid380_fracPostNorm_closePathExt_uid118_block_rsrvd_fix(BITJOIN,379)@15
    leftShiftStage2Idx1_uid380_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q <= leftShiftStage2Idx1Rng1_uid379_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_b & GND_q;

    -- leftShiftStage1Idx3Rng12_uid374_fracPostNorm_closePathExt_uid118_block_rsrvd_fix(BITSELECT,373)@14
    leftShiftStage1Idx3Rng12_uid374_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_in <= leftShiftStage0_uid366_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q(43 downto 0);
    leftShiftStage1Idx3Rng12_uid374_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_b <= leftShiftStage1Idx3Rng12_uid374_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_in(43 downto 0);

    -- leftShiftStage1Idx3Pad12_uid373_fracPostNorm_closePathExt_uid118_block_rsrvd_fix(CONSTANT,372)
    leftShiftStage1Idx3Pad12_uid373_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q <= "000000000000";

    -- leftShiftStage1Idx3_uid375_fracPostNorm_closePathExt_uid118_block_rsrvd_fix(BITJOIN,374)@14
    leftShiftStage1Idx3_uid375_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q <= leftShiftStage1Idx3Rng12_uid374_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_b & leftShiftStage1Idx3Pad12_uid373_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q;

    -- leftShiftStage1Idx2Rng8_uid371_fracPostNorm_closePathExt_uid118_block_rsrvd_fix(BITSELECT,370)@14
    leftShiftStage1Idx2Rng8_uid371_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_in <= leftShiftStage0_uid366_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q(47 downto 0);
    leftShiftStage1Idx2Rng8_uid371_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_b <= leftShiftStage1Idx2Rng8_uid371_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_in(47 downto 0);

    -- leftShiftStage1Idx2_uid372_fracPostNorm_closePathExt_uid118_block_rsrvd_fix(BITJOIN,371)@14
    leftShiftStage1Idx2_uid372_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q <= leftShiftStage1Idx2Rng8_uid371_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_b & zs_uid269_countValue_closePathZ_uid94_block_rsrvd_fix_q;

    -- leftShiftStage1Idx1Rng4_uid368_fracPostNorm_closePathExt_uid118_block_rsrvd_fix(BITSELECT,367)@14
    leftShiftStage1Idx1Rng4_uid368_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_in <= leftShiftStage0_uid366_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q(51 downto 0);
    leftShiftStage1Idx1Rng4_uid368_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_b <= leftShiftStage1Idx1Rng4_uid368_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_in(51 downto 0);

    -- leftShiftStage1Idx1_uid369_fracPostNorm_closePathExt_uid118_block_rsrvd_fix(BITJOIN,368)@14
    leftShiftStage1Idx1_uid369_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q <= leftShiftStage1Idx1Rng4_uid368_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_b & zs_uid275_countValue_closePathZ_uid94_block_rsrvd_fix_q;

    -- leftShiftStage0Idx3Rng48_uid363_fracPostNorm_closePathExt_uid118_block_rsrvd_fix(BITSELECT,362)@14
    leftShiftStage0Idx3Rng48_uid363_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_in <= redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_outputreg_q(7 downto 0);
    leftShiftStage0Idx3Rng48_uid363_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_b <= leftShiftStage0Idx3Rng48_uid363_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_in(7 downto 0);

    -- leftShiftStage0Idx3Pad48_uid362_fracPostNorm_closePathExt_uid118_block_rsrvd_fix(CONSTANT,361)
    leftShiftStage0Idx3Pad48_uid362_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q <= "000000000000000000000000000000000000000000000000";

    -- leftShiftStage0Idx3_uid364_fracPostNorm_closePathExt_uid118_block_rsrvd_fix(BITJOIN,363)@14
    leftShiftStage0Idx3_uid364_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q <= leftShiftStage0Idx3Rng48_uid363_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_b & leftShiftStage0Idx3Pad48_uid362_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q;

    -- redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_notEnable(LOGICAL,519)
    redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_nor(LOGICAL,520)
    redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_nor_q <= not (redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_notEnable_q or redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_sticky_ena_q);

    -- redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_mem_last(CONSTANT,516)
    redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_mem_last_q <= "010";

    -- redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_cmp(LOGICAL,517)
    redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_cmp_b <= STD_LOGIC_VECTOR("0" & redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_rdcnt_q);
    redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_cmp_q <= "1" WHEN redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_mem_last_q = redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_cmp_b ELSE "0";

    -- redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_cmpReg(REG,518)
    redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_cmpReg_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_cmpReg_q <= "0";
        ELSIF (clock'EVENT AND clock = '1') THEN
            redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_cmpReg_q <= STD_LOGIC_VECTOR(redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_cmp_q);
        END IF;
    END PROCESS;

    -- redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_sticky_ena(REG,521)
    redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_sticky_ena_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_sticky_ena_q <= "0";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_nor_q = "1") THEN
                redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_sticky_ena_q <= STD_LOGIC_VECTOR(redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_enaAnd(LOGICAL,522)
    redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_enaAnd_q <= redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_sticky_ena_q and VCC_q;

    -- redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_rdcnt(COUNTER,514)
    -- low=0, high=3, step=1, init=0
    redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_rdcnt_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_rdcnt_i <= TO_UNSIGNED(0, 2);
        ELSIF (clock'EVENT AND clock = '1') THEN
            redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_rdcnt_i <= redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_rdcnt_i + 1;
        END IF;
    END PROCESS;
    redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_rdcnt_i, 2)));

    -- redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_inputreg(DELAY,511)
    redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_inputreg : dspba_delay
    GENERIC MAP ( width => 24, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b, xout => redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_inputreg_q, clk => clock, aclr => resetn );

    -- redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_wraddr(REG,515)
    redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_wraddr_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_wraddr_q <= "11";
        ELSIF (clock'EVENT AND clock = '1') THEN
            redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_wraddr_q <= STD_LOGIC_VECTOR(redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_rdcnt_q);
        END IF;
    END PROCESS;

    -- redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_mem(DUALMEM,513)
    redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_mem_ia <= STD_LOGIC_VECTOR(redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_inputreg_q);
    redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_mem_aa <= redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_wraddr_q;
    redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_mem_ab <= redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_rdcnt_q;
    redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_mem_reset0 <= not (resetn);
    redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 24,
        widthad_a => 2,
        numwords_a => 4,
        width_b => 24,
        widthad_b => 2,
        numwords_b => 4,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_aclr_b => "CLEAR1",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Cyclone V"
    )
    PORT MAP (
        clocken1 => redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_enaAnd_q(0),
        clocken0 => VCC_q(0),
        clock0 => clock,
        aclr1 => redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_mem_reset0,
        clock1 => clock,
        address_a => redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_mem_aa,
        data_a => redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_mem_ab,
        q_b => redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_mem_iq
    );
    redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_mem_q <= redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_mem_iq(23 downto 0);

    -- redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_outputreg(DELAY,512)
    redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_outputreg : dspba_delay
    GENERIC MAP ( width => 24, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_mem_q, xout => redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_outputreg_q, clk => clock, aclr => resetn );

    -- leftShiftStage0Idx2_uid361_fracPostNorm_closePathExt_uid118_block_rsrvd_fix(BITJOIN,360)@14
    leftShiftStage0Idx2_uid361_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q <= redist11_vStage_uid259_countValue_closePathZ_uid94_block_rsrvd_fix_b_7_outputreg_q & zs_uid255_countValue_closePathZ_uid94_block_rsrvd_fix_q;

    -- leftShiftStage0Idx1Rng16_uid357_fracPostNorm_closePathExt_uid118_block_rsrvd_fix(BITSELECT,356)@14
    leftShiftStage0Idx1Rng16_uid357_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_in <= redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_outputreg_q(39 downto 0);
    leftShiftStage0Idx1Rng16_uid357_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_b <= leftShiftStage0Idx1Rng16_uid357_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_in(39 downto 0);

    -- leftShiftStage0Idx1_uid358_fracPostNorm_closePathExt_uid118_block_rsrvd_fix(BITJOIN,357)@14
    leftShiftStage0Idx1_uid358_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q <= leftShiftStage0Idx1Rng16_uid357_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_b & zs_uid263_countValue_closePathZ_uid94_block_rsrvd_fix_q;

    -- redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_notEnable(LOGICAL,544)
    redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_nor(LOGICAL,545)
    redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_nor_q <= not (redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_notEnable_q or redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_sticky_ena_q);

    -- redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_mem_last(CONSTANT,541)
    redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_mem_last_q <= "010";

    -- redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_cmp(LOGICAL,542)
    redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_cmp_b <= STD_LOGIC_VECTOR("0" & redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_rdcnt_q);
    redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_cmp_q <= "1" WHEN redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_mem_last_q = redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_cmp_b ELSE "0";

    -- redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_cmpReg(REG,543)
    redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_cmpReg_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_cmpReg_q <= "0";
        ELSIF (clock'EVENT AND clock = '1') THEN
            redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_cmpReg_q <= STD_LOGIC_VECTOR(redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_cmp_q);
        END IF;
    END PROCESS;

    -- redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_sticky_ena(REG,546)
    redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_sticky_ena_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_sticky_ena_q <= "0";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_nor_q = "1") THEN
                redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_sticky_ena_q <= STD_LOGIC_VECTOR(redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_enaAnd(LOGICAL,547)
    redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_enaAnd_q <= redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_sticky_ena_q and VCC_q;

    -- redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_rdcnt(COUNTER,539)
    -- low=0, high=3, step=1, init=0
    redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_rdcnt_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_rdcnt_i <= TO_UNSIGNED(0, 2);
        ELSIF (clock'EVENT AND clock = '1') THEN
            redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_rdcnt_i <= redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_rdcnt_i + 1;
        END IF;
    END PROCESS;
    redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_rdcnt_i, 2)));

    -- redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_inputreg(DELAY,536)
    redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_inputreg : dspba_delay
    GENERIC MAP ( width => 56, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist33_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_1_q, xout => redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_inputreg_q, clk => clock, aclr => resetn );

    -- redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_wraddr(REG,540)
    redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_wraddr_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_wraddr_q <= "11";
        ELSIF (clock'EVENT AND clock = '1') THEN
            redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_wraddr_q <= STD_LOGIC_VECTOR(redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_rdcnt_q);
        END IF;
    END PROCESS;

    -- redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_mem(DUALMEM,538)
    redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_mem_ia <= STD_LOGIC_VECTOR(redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_inputreg_q);
    redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_mem_aa <= redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_wraddr_q;
    redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_mem_ab <= redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_rdcnt_q;
    redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_mem_reset0 <= not (resetn);
    redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 56,
        widthad_a => 2,
        numwords_a => 4,
        width_b => 56,
        widthad_b => 2,
        numwords_b => 4,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_aclr_b => "CLEAR1",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Cyclone V"
    )
    PORT MAP (
        clocken1 => redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_enaAnd_q(0),
        clocken0 => VCC_q(0),
        clock0 => clock,
        aclr1 => redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_mem_reset0,
        clock1 => clock,
        address_a => redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_mem_aa,
        data_a => redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_mem_ab,
        q_b => redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_mem_iq
    );
    redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_mem_q <= redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_mem_iq(55 downto 0);

    -- redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_outputreg(DELAY,537)
    redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_outputreg : dspba_delay
    GENERIC MAP ( width => 56, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_mem_q, xout => redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_outputreg_q, clk => clock, aclr => resetn );

    -- leftShiftStage0_uid366_fracPostNorm_closePathExt_uid118_block_rsrvd_fix(MUX,365)@14
    leftShiftStage0_uid366_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_s <= leftShiftStageSel5Dto4_uid365_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_merged_bit_select_b;
    leftShiftStage0_uid366_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_combproc: PROCESS (leftShiftStage0_uid366_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_s, redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_outputreg_q, leftShiftStage0Idx1_uid358_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q, leftShiftStage0Idx2_uid361_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q, leftShiftStage0Idx3_uid364_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q)
    BEGIN
        CASE (leftShiftStage0_uid366_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_s) IS
            WHEN "00" => leftShiftStage0_uid366_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q <= redist34_fracAddResultNoSignExt_closePath_uid93_block_rsrvd_fix_b_8_outputreg_q;
            WHEN "01" => leftShiftStage0_uid366_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q <= leftShiftStage0Idx1_uid358_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q;
            WHEN "10" => leftShiftStage0_uid366_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q <= leftShiftStage0Idx2_uid361_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q;
            WHEN "11" => leftShiftStage0_uid366_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q <= leftShiftStage0Idx3_uid364_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q;
            WHEN OTHERS => leftShiftStage0_uid366_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist71_exp_aSig_uid22_block_rsrvd_fix_b_9(DELAY,507)
    redist71_exp_aSig_uid22_block_rsrvd_fix_b_9 : dspba_delay
    GENERIC MAP ( width => 11, depth => 3, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist70_exp_aSig_uid22_block_rsrvd_fix_b_6_outputreg_q, xout => redist71_exp_aSig_uid22_block_rsrvd_fix_b_9_q, clk => clock, aclr => resetn );

    -- expAP1_uid97_block_rsrvd_fix(ADD,96)@11 + 1
    expAP1_uid97_block_rsrvd_fix_a <= STD_LOGIC_VECTOR("0" & redist71_exp_aSig_uid22_block_rsrvd_fix_b_9_q);
    expAP1_uid97_block_rsrvd_fix_b <= STD_LOGIC_VECTOR("00000000000" & VCC_q);
    expAP1_uid97_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            expAP1_uid97_block_rsrvd_fix_o <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            expAP1_uid97_block_rsrvd_fix_o <= STD_LOGIC_VECTOR(UNSIGNED(expAP1_uid97_block_rsrvd_fix_a) + UNSIGNED(expAP1_uid97_block_rsrvd_fix_b));
        END IF;
    END PROCESS;
    expAP1_uid97_block_rsrvd_fix_q <= expAP1_uid97_block_rsrvd_fix_o(11 downto 0);

    -- redist6_r_uid290_countValue_closePathZ_uid94_block_rsrvd_fix_q_1(DELAY,442)
    redist6_r_uid290_countValue_closePathZ_uid94_block_rsrvd_fix_q_1 : dspba_delay
    GENERIC MAP ( width => 6, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => r_uid290_countValue_closePathZ_uid94_block_rsrvd_fix_q, xout => redist6_r_uid290_countValue_closePathZ_uid94_block_rsrvd_fix_q_1_q, clk => clock, aclr => resetn );

    -- condCase11_uid102_block_rsrvd_fix(COMPARE,101)@12 + 1
    condCase11_uid102_block_rsrvd_fix_a <= STD_LOGIC_VECTOR("00000000" & redist6_r_uid290_countValue_closePathZ_uid94_block_rsrvd_fix_q_1_q);
    condCase11_uid102_block_rsrvd_fix_b <= STD_LOGIC_VECTOR("00" & expAP1_uid97_block_rsrvd_fix_q);
    condCase11_uid102_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            condCase11_uid102_block_rsrvd_fix_o <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            condCase11_uid102_block_rsrvd_fix_o <= STD_LOGIC_VECTOR(UNSIGNED(condCase11_uid102_block_rsrvd_fix_a) - UNSIGNED(condCase11_uid102_block_rsrvd_fix_b));
        END IF;
    END PROCESS;
    condCase11_uid102_block_rsrvd_fix_n(0) <= not (condCase11_uid102_block_rsrvd_fix_o(13));

    -- condCase12_uid103_block_rsrvd_fix(LOGICAL,102)@13
    condCase12_uid103_block_rsrvd_fix_q <= not (condCase11_uid102_block_rsrvd_fix_n);

    -- aNormalAndClosePath_uid101_block_rsrvd_fix(LOGICAL,100)@12 + 1
    aNormalAndClosePath_uid101_block_rsrvd_fix_qi <= redist60_excR_aSig_uid33_block_rsrvd_fix_q_4_q and closePath_uid71_block_rsrvd_fix_q;
    aNormalAndClosePath_uid101_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => aNormalAndClosePath_uid101_block_rsrvd_fix_qi, xout => aNormalAndClosePath_uid101_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- case12_uid105_block_rsrvd_fix(LOGICAL,104)@13
    case12_uid105_block_rsrvd_fix_q <= aNormalAndClosePath_uid101_block_rsrvd_fix_q and condCase12_uid103_block_rsrvd_fix_q;

    -- zExt_uid99_block_rsrvd_fix(CONSTANT,98)
    zExt_uid99_block_rsrvd_fix_q <= "00000";

    -- redist7_r_uid290_countValue_closePathZ_uid94_block_rsrvd_fix_q_2(DELAY,443)
    redist7_r_uid290_countValue_closePathZ_uid94_block_rsrvd_fix_q_2 : dspba_delay
    GENERIC MAP ( width => 6, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist6_r_uid290_countValue_closePathZ_uid94_block_rsrvd_fix_q_1_q, xout => redist7_r_uid290_countValue_closePathZ_uid94_block_rsrvd_fix_q_2_q, clk => clock, aclr => resetn );

    -- expValueClosePath_Case12_uid100_block_rsrvd_fix(BITJOIN,99)@13
    expValueClosePath_Case12_uid100_block_rsrvd_fix_q <= zExt_uid99_block_rsrvd_fix_q & redist7_r_uid290_countValue_closePathZ_uid94_block_rsrvd_fix_q_2_q;

    -- case12Exponent_uid108_block_rsrvd_fix(LOGICAL,107)@13
    case12Exponent_uid108_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((10 downto 1 => case12_uid105_block_rsrvd_fix_q(0)) & case12_uid105_block_rsrvd_fix_q));
    case12Exponent_uid108_block_rsrvd_fix_q <= expValueClosePath_Case12_uid100_block_rsrvd_fix_q and case12Exponent_uid108_block_rsrvd_fix_b;

    -- case11_uid104_block_rsrvd_fix(LOGICAL,103)@13
    case11_uid104_block_rsrvd_fix_q <= aNormalAndClosePath_uid101_block_rsrvd_fix_q and condCase11_uid102_block_rsrvd_fix_n;

    -- redist72_exp_aSig_uid22_block_rsrvd_fix_b_11(DELAY,508)
    redist72_exp_aSig_uid22_block_rsrvd_fix_b_11 : dspba_delay
    GENERIC MAP ( width => 11, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist71_exp_aSig_uid22_block_rsrvd_fix_b_9_q, xout => redist72_exp_aSig_uid22_block_rsrvd_fix_b_11_q, clk => clock, aclr => resetn );

    -- shiftValC11_uid114_block_rsrvd_fix(LOGICAL,113)@13
    shiftValC11_uid114_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((10 downto 1 => case11_uid104_block_rsrvd_fix_q(0)) & case11_uid104_block_rsrvd_fix_q));
    shiftValC11_uid114_block_rsrvd_fix_q <= redist72_exp_aSig_uid22_block_rsrvd_fix_b_11_q and shiftValC11_uid114_block_rsrvd_fix_b;

    -- redist38_closePath_uid71_block_rsrvd_fix_q_2(DELAY,474)
    redist38_closePath_uid71_block_rsrvd_fix_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => closePath_uid71_block_rsrvd_fix_q, xout => redist38_closePath_uid71_block_rsrvd_fix_q_2_q, clk => clock, aclr => resetn );

    -- aZeroOrSubnorm_uid72_block_rsrvd_fix(LOGICAL,71)@9
    aZeroOrSubnorm_uid72_block_rsrvd_fix_q <= excZ_aSig_uid28_block_rsrvd_fix_q or redist59_excS_aSig_uid34_block_rsrvd_fix_q_6_q;

    -- redist37_aZeroOrSubnorm_uid72_block_rsrvd_fix_q_4(DELAY,473)
    redist37_aZeroOrSubnorm_uid72_block_rsrvd_fix_q_4 : dspba_delay
    GENERIC MAP ( width => 1, depth => 4, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => aZeroOrSubnorm_uid72_block_rsrvd_fix_q, xout => redist37_aZeroOrSubnorm_uid72_block_rsrvd_fix_q_4_q, clk => clock, aclr => resetn );

    -- case0_uid95_block_rsrvd_fix(LOGICAL,94)@13
    case0_uid95_block_rsrvd_fix_q <= redist37_aZeroOrSubnorm_uid72_block_rsrvd_fix_q_4_q and redist37_aZeroOrSubnorm_uid72_block_rsrvd_fix_q_4_q and redist38_closePath_uid71_block_rsrvd_fix_q_2_q;

    -- expValueClosePath_Case0_uid96_block_rsrvd_fix(CONSTANT,95)
    expValueClosePath_Case0_uid96_block_rsrvd_fix_q <= "00000000001";

    -- case0Exponent_uid106_block_rsrvd_fix(LOGICAL,105)@13
    case0Exponent_uid106_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((10 downto 1 => case0_uid95_block_rsrvd_fix_q(0)) & case0_uid95_block_rsrvd_fix_q));
    case0Exponent_uid106_block_rsrvd_fix_q <= expValueClosePath_Case0_uid96_block_rsrvd_fix_q and case0Exponent_uid106_block_rsrvd_fix_b;

    -- shiftValueCloseAll_uid116_block_rsrvd_fix(LOGICAL,115)@13 + 1
    shiftValueCloseAll_uid116_block_rsrvd_fix_qi <= case0Exponent_uid106_block_rsrvd_fix_q or shiftValC11_uid114_block_rsrvd_fix_q or case12Exponent_uid108_block_rsrvd_fix_q;
    shiftValueCloseAll_uid116_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 11, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => shiftValueCloseAll_uid116_block_rsrvd_fix_qi, xout => shiftValueCloseAll_uid116_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- leftShiftStageSel5Dto4_uid365_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_merged_bit_select(BITSELECT,429)@14
    leftShiftStageSel5Dto4_uid365_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_merged_bit_select_in <= shiftValueCloseAll_uid116_block_rsrvd_fix_q(5 downto 0);
    leftShiftStageSel5Dto4_uid365_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_merged_bit_select_b <= leftShiftStageSel5Dto4_uid365_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_merged_bit_select_in(5 downto 4);
    leftShiftStageSel5Dto4_uid365_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_merged_bit_select_c <= leftShiftStageSel5Dto4_uid365_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_merged_bit_select_in(3 downto 2);
    leftShiftStageSel5Dto4_uid365_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_merged_bit_select_d <= leftShiftStageSel5Dto4_uid365_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_merged_bit_select_in(1 downto 0);

    -- leftShiftStage1_uid377_fracPostNorm_closePathExt_uid118_block_rsrvd_fix(MUX,376)@14 + 1
    leftShiftStage1_uid377_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_s <= leftShiftStageSel5Dto4_uid365_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_merged_bit_select_c;
    leftShiftStage1_uid377_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            leftShiftStage1_uid377_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            CASE (leftShiftStage1_uid377_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_s) IS
                WHEN "00" => leftShiftStage1_uid377_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q <= leftShiftStage0_uid366_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q;
                WHEN "01" => leftShiftStage1_uid377_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q <= leftShiftStage1Idx1_uid369_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q;
                WHEN "10" => leftShiftStage1_uid377_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q <= leftShiftStage1Idx2_uid372_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q;
                WHEN "11" => leftShiftStage1_uid377_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q <= leftShiftStage1Idx3_uid375_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q;
                WHEN OTHERS => leftShiftStage1_uid377_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- redist2_leftShiftStageSel5Dto4_uid365_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_merged_bit_select_d_1(DELAY,438)
    redist2_leftShiftStageSel5Dto4_uid365_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_merged_bit_select_d_1 : dspba_delay
    GENERIC MAP ( width => 2, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => leftShiftStageSel5Dto4_uid365_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_merged_bit_select_d, xout => redist2_leftShiftStageSel5Dto4_uid365_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_merged_bit_select_d_1_q, clk => clock, aclr => resetn );

    -- leftShiftStage2_uid388_fracPostNorm_closePathExt_uid118_block_rsrvd_fix(MUX,387)@15
    leftShiftStage2_uid388_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_s <= redist2_leftShiftStageSel5Dto4_uid365_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_merged_bit_select_d_1_q;
    leftShiftStage2_uid388_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_combproc: PROCESS (leftShiftStage2_uid388_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_s, leftShiftStage1_uid377_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q, leftShiftStage2Idx1_uid380_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q, leftShiftStage2Idx2_uid383_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q, leftShiftStage2Idx3_uid386_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q)
    BEGIN
        CASE (leftShiftStage2_uid388_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_s) IS
            WHEN "00" => leftShiftStage2_uid388_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q <= leftShiftStage1_uid377_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q;
            WHEN "01" => leftShiftStage2_uid388_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q <= leftShiftStage2Idx1_uid380_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q;
            WHEN "10" => leftShiftStage2_uid388_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q <= leftShiftStage2Idx2_uid383_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q;
            WHEN "11" => leftShiftStage2_uid388_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q <= leftShiftStage2Idx3_uid386_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q;
            WHEN OTHERS => leftShiftStage2_uid388_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- shiftedOut_uid355_fracPostNorm_closePathExt_uid118_block_rsrvd_fix(COMPARE,354)@14 + 1
    shiftedOut_uid355_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_a <= STD_LOGIC_VECTOR("00" & shiftValueCloseAll_uid116_block_rsrvd_fix_q);
    shiftedOut_uid355_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_b <= STD_LOGIC_VECTOR("0000000" & cAmA_uid120_block_rsrvd_fix_q);
    shiftedOut_uid355_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            shiftedOut_uid355_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_o <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            shiftedOut_uid355_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_o <= STD_LOGIC_VECTOR(UNSIGNED(shiftedOut_uid355_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_a) - UNSIGNED(shiftedOut_uid355_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_b));
        END IF;
    END PROCESS;
    shiftedOut_uid355_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_n(0) <= not (shiftedOut_uid355_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_o(12));

    -- r_uid390_fracPostNorm_closePathExt_uid118_block_rsrvd_fix(MUX,389)@15
    r_uid390_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_s <= shiftedOut_uid355_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_n;
    r_uid390_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_combproc: PROCESS (r_uid390_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_s, leftShiftStage2_uid388_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q, zeroOutCst_uid389_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q)
    BEGIN
        CASE (r_uid390_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_s) IS
            WHEN "0" => r_uid390_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q <= leftShiftStage2_uid388_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q;
            WHEN "1" => r_uid390_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q <= zeroOutCst_uid389_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q;
            WHEN OTHERS => r_uid390_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- fracPostNorm_closePath_uid119_block_rsrvd_fix(BITSELECT,118)@15
    fracPostNorm_closePath_uid119_block_rsrvd_fix_in <= r_uid390_fracPostNorm_closePathExt_uid118_block_rsrvd_fix_q(54 downto 0);
    fracPostNorm_closePath_uid119_block_rsrvd_fix_b <= fracPostNorm_closePath_uid119_block_rsrvd_fix_in(54 downto 2);

    -- redist30_fracPostNorm_closePath_uid119_block_rsrvd_fix_b_1(DELAY,466)
    redist30_fracPostNorm_closePath_uid119_block_rsrvd_fix_b_1 : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => fracPostNorm_closePath_uid119_block_rsrvd_fix_b, xout => redist30_fracPostNorm_closePath_uid119_block_rsrvd_fix_b_1_q, clk => clock, aclr => resetn );

    -- lsb2BitsClosePath_uid202_block_rsrvd_fix(BITSELECT,201)@16
    lsb2BitsClosePath_uid202_block_rsrvd_fix_in <= redist30_fracPostNorm_closePath_uid119_block_rsrvd_fix_b_1_q(1 downto 0);
    lsb2BitsClosePath_uid202_block_rsrvd_fix_b <= lsb2BitsClosePath_uid202_block_rsrvd_fix_in(1 downto 0);

    -- IrndVal_close_uid203_block_rsrvd_fix(LOGICAL,202)@16
    IrndVal_close_uid203_block_rsrvd_fix_q <= "1" WHEN lsb2BitsClosePath_uid202_block_rsrvd_fix_b = oneOnTwoBits_uid154_block_rsrvd_fix_q ELSE "0";

    -- rndVal_close_uid204_block_rsrvd_fix(LOGICAL,203)@16
    rndVal_close_uid204_block_rsrvd_fix_q <= not (IrndVal_close_uid203_block_rsrvd_fix_q);

    -- cst2On3Bits_uid198_block_rsrvd_fix(CONSTANT,197)
    cst2On3Bits_uid198_block_rsrvd_fix_q <= "010";

    -- padConst_uid133_block_rsrvd_fix(CONSTANT,132)
    padConst_uid133_block_rsrvd_fix_q <= "0000000000000000000000000000000000000000000000000000000";

    -- rightPaddedIn_uid134_block_rsrvd_fix(BITJOIN,133)@5
    rightPaddedIn_uid134_block_rsrvd_fix_q <= oFracBREXC2S_uid79_block_rsrvd_fix_b & padConst_uid133_block_rsrvd_fix_q;

    -- xMSB_uid392_alignmentShifter_uid133_block_rsrvd_fix(BITSELECT,391)@5
    xMSB_uid392_alignmentShifter_uid133_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(rightPaddedIn_uid134_block_rsrvd_fix_q(110 downto 110));

    -- redist3_xMSB_uid392_alignmentShifter_uid133_block_rsrvd_fix_b_1(DELAY,439)
    redist3_xMSB_uid392_alignmentShifter_uid133_block_rsrvd_fix_b_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => xMSB_uid392_alignmentShifter_uid133_block_rsrvd_fix_b, xout => redist3_xMSB_uid392_alignmentShifter_uid133_block_rsrvd_fix_b_1_q, clk => clock, aclr => resetn );

    -- redist4_xMSB_uid392_alignmentShifter_uid133_block_rsrvd_fix_b_2(DELAY,440)
    redist4_xMSB_uid392_alignmentShifter_uid133_block_rsrvd_fix_b_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist3_xMSB_uid392_alignmentShifter_uid133_block_rsrvd_fix_b_1_q, xout => redist4_xMSB_uid392_alignmentShifter_uid133_block_rsrvd_fix_b_2_q, clk => clock, aclr => resetn );

    -- seMsb_to3_uid421(BITSELECT,420)@7
    seMsb_to3_uid421_in <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((2 downto 1 => redist4_xMSB_uid392_alignmentShifter_uid133_block_rsrvd_fix_b_2_q(0)) & redist4_xMSB_uid392_alignmentShifter_uid133_block_rsrvd_fix_b_2_q));
    seMsb_to3_uid421_b <= STD_LOGIC_VECTOR(seMsb_to3_uid421_in(2 downto 0));

    -- rightShiftStage2Idx3Rng3_uid422_alignmentShifter_uid133_block_rsrvd_fix(BITSELECT,421)@7
    rightShiftStage2Idx3Rng3_uid422_alignmentShifter_uid133_block_rsrvd_fix_b <= rightShiftStage1_uid415_alignmentShifter_uid133_block_rsrvd_fix_q(110 downto 3);

    -- rightShiftStage2Idx3_uid423_alignmentShifter_uid133_block_rsrvd_fix(BITJOIN,422)@7
    rightShiftStage2Idx3_uid423_alignmentShifter_uid133_block_rsrvd_fix_q <= seMsb_to3_uid421_b & rightShiftStage2Idx3Rng3_uid422_alignmentShifter_uid133_block_rsrvd_fix_b;

    -- seMsb_to2_uid418(BITSELECT,417)@7
    seMsb_to2_uid418_in <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((1 downto 1 => redist4_xMSB_uid392_alignmentShifter_uid133_block_rsrvd_fix_b_2_q(0)) & redist4_xMSB_uid392_alignmentShifter_uid133_block_rsrvd_fix_b_2_q));
    seMsb_to2_uid418_b <= STD_LOGIC_VECTOR(seMsb_to2_uid418_in(1 downto 0));

    -- rightShiftStage2Idx2Rng2_uid419_alignmentShifter_uid133_block_rsrvd_fix(BITSELECT,418)@7
    rightShiftStage2Idx2Rng2_uid419_alignmentShifter_uid133_block_rsrvd_fix_b <= rightShiftStage1_uid415_alignmentShifter_uid133_block_rsrvd_fix_q(110 downto 2);

    -- rightShiftStage2Idx2_uid420_alignmentShifter_uid133_block_rsrvd_fix(BITJOIN,419)@7
    rightShiftStage2Idx2_uid420_alignmentShifter_uid133_block_rsrvd_fix_q <= seMsb_to2_uid418_b & rightShiftStage2Idx2Rng2_uid419_alignmentShifter_uid133_block_rsrvd_fix_b;

    -- rightShiftStage2Idx1Rng1_uid416_alignmentShifter_uid133_block_rsrvd_fix(BITSELECT,415)@7
    rightShiftStage2Idx1Rng1_uid416_alignmentShifter_uid133_block_rsrvd_fix_b <= rightShiftStage1_uid415_alignmentShifter_uid133_block_rsrvd_fix_q(110 downto 1);

    -- rightShiftStage2Idx1_uid417_alignmentShifter_uid133_block_rsrvd_fix(BITJOIN,416)@7
    rightShiftStage2Idx1_uid417_alignmentShifter_uid133_block_rsrvd_fix_q <= redist4_xMSB_uid392_alignmentShifter_uid133_block_rsrvd_fix_b_2_q & rightShiftStage2Idx1Rng1_uid416_alignmentShifter_uid133_block_rsrvd_fix_b;

    -- seMsb_to12_uid411(BITSELECT,410)@6
    seMsb_to12_uid411_in <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((11 downto 1 => redist3_xMSB_uid392_alignmentShifter_uid133_block_rsrvd_fix_b_1_q(0)) & redist3_xMSB_uid392_alignmentShifter_uid133_block_rsrvd_fix_b_1_q));
    seMsb_to12_uid411_b <= STD_LOGIC_VECTOR(seMsb_to12_uid411_in(11 downto 0));

    -- rightShiftStage1Idx3Rng12_uid412_alignmentShifter_uid133_block_rsrvd_fix(BITSELECT,411)@6
    rightShiftStage1Idx3Rng12_uid412_alignmentShifter_uid133_block_rsrvd_fix_b <= rightShiftStage0_uid404_alignmentShifter_uid133_block_rsrvd_fix_q(110 downto 12);

    -- rightShiftStage1Idx3_uid413_alignmentShifter_uid133_block_rsrvd_fix(BITJOIN,412)@6
    rightShiftStage1Idx3_uid413_alignmentShifter_uid133_block_rsrvd_fix_q <= seMsb_to12_uid411_b & rightShiftStage1Idx3Rng12_uid412_alignmentShifter_uid133_block_rsrvd_fix_b;

    -- seMsb_to8_uid408(BITSELECT,407)@6
    seMsb_to8_uid408_in <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((7 downto 1 => redist3_xMSB_uid392_alignmentShifter_uid133_block_rsrvd_fix_b_1_q(0)) & redist3_xMSB_uid392_alignmentShifter_uid133_block_rsrvd_fix_b_1_q));
    seMsb_to8_uid408_b <= STD_LOGIC_VECTOR(seMsb_to8_uid408_in(7 downto 0));

    -- rightShiftStage1Idx2Rng8_uid409_alignmentShifter_uid133_block_rsrvd_fix(BITSELECT,408)@6
    rightShiftStage1Idx2Rng8_uid409_alignmentShifter_uid133_block_rsrvd_fix_b <= rightShiftStage0_uid404_alignmentShifter_uid133_block_rsrvd_fix_q(110 downto 8);

    -- rightShiftStage1Idx2_uid410_alignmentShifter_uid133_block_rsrvd_fix(BITJOIN,409)@6
    rightShiftStage1Idx2_uid410_alignmentShifter_uid133_block_rsrvd_fix_q <= seMsb_to8_uid408_b & rightShiftStage1Idx2Rng8_uid409_alignmentShifter_uid133_block_rsrvd_fix_b;

    -- seMsb_to4_uid405(BITSELECT,404)@6
    seMsb_to4_uid405_in <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((3 downto 1 => redist3_xMSB_uid392_alignmentShifter_uid133_block_rsrvd_fix_b_1_q(0)) & redist3_xMSB_uid392_alignmentShifter_uid133_block_rsrvd_fix_b_1_q));
    seMsb_to4_uid405_b <= STD_LOGIC_VECTOR(seMsb_to4_uid405_in(3 downto 0));

    -- rightShiftStage1Idx1Rng4_uid406_alignmentShifter_uid133_block_rsrvd_fix(BITSELECT,405)@6
    rightShiftStage1Idx1Rng4_uid406_alignmentShifter_uid133_block_rsrvd_fix_b <= rightShiftStage0_uid404_alignmentShifter_uid133_block_rsrvd_fix_q(110 downto 4);

    -- rightShiftStage1Idx1_uid407_alignmentShifter_uid133_block_rsrvd_fix(BITJOIN,406)@6
    rightShiftStage1Idx1_uid407_alignmentShifter_uid133_block_rsrvd_fix_q <= seMsb_to4_uid405_b & rightShiftStage1Idx1Rng4_uid406_alignmentShifter_uid133_block_rsrvd_fix_b;

    -- seMsb_to48_uid400(BITSELECT,399)@5
    seMsb_to48_uid400_in <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((47 downto 1 => xMSB_uid392_alignmentShifter_uid133_block_rsrvd_fix_b(0)) & xMSB_uid392_alignmentShifter_uid133_block_rsrvd_fix_b));
    seMsb_to48_uid400_b <= STD_LOGIC_VECTOR(seMsb_to48_uid400_in(47 downto 0));

    -- rightShiftStage0Idx3Rng48_uid401_alignmentShifter_uid133_block_rsrvd_fix(BITSELECT,400)@5
    rightShiftStage0Idx3Rng48_uid401_alignmentShifter_uid133_block_rsrvd_fix_b <= rightPaddedIn_uid134_block_rsrvd_fix_q(110 downto 48);

    -- rightShiftStage0Idx3_uid402_alignmentShifter_uid133_block_rsrvd_fix(BITJOIN,401)@5
    rightShiftStage0Idx3_uid402_alignmentShifter_uid133_block_rsrvd_fix_q <= seMsb_to48_uid400_b & rightShiftStage0Idx3Rng48_uid401_alignmentShifter_uid133_block_rsrvd_fix_b;

    -- seMsb_to32_uid397(BITSELECT,396)@5
    seMsb_to32_uid397_in <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((31 downto 1 => xMSB_uid392_alignmentShifter_uid133_block_rsrvd_fix_b(0)) & xMSB_uid392_alignmentShifter_uid133_block_rsrvd_fix_b));
    seMsb_to32_uid397_b <= STD_LOGIC_VECTOR(seMsb_to32_uid397_in(31 downto 0));

    -- rightShiftStage0Idx2Rng32_uid398_alignmentShifter_uid133_block_rsrvd_fix(BITSELECT,397)@5
    rightShiftStage0Idx2Rng32_uid398_alignmentShifter_uid133_block_rsrvd_fix_b <= rightPaddedIn_uid134_block_rsrvd_fix_q(110 downto 32);

    -- rightShiftStage0Idx2_uid399_alignmentShifter_uid133_block_rsrvd_fix(BITJOIN,398)@5
    rightShiftStage0Idx2_uid399_alignmentShifter_uid133_block_rsrvd_fix_q <= seMsb_to32_uid397_b & rightShiftStage0Idx2Rng32_uid398_alignmentShifter_uid133_block_rsrvd_fix_b;

    -- seMsb_to16_uid394(BITSELECT,393)@5
    seMsb_to16_uid394_in <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((15 downto 1 => xMSB_uid392_alignmentShifter_uid133_block_rsrvd_fix_b(0)) & xMSB_uid392_alignmentShifter_uid133_block_rsrvd_fix_b));
    seMsb_to16_uid394_b <= STD_LOGIC_VECTOR(seMsb_to16_uid394_in(15 downto 0));

    -- rightShiftStage0Idx1Rng16_uid395_alignmentShifter_uid133_block_rsrvd_fix(BITSELECT,394)@5
    rightShiftStage0Idx1Rng16_uid395_alignmentShifter_uid133_block_rsrvd_fix_b <= rightPaddedIn_uid134_block_rsrvd_fix_q(110 downto 16);

    -- rightShiftStage0Idx1_uid396_alignmentShifter_uid133_block_rsrvd_fix(BITJOIN,395)@5
    rightShiftStage0Idx1_uid396_alignmentShifter_uid133_block_rsrvd_fix_q <= seMsb_to16_uid394_b & rightShiftStage0Idx1Rng16_uid395_alignmentShifter_uid133_block_rsrvd_fix_b;

    -- shiftOutConst_uid126_block_rsrvd_fix(CONSTANT,125)
    shiftOutConst_uid126_block_rsrvd_fix_q <= "110111";

    -- expAmExpBm1_uid128_block_rsrvd_fix(SUB,127)@3
    expAmExpBm1_uid128_block_rsrvd_fix_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((13 downto 12 => expAmExpB_uid68_block_rsrvd_fix_q(11)) & expAmExpB_uid68_block_rsrvd_fix_q));
    expAmExpBm1_uid128_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0000000000000" & VCC_q));
    expAmExpBm1_uid128_block_rsrvd_fix_o <= STD_LOGIC_VECTOR(SIGNED(expAmExpBm1_uid128_block_rsrvd_fix_a) - SIGNED(expAmExpBm1_uid128_block_rsrvd_fix_b));
    expAmExpBm1_uid128_block_rsrvd_fix_q <= expAmExpBm1_uid128_block_rsrvd_fix_o(12 downto 0);

    -- expAmExpBm1RangeShift_uid129_block_rsrvd_fix(BITSELECT,128)@3
    expAmExpBm1RangeShift_uid129_block_rsrvd_fix_in <= expAmExpBm1_uid128_block_rsrvd_fix_q(5 downto 0);
    expAmExpBm1RangeShift_uid129_block_rsrvd_fix_b <= expAmExpBm1RangeShift_uid129_block_rsrvd_fix_in(5 downto 0);

    -- redist29_expAmExpBm1RangeShift_uid129_block_rsrvd_fix_b_1(DELAY,465)
    redist29_expAmExpBm1RangeShift_uid129_block_rsrvd_fix_b_1 : dspba_delay
    GENERIC MAP ( width => 6, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => expAmExpBm1RangeShift_uid129_block_rsrvd_fix_b, xout => redist29_expAmExpBm1RangeShift_uid129_block_rsrvd_fix_b_1_q, clk => clock, aclr => resetn );

    -- expAmExpBRangeShift_uid130_block_rsrvd_fix(BITSELECT,129)@3
    expAmExpBRangeShift_uid130_block_rsrvd_fix_in <= expAmExpB_uid68_block_rsrvd_fix_q(5 downto 0);
    expAmExpBRangeShift_uid130_block_rsrvd_fix_b <= expAmExpBRangeShift_uid130_block_rsrvd_fix_in(5 downto 0);

    -- redist28_expAmExpBRangeShift_uid130_block_rsrvd_fix_b_1(DELAY,464)
    redist28_expAmExpBRangeShift_uid130_block_rsrvd_fix_b_1 : dspba_delay
    GENERIC MAP ( width => 6, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => expAmExpBRangeShift_uid130_block_rsrvd_fix_b, xout => redist28_expAmExpBRangeShift_uid130_block_rsrvd_fix_b_1_q, clk => clock, aclr => resetn );

    -- shiftValue_farPathPreSat_uid131_block_rsrvd_fix(MUX,130)@4
    shiftValue_farPathPreSat_uid131_block_rsrvd_fix_s <= aNormalBSubnormal_uid88_block_rsrvd_fix_q;
    shiftValue_farPathPreSat_uid131_block_rsrvd_fix_combproc: PROCESS (shiftValue_farPathPreSat_uid131_block_rsrvd_fix_s, redist28_expAmExpBRangeShift_uid130_block_rsrvd_fix_b_1_q, redist29_expAmExpBm1RangeShift_uid129_block_rsrvd_fix_b_1_q)
    BEGIN
        CASE (shiftValue_farPathPreSat_uid131_block_rsrvd_fix_s) IS
            WHEN "0" => shiftValue_farPathPreSat_uid131_block_rsrvd_fix_q <= redist28_expAmExpBRangeShift_uid130_block_rsrvd_fix_b_1_q;
            WHEN "1" => shiftValue_farPathPreSat_uid131_block_rsrvd_fix_q <= redist29_expAmExpBm1RangeShift_uid129_block_rsrvd_fix_b_1_q;
            WHEN OTHERS => shiftValue_farPathPreSat_uid131_block_rsrvd_fix_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- cWFP2_uid123_block_rsrvd_fix(CONSTANT,122)
    cWFP2_uid123_block_rsrvd_fix_q <= "110110";

    -- shiftedOut_uid125_block_rsrvd_fix(COMPARE,124)@3 + 1
    shiftedOut_uid125_block_rsrvd_fix_a <= STD_LOGIC_VECTOR("00000000" & cWFP2_uid123_block_rsrvd_fix_q);
    shiftedOut_uid125_block_rsrvd_fix_b <= STD_LOGIC_VECTOR("00" & expAmExpB_uid68_block_rsrvd_fix_q);
    shiftedOut_uid125_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            shiftedOut_uid125_block_rsrvd_fix_o <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            shiftedOut_uid125_block_rsrvd_fix_o <= STD_LOGIC_VECTOR(UNSIGNED(shiftedOut_uid125_block_rsrvd_fix_a) - UNSIGNED(shiftedOut_uid125_block_rsrvd_fix_b));
        END IF;
    END PROCESS;
    shiftedOut_uid125_block_rsrvd_fix_c(0) <= shiftedOut_uid125_block_rsrvd_fix_o(13);

    -- shiftValue_farPath_uid132_block_rsrvd_fix(MUX,131)@4 + 1
    shiftValue_farPath_uid132_block_rsrvd_fix_s <= shiftedOut_uid125_block_rsrvd_fix_c;
    shiftValue_farPath_uid132_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            shiftValue_farPath_uid132_block_rsrvd_fix_q <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            CASE (shiftValue_farPath_uid132_block_rsrvd_fix_s) IS
                WHEN "0" => shiftValue_farPath_uid132_block_rsrvd_fix_q <= shiftValue_farPathPreSat_uid131_block_rsrvd_fix_q;
                WHEN "1" => shiftValue_farPath_uid132_block_rsrvd_fix_q <= shiftOutConst_uid126_block_rsrvd_fix_q;
                WHEN OTHERS => shiftValue_farPath_uid132_block_rsrvd_fix_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- rightShiftStageSel5Dto4_uid403_alignmentShifter_uid133_block_rsrvd_fix_merged_bit_select(BITSELECT,430)@5
    rightShiftStageSel5Dto4_uid403_alignmentShifter_uid133_block_rsrvd_fix_merged_bit_select_b <= shiftValue_farPath_uid132_block_rsrvd_fix_q(5 downto 4);
    rightShiftStageSel5Dto4_uid403_alignmentShifter_uid133_block_rsrvd_fix_merged_bit_select_c <= shiftValue_farPath_uid132_block_rsrvd_fix_q(3 downto 2);
    rightShiftStageSel5Dto4_uid403_alignmentShifter_uid133_block_rsrvd_fix_merged_bit_select_d <= shiftValue_farPath_uid132_block_rsrvd_fix_q(1 downto 0);

    -- rightShiftStage0_uid404_alignmentShifter_uid133_block_rsrvd_fix(MUX,403)@5 + 1
    rightShiftStage0_uid404_alignmentShifter_uid133_block_rsrvd_fix_s <= rightShiftStageSel5Dto4_uid403_alignmentShifter_uid133_block_rsrvd_fix_merged_bit_select_b;
    rightShiftStage0_uid404_alignmentShifter_uid133_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            rightShiftStage0_uid404_alignmentShifter_uid133_block_rsrvd_fix_q <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            CASE (rightShiftStage0_uid404_alignmentShifter_uid133_block_rsrvd_fix_s) IS
                WHEN "00" => rightShiftStage0_uid404_alignmentShifter_uid133_block_rsrvd_fix_q <= rightPaddedIn_uid134_block_rsrvd_fix_q;
                WHEN "01" => rightShiftStage0_uid404_alignmentShifter_uid133_block_rsrvd_fix_q <= rightShiftStage0Idx1_uid396_alignmentShifter_uid133_block_rsrvd_fix_q;
                WHEN "10" => rightShiftStage0_uid404_alignmentShifter_uid133_block_rsrvd_fix_q <= rightShiftStage0Idx2_uid399_alignmentShifter_uid133_block_rsrvd_fix_q;
                WHEN "11" => rightShiftStage0_uid404_alignmentShifter_uid133_block_rsrvd_fix_q <= rightShiftStage0Idx3_uid402_alignmentShifter_uid133_block_rsrvd_fix_q;
                WHEN OTHERS => rightShiftStage0_uid404_alignmentShifter_uid133_block_rsrvd_fix_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- redist0_rightShiftStageSel5Dto4_uid403_alignmentShifter_uid133_block_rsrvd_fix_merged_bit_select_c_1(DELAY,436)
    redist0_rightShiftStageSel5Dto4_uid403_alignmentShifter_uid133_block_rsrvd_fix_merged_bit_select_c_1 : dspba_delay
    GENERIC MAP ( width => 2, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => rightShiftStageSel5Dto4_uid403_alignmentShifter_uid133_block_rsrvd_fix_merged_bit_select_c, xout => redist0_rightShiftStageSel5Dto4_uid403_alignmentShifter_uid133_block_rsrvd_fix_merged_bit_select_c_1_q, clk => clock, aclr => resetn );

    -- rightShiftStage1_uid415_alignmentShifter_uid133_block_rsrvd_fix(MUX,414)@6 + 1
    rightShiftStage1_uid415_alignmentShifter_uid133_block_rsrvd_fix_s <= redist0_rightShiftStageSel5Dto4_uid403_alignmentShifter_uid133_block_rsrvd_fix_merged_bit_select_c_1_q;
    rightShiftStage1_uid415_alignmentShifter_uid133_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            rightShiftStage1_uid415_alignmentShifter_uid133_block_rsrvd_fix_q <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            CASE (rightShiftStage1_uid415_alignmentShifter_uid133_block_rsrvd_fix_s) IS
                WHEN "00" => rightShiftStage1_uid415_alignmentShifter_uid133_block_rsrvd_fix_q <= rightShiftStage0_uid404_alignmentShifter_uid133_block_rsrvd_fix_q;
                WHEN "01" => rightShiftStage1_uid415_alignmentShifter_uid133_block_rsrvd_fix_q <= rightShiftStage1Idx1_uid407_alignmentShifter_uid133_block_rsrvd_fix_q;
                WHEN "10" => rightShiftStage1_uid415_alignmentShifter_uid133_block_rsrvd_fix_q <= rightShiftStage1Idx2_uid410_alignmentShifter_uid133_block_rsrvd_fix_q;
                WHEN "11" => rightShiftStage1_uid415_alignmentShifter_uid133_block_rsrvd_fix_q <= rightShiftStage1Idx3_uid413_alignmentShifter_uid133_block_rsrvd_fix_q;
                WHEN OTHERS => rightShiftStage1_uid415_alignmentShifter_uid133_block_rsrvd_fix_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- redist1_rightShiftStageSel5Dto4_uid403_alignmentShifter_uid133_block_rsrvd_fix_merged_bit_select_d_2(DELAY,437)
    redist1_rightShiftStageSel5Dto4_uid403_alignmentShifter_uid133_block_rsrvd_fix_merged_bit_select_d_2 : dspba_delay
    GENERIC MAP ( width => 2, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => rightShiftStageSel5Dto4_uid403_alignmentShifter_uid133_block_rsrvd_fix_merged_bit_select_d, xout => redist1_rightShiftStageSel5Dto4_uid403_alignmentShifter_uid133_block_rsrvd_fix_merged_bit_select_d_2_q, clk => clock, aclr => resetn );

    -- rightShiftStage2_uid425_alignmentShifter_uid133_block_rsrvd_fix(MUX,424)@7
    rightShiftStage2_uid425_alignmentShifter_uid133_block_rsrvd_fix_s <= redist1_rightShiftStageSel5Dto4_uid403_alignmentShifter_uid133_block_rsrvd_fix_merged_bit_select_d_2_q;
    rightShiftStage2_uid425_alignmentShifter_uid133_block_rsrvd_fix_combproc: PROCESS (rightShiftStage2_uid425_alignmentShifter_uid133_block_rsrvd_fix_s, rightShiftStage1_uid415_alignmentShifter_uid133_block_rsrvd_fix_q, rightShiftStage2Idx1_uid417_alignmentShifter_uid133_block_rsrvd_fix_q, rightShiftStage2Idx2_uid420_alignmentShifter_uid133_block_rsrvd_fix_q, rightShiftStage2Idx3_uid423_alignmentShifter_uid133_block_rsrvd_fix_q)
    BEGIN
        CASE (rightShiftStage2_uid425_alignmentShifter_uid133_block_rsrvd_fix_s) IS
            WHEN "00" => rightShiftStage2_uid425_alignmentShifter_uid133_block_rsrvd_fix_q <= rightShiftStage1_uid415_alignmentShifter_uid133_block_rsrvd_fix_q;
            WHEN "01" => rightShiftStage2_uid425_alignmentShifter_uid133_block_rsrvd_fix_q <= rightShiftStage2Idx1_uid417_alignmentShifter_uid133_block_rsrvd_fix_q;
            WHEN "10" => rightShiftStage2_uid425_alignmentShifter_uid133_block_rsrvd_fix_q <= rightShiftStage2Idx2_uid420_alignmentShifter_uid133_block_rsrvd_fix_q;
            WHEN "11" => rightShiftStage2_uid425_alignmentShifter_uid133_block_rsrvd_fix_q <= rightShiftStage2Idx3_uid423_alignmentShifter_uid133_block_rsrvd_fix_q;
            WHEN OTHERS => rightShiftStage2_uid425_alignmentShifter_uid133_block_rsrvd_fix_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- highBBits_uid139_block_rsrvd_fix(BITSELECT,138)@7
    highBBits_uid139_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(rightShiftStage2_uid425_alignmentShifter_uid133_block_rsrvd_fix_q(110 downto 55));

    -- redist26_highBBits_uid139_block_rsrvd_fix_b_1(DELAY,462)
    redist26_highBBits_uid139_block_rsrvd_fix_b_1 : dspba_delay
    GENERIC MAP ( width => 56, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => highBBits_uid139_block_rsrvd_fix_b, xout => redist26_highBBits_uid139_block_rsrvd_fix_b_1_q, clk => clock, aclr => resetn );

    -- redist36_oFracAE_uid74_block_rsrvd_fix_q_2(DELAY,472)
    redist36_oFracAE_uid74_block_rsrvd_fix_q_2 : dspba_delay
    GENERIC MAP ( width => 56, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => oFracAE_uid74_block_rsrvd_fix_q, xout => redist36_oFracAE_uid74_block_rsrvd_fix_q_2_q, clk => clock, aclr => resetn );

    -- fracAddResult_farPathsumAHighB_uid140_block_rsrvd_fix(ADD,139)@8 + 1
    fracAddResult_farPathsumAHighB_uid140_block_rsrvd_fix_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((56 downto 56 => redist36_oFracAE_uid74_block_rsrvd_fix_q_2_q(55)) & redist36_oFracAE_uid74_block_rsrvd_fix_q_2_q));
    fracAddResult_farPathsumAHighB_uid140_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((56 downto 56 => redist26_highBBits_uid139_block_rsrvd_fix_b_1_q(55)) & redist26_highBBits_uid139_block_rsrvd_fix_b_1_q));
    fracAddResult_farPathsumAHighB_uid140_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            fracAddResult_farPathsumAHighB_uid140_block_rsrvd_fix_o <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            fracAddResult_farPathsumAHighB_uid140_block_rsrvd_fix_o <= STD_LOGIC_VECTOR(SIGNED(fracAddResult_farPathsumAHighB_uid140_block_rsrvd_fix_a) + SIGNED(fracAddResult_farPathsumAHighB_uid140_block_rsrvd_fix_b));
        END IF;
    END PROCESS;
    fracAddResult_farPathsumAHighB_uid140_block_rsrvd_fix_q <= fracAddResult_farPathsumAHighB_uid140_block_rsrvd_fix_o(56 downto 0);

    -- lowRangeB_uid138_block_rsrvd_fix(BITSELECT,137)@7
    lowRangeB_uid138_block_rsrvd_fix_in <= rightShiftStage2_uid425_alignmentShifter_uid133_block_rsrvd_fix_q(54 downto 0);
    lowRangeB_uid138_block_rsrvd_fix_b <= lowRangeB_uid138_block_rsrvd_fix_in(54 downto 0);

    -- redist27_lowRangeB_uid138_block_rsrvd_fix_b_2(DELAY,463)
    redist27_lowRangeB_uid138_block_rsrvd_fix_b_2 : dspba_delay
    GENERIC MAP ( width => 55, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => lowRangeB_uid138_block_rsrvd_fix_b, xout => redist27_lowRangeB_uid138_block_rsrvd_fix_b_2_q, clk => clock, aclr => resetn );

    -- fracAddResult_farPath_uid141_block_rsrvd_fix(BITJOIN,140)@9
    fracAddResult_farPath_uid141_block_rsrvd_fix_q <= fracAddResult_farPathsumAHighB_uid140_block_rsrvd_fix_q & redist27_lowRangeB_uid138_block_rsrvd_fix_b_2_q;

    -- redist25_fracAddResult_farPath_uid141_block_rsrvd_fix_q_1(DELAY,461)
    redist25_fracAddResult_farPath_uid141_block_rsrvd_fix_q_1 : dspba_delay
    GENERIC MAP ( width => 112, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => fracAddResult_farPath_uid141_block_rsrvd_fix_q, xout => redist25_fracAddResult_farPath_uid141_block_rsrvd_fix_q_1_q, clk => clock, aclr => resetn );

    -- fracPostNorm_farPath11_uid161_block_rsrvd_fix(BITSELECT,160)@10
    fracPostNorm_farPath11_uid161_block_rsrvd_fix_in <= redist25_fracAddResult_farPath_uid141_block_rsrvd_fix_q_1_q(109 downto 0);
    fracPostNorm_farPath11_uid161_block_rsrvd_fix_b <= fracPostNorm_farPath11_uid161_block_rsrvd_fix_in(109 downto 57);

    -- fracPostNorm_farPath01_uid165_block_rsrvd_fix(BITSELECT,164)@10
    fracPostNorm_farPath01_uid165_block_rsrvd_fix_in <= redist25_fracAddResult_farPath_uid141_block_rsrvd_fix_q_1_q(108 downto 0);
    fracPostNorm_farPath01_uid165_block_rsrvd_fix_b <= fracPostNorm_farPath01_uid165_block_rsrvd_fix_in(108 downto 56);

    -- fracPostNorm_farPath00_uid167_block_rsrvd_fix(BITSELECT,166)@10
    fracPostNorm_farPath00_uid167_block_rsrvd_fix_in <= redist25_fracAddResult_farPath_uid141_block_rsrvd_fix_q_1_q(107 downto 0);
    fracPostNorm_farPath00_uid167_block_rsrvd_fix_b <= fracPostNorm_farPath00_uid167_block_rsrvd_fix_in(107 downto 55);

    -- normBits_farPath_uid144_block_rsrvd_fix(BITSELECT,143)@9
    normBits_farPath_uid144_block_rsrvd_fix_in <= fracAddResult_farPath_uid141_block_rsrvd_fix_q(110 downto 0);
    normBits_farPath_uid144_block_rsrvd_fix_b <= normBits_farPath_uid144_block_rsrvd_fix_in(110 downto 109);

    -- normBits_farPathInternal1_uid145_block_rsrvd_fix_merged_bit_select(BITSELECT,431)@9
    normBits_farPathInternal1_uid145_block_rsrvd_fix_merged_bit_select_b <= STD_LOGIC_VECTOR(normBits_farPath_uid144_block_rsrvd_fix_b(1 downto 1));
    normBits_farPathInternal1_uid145_block_rsrvd_fix_merged_bit_select_c <= STD_LOGIC_VECTOR(normBits_farPath_uid144_block_rsrvd_fix_b(0 downto 0));

    -- invNormBits_farPathInternal1_uid146_block_rsrvd_fix(LOGICAL,145)@9
    invNormBits_farPathInternal1_uid146_block_rsrvd_fix_q <= not (normBits_farPathInternal1_uid145_block_rsrvd_fix_merged_bit_select_b);

    -- invNormBits_farPathInternal0_uid148_block_rsrvd_fix(LOGICAL,147)@9
    invNormBits_farPathInternal0_uid148_block_rsrvd_fix_q <= not (normBits_farPathInternal1_uid145_block_rsrvd_fix_merged_bit_select_c);

    -- bZeroOrSubnorm_uid73_block_rsrvd_fix(LOGICAL,72)@9
    bZeroOrSubnorm_uid73_block_rsrvd_fix_q <= redist55_excZ_bSig_uid45_block_rsrvd_fix_q_6_q or redist49_excS_bSig_uid51_block_rsrvd_fix_q_6_q;

    -- aAndBSubnormalsAndSubnormalRes_uid149_block_rsrvd_fix(LOGICAL,148)@9
    aAndBSubnormalsAndSubnormalRes_uid149_block_rsrvd_fix_q <= aZeroOrSubnorm_uid72_block_rsrvd_fix_q and bZeroOrSubnorm_uid73_block_rsrvd_fix_q and invNormBits_farPathInternal0_uid148_block_rsrvd_fix_q and invNormBits_farPathInternal1_uid146_block_rsrvd_fix_q;

    -- normBits_farPathRnd_uid155_block_rsrvd_fix(MUX,154)@9 + 1
    normBits_farPathRnd_uid155_block_rsrvd_fix_s <= aAndBSubnormalsAndSubnormalRes_uid149_block_rsrvd_fix_q;
    normBits_farPathRnd_uid155_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            normBits_farPathRnd_uid155_block_rsrvd_fix_q <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            CASE (normBits_farPathRnd_uid155_block_rsrvd_fix_s) IS
                WHEN "0" => normBits_farPathRnd_uid155_block_rsrvd_fix_q <= normBits_farPath_uid144_block_rsrvd_fix_b;
                WHEN "1" => normBits_farPathRnd_uid155_block_rsrvd_fix_q <= oneOnTwoBits_uid154_block_rsrvd_fix_q;
                WHEN OTHERS => normBits_farPathRnd_uid155_block_rsrvd_fix_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- fracPostNorm_farPath_uid169_block_rsrvd_fix(MUX,168)@10
    fracPostNorm_farPath_uid169_block_rsrvd_fix_s <= normBits_farPathRnd_uid155_block_rsrvd_fix_q;
    fracPostNorm_farPath_uid169_block_rsrvd_fix_combproc: PROCESS (fracPostNorm_farPath_uid169_block_rsrvd_fix_s, fracPostNorm_farPath00_uid167_block_rsrvd_fix_b, fracPostNorm_farPath01_uid165_block_rsrvd_fix_b, fracPostNorm_farPath11_uid161_block_rsrvd_fix_b)
    BEGIN
        CASE (fracPostNorm_farPath_uid169_block_rsrvd_fix_s) IS
            WHEN "00" => fracPostNorm_farPath_uid169_block_rsrvd_fix_q <= fracPostNorm_farPath00_uid167_block_rsrvd_fix_b;
            WHEN "01" => fracPostNorm_farPath_uid169_block_rsrvd_fix_q <= fracPostNorm_farPath01_uid165_block_rsrvd_fix_b;
            WHEN "10" => fracPostNorm_farPath_uid169_block_rsrvd_fix_q <= fracPostNorm_farPath11_uid161_block_rsrvd_fix_b;
            WHEN "11" => fracPostNorm_farPath_uid169_block_rsrvd_fix_q <= fracPostNorm_farPath11_uid161_block_rsrvd_fix_b;
            WHEN OTHERS => fracPostNorm_farPath_uid169_block_rsrvd_fix_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- lBit_uid196_block_rsrvd_fix(BITSELECT,195)@10
    lBit_uid196_block_rsrvd_fix_in <= STD_LOGIC_VECTOR(fracPostNorm_farPath_uid169_block_rsrvd_fix_q(1 downto 0));
    lBit_uid196_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(lBit_uid196_block_rsrvd_fix_in(1 downto 1));

    -- r11_uid182_block_rsrvd_fix(BITSELECT,181)@10
    r11_uid182_block_rsrvd_fix_in <= redist25_fracAddResult_farPath_uid141_block_rsrvd_fix_q_1_q(57 downto 0);
    r11_uid182_block_rsrvd_fix_b <= r11_uid182_block_rsrvd_fix_in(57 downto 57);

    -- r01_uid186_block_rsrvd_fix(BITSELECT,185)@10
    r01_uid186_block_rsrvd_fix_in <= redist25_fracAddResult_farPath_uid141_block_rsrvd_fix_q_1_q(56 downto 0);
    r01_uid186_block_rsrvd_fix_b <= r01_uid186_block_rsrvd_fix_in(56 downto 56);

    -- extra01_uid176_block_rsrvd_fix(BITSELECT,175)@10
    extra01_uid176_block_rsrvd_fix_in <= redist25_fracAddResult_farPath_uid141_block_rsrvd_fix_q_1_q(55 downto 0);
    extra01_uid176_block_rsrvd_fix_b <= extra01_uid176_block_rsrvd_fix_in(55 downto 55);

    -- rBit_uid190_block_rsrvd_fix(MUX,189)@10
    rBit_uid190_block_rsrvd_fix_s <= normBits_farPathRnd_uid155_block_rsrvd_fix_q;
    rBit_uid190_block_rsrvd_fix_combproc: PROCESS (rBit_uid190_block_rsrvd_fix_s, extra01_uid176_block_rsrvd_fix_b, r01_uid186_block_rsrvd_fix_b, r11_uid182_block_rsrvd_fix_b)
    BEGIN
        CASE (rBit_uid190_block_rsrvd_fix_s) IS
            WHEN "00" => rBit_uid190_block_rsrvd_fix_q <= extra01_uid176_block_rsrvd_fix_b;
            WHEN "01" => rBit_uid190_block_rsrvd_fix_q <= r01_uid186_block_rsrvd_fix_b;
            WHEN "10" => rBit_uid190_block_rsrvd_fix_q <= r11_uid182_block_rsrvd_fix_b;
            WHEN "11" => rBit_uid190_block_rsrvd_fix_q <= r11_uid182_block_rsrvd_fix_b;
            WHEN OTHERS => rBit_uid190_block_rsrvd_fix_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- stickyTemp_uid142_block_rsrvd_fix(BITSELECT,141)@9
    stickyTemp_uid142_block_rsrvd_fix_in <= fracAddResult_farPath_uid141_block_rsrvd_fix_q(54 downto 0);
    stickyTemp_uid142_block_rsrvd_fix_b <= stickyTemp_uid142_block_rsrvd_fix_in(54 downto 0);

    -- stickyPreMux_uid143_block_rsrvd_fix(LOGICAL,142)@9 + 1
    stickyPreMux_uid143_block_rsrvd_fix_qi <= "1" WHEN stickyTemp_uid142_block_rsrvd_fix_b /= "0000000000000000000000000000000000000000000000000000000" ELSE "0";
    stickyPreMux_uid143_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => stickyPreMux_uid143_block_rsrvd_fix_qi, xout => stickyPreMux_uid143_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- extra11_uid172_block_rsrvd_fix(BITSELECT,171)@10
    extra11_uid172_block_rsrvd_fix_in <= redist25_fracAddResult_farPath_uid141_block_rsrvd_fix_q_1_q(56 downto 0);
    extra11_uid172_block_rsrvd_fix_b <= extra11_uid172_block_rsrvd_fix_in(56 downto 55);

    -- m01_uid177_block_rsrvd_fix(BITJOIN,176)@10
    m01_uid177_block_rsrvd_fix_q <= extra01_uid176_block_rsrvd_fix_b & GND_q;

    -- stickyExtraBits_uid179_block_rsrvd_fix(MUX,178)@10
    stickyExtraBits_uid179_block_rsrvd_fix_s <= normBits_farPathRnd_uid155_block_rsrvd_fix_q;
    stickyExtraBits_uid179_block_rsrvd_fix_combproc: PROCESS (stickyExtraBits_uid179_block_rsrvd_fix_s, cst2zeros_uid170_block_rsrvd_fix_q, m01_uid177_block_rsrvd_fix_q, extra11_uid172_block_rsrvd_fix_b)
    BEGIN
        CASE (stickyExtraBits_uid179_block_rsrvd_fix_s) IS
            WHEN "00" => stickyExtraBits_uid179_block_rsrvd_fix_q <= cst2zeros_uid170_block_rsrvd_fix_q;
            WHEN "01" => stickyExtraBits_uid179_block_rsrvd_fix_q <= m01_uid177_block_rsrvd_fix_q;
            WHEN "10" => stickyExtraBits_uid179_block_rsrvd_fix_q <= extra11_uid172_block_rsrvd_fix_b;
            WHEN "11" => stickyExtraBits_uid179_block_rsrvd_fix_q <= extra11_uid172_block_rsrvd_fix_b;
            WHEN OTHERS => stickyExtraBits_uid179_block_rsrvd_fix_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- stickyAllBits_uid180_block_rsrvd_fix(BITJOIN,179)@10
    stickyAllBits_uid180_block_rsrvd_fix_q <= stickyPreMux_uid143_block_rsrvd_fix_q & stickyExtraBits_uid179_block_rsrvd_fix_q;

    -- sticky_uid181_block_rsrvd_fix(LOGICAL,180)@10
    sticky_uid181_block_rsrvd_fix_q <= "1" WHEN stickyAllBits_uid180_block_rsrvd_fix_q /= "000" ELSE "0";

    -- concBits_uid197_block_rsrvd_fix(BITJOIN,196)@10
    concBits_uid197_block_rsrvd_fix_q <= lBit_uid196_block_rsrvd_fix_b & rBit_uid190_block_rsrvd_fix_q & sticky_uid181_block_rsrvd_fix_q;

    -- IrndVal_uid199_block_rsrvd_fix(LOGICAL,198)@10 + 1
    IrndVal_uid199_block_rsrvd_fix_qi <= "1" WHEN concBits_uid197_block_rsrvd_fix_q = cst2On3Bits_uid198_block_rsrvd_fix_q ELSE "0";
    IrndVal_uid199_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => IrndVal_uid199_block_rsrvd_fix_qi, xout => IrndVal_uid199_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- redist22_IrndVal_uid199_block_rsrvd_fix_q_6(DELAY,458)
    redist22_IrndVal_uid199_block_rsrvd_fix_q_6 : dspba_delay
    GENERIC MAP ( width => 1, depth => 5, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => IrndVal_uid199_block_rsrvd_fix_q, xout => redist22_IrndVal_uid199_block_rsrvd_fix_q_6_q, clk => clock, aclr => resetn );

    -- rndVal_far_uid200_block_rsrvd_fix(LOGICAL,199)@16
    rndVal_far_uid200_block_rsrvd_fix_q <= not (redist22_IrndVal_uid199_block_rsrvd_fix_q_6_q);

    -- redist39_closePath_uid71_block_rsrvd_fix_q_3(DELAY,475)
    redist39_closePath_uid71_block_rsrvd_fix_q_3 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist38_closePath_uid71_block_rsrvd_fix_q_2_q, xout => redist39_closePath_uid71_block_rsrvd_fix_q_3_q, clk => clock, aclr => resetn );

    -- redist40_closePath_uid71_block_rsrvd_fix_q_5(DELAY,476)
    redist40_closePath_uid71_block_rsrvd_fix_q_5 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist39_closePath_uid71_block_rsrvd_fix_q_3_q, xout => redist40_closePath_uid71_block_rsrvd_fix_q_5_q, clk => clock, aclr => resetn );

    -- rndValue_uid211_block_rsrvd_fix(MUX,210)@16 + 1
    rndValue_uid211_block_rsrvd_fix_s <= redist40_closePath_uid71_block_rsrvd_fix_q_5_q;
    rndValue_uid211_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            rndValue_uid211_block_rsrvd_fix_q <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            CASE (rndValue_uid211_block_rsrvd_fix_s) IS
                WHEN "0" => rndValue_uid211_block_rsrvd_fix_q <= rndVal_far_uid200_block_rsrvd_fix_q;
                WHEN "1" => rndValue_uid211_block_rsrvd_fix_q <= rndVal_close_uid204_block_rsrvd_fix_q;
                WHEN OTHERS => rndValue_uid211_block_rsrvd_fix_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- redist31_expAP1_uid97_block_rsrvd_fix_q_2(DELAY,467)
    redist31_expAP1_uid97_block_rsrvd_fix_q_2 : dspba_delay
    GENERIC MAP ( width => 12, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => expAP1_uid97_block_rsrvd_fix_q, xout => redist31_expAP1_uid97_block_rsrvd_fix_q_2_q, clk => clock, aclr => resetn );

    -- expValueClosePath_Case11_uid98_block_rsrvd_fix(BITSELECT,97)@13
    expValueClosePath_Case11_uid98_block_rsrvd_fix_in <= redist31_expAP1_uid97_block_rsrvd_fix_q_2_q(10 downto 0);
    expValueClosePath_Case11_uid98_block_rsrvd_fix_b <= expValueClosePath_Case11_uid98_block_rsrvd_fix_in(10 downto 0);

    -- case11Exponent_uid107_block_rsrvd_fix(LOGICAL,106)@13
    case11Exponent_uid107_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((10 downto 1 => case11_uid104_block_rsrvd_fix_q(0)) & case11_uid104_block_rsrvd_fix_q));
    case11Exponent_uid107_block_rsrvd_fix_q <= expValueClosePath_Case11_uid98_block_rsrvd_fix_b and case11Exponent_uid107_block_rsrvd_fix_b;

    -- expValueClosePathExt_uid109_block_rsrvd_fix(LOGICAL,108)@13 + 1
    expValueClosePathExt_uid109_block_rsrvd_fix_qi <= case0Exponent_uid106_block_rsrvd_fix_q or case11Exponent_uid107_block_rsrvd_fix_q or case12Exponent_uid108_block_rsrvd_fix_q;
    expValueClosePathExt_uid109_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 11, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => expValueClosePathExt_uid109_block_rsrvd_fix_qi, xout => expValueClosePathExt_uid109_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- countValue_farPath00_uid194_block_rsrvd_fix(CONSTANT,193)
    countValue_farPath00_uid194_block_rsrvd_fix_q <= "00000000010";

    -- threeOnTwoBits_uid157_block_rsrvd_fix(CONSTANT,156)
    threeOnTwoBits_uid157_block_rsrvd_fix_q <= "11";

    -- aAndBSubnormalsAndNormalRes_uid153_block_rsrvd_fix(LOGICAL,152)@9
    aAndBSubnormalsAndNormalRes_uid153_block_rsrvd_fix_q <= aZeroOrSubnorm_uid72_block_rsrvd_fix_q and bZeroOrSubnorm_uid73_block_rsrvd_fix_q and normBits_farPathInternal1_uid145_block_rsrvd_fix_merged_bit_select_c and invNormBits_farPathInternal1_uid146_block_rsrvd_fix_q;

    -- aAndBSubnormalCst_uid159_block_rsrvd_fix(MUX,158)@9
    aAndBSubnormalCst_uid159_block_rsrvd_fix_s <= aAndBSubnormalsAndNormalRes_uid153_block_rsrvd_fix_q;
    aAndBSubnormalCst_uid159_block_rsrvd_fix_combproc: PROCESS (aAndBSubnormalCst_uid159_block_rsrvd_fix_s, oneOnTwoBits_uid154_block_rsrvd_fix_q, threeOnTwoBits_uid157_block_rsrvd_fix_q)
    BEGIN
        CASE (aAndBSubnormalCst_uid159_block_rsrvd_fix_s) IS
            WHEN "0" => aAndBSubnormalCst_uid159_block_rsrvd_fix_q <= oneOnTwoBits_uid154_block_rsrvd_fix_q;
            WHEN "1" => aAndBSubnormalCst_uid159_block_rsrvd_fix_q <= threeOnTwoBits_uid157_block_rsrvd_fix_q;
            WHEN OTHERS => aAndBSubnormalCst_uid159_block_rsrvd_fix_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- aAndBSubnormal_uid156_block_rsrvd_fix(LOGICAL,155)@9
    aAndBSubnormal_uid156_block_rsrvd_fix_q <= aZeroOrSubnorm_uid72_block_rsrvd_fix_q and bZeroOrSubnorm_uid73_block_rsrvd_fix_q;

    -- normBits_farPathCnt_uid160_block_rsrvd_fix(MUX,159)@9 + 1
    normBits_farPathCnt_uid160_block_rsrvd_fix_s <= aAndBSubnormal_uid156_block_rsrvd_fix_q;
    normBits_farPathCnt_uid160_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            normBits_farPathCnt_uid160_block_rsrvd_fix_q <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            CASE (normBits_farPathCnt_uid160_block_rsrvd_fix_s) IS
                WHEN "0" => normBits_farPathCnt_uid160_block_rsrvd_fix_q <= normBits_farPath_uid144_block_rsrvd_fix_b;
                WHEN "1" => normBits_farPathCnt_uid160_block_rsrvd_fix_q <= aAndBSubnormalCst_uid159_block_rsrvd_fix_q;
                WHEN OTHERS => normBits_farPathCnt_uid160_block_rsrvd_fix_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- redist24_normBits_farPathCnt_uid160_block_rsrvd_fix_q_5(DELAY,460)
    redist24_normBits_farPathCnt_uid160_block_rsrvd_fix_q_5 : dspba_delay
    GENERIC MAP ( width => 2, depth => 4, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => normBits_farPathCnt_uid160_block_rsrvd_fix_q, xout => redist24_normBits_farPathCnt_uid160_block_rsrvd_fix_q_5_q, clk => clock, aclr => resetn );

    -- countValue_farPath_uid195_block_rsrvd_fix(MUX,194)@14
    countValue_farPath_uid195_block_rsrvd_fix_s <= redist24_normBits_farPathCnt_uid160_block_rsrvd_fix_q_5_q;
    countValue_farPath_uid195_block_rsrvd_fix_combproc: PROCESS (countValue_farPath_uid195_block_rsrvd_fix_s, countValue_farPath00_uid194_block_rsrvd_fix_q, expValueClosePath_Case0_uid96_block_rsrvd_fix_q, cstAllZWE_uid21_block_rsrvd_fix_q)
    BEGIN
        CASE (countValue_farPath_uid195_block_rsrvd_fix_s) IS
            WHEN "00" => countValue_farPath_uid195_block_rsrvd_fix_q <= countValue_farPath00_uid194_block_rsrvd_fix_q;
            WHEN "01" => countValue_farPath_uid195_block_rsrvd_fix_q <= expValueClosePath_Case0_uid96_block_rsrvd_fix_q;
            WHEN "10" => countValue_farPath_uid195_block_rsrvd_fix_q <= cstAllZWE_uid21_block_rsrvd_fix_q;
            WHEN "11" => countValue_farPath_uid195_block_rsrvd_fix_q <= cstAllZWE_uid21_block_rsrvd_fix_q;
            WHEN OTHERS => countValue_farPath_uid195_block_rsrvd_fix_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- countValue_uid205_block_rsrvd_fix(MUX,204)@14 + 1
    countValue_uid205_block_rsrvd_fix_s <= redist39_closePath_uid71_block_rsrvd_fix_q_3_q;
    countValue_uid205_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            countValue_uid205_block_rsrvd_fix_q <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            CASE (countValue_uid205_block_rsrvd_fix_s) IS
                WHEN "0" => countValue_uid205_block_rsrvd_fix_q <= countValue_farPath_uid195_block_rsrvd_fix_q;
                WHEN "1" => countValue_uid205_block_rsrvd_fix_q <= expValueClosePathExt_uid109_block_rsrvd_fix_q;
                WHEN OTHERS => countValue_uid205_block_rsrvd_fix_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- redist32_expAP1_uid97_block_rsrvd_fix_q_4(DELAY,468)
    redist32_expAP1_uid97_block_rsrvd_fix_q_4 : dspba_delay
    GENERIC MAP ( width => 12, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist31_expAP1_uid97_block_rsrvd_fix_q_2_q, xout => redist32_expAP1_uid97_block_rsrvd_fix_q_4_q, clk => clock, aclr => resetn );

    -- expPostNorm_uid207_block_rsrvd_fix(SUB,206)@15 + 1
    expPostNorm_uid207_block_rsrvd_fix_a <= STD_LOGIC_VECTOR("0" & redist32_expAP1_uid97_block_rsrvd_fix_q_4_q);
    expPostNorm_uid207_block_rsrvd_fix_b <= STD_LOGIC_VECTOR("00" & countValue_uid205_block_rsrvd_fix_q);
    expPostNorm_uid207_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            expPostNorm_uid207_block_rsrvd_fix_o <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            expPostNorm_uid207_block_rsrvd_fix_o <= STD_LOGIC_VECTOR(UNSIGNED(expPostNorm_uid207_block_rsrvd_fix_a) - UNSIGNED(expPostNorm_uid207_block_rsrvd_fix_b));
        END IF;
    END PROCESS;
    expPostNorm_uid207_block_rsrvd_fix_q <= expPostNorm_uid207_block_rsrvd_fix_o(12 downto 0);

    -- redist21_expPostNorm_uid207_block_rsrvd_fix_q_2(DELAY,457)
    redist21_expPostNorm_uid207_block_rsrvd_fix_q_2 : dspba_delay
    GENERIC MAP ( width => 13, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => expPostNorm_uid207_block_rsrvd_fix_q, xout => redist21_expPostNorm_uid207_block_rsrvd_fix_q_2_q, clk => clock, aclr => resetn );

    -- redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_notEnable(LOGICAL,532)
    redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_nor(LOGICAL,533)
    redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_nor_q <= not (redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_notEnable_q or redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_sticky_ena_q);

    -- redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_mem_last(CONSTANT,529)
    redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_mem_last_q <= "01";

    -- redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_cmp(LOGICAL,530)
    redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_cmp_q <= "1" WHEN redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_mem_last_q = redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_rdcnt_q ELSE "0";

    -- redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_cmpReg(REG,531)
    redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_cmpReg_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_cmpReg_q <= "0";
        ELSIF (clock'EVENT AND clock = '1') THEN
            redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_cmpReg_q <= STD_LOGIC_VECTOR(redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_cmp_q);
        END IF;
    END PROCESS;

    -- redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_sticky_ena(REG,534)
    redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_sticky_ena_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_sticky_ena_q <= "0";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_nor_q = "1") THEN
                redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_sticky_ena_q <= STD_LOGIC_VECTOR(redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_enaAnd(LOGICAL,535)
    redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_enaAnd_q <= redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_sticky_ena_q and VCC_q;

    -- redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_rdcnt(COUNTER,527)
    -- low=0, high=2, step=1, init=0
    redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_rdcnt_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_rdcnt_i <= TO_UNSIGNED(0, 2);
            redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_rdcnt_eq <= '0';
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_rdcnt_i = TO_UNSIGNED(1, 2)) THEN
                redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_rdcnt_eq <= '1';
            ELSE
                redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_rdcnt_eq <= '0';
            END IF;
            IF (redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_rdcnt_eq = '1') THEN
                redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_rdcnt_i <= redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_rdcnt_i + 2;
            ELSE
                redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_rdcnt_i <= redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_rdcnt_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_rdcnt_i, 2)));

    -- redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_inputreg(DELAY,524)
    redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_inputreg : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => fracPostNorm_farPath_uid169_block_rsrvd_fix_q, xout => redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_inputreg_q, clk => clock, aclr => resetn );

    -- redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_wraddr(REG,528)
    redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_wraddr_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_wraddr_q <= "10";
        ELSIF (clock'EVENT AND clock = '1') THEN
            redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_wraddr_q <= STD_LOGIC_VECTOR(redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_rdcnt_q);
        END IF;
    END PROCESS;

    -- redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_mem(DUALMEM,526)
    redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_mem_ia <= STD_LOGIC_VECTOR(redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_inputreg_q);
    redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_mem_aa <= redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_wraddr_q;
    redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_mem_ab <= redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_rdcnt_q;
    redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_mem_reset0 <= not (resetn);
    redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 53,
        widthad_a => 2,
        numwords_a => 3,
        width_b => 53,
        widthad_b => 2,
        numwords_b => 3,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_aclr_b => "CLEAR1",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Cyclone V"
    )
    PORT MAP (
        clocken1 => redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_enaAnd_q(0),
        clocken0 => VCC_q(0),
        clock0 => clock,
        aclr1 => redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_mem_reset0,
        clock1 => clock,
        address_a => redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_mem_aa,
        data_a => redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_mem_ab,
        q_b => redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_mem_iq
    );
    redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_mem_q <= redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_mem_iq(52 downto 0);

    -- redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_outputreg(DELAY,525)
    redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_outputreg : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_mem_q, xout => redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_outputreg_q, clk => clock, aclr => resetn );

    -- fracPostNormPreRnd_uid210_block_rsrvd_fix(MUX,209)@16 + 1
    fracPostNormPreRnd_uid210_block_rsrvd_fix_s <= redist40_closePath_uid71_block_rsrvd_fix_q_5_q;
    fracPostNormPreRnd_uid210_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            fracPostNormPreRnd_uid210_block_rsrvd_fix_q <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            CASE (fracPostNormPreRnd_uid210_block_rsrvd_fix_s) IS
                WHEN "0" => fracPostNormPreRnd_uid210_block_rsrvd_fix_q <= redist23_fracPostNorm_farPath_uid169_block_rsrvd_fix_q_6_outputreg_q;
                WHEN "1" => fracPostNormPreRnd_uid210_block_rsrvd_fix_q <= redist30_fracPostNorm_closePath_uid119_block_rsrvd_fix_b_1_q;
                WHEN OTHERS => fracPostNormPreRnd_uid210_block_rsrvd_fix_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- countValFracPostNorm_uid212_block_rsrvd_fix(BITJOIN,211)@17
    countValFracPostNorm_uid212_block_rsrvd_fix_q <= redist21_expPostNorm_uid207_block_rsrvd_fix_q_2_q & fracPostNormPreRnd_uid210_block_rsrvd_fix_q;

    -- countValFracPostRnd_uid213_block_rsrvd_fix(ADD,212)@17
    countValFracPostRnd_uid213_block_rsrvd_fix_a <= STD_LOGIC_VECTOR("0" & countValFracPostNorm_uid212_block_rsrvd_fix_q);
    countValFracPostRnd_uid213_block_rsrvd_fix_b <= STD_LOGIC_VECTOR("000000000000000000000000000000000000000000000000000000000000000000" & rndValue_uid211_block_rsrvd_fix_q);
    countValFracPostRnd_uid213_block_rsrvd_fix_o <= STD_LOGIC_VECTOR(UNSIGNED(countValFracPostRnd_uid213_block_rsrvd_fix_a) + UNSIGNED(countValFracPostRnd_uid213_block_rsrvd_fix_b));
    countValFracPostRnd_uid213_block_rsrvd_fix_q <= countValFracPostRnd_uid213_block_rsrvd_fix_o(66 downto 0);

    -- countValue_uid214_block_rsrvd_fix(BITSELECT,213)@17
    countValue_uid214_block_rsrvd_fix_in <= STD_LOGIC_VECTOR(countValFracPostRnd_uid213_block_rsrvd_fix_q(65 downto 0));
    countValue_uid214_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(countValue_uid214_block_rsrvd_fix_in(65 downto 53));

    -- redist20_countValue_uid214_block_rsrvd_fix_b_1(DELAY,456)
    redist20_countValue_uid214_block_rsrvd_fix_b_1 : dspba_delay
    GENERIC MAP ( width => 13, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => countValue_uid214_block_rsrvd_fix_b, xout => redist20_countValue_uid214_block_rsrvd_fix_b_1_q, clk => clock, aclr => resetn );

    -- expRPreExc_uid220_block_rsrvd_fix(BITSELECT,219)@18
    expRPreExc_uid220_block_rsrvd_fix_in <= redist20_countValue_uid214_block_rsrvd_fix_b_1_q(10 downto 0);
    expRPreExc_uid220_block_rsrvd_fix_b <= expRPreExc_uid220_block_rsrvd_fix_in(10 downto 0);

    -- redist18_expRPreExc_uid220_block_rsrvd_fix_b_2(DELAY,454)
    redist18_expRPreExc_uid220_block_rsrvd_fix_b_2 : dspba_delay
    GENERIC MAP ( width => 11, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => expRPreExc_uid220_block_rsrvd_fix_b, xout => redist18_expRPreExc_uid220_block_rsrvd_fix_b_2_q, clk => clock, aclr => resetn );

    -- wEP2AllOwE_uid216_block_rsrvd_fix(CONSTANT,215)
    wEP2AllOwE_uid216_block_rsrvd_fix_q <= "0011111111111";

    -- rOvf_uid218_block_rsrvd_fix(COMPARE,217)@18 + 1
    rOvf_uid218_block_rsrvd_fix_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((15 downto 13 => redist20_countValue_uid214_block_rsrvd_fix_b_1_q(12)) & redist20_countValue_uid214_block_rsrvd_fix_b_1_q));
    rOvf_uid218_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & wEP2AllOwE_uid216_block_rsrvd_fix_q));
    rOvf_uid218_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            rOvf_uid218_block_rsrvd_fix_o <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            rOvf_uid218_block_rsrvd_fix_o <= STD_LOGIC_VECTOR(SIGNED(rOvf_uid218_block_rsrvd_fix_a) - SIGNED(rOvf_uid218_block_rsrvd_fix_b));
        END IF;
    END PROCESS;
    rOvf_uid218_block_rsrvd_fix_n(0) <= not (rOvf_uid218_block_rsrvd_fix_o(15));

    -- regInputs_uid221_block_rsrvd_fix(LOGICAL,220)@12 + 1
    regInputs_uid221_block_rsrvd_fix_qi <= redist60_excR_aSig_uid33_block_rsrvd_fix_q_4_q and redist51_excR_bSig_uid50_block_rsrvd_fix_q_9_q;
    regInputs_uid221_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => regInputs_uid221_block_rsrvd_fix_qi, xout => regInputs_uid221_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- redist17_regInputs_uid221_block_rsrvd_fix_q_7(DELAY,453)
    redist17_regInputs_uid221_block_rsrvd_fix_q_7 : dspba_delay
    GENERIC MAP ( width => 1, depth => 6, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => regInputs_uid221_block_rsrvd_fix_q, xout => redist17_regInputs_uid221_block_rsrvd_fix_q_7_q, clk => clock, aclr => resetn );

    -- rInfOvf_uid224_block_rsrvd_fix(LOGICAL,223)@19
    rInfOvf_uid224_block_rsrvd_fix_q <= redist17_regInputs_uid221_block_rsrvd_fix_q_7_q and rOvf_uid218_block_rsrvd_fix_n;

    -- excRInfVInC_uid225_block_rsrvd_fix(BITJOIN,224)@19
    excRInfVInC_uid225_block_rsrvd_fix_q <= rInfOvf_uid224_block_rsrvd_fix_q & redist52_excN_bSig_uid47_block_rsrvd_fix_q_16_q & redist62_excN_aSig_uid30_block_rsrvd_fix_q_11_q & redist54_excI_bSig_uid46_block_rsrvd_fix_q_16_q & redist64_excI_aSig_uid29_block_rsrvd_fix_q_11_q & redist44_effSub_uid59_block_rsrvd_fix_q_16_q;

    -- excRInf_uid226_block_rsrvd_fix(LOOKUP,225)@19
    excRInf_uid226_block_rsrvd_fix_combproc: PROCESS (excRInfVInC_uid225_block_rsrvd_fix_q)
    BEGIN
        -- Begin reserved scope level
        CASE (excRInfVInC_uid225_block_rsrvd_fix_q) IS
            WHEN "000000" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "000001" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "000010" => excRInf_uid226_block_rsrvd_fix_q <= "1";
            WHEN "000011" => excRInf_uid226_block_rsrvd_fix_q <= "1";
            WHEN "000100" => excRInf_uid226_block_rsrvd_fix_q <= "1";
            WHEN "000101" => excRInf_uid226_block_rsrvd_fix_q <= "1";
            WHEN "000110" => excRInf_uid226_block_rsrvd_fix_q <= "1";
            WHEN "000111" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "001000" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "001001" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "001010" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "001011" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "001100" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "001101" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "001110" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "001111" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "010000" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "010001" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "010010" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "010011" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "010100" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "010101" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "010110" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "010111" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "011000" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "011001" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "011010" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "011011" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "011100" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "011101" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "011110" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "011111" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "100000" => excRInf_uid226_block_rsrvd_fix_q <= "1";
            WHEN "100001" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "100010" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "100011" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "100100" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "100101" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "100110" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "100111" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "101000" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "101001" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "101010" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "101011" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "101100" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "101101" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "101110" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "101111" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "110000" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "110001" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "110010" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "110011" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "110100" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "110101" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "110110" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "110111" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "111000" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "111001" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "111010" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "111011" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "111100" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "111101" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "111110" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN "111111" => excRInf_uid226_block_rsrvd_fix_q <= "0";
            WHEN OTHERS => -- unreachable
                           excRInf_uid226_block_rsrvd_fix_q <= (others => '-');
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- excRZeroVInC_uid222_block_rsrvd_fix(BITJOIN,221)@12
    excRZeroVInC_uid222_block_rsrvd_fix_q <= aMinusA_uid122_block_rsrvd_fix_q & redist56_excZ_bSig_uid45_block_rsrvd_fix_q_9_q & redist65_excZ_aSig_uid28_block_rsrvd_fix_q_4_q;

    -- excRZero_uid223_block_rsrvd_fix(LOOKUP,222)@12 + 1
    excRZero_uid223_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            excRZero_uid223_block_rsrvd_fix_q <= "0";
        ELSIF (clock'EVENT AND clock = '1') THEN
            CASE (excRZeroVInC_uid222_block_rsrvd_fix_q) IS
                WHEN "000" => excRZero_uid223_block_rsrvd_fix_q <= "0";
                WHEN "001" => excRZero_uid223_block_rsrvd_fix_q <= "0";
                WHEN "010" => excRZero_uid223_block_rsrvd_fix_q <= "0";
                WHEN "011" => excRZero_uid223_block_rsrvd_fix_q <= "1";
                WHEN "100" => excRZero_uid223_block_rsrvd_fix_q <= "1";
                WHEN "101" => excRZero_uid223_block_rsrvd_fix_q <= "1";
                WHEN "110" => excRZero_uid223_block_rsrvd_fix_q <= "1";
                WHEN "111" => excRZero_uid223_block_rsrvd_fix_q <= "1";
                WHEN OTHERS => -- unreachable
                               excRZero_uid223_block_rsrvd_fix_q <= (others => '-');
            END CASE;
        END IF;
    END PROCESS;

    -- redist16_excRZero_uid223_block_rsrvd_fix_q_7(DELAY,452)
    redist16_excRZero_uid223_block_rsrvd_fix_q_7 : dspba_delay
    GENERIC MAP ( width => 1, depth => 6, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excRZero_uid223_block_rsrvd_fix_q, xout => redist16_excRZero_uid223_block_rsrvd_fix_q_7_q, clk => clock, aclr => resetn );

    -- concExc_uid230_block_rsrvd_fix(BITJOIN,229)@19
    concExc_uid230_block_rsrvd_fix_q <= excRNaN_uid229_block_rsrvd_fix_q & excRInf_uid226_block_rsrvd_fix_q & redist16_excRZero_uid223_block_rsrvd_fix_q_7_q;

    -- redist15_concExc_uid230_block_rsrvd_fix_q_1(DELAY,451)
    redist15_concExc_uid230_block_rsrvd_fix_q_1 : dspba_delay
    GENERIC MAP ( width => 3, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => concExc_uid230_block_rsrvd_fix_q, xout => redist15_concExc_uid230_block_rsrvd_fix_q_1_q, clk => clock, aclr => resetn );

    -- excREnc_uid231_block_rsrvd_fix(LOOKUP,230)@20
    excREnc_uid231_block_rsrvd_fix_combproc: PROCESS (redist15_concExc_uid230_block_rsrvd_fix_q_1_q)
    BEGIN
        -- Begin reserved scope level
        CASE (redist15_concExc_uid230_block_rsrvd_fix_q_1_q) IS
            WHEN "000" => excREnc_uid231_block_rsrvd_fix_q <= "01";
            WHEN "001" => excREnc_uid231_block_rsrvd_fix_q <= "00";
            WHEN "010" => excREnc_uid231_block_rsrvd_fix_q <= "10";
            WHEN "011" => excREnc_uid231_block_rsrvd_fix_q <= "10";
            WHEN "100" => excREnc_uid231_block_rsrvd_fix_q <= "11";
            WHEN "101" => excREnc_uid231_block_rsrvd_fix_q <= "11";
            WHEN "110" => excREnc_uid231_block_rsrvd_fix_q <= "11";
            WHEN "111" => excREnc_uid231_block_rsrvd_fix_q <= "11";
            WHEN OTHERS => -- unreachable
                           excREnc_uid231_block_rsrvd_fix_q <= (others => '-');
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- expRPostExc_uid252_block_rsrvd_fix(MUX,251)@20
    expRPostExc_uid252_block_rsrvd_fix_s <= excREnc_uid231_block_rsrvd_fix_q;
    expRPostExc_uid252_block_rsrvd_fix_combproc: PROCESS (expRPostExc_uid252_block_rsrvd_fix_s, cstAllZWE_uid21_block_rsrvd_fix_q, redist18_expRPreExc_uid220_block_rsrvd_fix_b_2_q, cstAllOWE_uid19_block_rsrvd_fix_q)
    BEGIN
        CASE (expRPostExc_uid252_block_rsrvd_fix_s) IS
            WHEN "00" => expRPostExc_uid252_block_rsrvd_fix_q <= cstAllZWE_uid21_block_rsrvd_fix_q;
            WHEN "01" => expRPostExc_uid252_block_rsrvd_fix_q <= redist18_expRPreExc_uid220_block_rsrvd_fix_b_2_q;
            WHEN "10" => expRPostExc_uid252_block_rsrvd_fix_q <= cstAllOWE_uid19_block_rsrvd_fix_q;
            WHEN "11" => expRPostExc_uid252_block_rsrvd_fix_q <= cstAllOWE_uid19_block_rsrvd_fix_q;
            WHEN OTHERS => expRPostExc_uid252_block_rsrvd_fix_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- oneFracRPostExc2_uid245_block_rsrvd_fix(CONSTANT,244)
    oneFracRPostExc2_uid245_block_rsrvd_fix_q <= "0000000000000000000000000000000000000000000000000001";

    -- fracValue_uid215_block_rsrvd_fix(BITSELECT,214)@17
    fracValue_uid215_block_rsrvd_fix_in <= countValFracPostRnd_uid213_block_rsrvd_fix_q(52 downto 0);
    fracValue_uid215_block_rsrvd_fix_b <= fracValue_uid215_block_rsrvd_fix_in(52 downto 1);

    -- redist19_fracValue_uid215_block_rsrvd_fix_b_3_inputreg(DELAY,523)
    redist19_fracValue_uid215_block_rsrvd_fix_b_3_inputreg : dspba_delay
    GENERIC MAP ( width => 52, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => fracValue_uid215_block_rsrvd_fix_b, xout => redist19_fracValue_uid215_block_rsrvd_fix_b_3_inputreg_q, clk => clock, aclr => resetn );

    -- redist19_fracValue_uid215_block_rsrvd_fix_b_3(DELAY,455)
    redist19_fracValue_uid215_block_rsrvd_fix_b_3 : dspba_delay
    GENERIC MAP ( width => 52, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist19_fracValue_uid215_block_rsrvd_fix_b_3_inputreg_q, xout => redist19_fracValue_uid215_block_rsrvd_fix_b_3_q, clk => clock, aclr => resetn );

    -- fracRPostExc_uid248_block_rsrvd_fix(MUX,247)@20
    fracRPostExc_uid248_block_rsrvd_fix_s <= excREnc_uid231_block_rsrvd_fix_q;
    fracRPostExc_uid248_block_rsrvd_fix_combproc: PROCESS (fracRPostExc_uid248_block_rsrvd_fix_s, cstZeroWF_uid20_block_rsrvd_fix_q, redist19_fracValue_uid215_block_rsrvd_fix_b_3_q, oneFracRPostExc2_uid245_block_rsrvd_fix_q)
    BEGIN
        CASE (fracRPostExc_uid248_block_rsrvd_fix_s) IS
            WHEN "00" => fracRPostExc_uid248_block_rsrvd_fix_q <= cstZeroWF_uid20_block_rsrvd_fix_q;
            WHEN "01" => fracRPostExc_uid248_block_rsrvd_fix_q <= redist19_fracValue_uid215_block_rsrvd_fix_b_3_q;
            WHEN "10" => fracRPostExc_uid248_block_rsrvd_fix_q <= cstZeroWF_uid20_block_rsrvd_fix_q;
            WHEN "11" => fracRPostExc_uid248_block_rsrvd_fix_q <= oneFracRPostExc2_uid245_block_rsrvd_fix_q;
            WHEN OTHERS => fracRPostExc_uid248_block_rsrvd_fix_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- R_uid253_block_rsrvd_fix(BITJOIN,252)@20
    R_uid253_block_rsrvd_fix_q <= signRPostExc_uid244_block_rsrvd_fix_q & expRPostExc_uid252_block_rsrvd_fix_q & fracRPostExc_uid248_block_rsrvd_fix_q;

    -- out_primWireOut(GPOUT,5)@20
    out_primWireOut <= R_uid253_block_rsrvd_fix_q;

END normal;
