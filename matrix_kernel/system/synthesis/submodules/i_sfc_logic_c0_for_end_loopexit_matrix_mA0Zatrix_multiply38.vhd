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

-- VHDL created from i_sfc_logic_c0_for_end_loopexit_matrix_multiply_c0_enter14_matrix_multiply38
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

entity i_sfc_logic_c0_for_end_loopexit_matrix_multiply_c0_enter14_matrix_multiply38 is
    port (
        in_P : in std_logic_vector(31 downto 0);  -- ufix32
        in_c0_eni313_0 : in std_logic_vector(0 downto 0);  -- ufix1
        in_c0_eni313_1 : in std_logic_vector(0 downto 0);  -- ufix1
        in_c0_eni313_2 : in std_logic_vector(63 downto 0);  -- float64_m52
        in_c0_eni313_3 : in std_logic_vector(63 downto 0);  -- float64_m52
        in_i_valid : in std_logic_vector(0 downto 0);  -- ufix1
        out_c0_exi118_0 : out std_logic_vector(0 downto 0);  -- ufix1
        out_c0_exi118_1 : out std_logic_vector(63 downto 0);  -- float64_m52
        out_o_valid : out std_logic_vector(0 downto 0);  -- ufix1
        clock : in std_logic;
        resetn : in std_logic
    );
end i_sfc_logic_c0_for_end_loopexit_matrix_multiply_c0_enter14_matrix_multiply38;

