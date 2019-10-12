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

-- VHDL created from floatComponent_i_sfc_logic_c0_for_body_matrix_multiply_c0_enter6_matrix_multiplyA0Z2463a0054c2a6342iyc5
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

entity floatComponent_i_sfc_logic_c0_for_body_matrix_multiply_c0_enter6_matrix_multiplyA0Z2463a0054c2a6342iyc5 is
    port (
        in_0 : in std_logic_vector(63 downto 0);  -- float64_m52
        in_1 : in std_logic_vector(63 downto 0);  -- float64_m52
        out_primWireOut : out std_logic_vector(63 downto 0);  -- float64_m52
        clock : in std_logic;
        resetn : in std_logic
    );
end floatComponent_i_sfc_logic_c0_for_body_matrix_multiply_c0_enter6_matrix_multiplyA0Z2463a0054c2a6342iyc5;

architecture normal of floatComponent_i_sfc_logic_c0_for_body_matrix_multiply_c0_enter6_matrix_multiplyA0Z2463a0054c2a6342iyc5 is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expX_uid7_block_rsrvd_fix_b : STD_LOGIC_VECTOR (10 downto 0);
    signal expY_uid8_block_rsrvd_fix_b : STD_LOGIC_VECTOR (10 downto 0);
    signal signX_uid9_block_rsrvd_fix_b : STD_LOGIC_VECTOR (0 downto 0);
    signal signY_uid10_block_rsrvd_fix_b : STD_LOGIC_VECTOR (0 downto 0);
    signal cstAllOWE_uid11_block_rsrvd_fix_q : STD_LOGIC_VECTOR (10 downto 0);
    signal cstZeroWF_uid12_block_rsrvd_fix_q : STD_LOGIC_VECTOR (51 downto 0);
    signal cstAllZWE_uid13_block_rsrvd_fix_q : STD_LOGIC_VECTOR (10 downto 0);
    signal frac_x_uid15_block_rsrvd_fix_b : STD_LOGIC_VECTOR (51 downto 0);
    signal expXIsZero_uid16_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expXIsMax_uid17_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsNotZero_uid19_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excZ_x_uid20_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excZ_x_uid20_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excI_x_uid21_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excI_x_uid21_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excN_x_uid22_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excN_x_uid22_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal invExpXIsMax_uid23_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal InvExpXIsZero_uid24_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excR_x_uid25_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excR_x_uid25_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal frac_y_uid32_block_rsrvd_fix_b : STD_LOGIC_VECTOR (51 downto 0);
    signal expXIsZero_uid33_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expXIsMax_uid34_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsNotZero_uid36_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excZ_y_uid37_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excZ_y_uid37_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excI_y_uid38_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excI_y_uid38_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excN_y_uid39_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excN_y_uid39_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal invExpXIsMax_uid40_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal InvExpXIsZero_uid41_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excR_y_uid42_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excR_y_uid42_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal xIsAnyButSubnorm_uid45_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal xIsSubnorm_uid46_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal yIsAnyButSubnorm_uid47_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal yIsSubnorm_uid48_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ofracX_uid51_block_rsrvd_fix_q : STD_LOGIC_VECTOR (52 downto 0);
    signal ofracY_uid54_block_rsrvd_fix_q : STD_LOGIC_VECTOR (52 downto 0);
    signal cstOneWea_uid55_block_rsrvd_fix_q : STD_LOGIC_VECTOR (10 downto 0);
    signal expXPostSubnorm_uid57_block_rsrvd_fix_s : STD_LOGIC_VECTOR (0 downto 0);
    signal expXPostSubnorm_uid57_block_rsrvd_fix_q : STD_LOGIC_VECTOR (10 downto 0);
    signal expYPostSubnorm_uid58_block_rsrvd_fix_s : STD_LOGIC_VECTOR (0 downto 0);
    signal expYPostSubnorm_uid58_block_rsrvd_fix_q : STD_LOGIC_VECTOR (10 downto 0);
    signal expSum_uid59_block_rsrvd_fix_a : STD_LOGIC_VECTOR (11 downto 0);
    signal expSum_uid59_block_rsrvd_fix_b : STD_LOGIC_VECTOR (11 downto 0);
    signal expSum_uid59_block_rsrvd_fix_o : STD_LOGIC_VECTOR (11 downto 0);
    signal expSum_uid59_block_rsrvd_fix_q : STD_LOGIC_VECTOR (11 downto 0);
    signal biasInc_uid60_block_rsrvd_fix_q : STD_LOGIC_VECTOR (12 downto 0);
    signal expSumMBias_uid61_block_rsrvd_fix_a : STD_LOGIC_VECTOR (14 downto 0);
    signal expSumMBias_uid61_block_rsrvd_fix_b : STD_LOGIC_VECTOR (14 downto 0);
    signal expSumMBias_uid61_block_rsrvd_fix_o : STD_LOGIC_VECTOR (14 downto 0);
    signal expSumMBias_uid61_block_rsrvd_fix_q : STD_LOGIC_VECTOR (13 downto 0);
    signal signR_uid63_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal signR_uid63_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_in : STD_LOGIC_VECTOR (104 downto 0);
    signal prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b : STD_LOGIC_VECTOR (104 downto 0);
    signal prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b : STD_LOGIC_VECTOR (54 downto 0);
    signal prodStickyRange_uid66_block_rsrvd_fix_in : STD_LOGIC_VECTOR (50 downto 0);
    signal prodStickyRange_uid66_block_rsrvd_fix_b : STD_LOGIC_VECTOR (50 downto 0);
    signal prodSticky_uid67_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal prodSticky_uid67_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal top2BitsProd_uid69_block_rsrvd_fix_b : STD_LOGIC_VECTOR (1 downto 0);
    signal xMSB_uid70_block_rsrvd_fix_b : STD_LOGIC_VECTOR (0 downto 0);
    signal cstOneOnTwoBits_uid72_block_rsrvd_fix_q : STD_LOGIC_VECTOR (1 downto 0);
    signal prodInOneTwo_uid73_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal prodInOneTwo_uid73_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal OneTopBitIsOne_uid74_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal prodLessThanOne_uid75_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expSumMBiasGTZero_uid76_block_rsrvd_fix_a : STD_LOGIC_VECTOR (15 downto 0);
    signal expSumMBiasGTZero_uid76_block_rsrvd_fix_b : STD_LOGIC_VECTOR (15 downto 0);
    signal expSumMBiasGTZero_uid76_block_rsrvd_fix_o : STD_LOGIC_VECTOR (15 downto 0);
    signal expSumMBiasGTZero_uid76_block_rsrvd_fix_c : STD_LOGIC_VECTOR (0 downto 0);
    signal expSumMBiasGTZero_uid76_block_rsrvd_fix_n : STD_LOGIC_VECTOR (0 downto 0);
    signal expSumMBiasEQZero_uid79_block_rsrvd_fix_b : STD_LOGIC_VECTOR (13 downto 0);
    signal expSumMBiasEQZero_uid79_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal expSumMBiasEQZero_uid79_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal case0_uid80_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal case1_uid81_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal case2_uid82_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal case3_uid83_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal case4_uid84_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal case5_uid85_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal case5_uid85_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal subnormRightShiftValueTerm2_uid86_block_rsrvd_fix_b : STD_LOGIC_VECTOR (13 downto 0);
    signal subnormRightShiftValueTerm2_uid86_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (13 downto 0);
    signal subnormRightShiftValueTerm2_uid86_block_rsrvd_fix_q : STD_LOGIC_VECTOR (13 downto 0);
    signal secondCond_uid87_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal secondCond2_uid88_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal secondCond2_uid88_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal subnormRightShiftValue_uid89_block_rsrvd_fix_a : STD_LOGIC_VECTOR (15 downto 0);
    signal subnormRightShiftValue_uid89_block_rsrvd_fix_b : STD_LOGIC_VECTOR (15 downto 0);
    signal subnormRightShiftValue_uid89_block_rsrvd_fix_o : STD_LOGIC_VECTOR (15 downto 0);
    signal subnormRightShiftValue_uid89_block_rsrvd_fix_q : STD_LOGIC_VECTOR (14 downto 0);
    signal padConst_uid90_block_rsrvd_fix_q : STD_LOGIC_VECTOR (54 downto 0);
    signal rightPaddedIn_uid91_block_rsrvd_fix_q : STD_LOGIC_VECTOR (109 downto 0);
    signal stickySubnormalRange_uid93_block_rsrvd_fix_in : STD_LOGIC_VECTOR (54 downto 0);
    signal stickySubnormalRange_uid93_block_rsrvd_fix_b : STD_LOGIC_VECTOR (54 downto 0);
    signal stickySubnormal_uid94_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal stickySubnormal_uid94_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal stickySubnormalRnd_uid95_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal lS_uid96_block_rsrvd_fix_in : STD_LOGIC_VECTOR (56 downto 0);
    signal lS_uid96_block_rsrvd_fix_b : STD_LOGIC_VECTOR (0 downto 0);
    signal rS_uid97_block_rsrvd_fix_in : STD_LOGIC_VECTOR (55 downto 0);
    signal rS_uid97_block_rsrvd_fix_b : STD_LOGIC_VECTOR (0 downto 0);
    signal postRightShiftProdR_uid98_block_rsrvd_fix_in : STD_LOGIC_VECTOR (107 downto 0);
    signal postRightShiftProdR_uid98_block_rsrvd_fix_b : STD_LOGIC_VECTOR (52 downto 0);
    signal stickySubnormalRnd0_uid99_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal lS0_uid100_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal rndValueSInv_uid101_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal rndValueSInv_uid101_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal rndValueS_uid102_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal subnormLeftShiftValue_uid104_block_rsrvd_fix_a : STD_LOGIC_VECTOR (15 downto 0);
    signal subnormLeftShiftValue_uid104_block_rsrvd_fix_b : STD_LOGIC_VECTOR (15 downto 0);
    signal subnormLeftShiftValue_uid104_block_rsrvd_fix_o : STD_LOGIC_VECTOR (15 downto 0);
    signal subnormLeftShiftValue_uid104_block_rsrvd_fix_q : STD_LOGIC_VECTOR (14 downto 0);
    signal lzGTELepLeftShift_uid105_block_rsrvd_fix_a : STD_LOGIC_VECTOR (15 downto 0);
    signal lzGTELepLeftShift_uid105_block_rsrvd_fix_b : STD_LOGIC_VECTOR (15 downto 0);
    signal lzGTELepLeftShift_uid105_block_rsrvd_fix_o : STD_LOGIC_VECTOR (15 downto 0);
    signal lzGTELepLeftShift_uid105_block_rsrvd_fix_n : STD_LOGIC_VECTOR (0 downto 0);
    signal lzu_to15_uid106_in : STD_LOGIC_VECTOR (14 downto 0);
    signal lzu_to15_uid106_b : STD_LOGIC_VECTOR (14 downto 0);
    signal leftShiftValueBothCases_uid107_block_rsrvd_fix_s : STD_LOGIC_VECTOR (0 downto 0);
    signal leftShiftValueBothCases_uid107_block_rsrvd_fix_q : STD_LOGIC_VECTOR (14 downto 0);
    signal stickyLeftShift_uid111_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal stickyLeftShift_uid111_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal stickyLeftShift0_uid114_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal lBitLeftShift0_uid115_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal rndValueSLeftInv_uid116_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal rndValueSLeft_uid117_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracInRnd_uid118_block_rsrvd_fix_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fracInRnd_uid118_block_rsrvd_fix_q : STD_LOGIC_VECTOR (52 downto 0);
    signal rndVal_uid119_block_rsrvd_fix_s : STD_LOGIC_VECTOR (0 downto 0);
    signal rndVal_uid119_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracRnd_uid120_block_rsrvd_fix_a : STD_LOGIC_VECTOR (53 downto 0);
    signal fracRnd_uid120_block_rsrvd_fix_b : STD_LOGIC_VECTOR (53 downto 0);
    signal fracRnd_uid120_block_rsrvd_fix_o : STD_LOGIC_VECTOR (53 downto 0);
    signal fracRnd_uid120_block_rsrvd_fix_q : STD_LOGIC_VECTOR (53 downto 0);
    signal fracRPreExc_uid121_block_rsrvd_fix_in : STD_LOGIC_VECTOR (52 downto 0);
    signal fracRPreExc_uid121_block_rsrvd_fix_b : STD_LOGIC_VECTOR (51 downto 0);
    signal expIncrement_uid122_block_rsrvd_fix_b : STD_LOGIC_VECTOR (0 downto 0);
    signal expSumMBiasP1_uid124_block_rsrvd_fix_a : STD_LOGIC_VECTOR (15 downto 0);
    signal expSumMBiasP1_uid124_block_rsrvd_fix_b : STD_LOGIC_VECTOR (15 downto 0);
    signal expSumMBiasP1_uid124_block_rsrvd_fix_o : STD_LOGIC_VECTOR (15 downto 0);
    signal expSumMBiasP1_uid124_block_rsrvd_fix_q : STD_LOGIC_VECTOR (14 downto 0);
    signal expSumMBiasMLZ_uid125_block_rsrvd_fix_a : STD_LOGIC_VECTOR (15 downto 0);
    signal expSumMBiasMLZ_uid125_block_rsrvd_fix_b : STD_LOGIC_VECTOR (15 downto 0);
    signal expSumMBiasMLZ_uid125_block_rsrvd_fix_o : STD_LOGIC_VECTOR (15 downto 0);
    signal expSumMBiasMLZ_uid125_block_rsrvd_fix_q : STD_LOGIC_VECTOR (14 downto 0);
    signal sel0r_uid126_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal cst02bit_uid127_block_rsrvd_fix_q : STD_LOGIC_VECTOR (1 downto 0);
    signal sel0_uid128_block_rsrvd_fix_b : STD_LOGIC_VECTOR (1 downto 0);
    signal sel0_uid128_block_rsrvd_fix_q : STD_LOGIC_VECTOR (1 downto 0);
    signal expGTE0_uid129_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal sel1r_uid130_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal sel1_uid132_block_rsrvd_fix_b : STD_LOGIC_VECTOR (1 downto 0);
    signal sel1_uid132_block_rsrvd_fix_q : STD_LOGIC_VECTOR (1 downto 0);
    signal case5WithlzGTELepLeftShift_uid133_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal sel2r_uid134_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal cst22bit_uid135_block_rsrvd_fix_q : STD_LOGIC_VECTOR (1 downto 0);
    signal sel2_uid136_block_rsrvd_fix_b : STD_LOGIC_VECTOR (1 downto 0);
    signal sel2_uid136_block_rsrvd_fix_q : STD_LOGIC_VECTOR (1 downto 0);
    signal invLZGTELepLeftShift_uid137_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal sel3r_uid138_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal cst32bit_uid139_block_rsrvd_fix_q : STD_LOGIC_VECTOR (1 downto 0);
    signal sel3_uid140_block_rsrvd_fix_b : STD_LOGIC_VECTOR (1 downto 0);
    signal sel3_uid140_block_rsrvd_fix_q : STD_LOGIC_VECTOR (1 downto 0);
    signal muxSel_uid141_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (1 downto 0);
    signal muxSel_uid141_block_rsrvd_fix_q : STD_LOGIC_VECTOR (1 downto 0);
    signal zeroExtBits_to15_uid142_in : STD_LOGIC_VECTOR (14 downto 0);
    signal zeroExtBits_to15_uid142_b : STD_LOGIC_VECTOR (14 downto 0);
    signal expSumMBias_to15_uid144_in : STD_LOGIC_VECTOR (14 downto 0);
    signal expSumMBias_to15_uid144_b : STD_LOGIC_VECTOR (14 downto 0);
    signal expRPre_uid145_block_rsrvd_fix_s : STD_LOGIC_VECTOR (1 downto 0);
    signal expRPre_uid145_block_rsrvd_fix_q : STD_LOGIC_VECTOR (14 downto 0);
    signal expRPreExc_uid146_block_rsrvd_fix_a : STD_LOGIC_VECTOR (16 downto 0);
    signal expRPreExc_uid146_block_rsrvd_fix_b : STD_LOGIC_VECTOR (16 downto 0);
    signal expRPreExc_uid146_block_rsrvd_fix_o : STD_LOGIC_VECTOR (16 downto 0);
    signal expRPreExc_uid146_block_rsrvd_fix_q : STD_LOGIC_VECTOR (15 downto 0);
    signal expOvf_uid149_block_rsrvd_fix_a : STD_LOGIC_VECTOR (17 downto 0);
    signal expOvf_uid149_block_rsrvd_fix_b : STD_LOGIC_VECTOR (17 downto 0);
    signal expOvf_uid149_block_rsrvd_fix_o : STD_LOGIC_VECTOR (17 downto 0);
    signal expOvf_uid149_block_rsrvd_fix_n : STD_LOGIC_VECTOR (0 downto 0);
    signal excXZAndExcYZ_uid150_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXRSub_uid151_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excYRSub_uid152_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXZAndExcYR_uid153_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excYZAndExcXR_uid154_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excZC3_uid155_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRZero_uid156_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excRZero_uid156_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXIAndExcYI_uid157_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excXIAndExcYI_uid157_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXRAndExcYI_uid160_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excXRAndExcYI_uid160_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excYRAndExcXI_uid161_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excYRAndExcXI_uid161_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ExcROvfAndInReg_uid162_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRInf_uid163_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excYZAndExcXI_uid164_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excXZAndExcYI_uid165_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal ZeroTimesInf_uid166_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRNaN_uid167_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excRNaN_uid167_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal concExc_uid168_block_rsrvd_fix_q : STD_LOGIC_VECTOR (2 downto 0);
    signal excREnc_uid169_block_rsrvd_fix_q : STD_LOGIC_VECTOR (1 downto 0);
    signal oneFracRPostExc2_uid170_block_rsrvd_fix_q : STD_LOGIC_VECTOR (51 downto 0);
    signal fracRPostExc_uid173_block_rsrvd_fix_s : STD_LOGIC_VECTOR (1 downto 0);
    signal fracRPostExc_uid173_block_rsrvd_fix_q : STD_LOGIC_VECTOR (51 downto 0);
    signal expRFinal_uid176_block_rsrvd_fix_in : STD_LOGIC_VECTOR (10 downto 0);
    signal expRFinal_uid176_block_rsrvd_fix_b : STD_LOGIC_VECTOR (10 downto 0);
    signal expRPostExc_uid178_block_rsrvd_fix_s : STD_LOGIC_VECTOR (1 downto 0);
    signal expRPostExc_uid178_block_rsrvd_fix_q : STD_LOGIC_VECTOR (10 downto 0);
    signal invExcRNaN_uid179_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal signRPostExc_uid180_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal signRPostExc_uid180_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal R_uid181_block_rsrvd_fix_q : STD_LOGIC_VECTOR (63 downto 0);
    signal aboveLeftY_mergedSignalTM_uid189_prod_uid62_block_rsrvd_fix_q : STD_LOGIC_VECTOR (26 downto 0);
    signal rightBottomX_mergedSignalTM_uid193_prod_uid62_block_rsrvd_fix_q : STD_LOGIC_VECTOR (26 downto 0);
    signal add0_uid207_prod_uid62_block_rsrvd_fix_q : STD_LOGIC_VECTOR (107 downto 0);
    signal lowRangeB_uid208_prod_uid62_block_rsrvd_fix_in : STD_LOGIC_VECTOR (26 downto 0);
    signal lowRangeB_uid208_prod_uid62_block_rsrvd_fix_b : STD_LOGIC_VECTOR (26 downto 0);
    signal add1_uid211_prod_uid62_block_rsrvd_fix_q : STD_LOGIC_VECTOR (108 downto 0);
    signal osig_uid212_prod_uid62_block_rsrvd_fix_in : STD_LOGIC_VECTOR (107 downto 0);
    signal osig_uid212_prod_uid62_block_rsrvd_fix_b : STD_LOGIC_VECTOR (105 downto 0);
    signal zs_uid214_lz_uid68_block_rsrvd_fix_q : STD_LOGIC_VECTOR (63 downto 0);
    signal rVStage_uid215_lz_uid68_block_rsrvd_fix_b : STD_LOGIC_VECTOR (63 downto 0);
    signal mO_uid217_lz_uid68_block_rsrvd_fix_q : STD_LOGIC_VECTOR (22 downto 0);
    signal vStage_uid218_lz_uid68_block_rsrvd_fix_in : STD_LOGIC_VECTOR (40 downto 0);
    signal vStage_uid218_lz_uid68_block_rsrvd_fix_b : STD_LOGIC_VECTOR (40 downto 0);
    signal cStage_uid219_lz_uid68_block_rsrvd_fix_q : STD_LOGIC_VECTOR (63 downto 0);
    signal vStagei_uid221_lz_uid68_block_rsrvd_fix_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid221_lz_uid68_block_rsrvd_fix_q : STD_LOGIC_VECTOR (63 downto 0);
    signal zs_uid222_lz_uid68_block_rsrvd_fix_q : STD_LOGIC_VECTOR (31 downto 0);
    signal vCount_uid224_lz_uid68_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid227_lz_uid68_block_rsrvd_fix_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid227_lz_uid68_block_rsrvd_fix_q : STD_LOGIC_VECTOR (31 downto 0);
    signal zs_uid228_lz_uid68_block_rsrvd_fix_q : STD_LOGIC_VECTOR (15 downto 0);
    signal vCount_uid230_lz_uid68_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid233_lz_uid68_block_rsrvd_fix_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid233_lz_uid68_block_rsrvd_fix_q : STD_LOGIC_VECTOR (15 downto 0);
    signal zs_uid234_lz_uid68_block_rsrvd_fix_q : STD_LOGIC_VECTOR (7 downto 0);
    signal vCount_uid236_lz_uid68_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid239_lz_uid68_block_rsrvd_fix_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid239_lz_uid68_block_rsrvd_fix_q : STD_LOGIC_VECTOR (7 downto 0);
    signal zs_uid240_lz_uid68_block_rsrvd_fix_q : STD_LOGIC_VECTOR (3 downto 0);
    signal vCount_uid242_lz_uid68_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid245_lz_uid68_block_rsrvd_fix_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid245_lz_uid68_block_rsrvd_fix_q : STD_LOGIC_VECTOR (3 downto 0);
    signal vCount_uid248_lz_uid68_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid251_lz_uid68_block_rsrvd_fix_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid251_lz_uid68_block_rsrvd_fix_q : STD_LOGIC_VECTOR (1 downto 0);
    signal rVStage_uid253_lz_uid68_block_rsrvd_fix_b : STD_LOGIC_VECTOR (0 downto 0);
    signal vCount_uid254_lz_uid68_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal r_uid255_lz_uid68_block_rsrvd_fix_q : STD_LOGIC_VECTOR (6 downto 0);
    signal eq0_uid259_fracXIsZero_uid18_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq1_uid262_fracXIsZero_uid18_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq2_uid265_fracXIsZero_uid18_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq3_uid268_fracXIsZero_uid18_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq4_uid271_fracXIsZero_uid18_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq5_uid274_fracXIsZero_uid18_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq6_uid277_fracXIsZero_uid18_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq7_uid280_fracXIsZero_uid18_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq8_uid283_fracXIsZero_uid18_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal and_lev0_uid284_fracXIsZero_uid18_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal and_lev0_uid284_fracXIsZero_uid18_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal and_lev0_uid285_fracXIsZero_uid18_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal and_lev0_uid285_fracXIsZero_uid18_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal and_lev1_uid286_fracXIsZero_uid18_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq0_uid289_fracXIsZero_uid35_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq1_uid292_fracXIsZero_uid35_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq2_uid295_fracXIsZero_uid35_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq3_uid298_fracXIsZero_uid35_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq4_uid301_fracXIsZero_uid35_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq5_uid304_fracXIsZero_uid35_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq6_uid307_fracXIsZero_uid35_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq7_uid310_fracXIsZero_uid35_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq8_uid313_fracXIsZero_uid35_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal and_lev0_uid314_fracXIsZero_uid35_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal and_lev0_uid314_fracXIsZero_uid35_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal and_lev0_uid315_fracXIsZero_uid35_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal and_lev0_uid315_fracXIsZero_uid35_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal and_lev1_uid316_fracXIsZero_uid35_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expSumMBiasLTZero_uid78_block_rsrvd_fix_cmp_sign_q : STD_LOGIC_VECTOR (0 downto 0);
    signal wIntCst_uid321_postRightShiftProd_uid90_block_rsrvd_fix_q : STD_LOGIC_VECTOR (6 downto 0);
    signal shiftedOut_uid322_postRightShiftProd_uid90_block_rsrvd_fix_a : STD_LOGIC_VECTOR (16 downto 0);
    signal shiftedOut_uid322_postRightShiftProd_uid90_block_rsrvd_fix_b : STD_LOGIC_VECTOR (16 downto 0);
    signal shiftedOut_uid322_postRightShiftProd_uid90_block_rsrvd_fix_o : STD_LOGIC_VECTOR (16 downto 0);
    signal shiftedOut_uid322_postRightShiftProd_uid90_block_rsrvd_fix_n : STD_LOGIC_VECTOR (0 downto 0);
    signal rightShiftStage0Idx1Rng32_uid323_postRightShiftProd_uid90_block_rsrvd_fix_b : STD_LOGIC_VECTOR (77 downto 0);
    signal rightShiftStage0Idx1_uid325_postRightShiftProd_uid90_block_rsrvd_fix_q : STD_LOGIC_VECTOR (109 downto 0);
    signal rightShiftStage0Idx2Rng64_uid326_postRightShiftProd_uid90_block_rsrvd_fix_b : STD_LOGIC_VECTOR (45 downto 0);
    signal rightShiftStage0Idx2_uid328_postRightShiftProd_uid90_block_rsrvd_fix_q : STD_LOGIC_VECTOR (109 downto 0);
    signal rightShiftStage0Idx3Rng96_uid329_postRightShiftProd_uid90_block_rsrvd_fix_b : STD_LOGIC_VECTOR (13 downto 0);
    signal rightShiftStage0Idx3Pad96_uid330_postRightShiftProd_uid90_block_rsrvd_fix_q : STD_LOGIC_VECTOR (95 downto 0);
    signal rightShiftStage0Idx3_uid331_postRightShiftProd_uid90_block_rsrvd_fix_q : STD_LOGIC_VECTOR (109 downto 0);
    signal rightShiftStage0_uid333_postRightShiftProd_uid90_block_rsrvd_fix_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage0_uid333_postRightShiftProd_uid90_block_rsrvd_fix_q : STD_LOGIC_VECTOR (109 downto 0);
    signal rightShiftStage1Idx1Rng8_uid334_postRightShiftProd_uid90_block_rsrvd_fix_b : STD_LOGIC_VECTOR (101 downto 0);
    signal rightShiftStage1Idx1_uid336_postRightShiftProd_uid90_block_rsrvd_fix_q : STD_LOGIC_VECTOR (109 downto 0);
    signal rightShiftStage1Idx2Rng16_uid337_postRightShiftProd_uid90_block_rsrvd_fix_b : STD_LOGIC_VECTOR (93 downto 0);
    signal rightShiftStage1Idx2_uid339_postRightShiftProd_uid90_block_rsrvd_fix_q : STD_LOGIC_VECTOR (109 downto 0);
    signal rightShiftStage1Idx3Rng24_uid340_postRightShiftProd_uid90_block_rsrvd_fix_b : STD_LOGIC_VECTOR (85 downto 0);
    signal rightShiftStage1Idx3Pad24_uid341_postRightShiftProd_uid90_block_rsrvd_fix_q : STD_LOGIC_VECTOR (23 downto 0);
    signal rightShiftStage1Idx3_uid342_postRightShiftProd_uid90_block_rsrvd_fix_q : STD_LOGIC_VECTOR (109 downto 0);
    signal rightShiftStage1_uid344_postRightShiftProd_uid90_block_rsrvd_fix_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage1_uid344_postRightShiftProd_uid90_block_rsrvd_fix_q : STD_LOGIC_VECTOR (109 downto 0);
    signal rightShiftStage2Idx1Rng2_uid345_postRightShiftProd_uid90_block_rsrvd_fix_b : STD_LOGIC_VECTOR (107 downto 0);
    signal rightShiftStage2Idx1_uid347_postRightShiftProd_uid90_block_rsrvd_fix_q : STD_LOGIC_VECTOR (109 downto 0);
    signal rightShiftStage2Idx2Rng4_uid348_postRightShiftProd_uid90_block_rsrvd_fix_b : STD_LOGIC_VECTOR (105 downto 0);
    signal rightShiftStage2Idx2_uid350_postRightShiftProd_uid90_block_rsrvd_fix_q : STD_LOGIC_VECTOR (109 downto 0);
    signal rightShiftStage2Idx3Rng6_uid351_postRightShiftProd_uid90_block_rsrvd_fix_b : STD_LOGIC_VECTOR (103 downto 0);
    signal rightShiftStage2Idx3Pad6_uid352_postRightShiftProd_uid90_block_rsrvd_fix_q : STD_LOGIC_VECTOR (5 downto 0);
    signal rightShiftStage2Idx3_uid353_postRightShiftProd_uid90_block_rsrvd_fix_q : STD_LOGIC_VECTOR (109 downto 0);
    signal rightShiftStage2_uid355_postRightShiftProd_uid90_block_rsrvd_fix_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage2_uid355_postRightShiftProd_uid90_block_rsrvd_fix_q : STD_LOGIC_VECTOR (109 downto 0);
    signal rightShiftStage3Idx1Rng1_uid356_postRightShiftProd_uid90_block_rsrvd_fix_b : STD_LOGIC_VECTOR (108 downto 0);
    signal rightShiftStage3Idx1_uid358_postRightShiftProd_uid90_block_rsrvd_fix_q : STD_LOGIC_VECTOR (109 downto 0);
    signal rightShiftStage3_uid360_postRightShiftProd_uid90_block_rsrvd_fix_s : STD_LOGIC_VECTOR (0 downto 0);
    signal rightShiftStage3_uid360_postRightShiftProd_uid90_block_rsrvd_fix_q : STD_LOGIC_VECTOR (109 downto 0);
    signal zeroOutCst_uid361_postRightShiftProd_uid90_block_rsrvd_fix_q : STD_LOGIC_VECTOR (109 downto 0);
    signal r_uid362_postRightShiftProd_uid90_block_rsrvd_fix_s : STD_LOGIC_VECTOR (0 downto 0);
    signal r_uid362_postRightShiftProd_uid90_block_rsrvd_fix_q : STD_LOGIC_VECTOR (109 downto 0);
    signal wOutCst_uid366_postLeftShiftProd_uid108_block_rsrvd_fix_q : STD_LOGIC_VECTOR (6 downto 0);
    signal shiftedOut_uid367_postLeftShiftProd_uid108_block_rsrvd_fix_a : STD_LOGIC_VECTOR (16 downto 0);
    signal shiftedOut_uid367_postLeftShiftProd_uid108_block_rsrvd_fix_b : STD_LOGIC_VECTOR (16 downto 0);
    signal shiftedOut_uid367_postLeftShiftProd_uid108_block_rsrvd_fix_o : STD_LOGIC_VECTOR (16 downto 0);
    signal shiftedOut_uid367_postLeftShiftProd_uid108_block_rsrvd_fix_n : STD_LOGIC_VECTOR (0 downto 0);
    signal leftShiftStage0Idx1Rng32_uid369_postLeftShiftProd_uid108_block_rsrvd_fix_in : STD_LOGIC_VECTOR (72 downto 0);
    signal leftShiftStage0Idx1Rng32_uid369_postLeftShiftProd_uid108_block_rsrvd_fix_b : STD_LOGIC_VECTOR (72 downto 0);
    signal leftShiftStage0Idx1_uid370_postLeftShiftProd_uid108_block_rsrvd_fix_q : STD_LOGIC_VECTOR (104 downto 0);
    signal leftShiftStage0Idx2_uid373_postLeftShiftProd_uid108_block_rsrvd_fix_q : STD_LOGIC_VECTOR (104 downto 0);
    signal leftShiftStage0Idx3Rng96_uid375_postLeftShiftProd_uid108_block_rsrvd_fix_in : STD_LOGIC_VECTOR (8 downto 0);
    signal leftShiftStage0Idx3Rng96_uid375_postLeftShiftProd_uid108_block_rsrvd_fix_b : STD_LOGIC_VECTOR (8 downto 0);
    signal leftShiftStage0Idx3_uid376_postLeftShiftProd_uid108_block_rsrvd_fix_q : STD_LOGIC_VECTOR (104 downto 0);
    signal leftShiftStage0_uid378_postLeftShiftProd_uid108_block_rsrvd_fix_s : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage0_uid378_postLeftShiftProd_uid108_block_rsrvd_fix_q : STD_LOGIC_VECTOR (104 downto 0);
    signal leftShiftStage1Idx1Rng8_uid380_postLeftShiftProd_uid108_block_rsrvd_fix_in : STD_LOGIC_VECTOR (96 downto 0);
    signal leftShiftStage1Idx1Rng8_uid380_postLeftShiftProd_uid108_block_rsrvd_fix_b : STD_LOGIC_VECTOR (96 downto 0);
    signal leftShiftStage1Idx1_uid381_postLeftShiftProd_uid108_block_rsrvd_fix_q : STD_LOGIC_VECTOR (104 downto 0);
    signal leftShiftStage1Idx2Rng16_uid383_postLeftShiftProd_uid108_block_rsrvd_fix_in : STD_LOGIC_VECTOR (88 downto 0);
    signal leftShiftStage1Idx2Rng16_uid383_postLeftShiftProd_uid108_block_rsrvd_fix_b : STD_LOGIC_VECTOR (88 downto 0);
    signal leftShiftStage1Idx2_uid384_postLeftShiftProd_uid108_block_rsrvd_fix_q : STD_LOGIC_VECTOR (104 downto 0);
    signal leftShiftStage1Idx3Rng24_uid386_postLeftShiftProd_uid108_block_rsrvd_fix_in : STD_LOGIC_VECTOR (80 downto 0);
    signal leftShiftStage1Idx3Rng24_uid386_postLeftShiftProd_uid108_block_rsrvd_fix_b : STD_LOGIC_VECTOR (80 downto 0);
    signal leftShiftStage1Idx3_uid387_postLeftShiftProd_uid108_block_rsrvd_fix_q : STD_LOGIC_VECTOR (104 downto 0);
    signal leftShiftStage1_uid389_postLeftShiftProd_uid108_block_rsrvd_fix_s : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage1_uid389_postLeftShiftProd_uid108_block_rsrvd_fix_q : STD_LOGIC_VECTOR (104 downto 0);
    signal leftShiftStage2Idx1Rng2_uid391_postLeftShiftProd_uid108_block_rsrvd_fix_in : STD_LOGIC_VECTOR (102 downto 0);
    signal leftShiftStage2Idx1Rng2_uid391_postLeftShiftProd_uid108_block_rsrvd_fix_b : STD_LOGIC_VECTOR (102 downto 0);
    signal leftShiftStage2Idx1_uid392_postLeftShiftProd_uid108_block_rsrvd_fix_q : STD_LOGIC_VECTOR (104 downto 0);
    signal leftShiftStage2Idx2Rng4_uid394_postLeftShiftProd_uid108_block_rsrvd_fix_in : STD_LOGIC_VECTOR (100 downto 0);
    signal leftShiftStage2Idx2Rng4_uid394_postLeftShiftProd_uid108_block_rsrvd_fix_b : STD_LOGIC_VECTOR (100 downto 0);
    signal leftShiftStage2Idx2_uid395_postLeftShiftProd_uid108_block_rsrvd_fix_q : STD_LOGIC_VECTOR (104 downto 0);
    signal leftShiftStage2Idx3Rng6_uid397_postLeftShiftProd_uid108_block_rsrvd_fix_in : STD_LOGIC_VECTOR (98 downto 0);
    signal leftShiftStage2Idx3Rng6_uid397_postLeftShiftProd_uid108_block_rsrvd_fix_b : STD_LOGIC_VECTOR (98 downto 0);
    signal leftShiftStage2Idx3_uid398_postLeftShiftProd_uid108_block_rsrvd_fix_q : STD_LOGIC_VECTOR (104 downto 0);
    signal leftShiftStage2_uid400_postLeftShiftProd_uid108_block_rsrvd_fix_s : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage2_uid400_postLeftShiftProd_uid108_block_rsrvd_fix_q : STD_LOGIC_VECTOR (104 downto 0);
    signal leftShiftStage3Idx1Rng1_uid402_postLeftShiftProd_uid108_block_rsrvd_fix_in : STD_LOGIC_VECTOR (103 downto 0);
    signal leftShiftStage3Idx1Rng1_uid402_postLeftShiftProd_uid108_block_rsrvd_fix_b : STD_LOGIC_VECTOR (103 downto 0);
    signal leftShiftStage3Idx1_uid403_postLeftShiftProd_uid108_block_rsrvd_fix_q : STD_LOGIC_VECTOR (104 downto 0);
    signal leftShiftStage3_uid405_postLeftShiftProd_uid108_block_rsrvd_fix_s : STD_LOGIC_VECTOR (0 downto 0);
    signal leftShiftStage3_uid405_postLeftShiftProd_uid108_block_rsrvd_fix_q : STD_LOGIC_VECTOR (104 downto 0);
    signal zeroOutCst_uid406_postLeftShiftProd_uid108_block_rsrvd_fix_q : STD_LOGIC_VECTOR (104 downto 0);
    signal r_uid407_postLeftShiftProd_uid108_block_rsrvd_fix_s : STD_LOGIC_VECTOR (0 downto 0);
    signal r_uid407_postLeftShiftProd_uid108_block_rsrvd_fix_q : STD_LOGIC_VECTOR (104 downto 0);
    signal rUnderflow_uid147_block_rsrvd_fix_cmp_sign_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq0_uid413_vCount_uid216_lz_uid68_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq1_uid416_vCount_uid216_lz_uid68_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq2_uid419_vCount_uid216_lz_uid68_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq3_uid422_vCount_uid216_lz_uid68_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq4_uid425_vCount_uid216_lz_uid68_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq5_uid428_vCount_uid216_lz_uid68_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq6_uid431_vCount_uid216_lz_uid68_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq7_uid434_vCount_uid216_lz_uid68_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq8_uid437_vCount_uid216_lz_uid68_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq9_uid440_vCount_uid216_lz_uid68_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal eq10_uid443_vCount_uid216_lz_uid68_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal and_lev0_uid444_vCount_uid216_lz_uid68_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal and_lev0_uid444_vCount_uid216_lz_uid68_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal and_lev0_uid445_vCount_uid216_lz_uid68_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal and_lev0_uid445_vCount_uid216_lz_uid68_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal and_lev1_uid446_vCount_uid216_lz_uid68_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_UpperBits_for_a_q : STD_LOGIC_VECTOR (26 downto 0);
    signal add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_p1_of_2_a : STD_LOGIC_VECTOR (73 downto 0);
    signal add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_p1_of_2_b : STD_LOGIC_VECTOR (73 downto 0);
    signal add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_p1_of_2_o : STD_LOGIC_VECTOR (73 downto 0);
    signal add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_p1_of_2_c : STD_LOGIC_VECTOR (0 downto 0);
    signal add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_p1_of_2_q : STD_LOGIC_VECTOR (72 downto 0);
    signal add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_p2_of_2_a : STD_LOGIC_VECTOR (10 downto 0);
    signal add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_p2_of_2_b : STD_LOGIC_VECTOR (10 downto 0);
    signal add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_p2_of_2_o : STD_LOGIC_VECTOR (10 downto 0);
    signal add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_p2_of_2_cin : STD_LOGIC_VECTOR (0 downto 0);
    signal add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_p2_of_2_q : STD_LOGIC_VECTOR (8 downto 0);
    signal add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_BitJoin_for_q_q : STD_LOGIC_VECTOR (81 downto 0);
    signal add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_BitSelect_for_a_BitJoin_for_b_q : STD_LOGIC_VECTOR (72 downto 0);
    signal add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_BitSelect_for_b_tessel0_0_b : STD_LOGIC_VECTOR (26 downto 0);
    signal add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_BitSelect_for_b_BitJoin_for_b_q : STD_LOGIC_VECTOR (72 downto 0);
    signal add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_BitSelect_for_b_BitJoin_for_c_q : STD_LOGIC_VECTOR (8 downto 0);
    signal topProd_uid185_prod_uid62_block_rsrvd_fix_cma_reset : std_logic;
    type topProd_uid185_prod_uid62_block_rsrvd_fix_cma_a0type is array(NATURAL range <>) of UNSIGNED(26 downto 0);
    signal topProd_uid185_prod_uid62_block_rsrvd_fix_cma_a0 : topProd_uid185_prod_uid62_block_rsrvd_fix_cma_a0type(0 to 0);
    attribute preserve : boolean;
    attribute preserve of topProd_uid185_prod_uid62_block_rsrvd_fix_cma_a0 : signal is true;
    signal topProd_uid185_prod_uid62_block_rsrvd_fix_cma_c0 : topProd_uid185_prod_uid62_block_rsrvd_fix_cma_a0type(0 to 0);
    attribute preserve of topProd_uid185_prod_uid62_block_rsrvd_fix_cma_c0 : signal is true;
    type topProd_uid185_prod_uid62_block_rsrvd_fix_cma_ptype is array(NATURAL range <>) of UNSIGNED(53 downto 0);
    signal topProd_uid185_prod_uid62_block_rsrvd_fix_cma_p : topProd_uid185_prod_uid62_block_rsrvd_fix_cma_ptype(0 to 0);
    signal topProd_uid185_prod_uid62_block_rsrvd_fix_cma_u : topProd_uid185_prod_uid62_block_rsrvd_fix_cma_ptype(0 to 0);
    signal topProd_uid185_prod_uid62_block_rsrvd_fix_cma_w : topProd_uid185_prod_uid62_block_rsrvd_fix_cma_ptype(0 to 0);
    signal topProd_uid185_prod_uid62_block_rsrvd_fix_cma_x : topProd_uid185_prod_uid62_block_rsrvd_fix_cma_ptype(0 to 0);
    signal topProd_uid185_prod_uid62_block_rsrvd_fix_cma_y : topProd_uid185_prod_uid62_block_rsrvd_fix_cma_ptype(0 to 0);
    signal topProd_uid185_prod_uid62_block_rsrvd_fix_cma_s : topProd_uid185_prod_uid62_block_rsrvd_fix_cma_ptype(0 to 0);
    signal topProd_uid185_prod_uid62_block_rsrvd_fix_cma_qq : STD_LOGIC_VECTOR (53 downto 0);
    signal topProd_uid185_prod_uid62_block_rsrvd_fix_cma_q : STD_LOGIC_VECTOR (53 downto 0);
    signal topProd_uid185_prod_uid62_block_rsrvd_fix_cma_ena0 : std_logic;
    signal topProd_uid185_prod_uid62_block_rsrvd_fix_cma_ena1 : std_logic;
    signal sm0_uid206_prod_uid62_block_rsrvd_fix_cma_reset : std_logic;
    signal sm0_uid206_prod_uid62_block_rsrvd_fix_cma_a0 : topProd_uid185_prod_uid62_block_rsrvd_fix_cma_a0type(0 to 0);
    attribute preserve of sm0_uid206_prod_uid62_block_rsrvd_fix_cma_a0 : signal is true;
    signal sm0_uid206_prod_uid62_block_rsrvd_fix_cma_c0 : topProd_uid185_prod_uid62_block_rsrvd_fix_cma_a0type(0 to 0);
    attribute preserve of sm0_uid206_prod_uid62_block_rsrvd_fix_cma_c0 : signal is true;
    signal sm0_uid206_prod_uid62_block_rsrvd_fix_cma_p : topProd_uid185_prod_uid62_block_rsrvd_fix_cma_ptype(0 to 0);
    signal sm0_uid206_prod_uid62_block_rsrvd_fix_cma_u : topProd_uid185_prod_uid62_block_rsrvd_fix_cma_ptype(0 to 0);
    signal sm0_uid206_prod_uid62_block_rsrvd_fix_cma_w : topProd_uid185_prod_uid62_block_rsrvd_fix_cma_ptype(0 to 0);
    signal sm0_uid206_prod_uid62_block_rsrvd_fix_cma_x : topProd_uid185_prod_uid62_block_rsrvd_fix_cma_ptype(0 to 0);
    signal sm0_uid206_prod_uid62_block_rsrvd_fix_cma_y : topProd_uid185_prod_uid62_block_rsrvd_fix_cma_ptype(0 to 0);
    signal sm0_uid206_prod_uid62_block_rsrvd_fix_cma_s : topProd_uid185_prod_uid62_block_rsrvd_fix_cma_ptype(0 to 0);
    signal sm0_uid206_prod_uid62_block_rsrvd_fix_cma_qq : STD_LOGIC_VECTOR (53 downto 0);
    signal sm0_uid206_prod_uid62_block_rsrvd_fix_cma_q : STD_LOGIC_VECTOR (53 downto 0);
    signal sm0_uid206_prod_uid62_block_rsrvd_fix_cma_ena0 : std_logic;
    signal sm0_uid206_prod_uid62_block_rsrvd_fix_cma_ena1 : std_logic;
    signal multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_reset : std_logic;
    signal multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_a0 : topProd_uid185_prod_uid62_block_rsrvd_fix_cma_a0type(0 to 1);
    attribute preserve of multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_a0 : signal is true;
    signal multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_c0 : topProd_uid185_prod_uid62_block_rsrvd_fix_cma_a0type(0 to 1);
    attribute preserve of multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_c0 : signal is true;
    signal multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_p : topProd_uid185_prod_uid62_block_rsrvd_fix_cma_ptype(0 to 1);
    type multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_utype is array(NATURAL range <>) of UNSIGNED(54 downto 0);
    signal multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_u : multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_utype(0 to 1);
    signal multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_w : multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_utype(0 to 1);
    signal multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_x : multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_utype(0 to 1);
    signal multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_y : multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_utype(0 to 1);
    signal multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_s : multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_utype(0 to 1);
    signal multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_qq : STD_LOGIC_VECTOR (54 downto 0);
    signal multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_q : STD_LOGIC_VECTOR (54 downto 0);
    signal multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_ena0 : std_logic;
    signal multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_ena1 : std_logic;
    signal c0_uid258_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_b : STD_LOGIC_VECTOR (5 downto 0);
    signal c0_uid258_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_c : STD_LOGIC_VECTOR (5 downto 0);
    signal c0_uid258_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_d : STD_LOGIC_VECTOR (5 downto 0);
    signal c0_uid258_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_e : STD_LOGIC_VECTOR (5 downto 0);
    signal c0_uid258_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_f : STD_LOGIC_VECTOR (5 downto 0);
    signal c0_uid258_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_g : STD_LOGIC_VECTOR (5 downto 0);
    signal c0_uid258_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_h : STD_LOGIC_VECTOR (5 downto 0);
    signal c0_uid258_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_i : STD_LOGIC_VECTOR (5 downto 0);
    signal c0_uid258_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_j : STD_LOGIC_VECTOR (3 downto 0);
    signal z0_uid257_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_b : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid257_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_c : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid257_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_d : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid257_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_e : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid257_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_f : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid257_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_g : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid257_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_h : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid257_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_i : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid257_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_j : STD_LOGIC_VECTOR (3 downto 0);
    signal z0_uid287_fracXIsZero_uid35_block_rsrvd_fix_merged_bit_select_b : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid287_fracXIsZero_uid35_block_rsrvd_fix_merged_bit_select_c : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid287_fracXIsZero_uid35_block_rsrvd_fix_merged_bit_select_d : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid287_fracXIsZero_uid35_block_rsrvd_fix_merged_bit_select_e : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid287_fracXIsZero_uid35_block_rsrvd_fix_merged_bit_select_f : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid287_fracXIsZero_uid35_block_rsrvd_fix_merged_bit_select_g : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid287_fracXIsZero_uid35_block_rsrvd_fix_merged_bit_select_h : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid287_fracXIsZero_uid35_block_rsrvd_fix_merged_bit_select_i : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid287_fracXIsZero_uid35_block_rsrvd_fix_merged_bit_select_j : STD_LOGIC_VECTOR (3 downto 0);
    signal topRangeX_uid183_prod_uid62_block_rsrvd_fix_merged_bit_select_b : STD_LOGIC_VECTOR (26 downto 0);
    signal topRangeX_uid183_prod_uid62_block_rsrvd_fix_merged_bit_select_c : STD_LOGIC_VECTOR (25 downto 0);
    signal topRangeY_uid184_prod_uid62_block_rsrvd_fix_merged_bit_select_b : STD_LOGIC_VECTOR (26 downto 0);
    signal topRangeY_uid184_prod_uid62_block_rsrvd_fix_merged_bit_select_c : STD_LOGIC_VECTOR (25 downto 0);
    signal rightShiftStageSel6Dto5_uid332_postRightShiftProd_uid90_block_rsrvd_fix_merged_bit_select_in : STD_LOGIC_VECTOR (6 downto 0);
    signal rightShiftStageSel6Dto5_uid332_postRightShiftProd_uid90_block_rsrvd_fix_merged_bit_select_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStageSel6Dto5_uid332_postRightShiftProd_uid90_block_rsrvd_fix_merged_bit_select_c : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStageSel6Dto5_uid332_postRightShiftProd_uid90_block_rsrvd_fix_merged_bit_select_d : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStageSel6Dto5_uid332_postRightShiftProd_uid90_block_rsrvd_fix_merged_bit_select_e : STD_LOGIC_VECTOR (0 downto 0);
    signal leftShiftStageSel6Dto5_uid377_postLeftShiftProd_uid108_block_rsrvd_fix_merged_bit_select_in : STD_LOGIC_VECTOR (6 downto 0);
    signal leftShiftStageSel6Dto5_uid377_postLeftShiftProd_uid108_block_rsrvd_fix_merged_bit_select_b : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStageSel6Dto5_uid377_postLeftShiftProd_uid108_block_rsrvd_fix_merged_bit_select_c : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStageSel6Dto5_uid377_postLeftShiftProd_uid108_block_rsrvd_fix_merged_bit_select_d : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStageSel6Dto5_uid377_postLeftShiftProd_uid108_block_rsrvd_fix_merged_bit_select_e : STD_LOGIC_VECTOR (0 downto 0);
    signal rndBitLeftShift_uid112_block_rsrvd_fix_merged_bit_select_in : STD_LOGIC_VECTOR (1 downto 0);
    signal rndBitLeftShift_uid112_block_rsrvd_fix_merged_bit_select_b : STD_LOGIC_VECTOR (0 downto 0);
    signal rndBitLeftShift_uid112_block_rsrvd_fix_merged_bit_select_c : STD_LOGIC_VECTOR (0 downto 0);
    signal c0_uid412_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_b : STD_LOGIC_VECTOR (5 downto 0);
    signal c0_uid412_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_c : STD_LOGIC_VECTOR (5 downto 0);
    signal c0_uid412_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_d : STD_LOGIC_VECTOR (5 downto 0);
    signal c0_uid412_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_e : STD_LOGIC_VECTOR (5 downto 0);
    signal c0_uid412_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_f : STD_LOGIC_VECTOR (5 downto 0);
    signal c0_uid412_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_g : STD_LOGIC_VECTOR (5 downto 0);
    signal c0_uid412_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_h : STD_LOGIC_VECTOR (5 downto 0);
    signal c0_uid412_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_i : STD_LOGIC_VECTOR (5 downto 0);
    signal c0_uid412_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_j : STD_LOGIC_VECTOR (5 downto 0);
    signal c0_uid412_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_k : STD_LOGIC_VECTOR (5 downto 0);
    signal c0_uid412_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_l : STD_LOGIC_VECTOR (3 downto 0);
    signal z0_uid411_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_b : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid411_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_c : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid411_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_d : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid411_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_e : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid411_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_f : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid411_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_g : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid411_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_h : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid411_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_i : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid411_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_j : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid411_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_k : STD_LOGIC_VECTOR (5 downto 0);
    signal z0_uid411_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_l : STD_LOGIC_VECTOR (3 downto 0);
    signal rVStage_uid223_lz_uid68_block_rsrvd_fix_merged_bit_select_b : STD_LOGIC_VECTOR (31 downto 0);
    signal rVStage_uid223_lz_uid68_block_rsrvd_fix_merged_bit_select_c : STD_LOGIC_VECTOR (31 downto 0);
    signal rVStage_uid229_lz_uid68_block_rsrvd_fix_merged_bit_select_b : STD_LOGIC_VECTOR (15 downto 0);
    signal rVStage_uid229_lz_uid68_block_rsrvd_fix_merged_bit_select_c : STD_LOGIC_VECTOR (15 downto 0);
    signal rVStage_uid235_lz_uid68_block_rsrvd_fix_merged_bit_select_b : STD_LOGIC_VECTOR (7 downto 0);
    signal rVStage_uid235_lz_uid68_block_rsrvd_fix_merged_bit_select_c : STD_LOGIC_VECTOR (7 downto 0);
    signal rVStage_uid241_lz_uid68_block_rsrvd_fix_merged_bit_select_b : STD_LOGIC_VECTOR (3 downto 0);
    signal rVStage_uid241_lz_uid68_block_rsrvd_fix_merged_bit_select_c : STD_LOGIC_VECTOR (3 downto 0);
    signal rVStage_uid247_lz_uid68_block_rsrvd_fix_merged_bit_select_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rVStage_uid247_lz_uid68_block_rsrvd_fix_merged_bit_select_c : STD_LOGIC_VECTOR (1 downto 0);
    signal preRndFracLeftShift_uid109_block_rsrvd_fix_merged_bit_select_in : STD_LOGIC_VECTOR (103 downto 0);
    signal preRndFracLeftShift_uid109_block_rsrvd_fix_merged_bit_select_b : STD_LOGIC_VECTOR (52 downto 0);
    signal preRndFracLeftShift_uid109_block_rsrvd_fix_merged_bit_select_c : STD_LOGIC_VECTOR (50 downto 0);
    signal add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_BitSelect_for_a_tessel0_1_merged_bit_select_b : STD_LOGIC_VECTOR (17 downto 0);
    signal add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_BitSelect_for_a_tessel0_1_merged_bit_select_c : STD_LOGIC_VECTOR (8 downto 0);
    signal add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_BitSelect_for_b_tessel0_1_merged_bit_select_b : STD_LOGIC_VECTOR (45 downto 0);
    signal add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_BitSelect_for_b_tessel0_1_merged_bit_select_c : STD_LOGIC_VECTOR (7 downto 0);
    signal redist0_add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_BitSelect_for_b_tessel0_1_merged_bit_select_c_1_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist1_preRndFracLeftShift_uid109_block_rsrvd_fix_merged_bit_select_c_1_q : STD_LOGIC_VECTOR (50 downto 0);
    signal redist2_rndBitLeftShift_uid112_block_rsrvd_fix_merged_bit_select_b_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist3_rndBitLeftShift_uid112_block_rsrvd_fix_merged_bit_select_c_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist4_leftShiftStageSel6Dto5_uid377_postLeftShiftProd_uid108_block_rsrvd_fix_merged_bit_select_c_1_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist5_leftShiftStageSel6Dto5_uid377_postLeftShiftProd_uid108_block_rsrvd_fix_merged_bit_select_d_2_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist6_leftShiftStageSel6Dto5_uid377_postLeftShiftProd_uid108_block_rsrvd_fix_merged_bit_select_e_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist7_rightShiftStageSel6Dto5_uid332_postRightShiftProd_uid90_block_rsrvd_fix_merged_bit_select_c_1_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist8_rightShiftStageSel6Dto5_uid332_postRightShiftProd_uid90_block_rsrvd_fix_merged_bit_select_d_2_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist9_rightShiftStageSel6Dto5_uid332_postRightShiftProd_uid90_block_rsrvd_fix_merged_bit_select_e_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist10_topRangeY_uid184_prod_uid62_block_rsrvd_fix_merged_bit_select_b_1_q : STD_LOGIC_VECTOR (26 downto 0);
    signal redist11_topRangeX_uid183_prod_uid62_block_rsrvd_fix_merged_bit_select_b_1_q : STD_LOGIC_VECTOR (26 downto 0);
    signal redist12_topRangeX_uid183_prod_uid62_block_rsrvd_fix_merged_bit_select_c_1_q : STD_LOGIC_VECTOR (25 downto 0);
    signal redist13_multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_q_1_q : STD_LOGIC_VECTOR (54 downto 0);
    signal redist14_sm0_uid206_prod_uid62_block_rsrvd_fix_cma_q_1_q : STD_LOGIC_VECTOR (53 downto 0);
    signal redist15_topProd_uid185_prod_uid62_block_rsrvd_fix_cma_q_1_q : STD_LOGIC_VECTOR (53 downto 0);
    signal redist16_add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_p1_of_2_q_1_q : STD_LOGIC_VECTOR (72 downto 0);
    signal redist17_and_lev1_uid446_vCount_uid216_lz_uid68_block_rsrvd_fix_q_6_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist18_shiftedOut_uid367_postLeftShiftProd_uid108_block_rsrvd_fix_n_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist19_shiftedOut_uid322_postRightShiftProd_uid90_block_rsrvd_fix_n_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist20_r_uid255_lz_uid68_block_rsrvd_fix_q_1_q : STD_LOGIC_VECTOR (6 downto 0);
    signal redist21_rVStage_uid253_lz_uid68_block_rsrvd_fix_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist22_vCount_uid248_lz_uid68_block_rsrvd_fix_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist23_vCount_uid242_lz_uid68_block_rsrvd_fix_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist24_vCount_uid236_lz_uid68_block_rsrvd_fix_q_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist25_vCount_uid230_lz_uid68_block_rsrvd_fix_q_4_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist26_vCount_uid224_lz_uid68_block_rsrvd_fix_q_5_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist28_rVStage_uid215_lz_uid68_block_rsrvd_fix_b_1_q : STD_LOGIC_VECTOR (63 downto 0);
    signal redist29_lowRangeB_uid208_prod_uid62_block_rsrvd_fix_b_2_q : STD_LOGIC_VECTOR (26 downto 0);
    signal redist30_aboveLeftY_mergedSignalTM_uid189_prod_uid62_block_rsrvd_fix_q_1_q : STD_LOGIC_VECTOR (26 downto 0);
    signal redist31_expRFinal_uid176_block_rsrvd_fix_b_2_q : STD_LOGIC_VECTOR (10 downto 0);
    signal redist32_excRNaN_uid167_block_rsrvd_fix_q_23_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist34_expIncrement_uid122_block_rsrvd_fix_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist35_fracRPreExc_uid121_block_rsrvd_fix_b_4_q : STD_LOGIC_VECTOR (51 downto 0);
    signal redist36_fracInRnd_uid118_block_rsrvd_fix_q_3_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist37_leftShiftValueBothCases_uid107_block_rsrvd_fix_q_1_q : STD_LOGIC_VECTOR (14 downto 0);
    signal redist38_postRightShiftProdR_uid98_block_rsrvd_fix_b_1_q : STD_LOGIC_VECTOR (52 downto 0);
    signal redist39_rS_uid97_block_rsrvd_fix_b_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist40_lS_uid96_block_rsrvd_fix_b_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist41_stickySubnormalRange_uid93_block_rsrvd_fix_b_1_q : STD_LOGIC_VECTOR (54 downto 0);
    signal redist42_case5_uid85_block_rsrvd_fix_q_4_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist43_case5_uid85_block_rsrvd_fix_q_6_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist44_expSumMBiasGTZero_uid76_block_rsrvd_fix_c_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist45_expSumMBiasGTZero_uid76_block_rsrvd_fix_c_4_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist46_expSumMBiasGTZero_uid76_block_rsrvd_fix_n_4_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist47_prodLessThanOne_uid75_block_rsrvd_fix_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist48_xMSB_uid70_block_rsrvd_fix_b_5_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist49_xMSB_uid70_block_rsrvd_fix_b_8_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist50_top2BitsProd_uid69_block_rsrvd_fix_b_7_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist51_prodSticky_uid67_block_rsrvd_fix_q_12_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist53_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_1_q : STD_LOGIC_VECTOR (104 downto 0);
    signal redist55_signR_uid63_block_rsrvd_fix_q_25_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist56_expSumMBias_uid61_block_rsrvd_fix_q_2_q : STD_LOGIC_VECTOR (13 downto 0);
    signal redist57_expSumMBias_uid61_block_rsrvd_fix_q_4_q : STD_LOGIC_VECTOR (13 downto 0);
    signal redist58_expSumMBias_uid61_block_rsrvd_fix_q_5_q : STD_LOGIC_VECTOR (13 downto 0);
    signal redist59_expSumMBias_uid61_block_rsrvd_fix_q_6_q : STD_LOGIC_VECTOR (13 downto 0);
    signal redist61_yIsSubnorm_uid48_block_rsrvd_fix_q_22_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist62_xIsSubnorm_uid46_block_rsrvd_fix_q_22_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist63_excR_y_uid42_block_rsrvd_fix_q_23_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist64_excR_y_uid42_block_rsrvd_fix_q_24_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist65_excI_y_uid38_block_rsrvd_fix_q_23_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist66_excZ_y_uid37_block_rsrvd_fix_q_23_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist67_frac_y_uid32_block_rsrvd_fix_b_2_q : STD_LOGIC_VECTOR (51 downto 0);
    signal redist68_excR_x_uid25_block_rsrvd_fix_q_23_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist69_excR_x_uid25_block_rsrvd_fix_q_24_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist70_excI_x_uid21_block_rsrvd_fix_q_23_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist71_excZ_x_uid20_block_rsrvd_fix_q_23_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist72_frac_x_uid15_block_rsrvd_fix_b_2_q : STD_LOGIC_VECTOR (51 downto 0);
    signal redist73_expY_uid8_block_rsrvd_fix_b_1_q : STD_LOGIC_VECTOR (10 downto 0);
    signal redist74_expY_uid8_block_rsrvd_fix_b_2_q : STD_LOGIC_VECTOR (10 downto 0);
    signal redist75_expX_uid7_block_rsrvd_fix_b_1_q : STD_LOGIC_VECTOR (10 downto 0);
    signal redist76_expX_uid7_block_rsrvd_fix_b_2_q : STD_LOGIC_VECTOR (10 downto 0);
    signal redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_inputreg_q : STD_LOGIC_VECTOR (40 downto 0);
    signal redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_outputreg_q : STD_LOGIC_VECTOR (40 downto 0);
    signal redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_mem_reset0 : std_logic;
    signal redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_mem_ia : STD_LOGIC_VECTOR (40 downto 0);
    signal redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_mem_aa : STD_LOGIC_VECTOR (1 downto 0);
    signal redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_mem_ab : STD_LOGIC_VECTOR (1 downto 0);
    signal redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_mem_iq : STD_LOGIC_VECTOR (40 downto 0);
    signal redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_mem_q : STD_LOGIC_VECTOR (40 downto 0);
    signal redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_rdcnt_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_rdcnt_i : UNSIGNED (1 downto 0);
    attribute preserve of redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_rdcnt_i : signal is true;
    signal redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_wraddr_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_mem_last_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_cmp_b : STD_LOGIC_VECTOR (2 downto 0);
    signal redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute dont_merge : boolean;
    attribute dont_merge of redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_sticky_ena_q : signal is true;
    signal redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist33_expRPre_uid145_block_rsrvd_fix_q_6_inputreg_q : STD_LOGIC_VECTOR (14 downto 0);
    signal redist33_expRPre_uid145_block_rsrvd_fix_q_6_outputreg_q : STD_LOGIC_VECTOR (14 downto 0);
    signal redist33_expRPre_uid145_block_rsrvd_fix_q_6_mem_reset0 : std_logic;
    signal redist33_expRPre_uid145_block_rsrvd_fix_q_6_mem_ia : STD_LOGIC_VECTOR (14 downto 0);
    signal redist33_expRPre_uid145_block_rsrvd_fix_q_6_mem_aa : STD_LOGIC_VECTOR (0 downto 0);
    signal redist33_expRPre_uid145_block_rsrvd_fix_q_6_mem_ab : STD_LOGIC_VECTOR (0 downto 0);
    signal redist33_expRPre_uid145_block_rsrvd_fix_q_6_mem_iq : STD_LOGIC_VECTOR (14 downto 0);
    signal redist33_expRPre_uid145_block_rsrvd_fix_q_6_mem_q : STD_LOGIC_VECTOR (14 downto 0);
    signal redist33_expRPre_uid145_block_rsrvd_fix_q_6_rdcnt_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist33_expRPre_uid145_block_rsrvd_fix_q_6_rdcnt_i : UNSIGNED (0 downto 0);
    attribute preserve of redist33_expRPre_uid145_block_rsrvd_fix_q_6_rdcnt_i : signal is true;
    signal redist33_expRPre_uid145_block_rsrvd_fix_q_6_wraddr_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist33_expRPre_uid145_block_rsrvd_fix_q_6_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist33_expRPre_uid145_block_rsrvd_fix_q_6_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist33_expRPre_uid145_block_rsrvd_fix_q_6_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist33_expRPre_uid145_block_rsrvd_fix_q_6_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute dont_merge of redist33_expRPre_uid145_block_rsrvd_fix_q_6_sticky_ena_q : signal is true;
    signal redist33_expRPre_uid145_block_rsrvd_fix_q_6_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist35_fracRPreExc_uid121_block_rsrvd_fix_b_4_inputreg_q : STD_LOGIC_VECTOR (51 downto 0);
    signal redist35_fracRPreExc_uid121_block_rsrvd_fix_b_4_outputreg_q : STD_LOGIC_VECTOR (51 downto 0);
    signal redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_inputreg_q : STD_LOGIC_VECTOR (54 downto 0);
    signal redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_outputreg_q : STD_LOGIC_VECTOR (54 downto 0);
    signal redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_mem_reset0 : std_logic;
    signal redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_mem_ia : STD_LOGIC_VECTOR (54 downto 0);
    signal redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_mem_aa : STD_LOGIC_VECTOR (1 downto 0);
    signal redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_mem_ab : STD_LOGIC_VECTOR (1 downto 0);
    signal redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_mem_iq : STD_LOGIC_VECTOR (54 downto 0);
    signal redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_mem_q : STD_LOGIC_VECTOR (54 downto 0);
    signal redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_rdcnt_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_rdcnt_i : UNSIGNED (1 downto 0);
    attribute preserve of redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_rdcnt_i : signal is true;
    signal redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_wraddr_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_mem_last_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_cmp_b : STD_LOGIC_VECTOR (2 downto 0);
    signal redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute dont_merge of redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_sticky_ena_q : signal is true;
    signal redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_inputreg_q : STD_LOGIC_VECTOR (104 downto 0);
    signal redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_outputreg_q : STD_LOGIC_VECTOR (104 downto 0);
    signal redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_mem_reset0 : std_logic;
    signal redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_mem_ia : STD_LOGIC_VECTOR (104 downto 0);
    signal redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_mem_aa : STD_LOGIC_VECTOR (1 downto 0);
    signal redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_mem_ab : STD_LOGIC_VECTOR (1 downto 0);
    signal redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_mem_iq : STD_LOGIC_VECTOR (104 downto 0);
    signal redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_mem_q : STD_LOGIC_VECTOR (104 downto 0);
    signal redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_rdcnt_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_rdcnt_i : UNSIGNED (1 downto 0);
    attribute preserve of redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_rdcnt_i : signal is true;
    signal redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_wraddr_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_mem_last_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_cmp_b : STD_LOGIC_VECTOR (2 downto 0);
    signal redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute dont_merge of redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_sticky_ena_q : signal is true;
    signal redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist60_expSum_uid59_block_rsrvd_fix_q_9_inputreg_q : STD_LOGIC_VECTOR (11 downto 0);
    signal redist60_expSum_uid59_block_rsrvd_fix_q_9_outputreg_q : STD_LOGIC_VECTOR (11 downto 0);
    signal redist60_expSum_uid59_block_rsrvd_fix_q_9_mem_reset0 : std_logic;
    signal redist60_expSum_uid59_block_rsrvd_fix_q_9_mem_ia : STD_LOGIC_VECTOR (11 downto 0);
    signal redist60_expSum_uid59_block_rsrvd_fix_q_9_mem_aa : STD_LOGIC_VECTOR (2 downto 0);
    signal redist60_expSum_uid59_block_rsrvd_fix_q_9_mem_ab : STD_LOGIC_VECTOR (2 downto 0);
    signal redist60_expSum_uid59_block_rsrvd_fix_q_9_mem_iq : STD_LOGIC_VECTOR (11 downto 0);
    signal redist60_expSum_uid59_block_rsrvd_fix_q_9_mem_q : STD_LOGIC_VECTOR (11 downto 0);
    signal redist60_expSum_uid59_block_rsrvd_fix_q_9_rdcnt_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist60_expSum_uid59_block_rsrvd_fix_q_9_rdcnt_i : UNSIGNED (2 downto 0);
    attribute preserve of redist60_expSum_uid59_block_rsrvd_fix_q_9_rdcnt_i : signal is true;
    signal redist60_expSum_uid59_block_rsrvd_fix_q_9_rdcnt_eq : std_logic;
    attribute preserve of redist60_expSum_uid59_block_rsrvd_fix_q_9_rdcnt_eq : signal is true;
    signal redist60_expSum_uid59_block_rsrvd_fix_q_9_wraddr_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist60_expSum_uid59_block_rsrvd_fix_q_9_mem_last_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist60_expSum_uid59_block_rsrvd_fix_q_9_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist60_expSum_uid59_block_rsrvd_fix_q_9_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist60_expSum_uid59_block_rsrvd_fix_q_9_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist60_expSum_uid59_block_rsrvd_fix_q_9_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist60_expSum_uid59_block_rsrvd_fix_q_9_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute dont_merge of redist60_expSum_uid59_block_rsrvd_fix_q_9_sticky_ena_q : signal is true;
    signal redist60_expSum_uid59_block_rsrvd_fix_q_9_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- cstZeroWF_uid12_block_rsrvd_fix(CONSTANT,11)
    cstZeroWF_uid12_block_rsrvd_fix_q <= "0000000000000000000000000000000000000000000000000000";

    -- c0_uid258_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select(BITSELECT,469)
    c0_uid258_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_b <= cstZeroWF_uid12_block_rsrvd_fix_q(5 downto 0);
    c0_uid258_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_c <= cstZeroWF_uid12_block_rsrvd_fix_q(11 downto 6);
    c0_uid258_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_d <= cstZeroWF_uid12_block_rsrvd_fix_q(17 downto 12);
    c0_uid258_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_e <= cstZeroWF_uid12_block_rsrvd_fix_q(23 downto 18);
    c0_uid258_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_f <= cstZeroWF_uid12_block_rsrvd_fix_q(29 downto 24);
    c0_uid258_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_g <= cstZeroWF_uid12_block_rsrvd_fix_q(35 downto 30);
    c0_uid258_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_h <= cstZeroWF_uid12_block_rsrvd_fix_q(41 downto 36);
    c0_uid258_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_i <= cstZeroWF_uid12_block_rsrvd_fix_q(47 downto 42);
    c0_uid258_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_j <= cstZeroWF_uid12_block_rsrvd_fix_q(51 downto 48);

    -- frac_x_uid15_block_rsrvd_fix(BITSELECT,14)@0
    frac_x_uid15_block_rsrvd_fix_b <= in_0(51 downto 0);

    -- z0_uid257_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select(BITSELECT,470)@0
    z0_uid257_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_b <= frac_x_uid15_block_rsrvd_fix_b(5 downto 0);
    z0_uid257_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_c <= frac_x_uid15_block_rsrvd_fix_b(11 downto 6);
    z0_uid257_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_d <= frac_x_uid15_block_rsrvd_fix_b(17 downto 12);
    z0_uid257_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_e <= frac_x_uid15_block_rsrvd_fix_b(23 downto 18);
    z0_uid257_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_f <= frac_x_uid15_block_rsrvd_fix_b(29 downto 24);
    z0_uid257_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_g <= frac_x_uid15_block_rsrvd_fix_b(35 downto 30);
    z0_uid257_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_h <= frac_x_uid15_block_rsrvd_fix_b(41 downto 36);
    z0_uid257_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_i <= frac_x_uid15_block_rsrvd_fix_b(47 downto 42);
    z0_uid257_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_j <= frac_x_uid15_block_rsrvd_fix_b(51 downto 48);

    -- eq8_uid283_fracXIsZero_uid18_block_rsrvd_fix(LOGICAL,282)@0
    eq8_uid283_fracXIsZero_uid18_block_rsrvd_fix_q <= "1" WHEN z0_uid257_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_j = c0_uid258_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_j ELSE "0";

    -- eq7_uid280_fracXIsZero_uid18_block_rsrvd_fix(LOGICAL,279)@0
    eq7_uid280_fracXIsZero_uid18_block_rsrvd_fix_q <= "1" WHEN z0_uid257_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_i = c0_uid258_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_i ELSE "0";

    -- eq6_uid277_fracXIsZero_uid18_block_rsrvd_fix(LOGICAL,276)@0
    eq6_uid277_fracXIsZero_uid18_block_rsrvd_fix_q <= "1" WHEN z0_uid257_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_h = c0_uid258_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_h ELSE "0";

    -- and_lev0_uid285_fracXIsZero_uid18_block_rsrvd_fix(LOGICAL,284)@0 + 1
    and_lev0_uid285_fracXIsZero_uid18_block_rsrvd_fix_qi <= eq6_uid277_fracXIsZero_uid18_block_rsrvd_fix_q and eq7_uid280_fracXIsZero_uid18_block_rsrvd_fix_q and eq8_uid283_fracXIsZero_uid18_block_rsrvd_fix_q;
    and_lev0_uid285_fracXIsZero_uid18_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => and_lev0_uid285_fracXIsZero_uid18_block_rsrvd_fix_qi, xout => and_lev0_uid285_fracXIsZero_uid18_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- eq5_uid274_fracXIsZero_uid18_block_rsrvd_fix(LOGICAL,273)@0
    eq5_uid274_fracXIsZero_uid18_block_rsrvd_fix_q <= "1" WHEN z0_uid257_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_g = c0_uid258_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_g ELSE "0";

    -- eq4_uid271_fracXIsZero_uid18_block_rsrvd_fix(LOGICAL,270)@0
    eq4_uid271_fracXIsZero_uid18_block_rsrvd_fix_q <= "1" WHEN z0_uid257_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_f = c0_uid258_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_f ELSE "0";

    -- eq3_uid268_fracXIsZero_uid18_block_rsrvd_fix(LOGICAL,267)@0
    eq3_uid268_fracXIsZero_uid18_block_rsrvd_fix_q <= "1" WHEN z0_uid257_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_e = c0_uid258_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_e ELSE "0";

    -- eq2_uid265_fracXIsZero_uid18_block_rsrvd_fix(LOGICAL,264)@0
    eq2_uid265_fracXIsZero_uid18_block_rsrvd_fix_q <= "1" WHEN z0_uid257_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_d = c0_uid258_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_d ELSE "0";

    -- eq1_uid262_fracXIsZero_uid18_block_rsrvd_fix(LOGICAL,261)@0
    eq1_uid262_fracXIsZero_uid18_block_rsrvd_fix_q <= "1" WHEN z0_uid257_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_c = c0_uid258_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_c ELSE "0";

    -- eq0_uid259_fracXIsZero_uid18_block_rsrvd_fix(LOGICAL,258)@0
    eq0_uid259_fracXIsZero_uid18_block_rsrvd_fix_q <= "1" WHEN z0_uid257_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_b = c0_uid258_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_b ELSE "0";

    -- and_lev0_uid284_fracXIsZero_uid18_block_rsrvd_fix(LOGICAL,283)@0 + 1
    and_lev0_uid284_fracXIsZero_uid18_block_rsrvd_fix_qi <= eq0_uid259_fracXIsZero_uid18_block_rsrvd_fix_q and eq1_uid262_fracXIsZero_uid18_block_rsrvd_fix_q and eq2_uid265_fracXIsZero_uid18_block_rsrvd_fix_q and eq3_uid268_fracXIsZero_uid18_block_rsrvd_fix_q and eq4_uid271_fracXIsZero_uid18_block_rsrvd_fix_q and eq5_uid274_fracXIsZero_uid18_block_rsrvd_fix_q;
    and_lev0_uid284_fracXIsZero_uid18_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => and_lev0_uid284_fracXIsZero_uid18_block_rsrvd_fix_qi, xout => and_lev0_uid284_fracXIsZero_uid18_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- and_lev1_uid286_fracXIsZero_uid18_block_rsrvd_fix(LOGICAL,285)@1
    and_lev1_uid286_fracXIsZero_uid18_block_rsrvd_fix_q <= and_lev0_uid284_fracXIsZero_uid18_block_rsrvd_fix_q and and_lev0_uid285_fracXIsZero_uid18_block_rsrvd_fix_q;

    -- cstAllOWE_uid11_block_rsrvd_fix(CONSTANT,10)
    cstAllOWE_uid11_block_rsrvd_fix_q <= "11111111111";

    -- expX_uid7_block_rsrvd_fix(BITSELECT,6)@0
    expX_uid7_block_rsrvd_fix_b <= in_0(62 downto 52);

    -- redist75_expX_uid7_block_rsrvd_fix_b_1(DELAY,562)
    redist75_expX_uid7_block_rsrvd_fix_b_1 : dspba_delay
    GENERIC MAP ( width => 11, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => expX_uid7_block_rsrvd_fix_b, xout => redist75_expX_uid7_block_rsrvd_fix_b_1_q, clk => clock, aclr => resetn );

    -- expXIsMax_uid17_block_rsrvd_fix(LOGICAL,16)@1
    expXIsMax_uid17_block_rsrvd_fix_q <= "1" WHEN redist75_expX_uid7_block_rsrvd_fix_b_1_q = cstAllOWE_uid11_block_rsrvd_fix_q ELSE "0";

    -- excI_x_uid21_block_rsrvd_fix(LOGICAL,20)@1 + 1
    excI_x_uid21_block_rsrvd_fix_qi <= expXIsMax_uid17_block_rsrvd_fix_q and and_lev1_uid286_fracXIsZero_uid18_block_rsrvd_fix_q;
    excI_x_uid21_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excI_x_uid21_block_rsrvd_fix_qi, xout => excI_x_uid21_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- frac_y_uid32_block_rsrvd_fix(BITSELECT,31)@0
    frac_y_uid32_block_rsrvd_fix_b <= in_1(51 downto 0);

    -- z0_uid287_fracXIsZero_uid35_block_rsrvd_fix_merged_bit_select(BITSELECT,471)@0
    z0_uid287_fracXIsZero_uid35_block_rsrvd_fix_merged_bit_select_b <= frac_y_uid32_block_rsrvd_fix_b(5 downto 0);
    z0_uid287_fracXIsZero_uid35_block_rsrvd_fix_merged_bit_select_c <= frac_y_uid32_block_rsrvd_fix_b(11 downto 6);
    z0_uid287_fracXIsZero_uid35_block_rsrvd_fix_merged_bit_select_d <= frac_y_uid32_block_rsrvd_fix_b(17 downto 12);
    z0_uid287_fracXIsZero_uid35_block_rsrvd_fix_merged_bit_select_e <= frac_y_uid32_block_rsrvd_fix_b(23 downto 18);
    z0_uid287_fracXIsZero_uid35_block_rsrvd_fix_merged_bit_select_f <= frac_y_uid32_block_rsrvd_fix_b(29 downto 24);
    z0_uid287_fracXIsZero_uid35_block_rsrvd_fix_merged_bit_select_g <= frac_y_uid32_block_rsrvd_fix_b(35 downto 30);
    z0_uid287_fracXIsZero_uid35_block_rsrvd_fix_merged_bit_select_h <= frac_y_uid32_block_rsrvd_fix_b(41 downto 36);
    z0_uid287_fracXIsZero_uid35_block_rsrvd_fix_merged_bit_select_i <= frac_y_uid32_block_rsrvd_fix_b(47 downto 42);
    z0_uid287_fracXIsZero_uid35_block_rsrvd_fix_merged_bit_select_j <= frac_y_uid32_block_rsrvd_fix_b(51 downto 48);

    -- eq8_uid313_fracXIsZero_uid35_block_rsrvd_fix(LOGICAL,312)@0
    eq8_uid313_fracXIsZero_uid35_block_rsrvd_fix_q <= "1" WHEN z0_uid287_fracXIsZero_uid35_block_rsrvd_fix_merged_bit_select_j = c0_uid258_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_j ELSE "0";

    -- eq7_uid310_fracXIsZero_uid35_block_rsrvd_fix(LOGICAL,309)@0
    eq7_uid310_fracXIsZero_uid35_block_rsrvd_fix_q <= "1" WHEN z0_uid287_fracXIsZero_uid35_block_rsrvd_fix_merged_bit_select_i = c0_uid258_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_i ELSE "0";

    -- eq6_uid307_fracXIsZero_uid35_block_rsrvd_fix(LOGICAL,306)@0
    eq6_uid307_fracXIsZero_uid35_block_rsrvd_fix_q <= "1" WHEN z0_uid287_fracXIsZero_uid35_block_rsrvd_fix_merged_bit_select_h = c0_uid258_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_h ELSE "0";

    -- and_lev0_uid315_fracXIsZero_uid35_block_rsrvd_fix(LOGICAL,314)@0 + 1
    and_lev0_uid315_fracXIsZero_uid35_block_rsrvd_fix_qi <= eq6_uid307_fracXIsZero_uid35_block_rsrvd_fix_q and eq7_uid310_fracXIsZero_uid35_block_rsrvd_fix_q and eq8_uid313_fracXIsZero_uid35_block_rsrvd_fix_q;
    and_lev0_uid315_fracXIsZero_uid35_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => and_lev0_uid315_fracXIsZero_uid35_block_rsrvd_fix_qi, xout => and_lev0_uid315_fracXIsZero_uid35_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- eq5_uid304_fracXIsZero_uid35_block_rsrvd_fix(LOGICAL,303)@0
    eq5_uid304_fracXIsZero_uid35_block_rsrvd_fix_q <= "1" WHEN z0_uid287_fracXIsZero_uid35_block_rsrvd_fix_merged_bit_select_g = c0_uid258_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_g ELSE "0";

    -- eq4_uid301_fracXIsZero_uid35_block_rsrvd_fix(LOGICAL,300)@0
    eq4_uid301_fracXIsZero_uid35_block_rsrvd_fix_q <= "1" WHEN z0_uid287_fracXIsZero_uid35_block_rsrvd_fix_merged_bit_select_f = c0_uid258_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_f ELSE "0";

    -- eq3_uid298_fracXIsZero_uid35_block_rsrvd_fix(LOGICAL,297)@0
    eq3_uid298_fracXIsZero_uid35_block_rsrvd_fix_q <= "1" WHEN z0_uid287_fracXIsZero_uid35_block_rsrvd_fix_merged_bit_select_e = c0_uid258_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_e ELSE "0";

    -- eq2_uid295_fracXIsZero_uid35_block_rsrvd_fix(LOGICAL,294)@0
    eq2_uid295_fracXIsZero_uid35_block_rsrvd_fix_q <= "1" WHEN z0_uid287_fracXIsZero_uid35_block_rsrvd_fix_merged_bit_select_d = c0_uid258_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_d ELSE "0";

    -- eq1_uid292_fracXIsZero_uid35_block_rsrvd_fix(LOGICAL,291)@0
    eq1_uid292_fracXIsZero_uid35_block_rsrvd_fix_q <= "1" WHEN z0_uid287_fracXIsZero_uid35_block_rsrvd_fix_merged_bit_select_c = c0_uid258_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_c ELSE "0";

    -- eq0_uid289_fracXIsZero_uid35_block_rsrvd_fix(LOGICAL,288)@0
    eq0_uid289_fracXIsZero_uid35_block_rsrvd_fix_q <= "1" WHEN z0_uid287_fracXIsZero_uid35_block_rsrvd_fix_merged_bit_select_b = c0_uid258_fracXIsZero_uid18_block_rsrvd_fix_merged_bit_select_b ELSE "0";

    -- and_lev0_uid314_fracXIsZero_uid35_block_rsrvd_fix(LOGICAL,313)@0 + 1
    and_lev0_uid314_fracXIsZero_uid35_block_rsrvd_fix_qi <= eq0_uid289_fracXIsZero_uid35_block_rsrvd_fix_q and eq1_uid292_fracXIsZero_uid35_block_rsrvd_fix_q and eq2_uid295_fracXIsZero_uid35_block_rsrvd_fix_q and eq3_uid298_fracXIsZero_uid35_block_rsrvd_fix_q and eq4_uid301_fracXIsZero_uid35_block_rsrvd_fix_q and eq5_uid304_fracXIsZero_uid35_block_rsrvd_fix_q;
    and_lev0_uid314_fracXIsZero_uid35_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => and_lev0_uid314_fracXIsZero_uid35_block_rsrvd_fix_qi, xout => and_lev0_uid314_fracXIsZero_uid35_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- and_lev1_uid316_fracXIsZero_uid35_block_rsrvd_fix(LOGICAL,315)@1
    and_lev1_uid316_fracXIsZero_uid35_block_rsrvd_fix_q <= and_lev0_uid314_fracXIsZero_uid35_block_rsrvd_fix_q and and_lev0_uid315_fracXIsZero_uid35_block_rsrvd_fix_q;

    -- cstAllZWE_uid13_block_rsrvd_fix(CONSTANT,12)
    cstAllZWE_uid13_block_rsrvd_fix_q <= "00000000000";

    -- expY_uid8_block_rsrvd_fix(BITSELECT,7)@0
    expY_uid8_block_rsrvd_fix_b <= in_1(62 downto 52);

    -- redist73_expY_uid8_block_rsrvd_fix_b_1(DELAY,560)
    redist73_expY_uid8_block_rsrvd_fix_b_1 : dspba_delay
    GENERIC MAP ( width => 11, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => expY_uid8_block_rsrvd_fix_b, xout => redist73_expY_uid8_block_rsrvd_fix_b_1_q, clk => clock, aclr => resetn );

    -- expXIsZero_uid33_block_rsrvd_fix(LOGICAL,32)@1
    expXIsZero_uid33_block_rsrvd_fix_q <= "1" WHEN redist73_expY_uid8_block_rsrvd_fix_b_1_q = cstAllZWE_uid13_block_rsrvd_fix_q ELSE "0";

    -- excZ_y_uid37_block_rsrvd_fix(LOGICAL,36)@1 + 1
    excZ_y_uid37_block_rsrvd_fix_qi <= expXIsZero_uid33_block_rsrvd_fix_q and and_lev1_uid316_fracXIsZero_uid35_block_rsrvd_fix_q;
    excZ_y_uid37_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excZ_y_uid37_block_rsrvd_fix_qi, xout => excZ_y_uid37_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- excYZAndExcXI_uid164_block_rsrvd_fix(LOGICAL,163)@2
    excYZAndExcXI_uid164_block_rsrvd_fix_q <= excZ_y_uid37_block_rsrvd_fix_q and excI_x_uid21_block_rsrvd_fix_q;

    -- expXIsMax_uid34_block_rsrvd_fix(LOGICAL,33)@1
    expXIsMax_uid34_block_rsrvd_fix_q <= "1" WHEN redist73_expY_uid8_block_rsrvd_fix_b_1_q = cstAllOWE_uid11_block_rsrvd_fix_q ELSE "0";

    -- excI_y_uid38_block_rsrvd_fix(LOGICAL,37)@1 + 1
    excI_y_uid38_block_rsrvd_fix_qi <= expXIsMax_uid34_block_rsrvd_fix_q and and_lev1_uid316_fracXIsZero_uid35_block_rsrvd_fix_q;
    excI_y_uid38_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excI_y_uid38_block_rsrvd_fix_qi, xout => excI_y_uid38_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- expXIsZero_uid16_block_rsrvd_fix(LOGICAL,15)@1
    expXIsZero_uid16_block_rsrvd_fix_q <= "1" WHEN redist75_expX_uid7_block_rsrvd_fix_b_1_q = cstAllZWE_uid13_block_rsrvd_fix_q ELSE "0";

    -- excZ_x_uid20_block_rsrvd_fix(LOGICAL,19)@1 + 1
    excZ_x_uid20_block_rsrvd_fix_qi <= expXIsZero_uid16_block_rsrvd_fix_q and and_lev1_uid286_fracXIsZero_uid18_block_rsrvd_fix_q;
    excZ_x_uid20_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excZ_x_uid20_block_rsrvd_fix_qi, xout => excZ_x_uid20_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- excXZAndExcYI_uid165_block_rsrvd_fix(LOGICAL,164)@2
    excXZAndExcYI_uid165_block_rsrvd_fix_q <= excZ_x_uid20_block_rsrvd_fix_q and excI_y_uid38_block_rsrvd_fix_q;

    -- ZeroTimesInf_uid166_block_rsrvd_fix(LOGICAL,165)@2
    ZeroTimesInf_uid166_block_rsrvd_fix_q <= excXZAndExcYI_uid165_block_rsrvd_fix_q or excYZAndExcXI_uid164_block_rsrvd_fix_q;

    -- fracXIsNotZero_uid36_block_rsrvd_fix(LOGICAL,35)@1
    fracXIsNotZero_uid36_block_rsrvd_fix_q <= not (and_lev1_uid316_fracXIsZero_uid35_block_rsrvd_fix_q);

    -- excN_y_uid39_block_rsrvd_fix(LOGICAL,38)@1 + 1
    excN_y_uid39_block_rsrvd_fix_qi <= expXIsMax_uid34_block_rsrvd_fix_q and fracXIsNotZero_uid36_block_rsrvd_fix_q;
    excN_y_uid39_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excN_y_uid39_block_rsrvd_fix_qi, xout => excN_y_uid39_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- fracXIsNotZero_uid19_block_rsrvd_fix(LOGICAL,18)@1
    fracXIsNotZero_uid19_block_rsrvd_fix_q <= not (and_lev1_uid286_fracXIsZero_uid18_block_rsrvd_fix_q);

    -- excN_x_uid22_block_rsrvd_fix(LOGICAL,21)@1 + 1
    excN_x_uid22_block_rsrvd_fix_qi <= expXIsMax_uid17_block_rsrvd_fix_q and fracXIsNotZero_uid19_block_rsrvd_fix_q;
    excN_x_uid22_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excN_x_uid22_block_rsrvd_fix_qi, xout => excN_x_uid22_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- excRNaN_uid167_block_rsrvd_fix(LOGICAL,166)@2 + 1
    excRNaN_uid167_block_rsrvd_fix_qi <= excN_x_uid22_block_rsrvd_fix_q or excN_y_uid39_block_rsrvd_fix_q or ZeroTimesInf_uid166_block_rsrvd_fix_q;
    excRNaN_uid167_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excRNaN_uid167_block_rsrvd_fix_qi, xout => excRNaN_uid167_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- redist32_excRNaN_uid167_block_rsrvd_fix_q_23(DELAY,519)
    redist32_excRNaN_uid167_block_rsrvd_fix_q_23 : dspba_delay
    GENERIC MAP ( width => 1, depth => 22, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excRNaN_uid167_block_rsrvd_fix_q, xout => redist32_excRNaN_uid167_block_rsrvd_fix_q_23_q, clk => clock, aclr => resetn );

    -- invExcRNaN_uid179_block_rsrvd_fix(LOGICAL,178)@25
    invExcRNaN_uid179_block_rsrvd_fix_q <= not (redist32_excRNaN_uid167_block_rsrvd_fix_q_23_q);

    -- signY_uid10_block_rsrvd_fix(BITSELECT,9)@0
    signY_uid10_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(in_1(63 downto 63));

    -- signX_uid9_block_rsrvd_fix(BITSELECT,8)@0
    signX_uid9_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(in_0(63 downto 63));

    -- signR_uid63_block_rsrvd_fix(LOGICAL,62)@0 + 1
    signR_uid63_block_rsrvd_fix_qi <= signX_uid9_block_rsrvd_fix_b xor signY_uid10_block_rsrvd_fix_b;
    signR_uid63_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => signR_uid63_block_rsrvd_fix_qi, xout => signR_uid63_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- redist55_signR_uid63_block_rsrvd_fix_q_25(DELAY,542)
    redist55_signR_uid63_block_rsrvd_fix_q_25 : dspba_delay
    GENERIC MAP ( width => 1, depth => 24, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => signR_uid63_block_rsrvd_fix_q, xout => redist55_signR_uid63_block_rsrvd_fix_q_25_q, clk => clock, aclr => resetn );

    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- signRPostExc_uid180_block_rsrvd_fix(LOGICAL,179)@25 + 1
    signRPostExc_uid180_block_rsrvd_fix_qi <= redist55_signR_uid63_block_rsrvd_fix_q_25_q and invExcRNaN_uid179_block_rsrvd_fix_q;
    signRPostExc_uid180_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => signRPostExc_uid180_block_rsrvd_fix_qi, xout => signRPostExc_uid180_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- zeroOutCst_uid406_postLeftShiftProd_uid108_block_rsrvd_fix(CONSTANT,405)
    zeroOutCst_uid406_postLeftShiftProd_uid108_block_rsrvd_fix_q <= "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";

    -- leftShiftStage3Idx1Rng1_uid402_postLeftShiftProd_uid108_block_rsrvd_fix(BITSELECT,401)@18
    leftShiftStage3Idx1Rng1_uid402_postLeftShiftProd_uid108_block_rsrvd_fix_in <= leftShiftStage2_uid400_postLeftShiftProd_uid108_block_rsrvd_fix_q(103 downto 0);
    leftShiftStage3Idx1Rng1_uid402_postLeftShiftProd_uid108_block_rsrvd_fix_b <= leftShiftStage3Idx1Rng1_uid402_postLeftShiftProd_uid108_block_rsrvd_fix_in(103 downto 0);

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- leftShiftStage3Idx1_uid403_postLeftShiftProd_uid108_block_rsrvd_fix(BITJOIN,402)@18
    leftShiftStage3Idx1_uid403_postLeftShiftProd_uid108_block_rsrvd_fix_q <= leftShiftStage3Idx1Rng1_uid402_postLeftShiftProd_uid108_block_rsrvd_fix_b & GND_q;

    -- leftShiftStage2Idx3Rng6_uid397_postLeftShiftProd_uid108_block_rsrvd_fix(BITSELECT,396)@18
    leftShiftStage2Idx3Rng6_uid397_postLeftShiftProd_uid108_block_rsrvd_fix_in <= leftShiftStage1_uid389_postLeftShiftProd_uid108_block_rsrvd_fix_q(98 downto 0);
    leftShiftStage2Idx3Rng6_uid397_postLeftShiftProd_uid108_block_rsrvd_fix_b <= leftShiftStage2Idx3Rng6_uid397_postLeftShiftProd_uid108_block_rsrvd_fix_in(98 downto 0);

    -- rightShiftStage2Idx3Pad6_uid352_postRightShiftProd_uid90_block_rsrvd_fix(CONSTANT,351)
    rightShiftStage2Idx3Pad6_uid352_postRightShiftProd_uid90_block_rsrvd_fix_q <= "000000";

    -- leftShiftStage2Idx3_uid398_postLeftShiftProd_uid108_block_rsrvd_fix(BITJOIN,397)@18
    leftShiftStage2Idx3_uid398_postLeftShiftProd_uid108_block_rsrvd_fix_q <= leftShiftStage2Idx3Rng6_uid397_postLeftShiftProd_uid108_block_rsrvd_fix_b & rightShiftStage2Idx3Pad6_uid352_postRightShiftProd_uid90_block_rsrvd_fix_q;

    -- leftShiftStage2Idx2Rng4_uid394_postLeftShiftProd_uid108_block_rsrvd_fix(BITSELECT,393)@18
    leftShiftStage2Idx2Rng4_uid394_postLeftShiftProd_uid108_block_rsrvd_fix_in <= leftShiftStage1_uid389_postLeftShiftProd_uid108_block_rsrvd_fix_q(100 downto 0);
    leftShiftStage2Idx2Rng4_uid394_postLeftShiftProd_uid108_block_rsrvd_fix_b <= leftShiftStage2Idx2Rng4_uid394_postLeftShiftProd_uid108_block_rsrvd_fix_in(100 downto 0);

    -- zs_uid240_lz_uid68_block_rsrvd_fix(CONSTANT,239)
    zs_uid240_lz_uid68_block_rsrvd_fix_q <= "0000";

    -- leftShiftStage2Idx2_uid395_postLeftShiftProd_uid108_block_rsrvd_fix(BITJOIN,394)@18
    leftShiftStage2Idx2_uid395_postLeftShiftProd_uid108_block_rsrvd_fix_q <= leftShiftStage2Idx2Rng4_uid394_postLeftShiftProd_uid108_block_rsrvd_fix_b & zs_uid240_lz_uid68_block_rsrvd_fix_q;

    -- leftShiftStage2Idx1Rng2_uid391_postLeftShiftProd_uid108_block_rsrvd_fix(BITSELECT,390)@18
    leftShiftStage2Idx1Rng2_uid391_postLeftShiftProd_uid108_block_rsrvd_fix_in <= leftShiftStage1_uid389_postLeftShiftProd_uid108_block_rsrvd_fix_q(102 downto 0);
    leftShiftStage2Idx1Rng2_uid391_postLeftShiftProd_uid108_block_rsrvd_fix_b <= leftShiftStage2Idx1Rng2_uid391_postLeftShiftProd_uid108_block_rsrvd_fix_in(102 downto 0);

    -- cst02bit_uid127_block_rsrvd_fix(CONSTANT,126)
    cst02bit_uid127_block_rsrvd_fix_q <= "00";

    -- leftShiftStage2Idx1_uid392_postLeftShiftProd_uid108_block_rsrvd_fix(BITJOIN,391)@18
    leftShiftStage2Idx1_uid392_postLeftShiftProd_uid108_block_rsrvd_fix_q <= leftShiftStage2Idx1Rng2_uid391_postLeftShiftProd_uid108_block_rsrvd_fix_b & cst02bit_uid127_block_rsrvd_fix_q;

    -- leftShiftStage1Idx3Rng24_uid386_postLeftShiftProd_uid108_block_rsrvd_fix(BITSELECT,385)@17
    leftShiftStage1Idx3Rng24_uid386_postLeftShiftProd_uid108_block_rsrvd_fix_in <= leftShiftStage0_uid378_postLeftShiftProd_uid108_block_rsrvd_fix_q(80 downto 0);
    leftShiftStage1Idx3Rng24_uid386_postLeftShiftProd_uid108_block_rsrvd_fix_b <= leftShiftStage1Idx3Rng24_uid386_postLeftShiftProd_uid108_block_rsrvd_fix_in(80 downto 0);

    -- rightShiftStage1Idx3Pad24_uid341_postRightShiftProd_uid90_block_rsrvd_fix(CONSTANT,340)
    rightShiftStage1Idx3Pad24_uid341_postRightShiftProd_uid90_block_rsrvd_fix_q <= "000000000000000000000000";

    -- leftShiftStage1Idx3_uid387_postLeftShiftProd_uid108_block_rsrvd_fix(BITJOIN,386)@17
    leftShiftStage1Idx3_uid387_postLeftShiftProd_uid108_block_rsrvd_fix_q <= leftShiftStage1Idx3Rng24_uid386_postLeftShiftProd_uid108_block_rsrvd_fix_b & rightShiftStage1Idx3Pad24_uid341_postRightShiftProd_uid90_block_rsrvd_fix_q;

    -- leftShiftStage1Idx2Rng16_uid383_postLeftShiftProd_uid108_block_rsrvd_fix(BITSELECT,382)@17
    leftShiftStage1Idx2Rng16_uid383_postLeftShiftProd_uid108_block_rsrvd_fix_in <= leftShiftStage0_uid378_postLeftShiftProd_uid108_block_rsrvd_fix_q(88 downto 0);
    leftShiftStage1Idx2Rng16_uid383_postLeftShiftProd_uid108_block_rsrvd_fix_b <= leftShiftStage1Idx2Rng16_uid383_postLeftShiftProd_uid108_block_rsrvd_fix_in(88 downto 0);

    -- zs_uid228_lz_uid68_block_rsrvd_fix(CONSTANT,227)
    zs_uid228_lz_uid68_block_rsrvd_fix_q <= "0000000000000000";

    -- leftShiftStage1Idx2_uid384_postLeftShiftProd_uid108_block_rsrvd_fix(BITJOIN,383)@17
    leftShiftStage1Idx2_uid384_postLeftShiftProd_uid108_block_rsrvd_fix_q <= leftShiftStage1Idx2Rng16_uid383_postLeftShiftProd_uid108_block_rsrvd_fix_b & zs_uid228_lz_uid68_block_rsrvd_fix_q;

    -- leftShiftStage1Idx1Rng8_uid380_postLeftShiftProd_uid108_block_rsrvd_fix(BITSELECT,379)@17
    leftShiftStage1Idx1Rng8_uid380_postLeftShiftProd_uid108_block_rsrvd_fix_in <= leftShiftStage0_uid378_postLeftShiftProd_uid108_block_rsrvd_fix_q(96 downto 0);
    leftShiftStage1Idx1Rng8_uid380_postLeftShiftProd_uid108_block_rsrvd_fix_b <= leftShiftStage1Idx1Rng8_uid380_postLeftShiftProd_uid108_block_rsrvd_fix_in(96 downto 0);

    -- zs_uid234_lz_uid68_block_rsrvd_fix(CONSTANT,233)
    zs_uid234_lz_uid68_block_rsrvd_fix_q <= "00000000";

    -- leftShiftStage1Idx1_uid381_postLeftShiftProd_uid108_block_rsrvd_fix(BITJOIN,380)@17
    leftShiftStage1Idx1_uid381_postLeftShiftProd_uid108_block_rsrvd_fix_q <= leftShiftStage1Idx1Rng8_uid380_postLeftShiftProd_uid108_block_rsrvd_fix_b & zs_uid234_lz_uid68_block_rsrvd_fix_q;

    -- leftShiftStage0Idx3Rng96_uid375_postLeftShiftProd_uid108_block_rsrvd_fix(BITSELECT,374)@16
    leftShiftStage0Idx3Rng96_uid375_postLeftShiftProd_uid108_block_rsrvd_fix_in <= redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_outputreg_q(8 downto 0);
    leftShiftStage0Idx3Rng96_uid375_postLeftShiftProd_uid108_block_rsrvd_fix_b <= leftShiftStage0Idx3Rng96_uid375_postLeftShiftProd_uid108_block_rsrvd_fix_in(8 downto 0);

    -- rightShiftStage0Idx3Pad96_uid330_postRightShiftProd_uid90_block_rsrvd_fix(CONSTANT,329)
    rightShiftStage0Idx3Pad96_uid330_postRightShiftProd_uid90_block_rsrvd_fix_q <= "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";

    -- leftShiftStage0Idx3_uid376_postLeftShiftProd_uid108_block_rsrvd_fix(BITJOIN,375)@16
    leftShiftStage0Idx3_uid376_postLeftShiftProd_uid108_block_rsrvd_fix_q <= leftShiftStage0Idx3Rng96_uid375_postLeftShiftProd_uid108_block_rsrvd_fix_b & rightShiftStage0Idx3Pad96_uid330_postRightShiftProd_uid90_block_rsrvd_fix_q;

    -- redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_notEnable(LOGICAL,572)
    redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_nor(LOGICAL,573)
    redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_nor_q <= not (redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_notEnable_q or redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_sticky_ena_q);

    -- redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_mem_last(CONSTANT,569)
    redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_mem_last_q <= "010";

    -- redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_cmp(LOGICAL,570)
    redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_cmp_b <= STD_LOGIC_VECTOR("0" & redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_rdcnt_q);
    redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_cmp_q <= "1" WHEN redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_mem_last_q = redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_cmp_b ELSE "0";

    -- redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_cmpReg(REG,571)
    redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_cmpReg_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_cmpReg_q <= "0";
        ELSIF (clock'EVENT AND clock = '1') THEN
            redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_cmpReg_q <= STD_LOGIC_VECTOR(redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_cmp_q);
        END IF;
    END PROCESS;

    -- redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_sticky_ena(REG,574)
    redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_sticky_ena_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_sticky_ena_q <= "0";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_nor_q = "1") THEN
                redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_sticky_ena_q <= STD_LOGIC_VECTOR(redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_enaAnd(LOGICAL,575)
    redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_enaAnd_q <= redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_sticky_ena_q and VCC_q;

    -- redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_rdcnt(COUNTER,567)
    -- low=0, high=3, step=1, init=0
    redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_rdcnt_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_rdcnt_i <= TO_UNSIGNED(0, 2);
        ELSIF (clock'EVENT AND clock = '1') THEN
            redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_rdcnt_i <= redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_rdcnt_i + 1;
        END IF;
    END PROCESS;
    redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_rdcnt_i, 2)));

    -- invExpXIsMax_uid40_block_rsrvd_fix(LOGICAL,39)@1
    invExpXIsMax_uid40_block_rsrvd_fix_q <= not (expXIsMax_uid34_block_rsrvd_fix_q);

    -- InvExpXIsZero_uid41_block_rsrvd_fix(LOGICAL,40)@1
    InvExpXIsZero_uid41_block_rsrvd_fix_q <= not (expXIsZero_uid33_block_rsrvd_fix_q);

    -- excR_y_uid42_block_rsrvd_fix(LOGICAL,41)@1 + 1
    excR_y_uid42_block_rsrvd_fix_qi <= InvExpXIsZero_uid41_block_rsrvd_fix_q and invExpXIsMax_uid40_block_rsrvd_fix_q;
    excR_y_uid42_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excR_y_uid42_block_rsrvd_fix_qi, xout => excR_y_uid42_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- yIsAnyButSubnorm_uid47_block_rsrvd_fix(LOGICAL,46)@2
    yIsAnyButSubnorm_uid47_block_rsrvd_fix_q <= excZ_y_uid37_block_rsrvd_fix_q or excR_y_uid42_block_rsrvd_fix_q or excN_y_uid39_block_rsrvd_fix_q or excI_y_uid38_block_rsrvd_fix_q;

    -- redist67_frac_y_uid32_block_rsrvd_fix_b_2(DELAY,554)
    redist67_frac_y_uid32_block_rsrvd_fix_b_2 : dspba_delay
    GENERIC MAP ( width => 52, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => frac_y_uid32_block_rsrvd_fix_b, xout => redist67_frac_y_uid32_block_rsrvd_fix_b_2_q, clk => clock, aclr => resetn );

    -- ofracY_uid54_block_rsrvd_fix(BITJOIN,53)@2
    ofracY_uid54_block_rsrvd_fix_q <= yIsAnyButSubnorm_uid47_block_rsrvd_fix_q & redist67_frac_y_uid32_block_rsrvd_fix_b_2_q;

    -- topRangeY_uid184_prod_uid62_block_rsrvd_fix_merged_bit_select(BITSELECT,473)@2
    topRangeY_uid184_prod_uid62_block_rsrvd_fix_merged_bit_select_b <= ofracY_uid54_block_rsrvd_fix_q(52 downto 26);
    topRangeY_uid184_prod_uid62_block_rsrvd_fix_merged_bit_select_c <= ofracY_uid54_block_rsrvd_fix_q(25 downto 0);

    -- redist10_topRangeY_uid184_prod_uid62_block_rsrvd_fix_merged_bit_select_b_1(DELAY,497)
    redist10_topRangeY_uid184_prod_uid62_block_rsrvd_fix_merged_bit_select_b_1 : dspba_delay
    GENERIC MAP ( width => 27, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => topRangeY_uid184_prod_uid62_block_rsrvd_fix_merged_bit_select_b, xout => redist10_topRangeY_uid184_prod_uid62_block_rsrvd_fix_merged_bit_select_b_1_q, clk => clock, aclr => resetn );

    -- invExpXIsMax_uid23_block_rsrvd_fix(LOGICAL,22)@1
    invExpXIsMax_uid23_block_rsrvd_fix_q <= not (expXIsMax_uid17_block_rsrvd_fix_q);

    -- InvExpXIsZero_uid24_block_rsrvd_fix(LOGICAL,23)@1
    InvExpXIsZero_uid24_block_rsrvd_fix_q <= not (expXIsZero_uid16_block_rsrvd_fix_q);

    -- excR_x_uid25_block_rsrvd_fix(LOGICAL,24)@1 + 1
    excR_x_uid25_block_rsrvd_fix_qi <= InvExpXIsZero_uid24_block_rsrvd_fix_q and invExpXIsMax_uid23_block_rsrvd_fix_q;
    excR_x_uid25_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excR_x_uid25_block_rsrvd_fix_qi, xout => excR_x_uid25_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- xIsAnyButSubnorm_uid45_block_rsrvd_fix(LOGICAL,44)@2
    xIsAnyButSubnorm_uid45_block_rsrvd_fix_q <= excZ_x_uid20_block_rsrvd_fix_q or excR_x_uid25_block_rsrvd_fix_q or excN_x_uid22_block_rsrvd_fix_q or excI_x_uid21_block_rsrvd_fix_q;

    -- redist72_frac_x_uid15_block_rsrvd_fix_b_2(DELAY,559)
    redist72_frac_x_uid15_block_rsrvd_fix_b_2 : dspba_delay
    GENERIC MAP ( width => 52, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => frac_x_uid15_block_rsrvd_fix_b, xout => redist72_frac_x_uid15_block_rsrvd_fix_b_2_q, clk => clock, aclr => resetn );

    -- ofracX_uid51_block_rsrvd_fix(BITJOIN,50)@2
    ofracX_uid51_block_rsrvd_fix_q <= xIsAnyButSubnorm_uid45_block_rsrvd_fix_q & redist72_frac_x_uid15_block_rsrvd_fix_b_2_q;

    -- topRangeX_uid183_prod_uid62_block_rsrvd_fix_merged_bit_select(BITSELECT,472)@2
    topRangeX_uid183_prod_uid62_block_rsrvd_fix_merged_bit_select_b <= ofracX_uid51_block_rsrvd_fix_q(52 downto 26);
    topRangeX_uid183_prod_uid62_block_rsrvd_fix_merged_bit_select_c <= ofracX_uid51_block_rsrvd_fix_q(25 downto 0);

    -- redist11_topRangeX_uid183_prod_uid62_block_rsrvd_fix_merged_bit_select_b_1(DELAY,498)
    redist11_topRangeX_uid183_prod_uid62_block_rsrvd_fix_merged_bit_select_b_1 : dspba_delay
    GENERIC MAP ( width => 27, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => topRangeX_uid183_prod_uid62_block_rsrvd_fix_merged_bit_select_b, xout => redist11_topRangeX_uid183_prod_uid62_block_rsrvd_fix_merged_bit_select_b_1_q, clk => clock, aclr => resetn );

    -- topProd_uid185_prod_uid62_block_rsrvd_fix_cma(CHAINMULTADD,466)@3 + 2
    topProd_uid185_prod_uid62_block_rsrvd_fix_cma_reset <= not (resetn);
    topProd_uid185_prod_uid62_block_rsrvd_fix_cma_ena0 <= '1';
    topProd_uid185_prod_uid62_block_rsrvd_fix_cma_ena1 <= topProd_uid185_prod_uid62_block_rsrvd_fix_cma_ena0;
    topProd_uid185_prod_uid62_block_rsrvd_fix_cma_p(0) <= topProd_uid185_prod_uid62_block_rsrvd_fix_cma_a0(0) * topProd_uid185_prod_uid62_block_rsrvd_fix_cma_c0(0);
    topProd_uid185_prod_uid62_block_rsrvd_fix_cma_u(0) <= RESIZE(topProd_uid185_prod_uid62_block_rsrvd_fix_cma_p(0),54);
    topProd_uid185_prod_uid62_block_rsrvd_fix_cma_w(0) <= topProd_uid185_prod_uid62_block_rsrvd_fix_cma_u(0);
    topProd_uid185_prod_uid62_block_rsrvd_fix_cma_x(0) <= topProd_uid185_prod_uid62_block_rsrvd_fix_cma_w(0);
    topProd_uid185_prod_uid62_block_rsrvd_fix_cma_y(0) <= topProd_uid185_prod_uid62_block_rsrvd_fix_cma_x(0);
    topProd_uid185_prod_uid62_block_rsrvd_fix_cma_chainmultadd_input: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            topProd_uid185_prod_uid62_block_rsrvd_fix_cma_a0 <= (others => (others => '0'));
            topProd_uid185_prod_uid62_block_rsrvd_fix_cma_c0 <= (others => (others => '0'));
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (topProd_uid185_prod_uid62_block_rsrvd_fix_cma_ena0 = '1') THEN
                topProd_uid185_prod_uid62_block_rsrvd_fix_cma_a0(0) <= RESIZE(UNSIGNED(redist11_topRangeX_uid183_prod_uid62_block_rsrvd_fix_merged_bit_select_b_1_q),27);
                topProd_uid185_prod_uid62_block_rsrvd_fix_cma_c0(0) <= RESIZE(UNSIGNED(redist10_topRangeY_uid184_prod_uid62_block_rsrvd_fix_merged_bit_select_b_1_q),27);
            END IF;
        END IF;
    END PROCESS;
    topProd_uid185_prod_uid62_block_rsrvd_fix_cma_chainmultadd_output: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            topProd_uid185_prod_uid62_block_rsrvd_fix_cma_s <= (others => (others => '0'));
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (topProd_uid185_prod_uid62_block_rsrvd_fix_cma_ena1 = '1') THEN
                topProd_uid185_prod_uid62_block_rsrvd_fix_cma_s(0) <= topProd_uid185_prod_uid62_block_rsrvd_fix_cma_y(0);
            END IF;
        END IF;
    END PROCESS;
    topProd_uid185_prod_uid62_block_rsrvd_fix_cma_delay : dspba_delay
    GENERIC MAP ( width => 54, depth => 0, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => STD_LOGIC_VECTOR(topProd_uid185_prod_uid62_block_rsrvd_fix_cma_s(0)(53 downto 0)), xout => topProd_uid185_prod_uid62_block_rsrvd_fix_cma_qq, clk => clock, aclr => resetn );
    topProd_uid185_prod_uid62_block_rsrvd_fix_cma_q <= STD_LOGIC_VECTOR(topProd_uid185_prod_uid62_block_rsrvd_fix_cma_qq(53 downto 0));

    -- redist15_topProd_uid185_prod_uid62_block_rsrvd_fix_cma_q_1(DELAY,502)
    redist15_topProd_uid185_prod_uid62_block_rsrvd_fix_cma_q_1 : dspba_delay
    GENERIC MAP ( width => 54, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => topProd_uid185_prod_uid62_block_rsrvd_fix_cma_q, xout => redist15_topProd_uid185_prod_uid62_block_rsrvd_fix_cma_q_1_q, clk => clock, aclr => resetn );

    -- add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_BitSelect_for_b_tessel0_1_merged_bit_select(BITSELECT,486)@6
    add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_BitSelect_for_b_tessel0_1_merged_bit_select_b <= STD_LOGIC_VECTOR(redist15_topProd_uid185_prod_uid62_block_rsrvd_fix_cma_q_1_q(45 downto 0));
    add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_BitSelect_for_b_tessel0_1_merged_bit_select_c <= STD_LOGIC_VECTOR(redist15_topProd_uid185_prod_uid62_block_rsrvd_fix_cma_q_1_q(53 downto 46));

    -- aboveLeftY_mergedSignalTM_uid189_prod_uid62_block_rsrvd_fix(BITJOIN,188)@2
    aboveLeftY_mergedSignalTM_uid189_prod_uid62_block_rsrvd_fix_q <= topRangeY_uid184_prod_uid62_block_rsrvd_fix_merged_bit_select_c & GND_q;

    -- redist30_aboveLeftY_mergedSignalTM_uid189_prod_uid62_block_rsrvd_fix_q_1(DELAY,517)
    redist30_aboveLeftY_mergedSignalTM_uid189_prod_uid62_block_rsrvd_fix_q_1 : dspba_delay
    GENERIC MAP ( width => 27, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => aboveLeftY_mergedSignalTM_uid189_prod_uid62_block_rsrvd_fix_q, xout => redist30_aboveLeftY_mergedSignalTM_uid189_prod_uid62_block_rsrvd_fix_q_1_q, clk => clock, aclr => resetn );

    -- redist12_topRangeX_uid183_prod_uid62_block_rsrvd_fix_merged_bit_select_c_1(DELAY,499)
    redist12_topRangeX_uid183_prod_uid62_block_rsrvd_fix_merged_bit_select_c_1 : dspba_delay
    GENERIC MAP ( width => 26, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => topRangeX_uid183_prod_uid62_block_rsrvd_fix_merged_bit_select_c, xout => redist12_topRangeX_uid183_prod_uid62_block_rsrvd_fix_merged_bit_select_c_1_q, clk => clock, aclr => resetn );

    -- rightBottomX_mergedSignalTM_uid193_prod_uid62_block_rsrvd_fix(BITJOIN,192)@3
    rightBottomX_mergedSignalTM_uid193_prod_uid62_block_rsrvd_fix_q <= redist12_topRangeX_uid183_prod_uid62_block_rsrvd_fix_merged_bit_select_c_1_q & GND_q;

    -- sm0_uid206_prod_uid62_block_rsrvd_fix_cma(CHAINMULTADD,467)@3 + 2
    sm0_uid206_prod_uid62_block_rsrvd_fix_cma_reset <= not (resetn);
    sm0_uid206_prod_uid62_block_rsrvd_fix_cma_ena0 <= '1';
    sm0_uid206_prod_uid62_block_rsrvd_fix_cma_ena1 <= sm0_uid206_prod_uid62_block_rsrvd_fix_cma_ena0;
    sm0_uid206_prod_uid62_block_rsrvd_fix_cma_p(0) <= sm0_uid206_prod_uid62_block_rsrvd_fix_cma_a0(0) * sm0_uid206_prod_uid62_block_rsrvd_fix_cma_c0(0);
    sm0_uid206_prod_uid62_block_rsrvd_fix_cma_u(0) <= RESIZE(sm0_uid206_prod_uid62_block_rsrvd_fix_cma_p(0),54);
    sm0_uid206_prod_uid62_block_rsrvd_fix_cma_w(0) <= sm0_uid206_prod_uid62_block_rsrvd_fix_cma_u(0);
    sm0_uid206_prod_uid62_block_rsrvd_fix_cma_x(0) <= sm0_uid206_prod_uid62_block_rsrvd_fix_cma_w(0);
    sm0_uid206_prod_uid62_block_rsrvd_fix_cma_y(0) <= sm0_uid206_prod_uid62_block_rsrvd_fix_cma_x(0);
    sm0_uid206_prod_uid62_block_rsrvd_fix_cma_chainmultadd_input: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            sm0_uid206_prod_uid62_block_rsrvd_fix_cma_a0 <= (others => (others => '0'));
            sm0_uid206_prod_uid62_block_rsrvd_fix_cma_c0 <= (others => (others => '0'));
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (sm0_uid206_prod_uid62_block_rsrvd_fix_cma_ena0 = '1') THEN
                sm0_uid206_prod_uid62_block_rsrvd_fix_cma_a0(0) <= RESIZE(UNSIGNED(rightBottomX_mergedSignalTM_uid193_prod_uid62_block_rsrvd_fix_q),27);
                sm0_uid206_prod_uid62_block_rsrvd_fix_cma_c0(0) <= RESIZE(UNSIGNED(redist30_aboveLeftY_mergedSignalTM_uid189_prod_uid62_block_rsrvd_fix_q_1_q),27);
            END IF;
        END IF;
    END PROCESS;
    sm0_uid206_prod_uid62_block_rsrvd_fix_cma_chainmultadd_output: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            sm0_uid206_prod_uid62_block_rsrvd_fix_cma_s <= (others => (others => '0'));
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (sm0_uid206_prod_uid62_block_rsrvd_fix_cma_ena1 = '1') THEN
                sm0_uid206_prod_uid62_block_rsrvd_fix_cma_s(0) <= sm0_uid206_prod_uid62_block_rsrvd_fix_cma_y(0);
            END IF;
        END IF;
    END PROCESS;
    sm0_uid206_prod_uid62_block_rsrvd_fix_cma_delay : dspba_delay
    GENERIC MAP ( width => 54, depth => 0, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => STD_LOGIC_VECTOR(sm0_uid206_prod_uid62_block_rsrvd_fix_cma_s(0)(53 downto 0)), xout => sm0_uid206_prod_uid62_block_rsrvd_fix_cma_qq, clk => clock, aclr => resetn );
    sm0_uid206_prod_uid62_block_rsrvd_fix_cma_q <= STD_LOGIC_VECTOR(sm0_uid206_prod_uid62_block_rsrvd_fix_cma_qq(53 downto 0));

    -- redist14_sm0_uid206_prod_uid62_block_rsrvd_fix_cma_q_1(DELAY,501)
    redist14_sm0_uid206_prod_uid62_block_rsrvd_fix_cma_q_1 : dspba_delay
    GENERIC MAP ( width => 54, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => sm0_uid206_prod_uid62_block_rsrvd_fix_cma_q, xout => redist14_sm0_uid206_prod_uid62_block_rsrvd_fix_cma_q_1_q, clk => clock, aclr => resetn );

    -- add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_BitSelect_for_b_tessel0_0(BITSELECT,460)@6
    add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_BitSelect_for_b_tessel0_0_b <= STD_LOGIC_VECTOR(redist14_sm0_uid206_prod_uid62_block_rsrvd_fix_cma_q_1_q(53 downto 27));

    -- add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_BitSelect_for_b_BitJoin_for_b(BITJOIN,462)@6
    add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_BitSelect_for_b_BitJoin_for_b_q <= add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_BitSelect_for_b_tessel0_1_merged_bit_select_b & add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_BitSelect_for_b_tessel0_0_b;

    -- multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma(CHAINMULTADD,468)@2 + 2
    -- in e@3
    -- in g@3
    -- out q@5
    multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_reset <= not (resetn);
    multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_ena0 <= '1';
    multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_ena1 <= multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_ena0;
    multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_p(0) <= multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_a0(0) * multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_c0(0);
    multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_p(1) <= multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_a0(1) * multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_c0(1);
    multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_u(0) <= RESIZE(multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_p(0),55);
    multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_u(1) <= RESIZE(multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_p(1),55);
    multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_w(0) <= multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_u(0);
    multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_w(1) <= multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_u(1);
    multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_x(0) <= multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_w(0);
    multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_x(1) <= multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_w(1);
    multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_y(0) <= multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_s(1) + multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_x(0);
    multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_y(1) <= multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_x(1);
    multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_chainmultadd_input: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_a0 <= (others => (others => '0'));
            multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_c0 <= (others => (others => '0'));
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_ena0 = '1') THEN
                multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_a0(0) <= RESIZE(UNSIGNED(redist10_topRangeY_uid184_prod_uid62_block_rsrvd_fix_merged_bit_select_b_1_q),27);
                multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_a0(1) <= RESIZE(UNSIGNED(aboveLeftY_mergedSignalTM_uid189_prod_uid62_block_rsrvd_fix_q),27);
                multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_c0(0) <= RESIZE(UNSIGNED(rightBottomX_mergedSignalTM_uid193_prod_uid62_block_rsrvd_fix_q),27);
                multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_c0(1) <= RESIZE(UNSIGNED(topRangeX_uid183_prod_uid62_block_rsrvd_fix_merged_bit_select_b),27);
            END IF;
        END IF;
    END PROCESS;
    multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_chainmultadd_output: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_s <= (others => (others => '0'));
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_ena1 = '1') THEN
                multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_s(0) <= multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_y(0);
                multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_s(1) <= multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_y(1);
            END IF;
        END IF;
    END PROCESS;
    multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_delay : dspba_delay
    GENERIC MAP ( width => 55, depth => 0, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => STD_LOGIC_VECTOR(multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_s(0)(54 downto 0)), xout => multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_qq, clk => clock, aclr => resetn );
    multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_q <= STD_LOGIC_VECTOR(multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_qq(54 downto 0));

    -- redist13_multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_q_1(DELAY,500)
    redist13_multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_q_1 : dspba_delay
    GENERIC MAP ( width => 55, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_q, xout => redist13_multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_q_1_q, clk => clock, aclr => resetn );

    -- add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_BitSelect_for_a_BitJoin_for_b(BITJOIN,457)@6
    add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_BitSelect_for_a_BitJoin_for_b_q <= add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_BitSelect_for_a_tessel0_1_merged_bit_select_b & redist13_multSumOfTwoTS_uid196_prod_uid62_block_rsrvd_fix_cma_q_1_q;

    -- add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_p1_of_2(ADD,452)@6 + 1
    add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_p1_of_2_a <= STD_LOGIC_VECTOR("0" & add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_BitSelect_for_a_BitJoin_for_b_q);
    add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_p1_of_2_b <= STD_LOGIC_VECTOR("0" & add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_BitSelect_for_b_BitJoin_for_b_q);
    add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_p1_of_2_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_p1_of_2_o <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_p1_of_2_o <= STD_LOGIC_VECTOR(UNSIGNED(add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_p1_of_2_a) + UNSIGNED(add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_p1_of_2_b));
        END IF;
    END PROCESS;
    add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_p1_of_2_c(0) <= add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_p1_of_2_o(73);
    add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_p1_of_2_q <= add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_p1_of_2_o(72 downto 0);

    -- redist0_add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_BitSelect_for_b_tessel0_1_merged_bit_select_c_1(DELAY,487)
    redist0_add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_BitSelect_for_b_tessel0_1_merged_bit_select_c_1 : dspba_delay
    GENERIC MAP ( width => 8, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_BitSelect_for_b_tessel0_1_merged_bit_select_c, xout => redist0_add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_BitSelect_for_b_tessel0_1_merged_bit_select_c_1_q, clk => clock, aclr => resetn );

    -- add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_BitSelect_for_b_BitJoin_for_c(BITJOIN,465)@7
    add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_BitSelect_for_b_BitJoin_for_c_q <= GND_q & redist0_add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_BitSelect_for_b_tessel0_1_merged_bit_select_c_1_q;

    -- add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_UpperBits_for_a(CONSTANT,447)
    add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_UpperBits_for_a_q <= "000000000000000000000000000";

    -- add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_BitSelect_for_a_tessel0_1_merged_bit_select(BITSELECT,485)
    add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_BitSelect_for_a_tessel0_1_merged_bit_select_b <= STD_LOGIC_VECTOR(add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_UpperBits_for_a_q(17 downto 0));
    add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_BitSelect_for_a_tessel0_1_merged_bit_select_c <= STD_LOGIC_VECTOR(add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_UpperBits_for_a_q(26 downto 18));

    -- add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_p2_of_2(ADD,453)@7 + 1
    add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_p2_of_2_cin <= add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_p1_of_2_c;
    add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_p2_of_2_a <= STD_LOGIC_VECTOR("0" & add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_BitSelect_for_a_tessel0_1_merged_bit_select_c) & '1';
    add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_p2_of_2_b <= STD_LOGIC_VECTOR("0" & add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_BitSelect_for_b_BitJoin_for_c_q) & add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_p2_of_2_cin(0);
    add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_p2_of_2_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_p2_of_2_o <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_p2_of_2_o <= STD_LOGIC_VECTOR(UNSIGNED(add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_p2_of_2_a) + UNSIGNED(add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_p2_of_2_b));
        END IF;
    END PROCESS;
    add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_p2_of_2_q <= add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_p2_of_2_o(9 downto 1);

    -- redist16_add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_p1_of_2_q_1(DELAY,503)
    redist16_add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_p1_of_2_q_1 : dspba_delay
    GENERIC MAP ( width => 73, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_p1_of_2_q, xout => redist16_add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_p1_of_2_q_1_q, clk => clock, aclr => resetn );

    -- add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_BitJoin_for_q(BITJOIN,454)@8
    add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_BitJoin_for_q_q <= add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_p2_of_2_q & redist16_add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_p1_of_2_q_1_q;

    -- add0_uid207_prod_uid62_block_rsrvd_fix(BITJOIN,206)@6
    add0_uid207_prod_uid62_block_rsrvd_fix_q <= redist15_topProd_uid185_prod_uid62_block_rsrvd_fix_cma_q_1_q & redist14_sm0_uid206_prod_uid62_block_rsrvd_fix_cma_q_1_q;

    -- lowRangeB_uid208_prod_uid62_block_rsrvd_fix(BITSELECT,207)@6
    lowRangeB_uid208_prod_uid62_block_rsrvd_fix_in <= add0_uid207_prod_uid62_block_rsrvd_fix_q(26 downto 0);
    lowRangeB_uid208_prod_uid62_block_rsrvd_fix_b <= lowRangeB_uid208_prod_uid62_block_rsrvd_fix_in(26 downto 0);

    -- redist29_lowRangeB_uid208_prod_uid62_block_rsrvd_fix_b_2(DELAY,516)
    redist29_lowRangeB_uid208_prod_uid62_block_rsrvd_fix_b_2 : dspba_delay
    GENERIC MAP ( width => 27, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => lowRangeB_uid208_prod_uid62_block_rsrvd_fix_b, xout => redist29_lowRangeB_uid208_prod_uid62_block_rsrvd_fix_b_2_q, clk => clock, aclr => resetn );

    -- add1_uid211_prod_uid62_block_rsrvd_fix(BITJOIN,210)@8
    add1_uid211_prod_uid62_block_rsrvd_fix_q <= add1sumAHighB_uid210_prod_uid62_block_rsrvd_fix_BitJoin_for_q_q & redist29_lowRangeB_uid208_prod_uid62_block_rsrvd_fix_b_2_q;

    -- osig_uid212_prod_uid62_block_rsrvd_fix(BITSELECT,211)@8
    osig_uid212_prod_uid62_block_rsrvd_fix_in <= add1_uid211_prod_uid62_block_rsrvd_fix_q(107 downto 0);
    osig_uid212_prod_uid62_block_rsrvd_fix_b <= osig_uid212_prod_uid62_block_rsrvd_fix_in(107 downto 2);

    -- prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix(BITSELECT,63)@8
    prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_in <= osig_uid212_prod_uid62_block_rsrvd_fix_b(104 downto 0);
    prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b <= prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_in(104 downto 0);

    -- redist53_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_1(DELAY,540)
    redist53_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_1 : dspba_delay
    GENERIC MAP ( width => 105, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b, xout => redist53_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_1_q, clk => clock, aclr => resetn );

    -- vStage_uid218_lz_uid68_block_rsrvd_fix(BITSELECT,217)@9
    vStage_uid218_lz_uid68_block_rsrvd_fix_in <= redist53_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_1_q(40 downto 0);
    vStage_uid218_lz_uid68_block_rsrvd_fix_b <= vStage_uid218_lz_uid68_block_rsrvd_fix_in(40 downto 0);

    -- redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_inputreg(DELAY,564)
    redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_inputreg : dspba_delay
    GENERIC MAP ( width => 41, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => vStage_uid218_lz_uid68_block_rsrvd_fix_b, xout => redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_inputreg_q, clk => clock, aclr => resetn );

    -- redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_wraddr(REG,568)
    redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_wraddr_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_wraddr_q <= "11";
        ELSIF (clock'EVENT AND clock = '1') THEN
            redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_wraddr_q <= STD_LOGIC_VECTOR(redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_rdcnt_q);
        END IF;
    END PROCESS;

    -- redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_mem(DUALMEM,566)
    redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_mem_ia <= STD_LOGIC_VECTOR(redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_inputreg_q);
    redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_mem_aa <= redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_wraddr_q;
    redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_mem_ab <= redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_rdcnt_q;
    redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_mem_reset0 <= not (resetn);
    redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 41,
        widthad_a => 2,
        numwords_a => 4,
        width_b => 41,
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
        clocken1 => redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_enaAnd_q(0),
        clocken0 => VCC_q(0),
        clock0 => clock,
        aclr1 => redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_mem_reset0,
        clock1 => clock,
        address_a => redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_mem_aa,
        data_a => redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_mem_ab,
        q_b => redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_mem_iq
    );
    redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_mem_q <= redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_mem_iq(40 downto 0);

    -- redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_outputreg(DELAY,565)
    redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_outputreg : dspba_delay
    GENERIC MAP ( width => 41, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_mem_q, xout => redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_outputreg_q, clk => clock, aclr => resetn );

    -- zs_uid214_lz_uid68_block_rsrvd_fix(CONSTANT,213)
    zs_uid214_lz_uid68_block_rsrvd_fix_q <= "0000000000000000000000000000000000000000000000000000000000000000";

    -- leftShiftStage0Idx2_uid373_postLeftShiftProd_uid108_block_rsrvd_fix(BITJOIN,372)@16
    leftShiftStage0Idx2_uid373_postLeftShiftProd_uid108_block_rsrvd_fix_q <= redist27_vStage_uid218_lz_uid68_block_rsrvd_fix_b_7_outputreg_q & zs_uid214_lz_uid68_block_rsrvd_fix_q;

    -- leftShiftStage0Idx1Rng32_uid369_postLeftShiftProd_uid108_block_rsrvd_fix(BITSELECT,368)@16
    leftShiftStage0Idx1Rng32_uid369_postLeftShiftProd_uid108_block_rsrvd_fix_in <= redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_outputreg_q(72 downto 0);
    leftShiftStage0Idx1Rng32_uid369_postLeftShiftProd_uid108_block_rsrvd_fix_b <= leftShiftStage0Idx1Rng32_uid369_postLeftShiftProd_uid108_block_rsrvd_fix_in(72 downto 0);

    -- zs_uid222_lz_uid68_block_rsrvd_fix(CONSTANT,221)
    zs_uid222_lz_uid68_block_rsrvd_fix_q <= "00000000000000000000000000000000";

    -- leftShiftStage0Idx1_uid370_postLeftShiftProd_uid108_block_rsrvd_fix(BITJOIN,369)@16
    leftShiftStage0Idx1_uid370_postLeftShiftProd_uid108_block_rsrvd_fix_q <= leftShiftStage0Idx1Rng32_uid369_postLeftShiftProd_uid108_block_rsrvd_fix_b & zs_uid222_lz_uid68_block_rsrvd_fix_q;

    -- redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_notEnable(LOGICAL,608)
    redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_nor(LOGICAL,609)
    redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_nor_q <= not (redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_notEnable_q or redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_sticky_ena_q);

    -- redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_mem_last(CONSTANT,605)
    redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_mem_last_q <= "010";

    -- redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_cmp(LOGICAL,606)
    redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_cmp_b <= STD_LOGIC_VECTOR("0" & redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_rdcnt_q);
    redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_cmp_q <= "1" WHEN redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_mem_last_q = redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_cmp_b ELSE "0";

    -- redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_cmpReg(REG,607)
    redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_cmpReg_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_cmpReg_q <= "0";
        ELSIF (clock'EVENT AND clock = '1') THEN
            redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_cmpReg_q <= STD_LOGIC_VECTOR(redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_cmp_q);
        END IF;
    END PROCESS;

    -- redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_sticky_ena(REG,610)
    redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_sticky_ena_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_sticky_ena_q <= "0";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_nor_q = "1") THEN
                redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_sticky_ena_q <= STD_LOGIC_VECTOR(redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_enaAnd(LOGICAL,611)
    redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_enaAnd_q <= redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_sticky_ena_q and VCC_q;

    -- redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_rdcnt(COUNTER,603)
    -- low=0, high=3, step=1, init=0
    redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_rdcnt_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_rdcnt_i <= TO_UNSIGNED(0, 2);
        ELSIF (clock'EVENT AND clock = '1') THEN
            redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_rdcnt_i <= redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_rdcnt_i + 1;
        END IF;
    END PROCESS;
    redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_rdcnt_i, 2)));

    -- redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_inputreg(DELAY,600)
    redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_inputreg : dspba_delay
    GENERIC MAP ( width => 105, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist53_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_1_q, xout => redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_inputreg_q, clk => clock, aclr => resetn );

    -- redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_wraddr(REG,604)
    redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_wraddr_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_wraddr_q <= "11";
        ELSIF (clock'EVENT AND clock = '1') THEN
            redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_wraddr_q <= STD_LOGIC_VECTOR(redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_rdcnt_q);
        END IF;
    END PROCESS;

    -- redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_mem(DUALMEM,602)
    redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_mem_ia <= STD_LOGIC_VECTOR(redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_inputreg_q);
    redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_mem_aa <= redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_wraddr_q;
    redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_mem_ab <= redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_rdcnt_q;
    redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_mem_reset0 <= not (resetn);
    redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 105,
        widthad_a => 2,
        numwords_a => 4,
        width_b => 105,
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
        clocken1 => redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_enaAnd_q(0),
        clocken0 => VCC_q(0),
        clock0 => clock,
        aclr1 => redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_mem_reset0,
        clock1 => clock,
        address_a => redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_mem_aa,
        data_a => redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_mem_ab,
        q_b => redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_mem_iq
    );
    redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_mem_q <= redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_mem_iq(104 downto 0);

    -- redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_outputreg(DELAY,601)
    redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_outputreg : dspba_delay
    GENERIC MAP ( width => 105, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_mem_q, xout => redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_outputreg_q, clk => clock, aclr => resetn );

    -- biasInc_uid60_block_rsrvd_fix(CONSTANT,59)
    biasInc_uid60_block_rsrvd_fix_q <= "0001111111111";

    -- redist60_expSum_uid59_block_rsrvd_fix_q_9_notEnable(LOGICAL,620)
    redist60_expSum_uid59_block_rsrvd_fix_q_9_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist60_expSum_uid59_block_rsrvd_fix_q_9_nor(LOGICAL,621)
    redist60_expSum_uid59_block_rsrvd_fix_q_9_nor_q <= not (redist60_expSum_uid59_block_rsrvd_fix_q_9_notEnable_q or redist60_expSum_uid59_block_rsrvd_fix_q_9_sticky_ena_q);

    -- redist60_expSum_uid59_block_rsrvd_fix_q_9_mem_last(CONSTANT,617)
    redist60_expSum_uid59_block_rsrvd_fix_q_9_mem_last_q <= "011";

    -- redist60_expSum_uid59_block_rsrvd_fix_q_9_cmp(LOGICAL,618)
    redist60_expSum_uid59_block_rsrvd_fix_q_9_cmp_q <= "1" WHEN redist60_expSum_uid59_block_rsrvd_fix_q_9_mem_last_q = redist60_expSum_uid59_block_rsrvd_fix_q_9_rdcnt_q ELSE "0";

    -- redist60_expSum_uid59_block_rsrvd_fix_q_9_cmpReg(REG,619)
    redist60_expSum_uid59_block_rsrvd_fix_q_9_cmpReg_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist60_expSum_uid59_block_rsrvd_fix_q_9_cmpReg_q <= "0";
        ELSIF (clock'EVENT AND clock = '1') THEN
            redist60_expSum_uid59_block_rsrvd_fix_q_9_cmpReg_q <= STD_LOGIC_VECTOR(redist60_expSum_uid59_block_rsrvd_fix_q_9_cmp_q);
        END IF;
    END PROCESS;

    -- redist60_expSum_uid59_block_rsrvd_fix_q_9_sticky_ena(REG,622)
    redist60_expSum_uid59_block_rsrvd_fix_q_9_sticky_ena_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist60_expSum_uid59_block_rsrvd_fix_q_9_sticky_ena_q <= "0";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (redist60_expSum_uid59_block_rsrvd_fix_q_9_nor_q = "1") THEN
                redist60_expSum_uid59_block_rsrvd_fix_q_9_sticky_ena_q <= STD_LOGIC_VECTOR(redist60_expSum_uid59_block_rsrvd_fix_q_9_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist60_expSum_uid59_block_rsrvd_fix_q_9_enaAnd(LOGICAL,623)
    redist60_expSum_uid59_block_rsrvd_fix_q_9_enaAnd_q <= redist60_expSum_uid59_block_rsrvd_fix_q_9_sticky_ena_q and VCC_q;

    -- redist60_expSum_uid59_block_rsrvd_fix_q_9_rdcnt(COUNTER,615)
    -- low=0, high=4, step=1, init=0
    redist60_expSum_uid59_block_rsrvd_fix_q_9_rdcnt_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist60_expSum_uid59_block_rsrvd_fix_q_9_rdcnt_i <= TO_UNSIGNED(0, 3);
            redist60_expSum_uid59_block_rsrvd_fix_q_9_rdcnt_eq <= '0';
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (redist60_expSum_uid59_block_rsrvd_fix_q_9_rdcnt_i = TO_UNSIGNED(3, 3)) THEN
                redist60_expSum_uid59_block_rsrvd_fix_q_9_rdcnt_eq <= '1';
            ELSE
                redist60_expSum_uid59_block_rsrvd_fix_q_9_rdcnt_eq <= '0';
            END IF;
            IF (redist60_expSum_uid59_block_rsrvd_fix_q_9_rdcnt_eq = '1') THEN
                redist60_expSum_uid59_block_rsrvd_fix_q_9_rdcnt_i <= redist60_expSum_uid59_block_rsrvd_fix_q_9_rdcnt_i + 4;
            ELSE
                redist60_expSum_uid59_block_rsrvd_fix_q_9_rdcnt_i <= redist60_expSum_uid59_block_rsrvd_fix_q_9_rdcnt_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist60_expSum_uid59_block_rsrvd_fix_q_9_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist60_expSum_uid59_block_rsrvd_fix_q_9_rdcnt_i, 3)));

    -- cstOneWea_uid55_block_rsrvd_fix(CONSTANT,54)
    cstOneWea_uid55_block_rsrvd_fix_q <= "00000000001";

    -- redist74_expY_uid8_block_rsrvd_fix_b_2(DELAY,561)
    redist74_expY_uid8_block_rsrvd_fix_b_2 : dspba_delay
    GENERIC MAP ( width => 11, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist73_expY_uid8_block_rsrvd_fix_b_1_q, xout => redist74_expY_uid8_block_rsrvd_fix_b_2_q, clk => clock, aclr => resetn );

    -- yIsSubnorm_uid48_block_rsrvd_fix(LOGICAL,47)@2
    yIsSubnorm_uid48_block_rsrvd_fix_q <= not (yIsAnyButSubnorm_uid47_block_rsrvd_fix_q);

    -- expYPostSubnorm_uid58_block_rsrvd_fix(MUX,57)@2
    expYPostSubnorm_uid58_block_rsrvd_fix_s <= yIsSubnorm_uid48_block_rsrvd_fix_q;
    expYPostSubnorm_uid58_block_rsrvd_fix_combproc: PROCESS (expYPostSubnorm_uid58_block_rsrvd_fix_s, redist74_expY_uid8_block_rsrvd_fix_b_2_q, cstOneWea_uid55_block_rsrvd_fix_q)
    BEGIN
        CASE (expYPostSubnorm_uid58_block_rsrvd_fix_s) IS
            WHEN "0" => expYPostSubnorm_uid58_block_rsrvd_fix_q <= redist74_expY_uid8_block_rsrvd_fix_b_2_q;
            WHEN "1" => expYPostSubnorm_uid58_block_rsrvd_fix_q <= cstOneWea_uid55_block_rsrvd_fix_q;
            WHEN OTHERS => expYPostSubnorm_uid58_block_rsrvd_fix_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist76_expX_uid7_block_rsrvd_fix_b_2(DELAY,563)
    redist76_expX_uid7_block_rsrvd_fix_b_2 : dspba_delay
    GENERIC MAP ( width => 11, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist75_expX_uid7_block_rsrvd_fix_b_1_q, xout => redist76_expX_uid7_block_rsrvd_fix_b_2_q, clk => clock, aclr => resetn );

    -- xIsSubnorm_uid46_block_rsrvd_fix(LOGICAL,45)@2
    xIsSubnorm_uid46_block_rsrvd_fix_q <= not (xIsAnyButSubnorm_uid45_block_rsrvd_fix_q);

    -- expXPostSubnorm_uid57_block_rsrvd_fix(MUX,56)@2
    expXPostSubnorm_uid57_block_rsrvd_fix_s <= xIsSubnorm_uid46_block_rsrvd_fix_q;
    expXPostSubnorm_uid57_block_rsrvd_fix_combproc: PROCESS (expXPostSubnorm_uid57_block_rsrvd_fix_s, redist76_expX_uid7_block_rsrvd_fix_b_2_q, cstOneWea_uid55_block_rsrvd_fix_q)
    BEGIN
        CASE (expXPostSubnorm_uid57_block_rsrvd_fix_s) IS
            WHEN "0" => expXPostSubnorm_uid57_block_rsrvd_fix_q <= redist76_expX_uid7_block_rsrvd_fix_b_2_q;
            WHEN "1" => expXPostSubnorm_uid57_block_rsrvd_fix_q <= cstOneWea_uid55_block_rsrvd_fix_q;
            WHEN OTHERS => expXPostSubnorm_uid57_block_rsrvd_fix_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- expSum_uid59_block_rsrvd_fix(ADD,58)@2 + 1
    expSum_uid59_block_rsrvd_fix_a <= STD_LOGIC_VECTOR("0" & expXPostSubnorm_uid57_block_rsrvd_fix_q);
    expSum_uid59_block_rsrvd_fix_b <= STD_LOGIC_VECTOR("0" & expYPostSubnorm_uid58_block_rsrvd_fix_q);
    expSum_uid59_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            expSum_uid59_block_rsrvd_fix_o <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            expSum_uid59_block_rsrvd_fix_o <= STD_LOGIC_VECTOR(UNSIGNED(expSum_uid59_block_rsrvd_fix_a) + UNSIGNED(expSum_uid59_block_rsrvd_fix_b));
        END IF;
    END PROCESS;
    expSum_uid59_block_rsrvd_fix_q <= expSum_uid59_block_rsrvd_fix_o(11 downto 0);

    -- redist60_expSum_uid59_block_rsrvd_fix_q_9_inputreg(DELAY,612)
    redist60_expSum_uid59_block_rsrvd_fix_q_9_inputreg : dspba_delay
    GENERIC MAP ( width => 12, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => expSum_uid59_block_rsrvd_fix_q, xout => redist60_expSum_uid59_block_rsrvd_fix_q_9_inputreg_q, clk => clock, aclr => resetn );

    -- redist60_expSum_uid59_block_rsrvd_fix_q_9_wraddr(REG,616)
    redist60_expSum_uid59_block_rsrvd_fix_q_9_wraddr_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist60_expSum_uid59_block_rsrvd_fix_q_9_wraddr_q <= "100";
        ELSIF (clock'EVENT AND clock = '1') THEN
            redist60_expSum_uid59_block_rsrvd_fix_q_9_wraddr_q <= STD_LOGIC_VECTOR(redist60_expSum_uid59_block_rsrvd_fix_q_9_rdcnt_q);
        END IF;
    END PROCESS;

    -- redist60_expSum_uid59_block_rsrvd_fix_q_9_mem(DUALMEM,614)
    redist60_expSum_uid59_block_rsrvd_fix_q_9_mem_ia <= STD_LOGIC_VECTOR(redist60_expSum_uid59_block_rsrvd_fix_q_9_inputreg_q);
    redist60_expSum_uid59_block_rsrvd_fix_q_9_mem_aa <= redist60_expSum_uid59_block_rsrvd_fix_q_9_wraddr_q;
    redist60_expSum_uid59_block_rsrvd_fix_q_9_mem_ab <= redist60_expSum_uid59_block_rsrvd_fix_q_9_rdcnt_q;
    redist60_expSum_uid59_block_rsrvd_fix_q_9_mem_reset0 <= not (resetn);
    redist60_expSum_uid59_block_rsrvd_fix_q_9_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 12,
        widthad_a => 3,
        numwords_a => 5,
        width_b => 12,
        widthad_b => 3,
        numwords_b => 5,
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
        clocken1 => redist60_expSum_uid59_block_rsrvd_fix_q_9_enaAnd_q(0),
        clocken0 => VCC_q(0),
        clock0 => clock,
        aclr1 => redist60_expSum_uid59_block_rsrvd_fix_q_9_mem_reset0,
        clock1 => clock,
        address_a => redist60_expSum_uid59_block_rsrvd_fix_q_9_mem_aa,
        data_a => redist60_expSum_uid59_block_rsrvd_fix_q_9_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist60_expSum_uid59_block_rsrvd_fix_q_9_mem_ab,
        q_b => redist60_expSum_uid59_block_rsrvd_fix_q_9_mem_iq
    );
    redist60_expSum_uid59_block_rsrvd_fix_q_9_mem_q <= redist60_expSum_uid59_block_rsrvd_fix_q_9_mem_iq(11 downto 0);

    -- redist60_expSum_uid59_block_rsrvd_fix_q_9_outputreg(DELAY,613)
    redist60_expSum_uid59_block_rsrvd_fix_q_9_outputreg : dspba_delay
    GENERIC MAP ( width => 12, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist60_expSum_uid59_block_rsrvd_fix_q_9_mem_q, xout => redist60_expSum_uid59_block_rsrvd_fix_q_9_outputreg_q, clk => clock, aclr => resetn );

    -- expSumMBias_uid61_block_rsrvd_fix(SUB,60)@11 + 1
    expSumMBias_uid61_block_rsrvd_fix_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000" & redist60_expSum_uid59_block_rsrvd_fix_q_9_outputreg_q));
    expSumMBias_uid61_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 13 => biasInc_uid60_block_rsrvd_fix_q(12)) & biasInc_uid60_block_rsrvd_fix_q));
    expSumMBias_uid61_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            expSumMBias_uid61_block_rsrvd_fix_o <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            expSumMBias_uid61_block_rsrvd_fix_o <= STD_LOGIC_VECTOR(SIGNED(expSumMBias_uid61_block_rsrvd_fix_a) - SIGNED(expSumMBias_uid61_block_rsrvd_fix_b));
        END IF;
    END PROCESS;
    expSumMBias_uid61_block_rsrvd_fix_q <= expSumMBias_uid61_block_rsrvd_fix_o(13 downto 0);

    -- redist56_expSumMBias_uid61_block_rsrvd_fix_q_2(DELAY,543)
    redist56_expSumMBias_uid61_block_rsrvd_fix_q_2 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => expSumMBias_uid61_block_rsrvd_fix_q, xout => redist56_expSumMBias_uid61_block_rsrvd_fix_q_2_q, clk => clock, aclr => resetn );

    -- redist57_expSumMBias_uid61_block_rsrvd_fix_q_4(DELAY,544)
    redist57_expSumMBias_uid61_block_rsrvd_fix_q_4 : dspba_delay
    GENERIC MAP ( width => 14, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist56_expSumMBias_uid61_block_rsrvd_fix_q_2_q, xout => redist57_expSumMBias_uid61_block_rsrvd_fix_q_4_q, clk => clock, aclr => resetn );

    -- subnormLeftShiftValue_uid104_block_rsrvd_fix(SUB,103)@15 + 1
    subnormLeftShiftValue_uid104_block_rsrvd_fix_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((15 downto 14 => redist57_expSumMBias_uid61_block_rsrvd_fix_q_4_q(13)) & redist57_expSumMBias_uid61_block_rsrvd_fix_q_4_q));
    subnormLeftShiftValue_uid104_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000000000000000" & VCC_q));
    subnormLeftShiftValue_uid104_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            subnormLeftShiftValue_uid104_block_rsrvd_fix_o <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            subnormLeftShiftValue_uid104_block_rsrvd_fix_o <= STD_LOGIC_VECTOR(SIGNED(subnormLeftShiftValue_uid104_block_rsrvd_fix_a) - SIGNED(subnormLeftShiftValue_uid104_block_rsrvd_fix_b));
        END IF;
    END PROCESS;
    subnormLeftShiftValue_uid104_block_rsrvd_fix_q <= subnormLeftShiftValue_uid104_block_rsrvd_fix_o(14 downto 0);

    -- c0_uid412_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select(BITSELECT,477)
    c0_uid412_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_b <= zs_uid214_lz_uid68_block_rsrvd_fix_q(5 downto 0);
    c0_uid412_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_c <= zs_uid214_lz_uid68_block_rsrvd_fix_q(11 downto 6);
    c0_uid412_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_d <= zs_uid214_lz_uid68_block_rsrvd_fix_q(17 downto 12);
    c0_uid412_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_e <= zs_uid214_lz_uid68_block_rsrvd_fix_q(23 downto 18);
    c0_uid412_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_f <= zs_uid214_lz_uid68_block_rsrvd_fix_q(29 downto 24);
    c0_uid412_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_g <= zs_uid214_lz_uid68_block_rsrvd_fix_q(35 downto 30);
    c0_uid412_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_h <= zs_uid214_lz_uid68_block_rsrvd_fix_q(41 downto 36);
    c0_uid412_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_i <= zs_uid214_lz_uid68_block_rsrvd_fix_q(47 downto 42);
    c0_uid412_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_j <= zs_uid214_lz_uid68_block_rsrvd_fix_q(53 downto 48);
    c0_uid412_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_k <= zs_uid214_lz_uid68_block_rsrvd_fix_q(59 downto 54);
    c0_uid412_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_l <= zs_uid214_lz_uid68_block_rsrvd_fix_q(63 downto 60);

    -- rVStage_uid215_lz_uid68_block_rsrvd_fix(BITSELECT,214)@8
    rVStage_uid215_lz_uid68_block_rsrvd_fix_b <= prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b(104 downto 41);

    -- z0_uid411_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select(BITSELECT,478)@8
    z0_uid411_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_b <= rVStage_uid215_lz_uid68_block_rsrvd_fix_b(5 downto 0);
    z0_uid411_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_c <= rVStage_uid215_lz_uid68_block_rsrvd_fix_b(11 downto 6);
    z0_uid411_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_d <= rVStage_uid215_lz_uid68_block_rsrvd_fix_b(17 downto 12);
    z0_uid411_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_e <= rVStage_uid215_lz_uid68_block_rsrvd_fix_b(23 downto 18);
    z0_uid411_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_f <= rVStage_uid215_lz_uid68_block_rsrvd_fix_b(29 downto 24);
    z0_uid411_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_g <= rVStage_uid215_lz_uid68_block_rsrvd_fix_b(35 downto 30);
    z0_uid411_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_h <= rVStage_uid215_lz_uid68_block_rsrvd_fix_b(41 downto 36);
    z0_uid411_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_i <= rVStage_uid215_lz_uid68_block_rsrvd_fix_b(47 downto 42);
    z0_uid411_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_j <= rVStage_uid215_lz_uid68_block_rsrvd_fix_b(53 downto 48);
    z0_uid411_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_k <= rVStage_uid215_lz_uid68_block_rsrvd_fix_b(59 downto 54);
    z0_uid411_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_l <= rVStage_uid215_lz_uid68_block_rsrvd_fix_b(63 downto 60);

    -- eq10_uid443_vCount_uid216_lz_uid68_block_rsrvd_fix(LOGICAL,442)@8
    eq10_uid443_vCount_uid216_lz_uid68_block_rsrvd_fix_q <= "1" WHEN z0_uid411_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_l = c0_uid412_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_l ELSE "0";

    -- eq9_uid440_vCount_uid216_lz_uid68_block_rsrvd_fix(LOGICAL,439)@8
    eq9_uid440_vCount_uid216_lz_uid68_block_rsrvd_fix_q <= "1" WHEN z0_uid411_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_k = c0_uid412_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_k ELSE "0";

    -- eq8_uid437_vCount_uid216_lz_uid68_block_rsrvd_fix(LOGICAL,436)@8
    eq8_uid437_vCount_uid216_lz_uid68_block_rsrvd_fix_q <= "1" WHEN z0_uid411_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_j = c0_uid412_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_j ELSE "0";

    -- eq7_uid434_vCount_uid216_lz_uid68_block_rsrvd_fix(LOGICAL,433)@8
    eq7_uid434_vCount_uid216_lz_uid68_block_rsrvd_fix_q <= "1" WHEN z0_uid411_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_i = c0_uid412_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_i ELSE "0";

    -- eq6_uid431_vCount_uid216_lz_uid68_block_rsrvd_fix(LOGICAL,430)@8
    eq6_uid431_vCount_uid216_lz_uid68_block_rsrvd_fix_q <= "1" WHEN z0_uid411_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_h = c0_uid412_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_h ELSE "0";

    -- and_lev0_uid445_vCount_uid216_lz_uid68_block_rsrvd_fix(LOGICAL,444)@8 + 1
    and_lev0_uid445_vCount_uid216_lz_uid68_block_rsrvd_fix_qi <= eq6_uid431_vCount_uid216_lz_uid68_block_rsrvd_fix_q and eq7_uid434_vCount_uid216_lz_uid68_block_rsrvd_fix_q and eq8_uid437_vCount_uid216_lz_uid68_block_rsrvd_fix_q and eq9_uid440_vCount_uid216_lz_uid68_block_rsrvd_fix_q and eq10_uid443_vCount_uid216_lz_uid68_block_rsrvd_fix_q;
    and_lev0_uid445_vCount_uid216_lz_uid68_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => and_lev0_uid445_vCount_uid216_lz_uid68_block_rsrvd_fix_qi, xout => and_lev0_uid445_vCount_uid216_lz_uid68_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- eq5_uid428_vCount_uid216_lz_uid68_block_rsrvd_fix(LOGICAL,427)@8
    eq5_uid428_vCount_uid216_lz_uid68_block_rsrvd_fix_q <= "1" WHEN z0_uid411_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_g = c0_uid412_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_g ELSE "0";

    -- eq4_uid425_vCount_uid216_lz_uid68_block_rsrvd_fix(LOGICAL,424)@8
    eq4_uid425_vCount_uid216_lz_uid68_block_rsrvd_fix_q <= "1" WHEN z0_uid411_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_f = c0_uid412_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_f ELSE "0";

    -- eq3_uid422_vCount_uid216_lz_uid68_block_rsrvd_fix(LOGICAL,421)@8
    eq3_uid422_vCount_uid216_lz_uid68_block_rsrvd_fix_q <= "1" WHEN z0_uid411_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_e = c0_uid412_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_e ELSE "0";

    -- eq2_uid419_vCount_uid216_lz_uid68_block_rsrvd_fix(LOGICAL,418)@8
    eq2_uid419_vCount_uid216_lz_uid68_block_rsrvd_fix_q <= "1" WHEN z0_uid411_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_d = c0_uid412_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_d ELSE "0";

    -- eq1_uid416_vCount_uid216_lz_uid68_block_rsrvd_fix(LOGICAL,415)@8
    eq1_uid416_vCount_uid216_lz_uid68_block_rsrvd_fix_q <= "1" WHEN z0_uid411_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_c = c0_uid412_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_c ELSE "0";

    -- eq0_uid413_vCount_uid216_lz_uid68_block_rsrvd_fix(LOGICAL,412)@8
    eq0_uid413_vCount_uid216_lz_uid68_block_rsrvd_fix_q <= "1" WHEN z0_uid411_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_b = c0_uid412_vCount_uid216_lz_uid68_block_rsrvd_fix_merged_bit_select_b ELSE "0";

    -- and_lev0_uid444_vCount_uid216_lz_uid68_block_rsrvd_fix(LOGICAL,443)@8 + 1
    and_lev0_uid444_vCount_uid216_lz_uid68_block_rsrvd_fix_qi <= eq0_uid413_vCount_uid216_lz_uid68_block_rsrvd_fix_q and eq1_uid416_vCount_uid216_lz_uid68_block_rsrvd_fix_q and eq2_uid419_vCount_uid216_lz_uid68_block_rsrvd_fix_q and eq3_uid422_vCount_uid216_lz_uid68_block_rsrvd_fix_q and eq4_uid425_vCount_uid216_lz_uid68_block_rsrvd_fix_q and eq5_uid428_vCount_uid216_lz_uid68_block_rsrvd_fix_q;
    and_lev0_uid444_vCount_uid216_lz_uid68_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => and_lev0_uid444_vCount_uid216_lz_uid68_block_rsrvd_fix_qi, xout => and_lev0_uid444_vCount_uid216_lz_uid68_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- and_lev1_uid446_vCount_uid216_lz_uid68_block_rsrvd_fix(LOGICAL,445)@9
    and_lev1_uid446_vCount_uid216_lz_uid68_block_rsrvd_fix_q <= and_lev0_uid444_vCount_uid216_lz_uid68_block_rsrvd_fix_q and and_lev0_uid445_vCount_uid216_lz_uid68_block_rsrvd_fix_q;

    -- redist17_and_lev1_uid446_vCount_uid216_lz_uid68_block_rsrvd_fix_q_6(DELAY,504)
    redist17_and_lev1_uid446_vCount_uid216_lz_uid68_block_rsrvd_fix_q_6 : dspba_delay
    GENERIC MAP ( width => 1, depth => 6, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => and_lev1_uid446_vCount_uid216_lz_uid68_block_rsrvd_fix_q, xout => redist17_and_lev1_uid446_vCount_uid216_lz_uid68_block_rsrvd_fix_q_6_q, clk => clock, aclr => resetn );

    -- mO_uid217_lz_uid68_block_rsrvd_fix(CONSTANT,216)
    mO_uid217_lz_uid68_block_rsrvd_fix_q <= "11111111111111111111111";

    -- cStage_uid219_lz_uid68_block_rsrvd_fix(BITJOIN,218)@9
    cStage_uid219_lz_uid68_block_rsrvd_fix_q <= vStage_uid218_lz_uid68_block_rsrvd_fix_b & mO_uid217_lz_uid68_block_rsrvd_fix_q;

    -- redist28_rVStage_uid215_lz_uid68_block_rsrvd_fix_b_1(DELAY,515)
    redist28_rVStage_uid215_lz_uid68_block_rsrvd_fix_b_1 : dspba_delay
    GENERIC MAP ( width => 64, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => rVStage_uid215_lz_uid68_block_rsrvd_fix_b, xout => redist28_rVStage_uid215_lz_uid68_block_rsrvd_fix_b_1_q, clk => clock, aclr => resetn );

    -- vStagei_uid221_lz_uid68_block_rsrvd_fix(MUX,220)@9 + 1
    vStagei_uid221_lz_uid68_block_rsrvd_fix_s <= and_lev1_uid446_vCount_uid216_lz_uid68_block_rsrvd_fix_q;
    vStagei_uid221_lz_uid68_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            vStagei_uid221_lz_uid68_block_rsrvd_fix_q <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            CASE (vStagei_uid221_lz_uid68_block_rsrvd_fix_s) IS
                WHEN "0" => vStagei_uid221_lz_uid68_block_rsrvd_fix_q <= redist28_rVStage_uid215_lz_uid68_block_rsrvd_fix_b_1_q;
                WHEN "1" => vStagei_uid221_lz_uid68_block_rsrvd_fix_q <= cStage_uid219_lz_uid68_block_rsrvd_fix_q;
                WHEN OTHERS => vStagei_uid221_lz_uid68_block_rsrvd_fix_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- rVStage_uid223_lz_uid68_block_rsrvd_fix_merged_bit_select(BITSELECT,479)@10
    rVStage_uid223_lz_uid68_block_rsrvd_fix_merged_bit_select_b <= vStagei_uid221_lz_uid68_block_rsrvd_fix_q(63 downto 32);
    rVStage_uid223_lz_uid68_block_rsrvd_fix_merged_bit_select_c <= vStagei_uid221_lz_uid68_block_rsrvd_fix_q(31 downto 0);

    -- vCount_uid224_lz_uid68_block_rsrvd_fix(LOGICAL,223)@10
    vCount_uid224_lz_uid68_block_rsrvd_fix_q <= "1" WHEN rVStage_uid223_lz_uid68_block_rsrvd_fix_merged_bit_select_b = zs_uid222_lz_uid68_block_rsrvd_fix_q ELSE "0";

    -- redist26_vCount_uid224_lz_uid68_block_rsrvd_fix_q_5(DELAY,513)
    redist26_vCount_uid224_lz_uid68_block_rsrvd_fix_q_5 : dspba_delay
    GENERIC MAP ( width => 1, depth => 5, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => vCount_uid224_lz_uid68_block_rsrvd_fix_q, xout => redist26_vCount_uid224_lz_uid68_block_rsrvd_fix_q_5_q, clk => clock, aclr => resetn );

    -- vStagei_uid227_lz_uid68_block_rsrvd_fix(MUX,226)@10 + 1
    vStagei_uid227_lz_uid68_block_rsrvd_fix_s <= vCount_uid224_lz_uid68_block_rsrvd_fix_q;
    vStagei_uid227_lz_uid68_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            vStagei_uid227_lz_uid68_block_rsrvd_fix_q <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            CASE (vStagei_uid227_lz_uid68_block_rsrvd_fix_s) IS
                WHEN "0" => vStagei_uid227_lz_uid68_block_rsrvd_fix_q <= rVStage_uid223_lz_uid68_block_rsrvd_fix_merged_bit_select_b;
                WHEN "1" => vStagei_uid227_lz_uid68_block_rsrvd_fix_q <= rVStage_uid223_lz_uid68_block_rsrvd_fix_merged_bit_select_c;
                WHEN OTHERS => vStagei_uid227_lz_uid68_block_rsrvd_fix_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- rVStage_uid229_lz_uid68_block_rsrvd_fix_merged_bit_select(BITSELECT,480)@11
    rVStage_uid229_lz_uid68_block_rsrvd_fix_merged_bit_select_b <= vStagei_uid227_lz_uid68_block_rsrvd_fix_q(31 downto 16);
    rVStage_uid229_lz_uid68_block_rsrvd_fix_merged_bit_select_c <= vStagei_uid227_lz_uid68_block_rsrvd_fix_q(15 downto 0);

    -- vCount_uid230_lz_uid68_block_rsrvd_fix(LOGICAL,229)@11
    vCount_uid230_lz_uid68_block_rsrvd_fix_q <= "1" WHEN rVStage_uid229_lz_uid68_block_rsrvd_fix_merged_bit_select_b = zs_uid228_lz_uid68_block_rsrvd_fix_q ELSE "0";

    -- redist25_vCount_uid230_lz_uid68_block_rsrvd_fix_q_4(DELAY,512)
    redist25_vCount_uid230_lz_uid68_block_rsrvd_fix_q_4 : dspba_delay
    GENERIC MAP ( width => 1, depth => 4, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => vCount_uid230_lz_uid68_block_rsrvd_fix_q, xout => redist25_vCount_uid230_lz_uid68_block_rsrvd_fix_q_4_q, clk => clock, aclr => resetn );

    -- vStagei_uid233_lz_uid68_block_rsrvd_fix(MUX,232)@11 + 1
    vStagei_uid233_lz_uid68_block_rsrvd_fix_s <= vCount_uid230_lz_uid68_block_rsrvd_fix_q;
    vStagei_uid233_lz_uid68_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            vStagei_uid233_lz_uid68_block_rsrvd_fix_q <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            CASE (vStagei_uid233_lz_uid68_block_rsrvd_fix_s) IS
                WHEN "0" => vStagei_uid233_lz_uid68_block_rsrvd_fix_q <= rVStage_uid229_lz_uid68_block_rsrvd_fix_merged_bit_select_b;
                WHEN "1" => vStagei_uid233_lz_uid68_block_rsrvd_fix_q <= rVStage_uid229_lz_uid68_block_rsrvd_fix_merged_bit_select_c;
                WHEN OTHERS => vStagei_uid233_lz_uid68_block_rsrvd_fix_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- rVStage_uid235_lz_uid68_block_rsrvd_fix_merged_bit_select(BITSELECT,481)@12
    rVStage_uid235_lz_uid68_block_rsrvd_fix_merged_bit_select_b <= vStagei_uid233_lz_uid68_block_rsrvd_fix_q(15 downto 8);
    rVStage_uid235_lz_uid68_block_rsrvd_fix_merged_bit_select_c <= vStagei_uid233_lz_uid68_block_rsrvd_fix_q(7 downto 0);

    -- vCount_uid236_lz_uid68_block_rsrvd_fix(LOGICAL,235)@12
    vCount_uid236_lz_uid68_block_rsrvd_fix_q <= "1" WHEN rVStage_uid235_lz_uid68_block_rsrvd_fix_merged_bit_select_b = zs_uid234_lz_uid68_block_rsrvd_fix_q ELSE "0";

    -- redist24_vCount_uid236_lz_uid68_block_rsrvd_fix_q_3(DELAY,511)
    redist24_vCount_uid236_lz_uid68_block_rsrvd_fix_q_3 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => vCount_uid236_lz_uid68_block_rsrvd_fix_q, xout => redist24_vCount_uid236_lz_uid68_block_rsrvd_fix_q_3_q, clk => clock, aclr => resetn );

    -- vStagei_uid239_lz_uid68_block_rsrvd_fix(MUX,238)@12 + 1
    vStagei_uid239_lz_uid68_block_rsrvd_fix_s <= vCount_uid236_lz_uid68_block_rsrvd_fix_q;
    vStagei_uid239_lz_uid68_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            vStagei_uid239_lz_uid68_block_rsrvd_fix_q <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            CASE (vStagei_uid239_lz_uid68_block_rsrvd_fix_s) IS
                WHEN "0" => vStagei_uid239_lz_uid68_block_rsrvd_fix_q <= rVStage_uid235_lz_uid68_block_rsrvd_fix_merged_bit_select_b;
                WHEN "1" => vStagei_uid239_lz_uid68_block_rsrvd_fix_q <= rVStage_uid235_lz_uid68_block_rsrvd_fix_merged_bit_select_c;
                WHEN OTHERS => vStagei_uid239_lz_uid68_block_rsrvd_fix_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- rVStage_uid241_lz_uid68_block_rsrvd_fix_merged_bit_select(BITSELECT,482)@13
    rVStage_uid241_lz_uid68_block_rsrvd_fix_merged_bit_select_b <= vStagei_uid239_lz_uid68_block_rsrvd_fix_q(7 downto 4);
    rVStage_uid241_lz_uid68_block_rsrvd_fix_merged_bit_select_c <= vStagei_uid239_lz_uid68_block_rsrvd_fix_q(3 downto 0);

    -- vCount_uid242_lz_uid68_block_rsrvd_fix(LOGICAL,241)@13
    vCount_uid242_lz_uid68_block_rsrvd_fix_q <= "1" WHEN rVStage_uid241_lz_uid68_block_rsrvd_fix_merged_bit_select_b = zs_uid240_lz_uid68_block_rsrvd_fix_q ELSE "0";

    -- redist23_vCount_uid242_lz_uid68_block_rsrvd_fix_q_2(DELAY,510)
    redist23_vCount_uid242_lz_uid68_block_rsrvd_fix_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => vCount_uid242_lz_uid68_block_rsrvd_fix_q, xout => redist23_vCount_uid242_lz_uid68_block_rsrvd_fix_q_2_q, clk => clock, aclr => resetn );

    -- vStagei_uid245_lz_uid68_block_rsrvd_fix(MUX,244)@13 + 1
    vStagei_uid245_lz_uid68_block_rsrvd_fix_s <= vCount_uid242_lz_uid68_block_rsrvd_fix_q;
    vStagei_uid245_lz_uid68_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            vStagei_uid245_lz_uid68_block_rsrvd_fix_q <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            CASE (vStagei_uid245_lz_uid68_block_rsrvd_fix_s) IS
                WHEN "0" => vStagei_uid245_lz_uid68_block_rsrvd_fix_q <= rVStage_uid241_lz_uid68_block_rsrvd_fix_merged_bit_select_b;
                WHEN "1" => vStagei_uid245_lz_uid68_block_rsrvd_fix_q <= rVStage_uid241_lz_uid68_block_rsrvd_fix_merged_bit_select_c;
                WHEN OTHERS => vStagei_uid245_lz_uid68_block_rsrvd_fix_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- rVStage_uid247_lz_uid68_block_rsrvd_fix_merged_bit_select(BITSELECT,483)@14
    rVStage_uid247_lz_uid68_block_rsrvd_fix_merged_bit_select_b <= vStagei_uid245_lz_uid68_block_rsrvd_fix_q(3 downto 2);
    rVStage_uid247_lz_uid68_block_rsrvd_fix_merged_bit_select_c <= vStagei_uid245_lz_uid68_block_rsrvd_fix_q(1 downto 0);

    -- vCount_uid248_lz_uid68_block_rsrvd_fix(LOGICAL,247)@14
    vCount_uid248_lz_uid68_block_rsrvd_fix_q <= "1" WHEN rVStage_uid247_lz_uid68_block_rsrvd_fix_merged_bit_select_b = cst02bit_uid127_block_rsrvd_fix_q ELSE "0";

    -- redist22_vCount_uid248_lz_uid68_block_rsrvd_fix_q_1(DELAY,509)
    redist22_vCount_uid248_lz_uid68_block_rsrvd_fix_q_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => vCount_uid248_lz_uid68_block_rsrvd_fix_q, xout => redist22_vCount_uid248_lz_uid68_block_rsrvd_fix_q_1_q, clk => clock, aclr => resetn );

    -- vStagei_uid251_lz_uid68_block_rsrvd_fix(MUX,250)@14
    vStagei_uid251_lz_uid68_block_rsrvd_fix_s <= vCount_uid248_lz_uid68_block_rsrvd_fix_q;
    vStagei_uid251_lz_uid68_block_rsrvd_fix_combproc: PROCESS (vStagei_uid251_lz_uid68_block_rsrvd_fix_s, rVStage_uid247_lz_uid68_block_rsrvd_fix_merged_bit_select_b, rVStage_uid247_lz_uid68_block_rsrvd_fix_merged_bit_select_c)
    BEGIN
        CASE (vStagei_uid251_lz_uid68_block_rsrvd_fix_s) IS
            WHEN "0" => vStagei_uid251_lz_uid68_block_rsrvd_fix_q <= rVStage_uid247_lz_uid68_block_rsrvd_fix_merged_bit_select_b;
            WHEN "1" => vStagei_uid251_lz_uid68_block_rsrvd_fix_q <= rVStage_uid247_lz_uid68_block_rsrvd_fix_merged_bit_select_c;
            WHEN OTHERS => vStagei_uid251_lz_uid68_block_rsrvd_fix_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid253_lz_uid68_block_rsrvd_fix(BITSELECT,252)@14
    rVStage_uid253_lz_uid68_block_rsrvd_fix_b <= vStagei_uid251_lz_uid68_block_rsrvd_fix_q(1 downto 1);

    -- redist21_rVStage_uid253_lz_uid68_block_rsrvd_fix_b_1(DELAY,508)
    redist21_rVStage_uid253_lz_uid68_block_rsrvd_fix_b_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => rVStage_uid253_lz_uid68_block_rsrvd_fix_b, xout => redist21_rVStage_uid253_lz_uid68_block_rsrvd_fix_b_1_q, clk => clock, aclr => resetn );

    -- vCount_uid254_lz_uid68_block_rsrvd_fix(LOGICAL,253)@15
    vCount_uid254_lz_uid68_block_rsrvd_fix_q <= "1" WHEN redist21_rVStage_uid253_lz_uid68_block_rsrvd_fix_b_1_q = GND_q ELSE "0";

    -- r_uid255_lz_uid68_block_rsrvd_fix(BITJOIN,254)@15
    r_uid255_lz_uid68_block_rsrvd_fix_q <= redist17_and_lev1_uid446_vCount_uid216_lz_uid68_block_rsrvd_fix_q_6_q & redist26_vCount_uid224_lz_uid68_block_rsrvd_fix_q_5_q & redist25_vCount_uid230_lz_uid68_block_rsrvd_fix_q_4_q & redist24_vCount_uid236_lz_uid68_block_rsrvd_fix_q_3_q & redist23_vCount_uid242_lz_uid68_block_rsrvd_fix_q_2_q & redist22_vCount_uid248_lz_uid68_block_rsrvd_fix_q_1_q & vCount_uid254_lz_uid68_block_rsrvd_fix_q;

    -- redist20_r_uid255_lz_uid68_block_rsrvd_fix_q_1(DELAY,507)
    redist20_r_uid255_lz_uid68_block_rsrvd_fix_q_1 : dspba_delay
    GENERIC MAP ( width => 7, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => r_uid255_lz_uid68_block_rsrvd_fix_q, xout => redist20_r_uid255_lz_uid68_block_rsrvd_fix_q_1_q, clk => clock, aclr => resetn );

    -- lzu_to15_uid106(BITSELECT,105)@16
    lzu_to15_uid106_in <= STD_LOGIC_VECTOR("00000000" & redist20_r_uid255_lz_uid68_block_rsrvd_fix_q_1_q);
    lzu_to15_uid106_b <= lzu_to15_uid106_in(14 downto 0);

    -- lzGTELepLeftShift_uid105_block_rsrvd_fix(COMPARE,104)@15 + 1
    lzGTELepLeftShift_uid105_block_rsrvd_fix_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000000000" & r_uid255_lz_uid68_block_rsrvd_fix_q));
    lzGTELepLeftShift_uid105_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((15 downto 14 => redist57_expSumMBias_uid61_block_rsrvd_fix_q_4_q(13)) & redist57_expSumMBias_uid61_block_rsrvd_fix_q_4_q));
    lzGTELepLeftShift_uid105_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            lzGTELepLeftShift_uid105_block_rsrvd_fix_o <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            lzGTELepLeftShift_uid105_block_rsrvd_fix_o <= STD_LOGIC_VECTOR(SIGNED(lzGTELepLeftShift_uid105_block_rsrvd_fix_a) - SIGNED(lzGTELepLeftShift_uid105_block_rsrvd_fix_b));
        END IF;
    END PROCESS;
    lzGTELepLeftShift_uid105_block_rsrvd_fix_n(0) <= not (lzGTELepLeftShift_uid105_block_rsrvd_fix_o(15));

    -- leftShiftValueBothCases_uid107_block_rsrvd_fix(MUX,106)@16
    leftShiftValueBothCases_uid107_block_rsrvd_fix_s <= lzGTELepLeftShift_uid105_block_rsrvd_fix_n;
    leftShiftValueBothCases_uid107_block_rsrvd_fix_combproc: PROCESS (leftShiftValueBothCases_uid107_block_rsrvd_fix_s, lzu_to15_uid106_b, subnormLeftShiftValue_uid104_block_rsrvd_fix_q)
    BEGIN
        CASE (leftShiftValueBothCases_uid107_block_rsrvd_fix_s) IS
            WHEN "0" => leftShiftValueBothCases_uid107_block_rsrvd_fix_q <= lzu_to15_uid106_b;
            WHEN "1" => leftShiftValueBothCases_uid107_block_rsrvd_fix_q <= subnormLeftShiftValue_uid104_block_rsrvd_fix_q;
            WHEN OTHERS => leftShiftValueBothCases_uid107_block_rsrvd_fix_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- leftShiftStageSel6Dto5_uid377_postLeftShiftProd_uid108_block_rsrvd_fix_merged_bit_select(BITSELECT,475)@16
    leftShiftStageSel6Dto5_uid377_postLeftShiftProd_uid108_block_rsrvd_fix_merged_bit_select_in <= leftShiftValueBothCases_uid107_block_rsrvd_fix_q(6 downto 0);
    leftShiftStageSel6Dto5_uid377_postLeftShiftProd_uid108_block_rsrvd_fix_merged_bit_select_b <= leftShiftStageSel6Dto5_uid377_postLeftShiftProd_uid108_block_rsrvd_fix_merged_bit_select_in(6 downto 5);
    leftShiftStageSel6Dto5_uid377_postLeftShiftProd_uid108_block_rsrvd_fix_merged_bit_select_c <= leftShiftStageSel6Dto5_uid377_postLeftShiftProd_uid108_block_rsrvd_fix_merged_bit_select_in(4 downto 3);
    leftShiftStageSel6Dto5_uid377_postLeftShiftProd_uid108_block_rsrvd_fix_merged_bit_select_d <= leftShiftStageSel6Dto5_uid377_postLeftShiftProd_uid108_block_rsrvd_fix_merged_bit_select_in(2 downto 1);
    leftShiftStageSel6Dto5_uid377_postLeftShiftProd_uid108_block_rsrvd_fix_merged_bit_select_e <= leftShiftStageSel6Dto5_uid377_postLeftShiftProd_uid108_block_rsrvd_fix_merged_bit_select_in(0 downto 0);

    -- leftShiftStage0_uid378_postLeftShiftProd_uid108_block_rsrvd_fix(MUX,377)@16 + 1
    leftShiftStage0_uid378_postLeftShiftProd_uid108_block_rsrvd_fix_s <= leftShiftStageSel6Dto5_uid377_postLeftShiftProd_uid108_block_rsrvd_fix_merged_bit_select_b;
    leftShiftStage0_uid378_postLeftShiftProd_uid108_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            leftShiftStage0_uid378_postLeftShiftProd_uid108_block_rsrvd_fix_q <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            CASE (leftShiftStage0_uid378_postLeftShiftProd_uid108_block_rsrvd_fix_s) IS
                WHEN "00" => leftShiftStage0_uid378_postLeftShiftProd_uid108_block_rsrvd_fix_q <= redist54_prodTopBitsWithoutMSBForLeftShifter_uid64_block_rsrvd_fix_b_8_outputreg_q;
                WHEN "01" => leftShiftStage0_uid378_postLeftShiftProd_uid108_block_rsrvd_fix_q <= leftShiftStage0Idx1_uid370_postLeftShiftProd_uid108_block_rsrvd_fix_q;
                WHEN "10" => leftShiftStage0_uid378_postLeftShiftProd_uid108_block_rsrvd_fix_q <= leftShiftStage0Idx2_uid373_postLeftShiftProd_uid108_block_rsrvd_fix_q;
                WHEN "11" => leftShiftStage0_uid378_postLeftShiftProd_uid108_block_rsrvd_fix_q <= leftShiftStage0Idx3_uid376_postLeftShiftProd_uid108_block_rsrvd_fix_q;
                WHEN OTHERS => leftShiftStage0_uid378_postLeftShiftProd_uid108_block_rsrvd_fix_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- redist4_leftShiftStageSel6Dto5_uid377_postLeftShiftProd_uid108_block_rsrvd_fix_merged_bit_select_c_1(DELAY,491)
    redist4_leftShiftStageSel6Dto5_uid377_postLeftShiftProd_uid108_block_rsrvd_fix_merged_bit_select_c_1 : dspba_delay
    GENERIC MAP ( width => 2, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => leftShiftStageSel6Dto5_uid377_postLeftShiftProd_uid108_block_rsrvd_fix_merged_bit_select_c, xout => redist4_leftShiftStageSel6Dto5_uid377_postLeftShiftProd_uid108_block_rsrvd_fix_merged_bit_select_c_1_q, clk => clock, aclr => resetn );

    -- leftShiftStage1_uid389_postLeftShiftProd_uid108_block_rsrvd_fix(MUX,388)@17 + 1
    leftShiftStage1_uid389_postLeftShiftProd_uid108_block_rsrvd_fix_s <= redist4_leftShiftStageSel6Dto5_uid377_postLeftShiftProd_uid108_block_rsrvd_fix_merged_bit_select_c_1_q;
    leftShiftStage1_uid389_postLeftShiftProd_uid108_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            leftShiftStage1_uid389_postLeftShiftProd_uid108_block_rsrvd_fix_q <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            CASE (leftShiftStage1_uid389_postLeftShiftProd_uid108_block_rsrvd_fix_s) IS
                WHEN "00" => leftShiftStage1_uid389_postLeftShiftProd_uid108_block_rsrvd_fix_q <= leftShiftStage0_uid378_postLeftShiftProd_uid108_block_rsrvd_fix_q;
                WHEN "01" => leftShiftStage1_uid389_postLeftShiftProd_uid108_block_rsrvd_fix_q <= leftShiftStage1Idx1_uid381_postLeftShiftProd_uid108_block_rsrvd_fix_q;
                WHEN "10" => leftShiftStage1_uid389_postLeftShiftProd_uid108_block_rsrvd_fix_q <= leftShiftStage1Idx2_uid384_postLeftShiftProd_uid108_block_rsrvd_fix_q;
                WHEN "11" => leftShiftStage1_uid389_postLeftShiftProd_uid108_block_rsrvd_fix_q <= leftShiftStage1Idx3_uid387_postLeftShiftProd_uid108_block_rsrvd_fix_q;
                WHEN OTHERS => leftShiftStage1_uid389_postLeftShiftProd_uid108_block_rsrvd_fix_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- redist5_leftShiftStageSel6Dto5_uid377_postLeftShiftProd_uid108_block_rsrvd_fix_merged_bit_select_d_2(DELAY,492)
    redist5_leftShiftStageSel6Dto5_uid377_postLeftShiftProd_uid108_block_rsrvd_fix_merged_bit_select_d_2 : dspba_delay
    GENERIC MAP ( width => 2, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => leftShiftStageSel6Dto5_uid377_postLeftShiftProd_uid108_block_rsrvd_fix_merged_bit_select_d, xout => redist5_leftShiftStageSel6Dto5_uid377_postLeftShiftProd_uid108_block_rsrvd_fix_merged_bit_select_d_2_q, clk => clock, aclr => resetn );

    -- leftShiftStage2_uid400_postLeftShiftProd_uid108_block_rsrvd_fix(MUX,399)@18
    leftShiftStage2_uid400_postLeftShiftProd_uid108_block_rsrvd_fix_s <= redist5_leftShiftStageSel6Dto5_uid377_postLeftShiftProd_uid108_block_rsrvd_fix_merged_bit_select_d_2_q;
    leftShiftStage2_uid400_postLeftShiftProd_uid108_block_rsrvd_fix_combproc: PROCESS (leftShiftStage2_uid400_postLeftShiftProd_uid108_block_rsrvd_fix_s, leftShiftStage1_uid389_postLeftShiftProd_uid108_block_rsrvd_fix_q, leftShiftStage2Idx1_uid392_postLeftShiftProd_uid108_block_rsrvd_fix_q, leftShiftStage2Idx2_uid395_postLeftShiftProd_uid108_block_rsrvd_fix_q, leftShiftStage2Idx3_uid398_postLeftShiftProd_uid108_block_rsrvd_fix_q)
    BEGIN
        CASE (leftShiftStage2_uid400_postLeftShiftProd_uid108_block_rsrvd_fix_s) IS
            WHEN "00" => leftShiftStage2_uid400_postLeftShiftProd_uid108_block_rsrvd_fix_q <= leftShiftStage1_uid389_postLeftShiftProd_uid108_block_rsrvd_fix_q;
            WHEN "01" => leftShiftStage2_uid400_postLeftShiftProd_uid108_block_rsrvd_fix_q <= leftShiftStage2Idx1_uid392_postLeftShiftProd_uid108_block_rsrvd_fix_q;
            WHEN "10" => leftShiftStage2_uid400_postLeftShiftProd_uid108_block_rsrvd_fix_q <= leftShiftStage2Idx2_uid395_postLeftShiftProd_uid108_block_rsrvd_fix_q;
            WHEN "11" => leftShiftStage2_uid400_postLeftShiftProd_uid108_block_rsrvd_fix_q <= leftShiftStage2Idx3_uid398_postLeftShiftProd_uid108_block_rsrvd_fix_q;
            WHEN OTHERS => leftShiftStage2_uid400_postLeftShiftProd_uid108_block_rsrvd_fix_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist6_leftShiftStageSel6Dto5_uid377_postLeftShiftProd_uid108_block_rsrvd_fix_merged_bit_select_e_2(DELAY,493)
    redist6_leftShiftStageSel6Dto5_uid377_postLeftShiftProd_uid108_block_rsrvd_fix_merged_bit_select_e_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => leftShiftStageSel6Dto5_uid377_postLeftShiftProd_uid108_block_rsrvd_fix_merged_bit_select_e, xout => redist6_leftShiftStageSel6Dto5_uid377_postLeftShiftProd_uid108_block_rsrvd_fix_merged_bit_select_e_2_q, clk => clock, aclr => resetn );

    -- leftShiftStage3_uid405_postLeftShiftProd_uid108_block_rsrvd_fix(MUX,404)@18 + 1
    leftShiftStage3_uid405_postLeftShiftProd_uid108_block_rsrvd_fix_s <= redist6_leftShiftStageSel6Dto5_uid377_postLeftShiftProd_uid108_block_rsrvd_fix_merged_bit_select_e_2_q;
    leftShiftStage3_uid405_postLeftShiftProd_uid108_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            leftShiftStage3_uid405_postLeftShiftProd_uid108_block_rsrvd_fix_q <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            CASE (leftShiftStage3_uid405_postLeftShiftProd_uid108_block_rsrvd_fix_s) IS
                WHEN "0" => leftShiftStage3_uid405_postLeftShiftProd_uid108_block_rsrvd_fix_q <= leftShiftStage2_uid400_postLeftShiftProd_uid108_block_rsrvd_fix_q;
                WHEN "1" => leftShiftStage3_uid405_postLeftShiftProd_uid108_block_rsrvd_fix_q <= leftShiftStage3Idx1_uid403_postLeftShiftProd_uid108_block_rsrvd_fix_q;
                WHEN OTHERS => leftShiftStage3_uid405_postLeftShiftProd_uid108_block_rsrvd_fix_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- wOutCst_uid366_postLeftShiftProd_uid108_block_rsrvd_fix(CONSTANT,365)
    wOutCst_uid366_postLeftShiftProd_uid108_block_rsrvd_fix_q <= "1101001";

    -- redist37_leftShiftValueBothCases_uid107_block_rsrvd_fix_q_1(DELAY,524)
    redist37_leftShiftValueBothCases_uid107_block_rsrvd_fix_q_1 : dspba_delay
    GENERIC MAP ( width => 15, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => leftShiftValueBothCases_uid107_block_rsrvd_fix_q, xout => redist37_leftShiftValueBothCases_uid107_block_rsrvd_fix_q_1_q, clk => clock, aclr => resetn );

    -- shiftedOut_uid367_postLeftShiftProd_uid108_block_rsrvd_fix(COMPARE,366)@17 + 1
    shiftedOut_uid367_postLeftShiftProd_uid108_block_rsrvd_fix_a <= STD_LOGIC_VECTOR("00" & redist37_leftShiftValueBothCases_uid107_block_rsrvd_fix_q_1_q);
    shiftedOut_uid367_postLeftShiftProd_uid108_block_rsrvd_fix_b <= STD_LOGIC_VECTOR("0000000000" & wOutCst_uid366_postLeftShiftProd_uid108_block_rsrvd_fix_q);
    shiftedOut_uid367_postLeftShiftProd_uid108_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            shiftedOut_uid367_postLeftShiftProd_uid108_block_rsrvd_fix_o <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            shiftedOut_uid367_postLeftShiftProd_uid108_block_rsrvd_fix_o <= STD_LOGIC_VECTOR(UNSIGNED(shiftedOut_uid367_postLeftShiftProd_uid108_block_rsrvd_fix_a) - UNSIGNED(shiftedOut_uid367_postLeftShiftProd_uid108_block_rsrvd_fix_b));
        END IF;
    END PROCESS;
    shiftedOut_uid367_postLeftShiftProd_uid108_block_rsrvd_fix_n(0) <= not (shiftedOut_uid367_postLeftShiftProd_uid108_block_rsrvd_fix_o(16));

    -- redist18_shiftedOut_uid367_postLeftShiftProd_uid108_block_rsrvd_fix_n_2(DELAY,505)
    redist18_shiftedOut_uid367_postLeftShiftProd_uid108_block_rsrvd_fix_n_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => shiftedOut_uid367_postLeftShiftProd_uid108_block_rsrvd_fix_n, xout => redist18_shiftedOut_uid367_postLeftShiftProd_uid108_block_rsrvd_fix_n_2_q, clk => clock, aclr => resetn );

    -- r_uid407_postLeftShiftProd_uid108_block_rsrvd_fix(MUX,406)@19
    r_uid407_postLeftShiftProd_uid108_block_rsrvd_fix_s <= redist18_shiftedOut_uid367_postLeftShiftProd_uid108_block_rsrvd_fix_n_2_q;
    r_uid407_postLeftShiftProd_uid108_block_rsrvd_fix_combproc: PROCESS (r_uid407_postLeftShiftProd_uid108_block_rsrvd_fix_s, leftShiftStage3_uid405_postLeftShiftProd_uid108_block_rsrvd_fix_q, zeroOutCst_uid406_postLeftShiftProd_uid108_block_rsrvd_fix_q)
    BEGIN
        CASE (r_uid407_postLeftShiftProd_uid108_block_rsrvd_fix_s) IS
            WHEN "0" => r_uid407_postLeftShiftProd_uid108_block_rsrvd_fix_q <= leftShiftStage3_uid405_postLeftShiftProd_uid108_block_rsrvd_fix_q;
            WHEN "1" => r_uid407_postLeftShiftProd_uid108_block_rsrvd_fix_q <= zeroOutCst_uid406_postLeftShiftProd_uid108_block_rsrvd_fix_q;
            WHEN OTHERS => r_uid407_postLeftShiftProd_uid108_block_rsrvd_fix_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- preRndFracLeftShift_uid109_block_rsrvd_fix_merged_bit_select(BITSELECT,484)@19
    preRndFracLeftShift_uid109_block_rsrvd_fix_merged_bit_select_in <= r_uid407_postLeftShiftProd_uid108_block_rsrvd_fix_q(103 downto 0);
    preRndFracLeftShift_uid109_block_rsrvd_fix_merged_bit_select_b <= preRndFracLeftShift_uid109_block_rsrvd_fix_merged_bit_select_in(103 downto 51);
    preRndFracLeftShift_uid109_block_rsrvd_fix_merged_bit_select_c <= preRndFracLeftShift_uid109_block_rsrvd_fix_merged_bit_select_in(50 downto 0);

    -- redist1_preRndFracLeftShift_uid109_block_rsrvd_fix_merged_bit_select_c_1(DELAY,488)
    redist1_preRndFracLeftShift_uid109_block_rsrvd_fix_merged_bit_select_c_1 : dspba_delay
    GENERIC MAP ( width => 51, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => preRndFracLeftShift_uid109_block_rsrvd_fix_merged_bit_select_c, xout => redist1_preRndFracLeftShift_uid109_block_rsrvd_fix_merged_bit_select_c_1_q, clk => clock, aclr => resetn );

    -- stickyLeftShift_uid111_block_rsrvd_fix(LOGICAL,110)@20 + 1
    stickyLeftShift_uid111_block_rsrvd_fix_qi <= "1" WHEN redist1_preRndFracLeftShift_uid109_block_rsrvd_fix_merged_bit_select_c_1_q /= "000000000000000000000000000000000000000000000000000" ELSE "0";
    stickyLeftShift_uid111_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => stickyLeftShift_uid111_block_rsrvd_fix_qi, xout => stickyLeftShift_uid111_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- stickyLeftShift0_uid114_block_rsrvd_fix(LOGICAL,113)@21
    stickyLeftShift0_uid114_block_rsrvd_fix_q <= not (stickyLeftShift_uid111_block_rsrvd_fix_q);

    -- rndBitLeftShift_uid112_block_rsrvd_fix_merged_bit_select(BITSELECT,476)@19
    rndBitLeftShift_uid112_block_rsrvd_fix_merged_bit_select_in <= STD_LOGIC_VECTOR(preRndFracLeftShift_uid109_block_rsrvd_fix_merged_bit_select_b(1 downto 0));
    rndBitLeftShift_uid112_block_rsrvd_fix_merged_bit_select_b <= STD_LOGIC_VECTOR(rndBitLeftShift_uid112_block_rsrvd_fix_merged_bit_select_in(0 downto 0));
    rndBitLeftShift_uid112_block_rsrvd_fix_merged_bit_select_c <= STD_LOGIC_VECTOR(rndBitLeftShift_uid112_block_rsrvd_fix_merged_bit_select_in(1 downto 1));

    -- redist2_rndBitLeftShift_uid112_block_rsrvd_fix_merged_bit_select_b_2(DELAY,489)
    redist2_rndBitLeftShift_uid112_block_rsrvd_fix_merged_bit_select_b_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => rndBitLeftShift_uid112_block_rsrvd_fix_merged_bit_select_b, xout => redist2_rndBitLeftShift_uid112_block_rsrvd_fix_merged_bit_select_b_2_q, clk => clock, aclr => resetn );

    -- redist3_rndBitLeftShift_uid112_block_rsrvd_fix_merged_bit_select_c_2(DELAY,490)
    redist3_rndBitLeftShift_uid112_block_rsrvd_fix_merged_bit_select_c_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => rndBitLeftShift_uid112_block_rsrvd_fix_merged_bit_select_c, xout => redist3_rndBitLeftShift_uid112_block_rsrvd_fix_merged_bit_select_c_2_q, clk => clock, aclr => resetn );

    -- lBitLeftShift0_uid115_block_rsrvd_fix(LOGICAL,114)@21
    lBitLeftShift0_uid115_block_rsrvd_fix_q <= not (redist3_rndBitLeftShift_uid112_block_rsrvd_fix_merged_bit_select_c_2_q);

    -- rndValueSLeftInv_uid116_block_rsrvd_fix(LOGICAL,115)@21
    rndValueSLeftInv_uid116_block_rsrvd_fix_q <= lBitLeftShift0_uid115_block_rsrvd_fix_q and redist2_rndBitLeftShift_uid112_block_rsrvd_fix_merged_bit_select_b_2_q and stickyLeftShift0_uid114_block_rsrvd_fix_q;

    -- rndValueSLeft_uid117_block_rsrvd_fix(LOGICAL,116)@21
    rndValueSLeft_uid117_block_rsrvd_fix_q <= not (rndValueSLeftInv_uid116_block_rsrvd_fix_q);

    -- prodStickyRange_uid66_block_rsrvd_fix(BITSELECT,65)@8
    prodStickyRange_uid66_block_rsrvd_fix_in <= osig_uid212_prod_uid62_block_rsrvd_fix_b(50 downto 0);
    prodStickyRange_uid66_block_rsrvd_fix_b <= prodStickyRange_uid66_block_rsrvd_fix_in(50 downto 0);

    -- prodSticky_uid67_block_rsrvd_fix(LOGICAL,66)@8 + 1
    prodSticky_uid67_block_rsrvd_fix_qi <= "1" WHEN prodStickyRange_uid66_block_rsrvd_fix_b /= "000000000000000000000000000000000000000000000000000" ELSE "0";
    prodSticky_uid67_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => prodSticky_uid67_block_rsrvd_fix_qi, xout => prodSticky_uid67_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- redist51_prodSticky_uid67_block_rsrvd_fix_q_12(DELAY,538)
    redist51_prodSticky_uid67_block_rsrvd_fix_q_12 : dspba_delay
    GENERIC MAP ( width => 1, depth => 11, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => prodSticky_uid67_block_rsrvd_fix_q, xout => redist51_prodSticky_uid67_block_rsrvd_fix_q_12_q, clk => clock, aclr => resetn );

    -- zeroOutCst_uid361_postRightShiftProd_uid90_block_rsrvd_fix(CONSTANT,360)
    zeroOutCst_uid361_postRightShiftProd_uid90_block_rsrvd_fix_q <= "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";

    -- rightShiftStage3Idx1Rng1_uid356_postRightShiftProd_uid90_block_rsrvd_fix(BITSELECT,355)@18
    rightShiftStage3Idx1Rng1_uid356_postRightShiftProd_uid90_block_rsrvd_fix_b <= rightShiftStage2_uid355_postRightShiftProd_uid90_block_rsrvd_fix_q(109 downto 1);

    -- rightShiftStage3Idx1_uid358_postRightShiftProd_uid90_block_rsrvd_fix(BITJOIN,357)@18
    rightShiftStage3Idx1_uid358_postRightShiftProd_uid90_block_rsrvd_fix_q <= GND_q & rightShiftStage3Idx1Rng1_uid356_postRightShiftProd_uid90_block_rsrvd_fix_b;

    -- rightShiftStage2Idx3Rng6_uid351_postRightShiftProd_uid90_block_rsrvd_fix(BITSELECT,350)@17
    rightShiftStage2Idx3Rng6_uid351_postRightShiftProd_uid90_block_rsrvd_fix_b <= rightShiftStage1_uid344_postRightShiftProd_uid90_block_rsrvd_fix_q(109 downto 6);

    -- rightShiftStage2Idx3_uid353_postRightShiftProd_uid90_block_rsrvd_fix(BITJOIN,352)@17
    rightShiftStage2Idx3_uid353_postRightShiftProd_uid90_block_rsrvd_fix_q <= rightShiftStage2Idx3Pad6_uid352_postRightShiftProd_uid90_block_rsrvd_fix_q & rightShiftStage2Idx3Rng6_uid351_postRightShiftProd_uid90_block_rsrvd_fix_b;

    -- rightShiftStage2Idx2Rng4_uid348_postRightShiftProd_uid90_block_rsrvd_fix(BITSELECT,347)@17
    rightShiftStage2Idx2Rng4_uid348_postRightShiftProd_uid90_block_rsrvd_fix_b <= rightShiftStage1_uid344_postRightShiftProd_uid90_block_rsrvd_fix_q(109 downto 4);

    -- rightShiftStage2Idx2_uid350_postRightShiftProd_uid90_block_rsrvd_fix(BITJOIN,349)@17
    rightShiftStage2Idx2_uid350_postRightShiftProd_uid90_block_rsrvd_fix_q <= zs_uid240_lz_uid68_block_rsrvd_fix_q & rightShiftStage2Idx2Rng4_uid348_postRightShiftProd_uid90_block_rsrvd_fix_b;

    -- rightShiftStage2Idx1Rng2_uid345_postRightShiftProd_uid90_block_rsrvd_fix(BITSELECT,344)@17
    rightShiftStage2Idx1Rng2_uid345_postRightShiftProd_uid90_block_rsrvd_fix_b <= rightShiftStage1_uid344_postRightShiftProd_uid90_block_rsrvd_fix_q(109 downto 2);

    -- rightShiftStage2Idx1_uid347_postRightShiftProd_uid90_block_rsrvd_fix(BITJOIN,346)@17
    rightShiftStage2Idx1_uid347_postRightShiftProd_uid90_block_rsrvd_fix_q <= cst02bit_uid127_block_rsrvd_fix_q & rightShiftStage2Idx1Rng2_uid345_postRightShiftProd_uid90_block_rsrvd_fix_b;

    -- rightShiftStage1Idx3Rng24_uid340_postRightShiftProd_uid90_block_rsrvd_fix(BITSELECT,339)@16
    rightShiftStage1Idx3Rng24_uid340_postRightShiftProd_uid90_block_rsrvd_fix_b <= rightShiftStage0_uid333_postRightShiftProd_uid90_block_rsrvd_fix_q(109 downto 24);

    -- rightShiftStage1Idx3_uid342_postRightShiftProd_uid90_block_rsrvd_fix(BITJOIN,341)@16
    rightShiftStage1Idx3_uid342_postRightShiftProd_uid90_block_rsrvd_fix_q <= rightShiftStage1Idx3Pad24_uid341_postRightShiftProd_uid90_block_rsrvd_fix_q & rightShiftStage1Idx3Rng24_uid340_postRightShiftProd_uid90_block_rsrvd_fix_b;

    -- rightShiftStage1Idx2Rng16_uid337_postRightShiftProd_uid90_block_rsrvd_fix(BITSELECT,336)@16
    rightShiftStage1Idx2Rng16_uid337_postRightShiftProd_uid90_block_rsrvd_fix_b <= rightShiftStage0_uid333_postRightShiftProd_uid90_block_rsrvd_fix_q(109 downto 16);

    -- rightShiftStage1Idx2_uid339_postRightShiftProd_uid90_block_rsrvd_fix(BITJOIN,338)@16
    rightShiftStage1Idx2_uid339_postRightShiftProd_uid90_block_rsrvd_fix_q <= zs_uid228_lz_uid68_block_rsrvd_fix_q & rightShiftStage1Idx2Rng16_uid337_postRightShiftProd_uid90_block_rsrvd_fix_b;

    -- rightShiftStage1Idx1Rng8_uid334_postRightShiftProd_uid90_block_rsrvd_fix(BITSELECT,333)@16
    rightShiftStage1Idx1Rng8_uid334_postRightShiftProd_uid90_block_rsrvd_fix_b <= rightShiftStage0_uid333_postRightShiftProd_uid90_block_rsrvd_fix_q(109 downto 8);

    -- rightShiftStage1Idx1_uid336_postRightShiftProd_uid90_block_rsrvd_fix(BITJOIN,335)@16
    rightShiftStage1Idx1_uid336_postRightShiftProd_uid90_block_rsrvd_fix_q <= zs_uid234_lz_uid68_block_rsrvd_fix_q & rightShiftStage1Idx1Rng8_uid334_postRightShiftProd_uid90_block_rsrvd_fix_b;

    -- rightShiftStage0Idx3Rng96_uid329_postRightShiftProd_uid90_block_rsrvd_fix(BITSELECT,328)@15
    rightShiftStage0Idx3Rng96_uid329_postRightShiftProd_uid90_block_rsrvd_fix_b <= rightPaddedIn_uid91_block_rsrvd_fix_q(109 downto 96);

    -- rightShiftStage0Idx3_uid331_postRightShiftProd_uid90_block_rsrvd_fix(BITJOIN,330)@15
    rightShiftStage0Idx3_uid331_postRightShiftProd_uid90_block_rsrvd_fix_q <= rightShiftStage0Idx3Pad96_uid330_postRightShiftProd_uid90_block_rsrvd_fix_q & rightShiftStage0Idx3Rng96_uid329_postRightShiftProd_uid90_block_rsrvd_fix_b;

    -- rightShiftStage0Idx2Rng64_uid326_postRightShiftProd_uid90_block_rsrvd_fix(BITSELECT,325)@15
    rightShiftStage0Idx2Rng64_uid326_postRightShiftProd_uid90_block_rsrvd_fix_b <= rightPaddedIn_uid91_block_rsrvd_fix_q(109 downto 64);

    -- rightShiftStage0Idx2_uid328_postRightShiftProd_uid90_block_rsrvd_fix(BITJOIN,327)@15
    rightShiftStage0Idx2_uid328_postRightShiftProd_uid90_block_rsrvd_fix_q <= zs_uid214_lz_uid68_block_rsrvd_fix_q & rightShiftStage0Idx2Rng64_uid326_postRightShiftProd_uid90_block_rsrvd_fix_b;

    -- rightShiftStage0Idx1Rng32_uid323_postRightShiftProd_uid90_block_rsrvd_fix(BITSELECT,322)@15
    rightShiftStage0Idx1Rng32_uid323_postRightShiftProd_uid90_block_rsrvd_fix_b <= rightPaddedIn_uid91_block_rsrvd_fix_q(109 downto 32);

    -- rightShiftStage0Idx1_uid325_postRightShiftProd_uid90_block_rsrvd_fix(BITJOIN,324)@15
    rightShiftStage0Idx1_uid325_postRightShiftProd_uid90_block_rsrvd_fix_q <= zs_uid222_lz_uid68_block_rsrvd_fix_q & rightShiftStage0Idx1Rng32_uid323_postRightShiftProd_uid90_block_rsrvd_fix_b;

    -- redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_notEnable(LOGICAL,596)
    redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_nor(LOGICAL,597)
    redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_nor_q <= not (redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_notEnable_q or redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_sticky_ena_q);

    -- redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_mem_last(CONSTANT,593)
    redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_mem_last_q <= "010";

    -- redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_cmp(LOGICAL,594)
    redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_cmp_b <= STD_LOGIC_VECTOR("0" & redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_rdcnt_q);
    redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_cmp_q <= "1" WHEN redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_mem_last_q = redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_cmp_b ELSE "0";

    -- redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_cmpReg(REG,595)
    redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_cmpReg_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_cmpReg_q <= "0";
        ELSIF (clock'EVENT AND clock = '1') THEN
            redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_cmpReg_q <= STD_LOGIC_VECTOR(redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_cmp_q);
        END IF;
    END PROCESS;

    -- redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_sticky_ena(REG,598)
    redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_sticky_ena_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_sticky_ena_q <= "0";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_nor_q = "1") THEN
                redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_sticky_ena_q <= STD_LOGIC_VECTOR(redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_enaAnd(LOGICAL,599)
    redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_enaAnd_q <= redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_sticky_ena_q and VCC_q;

    -- redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_rdcnt(COUNTER,591)
    -- low=0, high=3, step=1, init=0
    redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_rdcnt_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_rdcnt_i <= TO_UNSIGNED(0, 2);
        ELSIF (clock'EVENT AND clock = '1') THEN
            redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_rdcnt_i <= redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_rdcnt_i + 1;
        END IF;
    END PROCESS;
    redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_rdcnt_i, 2)));

    -- prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix(BITSELECT,64)@8
    prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b <= osig_uid212_prod_uid62_block_rsrvd_fix_b(105 downto 51);

    -- redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_inputreg(DELAY,588)
    redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_inputreg : dspba_delay
    GENERIC MAP ( width => 55, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b, xout => redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_inputreg_q, clk => clock, aclr => resetn );

    -- redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_wraddr(REG,592)
    redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_wraddr_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_wraddr_q <= "11";
        ELSIF (clock'EVENT AND clock = '1') THEN
            redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_wraddr_q <= STD_LOGIC_VECTOR(redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_rdcnt_q);
        END IF;
    END PROCESS;

    -- redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_mem(DUALMEM,590)
    redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_mem_ia <= STD_LOGIC_VECTOR(redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_inputreg_q);
    redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_mem_aa <= redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_wraddr_q;
    redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_mem_ab <= redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_rdcnt_q;
    redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_mem_reset0 <= not (resetn);
    redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 55,
        widthad_a => 2,
        numwords_a => 4,
        width_b => 55,
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
        clocken1 => redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_enaAnd_q(0),
        clocken0 => VCC_q(0),
        clock0 => clock,
        aclr1 => redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_mem_reset0,
        clock1 => clock,
        address_a => redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_mem_aa,
        data_a => redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_mem_ab,
        q_b => redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_mem_iq
    );
    redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_mem_q <= redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_mem_iq(54 downto 0);

    -- redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_outputreg(DELAY,589)
    redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_outputreg : dspba_delay
    GENERIC MAP ( width => 55, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_mem_q, xout => redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_outputreg_q, clk => clock, aclr => resetn );

    -- padConst_uid90_block_rsrvd_fix(CONSTANT,89)
    padConst_uid90_block_rsrvd_fix_q <= "0000000000000000000000000000000000000000000000000000000";

    -- rightPaddedIn_uid91_block_rsrvd_fix(BITJOIN,90)@15
    rightPaddedIn_uid91_block_rsrvd_fix_q <= redist52_prodTopBitsNoStickyRangeForRightShifter_uid65_block_rsrvd_fix_b_7_outputreg_q & padConst_uid90_block_rsrvd_fix_q;

    -- expSumMBiasGTZero_uid76_block_rsrvd_fix(COMPARE,75)@12 + 1
    expSumMBiasGTZero_uid76_block_rsrvd_fix_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((15 downto 1 => GND_q(0)) & GND_q));
    expSumMBiasGTZero_uid76_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((15 downto 14 => expSumMBias_uid61_block_rsrvd_fix_q(13)) & expSumMBias_uid61_block_rsrvd_fix_q));
    expSumMBiasGTZero_uid76_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            expSumMBiasGTZero_uid76_block_rsrvd_fix_o <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            expSumMBiasGTZero_uid76_block_rsrvd_fix_o <= STD_LOGIC_VECTOR(SIGNED(expSumMBiasGTZero_uid76_block_rsrvd_fix_a) - SIGNED(expSumMBiasGTZero_uid76_block_rsrvd_fix_b));
        END IF;
    END PROCESS;
    expSumMBiasGTZero_uid76_block_rsrvd_fix_c(0) <= expSumMBiasGTZero_uid76_block_rsrvd_fix_o(15);
    expSumMBiasGTZero_uid76_block_rsrvd_fix_n(0) <= not (expSumMBiasGTZero_uid76_block_rsrvd_fix_o(15));

    -- subnormRightShiftValueTerm2_uid86_block_rsrvd_fix(LOGICAL,85)@13 + 1
    subnormRightShiftValueTerm2_uid86_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((13 downto 1 => expSumMBiasGTZero_uid76_block_rsrvd_fix_n(0)) & expSumMBiasGTZero_uid76_block_rsrvd_fix_n));
    subnormRightShiftValueTerm2_uid86_block_rsrvd_fix_qi <= redist56_expSumMBias_uid61_block_rsrvd_fix_q_2_q and subnormRightShiftValueTerm2_uid86_block_rsrvd_fix_b;
    subnormRightShiftValueTerm2_uid86_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 14, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => subnormRightShiftValueTerm2_uid86_block_rsrvd_fix_qi, xout => subnormRightShiftValueTerm2_uid86_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- xMSB_uid70_block_rsrvd_fix(BITSELECT,69)@8
    xMSB_uid70_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(osig_uid212_prod_uid62_block_rsrvd_fix_b(105 downto 105));

    -- redist48_xMSB_uid70_block_rsrvd_fix_b_5(DELAY,535)
    redist48_xMSB_uid70_block_rsrvd_fix_b_5 : dspba_delay
    GENERIC MAP ( width => 1, depth => 5, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => xMSB_uid70_block_rsrvd_fix_b, xout => redist48_xMSB_uid70_block_rsrvd_fix_b_5_q, clk => clock, aclr => resetn );

    -- secondCond_uid87_block_rsrvd_fix(LOGICAL,86)@13
    secondCond_uid87_block_rsrvd_fix_q <= expSumMBiasGTZero_uid76_block_rsrvd_fix_c and redist48_xMSB_uid70_block_rsrvd_fix_b_5_q;

    -- secondCond2_uid88_block_rsrvd_fix(LOGICAL,87)@13 + 1
    secondCond2_uid88_block_rsrvd_fix_qi <= expSumMBiasGTZero_uid76_block_rsrvd_fix_n or secondCond_uid87_block_rsrvd_fix_q;
    secondCond2_uid88_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => secondCond2_uid88_block_rsrvd_fix_qi, xout => secondCond2_uid88_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- subnormRightShiftValue_uid89_block_rsrvd_fix(SUB,88)@14 + 1
    subnormRightShiftValue_uid89_block_rsrvd_fix_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000000000000000" & secondCond2_uid88_block_rsrvd_fix_q));
    subnormRightShiftValue_uid89_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((15 downto 14 => subnormRightShiftValueTerm2_uid86_block_rsrvd_fix_q(13)) & subnormRightShiftValueTerm2_uid86_block_rsrvd_fix_q));
    subnormRightShiftValue_uid89_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            subnormRightShiftValue_uid89_block_rsrvd_fix_o <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            subnormRightShiftValue_uid89_block_rsrvd_fix_o <= STD_LOGIC_VECTOR(SIGNED(subnormRightShiftValue_uid89_block_rsrvd_fix_a) - SIGNED(subnormRightShiftValue_uid89_block_rsrvd_fix_b));
        END IF;
    END PROCESS;
    subnormRightShiftValue_uid89_block_rsrvd_fix_q <= subnormRightShiftValue_uid89_block_rsrvd_fix_o(14 downto 0);

    -- rightShiftStageSel6Dto5_uid332_postRightShiftProd_uid90_block_rsrvd_fix_merged_bit_select(BITSELECT,474)@15
    rightShiftStageSel6Dto5_uid332_postRightShiftProd_uid90_block_rsrvd_fix_merged_bit_select_in <= subnormRightShiftValue_uid89_block_rsrvd_fix_q(6 downto 0);
    rightShiftStageSel6Dto5_uid332_postRightShiftProd_uid90_block_rsrvd_fix_merged_bit_select_b <= rightShiftStageSel6Dto5_uid332_postRightShiftProd_uid90_block_rsrvd_fix_merged_bit_select_in(6 downto 5);
    rightShiftStageSel6Dto5_uid332_postRightShiftProd_uid90_block_rsrvd_fix_merged_bit_select_c <= rightShiftStageSel6Dto5_uid332_postRightShiftProd_uid90_block_rsrvd_fix_merged_bit_select_in(4 downto 3);
    rightShiftStageSel6Dto5_uid332_postRightShiftProd_uid90_block_rsrvd_fix_merged_bit_select_d <= rightShiftStageSel6Dto5_uid332_postRightShiftProd_uid90_block_rsrvd_fix_merged_bit_select_in(2 downto 1);
    rightShiftStageSel6Dto5_uid332_postRightShiftProd_uid90_block_rsrvd_fix_merged_bit_select_e <= rightShiftStageSel6Dto5_uid332_postRightShiftProd_uid90_block_rsrvd_fix_merged_bit_select_in(0 downto 0);

    -- rightShiftStage0_uid333_postRightShiftProd_uid90_block_rsrvd_fix(MUX,332)@15 + 1
    rightShiftStage0_uid333_postRightShiftProd_uid90_block_rsrvd_fix_s <= rightShiftStageSel6Dto5_uid332_postRightShiftProd_uid90_block_rsrvd_fix_merged_bit_select_b;
    rightShiftStage0_uid333_postRightShiftProd_uid90_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            rightShiftStage0_uid333_postRightShiftProd_uid90_block_rsrvd_fix_q <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            CASE (rightShiftStage0_uid333_postRightShiftProd_uid90_block_rsrvd_fix_s) IS
                WHEN "00" => rightShiftStage0_uid333_postRightShiftProd_uid90_block_rsrvd_fix_q <= rightPaddedIn_uid91_block_rsrvd_fix_q;
                WHEN "01" => rightShiftStage0_uid333_postRightShiftProd_uid90_block_rsrvd_fix_q <= rightShiftStage0Idx1_uid325_postRightShiftProd_uid90_block_rsrvd_fix_q;
                WHEN "10" => rightShiftStage0_uid333_postRightShiftProd_uid90_block_rsrvd_fix_q <= rightShiftStage0Idx2_uid328_postRightShiftProd_uid90_block_rsrvd_fix_q;
                WHEN "11" => rightShiftStage0_uid333_postRightShiftProd_uid90_block_rsrvd_fix_q <= rightShiftStage0Idx3_uid331_postRightShiftProd_uid90_block_rsrvd_fix_q;
                WHEN OTHERS => rightShiftStage0_uid333_postRightShiftProd_uid90_block_rsrvd_fix_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- redist7_rightShiftStageSel6Dto5_uid332_postRightShiftProd_uid90_block_rsrvd_fix_merged_bit_select_c_1(DELAY,494)
    redist7_rightShiftStageSel6Dto5_uid332_postRightShiftProd_uid90_block_rsrvd_fix_merged_bit_select_c_1 : dspba_delay
    GENERIC MAP ( width => 2, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => rightShiftStageSel6Dto5_uid332_postRightShiftProd_uid90_block_rsrvd_fix_merged_bit_select_c, xout => redist7_rightShiftStageSel6Dto5_uid332_postRightShiftProd_uid90_block_rsrvd_fix_merged_bit_select_c_1_q, clk => clock, aclr => resetn );

    -- rightShiftStage1_uid344_postRightShiftProd_uid90_block_rsrvd_fix(MUX,343)@16 + 1
    rightShiftStage1_uid344_postRightShiftProd_uid90_block_rsrvd_fix_s <= redist7_rightShiftStageSel6Dto5_uid332_postRightShiftProd_uid90_block_rsrvd_fix_merged_bit_select_c_1_q;
    rightShiftStage1_uid344_postRightShiftProd_uid90_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            rightShiftStage1_uid344_postRightShiftProd_uid90_block_rsrvd_fix_q <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            CASE (rightShiftStage1_uid344_postRightShiftProd_uid90_block_rsrvd_fix_s) IS
                WHEN "00" => rightShiftStage1_uid344_postRightShiftProd_uid90_block_rsrvd_fix_q <= rightShiftStage0_uid333_postRightShiftProd_uid90_block_rsrvd_fix_q;
                WHEN "01" => rightShiftStage1_uid344_postRightShiftProd_uid90_block_rsrvd_fix_q <= rightShiftStage1Idx1_uid336_postRightShiftProd_uid90_block_rsrvd_fix_q;
                WHEN "10" => rightShiftStage1_uid344_postRightShiftProd_uid90_block_rsrvd_fix_q <= rightShiftStage1Idx2_uid339_postRightShiftProd_uid90_block_rsrvd_fix_q;
                WHEN "11" => rightShiftStage1_uid344_postRightShiftProd_uid90_block_rsrvd_fix_q <= rightShiftStage1Idx3_uid342_postRightShiftProd_uid90_block_rsrvd_fix_q;
                WHEN OTHERS => rightShiftStage1_uid344_postRightShiftProd_uid90_block_rsrvd_fix_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- redist8_rightShiftStageSel6Dto5_uid332_postRightShiftProd_uid90_block_rsrvd_fix_merged_bit_select_d_2(DELAY,495)
    redist8_rightShiftStageSel6Dto5_uid332_postRightShiftProd_uid90_block_rsrvd_fix_merged_bit_select_d_2 : dspba_delay
    GENERIC MAP ( width => 2, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => rightShiftStageSel6Dto5_uid332_postRightShiftProd_uid90_block_rsrvd_fix_merged_bit_select_d, xout => redist8_rightShiftStageSel6Dto5_uid332_postRightShiftProd_uid90_block_rsrvd_fix_merged_bit_select_d_2_q, clk => clock, aclr => resetn );

    -- rightShiftStage2_uid355_postRightShiftProd_uid90_block_rsrvd_fix(MUX,354)@17 + 1
    rightShiftStage2_uid355_postRightShiftProd_uid90_block_rsrvd_fix_s <= redist8_rightShiftStageSel6Dto5_uid332_postRightShiftProd_uid90_block_rsrvd_fix_merged_bit_select_d_2_q;
    rightShiftStage2_uid355_postRightShiftProd_uid90_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            rightShiftStage2_uid355_postRightShiftProd_uid90_block_rsrvd_fix_q <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            CASE (rightShiftStage2_uid355_postRightShiftProd_uid90_block_rsrvd_fix_s) IS
                WHEN "00" => rightShiftStage2_uid355_postRightShiftProd_uid90_block_rsrvd_fix_q <= rightShiftStage1_uid344_postRightShiftProd_uid90_block_rsrvd_fix_q;
                WHEN "01" => rightShiftStage2_uid355_postRightShiftProd_uid90_block_rsrvd_fix_q <= rightShiftStage2Idx1_uid347_postRightShiftProd_uid90_block_rsrvd_fix_q;
                WHEN "10" => rightShiftStage2_uid355_postRightShiftProd_uid90_block_rsrvd_fix_q <= rightShiftStage2Idx2_uid350_postRightShiftProd_uid90_block_rsrvd_fix_q;
                WHEN "11" => rightShiftStage2_uid355_postRightShiftProd_uid90_block_rsrvd_fix_q <= rightShiftStage2Idx3_uid353_postRightShiftProd_uid90_block_rsrvd_fix_q;
                WHEN OTHERS => rightShiftStage2_uid355_postRightShiftProd_uid90_block_rsrvd_fix_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- redist9_rightShiftStageSel6Dto5_uid332_postRightShiftProd_uid90_block_rsrvd_fix_merged_bit_select_e_3(DELAY,496)
    redist9_rightShiftStageSel6Dto5_uid332_postRightShiftProd_uid90_block_rsrvd_fix_merged_bit_select_e_3 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => rightShiftStageSel6Dto5_uid332_postRightShiftProd_uid90_block_rsrvd_fix_merged_bit_select_e, xout => redist9_rightShiftStageSel6Dto5_uid332_postRightShiftProd_uid90_block_rsrvd_fix_merged_bit_select_e_3_q, clk => clock, aclr => resetn );

    -- rightShiftStage3_uid360_postRightShiftProd_uid90_block_rsrvd_fix(MUX,359)@18
    rightShiftStage3_uid360_postRightShiftProd_uid90_block_rsrvd_fix_s <= redist9_rightShiftStageSel6Dto5_uid332_postRightShiftProd_uid90_block_rsrvd_fix_merged_bit_select_e_3_q;
    rightShiftStage3_uid360_postRightShiftProd_uid90_block_rsrvd_fix_combproc: PROCESS (rightShiftStage3_uid360_postRightShiftProd_uid90_block_rsrvd_fix_s, rightShiftStage2_uid355_postRightShiftProd_uid90_block_rsrvd_fix_q, rightShiftStage3Idx1_uid358_postRightShiftProd_uid90_block_rsrvd_fix_q)
    BEGIN
        CASE (rightShiftStage3_uid360_postRightShiftProd_uid90_block_rsrvd_fix_s) IS
            WHEN "0" => rightShiftStage3_uid360_postRightShiftProd_uid90_block_rsrvd_fix_q <= rightShiftStage2_uid355_postRightShiftProd_uid90_block_rsrvd_fix_q;
            WHEN "1" => rightShiftStage3_uid360_postRightShiftProd_uid90_block_rsrvd_fix_q <= rightShiftStage3Idx1_uid358_postRightShiftProd_uid90_block_rsrvd_fix_q;
            WHEN OTHERS => rightShiftStage3_uid360_postRightShiftProd_uid90_block_rsrvd_fix_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- wIntCst_uid321_postRightShiftProd_uid90_block_rsrvd_fix(CONSTANT,320)
    wIntCst_uid321_postRightShiftProd_uid90_block_rsrvd_fix_q <= "1101110";

    -- shiftedOut_uid322_postRightShiftProd_uid90_block_rsrvd_fix(COMPARE,321)@15 + 1
    shiftedOut_uid322_postRightShiftProd_uid90_block_rsrvd_fix_a <= STD_LOGIC_VECTOR("00" & subnormRightShiftValue_uid89_block_rsrvd_fix_q);
    shiftedOut_uid322_postRightShiftProd_uid90_block_rsrvd_fix_b <= STD_LOGIC_VECTOR("0000000000" & wIntCst_uid321_postRightShiftProd_uid90_block_rsrvd_fix_q);
    shiftedOut_uid322_postRightShiftProd_uid90_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            shiftedOut_uid322_postRightShiftProd_uid90_block_rsrvd_fix_o <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            shiftedOut_uid322_postRightShiftProd_uid90_block_rsrvd_fix_o <= STD_LOGIC_VECTOR(UNSIGNED(shiftedOut_uid322_postRightShiftProd_uid90_block_rsrvd_fix_a) - UNSIGNED(shiftedOut_uid322_postRightShiftProd_uid90_block_rsrvd_fix_b));
        END IF;
    END PROCESS;
    shiftedOut_uid322_postRightShiftProd_uid90_block_rsrvd_fix_n(0) <= not (shiftedOut_uid322_postRightShiftProd_uid90_block_rsrvd_fix_o(16));

    -- redist19_shiftedOut_uid322_postRightShiftProd_uid90_block_rsrvd_fix_n_3(DELAY,506)
    redist19_shiftedOut_uid322_postRightShiftProd_uid90_block_rsrvd_fix_n_3 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => shiftedOut_uid322_postRightShiftProd_uid90_block_rsrvd_fix_n, xout => redist19_shiftedOut_uid322_postRightShiftProd_uid90_block_rsrvd_fix_n_3_q, clk => clock, aclr => resetn );

    -- r_uid362_postRightShiftProd_uid90_block_rsrvd_fix(MUX,361)@18
    r_uid362_postRightShiftProd_uid90_block_rsrvd_fix_s <= redist19_shiftedOut_uid322_postRightShiftProd_uid90_block_rsrvd_fix_n_3_q;
    r_uid362_postRightShiftProd_uid90_block_rsrvd_fix_combproc: PROCESS (r_uid362_postRightShiftProd_uid90_block_rsrvd_fix_s, rightShiftStage3_uid360_postRightShiftProd_uid90_block_rsrvd_fix_q, zeroOutCst_uid361_postRightShiftProd_uid90_block_rsrvd_fix_q)
    BEGIN
        CASE (r_uid362_postRightShiftProd_uid90_block_rsrvd_fix_s) IS
            WHEN "0" => r_uid362_postRightShiftProd_uid90_block_rsrvd_fix_q <= rightShiftStage3_uid360_postRightShiftProd_uid90_block_rsrvd_fix_q;
            WHEN "1" => r_uid362_postRightShiftProd_uid90_block_rsrvd_fix_q <= zeroOutCst_uid361_postRightShiftProd_uid90_block_rsrvd_fix_q;
            WHEN OTHERS => r_uid362_postRightShiftProd_uid90_block_rsrvd_fix_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- stickySubnormalRange_uid93_block_rsrvd_fix(BITSELECT,92)@18
    stickySubnormalRange_uid93_block_rsrvd_fix_in <= r_uid362_postRightShiftProd_uid90_block_rsrvd_fix_q(54 downto 0);
    stickySubnormalRange_uid93_block_rsrvd_fix_b <= stickySubnormalRange_uid93_block_rsrvd_fix_in(54 downto 0);

    -- redist41_stickySubnormalRange_uid93_block_rsrvd_fix_b_1(DELAY,528)
    redist41_stickySubnormalRange_uid93_block_rsrvd_fix_b_1 : dspba_delay
    GENERIC MAP ( width => 55, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => stickySubnormalRange_uid93_block_rsrvd_fix_b, xout => redist41_stickySubnormalRange_uid93_block_rsrvd_fix_b_1_q, clk => clock, aclr => resetn );

    -- stickySubnormal_uid94_block_rsrvd_fix(LOGICAL,93)@19 + 1
    stickySubnormal_uid94_block_rsrvd_fix_qi <= "1" WHEN redist41_stickySubnormalRange_uid93_block_rsrvd_fix_b_1_q /= "0000000000000000000000000000000000000000000000000000000" ELSE "0";
    stickySubnormal_uid94_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => stickySubnormal_uid94_block_rsrvd_fix_qi, xout => stickySubnormal_uid94_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- stickySubnormalRnd_uid95_block_rsrvd_fix(LOGICAL,94)@20
    stickySubnormalRnd_uid95_block_rsrvd_fix_q <= stickySubnormal_uid94_block_rsrvd_fix_q or redist51_prodSticky_uid67_block_rsrvd_fix_q_12_q;

    -- stickySubnormalRnd0_uid99_block_rsrvd_fix(LOGICAL,98)@20
    stickySubnormalRnd0_uid99_block_rsrvd_fix_q <= not (stickySubnormalRnd_uid95_block_rsrvd_fix_q);

    -- rS_uid97_block_rsrvd_fix(BITSELECT,96)@18
    rS_uid97_block_rsrvd_fix_in <= STD_LOGIC_VECTOR(r_uid362_postRightShiftProd_uid90_block_rsrvd_fix_q(55 downto 0));
    rS_uid97_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(rS_uid97_block_rsrvd_fix_in(55 downto 55));

    -- redist39_rS_uid97_block_rsrvd_fix_b_2(DELAY,526)
    redist39_rS_uid97_block_rsrvd_fix_b_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => rS_uid97_block_rsrvd_fix_b, xout => redist39_rS_uid97_block_rsrvd_fix_b_2_q, clk => clock, aclr => resetn );

    -- lS_uid96_block_rsrvd_fix(BITSELECT,95)@18
    lS_uid96_block_rsrvd_fix_in <= STD_LOGIC_VECTOR(r_uid362_postRightShiftProd_uid90_block_rsrvd_fix_q(56 downto 0));
    lS_uid96_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(lS_uid96_block_rsrvd_fix_in(56 downto 56));

    -- redist40_lS_uid96_block_rsrvd_fix_b_2(DELAY,527)
    redist40_lS_uid96_block_rsrvd_fix_b_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => lS_uid96_block_rsrvd_fix_b, xout => redist40_lS_uid96_block_rsrvd_fix_b_2_q, clk => clock, aclr => resetn );

    -- lS0_uid100_block_rsrvd_fix(LOGICAL,99)@20
    lS0_uid100_block_rsrvd_fix_q <= not (redist40_lS_uid96_block_rsrvd_fix_b_2_q);

    -- rndValueSInv_uid101_block_rsrvd_fix(LOGICAL,100)@20 + 1
    rndValueSInv_uid101_block_rsrvd_fix_qi <= lS0_uid100_block_rsrvd_fix_q and redist39_rS_uid97_block_rsrvd_fix_b_2_q and stickySubnormalRnd0_uid99_block_rsrvd_fix_q;
    rndValueSInv_uid101_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => rndValueSInv_uid101_block_rsrvd_fix_qi, xout => rndValueSInv_uid101_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- rndValueS_uid102_block_rsrvd_fix(LOGICAL,101)@21
    rndValueS_uid102_block_rsrvd_fix_q <= not (rndValueSInv_uid101_block_rsrvd_fix_q);

    -- top2BitsProd_uid69_block_rsrvd_fix(BITSELECT,68)@8
    top2BitsProd_uid69_block_rsrvd_fix_b <= osig_uid212_prod_uid62_block_rsrvd_fix_b(105 downto 104);

    -- redist50_top2BitsProd_uid69_block_rsrvd_fix_b_7(DELAY,537)
    redist50_top2BitsProd_uid69_block_rsrvd_fix_b_7 : dspba_delay
    GENERIC MAP ( width => 2, depth => 7, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => top2BitsProd_uid69_block_rsrvd_fix_b, xout => redist50_top2BitsProd_uid69_block_rsrvd_fix_b_7_q, clk => clock, aclr => resetn );

    -- OneTopBitIsOne_uid74_block_rsrvd_fix(LOGICAL,73)@15
    OneTopBitIsOne_uid74_block_rsrvd_fix_q <= "1" WHEN redist50_top2BitsProd_uid69_block_rsrvd_fix_b_7_q /= "00" ELSE "0";

    -- prodLessThanOne_uid75_block_rsrvd_fix(LOGICAL,74)@15
    prodLessThanOne_uid75_block_rsrvd_fix_q <= not (OneTopBitIsOne_uid74_block_rsrvd_fix_q);

    -- redist44_expSumMBiasGTZero_uid76_block_rsrvd_fix_c_3(DELAY,531)
    redist44_expSumMBiasGTZero_uid76_block_rsrvd_fix_c_3 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => expSumMBiasGTZero_uid76_block_rsrvd_fix_c, xout => redist44_expSumMBiasGTZero_uid76_block_rsrvd_fix_c_3_q, clk => clock, aclr => resetn );

    -- case5_uid85_block_rsrvd_fix(LOGICAL,84)@15 + 1
    case5_uid85_block_rsrvd_fix_qi <= redist44_expSumMBiasGTZero_uid76_block_rsrvd_fix_c_3_q and prodLessThanOne_uid75_block_rsrvd_fix_q;
    case5_uid85_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => case5_uid85_block_rsrvd_fix_qi, xout => case5_uid85_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- redist42_case5_uid85_block_rsrvd_fix_q_4(DELAY,529)
    redist42_case5_uid85_block_rsrvd_fix_q_4 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => case5_uid85_block_rsrvd_fix_q, xout => redist42_case5_uid85_block_rsrvd_fix_q_4_q, clk => clock, aclr => resetn );

    -- redist43_case5_uid85_block_rsrvd_fix_q_6(DELAY,530)
    redist43_case5_uid85_block_rsrvd_fix_q_6 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist42_case5_uid85_block_rsrvd_fix_q_4_q, xout => redist43_case5_uid85_block_rsrvd_fix_q_6_q, clk => clock, aclr => resetn );

    -- rndVal_uid119_block_rsrvd_fix(MUX,118)@21 + 1
    rndVal_uid119_block_rsrvd_fix_s <= redist43_case5_uid85_block_rsrvd_fix_q_6_q;
    rndVal_uid119_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            rndVal_uid119_block_rsrvd_fix_q <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            CASE (rndVal_uid119_block_rsrvd_fix_s) IS
                WHEN "0" => rndVal_uid119_block_rsrvd_fix_q <= rndValueS_uid102_block_rsrvd_fix_q;
                WHEN "1" => rndVal_uid119_block_rsrvd_fix_q <= rndValueSLeft_uid117_block_rsrvd_fix_q;
                WHEN OTHERS => rndVal_uid119_block_rsrvd_fix_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- postRightShiftProdR_uid98_block_rsrvd_fix(BITSELECT,97)@18
    postRightShiftProdR_uid98_block_rsrvd_fix_in <= r_uid362_postRightShiftProd_uid90_block_rsrvd_fix_q(107 downto 0);
    postRightShiftProdR_uid98_block_rsrvd_fix_b <= postRightShiftProdR_uid98_block_rsrvd_fix_in(107 downto 55);

    -- redist38_postRightShiftProdR_uid98_block_rsrvd_fix_b_1(DELAY,525)
    redist38_postRightShiftProdR_uid98_block_rsrvd_fix_b_1 : dspba_delay
    GENERIC MAP ( width => 53, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => postRightShiftProdR_uid98_block_rsrvd_fix_b, xout => redist38_postRightShiftProdR_uid98_block_rsrvd_fix_b_1_q, clk => clock, aclr => resetn );

    -- fracInRnd_uid118_block_rsrvd_fix(MUX,117)@19 + 1
    fracInRnd_uid118_block_rsrvd_fix_s <= redist42_case5_uid85_block_rsrvd_fix_q_4_q;
    fracInRnd_uid118_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            fracInRnd_uid118_block_rsrvd_fix_q <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            CASE (fracInRnd_uid118_block_rsrvd_fix_s) IS
                WHEN "0" => fracInRnd_uid118_block_rsrvd_fix_q <= redist38_postRightShiftProdR_uid98_block_rsrvd_fix_b_1_q;
                WHEN "1" => fracInRnd_uid118_block_rsrvd_fix_q <= preRndFracLeftShift_uid109_block_rsrvd_fix_merged_bit_select_b;
                WHEN OTHERS => fracInRnd_uid118_block_rsrvd_fix_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- redist36_fracInRnd_uid118_block_rsrvd_fix_q_3(DELAY,523)
    redist36_fracInRnd_uid118_block_rsrvd_fix_q_3 : dspba_delay
    GENERIC MAP ( width => 53, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => fracInRnd_uid118_block_rsrvd_fix_q, xout => redist36_fracInRnd_uid118_block_rsrvd_fix_q_3_q, clk => clock, aclr => resetn );

    -- fracRnd_uid120_block_rsrvd_fix(ADD,119)@22
    fracRnd_uid120_block_rsrvd_fix_a <= STD_LOGIC_VECTOR("0" & redist36_fracInRnd_uid118_block_rsrvd_fix_q_3_q);
    fracRnd_uid120_block_rsrvd_fix_b <= STD_LOGIC_VECTOR("00000000000000000000000000000000000000000000000000000" & rndVal_uid119_block_rsrvd_fix_q);
    fracRnd_uid120_block_rsrvd_fix_o <= STD_LOGIC_VECTOR(UNSIGNED(fracRnd_uid120_block_rsrvd_fix_a) + UNSIGNED(fracRnd_uid120_block_rsrvd_fix_b));
    fracRnd_uid120_block_rsrvd_fix_q <= fracRnd_uid120_block_rsrvd_fix_o(53 downto 0);

    -- expIncrement_uid122_block_rsrvd_fix(BITSELECT,121)@22
    expIncrement_uid122_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(fracRnd_uid120_block_rsrvd_fix_q(53 downto 53));

    -- redist34_expIncrement_uid122_block_rsrvd_fix_b_1(DELAY,521)
    redist34_expIncrement_uid122_block_rsrvd_fix_b_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => expIncrement_uid122_block_rsrvd_fix_b, xout => redist34_expIncrement_uid122_block_rsrvd_fix_b_1_q, clk => clock, aclr => resetn );

    -- redist33_expRPre_uid145_block_rsrvd_fix_q_6_notEnable(LOGICAL,582)
    redist33_expRPre_uid145_block_rsrvd_fix_q_6_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist33_expRPre_uid145_block_rsrvd_fix_q_6_nor(LOGICAL,583)
    redist33_expRPre_uid145_block_rsrvd_fix_q_6_nor_q <= not (redist33_expRPre_uid145_block_rsrvd_fix_q_6_notEnable_q or redist33_expRPre_uid145_block_rsrvd_fix_q_6_sticky_ena_q);

    -- redist33_expRPre_uid145_block_rsrvd_fix_q_6_cmpReg(REG,581)
    redist33_expRPre_uid145_block_rsrvd_fix_q_6_cmpReg_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist33_expRPre_uid145_block_rsrvd_fix_q_6_cmpReg_q <= "0";
        ELSIF (clock'EVENT AND clock = '1') THEN
            redist33_expRPre_uid145_block_rsrvd_fix_q_6_cmpReg_q <= STD_LOGIC_VECTOR(VCC_q);
        END IF;
    END PROCESS;

    -- redist33_expRPre_uid145_block_rsrvd_fix_q_6_sticky_ena(REG,584)
    redist33_expRPre_uid145_block_rsrvd_fix_q_6_sticky_ena_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist33_expRPre_uid145_block_rsrvd_fix_q_6_sticky_ena_q <= "0";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (redist33_expRPre_uid145_block_rsrvd_fix_q_6_nor_q = "1") THEN
                redist33_expRPre_uid145_block_rsrvd_fix_q_6_sticky_ena_q <= STD_LOGIC_VECTOR(redist33_expRPre_uid145_block_rsrvd_fix_q_6_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist33_expRPre_uid145_block_rsrvd_fix_q_6_enaAnd(LOGICAL,585)
    redist33_expRPre_uid145_block_rsrvd_fix_q_6_enaAnd_q <= redist33_expRPre_uid145_block_rsrvd_fix_q_6_sticky_ena_q and VCC_q;

    -- redist33_expRPre_uid145_block_rsrvd_fix_q_6_rdcnt(COUNTER,579)
    -- low=0, high=1, step=1, init=0
    redist33_expRPre_uid145_block_rsrvd_fix_q_6_rdcnt_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist33_expRPre_uid145_block_rsrvd_fix_q_6_rdcnt_i <= TO_UNSIGNED(0, 1);
        ELSIF (clock'EVENT AND clock = '1') THEN
            redist33_expRPre_uid145_block_rsrvd_fix_q_6_rdcnt_i <= redist33_expRPre_uid145_block_rsrvd_fix_q_6_rdcnt_i + 1;
        END IF;
    END PROCESS;
    redist33_expRPre_uid145_block_rsrvd_fix_q_6_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist33_expRPre_uid145_block_rsrvd_fix_q_6_rdcnt_i, 1)));

    -- redist58_expSumMBias_uid61_block_rsrvd_fix_q_5(DELAY,545)
    redist58_expSumMBias_uid61_block_rsrvd_fix_q_5 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist57_expSumMBias_uid61_block_rsrvd_fix_q_4_q, xout => redist58_expSumMBias_uid61_block_rsrvd_fix_q_5_q, clk => clock, aclr => resetn );

    -- expSumMBiasMLZ_uid125_block_rsrvd_fix(SUB,124)@16 + 1
    expSumMBiasMLZ_uid125_block_rsrvd_fix_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((15 downto 14 => redist58_expSumMBias_uid61_block_rsrvd_fix_q_5_q(13)) & redist58_expSumMBias_uid61_block_rsrvd_fix_q_5_q));
    expSumMBiasMLZ_uid125_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000000000" & redist20_r_uid255_lz_uid68_block_rsrvd_fix_q_1_q));
    expSumMBiasMLZ_uid125_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            expSumMBiasMLZ_uid125_block_rsrvd_fix_o <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            expSumMBiasMLZ_uid125_block_rsrvd_fix_o <= STD_LOGIC_VECTOR(SIGNED(expSumMBiasMLZ_uid125_block_rsrvd_fix_a) - SIGNED(expSumMBiasMLZ_uid125_block_rsrvd_fix_b));
        END IF;
    END PROCESS;
    expSumMBiasMLZ_uid125_block_rsrvd_fix_q <= expSumMBiasMLZ_uid125_block_rsrvd_fix_o(14 downto 0);

    -- zeroExtBits_to15_uid142(BITSELECT,141)@17
    zeroExtBits_to15_uid142_in <= STD_LOGIC_VECTOR("00000000000000" & GND_q);
    zeroExtBits_to15_uid142_b <= zeroExtBits_to15_uid142_in(14 downto 0);

    -- expSumMBiasP1_uid124_block_rsrvd_fix(ADD,123)@16 + 1
    expSumMBiasP1_uid124_block_rsrvd_fix_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((15 downto 14 => redist58_expSumMBias_uid61_block_rsrvd_fix_q_5_q(13)) & redist58_expSumMBias_uid61_block_rsrvd_fix_q_5_q));
    expSumMBiasP1_uid124_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("000000000000000" & VCC_q));
    expSumMBiasP1_uid124_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            expSumMBiasP1_uid124_block_rsrvd_fix_o <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            expSumMBiasP1_uid124_block_rsrvd_fix_o <= STD_LOGIC_VECTOR(SIGNED(expSumMBiasP1_uid124_block_rsrvd_fix_a) + SIGNED(expSumMBiasP1_uid124_block_rsrvd_fix_b));
        END IF;
    END PROCESS;
    expSumMBiasP1_uid124_block_rsrvd_fix_q <= expSumMBiasP1_uid124_block_rsrvd_fix_o(14 downto 0);

    -- redist59_expSumMBias_uid61_block_rsrvd_fix_q_6(DELAY,546)
    redist59_expSumMBias_uid61_block_rsrvd_fix_q_6 : dspba_delay
    GENERIC MAP ( width => 14, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist58_expSumMBias_uid61_block_rsrvd_fix_q_5_q, xout => redist59_expSumMBias_uid61_block_rsrvd_fix_q_6_q, clk => clock, aclr => resetn );

    -- expSumMBias_to15_uid144(BITSELECT,143)@17
    expSumMBias_to15_uid144_in <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((14 downto 14 => redist59_expSumMBias_uid61_block_rsrvd_fix_q_6_q(13)) & redist59_expSumMBias_uid61_block_rsrvd_fix_q_6_q));
    expSumMBias_to15_uid144_b <= STD_LOGIC_VECTOR(expSumMBias_to15_uid144_in(14 downto 0));

    -- invLZGTELepLeftShift_uid137_block_rsrvd_fix(LOGICAL,136)@16
    invLZGTELepLeftShift_uid137_block_rsrvd_fix_q <= not (lzGTELepLeftShift_uid105_block_rsrvd_fix_n);

    -- sel3r_uid138_block_rsrvd_fix(LOGICAL,137)@16
    sel3r_uid138_block_rsrvd_fix_q <= case5_uid85_block_rsrvd_fix_q and invLZGTELepLeftShift_uid137_block_rsrvd_fix_q;

    -- cst32bit_uid139_block_rsrvd_fix(CONSTANT,138)
    cst32bit_uid139_block_rsrvd_fix_q <= "11";

    -- sel3_uid140_block_rsrvd_fix(LOGICAL,139)@16
    sel3_uid140_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((1 downto 1 => sel3r_uid138_block_rsrvd_fix_q(0)) & sel3r_uid138_block_rsrvd_fix_q));
    sel3_uid140_block_rsrvd_fix_q <= cst32bit_uid139_block_rsrvd_fix_q and sel3_uid140_block_rsrvd_fix_b;

    -- case5WithlzGTELepLeftShift_uid133_block_rsrvd_fix(LOGICAL,132)@16
    case5WithlzGTELepLeftShift_uid133_block_rsrvd_fix_q <= case5_uid85_block_rsrvd_fix_q and lzGTELepLeftShift_uid105_block_rsrvd_fix_n;

    -- redist47_prodLessThanOne_uid75_block_rsrvd_fix_q_1(DELAY,534)
    redist47_prodLessThanOne_uid75_block_rsrvd_fix_q_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => prodLessThanOne_uid75_block_rsrvd_fix_q, xout => redist47_prodLessThanOne_uid75_block_rsrvd_fix_q_1_q, clk => clock, aclr => resetn );

    -- expSumMBiasLTZero_uid78_block_rsrvd_fix_cmp_sign(LOGICAL,316)@16
    expSumMBiasLTZero_uid78_block_rsrvd_fix_cmp_sign_q <= STD_LOGIC_VECTOR(redist58_expSumMBias_uid61_block_rsrvd_fix_q_5_q(13 downto 13));

    -- case4_uid84_block_rsrvd_fix(LOGICAL,83)@16
    case4_uid84_block_rsrvd_fix_q <= expSumMBiasLTZero_uid78_block_rsrvd_fix_cmp_sign_q and redist47_prodLessThanOne_uid75_block_rsrvd_fix_q_1_q;

    -- redist49_xMSB_uid70_block_rsrvd_fix_b_8(DELAY,536)
    redist49_xMSB_uid70_block_rsrvd_fix_b_8 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist48_xMSB_uid70_block_rsrvd_fix_b_5_q, xout => redist49_xMSB_uid70_block_rsrvd_fix_b_8_q, clk => clock, aclr => resetn );

    -- case2_uid82_block_rsrvd_fix(LOGICAL,81)@16
    case2_uid82_block_rsrvd_fix_q <= expSumMBiasLTZero_uid78_block_rsrvd_fix_cmp_sign_q and redist49_xMSB_uid70_block_rsrvd_fix_b_8_q;

    -- cstOneOnTwoBits_uid72_block_rsrvd_fix(CONSTANT,71)
    cstOneOnTwoBits_uid72_block_rsrvd_fix_q <= "01";

    -- prodInOneTwo_uid73_block_rsrvd_fix(LOGICAL,72)@15 + 1
    prodInOneTwo_uid73_block_rsrvd_fix_qi <= "1" WHEN redist50_top2BitsProd_uid69_block_rsrvd_fix_b_7_q = cstOneOnTwoBits_uid72_block_rsrvd_fix_q ELSE "0";
    prodInOneTwo_uid73_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => prodInOneTwo_uid73_block_rsrvd_fix_qi, xout => prodInOneTwo_uid73_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- redist46_expSumMBiasGTZero_uid76_block_rsrvd_fix_n_4(DELAY,533)
    redist46_expSumMBiasGTZero_uid76_block_rsrvd_fix_n_4 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => expSumMBiasGTZero_uid76_block_rsrvd_fix_n, xout => redist46_expSumMBiasGTZero_uid76_block_rsrvd_fix_n_4_q, clk => clock, aclr => resetn );

    -- case1_uid81_block_rsrvd_fix(LOGICAL,80)@16
    case1_uid81_block_rsrvd_fix_q <= redist46_expSumMBiasGTZero_uid76_block_rsrvd_fix_n_4_q and prodInOneTwo_uid73_block_rsrvd_fix_q;

    -- sel2r_uid134_block_rsrvd_fix(LOGICAL,133)@16
    sel2r_uid134_block_rsrvd_fix_q <= case1_uid81_block_rsrvd_fix_q or case2_uid82_block_rsrvd_fix_q or case4_uid84_block_rsrvd_fix_q or case5WithlzGTELepLeftShift_uid133_block_rsrvd_fix_q;

    -- cst22bit_uid135_block_rsrvd_fix(CONSTANT,134)
    cst22bit_uid135_block_rsrvd_fix_q <= "10";

    -- sel2_uid136_block_rsrvd_fix(LOGICAL,135)@16
    sel2_uid136_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((1 downto 1 => sel2r_uid134_block_rsrvd_fix_q(0)) & sel2r_uid134_block_rsrvd_fix_q));
    sel2_uid136_block_rsrvd_fix_q <= cst22bit_uid135_block_rsrvd_fix_q and sel2_uid136_block_rsrvd_fix_b;

    -- expSumMBiasEQZero_uid79_block_rsrvd_fix(LOGICAL,78)@15 + 1
    expSumMBiasEQZero_uid79_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((13 downto 1 => GND_q(0)) & GND_q));
    expSumMBiasEQZero_uid79_block_rsrvd_fix_qi <= "1" WHEN redist57_expSumMBias_uid61_block_rsrvd_fix_q_4_q = expSumMBiasEQZero_uid79_block_rsrvd_fix_b ELSE "0";
    expSumMBiasEQZero_uid79_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => expSumMBiasEQZero_uid79_block_rsrvd_fix_qi, xout => expSumMBiasEQZero_uid79_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- redist45_expSumMBiasGTZero_uid76_block_rsrvd_fix_c_4(DELAY,532)
    redist45_expSumMBiasGTZero_uid76_block_rsrvd_fix_c_4 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist44_expSumMBiasGTZero_uid76_block_rsrvd_fix_c_3_q, xout => redist45_expSumMBiasGTZero_uid76_block_rsrvd_fix_c_4_q, clk => clock, aclr => resetn );

    -- expGTE0_uid129_block_rsrvd_fix(LOGICAL,128)@16
    expGTE0_uid129_block_rsrvd_fix_q <= redist45_expSumMBiasGTZero_uid76_block_rsrvd_fix_c_4_q or expSumMBiasEQZero_uid79_block_rsrvd_fix_q;

    -- sel1r_uid130_block_rsrvd_fix(LOGICAL,129)@16
    sel1r_uid130_block_rsrvd_fix_q <= redist49_xMSB_uid70_block_rsrvd_fix_b_8_q and expGTE0_uid129_block_rsrvd_fix_q;

    -- sel1_uid132_block_rsrvd_fix(LOGICAL,131)@16
    sel1_uid132_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((1 downto 1 => sel1r_uid130_block_rsrvd_fix_q(0)) & sel1r_uid130_block_rsrvd_fix_q));
    sel1_uid132_block_rsrvd_fix_q <= cstOneOnTwoBits_uid72_block_rsrvd_fix_q and sel1_uid132_block_rsrvd_fix_b;

    -- case3_uid83_block_rsrvd_fix(LOGICAL,82)@16
    case3_uid83_block_rsrvd_fix_q <= expSumMBiasEQZero_uid79_block_rsrvd_fix_q and redist47_prodLessThanOne_uid75_block_rsrvd_fix_q_1_q;

    -- case0_uid80_block_rsrvd_fix(LOGICAL,79)@16
    case0_uid80_block_rsrvd_fix_q <= redist45_expSumMBiasGTZero_uid76_block_rsrvd_fix_c_4_q and prodInOneTwo_uid73_block_rsrvd_fix_q;

    -- sel0r_uid126_block_rsrvd_fix(LOGICAL,125)@16
    sel0r_uid126_block_rsrvd_fix_q <= case0_uid80_block_rsrvd_fix_q or case3_uid83_block_rsrvd_fix_q;

    -- sel0_uid128_block_rsrvd_fix(LOGICAL,127)@16
    sel0_uid128_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((1 downto 1 => sel0r_uid126_block_rsrvd_fix_q(0)) & sel0r_uid126_block_rsrvd_fix_q));
    sel0_uid128_block_rsrvd_fix_q <= cst02bit_uid127_block_rsrvd_fix_q and sel0_uid128_block_rsrvd_fix_b;

    -- muxSel_uid141_block_rsrvd_fix(LOGICAL,140)@16 + 1
    muxSel_uid141_block_rsrvd_fix_qi <= sel0_uid128_block_rsrvd_fix_q or sel1_uid132_block_rsrvd_fix_q or sel2_uid136_block_rsrvd_fix_q or sel3_uid140_block_rsrvd_fix_q;
    muxSel_uid141_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 2, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => muxSel_uid141_block_rsrvd_fix_qi, xout => muxSel_uid141_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- expRPre_uid145_block_rsrvd_fix(MUX,144)@17 + 1
    expRPre_uid145_block_rsrvd_fix_s <= muxSel_uid141_block_rsrvd_fix_q;
    expRPre_uid145_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            expRPre_uid145_block_rsrvd_fix_q <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            CASE (expRPre_uid145_block_rsrvd_fix_s) IS
                WHEN "00" => expRPre_uid145_block_rsrvd_fix_q <= expSumMBias_to15_uid144_b;
                WHEN "01" => expRPre_uid145_block_rsrvd_fix_q <= expSumMBiasP1_uid124_block_rsrvd_fix_q;
                WHEN "10" => expRPre_uid145_block_rsrvd_fix_q <= zeroExtBits_to15_uid142_b;
                WHEN "11" => expRPre_uid145_block_rsrvd_fix_q <= expSumMBiasMLZ_uid125_block_rsrvd_fix_q;
                WHEN OTHERS => expRPre_uid145_block_rsrvd_fix_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- redist33_expRPre_uid145_block_rsrvd_fix_q_6_inputreg(DELAY,576)
    redist33_expRPre_uid145_block_rsrvd_fix_q_6_inputreg : dspba_delay
    GENERIC MAP ( width => 15, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => expRPre_uid145_block_rsrvd_fix_q, xout => redist33_expRPre_uid145_block_rsrvd_fix_q_6_inputreg_q, clk => clock, aclr => resetn );

    -- redist33_expRPre_uid145_block_rsrvd_fix_q_6_wraddr(REG,580)
    redist33_expRPre_uid145_block_rsrvd_fix_q_6_wraddr_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist33_expRPre_uid145_block_rsrvd_fix_q_6_wraddr_q <= "1";
        ELSIF (clock'EVENT AND clock = '1') THEN
            redist33_expRPre_uid145_block_rsrvd_fix_q_6_wraddr_q <= STD_LOGIC_VECTOR(redist33_expRPre_uid145_block_rsrvd_fix_q_6_rdcnt_q);
        END IF;
    END PROCESS;

    -- redist33_expRPre_uid145_block_rsrvd_fix_q_6_mem(DUALMEM,578)
    redist33_expRPre_uid145_block_rsrvd_fix_q_6_mem_ia <= STD_LOGIC_VECTOR(redist33_expRPre_uid145_block_rsrvd_fix_q_6_inputreg_q);
    redist33_expRPre_uid145_block_rsrvd_fix_q_6_mem_aa <= redist33_expRPre_uid145_block_rsrvd_fix_q_6_wraddr_q;
    redist33_expRPre_uid145_block_rsrvd_fix_q_6_mem_ab <= redist33_expRPre_uid145_block_rsrvd_fix_q_6_rdcnt_q;
    redist33_expRPre_uid145_block_rsrvd_fix_q_6_mem_reset0 <= not (resetn);
    redist33_expRPre_uid145_block_rsrvd_fix_q_6_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 15,
        widthad_a => 1,
        numwords_a => 2,
        width_b => 15,
        widthad_b => 1,
        numwords_b => 2,
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
        clocken1 => redist33_expRPre_uid145_block_rsrvd_fix_q_6_enaAnd_q(0),
        clocken0 => VCC_q(0),
        clock0 => clock,
        aclr1 => redist33_expRPre_uid145_block_rsrvd_fix_q_6_mem_reset0,
        clock1 => clock,
        address_a => redist33_expRPre_uid145_block_rsrvd_fix_q_6_mem_aa,
        data_a => redist33_expRPre_uid145_block_rsrvd_fix_q_6_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist33_expRPre_uid145_block_rsrvd_fix_q_6_mem_ab,
        q_b => redist33_expRPre_uid145_block_rsrvd_fix_q_6_mem_iq
    );
    redist33_expRPre_uid145_block_rsrvd_fix_q_6_mem_q <= redist33_expRPre_uid145_block_rsrvd_fix_q_6_mem_iq(14 downto 0);

    -- redist33_expRPre_uid145_block_rsrvd_fix_q_6_outputreg(DELAY,577)
    redist33_expRPre_uid145_block_rsrvd_fix_q_6_outputreg : dspba_delay
    GENERIC MAP ( width => 15, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist33_expRPre_uid145_block_rsrvd_fix_q_6_mem_q, xout => redist33_expRPre_uid145_block_rsrvd_fix_q_6_outputreg_q, clk => clock, aclr => resetn );

    -- expRPreExc_uid146_block_rsrvd_fix(ADD,145)@23 + 1
    expRPreExc_uid146_block_rsrvd_fix_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((16 downto 15 => redist33_expRPre_uid145_block_rsrvd_fix_q_6_outputreg_q(14)) & redist33_expRPre_uid145_block_rsrvd_fix_q_6_outputreg_q));
    expRPreExc_uid146_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0000000000000000" & redist34_expIncrement_uid122_block_rsrvd_fix_b_1_q));
    expRPreExc_uid146_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            expRPreExc_uid146_block_rsrvd_fix_o <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            expRPreExc_uid146_block_rsrvd_fix_o <= STD_LOGIC_VECTOR(SIGNED(expRPreExc_uid146_block_rsrvd_fix_a) + SIGNED(expRPreExc_uid146_block_rsrvd_fix_b));
        END IF;
    END PROCESS;
    expRPreExc_uid146_block_rsrvd_fix_q <= expRPreExc_uid146_block_rsrvd_fix_o(15 downto 0);

    -- expRFinal_uid176_block_rsrvd_fix(BITSELECT,175)@24
    expRFinal_uid176_block_rsrvd_fix_in <= expRPreExc_uid146_block_rsrvd_fix_q(10 downto 0);
    expRFinal_uid176_block_rsrvd_fix_b <= expRFinal_uid176_block_rsrvd_fix_in(10 downto 0);

    -- redist31_expRFinal_uid176_block_rsrvd_fix_b_2(DELAY,518)
    redist31_expRFinal_uid176_block_rsrvd_fix_b_2 : dspba_delay
    GENERIC MAP ( width => 11, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => expRFinal_uid176_block_rsrvd_fix_b, xout => redist31_expRFinal_uid176_block_rsrvd_fix_b_2_q, clk => clock, aclr => resetn );

    -- expOvf_uid149_block_rsrvd_fix(COMPARE,148)@24 + 1
    expOvf_uid149_block_rsrvd_fix_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((17 downto 16 => expRPreExc_uid146_block_rsrvd_fix_q(15)) & expRPreExc_uid146_block_rsrvd_fix_q));
    expOvf_uid149_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR("0000000" & cstAllOWE_uid11_block_rsrvd_fix_q));
    expOvf_uid149_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            expOvf_uid149_block_rsrvd_fix_o <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            expOvf_uid149_block_rsrvd_fix_o <= STD_LOGIC_VECTOR(SIGNED(expOvf_uid149_block_rsrvd_fix_a) - SIGNED(expOvf_uid149_block_rsrvd_fix_b));
        END IF;
    END PROCESS;
    expOvf_uid149_block_rsrvd_fix_n(0) <= not (expOvf_uid149_block_rsrvd_fix_o(17));

    -- redist63_excR_y_uid42_block_rsrvd_fix_q_23(DELAY,550)
    redist63_excR_y_uid42_block_rsrvd_fix_q_23 : dspba_delay
    GENERIC MAP ( width => 1, depth => 22, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excR_y_uid42_block_rsrvd_fix_q, xout => redist63_excR_y_uid42_block_rsrvd_fix_q_23_q, clk => clock, aclr => resetn );

    -- redist64_excR_y_uid42_block_rsrvd_fix_q_24(DELAY,551)
    redist64_excR_y_uid42_block_rsrvd_fix_q_24 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist63_excR_y_uid42_block_rsrvd_fix_q_23_q, xout => redist64_excR_y_uid42_block_rsrvd_fix_q_24_q, clk => clock, aclr => resetn );

    -- redist68_excR_x_uid25_block_rsrvd_fix_q_23(DELAY,555)
    redist68_excR_x_uid25_block_rsrvd_fix_q_23 : dspba_delay
    GENERIC MAP ( width => 1, depth => 22, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excR_x_uid25_block_rsrvd_fix_q, xout => redist68_excR_x_uid25_block_rsrvd_fix_q_23_q, clk => clock, aclr => resetn );

    -- redist69_excR_x_uid25_block_rsrvd_fix_q_24(DELAY,556)
    redist69_excR_x_uid25_block_rsrvd_fix_q_24 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist68_excR_x_uid25_block_rsrvd_fix_q_23_q, xout => redist69_excR_x_uid25_block_rsrvd_fix_q_24_q, clk => clock, aclr => resetn );

    -- ExcROvfAndInReg_uid162_block_rsrvd_fix(LOGICAL,161)@25
    ExcROvfAndInReg_uid162_block_rsrvd_fix_q <= redist69_excR_x_uid25_block_rsrvd_fix_q_24_q and redist64_excR_y_uid42_block_rsrvd_fix_q_24_q and expOvf_uid149_block_rsrvd_fix_n;

    -- redist70_excI_x_uid21_block_rsrvd_fix_q_23(DELAY,557)
    redist70_excI_x_uid21_block_rsrvd_fix_q_23 : dspba_delay
    GENERIC MAP ( width => 1, depth => 22, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excI_x_uid21_block_rsrvd_fix_q, xout => redist70_excI_x_uid21_block_rsrvd_fix_q_23_q, clk => clock, aclr => resetn );

    -- redist61_yIsSubnorm_uid48_block_rsrvd_fix_q_22(DELAY,548)
    redist61_yIsSubnorm_uid48_block_rsrvd_fix_q_22 : dspba_delay
    GENERIC MAP ( width => 1, depth => 22, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => yIsSubnorm_uid48_block_rsrvd_fix_q, xout => redist61_yIsSubnorm_uid48_block_rsrvd_fix_q_22_q, clk => clock, aclr => resetn );

    -- excYRSub_uid152_block_rsrvd_fix(LOGICAL,151)@24
    excYRSub_uid152_block_rsrvd_fix_q <= redist63_excR_y_uid42_block_rsrvd_fix_q_23_q or redist61_yIsSubnorm_uid48_block_rsrvd_fix_q_22_q;

    -- excYRAndExcXI_uid161_block_rsrvd_fix(LOGICAL,160)@24 + 1
    excYRAndExcXI_uid161_block_rsrvd_fix_qi <= excYRSub_uid152_block_rsrvd_fix_q and redist70_excI_x_uid21_block_rsrvd_fix_q_23_q;
    excYRAndExcXI_uid161_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excYRAndExcXI_uid161_block_rsrvd_fix_qi, xout => excYRAndExcXI_uid161_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- redist65_excI_y_uid38_block_rsrvd_fix_q_23(DELAY,552)
    redist65_excI_y_uid38_block_rsrvd_fix_q_23 : dspba_delay
    GENERIC MAP ( width => 1, depth => 22, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excI_y_uid38_block_rsrvd_fix_q, xout => redist65_excI_y_uid38_block_rsrvd_fix_q_23_q, clk => clock, aclr => resetn );

    -- redist62_xIsSubnorm_uid46_block_rsrvd_fix_q_22(DELAY,549)
    redist62_xIsSubnorm_uid46_block_rsrvd_fix_q_22 : dspba_delay
    GENERIC MAP ( width => 1, depth => 22, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => xIsSubnorm_uid46_block_rsrvd_fix_q, xout => redist62_xIsSubnorm_uid46_block_rsrvd_fix_q_22_q, clk => clock, aclr => resetn );

    -- excXRSub_uid151_block_rsrvd_fix(LOGICAL,150)@24
    excXRSub_uid151_block_rsrvd_fix_q <= redist68_excR_x_uid25_block_rsrvd_fix_q_23_q or redist62_xIsSubnorm_uid46_block_rsrvd_fix_q_22_q;

    -- excXRAndExcYI_uid160_block_rsrvd_fix(LOGICAL,159)@24 + 1
    excXRAndExcYI_uid160_block_rsrvd_fix_qi <= excXRSub_uid151_block_rsrvd_fix_q and redist65_excI_y_uid38_block_rsrvd_fix_q_23_q;
    excXRAndExcYI_uid160_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excXRAndExcYI_uid160_block_rsrvd_fix_qi, xout => excXRAndExcYI_uid160_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- excXIAndExcYI_uid157_block_rsrvd_fix(LOGICAL,156)@24 + 1
    excXIAndExcYI_uid157_block_rsrvd_fix_qi <= redist70_excI_x_uid21_block_rsrvd_fix_q_23_q and redist65_excI_y_uid38_block_rsrvd_fix_q_23_q;
    excXIAndExcYI_uid157_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excXIAndExcYI_uid157_block_rsrvd_fix_qi, xout => excXIAndExcYI_uid157_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- excRInf_uid163_block_rsrvd_fix(LOGICAL,162)@25
    excRInf_uid163_block_rsrvd_fix_q <= excXIAndExcYI_uid157_block_rsrvd_fix_q or excXRAndExcYI_uid160_block_rsrvd_fix_q or excYRAndExcXI_uid161_block_rsrvd_fix_q or ExcROvfAndInReg_uid162_block_rsrvd_fix_q;

    -- rUnderflow_uid147_block_rsrvd_fix_cmp_sign(LOGICAL,408)@24
    rUnderflow_uid147_block_rsrvd_fix_cmp_sign_q <= STD_LOGIC_VECTOR(expRPreExc_uid146_block_rsrvd_fix_q(15 downto 15));

    -- excZC3_uid155_block_rsrvd_fix(LOGICAL,154)@24
    excZC3_uid155_block_rsrvd_fix_q <= excXRSub_uid151_block_rsrvd_fix_q and excYRSub_uid152_block_rsrvd_fix_q and rUnderflow_uid147_block_rsrvd_fix_cmp_sign_q;

    -- redist66_excZ_y_uid37_block_rsrvd_fix_q_23(DELAY,553)
    redist66_excZ_y_uid37_block_rsrvd_fix_q_23 : dspba_delay
    GENERIC MAP ( width => 1, depth => 22, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excZ_y_uid37_block_rsrvd_fix_q, xout => redist66_excZ_y_uid37_block_rsrvd_fix_q_23_q, clk => clock, aclr => resetn );

    -- excYZAndExcXR_uid154_block_rsrvd_fix(LOGICAL,153)@24
    excYZAndExcXR_uid154_block_rsrvd_fix_q <= redist66_excZ_y_uid37_block_rsrvd_fix_q_23_q and excXRSub_uid151_block_rsrvd_fix_q;

    -- redist71_excZ_x_uid20_block_rsrvd_fix_q_23(DELAY,558)
    redist71_excZ_x_uid20_block_rsrvd_fix_q_23 : dspba_delay
    GENERIC MAP ( width => 1, depth => 22, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excZ_x_uid20_block_rsrvd_fix_q, xout => redist71_excZ_x_uid20_block_rsrvd_fix_q_23_q, clk => clock, aclr => resetn );

    -- excXZAndExcYR_uid153_block_rsrvd_fix(LOGICAL,152)@24
    excXZAndExcYR_uid153_block_rsrvd_fix_q <= redist71_excZ_x_uid20_block_rsrvd_fix_q_23_q and excYRSub_uid152_block_rsrvd_fix_q;

    -- excXZAndExcYZ_uid150_block_rsrvd_fix(LOGICAL,149)@24
    excXZAndExcYZ_uid150_block_rsrvd_fix_q <= redist71_excZ_x_uid20_block_rsrvd_fix_q_23_q and redist66_excZ_y_uid37_block_rsrvd_fix_q_23_q;

    -- excRZero_uid156_block_rsrvd_fix(LOGICAL,155)@24 + 1
    excRZero_uid156_block_rsrvd_fix_qi <= excXZAndExcYZ_uid150_block_rsrvd_fix_q or excXZAndExcYR_uid153_block_rsrvd_fix_q or excYZAndExcXR_uid154_block_rsrvd_fix_q or excZC3_uid155_block_rsrvd_fix_q;
    excRZero_uid156_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excRZero_uid156_block_rsrvd_fix_qi, xout => excRZero_uid156_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- concExc_uid168_block_rsrvd_fix(BITJOIN,167)@25
    concExc_uid168_block_rsrvd_fix_q <= redist32_excRNaN_uid167_block_rsrvd_fix_q_23_q & excRInf_uid163_block_rsrvd_fix_q & excRZero_uid156_block_rsrvd_fix_q;

    -- excREnc_uid169_block_rsrvd_fix(LOOKUP,168)@25 + 1
    excREnc_uid169_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            excREnc_uid169_block_rsrvd_fix_q <= "01";
        ELSIF (clock'EVENT AND clock = '1') THEN
            CASE (concExc_uid168_block_rsrvd_fix_q) IS
                WHEN "000" => excREnc_uid169_block_rsrvd_fix_q <= "01";
                WHEN "001" => excREnc_uid169_block_rsrvd_fix_q <= "00";
                WHEN "010" => excREnc_uid169_block_rsrvd_fix_q <= "10";
                WHEN "011" => excREnc_uid169_block_rsrvd_fix_q <= "00";
                WHEN "100" => excREnc_uid169_block_rsrvd_fix_q <= "11";
                WHEN "101" => excREnc_uid169_block_rsrvd_fix_q <= "00";
                WHEN "110" => excREnc_uid169_block_rsrvd_fix_q <= "00";
                WHEN "111" => excREnc_uid169_block_rsrvd_fix_q <= "00";
                WHEN OTHERS => -- unreachable
                               excREnc_uid169_block_rsrvd_fix_q <= (others => '-');
            END CASE;
        END IF;
    END PROCESS;

    -- expRPostExc_uid178_block_rsrvd_fix(MUX,177)@26
    expRPostExc_uid178_block_rsrvd_fix_s <= excREnc_uid169_block_rsrvd_fix_q;
    expRPostExc_uid178_block_rsrvd_fix_combproc: PROCESS (expRPostExc_uid178_block_rsrvd_fix_s, cstAllZWE_uid13_block_rsrvd_fix_q, redist31_expRFinal_uid176_block_rsrvd_fix_b_2_q, cstAllOWE_uid11_block_rsrvd_fix_q)
    BEGIN
        CASE (expRPostExc_uid178_block_rsrvd_fix_s) IS
            WHEN "00" => expRPostExc_uid178_block_rsrvd_fix_q <= cstAllZWE_uid13_block_rsrvd_fix_q;
            WHEN "01" => expRPostExc_uid178_block_rsrvd_fix_q <= redist31_expRFinal_uid176_block_rsrvd_fix_b_2_q;
            WHEN "10" => expRPostExc_uid178_block_rsrvd_fix_q <= cstAllOWE_uid11_block_rsrvd_fix_q;
            WHEN "11" => expRPostExc_uid178_block_rsrvd_fix_q <= cstAllOWE_uid11_block_rsrvd_fix_q;
            WHEN OTHERS => expRPostExc_uid178_block_rsrvd_fix_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- oneFracRPostExc2_uid170_block_rsrvd_fix(CONSTANT,169)
    oneFracRPostExc2_uid170_block_rsrvd_fix_q <= "0000000000000000000000000000000000000000000000000001";

    -- fracRPreExc_uid121_block_rsrvd_fix(BITSELECT,120)@22
    fracRPreExc_uid121_block_rsrvd_fix_in <= fracRnd_uid120_block_rsrvd_fix_q(52 downto 0);
    fracRPreExc_uid121_block_rsrvd_fix_b <= fracRPreExc_uid121_block_rsrvd_fix_in(52 downto 1);

    -- redist35_fracRPreExc_uid121_block_rsrvd_fix_b_4_inputreg(DELAY,586)
    redist35_fracRPreExc_uid121_block_rsrvd_fix_b_4_inputreg : dspba_delay
    GENERIC MAP ( width => 52, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => fracRPreExc_uid121_block_rsrvd_fix_b, xout => redist35_fracRPreExc_uid121_block_rsrvd_fix_b_4_inputreg_q, clk => clock, aclr => resetn );

    -- redist35_fracRPreExc_uid121_block_rsrvd_fix_b_4(DELAY,522)
    redist35_fracRPreExc_uid121_block_rsrvd_fix_b_4 : dspba_delay
    GENERIC MAP ( width => 52, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist35_fracRPreExc_uid121_block_rsrvd_fix_b_4_inputreg_q, xout => redist35_fracRPreExc_uid121_block_rsrvd_fix_b_4_q, clk => clock, aclr => resetn );

    -- redist35_fracRPreExc_uid121_block_rsrvd_fix_b_4_outputreg(DELAY,587)
    redist35_fracRPreExc_uid121_block_rsrvd_fix_b_4_outputreg : dspba_delay
    GENERIC MAP ( width => 52, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist35_fracRPreExc_uid121_block_rsrvd_fix_b_4_q, xout => redist35_fracRPreExc_uid121_block_rsrvd_fix_b_4_outputreg_q, clk => clock, aclr => resetn );

    -- fracRPostExc_uid173_block_rsrvd_fix(MUX,172)@26
    fracRPostExc_uid173_block_rsrvd_fix_s <= excREnc_uid169_block_rsrvd_fix_q;
    fracRPostExc_uid173_block_rsrvd_fix_combproc: PROCESS (fracRPostExc_uid173_block_rsrvd_fix_s, cstZeroWF_uid12_block_rsrvd_fix_q, redist35_fracRPreExc_uid121_block_rsrvd_fix_b_4_outputreg_q, oneFracRPostExc2_uid170_block_rsrvd_fix_q)
    BEGIN
        CASE (fracRPostExc_uid173_block_rsrvd_fix_s) IS
            WHEN "00" => fracRPostExc_uid173_block_rsrvd_fix_q <= cstZeroWF_uid12_block_rsrvd_fix_q;
            WHEN "01" => fracRPostExc_uid173_block_rsrvd_fix_q <= redist35_fracRPreExc_uid121_block_rsrvd_fix_b_4_outputreg_q;
            WHEN "10" => fracRPostExc_uid173_block_rsrvd_fix_q <= cstZeroWF_uid12_block_rsrvd_fix_q;
            WHEN "11" => fracRPostExc_uid173_block_rsrvd_fix_q <= oneFracRPostExc2_uid170_block_rsrvd_fix_q;
            WHEN OTHERS => fracRPostExc_uid173_block_rsrvd_fix_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- R_uid181_block_rsrvd_fix(BITJOIN,180)@26
    R_uid181_block_rsrvd_fix_q <= signRPostExc_uid180_block_rsrvd_fix_q & expRPostExc_uid178_block_rsrvd_fix_q & fracRPostExc_uid173_block_rsrvd_fix_q;

    -- out_primWireOut(GPOUT,5)@26
    out_primWireOut <= R_uid181_block_rsrvd_fix_q;

END normal;
