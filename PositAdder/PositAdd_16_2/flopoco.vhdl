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
--                  RightShifterSticky14_by_max_14_F0_uid12
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca (2008-2011), Florent de Dinechin (2008-2019)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X S
-- Output signals: R Sticky

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity RightShifterSticky14_by_max_14_F0_uid12 is
    port (X : in  std_logic_vector(13 downto 0);
          S : in  std_logic_vector(3 downto 0);
          R : out  std_logic_vector(13 downto 0);
          Sticky : out  std_logic   );
end entity;

architecture arch of RightShifterSticky14_by_max_14_F0_uid12 is
signal ps :  std_logic_vector(3 downto 0);
signal level4 :  std_logic_vector(13 downto 0);
signal stk3 :  std_logic;
signal level3 :  std_logic_vector(13 downto 0);
signal stk2 :  std_logic;
signal level2 :  std_logic_vector(13 downto 0);
signal stk1 :  std_logic;
signal level1 :  std_logic_vector(13 downto 0);
signal stk0 :  std_logic;
signal level0 :  std_logic_vector(13 downto 0);
begin
   ps<= S;
   level4<= X;
   stk3 <= '1' when (level4(7 downto 0)/="00000000" and ps(3)='1')   else '0';
   level3 <=  level4 when  ps(3)='0'    else (7 downto 0 => '0') & level4(13 downto 8);
   stk2 <= '1' when (level3(3 downto 0)/="0000" and ps(2)='1') or stk3 ='1'   else '0';
   level2 <=  level3 when  ps(2)='0'    else (3 downto 0 => '0') & level3(13 downto 4);
   stk1 <= '1' when (level2(1 downto 0)/="00" and ps(1)='1') or stk2 ='1'   else '0';
   level1 <=  level2 when  ps(1)='0'    else (1 downto 0 => '0') & level2(13 downto 2);
   stk0 <= '1' when (level1(0 downto 0)/="0" and ps(0)='1') or stk1 ='1'   else '0';
   level0 <=  level1 when  ps(0)='0'    else (0 downto 0 => '0') & level1(13 downto 1);
   R <= level0;
   Sticky <= stk0;
end architecture;

--------------------------------------------------------------------------------
--                  LZCShifter_14_to_14_counting_16_F0_uid14
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Florent de Dinechin, Bogdan Pasca (2007-2016)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: I
-- Output signals: Count O

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity LZCShifter_14_to_14_counting_16_F0_uid14 is
    port (I : in  std_logic_vector(13 downto 0);
          Count : out  std_logic_vector(3 downto 0);
          O : out  std_logic_vector(13 downto 0)   );
end entity;

architecture arch of LZCShifter_14_to_14_counting_16_F0_uid14 is
signal level4 :  std_logic_vector(13 downto 0);
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
   count3<= '1' when level4(13 downto 6) = (13 downto 6=>'0') else '0';
   level3<= level4(13 downto 0) when count3='0' else level4(5 downto 0) & (7 downto 0 => '0');

   count2<= '1' when level3(13 downto 10) = (13 downto 10=>'0') else '0';
   level2<= level3(13 downto 0) when count2='0' else level3(9 downto 0) & (3 downto 0 => '0');

   count1<= '1' when level2(13 downto 12) = (13 downto 12=>'0') else '0';
   level1<= level2(13 downto 0) when count1='0' else level2(11 downto 0) & (1 downto 0 => '0');

   count0<= '1' when level1(13 downto 13) = (13 downto 13=>'0') else '0';
   level0<= level1(13 downto 0) when count0='0' else level1(12 downto 0) & (0 downto 0 => '0');

   O <= level0;
   sCount <= count3 & count2 & count1 & count0;
   Count <= sCount;
end architecture;

--------------------------------------------------------------------------------
--                  RightShifterSticky18_by_max_15_F0_uid16
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