architecture normal of i_sfc_logic_c0_for_end_loopexit_matrix_multiply_c0_enter14_matrix_multiply38 is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    component floatComponent_i_sfc_logic_c0_for_end_loopexit_matrix_multiply_c0_enter14_matrixA0Z0ocfd0j60ocqd006ou0z is
        port (
            in_0 : in std_logic_vector(63 downto 0);  -- Floating Point
            in_1 : in std_logic_vector(63 downto 0);  -- Floating Point
            out_primWireOut : out std_logic_vector(63 downto 0);  -- Floating Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_syncbuf_p_sync_buffer2_matrix_multiply40 is
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


    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal c_double_0_000000e_00_q : STD_LOGIC_VECTOR (63 downto 0);
    signal c_i32_0gr_q : STD_LOGIC_VECTOR (31 downto 0);
    signal i_add10_matrix_multiply_out_primWireOut : STD_LOGIC_VECTOR (63 downto 0);
    signal i_cmp21_rm16_matrix_multiply_a : STD_LOGIC_VECTOR (33 downto 0);
    signal i_cmp21_rm16_matrix_multiply_b : STD_LOGIC_VECTOR (33 downto 0);
    signal i_cmp21_rm16_matrix_multiply_o : STD_LOGIC_VECTOR (33 downto 0);
    signal i_cmp21_rm16_matrix_multiply_c : STD_LOGIC_VECTOR (0 downto 0);
    signal i_do_directly_for_end_loopexit_sel12_matrix_multiply_q : STD_LOGIC_VECTOR (0 downto 0);
    signal i_select4_matrix_multiply_s : STD_LOGIC_VECTOR (0 downto 0);
    signal i_select4_matrix_multiply_q : STD_LOGIC_VECTOR (63 downto 0);
    signal i_syncbuf_p_sync_buffer2_matrix_multiply_out_buffer_out : STD_LOGIC_VECTOR (31 downto 0);
    signal redist0_sync_in_aunroll_x_in_c0_eni313_1_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist1_sync_in_aunroll_x_in_c0_eni313_2_1_q : STD_LOGIC_VECTOR (63 downto 0);
    signal redist2_sync_in_aunroll_x_in_c0_eni313_3_2_q : STD_LOGIC_VECTOR (63 downto 0);
    signal redist3_sync_in_aunroll_x_in_i_valid_22_q : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- redist3_sync_in_aunroll_x_in_i_valid_22(DELAY,17)
    redist3_sync_in_aunroll_x_in_i_valid_22 : dspba_delay
    GENERIC MAP ( width => 1, depth => 22, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => in_i_valid, xout => redist3_sync_in_aunroll_x_in_i_valid_22_q, clk => clock, aclr => resetn );

    -- redist2_sync_in_aunroll_x_in_c0_eni313_3_2(DELAY,16)
    redist2_sync_in_aunroll_x_in_c0_eni313_3_2 : dspba_delay
    GENERIC MAP ( width => 64, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => in_c0_eni313_3, xout => redist2_sync_in_aunroll_x_in_c0_eni313_3_2_q, clk => clock, aclr => resetn );

    -- redist1_sync_in_aunroll_x_in_c0_eni313_2_1(DELAY,15)
    redist1_sync_in_aunroll_x_in_c0_eni313_2_1 : dspba_delay
    GENERIC MAP ( width => 64, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => in_c0_eni313_2, xout => redist1_sync_in_aunroll_x_in_c0_eni313_2_1_q, clk => clock, aclr => resetn );

    -- c_double_0_000000e_00(FLOATCONSTANT,4)
    c_double_0_000000e_00_q <= "0000000000000000000000000000000000000000000000000000000000000000";

    -- i_syncbuf_p_sync_buffer2_matrix_multiply(BLACKBOX,11)@0
    -- in in_i_dependence@120
    -- in in_valid_in@120
    -- out out_buffer_out@120
    -- out out_valid_out@120
    thei_syncbuf_p_sync_buffer2_matrix_multiply : i_syncbuf_p_sync_buffer2_matrix_multiply40
    PORT MAP (
        in_buffer_in => in_P,
        in_i_dependence => GND_q,
        in_stall_in => GND_q,
        in_valid_in => in_i_valid,
        out_buffer_out => i_syncbuf_p_sync_buffer2_matrix_multiply_out_buffer_out,
        clock => clock,
        resetn => resetn
    );

    -- c_i32_0gr(CONSTANT,6)
    c_i32_0gr_q <= "00000000000000000000000000000000";

    -- i_cmp21_rm16_matrix_multiply(COMPARE,8)@120 + 1
    i_cmp21_rm16_matrix_multiply_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 32 => c_i32_0gr_q(31)) & c_i32_0gr_q));
    i_cmp21_rm16_matrix_multiply_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((33 downto 32 => i_syncbuf_p_sync_buffer2_matrix_multiply_out_buffer_out(31)) & i_syncbuf_p_sync_buffer2_matrix_multiply_out_buffer_out));
    i_cmp21_rm16_matrix_multiply_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            i_cmp21_rm16_matrix_multiply_o <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            i_cmp21_rm16_matrix_multiply_o <= STD_LOGIC_VECTOR(SIGNED(i_cmp21_rm16_matrix_multiply_a) - SIGNED(i_cmp21_rm16_matrix_multiply_b));
        END IF;
    END PROCESS;
    i_cmp21_rm16_matrix_multiply_c(0) <= i_cmp21_rm16_matrix_multiply_o(33);

    -- redist0_sync_in_aunroll_x_in_c0_eni313_1_1(DELAY,14)
    redist0_sync_in_aunroll_x_in_c0_eni313_1_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => in_c0_eni313_1, xout => redist0_sync_in_aunroll_x_in_c0_eni313_1_1_q, clk => clock, aclr => resetn );

    -- i_do_directly_for_end_loopexit_sel12_matrix_multiply(LOGICAL,9)@121
    i_do_directly_for_end_loopexit_sel12_matrix_multiply_q <= redist0_sync_in_aunroll_x_in_c0_eni313_1_1_q and i_cmp21_rm16_matrix_multiply_c;

    -- i_select4_matrix_multiply(MUX,10)@121 + 1
    i_select4_matrix_multiply_s <= i_do_directly_for_end_loopexit_sel12_matrix_multiply_q;
    i_select4_matrix_multiply_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            i_select4_matrix_multiply_q <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            CASE (i_select4_matrix_multiply_s) IS
                WHEN "0" => i_select4_matrix_multiply_q <= c_double_0_000000e_00_q;
                WHEN "1" => i_select4_matrix_multiply_q <= redist1_sync_in_aunroll_x_in_c0_eni313_2_1_q;
                WHEN OTHERS => i_select4_matrix_multiply_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- i_add10_matrix_multiply(BLACKBOX,7)@122
    -- out out_primWireOut@142
    thei_add10_matrix_multiply : floatComponent_i_sfc_logic_c0_for_end_loopexit_matrix_multiply_c0_enter14_matrixA0Z0ocfd0j60ocqd006ou0z
    PORT MAP (
        in_0 => i_select4_matrix_multiply_q,
        in_1 => redist2_sync_in_aunroll_x_in_c0_eni313_3_2_q,
        out_primWireOut => i_add10_matrix_multiply_out_primWireOut,
        clock => clock,
        resetn => resetn
    );

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- sync_out_aunroll_x(GPOUT,3)@142
    out_c0_exi118_0 <= GND_q;
    out_c0_exi118_1 <= i_add10_matrix_multiply_out_primWireOut;
    out_o_valid <= redist3_sync_in_aunroll_x_in_i_valid_22_q;

END normal;
