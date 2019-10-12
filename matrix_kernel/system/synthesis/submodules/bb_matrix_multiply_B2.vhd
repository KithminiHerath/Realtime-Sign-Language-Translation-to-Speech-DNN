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

-- VHDL created from bb_matrix_multiply_B2
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

entity bb_matrix_multiply_B2 is
    port (
        in_C : in std_logic_vector(63 downto 0);  -- ufix64
        in_D : in std_logic_vector(63 downto 0);  -- ufix64
        in_N : in std_logic_vector(31 downto 0);  -- ufix32
        in_P : in std_logic_vector(31 downto 0);  -- ufix32
        in_acl_hw_wg_id5_0 : in std_logic_vector(31 downto 0);  -- ufix32
        in_c0_exe1102_0 : in std_logic_vector(63 downto 0);  -- float64_m52
        in_flush : in std_logic_vector(0 downto 0);  -- ufix1
        in_global_id_03_0 : in std_logic_vector(31 downto 0);  -- ufix32
        in_stall_in_0 : in std_logic_vector(0 downto 0);  -- ufix1
        in_unnamed_matrix_multiply2_avm_readdata : in std_logic_vector(255 downto 0);  -- ufix256
        in_unnamed_matrix_multiply2_avm_readdatavalid : in std_logic_vector(0 downto 0);  -- ufix1
        in_unnamed_matrix_multiply2_avm_waitrequest : in std_logic_vector(0 downto 0);  -- ufix1
        in_unnamed_matrix_multiply2_avm_writeack : in std_logic_vector(0 downto 0);  -- ufix1
        in_unnamed_matrix_multiply3_avm_readdata : in std_logic_vector(255 downto 0);  -- ufix256
        in_unnamed_matrix_multiply3_avm_readdatavalid : in std_logic_vector(0 downto 0);  -- ufix1
        in_unnamed_matrix_multiply3_avm_waitrequest : in std_logic_vector(0 downto 0);  -- ufix1
        in_unnamed_matrix_multiply3_avm_writeack : in std_logic_vector(0 downto 0);  -- ufix1
        in_valid_in_0 : in std_logic_vector(0 downto 0);  -- ufix1
        out_acl_hw_wg_id5 : out std_logic_vector(31 downto 0);  -- ufix32
        out_lsu_unnamed_matrix_multiply3_o_active : out std_logic_vector(0 downto 0);  -- ufix1
        out_stall_out_0 : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_matrix_multiply2_avm_address : out std_logic_vector(29 downto 0);  -- ufix30
        out_unnamed_matrix_multiply2_avm_burstcount : out std_logic_vector(4 downto 0);  -- ufix5
        out_unnamed_matrix_multiply2_avm_byteenable : out std_logic_vector(31 downto 0);  -- ufix32
        out_unnamed_matrix_multiply2_avm_enable : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_matrix_multiply2_avm_read : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_matrix_multiply2_avm_write : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_matrix_multiply2_avm_writedata : out std_logic_vector(255 downto 0);  -- ufix256
        out_unnamed_matrix_multiply3_avm_address : out std_logic_vector(29 downto 0);  -- ufix30
        out_unnamed_matrix_multiply3_avm_burstcount : out std_logic_vector(4 downto 0);  -- ufix5
        out_unnamed_matrix_multiply3_avm_byteenable : out std_logic_vector(31 downto 0);  -- ufix32
        out_unnamed_matrix_multiply3_avm_enable : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_matrix_multiply3_avm_read : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_matrix_multiply3_avm_write : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_matrix_multiply3_avm_writedata : out std_logic_vector(255 downto 0);  -- ufix256
        out_valid_out_0 : out std_logic_vector(0 downto 0);  -- ufix1
        clock : in std_logic;
        resetn : in std_logic
    );
end bb_matrix_multiply_B2;

