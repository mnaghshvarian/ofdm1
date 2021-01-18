-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\OFDM_rx\hdlsrc\OFDM_Tx_Rx_HW\ofdm_rx_src_ControlSigGen.vhd
-- Created: 2021-01-08 12:41:57
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ofdm_rx_src_ControlSigGen
-- Source Path: OFDM_Tx_Rx_HW/OFDMRx/Synchronisation/ControlSigGen
-- Hierarchy Level: 2
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ofdm_rx_src_ControlSigGen IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb_1_192_0                       :   IN    std_logic;
        validIn                           :   IN    std_logic;
        FFTValid                          :   OUT   std_logic;
        dataValid                         :   OUT   std_logic;
        preambleValid                     :   OUT   std_logic
        );
END ofdm_rx_src_ControlSigGen;


ARCHITECTURE rtl OF ofdm_rx_src_ControlSigGen IS

  -- Component Declarations
  COMPONENT ofdm_rx_src_PreambleValidGen
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_192_0                     :   IN    std_logic;
          ValidIn                         :   IN    std_logic;
          y                               :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT ofdm_rx_src_dataValidGen_block
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_192_0                     :   IN    std_logic;
          enb                             :   IN    std_logic;
          enb1                            :   IN    std_logic;
          y                               :   OUT   std_logic
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : ofdm_rx_src_PreambleValidGen
    USE ENTITY work.ofdm_rx_src_PreambleValidGen(rtl);

  FOR ALL : ofdm_rx_src_dataValidGen_block
    USE ENTITY work.ofdm_rx_src_dataValidGen_block(rtl);

  -- Signals
  SIGNAL PreambleValidGen_out1            : std_logic;
  SIGNAL dataValidGen_out1                : std_logic;
  SIGNAL OR_out1                          : std_logic;

BEGIN
  u_PreambleValidGen : ofdm_rx_src_PreambleValidGen
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_192_0 => enb_1_192_0,
              ValidIn => validIn,
              y => PreambleValidGen_out1
              );

  u_dataValidGen : ofdm_rx_src_dataValidGen_block
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_192_0 => enb_1_192_0,
              enb => PreambleValidGen_out1,
              enb1 => validIn,
              y => dataValidGen_out1
              );

  OR_out1 <= PreambleValidGen_out1 OR dataValidGen_out1;

  FFTValid <= OR_out1;

  dataValid <= dataValidGen_out1;

  preambleValid <= PreambleValidGen_out1;

END rtl;
