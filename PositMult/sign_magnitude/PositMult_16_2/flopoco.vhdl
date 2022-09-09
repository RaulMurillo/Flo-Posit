--------------------------------------------------------------------------------
--                  LZOCShifter_14_to_14_counting_16_F0_uid6
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Florent de Dinechin, Bogdan Pasca (2007-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: I OZb
-- Output signals: Count O

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity LZOCShifter_14_to_14_counting_16_F0_uid6 is
    port (I : in  std_logic_vector(13 downto 0);
          OZb : in  std_logic;
          Count : out  std_logic_vector(3 downto 0);
          O : out  std_logic_vector(13 downto 0)   );
end entity;

architecture arch of LZOCShifter_14_to_14_counting_16_F0_uid6 is
signal level4 :  std_logic_vector(13 downto 0);
signal sozb :  std_logic;
signal count3 :  std_logic;
signal level3 :  std_logic_vector(13 downto 0);
signal count2 :  std_logic;
signal level2 :  std_logic_vector(13 downto 0);
signal count1 :  std_logic;
signal level1 :  std_logic_vector(13 downto 0);
signal count0 :  std_logic;
signal level0 :  std_logic_vector(13 downto 0);
signal sCount :  std_logic_vector(3 downto 0);
begin
   level4 <= I ;
   sozb<= OZb;
   count3<= '1' when level4(13 downto 6) = (13 downto 6=>sozb) else '0';
   level3<= level4(13 downto 0) when count3='0' else level4(5 downto 0) & (7 downto 0 => '0');

   count2<= '1' when level3(13 downto 10) = (13 downto 10=>sozb) else '0';
   level2<= level3(13 downto 0) when count2='0' else level3(9 downto 0) & (3 downto 0 => '0');

   count1<= '1' when level2(13 downto 12) = (13 downto 12=>sozb) else '0';
   level1<= level2(13 downto 0) when count1='0' else level2(11 downto 0) & (1 downto 0 => '0');

   count0<= '1' when level1(13 downto 13) = (13 downto 13=>sozb) else '0';
   level0<= level1(13 downto 0) when count0='0' else level1(12 downto 0) & (0 downto 0 => '0');

   O <= level0;
   sCount <= count3 & count2 & count1 & count0;
   Count <= sCount;
end architecture;

--------------------------------------------------------------------------------
--                         PositDecoder_16_2_F0_uid4
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Raul Murillo, Alberto A. del Barrio, Guillermo Botella, 2020
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: Input
-- Output signals: Sign Reg Exp Frac z inf Abs_in

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity PositDecoder_16_2_F0_uid4 is
    port (Input : in  std_logic_vector(15 downto 0);
          Sign : out  std_logic;
          Reg : out  std_logic_vector(4 downto 0);
          Exp : out  std_logic_vector(1 downto 0);
          Frac : out  std_logic_vector(11 downto 0);
          z : out  std_logic;
          inf : out  std_logic;
          Abs_in : out  std_logic_vector(14 downto 0)   );
end entity;

architecture arch of PositDecoder_16_2_F0_uid4 is
   component LZOCShifter_14_to_14_counting_16_F0_uid6 is
      port ( I : in  std_logic_vector(13 downto 0);
             OZb : in  std_logic;
             Count : out  std_logic_vector(3 downto 0);
             O : out  std_logic_vector(13 downto 0)   );
   end component;

signal s :  std_logic;
signal nzero :  std_logic;
signal is_zero :  std_logic;
signal is_NAR :  std_logic;
signal rep_sign :  std_logic_vector(14 downto 0);
signal twos :  std_logic_vector(14 downto 0);
signal rc :  std_logic;
signal remainder :  std_logic_vector(13 downto 0);
signal lzCount :  std_logic_vector(3 downto 0);
signal usefulBits :  std_logic_vector(13 downto 0);
signal final_reg :  std_logic_vector(4 downto 0);
begin
--------------------------- Start of vhdl generation ---------------------------
------------------------------- Extract Sign bit -------------------------------
s <= Input(15);
Sign <= s;
-------------------------------- Special Cases --------------------------------
nzero <= Input(14) when Input(13 downto 0) = "00000000000000" else '1';
   -- 1 if Input is zero
is_zero <= s NOR nzero;
z <= is_zero;
   -- 1 if Input is infinity
is_NAR<= s AND (NOT nzero);
inf <= is_NAR;
--------------------------- 2's Complement of Input ---------------------------
rep_sign <= (others => s);
twos <= (rep_sign XOR Input(14 downto 0)) + s;
rc <= twos(twos'high);
----------------- Count leading zeros of regime & shift it out -----------------
remainder<= twos(13 downto 0);
   lzoc: LZOCShifter_14_to_14_counting_16_F0_uid6
      port map ( I => remainder,
                 OZb => rc,
                 Count => lzCount,
                 O => usefulBits);
------------------------ Extract fraction and exponent ------------------------
Frac <= nzero & usefulBits(10 downto 0);
Exp <= usefulBits(12 downto 11);
-------------------------------- Select regime --------------------------------
with rc  select  final_reg<= 
   "0" & lzCount when '1',
   NOT("0" & lzCount)  when '0',
   "-----" when others;
Reg <= final_reg;
Abs_in <= twos;
---------------------------- End of vhdl generation ----------------------------
end architecture;

--------------------------------------------------------------------------------
--                 LZOCShifter_14_to_14_counting_16_F0_uid10
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Florent de Dinechin, Bogdan Pasca (2007-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: I OZb
-- Output signals: Count O

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity LZOCShifter_14_to_14_counting_16_F0_uid10 is
    port (I : in  std_logic_vector(13 downto 0);
          OZb : in  std_logic;
          Count : out  std_logic_vector(3 downto 0);
          O : out  std_logic_vector(13 downto 0)   );
end entity;

architecture arch of LZOCShifter_14_to_14_counting_16_F0_uid10 is
signal level4 :  std_logic_vector(13 downto 0);
signal sozb :  std_logic;
signal count3 :  std_logic;
signal level3 :  std_logic_vector(13 downto 0);
signal count2 :  std_logic;
signal level2 :  std_logic_vector(13 downto 0);
signal count1 :  std_logic;
signal level1 :  std_logic_vector(13 downto 0);
signal count0 :  std_logic;
signal level0 :  std_logic_vector(13 downto 0);
signal sCount :  std_logic_vector(3 downto 0);
begin
   level4 <= I ;
   sozb<= OZb;
   count3<= '1' when level4(13 downto 6) = (13 downto 6=>sozb) else '0';
   level3<= level4(13 downto 0) when count3='0' else level4(5 downto 0) & (7 downto 0 => '0');

   count2<= '1' when level3(13 downto 10) = (13 downto 10=>sozb) else '0';
   level2<= level3(13 downto 0) when count2='0' else level3(9 downto 0) & (3 downto 0 => '0');

   count1<= '1' when level2(13 downto 12) = (13 downto 12=>sozb) else '0';
   level1<= level2(13 downto 0) when count1='0' else level2(11 downto 0) & (1 downto 0 => '0');

   count0<= '1' when level1(13 downto 13) = (13 downto 13=>sozb) else '0';
   level0<= level1(13 downto 0) when count0='0' else level1(12 downto 0) & (0 downto 0 => '0');

   O <= level0;
   sCount <= count3 & count2 & count1 & count0;
   Count <= sCount;
end architecture;

--------------------------------------------------------------------------------
--                         PositDecoder_16_2_F0_uid8
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Raul Murillo, Alberto A. del Barrio, Guillermo Botella, 2020
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: Input
-- Output signals: Sign Reg Exp Frac z inf Abs_in

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity PositDecoder_16_2_F0_uid8 is
    port (Input : in  std_logic_vector(15 downto 0);
          Sign : out  std_logic;
          Reg : out  std_logic_vector(4 downto 0);
          Exp : out  std_logic_vector(1 downto 0);
          Frac : out  std_logic_vector(11 downto 0);
          z : out  std_logic;
          inf : out  std_logic;
          Abs_in : out  std_logic_vector(14 downto 0)   );
end entity;

architecture arch of PositDecoder_16_2_F0_uid8 is
   component LZOCShifter_14_to_14_counting_16_F0_uid10 is
      port ( I : in  std_logic_vector(13 downto 0);
             OZb : in  std_logic;
             Count : out  std_logic_vector(3 downto 0);
             O : out  std_logic_vector(13 downto 0)   );
   end component;

signal s :  std_logic;
signal nzero :  std_logic;
signal is_zero :  std_logic;
signal is_NAR :  std_logic;
signal rep_sign :  std_logic_vector(14 downto 0);
signal twos :  std_logic_vector(14 downto 0);
signal rc :  std_logic;
signal remainder :  std_logic_vector(13 downto 0);
signal lzCount :  std_logic_vector(3 downto 0);
signal usefulBits :  std_logic_vector(13 downto 0);
signal final_reg :  std_logic_vector(4 downto 0);
begin
--------------------------- Start of vhdl generation ---------------------------
------------------------------- Extract Sign bit -------------------------------
s <= Input(15);
Sign <= s;
-------------------------------- Special Cases --------------------------------
nzero <= Input(14) when Input(13 downto 0) = "00000000000000" else '1';
   -- 1 if Input is zero
is_zero <= s NOR nzero;
z <= is_zero;
   -- 1 if Input is infinity
is_NAR<= s AND (NOT nzero);
inf <= is_NAR;
--------------------------- 2's Complement of Input ---------------------------
rep_sign <= (others => s);
twos <= (rep_sign XOR Input(14 downto 0)) + s;
rc <= twos(twos'high);
----------------- Count leading zeros of regime & shift it out -----------------
remainder<= twos(13 downto 0);
   lzoc: LZOCShifter_14_to_14_counting_16_F0_uid10
      port map ( I => remainder,
                 OZb => rc,
                 Count => lzCount,
                 O => usefulBits);
------------------------ Extract fraction and exponent ------------------------
Frac <= nzero & usefulBits(10 downto 0);
Exp <= usefulBits(12 downto 11);
-------------------------------- Select regime --------------------------------
with rc  select  final_reg<= 
   "0" & lzCount when '1',
   NOT("0" & lzCount)  when '0',
   "-----" when others;
Reg <= final_reg;
Abs_in <= twos;
---------------------------- End of vhdl generation ----------------------------
end architecture;

--------------------------------------------------------------------------------
--                  RightShifterSticky27_by_max_15_F0_uid12
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca (2008-2011), Florent de Dinechin (2008-2019)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X S padBit
-- Output signals: R Sticky

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity RightShifterSticky27_by_max_15_F0_uid12 is
    port (X : in  std_logic_vector(26 downto 0);
          S : in  std_logic_vector(3 downto 0);
          padBit : in  std_logic;
          R : out  std_logic_vector(26 downto 0);
          Sticky : out  std_logic   );
end entity;

architecture arch of RightShifterSticky27_by_max_15_F0_uid12 is
signal ps :  std_logic_vector(3 downto 0);
signal level4 :  std_logic_vector(26 downto 0);
signal stk3 :  std_logic;
signal level3 :  std_logic_vector(26 downto 0);
signal stk2 :  std_logic;
signal level2 :  std_logic_vector(26 downto 0);
signal stk1 :  std_logic;
signal level1 :  std_logic_vector(26 downto 0);
signal stk0 :  std_logic;
signal level0 :  std_logic_vector(26 downto 0);
begin
   ps<= S;
   level4<= X;
   stk3 <= '1' when (level4(7 downto 0)/="00000000" and ps(3)='1')   else '0';
   level3 <=  level4 when  ps(3)='0'    else (7 downto 0 => padBit) & level4(26 downto 8);
   stk2 <= '1' when (level3(3 downto 0)/="0000" and ps(2)='1') or stk3 ='1'   else '0';
   level2 <=  level3 when  ps(2)='0'    else (3 downto 0 => padBit) & level3(26 downto 4);
   stk1 <= '1' when (level2(1 downto 0)/="00" and ps(1)='1') or stk2 ='1'   else '0';
   level1 <=  level2 when  ps(1)='0'    else (1 downto 0 => padBit) & level2(26 downto 2);
   stk0 <= '1' when (level1(0 downto 0)/="0" and ps(0)='1') or stk1 ='1'   else '0';
   level0 <=  level1 when  ps(0)='0'    else (0 downto 0 => padBit) & level1(26 downto 1);
   R <= level0;
   Sticky <= stk0;
end architecture;

--------------------------------------------------------------------------------
--                           PositMult_16_2_F0_uid2
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Raul Murillo, Alberto A. del Barrio, Guillermo Botella, 2020
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity PositMult_16_2_F0_uid2 is
    port (X : in  std_logic_vector(15 downto 0);
          Y : in  std_logic_vector(15 downto 0);
          R : out  std_logic_vector(15 downto 0)   );
end entity;

architecture arch of PositMult_16_2_F0_uid2 is
   component PositDecoder_16_2_F0_uid4 is
      port ( Input : in  std_logic_vector(15 downto 0);
             Sign : out  std_logic;
             Reg : out  std_logic_vector(4 downto 0);
             Exp : out  std_logic_vector(1 downto 0);
             Frac : out  std_logic_vector(11 downto 0);
             z : out  std_logic;
             inf : out  std_logic;
             Abs_in : out  std_logic_vector(14 downto 0)   );
   end component;

   component PositDecoder_16_2_F0_uid8 is
      port ( Input : in  std_logic_vector(15 downto 0);
             Sign : out  std_logic;
             Reg : out  std_logic_vector(4 downto 0);
             Exp : out  std_logic_vector(1 downto 0);
             Frac : out  std_logic_vector(11 downto 0);
             z : out  std_logic;
             inf : out  std_logic;
             Abs_in : out  std_logic_vector(14 downto 0)   );
   end component;

   component RightShifterSticky27_by_max_15_F0_uid12 is
      port ( X : in  std_logic_vector(26 downto 0);
             S : in  std_logic_vector(3 downto 0);
             padBit : in  std_logic;
             R : out  std_logic_vector(26 downto 0);
             Sticky : out  std_logic   );
   end component;

signal sign_X :  std_logic;
signal reg_X :  std_logic_vector(4 downto 0);
signal exp_X :  std_logic_vector(1 downto 0);
signal frac_X :  std_logic_vector(11 downto 0);
signal z_X :  std_logic;
signal inf_X :  std_logic;
signal sign_Y :  std_logic;
signal reg_Y :  std_logic_vector(4 downto 0);
signal exp_Y :  std_logic_vector(1 downto 0);
signal frac_Y :  std_logic_vector(11 downto 0);
signal z_Y :  std_logic;
signal inf_Y :  std_logic;
signal sf_X :  std_logic_vector(6 downto 0);
signal sf_Y :  std_logic_vector(6 downto 0);
signal sign :  std_logic;
signal z :  std_logic;
signal inf :  std_logic;
signal frac_mult :  std_logic_vector(23 downto 0);
signal ovf_m :  std_logic;
signal normFrac :  std_logic_vector(24 downto 0);
signal sf_mult :  std_logic_vector(7 downto 0);
signal sf_sign :  std_logic;
signal nzero :  std_logic;
signal FinalExp :  std_logic_vector(1 downto 0);
signal RegimeAns_tmp :  std_logic_vector(4 downto 0);
signal RegimeAns :  std_logic_vector(4 downto 0);
signal reg_ovf :  std_logic;
signal FinalRegime :  std_logic_vector(4 downto 0);
signal input_shifter :  std_logic_vector(26 downto 0);
signal shift_offset :  std_logic_vector(3 downto 0);
signal pad :  std_logic;
signal shifted_frac :  std_logic_vector(26 downto 0);
signal S_bit_tmp :  std_logic;
signal tmp_ans :  std_logic_vector(14 downto 0);
signal LSB :  std_logic;
signal G_bit :  std_logic;
signal R_bit :  std_logic;
signal S_bit :  std_logic;
signal round :  std_logic;
signal result :  std_logic_vector(15 downto 0);
begin
--------------------------- Start of vhdl generation ---------------------------
------------------------------- Data Extraction -------------------------------
   X_decoder: PositDecoder_16_2_F0_uid4
      port map ( Input => X,
                 Abs_in => open,
                 Exp => exp_X,
                 Frac => frac_X,
                 Reg => reg_X,
                 Sign => sign_X,
                 inf => inf_X,
                 z => z_X);
   Y_decoder: PositDecoder_16_2_F0_uid8
      port map ( Input => Y,
                 Abs_in => open,
                 Exp => exp_Y,
                 Frac => frac_Y,
                 Reg => reg_Y,
                 Sign => sign_Y,
                 inf => inf_Y,
                 z => z_Y);
   -- Gather scale factors
sf_X <= reg_X & exp_X;
sf_Y <= reg_Y & exp_Y;
---------------------- Sign and Special Cases Computation ----------------------
sign <= sign_X XOR sign_Y;
z <= z_X OR z_Y;
inf <= inf_X OR inf_Y;
--------------- Multiply the fractions & add the exponent values ---------------
frac_mult <= frac_X * frac_Y;
   -- Adjust for overflow
ovf_m <= frac_mult(frac_mult'high);
with ovf_m  select  normFrac<= 
   frac_mult & '0' when '0',
   '0' & frac_mult when '1',
   "-------------------------" when others;
sf_mult <= (sf_X(sf_X'high) & sf_X) + (sf_Y(sf_Y'high) & sf_Y) + ovf_m;
sf_sign <= sf_mult(sf_mult'high);
---------------------- Compute Regime and Exponent value ----------------------
nzero <= '0' when frac_mult = "000000000000000000000000" else '1';
   -- Unpack scaling factors
FinalExp <= sf_mult(1 downto 0);
RegimeAns_tmp <= sf_mult(6 downto 2);
   -- Get Regime's absolute value
with sf_sign  select  RegimeAns<=
   (NOT RegimeAns_tmp) + 1 when '1',
   RegimeAns_tmp when '0',
   "-----" when others;
   -- Check for Regime overflow
reg_ovf <= '1' when RegimeAns > "01110" else '0';
with reg_ovf  select  FinalRegime <=
   "01110" when '1',
   RegimeAns when '0',
   "-----" when others;
------------------------------- Packing Stage 1 -------------------------------
with sf_sign  select  input_shifter<=
   '0' & nzero    & FinalExp    & normFrac(22 downto 0) when '1',
   nzero & '0'    & FinalExp    & normFrac(22 downto 0) when '0',
   "---------------------------" when others;
with sf_sign  select  shift_offset <=
   FinalRegime(3 downto 0) - 1 when '1',
   FinalRegime(3 downto 0) when '0',
   "----" when others;
pad<= input_shifter(input_shifter'high);
   right_signed_shifter: RightShifterSticky27_by_max_15_F0_uid12
      port map ( S => shift_offset,
                 X => input_shifter,
                 padBit => pad,
                 R => shifted_frac,
                 Sticky => S_bit_tmp);
tmp_ans <= shifted_frac(26 downto 12);
--------------------- Packing Stage 2 - Unbiased Rounding ---------------------
LSB <= shifted_frac(12);
G_bit <= shifted_frac(11);
R_bit <= shifted_frac(10);
S_bit <= S_bit_tmp when shifted_frac(9 downto 0) = "0000000000" else '1';
with reg_ovf  select  round<=
   '0' when '1',
   G_bit AND (LSB OR R_bit OR S_bit) when '0',
   '-' when others;
with sign  select  result<=
   '0' & (tmp_ans + round) when '0',
   '1' & ((NOT(tmp_ans + round))+1) when '1',
   "----------------" when others;
R <= '1' & "000000000000000" when inf = '1' else 
   "0000000000000000" when z = '1' else
    result;
---------------------------- End of vhdl generation ----------------------------
end architecture;

