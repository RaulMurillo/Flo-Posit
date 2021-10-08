--------------------------------------------------------------------------------
--                          Compressor_23_3_F0_uid21
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X1 X0
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity Compressor_23_3_F0_uid21 is
    port (X1 : in  std_logic_vector(1 downto 0);
          X0 : in  std_logic_vector(2 downto 0);
          R : out  std_logic_vector(2 downto 0)   );
end entity;

architecture arch of Compressor_23_3_F0_uid21 is
signal X :  std_logic_vector(4 downto 0);
signal R0 :  std_logic_vector(2 downto 0);
begin
   X <= X1 & X0 ;

   with X  select  R0 <= 
      "000" when "00000",
      "001" when "00001" | "00010" | "00100",
      "010" when "00011" | "00101" | "00110" | "01000" | "10000",
      "011" when "00111" | "01001" | "01010" | "01100" | "10001" | "10010" | "10100",
      "100" when "01011" | "01101" | "01110" | "10011" | "10101" | "10110" | "11000",
      "101" when "01111" | "10111" | "11001" | "11010" | "11100",
      "110" when "11011" | "11101" | "11110",
      "111" when "11111",
      "---" when others;
   R <= R0;
end architecture;

--------------------------------------------------------------------------------
--                       Normalizer_ZO_22_22_22_F0_uid6
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Florent de Dinechin, (2007-2020)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X OZb
-- Output signals: Count R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity Normalizer_ZO_22_22_22_F0_uid6 is
    port (X : in  std_logic_vector(21 downto 0);
          OZb : in  std_logic;
          Count : out  std_logic_vector(4 downto 0);
          R : out  std_logic_vector(21 downto 0)   );
end entity;

architecture arch of Normalizer_ZO_22_22_22_F0_uid6 is
signal level5 :  std_logic_vector(21 downto 0);
signal sozb :  std_logic;
signal count4 :  std_logic;
signal level4 :  std_logic_vector(21 downto 0);
signal count3 :  std_logic;
signal level3 :  std_logic_vector(21 downto 0);
signal count2 :  std_logic;
signal level2 :  std_logic_vector(21 downto 0);
signal count1 :  std_logic;
signal level1 :  std_logic_vector(21 downto 0);
signal count0 :  std_logic;
signal level0 :  std_logic_vector(21 downto 0);
signal sCount :  std_logic_vector(4 downto 0);
begin
   level5 <= X ;
   sozb<= OZb;
   count4<= '1' when level5(21 downto 6) = (21 downto 6=>sozb) else '0';
   level4<= level5(21 downto 0) when count4='0' else level5(5 downto 0) & (15 downto 0 => '0');

   count3<= '1' when level4(21 downto 14) = (21 downto 14=>sozb) else '0';
   level3<= level4(21 downto 0) when count3='0' else level4(13 downto 0) & (7 downto 0 => '0');

   count2<= '1' when level3(21 downto 18) = (21 downto 18=>sozb) else '0';
   level2<= level3(21 downto 0) when count2='0' else level3(17 downto 0) & (3 downto 0 => '0');

   count1<= '1' when level2(21 downto 20) = (21 downto 20=>sozb) else '0';
   level1<= level2(21 downto 0) when count1='0' else level2(19 downto 0) & (1 downto 0 => '0');

   count0<= '1' when level1(21 downto 21) = (21 downto 21=>sozb) else '0';
   level0<= level1(21 downto 0) when count0='0' else level1(20 downto 0) & (0 downto 0 => '0');

   R <= level0;
   sCount <= count4 & count3 & count2 & count1 & count0;
   Count <= sCount;
end architecture;

--------------------------------------------------------------------------------
--                         PositDecoder_24_2_F0_uid4
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Raul Murillo (2021)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X
-- Output signals: Sign SF Frac NZN

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity PositDecoder_24_2_F0_uid4 is
    port (X : in  std_logic_vector(23 downto 0);
          Sign : out  std_logic;
          SF : out  std_logic_vector(7 downto 0);
          Frac : out  std_logic_vector(18 downto 0);
          NZN : out  std_logic   );
end entity;

architecture arch of PositDecoder_24_2_F0_uid4 is
   component Normalizer_ZO_22_22_22_F0_uid6 is
      port ( X : in  std_logic_vector(21 downto 0);
             OZb : in  std_logic;
             Count : out  std_logic_vector(4 downto 0);
             R : out  std_logic_vector(21 downto 0)   );
   end component;

signal sgn :  std_logic;
signal pNZN :  std_logic;
signal rc :  std_logic;
signal regPosit :  std_logic_vector(21 downto 0);
signal regLength :  std_logic_vector(4 downto 0);
signal shiftedPosit :  std_logic_vector(21 downto 0);
signal k :  std_logic_vector(5 downto 0);
signal sgnVect :  std_logic_vector(1 downto 0);
signal exp :  std_logic_vector(1 downto 0);
signal pSF :  std_logic_vector(7 downto 0);
signal pFrac :  std_logic_vector(18 downto 0);
begin
--------------------------- Start of vhdl generation ---------------------------
--------------------------- Sign bit & special cases ---------------------------
   sgn <= X(23);
   pNZN <= '0' when (X(22 downto 0) = "00000000000000000000000") else '1';
-------------- Count leading zeros/ones of regime & shift it out --------------
   rc <= X(22);
   regPosit <= X(21 downto 0);
   RegimeCounter: Normalizer_ZO_22_22_22_F0_uid6
      port map ( OZb => rc,
                 X => regPosit,
                 Count => regLength,
                 R => shiftedPosit);
----------------- Determine the scaling factor - regime & exp -----------------
   k <= "0" & regLength when rc /= sgn else "1" & NOT(regLength);
   sgnVect <= (others => sgn);
   exp <= shiftedPosit(20 downto 19) XOR sgnVect;
   pSF <= k & exp;
------------------------------- Extract fraction -------------------------------
   pFrac <= shiftedPosit(18 downto 0);
   Sign <= sgn;
   SF <= pSF;
   Frac <= pFrac;
   NZN <= pNZN;
---------------------------- End of vhdl generation ----------------------------
end architecture;

--------------------------------------------------------------------------------
--                      Normalizer_ZO_22_22_22_F0_uid10
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Florent de Dinechin, (2007-2020)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X OZb
-- Output signals: Count R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity Normalizer_ZO_22_22_22_F0_uid10 is
    port (X : in  std_logic_vector(21 downto 0);
          OZb : in  std_logic;
          Count : out  std_logic_vector(4 downto 0);
          R : out  std_logic_vector(21 downto 0)   );
end entity;

