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

-- VHDL created from readdata_reg_unnamed_matrix_multiply0_matrix_multiply0
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

entity readdata_reg_unnamed_matrix_multiply0_matrix_multiply0 is
    port (
        in_data_in : in std_logic_vector(63 downto 0);  -- float64_m52
        in_valid_in : in std_logic_vector(0 downto 0);  -- ufix1
        out_data_out : out std_logic_vector(63 downto 0);  -- float64_m52
        out_valid_out : out std_logic_vector(0 downto 0);  -- ufix1
        in_stall_in : in std_logic_vector(0 downto 0);  -- ufix1
        out_stall_out : out std_logic_vector(0 downto 0);  -- ufix1
        clock : in std_logic;
        resetn : in std_logic
    );
end readdata_reg_unnamed_matrix_multiply0_matrix_multiply0;

architecture normal of readdata_reg_unnamed_matrix_multiply0_matrix_multiply0 is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal readdata_reg_unnamed_matrix_multiply0_matrix_multiply0_data_reg_q : STD_LOGIC_VECTOR (63 downto 0);
    signal readdata_reg_unnamed_matrix_multiply0_matrix_multiply0_valid_reg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal readdata_reg_unnamed_matrix_multiply0_matrix_multiply0_valid_reg_and_stall_in_q : STD_LOGIC_VECTOR (0 downto 0);
    signal readdata_reg_unnamed_matrix_multiply0_matrix_multiply0_valid_reg_not_q : STD_LOGIC_VECTOR (0 downto 0);
    signal stall_in_not_q : STD_LOGIC_VECTOR (0 downto 0);
    signal stall_in_not_or_readdata_reg_unnamed_matrix_multiply0_matrix_multiply0_valid_reg_q : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- stall_in_not(LOGICAL,8)
    stall_in_not_q <= not (in_stall_in);

    -- readdata_reg_unnamed_matrix_multiply0_matrix_multiply0_valid_reg_not(LOGICAL,7)
    readdata_reg_unnamed_matrix_multiply0_matrix_multiply0_valid_reg_not_q <= not (readdata_reg_unnamed_matrix_multiply0_matrix_multiply0_valid_reg_q);

    -- stall_in_not_or_readdata_reg_unnamed_matrix_multiply0_matrix_multiply0_valid_reg(LOGICAL,9)
    stall_in_not_or_readdata_reg_unnamed_matrix_multiply0_matrix_multiply0_valid_reg_q <= readdata_reg_unnamed_matrix_multiply0_matrix_multiply0_valid_reg_not_q or stall_in_not_q;

    -- readdata_reg_unnamed_matrix_multiply0_matrix_multiply0_valid_reg(REG,5)
    readdata_reg_unnamed_matrix_multiply0_matrix_multiply0_valid_reg_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            readdata_reg_unnamed_matrix_multiply0_matrix_multiply0_valid_reg_q <= "0";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (stall_in_not_or_readdata_reg_unnamed_matrix_multiply0_matrix_multiply0_valid_reg_q = "1") THEN
                readdata_reg_unnamed_matrix_multiply0_matrix_multiply0_valid_reg_q <= in_valid_in;
            END IF;
        END IF;
    END PROCESS;

    -- readdata_reg_unnamed_matrix_multiply0_matrix_multiply0_data_reg(REG,4)
    readdata_reg_unnamed_matrix_multiply0_matrix_multiply0_data_reg_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            readdata_reg_unnamed_matrix_multiply0_matrix_multiply0_data_reg_q <= "0000000000000000000000000000000000000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (stall_in_not_or_readdata_reg_unnamed_matrix_multiply0_matrix_multiply0_valid_reg_q = "1") THEN
                readdata_reg_unnamed_matrix_multiply0_matrix_multiply0_data_reg_q <= STD_LOGIC_VECTOR(in_data_in);
            END IF;
        END IF;
    END PROCESS;

    -- dupName_0_sync_out_x(GPOUT,3)@20000001
    out_data_out <= readdata_reg_unnamed_matrix_multiply0_matrix_multiply0_data_reg_q;
    out_valid_out <= readdata_reg_unnamed_matrix_multiply0_matrix_multiply0_valid_reg_q;

    -- readdata_reg_unnamed_matrix_multiply0_matrix_multiply0_valid_reg_and_stall_in(LOGICAL,6)
    readdata_reg_unnamed_matrix_multiply0_matrix_multiply0_valid_reg_and_stall_in_q <= readdata_reg_unnamed_matrix_multiply0_matrix_multiply0_valid_reg_q and in_stall_in;

    -- sync_out(GPOUT,11)@20000000
    out_stall_out <= readdata_reg_unnamed_matrix_multiply0_matrix_multiply0_valid_reg_and_stall_in_q;

END normal;
