-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\OFDM_rx\hdlsrc\OFDM_Tx_Rx_HW\ofdm_rx_dut.vhd
-- Created: 2021-01-08 12:42:01
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ofdm_rx_dut
-- Source Path: ofdm_rx/ofdm_rx_dut
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ofdm_rx_dut IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        dut_enable                        :   IN    std_logic;  -- ufix1
        s_axis_re_tdata                   :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        s_axis_im_tdata                   :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        ce_out                            :   OUT   std_logic;  -- ufix1
        m_axis_re_tdata                   :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        m_axis_re_tvalid                  :   OUT   std_logic;  -- ufix1
        m_axis_im_tdata                   :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        m_axis_im_tvalid                  :   OUT   std_logic  -- ufix1
        );
END ofdm_rx_dut;


ARCHITECTURE rtl OF ofdm_rx_dut IS

  -- Component Declarations
  COMPONENT ofdm_rx_src_OFDMRx
    PORT( clk                             :   IN    std_logic;
          clk_enable                      :   IN    std_logic;
          reset                           :   IN    std_logic;
          s_axis_re_tdata                 :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          s_axis_im_tdata                 :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          ce_out                          :   OUT   std_logic;  -- ufix1
          m_axis_re_tdata                 :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          m_axis_re_tvalid                :   OUT   std_logic;  -- ufix1
          m_axis_im_tdata                 :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          m_axis_im_tvalid                :   OUT   std_logic  -- ufix1
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : ofdm_rx_src_OFDMRx
    USE ENTITY work.ofdm_rx_src_OFDMRx(rtl);

  -- Signals
  SIGNAL enb                              : std_logic;
  SIGNAL ce_out_sig                       : std_logic;  -- ufix1
  SIGNAL m_axis_re_tdata_sig              : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL m_axis_re_tvalid_sig             : std_logic;  -- ufix1
  SIGNAL m_axis_im_tdata_sig              : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL m_axis_im_tvalid_sig             : std_logic;  -- ufix1

BEGIN
  u_ofdm_rx_src_OFDMRx : ofdm_rx_src_OFDMRx
    PORT MAP( clk => clk,
              clk_enable => enb,
              reset => reset,
              s_axis_re_tdata => s_axis_re_tdata,  -- sfix16_En14
              s_axis_im_tdata => s_axis_im_tdata,  -- sfix16_En14
              ce_out => ce_out_sig,  -- ufix1
              m_axis_re_tdata => m_axis_re_tdata_sig,  -- sfix16_En14
              m_axis_re_tvalid => m_axis_re_tvalid_sig,  -- ufix1
              m_axis_im_tdata => m_axis_im_tdata_sig,  -- sfix16_En14
              m_axis_im_tvalid => m_axis_im_tvalid_sig  -- ufix1
              );

  enb <= dut_enable;

  ce_out <= ce_out_sig;

  m_axis_re_tdata <= m_axis_re_tdata_sig;

  m_axis_re_tvalid <= m_axis_re_tvalid_sig;

  m_axis_im_tdata <= m_axis_im_tdata_sig;

  m_axis_im_tvalid <= m_axis_im_tvalid_sig;

END rtl;