architecture normal of bb_matrix_multiply_B2 is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    component bb_matrix_multiply_B2_stall_region is
        port (
            in_C : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_D : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_N : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_P : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_acl_hw_wg_id5 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_c0_exe1102 : in std_logic_vector(63 downto 0);  -- Floating Point
            in_flush : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_global_id_03 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
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
            out_lsu_unnamed_matrix_multiply3_o_active : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
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


    component matrix_multiply_B2_branch is
        port (
            in_acl_hw_wg_id5 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_stall_in_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_acl_hw_wg_id5 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component matrix_multiply_B2_merge is
        port (
            in_acl_hw_wg_id5_0 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_c0_exe1102_0 : in std_logic_vector(63 downto 0);  -- Floating Point
            in_global_id_03_0 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_acl_hw_wg_id5 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_c0_exe1102 : out std_logic_vector(63 downto 0);  -- Floating Point
            out_global_id_03 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_stall_out_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    signal bb_matrix_multiply_B2_stall_region_out_acl_hw_wg_id5 : STD_LOGIC_VECTOR (31 downto 0);
    signal bb_matrix_multiply_B2_stall_region_out_lsu_unnamed_matrix_multiply3_o_active : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_matrix_multiply_B2_stall_region_out_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_matrix_multiply_B2_stall_region_out_unnamed_matrix_multiply2_avm_address : STD_LOGIC_VECTOR (29 downto 0);
    signal bb_matrix_multiply_B2_stall_region_out_unnamed_matrix_multiply2_avm_burstcount : STD_LOGIC_VECTOR (4 downto 0);
    signal bb_matrix_multiply_B2_stall_region_out_unnamed_matrix_multiply2_avm_byteenable : STD_LOGIC_VECTOR (31 downto 0);
    signal bb_matrix_multiply_B2_stall_region_out_unnamed_matrix_multiply2_avm_enable : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_matrix_multiply_B2_stall_region_out_unnamed_matrix_multiply2_avm_read : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_matrix_multiply_B2_stall_region_out_unnamed_matrix_multiply2_avm_write : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_matrix_multiply_B2_stall_region_out_unnamed_matrix_multiply2_avm_writedata : STD_LOGIC_VECTOR (255 downto 0);
    signal bb_matrix_multiply_B2_stall_region_out_unnamed_matrix_multiply3_avm_address : STD_LOGIC_VECTOR (29 downto 0);
    signal bb_matrix_multiply_B2_stall_region_out_unnamed_matrix_multiply3_avm_burstcount : STD_LOGIC_VECTOR (4 downto 0);
    signal bb_matrix_multiply_B2_stall_region_out_unnamed_matrix_multiply3_avm_byteenable : STD_LOGIC_VECTOR (31 downto 0);
    signal bb_matrix_multiply_B2_stall_region_out_unnamed_matrix_multiply3_avm_enable : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_matrix_multiply_B2_stall_region_out_unnamed_matrix_multiply3_avm_read : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_matrix_multiply_B2_stall_region_out_unnamed_matrix_multiply3_avm_write : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_matrix_multiply_B2_stall_region_out_unnamed_matrix_multiply3_avm_writedata : STD_LOGIC_VECTOR (255 downto 0);
    signal bb_matrix_multiply_B2_stall_region_out_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal matrix_multiply_B2_branch_out_acl_hw_wg_id5 : STD_LOGIC_VECTOR (31 downto 0);
    signal matrix_multiply_B2_branch_out_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal matrix_multiply_B2_branch_out_valid_out_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal matrix_multiply_B2_merge_out_acl_hw_wg_id5 : STD_LOGIC_VECTOR (31 downto 0);
    signal matrix_multiply_B2_merge_out_c0_exe1102 : STD_LOGIC_VECTOR (63 downto 0);
    signal matrix_multiply_B2_merge_out_global_id_03 : STD_LOGIC_VECTOR (31 downto 0);
    signal matrix_multiply_B2_merge_out_stall_out_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal matrix_multiply_B2_merge_out_valid_out : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- matrix_multiply_B2_merge(BLACKBOX,22)
    thematrix_multiply_B2_merge : matrix_multiply_B2_merge
    PORT MAP (
        in_acl_hw_wg_id5_0 => in_acl_hw_wg_id5_0,
        in_c0_exe1102_0 => in_c0_exe1102_0,
        in_global_id_03_0 => in_global_id_03_0,
        in_stall_in => bb_matrix_multiply_B2_stall_region_out_stall_out,
        in_valid_in_0 => in_valid_in_0,
        out_acl_hw_wg_id5 => matrix_multiply_B2_merge_out_acl_hw_wg_id5,
        out_c0_exe1102 => matrix_multiply_B2_merge_out_c0_exe1102,
        out_global_id_03 => matrix_multiply_B2_merge_out_global_id_03,
        out_stall_out_0 => matrix_multiply_B2_merge_out_stall_out_0,
        out_valid_out => matrix_multiply_B2_merge_out_valid_out,
        clock => clock,
        resetn => resetn
    );

    -- bb_matrix_multiply_B2_stall_region(BLACKBOX,2)
    thebb_matrix_multiply_B2_stall_region : bb_matrix_multiply_B2_stall_region
    PORT MAP (
        in_C => in_C,
        in_D => in_D,
        in_N => in_N,
        in_P => in_P,
        in_acl_hw_wg_id5 => matrix_multiply_B2_merge_out_acl_hw_wg_id5,
        in_c0_exe1102 => matrix_multiply_B2_merge_out_c0_exe1102,
        in_flush => in_flush,
        in_global_id_03 => matrix_multiply_B2_merge_out_global_id_03,
        in_stall_in => matrix_multiply_B2_branch_out_stall_out,
        in_unnamed_matrix_multiply2_avm_readdata => in_unnamed_matrix_multiply2_avm_readdata,
        in_unnamed_matrix_multiply2_avm_readdatavalid => in_unnamed_matrix_multiply2_avm_readdatavalid,
        in_unnamed_matrix_multiply2_avm_waitrequest => in_unnamed_matrix_multiply2_avm_waitrequest,
        in_unnamed_matrix_multiply2_avm_writeack => in_unnamed_matrix_multiply2_avm_writeack,
        in_unnamed_matrix_multiply3_avm_readdata => in_unnamed_matrix_multiply3_avm_readdata,
        in_unnamed_matrix_multiply3_avm_readdatavalid => in_unnamed_matrix_multiply3_avm_readdatavalid,
        in_unnamed_matrix_multiply3_avm_waitrequest => in_unnamed_matrix_multiply3_avm_waitrequest,
        in_unnamed_matrix_multiply3_avm_writeack => in_unnamed_matrix_multiply3_avm_writeack,
        in_valid_in => matrix_multiply_B2_merge_out_valid_out,
        out_acl_hw_wg_id5 => bb_matrix_multiply_B2_stall_region_out_acl_hw_wg_id5,
        out_lsu_unnamed_matrix_multiply3_o_active => bb_matrix_multiply_B2_stall_region_out_lsu_unnamed_matrix_multiply3_o_active,
        out_stall_out => bb_matrix_multiply_B2_stall_region_out_stall_out,
        out_unnamed_matrix_multiply2_avm_address => bb_matrix_multiply_B2_stall_region_out_unnamed_matrix_multiply2_avm_address,
        out_unnamed_matrix_multiply2_avm_burstcount => bb_matrix_multiply_B2_stall_region_out_unnamed_matrix_multiply2_avm_burstcount,
        out_unnamed_matrix_multiply2_avm_byteenable => bb_matrix_multiply_B2_stall_region_out_unnamed_matrix_multiply2_avm_byteenable,
        out_unnamed_matrix_multiply2_avm_enable => bb_matrix_multiply_B2_stall_region_out_unnamed_matrix_multiply2_avm_enable,
        out_unnamed_matrix_multiply2_avm_read => bb_matrix_multiply_B2_stall_region_out_unnamed_matrix_multiply2_avm_read,
        out_unnamed_matrix_multiply2_avm_write => bb_matrix_multiply_B2_stall_region_out_unnamed_matrix_multiply2_avm_write,
        out_unnamed_matrix_multiply2_avm_writedata => bb_matrix_multiply_B2_stall_region_out_unnamed_matrix_multiply2_avm_writedata,
        out_unnamed_matrix_multiply3_avm_address => bb_matrix_multiply_B2_stall_region_out_unnamed_matrix_multiply3_avm_address,
        out_unnamed_matrix_multiply3_avm_burstcount => bb_matrix_multiply_B2_stall_region_out_unnamed_matrix_multiply3_avm_burstcount,
        out_unnamed_matrix_multiply3_avm_byteenable => bb_matrix_multiply_B2_stall_region_out_unnamed_matrix_multiply3_avm_byteenable,
        out_unnamed_matrix_multiply3_avm_enable => bb_matrix_multiply_B2_stall_region_out_unnamed_matrix_multiply3_avm_enable,
        out_unnamed_matrix_multiply3_avm_read => bb_matrix_multiply_B2_stall_region_out_unnamed_matrix_multiply3_avm_read,
        out_unnamed_matrix_multiply3_avm_write => bb_matrix_multiply_B2_stall_region_out_unnamed_matrix_multiply3_avm_write,
        out_unnamed_matrix_multiply3_avm_writedata => bb_matrix_multiply_B2_stall_region_out_unnamed_matrix_multiply3_avm_writedata,
        out_valid_out => bb_matrix_multiply_B2_stall_region_out_valid_out,
        clock => clock,
        resetn => resetn
    );

    -- matrix_multiply_B2_branch(BLACKBOX,21)
    thematrix_multiply_B2_branch : matrix_multiply_B2_branch
    PORT MAP (
        in_acl_hw_wg_id5 => bb_matrix_multiply_B2_stall_region_out_acl_hw_wg_id5,
        in_stall_in_0 => in_stall_in_0,
        in_valid_in => bb_matrix_multiply_B2_stall_region_out_valid_out,
        out_acl_hw_wg_id5 => matrix_multiply_B2_branch_out_acl_hw_wg_id5,
        out_stall_out => matrix_multiply_B2_branch_out_stall_out,
        out_valid_out_0 => matrix_multiply_B2_branch_out_valid_out_0,
        clock => clock,
        resetn => resetn
    );

    -- out_acl_hw_wg_id5(GPOUT,23)
    out_acl_hw_wg_id5 <= matrix_multiply_B2_branch_out_acl_hw_wg_id5;

    -- out_lsu_unnamed_matrix_multiply3_o_active(GPOUT,24)
    out_lsu_unnamed_matrix_multiply3_o_active <= bb_matrix_multiply_B2_stall_region_out_lsu_unnamed_matrix_multiply3_o_active;

    -- out_stall_out_0(GPOUT,25)
    out_stall_out_0 <= matrix_multiply_B2_merge_out_stall_out_0;

    -- out_unnamed_matrix_multiply2_avm_address(GPOUT,26)
    out_unnamed_matrix_multiply2_avm_address <= bb_matrix_multiply_B2_stall_region_out_unnamed_matrix_multiply2_avm_address;

    -- out_unnamed_matrix_multiply2_avm_burstcount(GPOUT,27)
    out_unnamed_matrix_multiply2_avm_burstcount <= bb_matrix_multiply_B2_stall_region_out_unnamed_matrix_multiply2_avm_burstcount;

    -- out_unnamed_matrix_multiply2_avm_byteenable(GPOUT,28)
    out_unnamed_matrix_multiply2_avm_byteenable <= bb_matrix_multiply_B2_stall_region_out_unnamed_matrix_multiply2_avm_byteenable;

    -- out_unnamed_matrix_multiply2_avm_enable(GPOUT,29)
    out_unnamed_matrix_multiply2_avm_enable <= bb_matrix_multiply_B2_stall_region_out_unnamed_matrix_multiply2_avm_enable;

    -- out_unnamed_matrix_multiply2_avm_read(GPOUT,30)
    out_unnamed_matrix_multiply2_avm_read <= bb_matrix_multiply_B2_stall_region_out_unnamed_matrix_multiply2_avm_read;

    -- out_unnamed_matrix_multiply2_avm_write(GPOUT,31)
    out_unnamed_matrix_multiply2_avm_write <= bb_matrix_multiply_B2_stall_region_out_unnamed_matrix_multiply2_avm_write;

    -- out_unnamed_matrix_multiply2_avm_writedata(GPOUT,32)
    out_unnamed_matrix_multiply2_avm_writedata <= bb_matrix_multiply_B2_stall_region_out_unnamed_matrix_multiply2_avm_writedata;

    -- out_unnamed_matrix_multiply3_avm_address(GPOUT,33)
    out_unnamed_matrix_multiply3_avm_address <= bb_matrix_multiply_B2_stall_region_out_unnamed_matrix_multiply3_avm_address;

    -- out_unnamed_matrix_multiply3_avm_burstcount(GPOUT,34)
    out_unnamed_matrix_multiply3_avm_burstcount <= bb_matrix_multiply_B2_stall_region_out_unnamed_matrix_multiply3_avm_burstcount;

    -- out_unnamed_matrix_multiply3_avm_byteenable(GPOUT,35)
    out_unnamed_matrix_multiply3_avm_byteenable <= bb_matrix_multiply_B2_stall_region_out_unnamed_matrix_multiply3_avm_byteenable;

    -- out_unnamed_matrix_multiply3_avm_enable(GPOUT,36)
    out_unnamed_matrix_multiply3_avm_enable <= bb_matrix_multiply_B2_stall_region_out_unnamed_matrix_multiply3_avm_enable;

    -- out_unnamed_matrix_multiply3_avm_read(GPOUT,37)
    out_unnamed_matrix_multiply3_avm_read <= bb_matrix_multiply_B2_stall_region_out_unnamed_matrix_multiply3_avm_read;

    -- out_unnamed_matrix_multiply3_avm_write(GPOUT,38)
    out_unnamed_matrix_multiply3_avm_write <= bb_matrix_multiply_B2_stall_region_out_unnamed_matrix_multiply3_avm_write;

    -- out_unnamed_matrix_multiply3_avm_writedata(GPOUT,39)
    out_unnamed_matrix_multiply3_avm_writedata <= bb_matrix_multiply_B2_stall_region_out_unnamed_matrix_multiply3_avm_writedata;

    -- out_valid_out_0(GPOUT,40)
    out_valid_out_0 <= matrix_multiply_B2_branch_out_valid_out_0;

END normal;