architecture arch of Normalizer_ZO_22_22_22_F0_uid10 is
signal level5 :  std_logic_vector(21 downto 0);
signal sozb :  std_logic;
signal count4 :  std_logic;
signal level4 :  std_logic_vector(21 downto 0);
signal count3 :  std_logic;
signal level3 :  std_logic_vector(21 downto 0);
signal count2 :  std_logic;
signal level2 :  std_logic_vector(21 downto 0);
signal count1 :  std_logic;
signal level1 :  std_logic_vector(21 downto 0);
signal count0 :  std_logic;
signal level0 :  std_logic_vector(21 downto 0);
signal sCount :  std_logic_vector(4 downto 0);
begin
   level5 <= X ;
   sozb<= OZb;
   count4<= '1' when level5(21 downto 6) = (21 downto 6=>sozb) else '0';
   level4<= level5(21 downto 0) when count4='0' else level5(5 downto 0) & (15 downto 0 => '0');

   count3<= '1' when level4(21 downto 14) = (21 downto 14=>sozb) else '0';
   level3<= level4(21 downto 0) when count3='0' else level4(13 downto 0) & (7 downto 0 => '0');

   count2<= '1' when level3(21 downto 18) = (21 downto 18=>sozb) else '0';
   level2<= level3(21 downto 0) when count2='0' else level3(17 downto 0) & (3 downto 0 => '0');

   count1<= '1' when level2(21 downto 20) = (21 downto 20=>sozb) else '0';
   level1<= level2(21 downto 0) when count1='0' else level2(19 downto 0) & (1 downto 0 => '0');

   count0<= '1' when level1(21 downto 21) = (21 downto 21=>sozb) else '0';
   level0<= level1(21 downto 0) when count0='0' else level1(20 downto 0) & (0 downto 0 => '0');

   R <= level0;
   sCount <= count4 & count3 & count2 & count1 & count0;
   Count <= sCount;
end architecture;

--------------------------------------------------------------------------------
--                         PositDecoder_24_2_F0_uid8
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Raul Murillo (2021)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X
-- Output signals: Sign SF Frac NZN

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity PositDecoder_24_2_F0_uid8 is
    port (X : in  std_logic_vector(23 downto 0);
          Sign : out  std_logic;
          SF : out  std_logic_vector(7 downto 0);
          Frac : out  std_logic_vector(18 downto 0);
          NZN : out  std_logic   );
end entity;

architecture arch of PositDecoder_24_2_F0_uid8 is
   component Normalizer_ZO_22_22_22_F0_uid10 is
      port ( X : in  std_logic_vector(21 downto 0);
             OZb : in  std_logic;
             Count : out  std_logic_vector(4 downto 0);
             R : out  std_logic_vector(21 downto 0)   );
   end component;

signal sgn :  std_logic;
signal pNZN :  std_logic;
signal rc :  std_logic;
signal regPosit :  std_logic_vector(21 downto 0);
signal regLength :  std_logic_vector(4 downto 0);
signal shiftedPosit :  std_logic_vector(21 downto 0);
signal k :  std_logic_vector(5 downto 0);
signal sgnVect :  std_logic_vector(1 downto 0);
signal exp :  std_logic_vector(1 downto 0);
signal pSF :  std_logic_vector(7 downto 0);
signal pFrac :  std_logic_vector(18 downto 0);
begin
--------------------------- Start of vhdl generation ---------------------------
--------------------------- Sign bit & special cases ---------------------------
   sgn <= X(23);
   pNZN <= '0' when (X(22 downto 0) = "00000000000000000000000") else '1';
-------------- Count leading zeros/ones of regime & shift it out --------------
   rc <= X(22);
   regPosit <= X(21 downto 0);
   RegimeCounter: Normalizer_ZO_22_22_22_F0_uid10
      port map ( OZb => rc,
                 X => regPosit,
                 Count => regLength,
                 R => shiftedPosit);
----------------- Determine the scaling factor - regime & exp -----------------
   k <= "0" & regLength when rc /= sgn else "1" & NOT(regLength);
   sgnVect <= (others => sgn);
   exp <= shiftedPosit(20 downto 19) XOR sgnVect;
   pSF <= k & exp;
------------------------------- Extract fraction -------------------------------
   pFrac <= shiftedPosit(18 downto 0);
   Sign <= sgn;
   SF <= pSF;
   Frac <= pFrac;
   NZN <= pNZN;
---------------------------- End of vhdl generation ----------------------------
end architecture;

--------------------------------------------------------------------------------
--                          DSPBlock_17x21_F0_uid16
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library std;
use std.textio.all;
library work;

entity DSPBlock_17x21_F0_uid16 is
    port (X : in  std_logic_vector(16 downto 0);
          Y : in  std_logic_vector(20 downto 0);
          R : out  std_logic_vector(37 downto 0)   );
end entity;

architecture arch of DSPBlock_17x21_F0_uid16 is
signal Mint :  std_logic_vector(38 downto 0);
signal M :  std_logic_vector(37 downto 0);
signal Rtmp :  std_logic_vector(37 downto 0);
begin
   Mint <= std_logic_vector(signed('0' & X) * signed(Y)); -- multiplier
   M <= Mint(37 downto 0);
   Rtmp <= M;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                           DSPBlock_4x21_F0_uid18
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library std;
use std.textio.all;
library work;

entity DSPBlock_4x21_F0_uid18 is
    port (X : in  std_logic_vector(3 downto 0);
          Y : in  std_logic_vector(20 downto 0);
          R : out  std_logic_vector(24 downto 0)   );
end entity;

