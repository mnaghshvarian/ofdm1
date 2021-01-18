-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\OFDM_tx\hdlsrc\OFDM_Tx_Rx_HW\ofdm_tx_src_CPAdd.vhd
-- Created: 2021-01-08 12:14:22
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ofdm_tx_src_CPAdd
-- Source Path: OFDM_Tx_Rx_HW/OFDMTx/CPAdd
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ofdm_tx_src_CPAdd IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb_1_192_0                       :   IN    std_logic;
        dataIn_re                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        dataIn_im                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        preambValid                       :   IN    std_logic;
        dataValid                         :   IN    std_logic;
        dataOut_re                        :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        dataOut_im                        :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En14
        );
END ofdm_tx_src_CPAdd;


ARCHITECTURE rtl OF ofdm_tx_src_CPAdd IS

  -- Component Declarations
  COMPONENT ofdm_tx_src_STFExtend
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_192_0                     :   IN    std_logic;
          data_re                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          data_im                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          preambVal                       :   IN    std_logic;
          STFExtendOut_re                 :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          STFExtendOut_im                 :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          STFValidOut                     :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT ofdm_tx_src_LTFExtend
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_192_0                     :   IN    std_logic;
          data_re                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          data_im                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          preambVal                       :   IN    std_logic;
          LTFExtendOut_re                 :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          LTFExtendOut_im                 :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          LTFValidOut                     :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT ofdm_tx_src_DataExtend
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_192_0                     :   IN    std_logic;
          dataIn_re                       :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          dataIn_im                       :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          dataValid                       :   IN    std_logic;
          dataOut_re                      :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          dataOut_im                      :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          dataValidOut                    :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT ofdm_tx_src_Mux2
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_192_0                     :   IN    std_logic;
          sts_re                          :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          sts_im                          :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          stsval                          :   IN    std_logic;
          lts_re                          :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          lts_im                          :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          ltsval                          :   IN    std_logic;
          data_re                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          data_im                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          dataval                         :   IN    std_logic;
          dataOut_re                      :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          dataOut_im                      :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En14
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : ofdm_tx_src_STFExtend
    USE ENTITY work.ofdm_tx_src_STFExtend(rtl);

  FOR ALL : ofdm_tx_src_LTFExtend
    USE ENTITY work.ofdm_tx_src_LTFExtend(rtl);

  FOR ALL : ofdm_tx_src_DataExtend
    USE ENTITY work.ofdm_tx_src_DataExtend(rtl);

  FOR ALL : ofdm_tx_src_Mux2
    USE ENTITY work.ofdm_tx_src_Mux2(rtl);

  -- Signals
  SIGNAL dataIn_re_signed                 : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL dataIn_im_signed                 : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL dataIn_re_1                      : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL dataIn_im_1                      : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL preambValid_1                    : std_logic;
  SIGNAL STFExtend_out1_re                : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL STFExtend_out1_im                : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL STFExtend_out2                   : std_logic;
  SIGNAL LTFExtend_out1_re                : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL LTFExtend_out1_im                : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL LTFExtend_out2                   : std_logic;
  SIGNAL dataValid_1                      : std_logic;
  SIGNAL DataExtend_out1_re               : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL DataExtend_out1_im               : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL DataExtend_out2                  : std_logic;
  SIGNAL dataOut_re_1                     : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL dataOut_im_1                     : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL dataOut_re_signed                : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL dataOut_im_signed                : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL dataOut_re_tmp                   : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL dataOut_im_tmp                   : signed(15 DOWNTO 0);  -- sfix16_En14

BEGIN
  u_STFExtend : ofdm_tx_src_STFExtend
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_192_0 => enb_1_192_0,
              data_re => std_logic_vector(dataIn_re_1),  -- sfix16_En14
              data_im => std_logic_vector(dataIn_im_1),  -- sfix16_En14
              preambVal => preambValid_1,
              STFExtendOut_re => STFExtend_out1_re,  -- sfix16_En14
              STFExtendOut_im => STFExtend_out1_im,  -- sfix16_En14
              STFValidOut => STFExtend_out2
              );

  u_LTFExtend : ofdm_tx_src_LTFExtend
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_192_0 => enb_1_192_0,
              data_re => std_logic_vector(dataIn_re_1),  -- sfix16_En14
              data_im => std_logic_vector(dataIn_im_1),  -- sfix16_En14
              preambVal => preambValid_1,
              LTFExtendOut_re => LTFExtend_out1_re,  -- sfix16_En14
              LTFExtendOut_im => LTFExtend_out1_im,  -- sfix16_En14
              LTFValidOut => LTFExtend_out2
              );

  u_DataExtend : ofdm_tx_src_DataExtend
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_192_0 => enb_1_192_0,
              dataIn_re => std_logic_vector(dataIn_re_1),  -- sfix16_En14
              dataIn_im => std_logic_vector(dataIn_im_1),  -- sfix16_En14
              dataValid => dataValid_1,
              dataOut_re => DataExtend_out1_re,  -- sfix16_En14
              dataOut_im => DataExtend_out1_im,  -- sfix16_En14
              dataValidOut => DataExtend_out2
              );

  u_Mux2 : ofdm_tx_src_Mux2
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_192_0 => enb_1_192_0,
              sts_re => STFExtend_out1_re,  -- sfix16_En14
              sts_im => STFExtend_out1_im,  -- sfix16_En14
              stsval => STFExtend_out2,
              lts_re => LTFExtend_out1_re,  -- sfix16_En14
              lts_im => LTFExtend_out1_im,  -- sfix16_En14
              ltsval => LTFExtend_out2,
              data_re => DataExtend_out1_re,  -- sfix16_En14
              data_im => DataExtend_out1_im,  -- sfix16_En14
              dataval => DataExtend_out2,
              dataOut_re => dataOut_re_1,  -- sfix16_En14
              dataOut_im => dataOut_im_1  -- sfix16_En14
              );

  dataIn_re_signed <= signed(dataIn_re);

  dataIn_im_signed <= signed(dataIn_im);

  in_0_pipe_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      dataIn_re_1 <= to_signed(16#0000#, 16);
      dataIn_im_1 <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_192_0 = '1' THEN
        dataIn_re_1 <= dataIn_re_signed;
        dataIn_im_1 <= dataIn_im_signed;
      END IF;
    END IF;
  END PROCESS in_0_pipe_process;


  in_1_pipe_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      preambValid_1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_192_0 = '1' THEN
        preambValid_1 <= preambValid;
      END IF;
    END IF;
  END PROCESS in_1_pipe_process;


  in_2_pipe_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      dataValid_1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_192_0 = '1' THEN
        dataValid_1 <= dataValid;
      END IF;
    END IF;
  END PROCESS in_2_pipe_process;


  dataOut_re_signed <= signed(dataOut_re_1);

  dataOut_im_signed <= signed(dataOut_im_1);

  out_0_pipe_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      dataOut_re_tmp <= to_signed(16#0000#, 16);
      dataOut_im_tmp <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_192_0 = '1' THEN
        dataOut_re_tmp <= dataOut_re_signed;
        dataOut_im_tmp <= dataOut_im_signed;
      END IF;
    END IF;
  END PROCESS out_0_pipe_process;


  dataOut_re <= std_logic_vector(dataOut_re_tmp);

  dataOut_im <= std_logic_vector(dataOut_im_tmp);

END rtl;