entity RightShifterSticky18_by_max_15_F0_uid16 is
    port (X : in  std_logic_vector(17 downto 0);
          S : in  std_logic_vector(3 downto 0);
          padBit : in  std_logic;
          R : out  std_logic_vector(17 downto 0);
          Sticky : out  std_logic   );
end entity;

architecture arch of RightShifterSticky18_by_max_15_F0_uid16 is
signal ps :  std_logic_vector(3 downto 0);
signal level4 :  std_logic_vector(17 downto 0);
signal stk3 :  std_logic;
signal level3 :  std_logic_vector(17 downto 0);
signal stk2 :  std_logic;
signal level2 :  std_logic_vector(17 downto 0);
signal stk1 :  std_logic;
signal level1 :  std_logic_vector(17 downto 0);
signal stk0 :  std_logic;
signal level0 :  std_logic_vector(17 downto 0);
begin
   ps<= S;
   level4<= X;
   stk3 <= '1' when (level4(7 downto 0)/="00000000" and ps(3)='1')   else '0';
   level3 <=  level4 when  ps(3)='0'    else (7 downto 0 => padBit) & level4(17 downto 8);
   stk2 <= '1' when (level3(3 downto 0)/="0000" and ps(2)='1') or stk3 ='1'   else '0';
   level2 <=  level3 when  ps(2)='0'    else (3 downto 0 => padBit) & level3(17 downto 4);
   stk1 <= '1' when (level2(1 downto 0)/="00" and ps(1)='1') or stk2 ='1'   else '0';
   level1 <=  level2 when  ps(1)='0'    else (1 downto 0 => padBit) & level2(17 downto 2);
   stk0 <= '1' when (level1(0 downto 0)/="0" and ps(0)='1') or stk1 ='1'   else '0';
   level0 <=  level1 when  ps(0)='0'    else (0 downto 0 => padBit) & level1(17 downto 1);
   R <= level0;
   Sticky <= stk0;
end architecture;

--------------------------------------------------------------------------------
--                           PositAdd2_16_2_F0_uid2
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

entity PositAdd2_16_2_F0_uid2 is
    port (X : in  std_logic_vector(15 downto 0);
          Y : in  std_logic_vector(15 downto 0);
          R : out  std_logic_vector(15 downto 0)   );
end entity;

architecture arch of PositAdd2_16_2_F0_uid2 is
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

   component RightShifterSticky14_by_max_14_F0_uid12 is
      port ( X : in  std_logic_vector(13 downto 0);
             S : in  std_logic_vector(3 downto 0);
             R : out  std_logic_vector(13 downto 0);
             Sticky : out  std_logic   );
   end component;

   component LZCShifter_14_to_14_counting_16_F0_uid14 is
      port ( I : in  std_logic_vector(13 downto 0);
             Count : out  std_logic_vector(3 downto 0);
             O : out  std_logic_vector(13 downto 0)   );
   end component;

   component RightShifterSticky18_by_max_15_F0_uid16 is
      port ( X : in  std_logic_vector(17 downto 0);
             S : in  std_logic_vector(3 downto 0);
             padBit : in  std_logic;
             R : out  std_logic_vector(17 downto 0);
             Sticky : out  std_logic   );
   end component;

