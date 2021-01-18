-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\OFDM_tx\hdlsrc\OFDM_Tx_Rx_HW\ofdm_tx_src_TWDLROM_5_1.vhd
-- Created: 2021-01-12 13:19:19
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ofdm_tx_src_TWDLROM_5_1
-- Source Path: OFDM_Tx_Rx_HW/OFDMTx/IFFT/IFFT HDL Optimized/TWDLROM_5_1
-- Hierarchy Level: 3
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.ofdm_tx_src_OFDMTx_pkg.ALL;

ENTITY ofdm_tx_src_TWDLROM_5_1 IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb_1_192_0                       :   IN    std_logic;
        dout_4_1_vld                      :   IN    std_logic;
        softReset                         :   IN    std_logic;
        twdl_5_1_re                       :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        twdl_5_1_im                       :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        twdl_5_1_vld                      :   OUT   std_logic
        );
END ofdm_tx_src_TWDLROM_5_1;


ARCHITECTURE rtl OF ofdm_tx_src_TWDLROM_5_1 IS

  -- Constants
  CONSTANT Twiddle_re_table_data          : vector_of_signed16(0 TO 7) := 
    (to_signed(16#4000#, 16), to_signed(16#3FB1#, 16), to_signed(16#3EC5#, 16), to_signed(16#3D3F#, 16),
     to_signed(16#3B21#, 16), to_signed(16#3871#, 16), to_signed(16#3537#, 16), to_signed(16#3179#, 16));  -- sfix16 [8]
  CONSTANT Twiddle_im_table_data          : vector_of_signed16(0 TO 7) := 
    (to_signed(16#0000#, 16), to_signed(-16#0646#, 16), to_signed(-16#0C7C#, 16), to_signed(-16#1294#, 16),
     to_signed(-16#187E#, 16), to_signed(-16#1E2B#, 16), to_signed(-16#238E#, 16), to_signed(-16#289A#, 16));  -- sfix16 [8]

  -- Functions
  -- HDLCODER_TO_STDLOGIC 
  FUNCTION hdlcoder_to_stdlogic(arg: boolean) RETURN std_logic IS
  BEGIN
    IF arg THEN
      RETURN '1';
    ELSE
      RETURN '0';
    END IF;
  END FUNCTION;


  -- Signals
  SIGNAL Radix22TwdlMapping_cnt           : unsigned(3 DOWNTO 0);  -- ufix4
  SIGNAL Radix22TwdlMapping_phase         : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL Radix22TwdlMapping_octantReg1    : unsigned(2 DOWNTO 0);  -- ufix3
  SIGNAL Radix22TwdlMapping_twdlAddr_raw  : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Radix22TwdlMapping_twdlAddrMap   : unsigned(2 DOWNTO 0);  -- ufix3
  SIGNAL Radix22TwdlMapping_twdl45Reg     : std_logic;
  SIGNAL Radix22TwdlMapping_dvldReg1      : std_logic;
  SIGNAL Radix22TwdlMapping_dvldReg2      : std_logic;
  SIGNAL Radix22TwdlMapping_cnt_next      : unsigned(3 DOWNTO 0);  -- ufix4
  SIGNAL Radix22TwdlMapping_phase_next    : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL Radix22TwdlMapping_octantReg1_next : unsigned(2 DOWNTO 0);  -- ufix3
  SIGNAL Radix22TwdlMapping_twdlAddr_raw_next : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Radix22TwdlMapping_twdlAddrMap_next : unsigned(2 DOWNTO 0);  -- ufix3
  SIGNAL Radix22TwdlMapping_twdl45Reg_next : std_logic;
  SIGNAL Radix22TwdlMapping_dvldReg1_next : std_logic;
  SIGNAL Radix22TwdlMapping_dvldReg2_next : std_logic;
  SIGNAL twdlAddr                         : unsigned(2 DOWNTO 0);  -- ufix3
  SIGNAL twdlAddrVld                      : std_logic;
  SIGNAL twdlOctant                       : unsigned(2 DOWNTO 0);  -- ufix3
  SIGNAL twdl45                           : std_logic;
  SIGNAL twiddleS_re                      : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL twiddleReg_re                    : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL twiddleS_im                      : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL twiddleReg_im                    : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL twdlOctantReg                    : unsigned(2 DOWNTO 0);  -- ufix3
  SIGNAL twdl45Reg                        : std_logic;
  SIGNAL twdl_5_1_re_tmp                  : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL twdl_5_1_im_tmp                  : signed(15 DOWNTO 0);  -- sfix16_En14

BEGIN
  -- Radix22TwdlMapping
  Radix22TwdlMapping_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Radix22TwdlMapping_octantReg1 <= to_unsigned(16#0#, 3);
      Radix22TwdlMapping_twdlAddr_raw <= to_unsigned(16#00#, 6);
      Radix22TwdlMapping_twdlAddrMap <= to_unsigned(16#0#, 3);
      Radix22TwdlMapping_twdl45Reg <= '0';
      Radix22TwdlMapping_dvldReg1 <= '0';
      Radix22TwdlMapping_dvldReg2 <= '0';
      Radix22TwdlMapping_cnt <= to_unsigned(16#0#, 4);
      Radix22TwdlMapping_phase <= to_unsigned(16#0#, 2);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_192_0 = '1' THEN
        Radix22TwdlMapping_cnt <= Radix22TwdlMapping_cnt_next;
        Radix22TwdlMapping_phase <= Radix22TwdlMapping_phase_next;
        Radix22TwdlMapping_octantReg1 <= Radix22TwdlMapping_octantReg1_next;
        Radix22TwdlMapping_twdlAddr_raw <= Radix22TwdlMapping_twdlAddr_raw_next;
        Radix22TwdlMapping_twdlAddrMap <= Radix22TwdlMapping_twdlAddrMap_next;
        Radix22TwdlMapping_twdl45Reg <= Radix22TwdlMapping_twdl45Reg_next;
        Radix22TwdlMapping_dvldReg1 <= Radix22TwdlMapping_dvldReg1_next;
        Radix22TwdlMapping_dvldReg2 <= Radix22TwdlMapping_dvldReg2_next;
      END IF;
    END IF;
  END PROCESS Radix22TwdlMapping_process;

  Radix22TwdlMapping_output : PROCESS (Radix22TwdlMapping_cnt, Radix22TwdlMapping_dvldReg1,
       Radix22TwdlMapping_dvldReg2, Radix22TwdlMapping_octantReg1,
       Radix22TwdlMapping_phase, Radix22TwdlMapping_twdl45Reg,
       Radix22TwdlMapping_twdlAddrMap, Radix22TwdlMapping_twdlAddr_raw,
       dout_4_1_vld)
    VARIABLE octant : unsigned(2 DOWNTO 0);
    VARIABLE cnt_cast : unsigned(5 DOWNTO 0);
    VARIABLE sub_cast : signed(13 DOWNTO 0);
    VARIABLE sub_temp : signed(13 DOWNTO 0);
    VARIABLE sub_cast_0 : signed(7 DOWNTO 0);
    VARIABLE sub_temp_0 : signed(7 DOWNTO 0);
    VARIABLE sub_cast_1 : signed(7 DOWNTO 0);
    VARIABLE sub_temp_1 : signed(7 DOWNTO 0);
    VARIABLE sub_cast_2 : signed(13 DOWNTO 0);
    VARIABLE sub_temp_2 : signed(13 DOWNTO 0);
    VARIABLE sub_cast_3 : signed(13 DOWNTO 0);
    VARIABLE sub_temp_3 : signed(13 DOWNTO 0);
  BEGIN
    sub_temp := to_signed(16#0000#, 14);
    sub_temp_0 := to_signed(16#00#, 8);
    sub_temp_1 := to_signed(16#00#, 8);
    sub_temp_2 := to_signed(16#0000#, 14);
    sub_temp_3 := to_signed(16#0000#, 14);
    cnt_cast := to_unsigned(16#00#, 6);
    sub_cast := to_signed(16#0000#, 14);
    sub_cast_0 := to_signed(16#00#, 8);
    sub_cast_1 := to_signed(16#00#, 8);
    sub_cast_2 := to_signed(16#0000#, 14);
    sub_cast_3 := to_signed(16#0000#, 14);
    Radix22TwdlMapping_cnt_next <= Radix22TwdlMapping_cnt;
    Radix22TwdlMapping_phase_next <= Radix22TwdlMapping_phase;
    Radix22TwdlMapping_twdlAddr_raw_next <= Radix22TwdlMapping_twdlAddr_raw;
    Radix22TwdlMapping_twdlAddrMap_next <= Radix22TwdlMapping_twdlAddrMap;
    Radix22TwdlMapping_twdl45Reg_next <= Radix22TwdlMapping_twdl45Reg;
    Radix22TwdlMapping_dvldReg2_next <= Radix22TwdlMapping_dvldReg1;
    Radix22TwdlMapping_dvldReg1_next <= dout_4_1_vld;
    CASE Radix22TwdlMapping_twdlAddr_raw IS
      WHEN "001000" =>
        octant := to_unsigned(16#0#, 3);
        Radix22TwdlMapping_twdl45Reg_next <= '1';
      WHEN "010000" =>
        octant := to_unsigned(16#1#, 3);
        Radix22TwdlMapping_twdl45Reg_next <= '0';
      WHEN "011000" =>
        octant := to_unsigned(16#2#, 3);
        Radix22TwdlMapping_twdl45Reg_next <= '1';
      WHEN "100000" =>
        octant := to_unsigned(16#3#, 3);
        Radix22TwdlMapping_twdl45Reg_next <= '0';
      WHEN "101000" =>
        octant := to_unsigned(16#4#, 3);
        Radix22TwdlMapping_twdl45Reg_next <= '1';
      WHEN OTHERS => 
        octant := Radix22TwdlMapping_twdlAddr_raw(5 DOWNTO 3);
        Radix22TwdlMapping_twdl45Reg_next <= '0';
    END CASE;
    Radix22TwdlMapping_octantReg1_next <= octant;
    CASE octant IS
      WHEN "000" =>
        Radix22TwdlMapping_twdlAddrMap_next <= Radix22TwdlMapping_twdlAddr_raw(2 DOWNTO 0);
      WHEN "001" =>
        sub_cast_0 := signed(resize(Radix22TwdlMapping_twdlAddr_raw, 8));
        sub_temp_0 := to_signed(16#10#, 8) - sub_cast_0;
        Radix22TwdlMapping_twdlAddrMap_next <= unsigned(sub_temp_0(2 DOWNTO 0));
      WHEN "010" =>
        sub_cast_1 := signed(resize(Radix22TwdlMapping_twdlAddr_raw, 8));
        sub_temp_1 := sub_cast_1 - to_signed(16#10#, 8);
        Radix22TwdlMapping_twdlAddrMap_next <= unsigned(sub_temp_1(2 DOWNTO 0));
      WHEN "011" =>
        sub_cast_2 := signed(resize(Radix22TwdlMapping_twdlAddr_raw & '0' & '0' & '0', 14));
        sub_temp_2 := to_signed(16#0100#, 14) - sub_cast_2;
        Radix22TwdlMapping_twdlAddrMap_next <= unsigned(sub_temp_2(5 DOWNTO 3));
      WHEN "100" =>
        sub_cast_3 := signed(resize(Radix22TwdlMapping_twdlAddr_raw & '0' & '0' & '0', 14));
        sub_temp_3 := sub_cast_3 - to_signed(16#0100#, 14);
        Radix22TwdlMapping_twdlAddrMap_next <= unsigned(sub_temp_3(5 DOWNTO 3));
      WHEN OTHERS => 
        sub_cast := signed(resize(Radix22TwdlMapping_twdlAddr_raw & '0' & '0' & '0', 14));
        sub_temp := to_signed(16#0180#, 14) - sub_cast;
        Radix22TwdlMapping_twdlAddrMap_next <= unsigned(sub_temp(5 DOWNTO 3));
    END CASE;
    IF Radix22TwdlMapping_phase = to_unsigned(16#0#, 2) THEN 
      Radix22TwdlMapping_twdlAddr_raw_next <= to_unsigned(16#00#, 6);
    ELSIF Radix22TwdlMapping_phase = to_unsigned(16#1#, 2) THEN 
      Radix22TwdlMapping_twdlAddr_raw_next <= resize(Radix22TwdlMapping_cnt, 6) sll 1;
    ELSIF Radix22TwdlMapping_phase = to_unsigned(16#2#, 2) THEN 
      Radix22TwdlMapping_twdlAddr_raw_next <= resize(Radix22TwdlMapping_cnt, 6);
    ELSE 
      cnt_cast := resize(Radix22TwdlMapping_cnt, 6);
      Radix22TwdlMapping_twdlAddr_raw_next <= (cnt_cast sll 1) + cnt_cast;
    END IF;
    IF (dout_4_1_vld AND hdlcoder_to_stdlogic(Radix22TwdlMapping_cnt > to_unsigned(16#B#, 4))) = '1' THEN 
      Radix22TwdlMapping_phase_next <= Radix22TwdlMapping_phase + to_unsigned(16#1#, 2);
    END IF;
    IF dout_4_1_vld = '1' THEN 
      Radix22TwdlMapping_cnt_next <= Radix22TwdlMapping_cnt + to_unsigned(16#4#, 4);
    END IF;
    twdlAddr <= Radix22TwdlMapping_twdlAddrMap;
    twdlAddrVld <= Radix22TwdlMapping_dvldReg2;
    twdlOctant <= Radix22TwdlMapping_octantReg1;
    twdl45 <= Radix22TwdlMapping_twdl45Reg;
  END PROCESS Radix22TwdlMapping_output;


  -- Twiddle ROM1
  twiddleS_re <= Twiddle_re_table_data(to_integer(twdlAddr));

  TWIDDLEROM_RE_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      twiddleReg_re <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_192_0 = '1' THEN
        twiddleReg_re <= twiddleS_re;
      END IF;
    END IF;
  END PROCESS TWIDDLEROM_RE_process;


  -- Twiddle ROM2
  twiddleS_im <= Twiddle_im_table_data(to_integer(twdlAddr));

  TWIDDLEROM_IM_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      twiddleReg_im <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_192_0 = '1' THEN
        twiddleReg_im <= twiddleS_im;
      END IF;
    END IF;
  END PROCESS TWIDDLEROM_IM_process;


  intdelay_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      twdlOctantReg <= to_unsigned(16#0#, 3);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_192_0 = '1' THEN
        twdlOctantReg <= twdlOctant;
      END IF;
    END IF;
  END PROCESS intdelay_process;


  intdelay_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      twdl45Reg <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_192_0 = '1' THEN
        twdl45Reg <= twdl45;
      END IF;
    END IF;
  END PROCESS intdelay_1_process;


  -- Radix22TwdlOctCorr
  Radix22TwdlOctCorr_output : PROCESS (twdl45Reg, twdlOctantReg, twiddleReg_im, twiddleReg_re)
    VARIABLE twdlIn_re : signed(15 DOWNTO 0);
    VARIABLE twdlIn_im : signed(15 DOWNTO 0);
    VARIABLE cast : signed(16 DOWNTO 0);
    VARIABLE cast_0 : signed(16 DOWNTO 0);
    VARIABLE cast_1 : signed(16 DOWNTO 0);
    VARIABLE cast_2 : signed(16 DOWNTO 0);
    VARIABLE cast_3 : signed(16 DOWNTO 0);
    VARIABLE cast_4 : signed(16 DOWNTO 0);
    VARIABLE cast_5 : signed(16 DOWNTO 0);
    VARIABLE cast_6 : signed(16 DOWNTO 0);
    VARIABLE cast_7 : signed(16 DOWNTO 0);
    VARIABLE cast_8 : signed(16 DOWNTO 0);
    VARIABLE cast_9 : signed(16 DOWNTO 0);
    VARIABLE cast_10 : signed(16 DOWNTO 0);
  BEGIN
    cast_0 := to_signed(16#00000#, 17);
    cast_2 := to_signed(16#00000#, 17);
    cast_4 := to_signed(16#00000#, 17);
    cast_6 := to_signed(16#00000#, 17);
    cast_8 := to_signed(16#00000#, 17);
    cast_10 := to_signed(16#00000#, 17);
    cast := to_signed(16#00000#, 17);
    cast_1 := to_signed(16#00000#, 17);
    cast_3 := to_signed(16#00000#, 17);
    cast_5 := to_signed(16#00000#, 17);
    cast_7 := to_signed(16#00000#, 17);
    cast_9 := to_signed(16#00000#, 17);
    twdlIn_re := twiddleReg_re;
    twdlIn_im := twiddleReg_im;
    IF twdl45Reg = '1' THEN 
      CASE twdlOctantReg IS
        WHEN "000" =>
          twdlIn_re := to_signed(16#2D41#, 16);
          twdlIn_im := to_signed(-16#2D41#, 16);
        WHEN "010" =>
          twdlIn_re := to_signed(-16#2D41#, 16);
          twdlIn_im := to_signed(-16#2D41#, 16);
        WHEN "100" =>
          twdlIn_re := to_signed(-16#2D41#, 16);
          twdlIn_im := to_signed(16#2D41#, 16);
        WHEN OTHERS => 
          twdlIn_re := to_signed(16#2D41#, 16);
          twdlIn_im := to_signed(-16#2D41#, 16);
      END CASE;
    ELSE 
      CASE twdlOctantReg IS
        WHEN "000" =>
          NULL;
        WHEN "001" =>
          cast := resize(twiddleReg_im, 17);
          cast_0 :=  - (cast);
          twdlIn_re := cast_0(15 DOWNTO 0);
          cast_5 := resize(twiddleReg_re, 17);
          cast_6 :=  - (cast_5);
          twdlIn_im := cast_6(15 DOWNTO 0);
        WHEN "010" =>
          twdlIn_re := twiddleReg_im;
          cast_7 := resize(twiddleReg_re, 17);
          cast_8 :=  - (cast_7);
          twdlIn_im := cast_8(15 DOWNTO 0);
        WHEN "011" =>
          cast_1 := resize(twiddleReg_re, 17);
          cast_2 :=  - (cast_1);
          twdlIn_re := cast_2(15 DOWNTO 0);
          twdlIn_im := twiddleReg_im;
        WHEN "100" =>
          cast_3 := resize(twiddleReg_re, 17);
          cast_4 :=  - (cast_3);
          twdlIn_re := cast_4(15 DOWNTO 0);
          cast_9 := resize(twiddleReg_im, 17);
          cast_10 :=  - (cast_9);
          twdlIn_im := cast_10(15 DOWNTO 0);
        WHEN OTHERS => 
          twdlIn_re := twiddleReg_im;
          twdlIn_im := twiddleReg_re;
      END CASE;
    END IF;
    twdl_5_1_re_tmp <= twdlIn_re;
    twdl_5_1_im_tmp <= twdlIn_im;
  END PROCESS Radix22TwdlOctCorr_output;


  twdl_5_1_re <= std_logic_vector(twdl_5_1_re_tmp);

  twdl_5_1_im <= std_logic_vector(twdl_5_1_im_tmp);

  intdelay_2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      twdl_5_1_vld <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_192_0 = '1' THEN
        twdl_5_1_vld <= twdlAddrVld;
      END IF;
    END IF;
  END PROCESS intdelay_2_process;


END rtl;
