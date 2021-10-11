--------------------------------------------------------------------------------
--                   LZOCShifter_6_to_6_counting_8_F0_uid6
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

entity LZOCShifter_6_to_6_counting_8_F0_uid6 is
    port (I : in  std_logic_vector(5 downto 0);
          OZb : in  std_logic;
          Count : out  std_logic_vector(2 downto 0);
          O : out  std_logic_vector(5 downto 0)   );
end entity;

architecture arch of LZOCShifter_6_to_6_counting_8_F0_uid6 is
signal level3 :  std_logic_vector(5 downto 0);
signal sozb :  std_logic;
signal count2 :  std_logic;
signal level2 :  std_logic_vector(5 downto 0);
signal count1 :  std_logic;
signal level1 :  std_logic_vector(5 downto 0);
signal count0 :  std_logic;
signal level0 :  std_logic_vector(5 downto 0);
signal sCount :  std_logic_vector(2 downto 0);
begin
   level3 <= I ;
   sozb<= OZb;
   count2<= '1' when level3(5 downto 2) = (5 downto 2=>sozb) else '0';
   level2<= level3(5 downto 0) when count2='0' else level3(1 downto 0) & (3 downto 0 => '0');

   count1<= '1' when level2(5 downto 4) = (5 downto 4=>sozb) else '0';
   level1<= level2(5 downto 0) when count1='0' else level2(3 downto 0) & (1 downto 0 => '0');

   count0<= '1' when level1(5 downto 5) = (5 downto 5=>sozb) else '0';
   level0<= level1(5 downto 0) when count0='0' else level1(4 downto 0) & (0 downto 0 => '0');

   O <= level0;
   sCount <= count2 & count1 & count0;
   Count <= sCount;
end architecture;

--------------------------------------------------------------------------------
--                         PositDecoder1_8_2_F0_uid4
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Raul Murillo, Alberto A. del Barrio, Guillermo Botella, 2020
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: Input
-- Output signals: Sign SF Frac Zero Inf Abs_in

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity PositDecoder1_8_2_F0_uid4 is
    port (Input : in  std_logic_vector(7 downto 0);
          Sign : out  std_logic;
          SF : out  std_logic_vector(5 downto 0);
          Frac : out  std_logic_vector(2 downto 0);
          Zero : out  std_logic;
          Inf : out  std_logic;
          Abs_in : out  std_logic_vector(6 downto 0)   );
end entity;

architecture arch of PositDecoder1_8_2_F0_uid4 is
   component LZOCShifter_6_to_6_counting_8_F0_uid6 is
      port ( I : in  std_logic_vector(5 downto 0);
             OZb : in  std_logic;
             Count : out  std_logic_vector(2 downto 0);
             O : out  std_logic_vector(5 downto 0)   );
   end component;

signal s :  std_logic;
signal special :  std_logic;
signal is_zero :  std_logic;
signal is_NAR :  std_logic;
signal rep_sign :  std_logic_vector(6 downto 0);
signal p_abs :  std_logic_vector(6 downto 0);
signal rc :  std_logic;
signal shifter_input :  std_logic_vector(5 downto 0);
signal lzCount :  std_logic_vector(2 downto 0);
signal shifted_p :  std_logic_vector(5 downto 0);
signal k :  std_logic_vector(3 downto 0);
begin
--------------------------- Start of vhdl generation ---------------------------
------------------------------- Extract Sign bit -------------------------------
   s <= Input(7);
   Sign <= s;
-------------------------------- Special Cases --------------------------------
   special <= '1' when Input(6 downto 0) = 0 else '0';
   -- 1 if Input is zero
   is_zero <= not(s) AND special;
   Zero <= is_zero;
   -- 1 if Input is infinity
   is_NAR<= s AND special;
   Inf <= is_NAR;