signal sign_X :  std_logic;
signal reg_X :  std_logic_vector(4 downto 0);
signal exp_X :  std_logic_vector(1 downto 0);
signal frac_X :  std_logic_vector(11 downto 0);
signal inf_X :  std_logic;
signal X_abs :  std_logic_vector(14 downto 0);
signal sign_Y :  std_logic;
signal reg_Y :  std_logic_vector(4 downto 0);
signal exp_Y :  std_logic_vector(1 downto 0);
signal frac_Y :  std_logic_vector(11 downto 0);
signal inf_Y :  std_logic;
signal Y_abs :  std_logic_vector(14 downto 0);
signal sf_X :  std_logic_vector(6 downto 0);
signal sf_Y :  std_logic_vector(6 downto 0);
signal OP :  std_logic;
signal inf :  std_logic;
signal is_larger :  std_logic;
signal larger_sign :  std_logic;
signal larger_sf :  std_logic_vector(6 downto 0);
signal larger_frac :  std_logic_vector(11 downto 0);
signal smaller_frac :  std_logic_vector(13 downto 0);
signal sf_diff :  std_logic_vector(7 downto 0);
signal diff_msb :  std_logic_vector(6 downto 0);
signal offset :  std_logic_vector(6 downto 0);
signal sup_offset :  std_logic_vector(2 downto 0);
signal shift_saturate :  std_logic;
signal frac_offset :  std_logic_vector(3 downto 0);
signal shifted_frac :  std_logic_vector(13 downto 0);
signal sticky :  std_logic;
signal add_frac :  std_logic_vector(15 downto 0);
signal ovf_frac :  std_logic;
signal useful_frac :  std_logic_vector(11 downto 0);
signal G_tmp :  std_logic;
signal R_tmp :  std_logic;
signal S_tmp :  std_logic;
signal frac_GR :  std_logic_vector(13 downto 0);
signal lzCount :  std_logic_vector(3 downto 0);
signal normFrac :  std_logic_vector(13 downto 0);
signal sf_add :  std_logic_vector(6 downto 0);
signal nzero :  std_logic;
signal FinalExp :  std_logic_vector(1 downto 0);
signal RegimeAns_tmp :  std_logic_vector(4 downto 0);
signal reg_sign :  std_logic;
signal FinalRegime :  std_logic_vector(4 downto 0);
signal input_shifter :  std_logic_vector(17 downto 0);
signal shift_offset :  std_logic_vector(3 downto 0);
signal pad :  std_logic;
signal shifted_ans :  std_logic_vector(17 downto 0);
signal S_bit_tmp :  std_logic;
signal tmp_ans :  std_logic_vector(14 downto 0);
signal LSB :  std_logic;
signal G_bit :  std_logic;
signal R_bit :  std_logic;
signal remain :  std_logic_vector(0 downto 0);
signal S_bit :  std_logic;
signal round :  std_logic;
signal result :  std_logic_vector(15 downto 0);
begin
--------------------------- Start of vhdl generation ---------------------------
------------------------------- Data Extraction -------------------------------
   X_decoder: PositDecoder_16_2_F0_uid4
      port map ( Input => X,
                 Abs_in => X_abs,
                 Exp => exp_X,
                 Frac => frac_X,
                 Reg => reg_X,
                 Sign => sign_X,
                 inf => inf_X,
                 z => open);
   Y_decoder: PositDecoder_16_2_F0_uid8
      port map ( Input => Y,
                 Abs_in => Y_abs,
                 Exp => exp_Y,
                 Frac => frac_Y,
                 Reg => reg_Y,
                 Sign => sign_Y,
                 inf => inf_Y,
                 z => open);
   -- Gather scale factors
sf_X <= reg_X & exp_X;
sf_Y <= reg_Y & exp_Y;
---------------------- Sign and Special Cases Computation ----------------------
OP <= sign_X XOR sign_Y;
inf <= inf_X OR inf_Y;
---------------------- Compare operands and adjust values ----------------------
is_larger<= '1' when X_abs > Y_abs else '0';
with is_larger  select  larger_sign <= 
   sign_X when '1',
   sign_Y when '0',
   '-' when others;
with is_larger  select  larger_sf <= 
   sf_X when '1',
   sf_Y when '0',
   "-------" when others;
with is_larger  select  larger_frac <= 
   frac_X when '1',
   frac_Y when '0',
   "------------" when others;
with is_larger  select  smaller_frac <= 
   (frac_Y & "00")  when '1',
   (frac_X & "00")  when '0',
   "--------------" when others;