architecture arch of DSPBlock_4x21_F0_uid18 is
signal Mint :  std_logic_vector(24 downto 0);
signal M :  std_logic_vector(24 downto 0);
signal Rtmp :  std_logic_vector(24 downto 0);
begin
   Mint <= std_logic_vector(signed(X) * signed(Y)); -- multiplier
   M <= Mint(24 downto 0);
   Rtmp <= M;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_24_F0_uid35
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_24_F0_uid35 is
    port (X : in  std_logic_vector(23 downto 0);
          Y : in  std_logic_vector(23 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(23 downto 0)   );
end entity;

architecture arch of IntAdder_24_F0_uid35 is
signal Rtmp :  std_logic_vector(23 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                           IntMultiplier_F0_uid12
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Martin Kumm, Florent de Dinechin, Kinga Illyes, Bogdan Popa, Bogdan Pasca, 2012
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library std;
use std.textio.all;
library work;

entity IntMultiplier_F0_uid12 is
    port (X : in  std_logic_vector(20 downto 0);
          Y : in  std_logic_vector(20 downto 0);
          R : out  std_logic_vector(41 downto 0)   );
end entity;

architecture arch of IntMultiplier_F0_uid12 is
   component DSPBlock_17x21_F0_uid16 is
      port ( X : in  std_logic_vector(16 downto 0);
             Y : in  std_logic_vector(20 downto 0);
             R : out  std_logic_vector(37 downto 0)   );
   end component;

   component DSPBlock_4x21_F0_uid18 is
      port ( X : in  std_logic_vector(3 downto 0);
             Y : in  std_logic_vector(20 downto 0);
             R : out  std_logic_vector(24 downto 0)   );
   end component;

   component Compressor_23_3_F0_uid21 is
      port ( X1 : in  std_logic_vector(1 downto 0);
             X0 : in  std_logic_vector(2 downto 0);
             R : out  std_logic_vector(2 downto 0)   );
   end component;

   component IntAdder_24_F0_uid35 is
      port ( X : in  std_logic_vector(23 downto 0);
             Y : in  std_logic_vector(23 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(23 downto 0)   );
   end component;

signal XX_m13 :  std_logic_vector(20 downto 0);
signal YY_m13 :  std_logic_vector(20 downto 0);
signal tile_0_X :  std_logic_vector(16 downto 0);
signal tile_0_Y :  std_logic_vector(20 downto 0);
signal tile_0_output :  std_logic_vector(37 downto 0);
signal tile_0_filtered_output :  signed(37-0 downto 0);
signal bh14_w0_0 :  std_logic;
signal bh14_w1_0 :  std_logic;
signal bh14_w2_0 :  std_logic;
signal bh14_w3_0 :  std_logic;
signal bh14_w4_0 :  std_logic;
signal bh14_w5_0 :  std_logic;
signal bh14_w6_0 :  std_logic;
signal bh14_w7_0 :  std_logic;
signal bh14_w8_0 :  std_logic;
signal bh14_w9_0 :  std_logic;
signal bh14_w10_0 :  std_logic;
signal bh14_w11_0 :  std_logic;
signal bh14_w12_0 :  std_logic;
signal bh14_w13_0 :  std_logic;
signal bh14_w14_0 :  std_logic;
signal bh14_w15_0 :  std_logic;
signal bh14_w16_0 :  std_logic;
signal bh14_w17_0 :  std_logic;
signal bh14_w18_0 :  std_logic;
signal bh14_w19_0 :  std_logic;
signal bh14_w20_0 :  std_logic;
signal bh14_w21_0 :  std_logic;
signal bh14_w22_0 :  std_logic;
signal bh14_w23_0 :  std_logic;
signal bh14_w24_0 :  std_logic;
signal bh14_w25_0 :  std_logic;
signal bh14_w26_0 :  std_logic;
signal bh14_w27_0 :  std_logic;
signal bh14_w28_0 :  std_logic;
signal bh14_w29_0 :  std_logic;
signal bh14_w30_0 :  std_logic;
signal bh14_w31_0 :  std_logic;
signal bh14_w32_0 :  std_logic;
signal bh14_w33_0 :  std_logic;
signal bh14_w34_0 :  std_logic;
signal bh14_w35_0 :  std_logic;
signal bh14_w36_0 :  std_logic;
signal bh14_w37_0 :  std_logic;
signal tile_1_X :  std_logic_vector(3 downto 0);
signal tile_1_Y :  std_logic_vector(20 downto 0);
signal tile_1_output :  std_logic_vector(24 downto 0);
signal tile_1_filtered_output :  signed(24-0 downto 0);
signal bh14_w17_1 :  std_logic;
signal bh14_w18_1 :  std_logic;
signal bh14_w19_1 :  std_logic;
signal bh14_w20_1 :  std_logic;
signal bh14_w21_1 :  std_logic;
signal bh14_w22_1 :  std_logic;
signal bh14_w23_1 :  std_logic;
signal bh14_w24_1 :  std_logic;
signal bh14_w25_1 :  std_logic;
signal bh14_w26_1 :  std_logic;
signal bh14_w27_1 :  std_logic;
signal bh14_w28_1 :  std_logic;
signal bh14_w29_1 :  std_logic;
signal bh14_w30_1 :  std_logic;
signal bh14_w31_1 :  std_logic;
signal bh14_w32_1 :  std_logic;
signal bh14_w33_1 :  std_logic;
signal bh14_w34_1 :  std_logic;
signal bh14_w35_1 :  std_logic;
signal bh14_w36_1 :  std_logic;
signal bh14_w37_1 :  std_logic;
signal bh14_w38_0 :  std_logic;
signal bh14_w39_0 :  std_logic;
signal bh14_w40_0 :  std_logic;
signal bh14_w41_0 :  std_logic;
signal bh14_w37_2 :  std_logic;
signal bh14_w38_1 :  std_logic;
signal bh14_w39_1 :  std_logic;
signal bh14_w40_1 :  std_logic;
signal Compressor_23_3_F0_uid21_bh14_uid22_In0 :  std_logic_vector(2 downto 0);
signal Compressor_23_3_F0_uid21_bh14_uid22_In1 :  std_logic_vector(1 downto 0);
signal Compressor_23_3_F0_uid21_bh14_uid22_Out0 :  std_logic_vector(2 downto 0);
signal bh14_w17_2 :  std_logic;
signal bh14_w18_2 :  std_logic;
signal bh14_w19_2 :  std_logic;
signal Compressor_23_3_F0_uid21_bh14_uid23_In0 :  std_logic_vector(2 downto 0);
signal Compressor_23_3_F0_uid21_bh14_uid23_In1 :  std_logic_vector(1 downto 0);
signal Compressor_23_3_F0_uid21_bh14_uid23_Out0 :  std_logic_vector(2 downto 0);
signal bh14_w19_3 :  std_logic;
signal bh14_w20_2 :  std_logic;
signal bh14_w21_2 :  std_logic;
signal Compressor_23_3_F0_uid21_bh14_uid24_In0 :  std_logic_vector(2 downto 0);
signal Compressor_23_3_F0_uid21_bh14_uid24_In1 :  std_logic_vector(1 downto 0);
signal Compressor_23_3_F0_uid21_bh14_uid24_Out0 :  std_logic_vector(2 downto 0);
signal bh14_w21_3 :  std_logic;
signal bh14_w22_2 :  std_logic;
signal bh14_w23_2 :  std_logic;
signal Compressor_23_3_F0_uid21_bh14_uid25_In0 :  std_logic_vector(2 downto 0);
signal Compressor_23_3_F0_uid21_bh14_uid25_In1 :  std_logic_vector(1 downto 0);
signal Compressor_23_3_F0_uid21_bh14_uid25_Out0 :  std_logic_vector(2 downto 0);
signal bh14_w23_3 :  std_logic;
signal bh14_w24_2 :  std_logic;
signal bh14_w25_2 :  std_logic;
signal Compressor_23_3_F0_uid21_bh14_uid26_In0 :  std_logic_vector(2 downto 0);
signal Compressor_23_3_F0_uid21_bh14_uid26_In1 :  std_logic_vector(1 downto 0);
signal Compressor_23_3_F0_uid21_bh14_uid26_Out0 :  std_logic_vector(2 downto 0);
signal bh14_w25_3 :  std_logic;
signal bh14_w26_2 :  std_logic;
signal bh14_w27_2 :  std_logic;
signal Compressor_23_3_F0_uid21_bh14_uid27_In0 :  std_logic_vector(2 downto 0);
signal Compressor_23_3_F0_uid21_bh14_uid27_In1 :  std_logic_vector(1 downto 0);
signal Compressor_23_3_F0_uid21_bh14_uid27_Out0 :  std_logic_vector(2 downto 0);
signal bh14_w27_3 :  std_logic;
signal bh14_w28_2 :  std_logic;
signal bh14_w29_2 :  std_logic;
signal Compressor_23_3_F0_uid21_bh14_uid28_In0 :  std_logic_vector(2 downto 0);
signal Compressor_23_3_F0_uid21_bh14_uid28_In1 :  std_logic_vector(1 downto 0);
signal Compressor_23_3_F0_uid21_bh14_uid28_Out0 :  std_logic_vector(2 downto 0);
signal bh14_w29_3 :  std_logic;
signal bh14_w30_2 :  std_logic;
signal bh14_w31_2 :  std_logic;
signal Compressor_23_3_F0_uid21_bh14_uid29_In0 :  std_logic_vector(2 downto 0);
signal Compressor_23_3_F0_uid21_bh14_uid29_In1 :  std_logic_vector(1 downto 0);
signal Compressor_23_3_F0_uid21_bh14_uid29_Out0 :  std_logic_vector(2 downto 0);
signal bh14_w31_3 :  std_logic;
signal bh14_w32_2 :  std_logic;
signal bh14_w33_2 :  std_logic;
signal Compressor_23_3_F0_uid21_bh14_uid30_In0 :  std_logic_vector(2 downto 0);
signal Compressor_23_3_F0_uid21_bh14_uid30_In1 :  std_logic_vector(1 downto 0);
signal Compressor_23_3_F0_uid21_bh14_uid30_Out0 :  std_logic_vector(2 downto 0);
signal bh14_w33_3 :  std_logic;
signal bh14_w34_2 :  std_logic;
signal bh14_w35_2 :  std_logic;
signal Compressor_23_3_F0_uid21_bh14_uid31_In0 :  std_logic_vector(2 downto 0);
signal Compressor_23_3_F0_uid21_bh14_uid31_In1 :  std_logic_vector(1 downto 0);
signal Compressor_23_3_F0_uid21_bh14_uid31_Out0 :  std_logic_vector(2 downto 0);
signal bh14_w35_3 :  std_logic;
signal bh14_w36_2 :  std_logic;
signal bh14_w37_3 :  std_logic;
signal Compressor_23_3_F0_uid21_bh14_uid32_In0 :  std_logic_vector(2 downto 0);
signal Compressor_23_3_F0_uid21_bh14_uid32_In1 :  std_logic_vector(1 downto 0);
signal Compressor_23_3_F0_uid21_bh14_uid32_Out0 :  std_logic_vector(2 downto 0);
signal bh14_w37_4 :  std_logic;
signal bh14_w38_2 :  std_logic;
signal bh14_w39_2 :  std_logic;
signal Compressor_23_3_F0_uid21_bh14_uid33_In0 :  std_logic_vector(2 downto 0);
signal Compressor_23_3_F0_uid21_bh14_uid33_In1 :  std_logic_vector(1 downto 0);
signal Compressor_23_3_F0_uid21_bh14_uid33_Out0 :  std_logic_vector(2 downto 0);
signal bh14_w39_3 :  std_logic;
signal bh14_w40_2 :  std_logic;
signal bh14_w41_1 :  std_logic;
signal tmp_bitheapResult_bh14_18 :  std_logic_vector(18 downto 0);
signal bitheapFinalAdd_bh14_In0 :  std_logic_vector(23 downto 0);
signal bitheapFinalAdd_bh14_In1 :  std_logic_vector(23 downto 0);
signal bitheapFinalAdd_bh14_Cin :  std_logic;
signal bitheapFinalAdd_bh14_Out :  std_logic_vector(23 downto 0);
signal bitheapResult_bh14 :  std_logic_vector(41 downto 0);
begin
   XX_m13 <= X ;
   YY_m13 <= Y ;
   tile_0_X <= X(16 downto 0);
   tile_0_Y <= Y(20 downto 0);
   tile_0_mult: DSPBlock_17x21_F0_uid16
      port map ( X => tile_0_X,
                 Y => tile_0_Y,
                 R => tile_0_output);

   tile_0_filtered_output <= signed(tile_0_output(37 downto 0));
   bh14_w0_0 <= tile_0_filtered_output(0);
   bh14_w1_0 <= tile_0_filtered_output(1);
   bh14_w2_0 <= tile_0_filtered_output(2);
   bh14_w3_0 <= tile_0_filtered_output(3);
   bh14_w4_0 <= tile_0_filtered_output(4);
   bh14_w5_0 <= tile_0_filtered_output(5);
   bh14_w6_0 <= tile_0_filtered_output(6);
   bh14_w7_0 <= tile_0_filtered_output(7);
   bh14_w8_0 <= tile_0_filtered_output(8);
   bh14_w9_0 <= tile_0_filtered_output(9);
   bh14_w10_0 <= tile_0_filtered_output(10);
   bh14_w11_0 <= tile_0_filtered_output(11);
   bh14_w12_0 <= tile_0_filtered_output(12);
   bh14_w13_0 <= tile_0_filtered_output(13);
   bh14_w14_0 <= tile_0_filtered_output(14);
   bh14_w15_0 <= tile_0_filtered_output(15);
   bh14_w16_0 <= tile_0_filtered_output(16);
   bh14_w17_0 <= tile_0_filtered_output(17);
   bh14_w18_0 <= tile_0_filtered_output(18);
   bh14_w19_0 <= tile_0_filtered_output(19);
   bh14_w20_0 <= tile_0_filtered_output(20);
   bh14_w21_0 <= tile_0_filtered_output(21);
   bh14_w22_0 <= tile_0_filtered_output(22);
   bh14_w23_0 <= tile_0_filtered_output(23);
   bh14_w24_0 <= tile_0_filtered_output(24);
   bh14_w25_0 <= tile_0_filtered_output(25);
   bh14_w26_0 <= tile_0_filtered_output(26);
   bh14_w27_0 <= tile_0_filtered_output(27);
   bh14_w28_0 <= tile_0_filtered_output(28);
   bh14_w29_0 <= tile_0_filtered_output(29);
   bh14_w30_0 <= tile_0_filtered_output(30);
   bh14_w31_0 <= tile_0_filtered_output(31);
   bh14_w32_0 <= tile_0_filtered_output(32);
   bh14_w33_0 <= tile_0_filtered_output(33);
   bh14_w34_0 <= tile_0_filtered_output(34);
   bh14_w35_0 <= tile_0_filtered_output(35);
   bh14_w36_0 <= tile_0_filtered_output(36);
   bh14_w37_0 <= not tile_0_filtered_output(37);
   tile_1_X <= X(20 downto 17);
   tile_1_Y <= Y(20 downto 0);
   tile_1_mult: DSPBlock_4x21_F0_uid18
      port map ( X => tile_1_X,
                 Y => tile_1_Y,
                 R => tile_1_output);

   tile_1_filtered_output <= signed(tile_1_output(24 downto 0));
   bh14_w17_1 <= tile_1_filtered_output(0);
   bh14_w18_1 <= tile_1_filtered_output(1);
   bh14_w19_1 <= tile_1_filtered_output(2);
   bh14_w20_1 <= tile_1_filtered_output(3);
   bh14_w21_1 <= tile_1_filtered_output(4);
   bh14_w22_1 <= tile_1_filtered_output(5);
   bh14_w23_1 <= tile_1_filtered_output(6);
   bh14_w24_1 <= tile_1_filtered_output(7);
   bh14_w25_1 <= tile_1_filtered_output(8);
   bh14_w26_1 <= tile_1_filtered_output(9);
   bh14_w27_1 <= tile_1_filtered_output(10);
   bh14_w28_1 <= tile_1_filtered_output(11);
   bh14_w29_1 <= tile_1_filtered_output(12);
   bh14_w30_1 <= tile_1_filtered_output(13);
   bh14_w31_1 <= tile_1_filtered_output(14);
   bh14_w32_1 <= tile_1_filtered_output(15);
   bh14_w33_1 <= tile_1_filtered_output(16);
   bh14_w34_1 <= tile_1_filtered_output(17);
   bh14_w35_1 <= tile_1_filtered_output(18);
   bh14_w36_1 <= tile_1_filtered_output(19);
   bh14_w37_1 <= tile_1_filtered_output(20);
   bh14_w38_0 <= tile_1_filtered_output(21);
   bh14_w39_0 <= tile_1_filtered_output(22);
   bh14_w40_0 <= tile_1_filtered_output(23);
   bh14_w41_0 <= not tile_1_filtered_output(24);

   -- Adding the constant bits 
   bh14_w37_2 <= '1';
   bh14_w38_1 <= '1';
   bh14_w39_1 <= '1';
   bh14_w40_1 <= '1';


   Compressor_23_3_F0_uid21_bh14_uid22_In0 <= "" & bh14_w17_0 & bh14_w17_1 & "0";
   Compressor_23_3_F0_uid21_bh14_uid22_In1 <= "" & bh14_w18_0 & bh14_w18_1;
   Compressor_23_3_F0_uid21_uid22: Compressor_23_3_F0_uid21
      port map ( X0 => Compressor_23_3_F0_uid21_bh14_uid22_In0,
                 X1 => Compressor_23_3_F0_uid21_bh14_uid22_In1,
                 R => Compressor_23_3_F0_uid21_bh14_uid22_Out0);

   bh14_w17_2 <= Compressor_23_3_F0_uid21_bh14_uid22_Out0(0);
   bh14_w18_2 <= Compressor_23_3_F0_uid21_bh14_uid22_Out0(1);
   bh14_w19_2 <= Compressor_23_3_F0_uid21_bh14_uid22_Out0(2);

   Compressor_23_3_F0_uid21_bh14_uid23_In0 <= "" & bh14_w19_0 & bh14_w19_1 & "0";
   Compressor_23_3_F0_uid21_bh14_uid23_In1 <= "" & bh14_w20_0 & bh14_w20_1;
   Compressor_23_3_F0_uid21_uid23: Compressor_23_3_F0_uid21
      port map ( X0 => Compressor_23_3_F0_uid21_bh14_uid23_In0,
                 X1 => Compressor_23_3_F0_uid21_bh14_uid23_In1,
                 R => Compressor_23_3_F0_uid21_bh14_uid23_Out0);

   bh14_w19_3 <= Compressor_23_3_F0_uid21_bh14_uid23_Out0(0);
   bh14_w20_2 <= Compressor_23_3_F0_uid21_bh14_uid23_Out0(1);
   bh14_w21_2 <= Compressor_23_3_F0_uid21_bh14_uid23_Out0(2);

   Compressor_23_3_F0_uid21_bh14_uid24_In0 <= "" & bh14_w21_0 & bh14_w21_1 & "0";
   Compressor_23_3_F0_uid21_bh14_uid24_In1 <= "" & bh14_w22_0 & bh14_w22_1;
   Compressor_23_3_F0_uid21_uid24: Compressor_23_3_F0_uid21
      port map ( X0 => Compressor_23_3_F0_uid21_bh14_uid24_In0,
                 X1 => Compressor_23_3_F0_uid21_bh14_uid24_In1,
                 R => Compressor_23_3_F0_uid21_bh14_uid24_Out0);

   bh14_w21_3 <= Compressor_23_3_F0_uid21_bh14_uid24_Out0(0);
   bh14_w22_2 <= Compressor_23_3_F0_uid21_bh14_uid24_Out0(1);
   bh14_w23_2 <= Compressor_23_3_F0_uid21_bh14_uid24_Out0(2);

   Compressor_23_3_F0_uid21_bh14_uid25_In0 <= "" & bh14_w23_0 & bh14_w23_1 & "0";
   Compressor_23_3_F0_uid21_bh14_uid25_In1 <= "" & bh14_w24_0 & bh14_w24_1;
   Compressor_23_3_F0_uid21_uid25: Compressor_23_3_F0_uid21
      port map ( X0 => Compressor_23_3_F0_uid21_bh14_uid25_In0,
                 X1 => Compressor_23_3_F0_uid21_bh14_uid25_In1,
                 R => Compressor_23_3_F0_uid21_bh14_uid25_Out0);

   bh14_w23_3 <= Compressor_23_3_F0_uid21_bh14_uid25_Out0(0);
   bh14_w24_2 <= Compressor_23_3_F0_uid21_bh14_uid25_Out0(1);
   bh14_w25_2 <= Compressor_23_3_F0_uid21_bh14_uid25_Out0(2);

   Compressor_23_3_F0_uid21_bh14_uid26_In0 <= "" & bh14_w25_0 & bh14_w25_1 & "0";
   Compressor_23_3_F0_uid21_bh14_uid26_In1 <= "" & bh14_w26_0 & bh14_w26_1;
   Compressor_23_3_F0_uid21_uid26: Compressor_23_3_F0_uid21
      port map ( X0 => Compressor_23_3_F0_uid21_bh14_uid26_In0,
                 X1 => Compressor_23_3_F0_uid21_bh14_uid26_In1,
                 R => Compressor_23_3_F0_uid21_bh14_uid26_Out0);

   bh14_w25_3 <= Compressor_23_3_F0_uid21_bh14_uid26_Out0(0);
   bh14_w26_2 <= Compressor_23_3_F0_uid21_bh14_uid26_Out0(1);
   bh14_w27_2 <= Compressor_23_3_F0_uid21_bh14_uid26_Out0(2);

   Compressor_23_3_F0_uid21_bh14_uid27_In0 <= "" & bh14_w27_0 & bh14_w27_1 & "0";
   Compressor_23_3_F0_uid21_bh14_uid27_In1 <= "" & bh14_w28_0 & bh14_w28_1;
   Compressor_23_3_F0_uid21_uid27: Compressor_23_3_F0_uid21
      port map ( X0 => Compressor_23_3_F0_uid21_bh14_uid27_In0,
                 X1 => Compressor_23_3_F0_uid21_bh14_uid27_In1,
                 R => Compressor_23_3_F0_uid21_bh14_uid27_Out0);

   bh14_w27_3 <= Compressor_23_3_F0_uid21_bh14_uid27_Out0(0);
   bh14_w28_2 <= Compressor_23_3_F0_uid21_bh14_uid27_Out0(1);
   bh14_w29_2 <= Compressor_23_3_F0_uid21_bh14_uid27_Out0(2);

   Compressor_23_3_F0_uid21_bh14_uid28_In0 <= "" & bh14_w29_0 & bh14_w29_1 & "0";
   Compressor_23_3_F0_uid21_bh14_uid28_In1 <= "" & bh14_w30_0 & bh14_w30_1;
   Compressor_23_3_F0_uid21_uid28: Compressor_23_3_F0_uid21
      port map ( X0 => Compressor_23_3_F0_uid21_bh14_uid28_In0,
                 X1 => Compressor_23_3_F0_uid21_bh14_uid28_In1,
                 R => Compressor_23_3_F0_uid21_bh14_uid28_Out0);

   bh14_w29_3 <= Compressor_23_3_F0_uid21_bh14_uid28_Out0(0);
   bh14_w30_2 <= Compressor_23_3_F0_uid21_bh14_uid28_Out0(1);
   bh14_w31_2 <= Compressor_23_3_F0_uid21_bh14_uid28_Out0(2);

   Compressor_23_3_F0_uid21_bh14_uid29_In0 <= "" & bh14_w31_0 & bh14_w31_1 & "0";
   Compressor_23_3_F0_uid21_bh14_uid29_In1 <= "" & bh14_w32_0 & bh14_w32_1;
   Compressor_23_3_F0_uid21_uid29: Compressor_23_3_F0_uid21
      port map ( X0 => Compressor_23_3_F0_uid21_bh14_uid29_In0,
                 X1 => Compressor_23_3_F0_uid21_bh14_uid29_In1,
                 R => Compressor_23_3_F0_uid21_bh14_uid29_Out0);

   bh14_w31_3 <= Compressor_23_3_F0_uid21_bh14_uid29_Out0(0);
   bh14_w32_2 <= Compressor_23_3_F0_uid21_bh14_uid29_Out0(1);
   bh14_w33_2 <= Compressor_23_3_F0_uid21_bh14_uid29_Out0(2);

   Compressor_23_3_F0_uid21_bh14_uid30_In0 <= "" & bh14_w33_0 & bh14_w33_1 & "0";
   Compressor_23_3_F0_uid21_bh14_uid30_In1 <= "" & bh14_w34_0 & bh14_w34_1;
   Compressor_23_3_F0_uid21_uid30: Compressor_23_3_F0_uid21
      port map ( X0 => Compressor_23_3_F0_uid21_bh14_uid30_In0,
                 X1 => Compressor_23_3_F0_uid21_bh14_uid30_In1,
                 R => Compressor_23_3_F0_uid21_bh14_uid30_Out0);

   bh14_w33_3 <= Compressor_23_3_F0_uid21_bh14_uid30_Out0(0);
   bh14_w34_2 <= Compressor_23_3_F0_uid21_bh14_uid30_Out0(1);
   bh14_w35_2 <= Compressor_23_3_F0_uid21_bh14_uid30_Out0(2);

   Compressor_23_3_F0_uid21_bh14_uid31_In0 <= "" & bh14_w35_0 & bh14_w35_1 & "0";
   Compressor_23_3_F0_uid21_bh14_uid31_In1 <= "" & bh14_w36_0 & bh14_w36_1;
   Compressor_23_3_F0_uid21_uid31: Compressor_23_3_F0_uid21
      port map ( X0 => Compressor_23_3_F0_uid21_bh14_uid31_In0,
                 X1 => Compressor_23_3_F0_uid21_bh14_uid31_In1,
                 R => Compressor_23_3_F0_uid21_bh14_uid31_Out0);

   bh14_w35_3 <= Compressor_23_3_F0_uid21_bh14_uid31_Out0(0);
   bh14_w36_2 <= Compressor_23_3_F0_uid21_bh14_uid31_Out0(1);
   bh14_w37_3 <= Compressor_23_3_F0_uid21_bh14_uid31_Out0(2);

   Compressor_23_3_F0_uid21_bh14_uid32_In0 <= "" & bh14_w37_0 & bh14_w37_1 & bh14_w37_2;
   Compressor_23_3_F0_uid21_bh14_uid32_In1 <= "" & bh14_w38_0 & bh14_w38_1;
   Compressor_23_3_F0_uid21_uid32: Compressor_23_3_F0_uid21
      port map ( X0 => Compressor_23_3_F0_uid21_bh14_uid32_In0,
                 X1 => Compressor_23_3_F0_uid21_bh14_uid32_In1,
                 R => Compressor_23_3_F0_uid21_bh14_uid32_Out0);

   bh14_w37_4 <= Compressor_23_3_F0_uid21_bh14_uid32_Out0(0);
   bh14_w38_2 <= Compressor_23_3_F0_uid21_bh14_uid32_Out0(1);
   bh14_w39_2 <= Compressor_23_3_F0_uid21_bh14_uid32_Out0(2);

   Compressor_23_3_F0_uid21_bh14_uid33_In0 <= "" & bh14_w39_0 & bh14_w39_1 & "0";
   Compressor_23_3_F0_uid21_bh14_uid33_In1 <= "" & bh14_w40_0 & bh14_w40_1;
   Compressor_23_3_F0_uid21_uid33: Compressor_23_3_F0_uid21
      port map ( X0 => Compressor_23_3_F0_uid21_bh14_uid33_In0,
                 X1 => Compressor_23_3_F0_uid21_bh14_uid33_In1,
                 R => Compressor_23_3_F0_uid21_bh14_uid33_Out0);

   bh14_w39_3 <= Compressor_23_3_F0_uid21_bh14_uid33_Out0(0);
   bh14_w40_2 <= Compressor_23_3_F0_uid21_bh14_uid33_Out0(1);
   bh14_w41_1 <= Compressor_23_3_F0_uid21_bh14_uid33_Out0(2);
   tmp_bitheapResult_bh14_18 <= bh14_w18_2 & bh14_w17_2 & bh14_w16_0 & bh14_w15_0 & bh14_w14_0 & bh14_w13_0 & bh14_w12_0 & bh14_w11_0 & bh14_w10_0 & bh14_w9_0 & bh14_w8_0 & bh14_w7_0 & bh14_w6_0 & bh14_w5_0 & bh14_w4_0 & bh14_w3_0 & bh14_w2_0 & bh14_w1_0 & bh14_w0_0;

   bitheapFinalAdd_bh14_In0 <= "0" & bh14_w41_1 & bh14_w40_2 & bh14_w39_3 & bh14_w38_2 & bh14_w37_4 & bh14_w36_2 & bh14_w35_3 & bh14_w34_2 & bh14_w33_3 & bh14_w32_2 & bh14_w31_3 & bh14_w30_2 & bh14_w29_3 & bh14_w28_2 & bh14_w27_3 & bh14_w26_2 & bh14_w25_3 & bh14_w24_2 & bh14_w23_3 & bh14_w22_2 & bh14_w21_3 & bh14_w20_2 & bh14_w19_3;
   bitheapFinalAdd_bh14_In1 <= "0" & bh14_w41_0 & "0" & bh14_w39_2 & "0" & bh14_w37_3 & "0" & bh14_w35_2 & "0" & bh14_w33_2 & "0" & bh14_w31_2 & "0" & bh14_w29_2 & "0" & bh14_w27_2 & "0" & bh14_w25_2 & "0" & bh14_w23_2 & "0" & bh14_w21_2 & "0" & bh14_w19_2;
   bitheapFinalAdd_bh14_Cin <= '0';

   bitheapFinalAdd_bh14: IntAdder_24_F0_uid35
      port map ( Cin => bitheapFinalAdd_bh14_Cin,
                 X => bitheapFinalAdd_bh14_In0,
                 Y => bitheapFinalAdd_bh14_In1,
                 R => bitheapFinalAdd_bh14_Out);
   bitheapResult_bh14 <= bitheapFinalAdd_bh14_Out(22 downto 0) & tmp_bitheapResult_bh14_18;
   R <= bitheapResult_bh14(41 downto 0);
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_9_F0_uid37
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_9_F0_uid37 is
    port (X : in  std_logic_vector(8 downto 0);
          Y : in  std_logic_vector(8 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(8 downto 0)   );
end entity;

architecture arch of IntAdder_9_F0_uid37 is
signal Rtmp :  std_logic_vector(8 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_9_F0_uid40
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_9_F0_uid40 is
    port (X : in  std_logic_vector(8 downto 0);
          Y : in  std_logic_vector(8 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(8 downto 0)   );
end entity;

architecture arch of IntAdder_9_F0_uid40 is
signal Rtmp :  std_logic_vector(8 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_8_F0_uid42
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y Cin
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_8_F0_uid42 is
    port (X : in  std_logic_vector(7 downto 0);
          Y : in  std_logic_vector(7 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(7 downto 0)   );
end entity;

architecture arch of IntAdder_8_F0_uid42 is
signal Rtmp :  std_logic_vector(7 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                    RightShifter216_by_max_176_F0_uid44
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca (2008-2011), Florent de Dinechin (2008-2019)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X S padBit
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity RightShifter216_by_max_176_F0_uid44 is
    port (X : in  std_logic_vector(215 downto 0);
          S : in  std_logic_vector(7 downto 0);
          padBit : in  std_logic;
          R : out  std_logic_vector(215 downto 0)   );
end entity;

architecture arch of RightShifter216_by_max_176_F0_uid44 is
signal ps :  std_logic_vector(7 downto 0);
signal level0 :  std_logic_vector(215 downto 0);
signal level1 :  std_logic_vector(216 downto 0);
signal level2 :  std_logic_vector(218 downto 0);
signal level3 :  std_logic_vector(222 downto 0);
signal level4 :  std_logic_vector(230 downto 0);
signal level5 :  std_logic_vector(246 downto 0);
signal level6 :  std_logic_vector(278 downto 0);
signal level7 :  std_logic_vector(342 downto 0);
signal level8 :  std_logic_vector(470 downto 0);
begin
   ps<= S;
   level0<= X;
   level1 <=  (0 downto 0 => padBit) & level0 when ps(0) = '1' else    level0 & (0 downto 0 => '0');
   R <= level8(470 downto 255);
   level2 <=  (1 downto 0 => padBit) & level1 when ps(1) = '1' else    level1 & (1 downto 0 => '0');
   R <= level8(470 downto 255);
   level3 <=  (3 downto 0 => padBit) & level2 when ps(2) = '1' else    level2 & (3 downto 0 => '0');
   R <= level8(470 downto 255);
   level4 <=  (7 downto 0 => padBit) & level3 when ps(3) = '1' else    level3 & (7 downto 0 => '0');
   R <= level8(470 downto 255);
   level5 <=  (15 downto 0 => padBit) & level4 when ps(4) = '1' else    level4 & (15 downto 0 => '0');
   R <= level8(470 downto 255);
   level6 <=  (31 downto 0 => padBit) & level5 when ps(5) = '1' else    level5 & (31 downto 0 => '0');
   R <= level8(470 downto 255);
   level7 <=  (63 downto 0 => padBit) & level6 when ps(6) = '1' else    level6 & (63 downto 0 => '0');
   R <= level8(470 downto 255);
   level8 <=  (127 downto 0 => padBit) & level7 when ps(7) = '1' else    level7 & (127 downto 0 => '0');
   R <= level8(470 downto 255);
end architecture;

--------------------------------------------------------------------------------
--                                  PositMAC
--                     (PositMAC_24_2_Quire_384_F0_uid2)
-- Inputs: this FMA computes A*B+C
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Raul Murillo (2021)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: A B C
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library std;
use std.textio.all;
library work;

entity PositMAC is
    port (A : in  std_logic_vector(23 downto 0);
          B : in  std_logic_vector(23 downto 0);
          C : in  std_logic_vector(383 downto 0);
          R : out  std_logic_vector(383 downto 0)   );
end entity;

architecture arch of PositMAC is
   component PositDecoder_24_2_F0_uid4 is
      port ( X : in  std_logic_vector(23 downto 0);
             Sign : out  std_logic;
             SF : out  std_logic_vector(7 downto 0);
             Frac : out  std_logic_vector(18 downto 0);
             NZN : out  std_logic   );
   end component;

   component PositDecoder_24_2_F0_uid8 is
      port ( X : in  std_logic_vector(23 downto 0);
             Sign : out  std_logic;
             SF : out  std_logic_vector(7 downto 0);
             Frac : out  std_logic_vector(18 downto 0);
             NZN : out  std_logic   );
   end component;

   component IntMultiplier_F0_uid12 is
      port ( X : in  std_logic_vector(20 downto 0);
             Y : in  std_logic_vector(20 downto 0);
             R : out  std_logic_vector(41 downto 0)   );
   end component;

   component IntAdder_9_F0_uid37 is
      port ( X : in  std_logic_vector(8 downto 0);
             Y : in  std_logic_vector(8 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(8 downto 0)   );
   end component;

   component IntAdder_9_F0_uid40 is
      port ( X : in  std_logic_vector(8 downto 0);
             Y : in  std_logic_vector(8 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(8 downto 0)   );
   end component;

   component IntAdder_8_F0_uid42 is
      port ( X : in  std_logic_vector(7 downto 0);
             Y : in  std_logic_vector(7 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(7 downto 0)   );
   end component;

   component RightShifter216_by_max_176_F0_uid44 is
      port ( X : in  std_logic_vector(215 downto 0);
             S : in  std_logic_vector(7 downto 0);
             padBit : in  std_logic;
             R : out  std_logic_vector(215 downto 0)   );
   end component;
   
   component brent_kung is
      generic(N: integer;
              S: integer);--Number of stages=log(N)
      port(
		a: in std_logic_vector((N-1) downto 0);
		b: in std_logic_vector((N-1) downto 0);
		cin: in std_logic;
		z: out std_logic_vector((N-1) downto 0);
		cout: out std_logic  );
   end component;

signal A_sgn :  std_logic;
signal A_sf :  std_logic_vector(7 downto 0);
signal A_f :  std_logic_vector(18 downto 0);
signal A_nzn :  std_logic;
signal B_sgn :  std_logic;
signal B_sf :  std_logic_vector(7 downto 0);
signal B_f :  std_logic_vector(18 downto 0);
signal B_nzn :  std_logic;
signal AB_nzn :  std_logic;
signal AB_nar :  std_logic;
signal AA_f :  std_logic_vector(20 downto 0);
signal BB_f :  std_logic_vector(20 downto 0);
signal AB_f :  std_logic_vector(41 downto 0);
signal AB_sgn :  std_logic;
signal AB_ovfExtra :  std_logic;
signal AB_ovf :  std_logic;
signal AB_normF :  std_logic_vector(38 downto 0);
signal AA_sf :  std_logic_vector(8 downto 0);
signal BB_sf :  std_logic_vector(8 downto 0);
signal AB_sf_tmp :  std_logic_vector(8 downto 0);
signal AB_sf :  std_logic_vector(8 downto 0);
signal neg_sf :  std_logic;
signal AB_effectiveSF :  std_logic_vector(7 downto 0);
signal adderInput :  std_logic_vector(7 downto 0);
signal adderBias :  std_logic_vector(7 downto 0);
signal ob :  std_logic;
signal AB_sfBiased :  std_logic_vector(7 downto 0);
signal paddedFrac :  std_logic_vector(215 downto 0);
signal fixedPosit :  std_logic_vector(215 downto 0);
signal quirePosit :  std_logic_vector(352 downto 0);
signal AB_quire :  std_logic_vector(383 downto 0);
signal zb :  std_logic;
signal ABC_add :  std_logic_vector(383 downto 0);
signal zeros :  std_logic_vector(382 downto 0);
signal C_nar :  std_logic;
signal ABC_nar :  std_logic;
signal result :  std_logic_vector(383 downto 0);
begin
--------------------------- Start of vhdl generation ---------------------------
---------------------------- Decode A & B operands ----------------------------
   A_decoder: PositDecoder_24_2_F0_uid4
      port map ( X => A,
                 Frac => A_f,
                 NZN => A_nzn,
                 SF => A_sf,
                 Sign => A_sgn);
   B_decoder: PositDecoder_24_2_F0_uid8
      port map ( X => B,
                 Frac => B_f,
                 NZN => B_nzn,
                 SF => B_sf,
                 Sign => B_sgn);
-------------------------------- Multiply A & B --------------------------------
   -- Sign and Special Cases Computation
   AB_nzn <= A_nzn AND B_nzn;
   AB_nar <= (A_sgn AND NOT(A_nzn)) OR (B_sgn AND NOT(B_nzn));
   -- Multiply the fractions
   AA_f <= A_sgn & NOT(A_sgn) & A_f;
   BB_f <= B_sgn & NOT(B_sgn) & B_f;
   FracMultiplier: IntMultiplier_F0_uid12
      port map ( X => AA_f,
                 Y => BB_f,
                 R => AB_f);
   AB_sgn <= AB_f(41);
   AB_ovfExtra <= NOT(AB_sgn) AND AB_f(40);
   AB_ovf <= AB_ovfExtra OR (AB_sgn XOR AB_f(39));
   AB_normF <= AB_f(38 downto 0) when AB_ovf = '1' else (AB_f(37 downto 0) & '0');
   -- Add the exponent values
   AA_sf <= A_sf(A_sf'high) & A_sf;
   BB_sf <= B_sf(B_sf'high) & B_sf;
   SFAdder: IntAdder_9_F0_uid37
      port map ( Cin => AB_ovfExtra,
                 X => AA_sf,
                 Y => BB_sf,
                 R => AB_sf_tmp);
   RoundingAdder: IntAdder_9_F0_uid40
      port map ( Cin => AB_ovf,
                 X => AB_sf_tmp,
                 Y => "000000000",
                 R => AB_sf);
-------------- Shift AB fraction into corresponding quire format --------------
   neg_sf <= AB_sf(8);
   AB_effectiveSF <= AB_sf(7 downto 0);
   adderInput <= NOT(AB_effectiveSF);
   adderBias <= "10110000" when neg_sf='0' else "11111111";
   ob <= '1';
   BiasedSFAdder: IntAdder_8_F0_uid42
      port map ( Cin => ob,
                 X => adderInput,
                 Y => adderBias,
                 R => AB_sfBiased);
   paddedFrac <= (NOT(AB_sgn) & AB_normF & "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000") when neg_sf='0' else ((215 downto 176 => AB_sgn) & NOT(AB_sgn) & AB_normF & "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000");
   Frac_RightShifter: RightShifter216_by_max_176_F0_uid44
      port map ( S => AB_sfBiased,
                 X => paddedFrac,
                 padBit => AB_sgn,
                 R => fixedPosit);
   quirePosit <= (fixedPosit & "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000") when neg_sf='0' else ((352 downto 216 => AB_sgn) & fixedPosit);
   AB_quire <= ((383 downto 353 => AB_sgn) & quirePosit) when AB_nzn='1' else AB_nar & (382 downto 0 => '0');
---------------------------------- Add quires ----------------------------------
   zb <= '0';
   --ABC_add <= std_logic_vector(unsigned(AB_quire) + unsigned(C));
   QuireAdder: brent_kung generic map(384, 9)
      port map ( a => C,
                 b => AB_quire,
                 cin => zb,
                 z => ABC_add,
                 cout => open);

   zeros <= (others => '0');
   C_nar <= C(383) when C(382 downto 0) = zeros else '0';
   ABC_nar <= AB_nar OR C_nar;
   result <= ABC_add when ABC_nar='0' else ('1' & zeros);
   R <= result;
---------------------------- End of vhdl generation ----------------------------
end architecture;