--------------------------- 2's Complement of Input ---------------------------
   rep_sign <= (others => s);
   p_abs <= (rep_sign XOR Input(6 downto 0)) + s;
   rc <= p_abs(p_abs'high);
-------------- Count leading zeros/ones of regime & shift it out --------------
   shifter_input <= p_abs(5 downto 0);
   lzoc: LZOCShifter_6_to_6_counting_8_F0_uid6
      port map ( I => shifter_input,
                 OZb => rc,
                 Count => lzCount,
                 O => shifted_p);
------------------------------- Extract fraction -------------------------------
   Frac <= shifted_p(2 downto 0);
-------------------- Extract scaling factor - regime & exp --------------------
   with rc  select  k <= 
      "0" & lzCount when '1',
      NOT("0" & lzCount) when '0',
      "----" when others;
   SF <= k & shifted_p(4 downto 3);
   Abs_in <= p_abs;
---------------------------- End of vhdl generation ----------------------------
end architecture;

--------------------------------------------------------------------------------
--                   LZOCShifter_6_to_6_counting_8_F0_uid10
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

entity LZOCShifter_6_to_6_counting_8_F0_uid10 is
    port (I : in  std_logic_vector(5 downto 0);
          OZb : in  std_logic;
          Count : out  std_logic_vector(2 downto 0);
          O : out  std_logic_vector(5 downto 0)   );
end entity;

architecture arch of LZOCShifter_6_to_6_counting_8_F0_uid10 is
signal level3 :  std_logic_vector(5 downto 0);
signal sozb :  std_logic;
signal count2 :  std_logic;
signal level2 :  std_logic_vector(5 downto 0);
signal count1 :  std_logic;
signal level1 :  std_logic_vector(5 downto 0);
signal count0 :  std_logic;
signal level0 :  std_logic_vector(5 downto 0);
signal sCount :  std_logic_vector(2 downto 0);
begin
   level3 <= I ;
   sozb<= OZb;
   count2<= '1' when level3(5 downto 2) = (5 downto 2=>sozb) else '0';
   level2<= level3(5 downto 0) when count2='0' else level3(1 downto 0) & (3 downto 0 => '0');

   count1<= '1' when level2(5 downto 4) = (5 downto 4=>sozb) else '0';
   level1<= level2(5 downto 0) when count1='0' else level2(3 downto 0) & (1 downto 0 => '0');

   count0<= '1' when level1(5 downto 5) = (5 downto 5=>sozb) else '0';
   level0<= level1(5 downto 0) when count0='0' else level1(4 downto 0) & (0 downto 0 => '0');

   O <= level0;
   sCount <= count2 & count1 & count0;
   Count <= sCount;
end architecture;

--------------------------------------------------------------------------------
--                         PositDecoder1_8_2_F0_uid8
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Raul Murillo, Alberto A. del Barrio, Guillermo Botella, 2020
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: Input
-- Output signals: Sign SF Frac Zero Inf Abs_in

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity PositDecoder1_8_2_F0_uid8 is
    port (Input : in  std_logic_vector(7 downto 0);
          Sign : out  std_logic;
          SF : out  std_logic_vector(5 downto 0);
          Frac : out  std_logic_vector(2 downto 0);
          Zero : out  std_logic;
          Inf : out  std_logic;
          Abs_in : out  std_logic_vector(6 downto 0)   );
end entity;

architecture arch of PositDecoder1_8_2_F0_uid8 is
   component LZOCShifter_6_to_6_counting_8_F0_uid10 is
      port ( I : in  std_logic_vector(5 downto 0);
             OZb : in  std_logic;
             Count : out  std_logic_vector(2 downto 0);
             O : out  std_logic_vector(5 downto 0)   );
   end component;

signal s :  std_logic;
signal special :  std_logic;
signal is_zero :  std_logic;
signal is_NAR :  std_logic;
signal rep_sign :  std_logic_vector(6 downto 0);
signal p_abs :  std_logic_vector(6 downto 0);
signal rc :  std_logic;
signal shifter_input :  std_logic_vector(5 downto 0);
signal lzCount :  std_logic_vector(2 downto 0);
signal shifted_p :  std_logic_vector(5 downto 0);
signal k :  std_logic_vector(3 downto 0);
begin
--------------------------- Start of vhdl generation ---------------------------
------------------------------- Extract Sign bit -------------------------------
   s <= Input(7);
   Sign <= s;
-------------------------------- Special Cases --------------------------------
   special <= '1' when Input(6 downto 0) = 0 else '0';
   -- 1 if Input is zero
   is_zero <= not(s) AND special;
   Zero <= is_zero;
   -- 1 if Input is infinity
   is_NAR<= s AND special;
   Inf <= is_NAR;
--------------------------- 2's Complement of Input ---------------------------
   rep_sign <= (others => s);
   p_abs <= (rep_sign XOR Input(6 downto 0)) + s;
   rc <= p_abs(p_abs'high);
-------------- Count leading zeros/ones of regime & shift it out --------------
   shifter_input <= p_abs(5 downto 0);
   lzoc: LZOCShifter_6_to_6_counting_8_F0_uid10
      port map ( I => shifter_input,
                 OZb => rc,
                 Count => lzCount,
                 O => shifted_p);
------------------------------- Extract fraction -------------------------------
   Frac <= shifted_p(2 downto 0);
-------------------- Extract scaling factor - regime & exp --------------------
   with rc  select  k <= 
      "0" & lzCount when '1',
      NOT("0" & lzCount) when '0',
      "----" when others;
   SF <= k & shifted_p(4 downto 3);
   Abs_in <= p_abs;
---------------------------- End of vhdl generation ----------------------------
end architecture;

--------------------------------------------------------------------------------
--                   RightShifterSticky8_by_max_6_F0_uid14
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

entity RightShifterSticky8_by_max_6_F0_uid14 is
    port (X : in  std_logic_vector(7 downto 0);
          S : in  std_logic_vector(2 downto 0);
          padBit : in  std_logic;
          R : out  std_logic_vector(7 downto 0);
          Sticky : out  std_logic   );
end entity;

architecture arch of RightShifterSticky8_by_max_6_F0_uid14 is
signal ps :  std_logic_vector(2 downto 0);
signal level3 :  std_logic_vector(7 downto 0);
signal stk2 :  std_logic;
signal level2 :  std_logic_vector(7 downto 0);
signal stk1 :  std_logic;
signal level1 :  std_logic_vector(7 downto 0);
signal stk0 :  std_logic;
signal level0 :  std_logic_vector(7 downto 0);
begin
   ps<= S;
   level3<= X;
   stk2 <= '1' when (level3(3 downto 0)/="0000" and ps(2)='1')   else '0';
   level2 <=  level3 when  ps(2)='0'    else (3 downto 0 => padBit) & level3(7 downto 4);
   stk1 <= '1' when (level2(1 downto 0)/="00" and ps(1)='1') or stk2 ='1'   else '0';
   level1 <=  level2 when  ps(1)='0'    else (1 downto 0 => padBit) & level2(7 downto 2);
   stk0 <= '1' when (level1(0 downto 0)/="0" and ps(0)='1') or stk1 ='1'   else '0';
   level0 <=  level1 when  ps(0)='0'    else (0 downto 0 => padBit) & level1(7 downto 1);
   R <= level0;
   Sticky <= stk0;
end architecture;

--------------------------------------------------------------------------------
--                         PositEncoder_8_2_F0_uid12
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Raul Murillo, Alberto A. del Barrio, Guillermo Botella, 2020
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: Sign SF Frac Sticky Zero Inf
-- Output signals: O

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity PositEncoder_8_2_F0_uid12 is
    port (Sign : in  std_logic;
          SF : in  std_logic_vector(6 downto 0);
          Frac : in  std_logic_vector(3 downto 0);
          Sticky : in  std_logic;
          Zero : in  std_logic;
          Inf : in  std_logic;
          O : out  std_logic_vector(7 downto 0)   );
end entity;

architecture arch of PositEncoder_8_2_F0_uid12 is
   component RightShifterSticky8_by_max_6_F0_uid14 is
      port ( X : in  std_logic_vector(7 downto 0);
             S : in  std_logic_vector(2 downto 0);
             padBit : in  std_logic;
             R : out  std_logic_vector(7 downto 0);
             Sticky : out  std_logic   );
   end component;

signal e :  std_logic_vector(1 downto 0);
signal k :  std_logic_vector(4 downto 0);
signal rc :  std_logic;
signal offset_tmp :  std_logic_vector(4 downto 0);
signal reg_ovf :  std_logic;
signal pad :  std_logic;
signal input_shifter :  std_logic_vector(7 downto 0);
signal shift_offset :  std_logic_vector(2 downto 0);
signal shifted_posit :  std_logic_vector(7 downto 0);
signal shifted_sb :  std_logic;
signal stk :  std_logic;
signal rnd :  std_logic;
signal lsb :  std_logic;
signal round :  std_logic;
signal rep_sign :  std_logic_vector(6 downto 0);
signal final_p :  std_logic_vector(6 downto 0);
begin
--------------------------- Start of vhdl generation ---------------------------
----------------------------- Get value of regime -----------------------------
   e <= SF(1 downto 0);
   k <= SF(6 downto 2);
   rc <= SF(SF'high);
   with rc  select  offset_tmp <=
      not k when '1',
      k when '0',
      "-----" when others;
   -- Check for regime overflow
   reg_ovf <= '1' when (offset_tmp > "00101") else '0';
-------------- Generate regime - shift out exponent and fraction --------------
   pad <= not rc;
   input_shifter <= pad & rc & e & Frac;
   with reg_ovf  select  shift_offset <= 
      "110" when '1',
      offset_tmp(2 downto 0) when '0',
      "---" when others;
   right_signed_shifter: RightShifterSticky8_by_max_6_F0_uid14
      port map ( S => shift_offset,
                 X => input_shifter,
                 padBit => pad,
                 R => shifted_posit,
                 Sticky => shifted_sb);
---------------------------- Round to nearest even ----------------------------
   stk <= shifted_sb OR Sticky;
   rnd <= shifted_posit(0);
   lsb <= shifted_posit(1);
   round <= rnd AND (lsb OR stk OR reg_ovf);
-------------------------- Check sign & Special Cases --------------------------
   rep_sign <= (others => Sign);
   -- Two's complement if posit is negative
   final_p <= (rep_sign XOR (shifted_posit(7 downto 1) + round)) + Sign;
   O <=
      '1' & "0000000" when Inf = '1' else 
      "00000000" when Zero = '1' else
      Sign & final_p;
---------------------------- End of vhdl generation ----------------------------
end architecture;

--------------------------------------------------------------------------------
--                            PositLAM_8_2_F0_uid2
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

entity PositLAM_8_2_F0_uid2 is
    port (X : in  std_logic_vector(7 downto 0);
          Y : in  std_logic_vector(7 downto 0);
          R : out  std_logic_vector(7 downto 0)   );
end entity;

architecture arch of PositLAM_8_2_F0_uid2 is
   component PositDecoder1_8_2_F0_uid4 is
      port ( Input : in  std_logic_vector(7 downto 0);
             Sign : out  std_logic;
             SF : out  std_logic_vector(5 downto 0);
             Frac : out  std_logic_vector(2 downto 0);
             Zero : out  std_logic;
             Inf : out  std_logic;
             Abs_in : out  std_logic_vector(6 downto 0)   );
   end component;

   component PositDecoder1_8_2_F0_uid8 is
      port ( Input : in  std_logic_vector(7 downto 0);
             Sign : out  std_logic;
             SF : out  std_logic_vector(5 downto 0);
             Frac : out  std_logic_vector(2 downto 0);
             Zero : out  std_logic;
             Inf : out  std_logic;
             Abs_in : out  std_logic_vector(6 downto 0)   );
   end component;

   component PositEncoder_8_2_F0_uid12 is
      port ( Sign : in  std_logic;
             SF : in  std_logic_vector(6 downto 0);
             Frac : in  std_logic_vector(3 downto 0);
             Sticky : in  std_logic;
             Zero : in  std_logic;
             Inf : in  std_logic;
             O : out  std_logic_vector(7 downto 0)   );
   end component;

signal sign_X :  std_logic;
signal sf_X :  std_logic_vector(5 downto 0);
signal f_X :  std_logic_vector(2 downto 0);
signal z_X :  std_logic;
signal inf_X :  std_logic;
signal sign_Y :  std_logic;
signal sf_Y :  std_logic_vector(5 downto 0);
signal f_Y :  std_logic_vector(2 downto 0);
signal z_Y :  std_logic;
signal inf_Y :  std_logic;
signal op_X :  std_logic_vector(8 downto 0);
signal op_Y :  std_logic_vector(8 downto 0);
signal sign :  std_logic;
signal zero :  std_logic;
signal inf :  std_logic;
signal add_r :  std_logic_vector(9 downto 0);
signal sf :  std_logic_vector(6 downto 0);
signal frac :  std_logic_vector(3 downto 0);
signal stk :  std_logic;
begin
--------------------------- Start of vhdl generation ---------------------------
------------------------------- Data Extraction -------------------------------
   X_decoder: PositDecoder1_8_2_F0_uid4
      port map ( Input => X,
                 Abs_in => open,
                 Frac => f_X,
                 Inf => inf_X,
                 SF => sf_X,
                 Sign => sign_X,
                 Zero => z_X);
   Y_decoder: PositDecoder1_8_2_F0_uid8
      port map ( Input => Y,
                 Abs_in => open,
                 Frac => f_Y,
                 Inf => inf_Y,
                 SF => sf_Y,
                 Sign => sign_Y,
                 Zero => z_Y);
   -- Gather operands
   op_X <= sf_X & f_X;
   op_Y <= sf_Y & f_Y;
---------------------- Sign and Special Cases Computation ----------------------
   sign <= sign_X XOR sign_Y;
   zero <= z_X OR z_Y;
   inf <= inf_X OR inf_Y;
-------------------- Add exponents & fractions all together --------------------
   add_r <= (op_X(op_X'high) & op_X) + (op_Y(op_Y'high) & op_Y);
   sf <= add_r(9 downto 3);
   frac <= add_r(2 downto 0) & '0';
-------------------------------- Data Encoding --------------------------------
   stk <= '0';
   R_encoding: PositEncoder_8_2_F0_uid12
      port map ( Frac => frac,
                 Inf => inf,
                 SF => sf,
                 Sign => sign,
                 Sticky => stk,
                 Zero => zero,
                 O => R);
---------------------------- End of vhdl generation ----------------------------
end architecture;