sf_diff <= (sf_X(sf_X'high) & sf_X) - (sf_Y(sf_Y'high) & sf_Y);
diff_msb <= (others => sf_diff(sf_diff'high));
offset <= (diff_msb XOR sf_diff(6 downto 0)) + sf_diff(sf_diff'high);
sup_offset <= offset(6 downto 4);
shift_saturate <= '0' when sup_offset = "000" else '1';
with shift_saturate  select  frac_offset <=
   "1111" when '1',
   offset(3 downto 0) when '0',
   "----" when others;
------------------------------- Align mantissas -------------------------------
   mantissa_shifter: RightShifterSticky14_by_max_14_F0_uid12
      port map ( S => frac_offset,
                 X => smaller_frac,
                 R => shifted_frac,
                 Sticky => sticky);
---------------------------- Add aligned mantissas ----------------------------
with OP  select  add_frac <= 
   ('0' & larger_frac & "000") + ('0' & shifted_frac & sticky) when '0',
   ('0' & larger_frac & "000") - ('0' & shifted_frac & sticky) when '1',
   "----------------" when others;
ovf_frac <= add_frac(add_frac'high);
with ovf_frac  select  useful_frac <=
   add_frac(15 downto 4) when '1',
   add_frac(14 downto 3) when '0',
   "------------" when others;
with ovf_frac  select  G_tmp <=
   add_frac(3) when '1',
   add_frac(2) when '0',
   '-' when others;
with ovf_frac  select  R_tmp <=
   add_frac(2) when '1',
   add_frac(1) when '0',
   '-' when others;
with ovf_frac  select  S_tmp <=
   add_frac(1) OR add_frac(0) when '1',
   add_frac(0) when '0',
   '-' when others;
frac_GR <= useful_frac & G_tmp & R_tmp;
   -- Normalization of add_frac
   align_mantissa: LZCShifter_14_to_14_counting_16_F0_uid14
      port map ( I => frac_GR,
                 Count => lzCount,
                 O => normFrac);
   -- Adjust exponent
sf_add <= larger_sf + ovf_frac - lzCount;
---------------------- Compute Regime and Exponent value ----------------------
nzero <= '0' when frac_GR = "00000000000000" else '1';
   -- Unpack scaling factors
FinalExp <= sf_add(1 downto 0);
RegimeAns_tmp <= sf_add(6 downto 2);
reg_sign <= RegimeAns_tmp(RegimeAns_tmp'high);
   -- Get Regime's absolute value
with reg_sign  select  FinalRegime <=
   (NOT RegimeAns_tmp) + 1 when '1',
   RegimeAns_tmp when '0',
   "-----" when others;
------------------------------- Packing Stage 1 -------------------------------
with reg_sign  select  input_shifter<=
   '0' & nzero    & FinalExp    & normFrac(12 downto 0) & S_tmp when '1',
   nzero & '0'    & FinalExp    & normFrac(12 downto 0) & S_tmp when '0',
   "------------------" when others;
with reg_sign  select  shift_offset <=
   FinalRegime(3 downto 0) - 1 when '1',
   FinalRegime(3 downto 0) when '0',
   "----" when others;
pad<= input_shifter(input_shifter'high);
   right_signed_shifter: RightShifterSticky18_by_max_15_F0_uid16
      port map ( S => shift_offset,
                 X => input_shifter,
                 padBit => pad,
                 R => shifted_ans,
                 Sticky => S_bit_tmp);
tmp_ans <= shifted_ans(17 downto 3);
--------------------- Packing Stage 2 - Unbiased Rounding ---------------------
LSB <= shifted_ans(3);
G_bit <= shifted_ans(2);
R_bit <= shifted_ans(1);
remain <= shifted_ans(0 downto 0);
S_bit <= S_bit_tmp when remain = "0" else '1';
round <= G_bit AND (LSB OR R_bit OR S_bit);
with larger_sign  select  result<=
   '0' & (tmp_ans + round) when '0',
   '1' & ((NOT(tmp_ans + round))+1) when '1',
   "----------------" when others;
R <= '1' & "000000000000000" when inf = '1' else 
   "0000000000000000" when nzero = '0' else
    result;
---------------------------- End of vhdl generation ----------------------------
end architecture;

