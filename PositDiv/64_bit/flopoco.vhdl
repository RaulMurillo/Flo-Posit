--------------------------------------------------------------------------------
--                       Normalizer_ZO_62_62_62_F0_uid6_PositDiv64
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

entity Normalizer_ZO_62_62_62_F0_uid6_PositDiv64 is
    port (X : in  std_logic_vector(61 downto 0);
          OZb : in  std_logic;
          Count : out  std_logic_vector(5 downto 0);
          R : out  std_logic_vector(61 downto 0)   );
end entity;

architecture arch of Normalizer_ZO_62_62_62_F0_uid6_PositDiv64 is
signal level6 :  std_logic_vector(61 downto 0);
signal sozb :  std_logic;
signal count5 :  std_logic;
signal level5 :  std_logic_vector(61 downto 0);
signal count4 :  std_logic;
signal level4 :  std_logic_vector(61 downto 0);
signal count3 :  std_logic;
signal level3 :  std_logic_vector(61 downto 0);
signal count2 :  std_logic;
signal level2 :  std_logic_vector(61 downto 0);
signal count1 :  std_logic;
signal level1 :  std_logic_vector(61 downto 0);
signal count0 :  std_logic;
signal level0 :  std_logic_vector(61 downto 0);
signal sCount :  std_logic_vector(5 downto 0);
begin
   level6 <= X ;
   sozb<= OZb;
   count5<= '1' when level6(61 downto 30) = (61 downto 30=>sozb) else '0';
   level5<= level6(61 downto 0) when count5='0' else level6(29 downto 0) & (31 downto 0 => '0');

   count4<= '1' when level5(61 downto 46) = (61 downto 46=>sozb) else '0';
   level4<= level5(61 downto 0) when count4='0' else level5(45 downto 0) & (15 downto 0 => '0');

   count3<= '1' when level4(61 downto 54) = (61 downto 54=>sozb) else '0';
   level3<= level4(61 downto 0) when count3='0' else level4(53 downto 0) & (7 downto 0 => '0');

   count2<= '1' when level3(61 downto 58) = (61 downto 58=>sozb) else '0';
   level2<= level3(61 downto 0) when count2='0' else level3(57 downto 0) & (3 downto 0 => '0');

   count1<= '1' when level2(61 downto 60) = (61 downto 60=>sozb) else '0';
   level1<= level2(61 downto 0) when count1='0' else level2(59 downto 0) & (1 downto 0 => '0');

   count0<= '1' when level1(61 downto 61) = (61 downto 61=>sozb) else '0';
   level0<= level1(61 downto 0) when count0='0' else level1(60 downto 0) & (0 downto 0 => '0');

   R <= level0;
   sCount <= count5 & count4 & count3 & count2 & count1 & count0;
   Count <= sCount;
end architecture;

--------------------------------------------------------------------------------
--                       PositFastDecoder_64_2_F0_uid4_PositDiv64
-- Version: 2024.06.24 - 135043
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Raul Murillo (2021-2022)
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

entity PositFastDecoder_64_2_F0_uid4_PositDiv64 is
    port (X : in  std_logic_vector(63 downto 0);
          Sign : out  std_logic;
          SF : out  std_logic_vector(8 downto 0);
          Frac : out  std_logic_vector(58 downto 0);
          NZN : out  std_logic   );
end entity;

architecture arch of PositFastDecoder_64_2_F0_uid4_PositDiv64 is
   component Normalizer_ZO_62_62_62_F0_uid6_PositDiv64 is
      port ( X : in  std_logic_vector(61 downto 0);
             OZb : in  std_logic;
             Count : out  std_logic_vector(5 downto 0);
             R : out  std_logic_vector(61 downto 0)   );
   end component;

signal sgn :  std_logic;
signal pNZN :  std_logic;
signal rc :  std_logic;
signal regPosit :  std_logic_vector(61 downto 0);
signal regLength :  std_logic_vector(5 downto 0);
signal shiftedPosit :  std_logic_vector(61 downto 0);
signal k :  std_logic_vector(6 downto 0);
signal sgnVect :  std_logic_vector(1 downto 0);
signal exp :  std_logic_vector(1 downto 0);
signal pSF :  std_logic_vector(8 downto 0);
signal pFrac :  std_logic_vector(58 downto 0);
begin
--------------------------- Start of vhdl generation ---------------------------
--------------------------- Sign bit & special cases ---------------------------
   sgn <= X(63);
   pNZN <= '0' when (X(62 downto 0) = "000000000000000000000000000000000000000000000000000000000000000") else '1';
-------------- Count leading zeros/ones of regime & shift it out --------------
   rc <= X(62);
   regPosit <= X(61 downto 0);
   RegimeCounter: Normalizer_ZO_62_62_62_F0_uid6_PositDiv64
      port map ( OZb => rc,
                 X => regPosit,
                 Count => regLength,
                 R => shiftedPosit);
----------------- Determine the scaling factor - regime & exp -----------------
   k <= "0" & regLength when rc /= sgn else "1" & NOT(regLength);
   sgnVect <= (others => sgn);
   exp <= shiftedPosit(60 downto 59) XOR sgnVect;
   pSF <= k & exp;
------------------------------- Extract fraction -------------------------------
   pFrac <= shiftedPosit(58 downto 0);
   Sign <= sgn;
   SF <= pSF;
   Frac <= pFrac;
   NZN <= pNZN;
---------------------------- End of vhdl generation ----------------------------
end architecture;

--------------------------------------------------------------------------------
--                      Normalizer_ZO_62_62_62_F0_uid10_PositDiv64
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

entity Normalizer_ZO_62_62_62_F0_uid10_PositDiv64 is
    port (X : in  std_logic_vector(61 downto 0);
          OZb : in  std_logic;
          Count : out  std_logic_vector(5 downto 0);
          R : out  std_logic_vector(61 downto 0)   );
end entity;

architecture arch of Normalizer_ZO_62_62_62_F0_uid10_PositDiv64 is
signal level6 :  std_logic_vector(61 downto 0);
signal sozb :  std_logic;
signal count5 :  std_logic;
signal level5 :  std_logic_vector(61 downto 0);
signal count4 :  std_logic;
signal level4 :  std_logic_vector(61 downto 0);
signal count3 :  std_logic;
signal level3 :  std_logic_vector(61 downto 0);
signal count2 :  std_logic;
signal level2 :  std_logic_vector(61 downto 0);
signal count1 :  std_logic;
signal level1 :  std_logic_vector(61 downto 0);
signal count0 :  std_logic;
signal level0 :  std_logic_vector(61 downto 0);
signal sCount :  std_logic_vector(5 downto 0);
begin
   level6 <= X ;
   sozb<= OZb;
   count5<= '1' when level6(61 downto 30) = (61 downto 30=>sozb) else '0';
   level5<= level6(61 downto 0) when count5='0' else level6(29 downto 0) & (31 downto 0 => '0');

   count4<= '1' when level5(61 downto 46) = (61 downto 46=>sozb) else '0';
   level4<= level5(61 downto 0) when count4='0' else level5(45 downto 0) & (15 downto 0 => '0');

   count3<= '1' when level4(61 downto 54) = (61 downto 54=>sozb) else '0';
   level3<= level4(61 downto 0) when count3='0' else level4(53 downto 0) & (7 downto 0 => '0');

   count2<= '1' when level3(61 downto 58) = (61 downto 58=>sozb) else '0';
   level2<= level3(61 downto 0) when count2='0' else level3(57 downto 0) & (3 downto 0 => '0');

   count1<= '1' when level2(61 downto 60) = (61 downto 60=>sozb) else '0';
   level1<= level2(61 downto 0) when count1='0' else level2(59 downto 0) & (1 downto 0 => '0');

   count0<= '1' when level1(61 downto 61) = (61 downto 61=>sozb) else '0';
   level0<= level1(61 downto 0) when count0='0' else level1(60 downto 0) & (0 downto 0 => '0');

   R <= level0;
   sCount <= count5 & count4 & count3 & count2 & count1 & count0;
   Count <= sCount;
end architecture;

--------------------------------------------------------------------------------
--                       PositFastDecoder_64_2_F0_uid8_PositDiv64
-- Version: 2024.06.24 - 135043
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Raul Murillo (2021-2022)
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

entity PositFastDecoder_64_2_F0_uid8_PositDiv64 is
    port (X : in  std_logic_vector(63 downto 0);
          Sign : out  std_logic;
          SF : out  std_logic_vector(8 downto 0);
          Frac : out  std_logic_vector(58 downto 0);
          NZN : out  std_logic   );
end entity;

architecture arch of PositFastDecoder_64_2_F0_uid8_PositDiv64 is
   component Normalizer_ZO_62_62_62_F0_uid10_PositDiv64 is
      port ( X : in  std_logic_vector(61 downto 0);
             OZb : in  std_logic;
             Count : out  std_logic_vector(5 downto 0);
             R : out  std_logic_vector(61 downto 0)   );
   end component;

signal sgn :  std_logic;
signal pNZN :  std_logic;
signal rc :  std_logic;
signal regPosit :  std_logic_vector(61 downto 0);
signal regLength :  std_logic_vector(5 downto 0);
signal shiftedPosit :  std_logic_vector(61 downto 0);
signal k :  std_logic_vector(6 downto 0);
signal sgnVect :  std_logic_vector(1 downto 0);
signal exp :  std_logic_vector(1 downto 0);
signal pSF :  std_logic_vector(8 downto 0);
signal pFrac :  std_logic_vector(58 downto 0);
begin
--------------------------- Start of vhdl generation ---------------------------
--------------------------- Sign bit & special cases ---------------------------
   sgn <= X(63);
   pNZN <= '0' when (X(62 downto 0) = "000000000000000000000000000000000000000000000000000000000000000") else '1';
-------------- Count leading zeros/ones of regime & shift it out --------------
   rc <= X(62);
   regPosit <= X(61 downto 0);
   RegimeCounter: Normalizer_ZO_62_62_62_F0_uid10_PositDiv64
      port map ( OZb => rc,
                 X => regPosit,
                 Count => regLength,
                 R => shiftedPosit);
----------------- Determine the scaling factor - regime & exp -----------------
   k <= "0" & regLength when rc /= sgn else "1" & NOT(regLength);
   sgnVect <= (others => sgn);
   exp <= shiftedPosit(60 downto 59) XOR sgnVect;
   pSF <= k & exp;
------------------------------- Extract fraction -------------------------------
   pFrac <= shiftedPosit(58 downto 0);
   Sign <= sgn;
   SF <= pSF;
   Frac <= pFrac;
   NZN <= pNZN;
---------------------------- End of vhdl generation ----------------------------
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_61_F0_uid14_PositDiv64
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

entity IntAdder_61_F0_uid14_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid14_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_61_F0_uid16_PositDiv64
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

entity IntAdder_61_F0_uid16_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid16_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_61_F0_uid18_PositDiv64
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

entity IntAdder_61_F0_uid18_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid18_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_61_F0_uid20_PositDiv64
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

entity IntAdder_61_F0_uid20_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid20_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_61_F0_uid22_PositDiv64
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

entity IntAdder_61_F0_uid22_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid22_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_61_F0_uid24_PositDiv64
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

entity IntAdder_61_F0_uid24_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid24_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_61_F0_uid26_PositDiv64
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

entity IntAdder_61_F0_uid26_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid26_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_61_F0_uid28_PositDiv64
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

entity IntAdder_61_F0_uid28_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid28_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_61_F0_uid30_PositDiv64
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

entity IntAdder_61_F0_uid30_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid30_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_61_F0_uid32_PositDiv64
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

entity IntAdder_61_F0_uid32_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid32_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_61_F0_uid34_PositDiv64
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

entity IntAdder_61_F0_uid34_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid34_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_61_F0_uid36_PositDiv64
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

entity IntAdder_61_F0_uid36_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid36_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_61_F0_uid38_PositDiv64
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

entity IntAdder_61_F0_uid38_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid38_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_61_F0_uid40_PositDiv64
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

entity IntAdder_61_F0_uid40_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid40_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_61_F0_uid42_PositDiv64
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

entity IntAdder_61_F0_uid42_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid42_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_61_F0_uid44_PositDiv64
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

entity IntAdder_61_F0_uid44_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid44_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_61_F0_uid46_PositDiv64
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

entity IntAdder_61_F0_uid46_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid46_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_61_F0_uid48_PositDiv64
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

entity IntAdder_61_F0_uid48_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid48_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_61_F0_uid50_PositDiv64
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

entity IntAdder_61_F0_uid50_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid50_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_61_F0_uid52_PositDiv64
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

entity IntAdder_61_F0_uid52_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid52_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_61_F0_uid54_PositDiv64
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

entity IntAdder_61_F0_uid54_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid54_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_61_F0_uid56_PositDiv64
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

entity IntAdder_61_F0_uid56_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid56_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_61_F0_uid58_PositDiv64
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

entity IntAdder_61_F0_uid58_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid58_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_61_F0_uid60_PositDiv64
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

entity IntAdder_61_F0_uid60_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid60_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_61_F0_uid62_PositDiv64
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

entity IntAdder_61_F0_uid62_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid62_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_61_F0_uid64_PositDiv64
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

entity IntAdder_61_F0_uid64_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid64_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_61_F0_uid66_PositDiv64
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

entity IntAdder_61_F0_uid66_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid66_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_61_F0_uid68_PositDiv64
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

entity IntAdder_61_F0_uid68_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid68_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_61_F0_uid70_PositDiv64
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

entity IntAdder_61_F0_uid70_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid70_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_61_F0_uid72_PositDiv64
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

entity IntAdder_61_F0_uid72_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid72_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_61_F0_uid74_PositDiv64
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

entity IntAdder_61_F0_uid74_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid74_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_61_F0_uid76_PositDiv64
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

entity IntAdder_61_F0_uid76_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid76_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_61_F0_uid78_PositDiv64
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

entity IntAdder_61_F0_uid78_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid78_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_61_F0_uid80_PositDiv64
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

entity IntAdder_61_F0_uid80_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid80_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_61_F0_uid82_PositDiv64
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

entity IntAdder_61_F0_uid82_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid82_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_61_F0_uid84_PositDiv64
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

entity IntAdder_61_F0_uid84_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid84_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_61_F0_uid86_PositDiv64
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

entity IntAdder_61_F0_uid86_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid86_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_61_F0_uid88_PositDiv64
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

entity IntAdder_61_F0_uid88_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid88_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_61_F0_uid90_PositDiv64
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

entity IntAdder_61_F0_uid90_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid90_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_61_F0_uid92_PositDiv64
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

entity IntAdder_61_F0_uid92_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid92_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_61_F0_uid94_PositDiv64
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

entity IntAdder_61_F0_uid94_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid94_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_61_F0_uid96_PositDiv64
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

entity IntAdder_61_F0_uid96_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid96_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_61_F0_uid98_PositDiv64
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

entity IntAdder_61_F0_uid98_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid98_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                           IntAdder_61_F0_uid100_PositDiv64
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

entity IntAdder_61_F0_uid100_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid100_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                           IntAdder_61_F0_uid102_PositDiv64
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

entity IntAdder_61_F0_uid102_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid102_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                           IntAdder_61_F0_uid104_PositDiv64
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

entity IntAdder_61_F0_uid104_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid104_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                           IntAdder_61_F0_uid106_PositDiv64
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

entity IntAdder_61_F0_uid106_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid106_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                           IntAdder_61_F0_uid108_PositDiv64
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

entity IntAdder_61_F0_uid108_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid108_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                           IntAdder_61_F0_uid110_PositDiv64
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

entity IntAdder_61_F0_uid110_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid110_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                           IntAdder_61_F0_uid112_PositDiv64
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

entity IntAdder_61_F0_uid112_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid112_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                           IntAdder_61_F0_uid114_PositDiv64
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

entity IntAdder_61_F0_uid114_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid114_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                           IntAdder_61_F0_uid116_PositDiv64
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

entity IntAdder_61_F0_uid116_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid116_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                           IntAdder_61_F0_uid118_PositDiv64
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

entity IntAdder_61_F0_uid118_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid118_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                           IntAdder_61_F0_uid120_PositDiv64
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

entity IntAdder_61_F0_uid120_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid120_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                           IntAdder_61_F0_uid122_PositDiv64
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

entity IntAdder_61_F0_uid122_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid122_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                           IntAdder_61_F0_uid124_PositDiv64
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

entity IntAdder_61_F0_uid124_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid124_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                           IntAdder_61_F0_uid126_PositDiv64
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

entity IntAdder_61_F0_uid126_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid126_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                           IntAdder_61_F0_uid128_PositDiv64
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

entity IntAdder_61_F0_uid128_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid128_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                           IntAdder_61_F0_uid130_PositDiv64
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

entity IntAdder_61_F0_uid130_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid130_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                           IntAdder_61_F0_uid132_PositDiv64
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

entity IntAdder_61_F0_uid132_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid132_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                           IntAdder_61_F0_uid134_PositDiv64
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

entity IntAdder_61_F0_uid134_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid134_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                           IntAdder_61_F0_uid136_PositDiv64
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

entity IntAdder_61_F0_uid136_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid136_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                           IntAdder_61_F0_uid138_PositDiv64
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

entity IntAdder_61_F0_uid138_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(60 downto 0)   );
end entity;

architecture arch of IntAdder_61_F0_uid138_PositDiv64 is
signal Rtmp :  std_logic_vector(60 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                           IntAdder_65_F0_uid140_PositDiv64
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

entity IntAdder_65_F0_uid140_PositDiv64 is
    port (X : in  std_logic_vector(64 downto 0);
          Y : in  std_logic_vector(64 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(64 downto 0)   );
end entity;

architecture arch of IntAdder_65_F0_uid140_PositDiv64 is
signal Rtmp :  std_logic_vector(64 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                           IntAdder_65_F0_uid142_PositDiv64
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

entity IntAdder_65_F0_uid142_PositDiv64 is
    port (X : in  std_logic_vector(64 downto 0);
          Y : in  std_logic_vector(64 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(64 downto 0)   );
end entity;

architecture arch of IntAdder_65_F0_uid142_PositDiv64 is
signal Rtmp :  std_logic_vector(64 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            FixDiv_1_59_F0_uid12_PositDiv64
-- Version: 2024.06.24 - 135043
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Raul Murillo (2021-2022)
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

entity FixDiv_1_59_F0_uid12_PositDiv64 is
    port (X : in  std_logic_vector(60 downto 0);
          Y : in  std_logic_vector(60 downto 0);
          R : out  std_logic_vector(63 downto 0)   );
end entity;

architecture arch of FixDiv_1_59_F0_uid12_PositDiv64 is
   component IntAdder_61_F0_uid14_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid16_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid18_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid20_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid22_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid24_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid26_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid28_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid30_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid32_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid34_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid36_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid38_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid40_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid42_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid44_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid46_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid48_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid50_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid52_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid54_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid56_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid58_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid60_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid62_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid64_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid66_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid68_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid70_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid72_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid74_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid76_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid78_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid80_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid82_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid84_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid86_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid88_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid90_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid92_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid94_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid96_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid98_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid100_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid102_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid104_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid106_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid108_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid110_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid112_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid114_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid116_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid118_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid120_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid122_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid124_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid126_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid128_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid130_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid132_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid134_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid136_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_61_F0_uid138_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(60 downto 0)   );
   end component;

   component IntAdder_65_F0_uid140_PositDiv64 is
      port ( X : in  std_logic_vector(64 downto 0);
             Y : in  std_logic_vector(64 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(64 downto 0)   );
   end component;

   component IntAdder_65_F0_uid142_PositDiv64 is
      port ( X : in  std_logic_vector(64 downto 0);
             Y : in  std_logic_vector(64 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(64 downto 0)   );
   end component;

signal X_minus_two :  std_logic;
signal Y_plus_one :  std_logic;
signal corner_case :  std_logic;
signal X_sign :  std_logic;
signal div :  std_logic_vector(60 downto 0);
signal div_sign :  std_logic;
signal diff_signs :  std_logic;
signal div_ge_tmp :  std_logic;
signal div_gr :  std_logic;
signal n_0 :  std_logic_vector(60 downto 0);
signal append_0 :  std_logic;
signal neg_div :  std_logic_vector(60 downto 0);
signal one_bit :  std_logic;
signal s_1 :  std_logic;
signal r_0 :  std_logic_vector(60 downto 0);
signal pm_div_1 :  std_logic_vector(60 downto 0);
signal n_1 :  std_logic_vector(60 downto 0);
signal rem_z_0 :  std_logic;
signal z_1 :  std_logic;
signal s_2 :  std_logic;
signal r_1 :  std_logic_vector(60 downto 0);
signal pm_div_2 :  std_logic_vector(60 downto 0);
signal n_2 :  std_logic_vector(60 downto 0);
signal rem_z_1 :  std_logic;
signal z_2 :  std_logic;
signal s_3 :  std_logic;
signal r_2 :  std_logic_vector(60 downto 0);
signal pm_div_3 :  std_logic_vector(60 downto 0);
signal n_3 :  std_logic_vector(60 downto 0);
signal rem_z_2 :  std_logic;
signal z_3 :  std_logic;
signal s_4 :  std_logic;
signal r_3 :  std_logic_vector(60 downto 0);
signal pm_div_4 :  std_logic_vector(60 downto 0);
signal n_4 :  std_logic_vector(60 downto 0);
signal rem_z_3 :  std_logic;
signal z_4 :  std_logic;
signal s_5 :  std_logic;
signal r_4 :  std_logic_vector(60 downto 0);
signal pm_div_5 :  std_logic_vector(60 downto 0);
signal n_5 :  std_logic_vector(60 downto 0);
signal rem_z_4 :  std_logic;
signal z_5 :  std_logic;
signal s_6 :  std_logic;
signal r_5 :  std_logic_vector(60 downto 0);
signal pm_div_6 :  std_logic_vector(60 downto 0);
signal n_6 :  std_logic_vector(60 downto 0);
signal rem_z_5 :  std_logic;
signal z_6 :  std_logic;
signal s_7 :  std_logic;
signal r_6 :  std_logic_vector(60 downto 0);
signal pm_div_7 :  std_logic_vector(60 downto 0);
signal n_7 :  std_logic_vector(60 downto 0);
signal rem_z_6 :  std_logic;
signal z_7 :  std_logic;
signal s_8 :  std_logic;
signal r_7 :  std_logic_vector(60 downto 0);
signal pm_div_8 :  std_logic_vector(60 downto 0);
signal n_8 :  std_logic_vector(60 downto 0);
signal rem_z_7 :  std_logic;
signal z_8 :  std_logic;
signal s_9 :  std_logic;
signal r_8 :  std_logic_vector(60 downto 0);
signal pm_div_9 :  std_logic_vector(60 downto 0);
signal n_9 :  std_logic_vector(60 downto 0);
signal rem_z_8 :  std_logic;
signal z_9 :  std_logic;
signal s_10 :  std_logic;
signal r_9 :  std_logic_vector(60 downto 0);
signal pm_div_10 :  std_logic_vector(60 downto 0);
signal n_10 :  std_logic_vector(60 downto 0);
signal rem_z_9 :  std_logic;
signal z_10 :  std_logic;
signal s_11 :  std_logic;
signal r_10 :  std_logic_vector(60 downto 0);
signal pm_div_11 :  std_logic_vector(60 downto 0);
signal n_11 :  std_logic_vector(60 downto 0);
signal rem_z_10 :  std_logic;
signal z_11 :  std_logic;
signal s_12 :  std_logic;
signal r_11 :  std_logic_vector(60 downto 0);
signal pm_div_12 :  std_logic_vector(60 downto 0);
signal n_12 :  std_logic_vector(60 downto 0);
signal rem_z_11 :  std_logic;
signal z_12 :  std_logic;
signal s_13 :  std_logic;
signal r_12 :  std_logic_vector(60 downto 0);
signal pm_div_13 :  std_logic_vector(60 downto 0);
signal n_13 :  std_logic_vector(60 downto 0);
signal rem_z_12 :  std_logic;
signal z_13 :  std_logic;
signal s_14 :  std_logic;
signal r_13 :  std_logic_vector(60 downto 0);
signal pm_div_14 :  std_logic_vector(60 downto 0);
signal n_14 :  std_logic_vector(60 downto 0);
signal rem_z_13 :  std_logic;
signal z_14 :  std_logic;
signal s_15 :  std_logic;
signal r_14 :  std_logic_vector(60 downto 0);
signal pm_div_15 :  std_logic_vector(60 downto 0);
signal n_15 :  std_logic_vector(60 downto 0);
signal rem_z_14 :  std_logic;
signal z_15 :  std_logic;
signal s_16 :  std_logic;
signal r_15 :  std_logic_vector(60 downto 0);
signal pm_div_16 :  std_logic_vector(60 downto 0);
signal n_16 :  std_logic_vector(60 downto 0);
signal rem_z_15 :  std_logic;
signal z_16 :  std_logic;
signal s_17 :  std_logic;
signal r_16 :  std_logic_vector(60 downto 0);
signal pm_div_17 :  std_logic_vector(60 downto 0);
signal n_17 :  std_logic_vector(60 downto 0);
signal rem_z_16 :  std_logic;
signal z_17 :  std_logic;
signal s_18 :  std_logic;
signal r_17 :  std_logic_vector(60 downto 0);
signal pm_div_18 :  std_logic_vector(60 downto 0);
signal n_18 :  std_logic_vector(60 downto 0);
signal rem_z_17 :  std_logic;
signal z_18 :  std_logic;
signal s_19 :  std_logic;
signal r_18 :  std_logic_vector(60 downto 0);
signal pm_div_19 :  std_logic_vector(60 downto 0);
signal n_19 :  std_logic_vector(60 downto 0);
signal rem_z_18 :  std_logic;
signal z_19 :  std_logic;
signal s_20 :  std_logic;
signal r_19 :  std_logic_vector(60 downto 0);
signal pm_div_20 :  std_logic_vector(60 downto 0);
signal n_20 :  std_logic_vector(60 downto 0);
signal rem_z_19 :  std_logic;
signal z_20 :  std_logic;
signal s_21 :  std_logic;
signal r_20 :  std_logic_vector(60 downto 0);
signal pm_div_21 :  std_logic_vector(60 downto 0);
signal n_21 :  std_logic_vector(60 downto 0);
signal rem_z_20 :  std_logic;
signal z_21 :  std_logic;
signal s_22 :  std_logic;
signal r_21 :  std_logic_vector(60 downto 0);
signal pm_div_22 :  std_logic_vector(60 downto 0);
signal n_22 :  std_logic_vector(60 downto 0);
signal rem_z_21 :  std_logic;
signal z_22 :  std_logic;
signal s_23 :  std_logic;
signal r_22 :  std_logic_vector(60 downto 0);
signal pm_div_23 :  std_logic_vector(60 downto 0);
signal n_23 :  std_logic_vector(60 downto 0);
signal rem_z_22 :  std_logic;
signal z_23 :  std_logic;
signal s_24 :  std_logic;
signal r_23 :  std_logic_vector(60 downto 0);
signal pm_div_24 :  std_logic_vector(60 downto 0);
signal n_24 :  std_logic_vector(60 downto 0);
signal rem_z_23 :  std_logic;
signal z_24 :  std_logic;
signal s_25 :  std_logic;
signal r_24 :  std_logic_vector(60 downto 0);
signal pm_div_25 :  std_logic_vector(60 downto 0);
signal n_25 :  std_logic_vector(60 downto 0);
signal rem_z_24 :  std_logic;
signal z_25 :  std_logic;
signal s_26 :  std_logic;
signal r_25 :  std_logic_vector(60 downto 0);
signal pm_div_26 :  std_logic_vector(60 downto 0);
signal n_26 :  std_logic_vector(60 downto 0);
signal rem_z_25 :  std_logic;
signal z_26 :  std_logic;
signal s_27 :  std_logic;
signal r_26 :  std_logic_vector(60 downto 0);
signal pm_div_27 :  std_logic_vector(60 downto 0);
signal n_27 :  std_logic_vector(60 downto 0);
signal rem_z_26 :  std_logic;
signal z_27 :  std_logic;
signal s_28 :  std_logic;
signal r_27 :  std_logic_vector(60 downto 0);
signal pm_div_28 :  std_logic_vector(60 downto 0);
signal n_28 :  std_logic_vector(60 downto 0);
signal rem_z_27 :  std_logic;
signal z_28 :  std_logic;
signal s_29 :  std_logic;
signal r_28 :  std_logic_vector(60 downto 0);
signal pm_div_29 :  std_logic_vector(60 downto 0);
signal n_29 :  std_logic_vector(60 downto 0);
signal rem_z_28 :  std_logic;
signal z_29 :  std_logic;
signal s_30 :  std_logic;
signal r_29 :  std_logic_vector(60 downto 0);
signal pm_div_30 :  std_logic_vector(60 downto 0);
signal n_30 :  std_logic_vector(60 downto 0);
signal rem_z_29 :  std_logic;
signal z_30 :  std_logic;
signal s_31 :  std_logic;
signal r_30 :  std_logic_vector(60 downto 0);
signal pm_div_31 :  std_logic_vector(60 downto 0);
signal n_31 :  std_logic_vector(60 downto 0);
signal rem_z_30 :  std_logic;
signal z_31 :  std_logic;
signal s_32 :  std_logic;
signal r_31 :  std_logic_vector(60 downto 0);
signal pm_div_32 :  std_logic_vector(60 downto 0);
signal n_32 :  std_logic_vector(60 downto 0);
signal rem_z_31 :  std_logic;
signal z_32 :  std_logic;
signal s_33 :  std_logic;
signal r_32 :  std_logic_vector(60 downto 0);
signal pm_div_33 :  std_logic_vector(60 downto 0);
signal n_33 :  std_logic_vector(60 downto 0);
signal rem_z_32 :  std_logic;
signal z_33 :  std_logic;
signal s_34 :  std_logic;
signal r_33 :  std_logic_vector(60 downto 0);
signal pm_div_34 :  std_logic_vector(60 downto 0);
signal n_34 :  std_logic_vector(60 downto 0);
signal rem_z_33 :  std_logic;
signal z_34 :  std_logic;
signal s_35 :  std_logic;
signal r_34 :  std_logic_vector(60 downto 0);
signal pm_div_35 :  std_logic_vector(60 downto 0);
signal n_35 :  std_logic_vector(60 downto 0);
signal rem_z_34 :  std_logic;
signal z_35 :  std_logic;
signal s_36 :  std_logic;
signal r_35 :  std_logic_vector(60 downto 0);
signal pm_div_36 :  std_logic_vector(60 downto 0);
signal n_36 :  std_logic_vector(60 downto 0);
signal rem_z_35 :  std_logic;
signal z_36 :  std_logic;
signal s_37 :  std_logic;
signal r_36 :  std_logic_vector(60 downto 0);
signal pm_div_37 :  std_logic_vector(60 downto 0);
signal n_37 :  std_logic_vector(60 downto 0);
signal rem_z_36 :  std_logic;
signal z_37 :  std_logic;
signal s_38 :  std_logic;
signal r_37 :  std_logic_vector(60 downto 0);
signal pm_div_38 :  std_logic_vector(60 downto 0);
signal n_38 :  std_logic_vector(60 downto 0);
signal rem_z_37 :  std_logic;
signal z_38 :  std_logic;
signal s_39 :  std_logic;
signal r_38 :  std_logic_vector(60 downto 0);
signal pm_div_39 :  std_logic_vector(60 downto 0);
signal n_39 :  std_logic_vector(60 downto 0);
signal rem_z_38 :  std_logic;
signal z_39 :  std_logic;
signal s_40 :  std_logic;
signal r_39 :  std_logic_vector(60 downto 0);
signal pm_div_40 :  std_logic_vector(60 downto 0);
signal n_40 :  std_logic_vector(60 downto 0);
signal rem_z_39 :  std_logic;
signal z_40 :  std_logic;
signal s_41 :  std_logic;
signal r_40 :  std_logic_vector(60 downto 0);
signal pm_div_41 :  std_logic_vector(60 downto 0);
signal n_41 :  std_logic_vector(60 downto 0);
signal rem_z_40 :  std_logic;
signal z_41 :  std_logic;
signal s_42 :  std_logic;
signal r_41 :  std_logic_vector(60 downto 0);
signal pm_div_42 :  std_logic_vector(60 downto 0);
signal n_42 :  std_logic_vector(60 downto 0);
signal rem_z_41 :  std_logic;
signal z_42 :  std_logic;
signal s_43 :  std_logic;
signal r_42 :  std_logic_vector(60 downto 0);
signal pm_div_43 :  std_logic_vector(60 downto 0);
signal n_43 :  std_logic_vector(60 downto 0);
signal rem_z_42 :  std_logic;
signal z_43 :  std_logic;
signal s_44 :  std_logic;
signal r_43 :  std_logic_vector(60 downto 0);
signal pm_div_44 :  std_logic_vector(60 downto 0);
signal n_44 :  std_logic_vector(60 downto 0);
signal rem_z_43 :  std_logic;
signal z_44 :  std_logic;
signal s_45 :  std_logic;
signal r_44 :  std_logic_vector(60 downto 0);
signal pm_div_45 :  std_logic_vector(60 downto 0);
signal n_45 :  std_logic_vector(60 downto 0);
signal rem_z_44 :  std_logic;
signal z_45 :  std_logic;
signal s_46 :  std_logic;
signal r_45 :  std_logic_vector(60 downto 0);
signal pm_div_46 :  std_logic_vector(60 downto 0);
signal n_46 :  std_logic_vector(60 downto 0);
signal rem_z_45 :  std_logic;
signal z_46 :  std_logic;
signal s_47 :  std_logic;
signal r_46 :  std_logic_vector(60 downto 0);
signal pm_div_47 :  std_logic_vector(60 downto 0);
signal n_47 :  std_logic_vector(60 downto 0);
signal rem_z_46 :  std_logic;
signal z_47 :  std_logic;
signal s_48 :  std_logic;
signal r_47 :  std_logic_vector(60 downto 0);
signal pm_div_48 :  std_logic_vector(60 downto 0);
signal n_48 :  std_logic_vector(60 downto 0);
signal rem_z_47 :  std_logic;
signal z_48 :  std_logic;
signal s_49 :  std_logic;
signal r_48 :  std_logic_vector(60 downto 0);
signal pm_div_49 :  std_logic_vector(60 downto 0);
signal n_49 :  std_logic_vector(60 downto 0);
signal rem_z_48 :  std_logic;
signal z_49 :  std_logic;
signal s_50 :  std_logic;
signal r_49 :  std_logic_vector(60 downto 0);
signal pm_div_50 :  std_logic_vector(60 downto 0);
signal n_50 :  std_logic_vector(60 downto 0);
signal rem_z_49 :  std_logic;
signal z_50 :  std_logic;
signal s_51 :  std_logic;
signal r_50 :  std_logic_vector(60 downto 0);
signal pm_div_51 :  std_logic_vector(60 downto 0);
signal n_51 :  std_logic_vector(60 downto 0);
signal rem_z_50 :  std_logic;
signal z_51 :  std_logic;
signal s_52 :  std_logic;
signal r_51 :  std_logic_vector(60 downto 0);
signal pm_div_52 :  std_logic_vector(60 downto 0);
signal n_52 :  std_logic_vector(60 downto 0);
signal rem_z_51 :  std_logic;
signal z_52 :  std_logic;
signal s_53 :  std_logic;
signal r_52 :  std_logic_vector(60 downto 0);
signal pm_div_53 :  std_logic_vector(60 downto 0);
signal n_53 :  std_logic_vector(60 downto 0);
signal rem_z_52 :  std_logic;
signal z_53 :  std_logic;
signal s_54 :  std_logic;
signal r_53 :  std_logic_vector(60 downto 0);
signal pm_div_54 :  std_logic_vector(60 downto 0);
signal n_54 :  std_logic_vector(60 downto 0);
signal rem_z_53 :  std_logic;
signal z_54 :  std_logic;
signal s_55 :  std_logic;
signal r_54 :  std_logic_vector(60 downto 0);
signal pm_div_55 :  std_logic_vector(60 downto 0);
signal n_55 :  std_logic_vector(60 downto 0);
signal rem_z_54 :  std_logic;
signal z_55 :  std_logic;
signal s_56 :  std_logic;
signal r_55 :  std_logic_vector(60 downto 0);
signal pm_div_56 :  std_logic_vector(60 downto 0);
signal n_56 :  std_logic_vector(60 downto 0);
signal rem_z_55 :  std_logic;
signal z_56 :  std_logic;
signal s_57 :  std_logic;
signal r_56 :  std_logic_vector(60 downto 0);
signal pm_div_57 :  std_logic_vector(60 downto 0);
signal n_57 :  std_logic_vector(60 downto 0);
signal rem_z_56 :  std_logic;
signal z_57 :  std_logic;
signal s_58 :  std_logic;
signal r_57 :  std_logic_vector(60 downto 0);
signal pm_div_58 :  std_logic_vector(60 downto 0);
signal n_58 :  std_logic_vector(60 downto 0);
signal rem_z_57 :  std_logic;
signal z_58 :  std_logic;
signal s_59 :  std_logic;
signal r_58 :  std_logic_vector(60 downto 0);
signal pm_div_59 :  std_logic_vector(60 downto 0);
signal n_59 :  std_logic_vector(60 downto 0);
signal rem_z_58 :  std_logic;
signal z_59 :  std_logic;
signal s_60 :  std_logic;
signal r_59 :  std_logic_vector(60 downto 0);
signal pm_div_60 :  std_logic_vector(60 downto 0);
signal n_60 :  std_logic_vector(60 downto 0);
signal rem_z_59 :  std_logic;
signal z_60 :  std_logic;
signal s_61 :  std_logic;
signal r_60 :  std_logic_vector(60 downto 0);
signal pm_div_61 :  std_logic_vector(60 downto 0);
signal n_61 :  std_logic_vector(60 downto 0);
signal rem_z_60 :  std_logic;
signal z_61 :  std_logic;
signal s_62 :  std_logic;
signal r_61 :  std_logic_vector(60 downto 0);
signal pm_div_62 :  std_logic_vector(60 downto 0);
signal n_62 :  std_logic_vector(60 downto 0);
signal rem_z_61 :  std_logic;
signal z_62 :  std_logic;
signal s_63 :  std_logic;
signal r_62 :  std_logic_vector(60 downto 0);
signal pm_div_63 :  std_logic_vector(60 downto 0);
signal n_63 :  std_logic_vector(60 downto 0);
signal rem_z_62 :  std_logic;
signal z_63 :  std_logic;
signal q_1 :  std_logic_vector(64 downto 0);
signal q_2 :  std_logic_vector(64 downto 0);
signal quotient_tmp :  std_logic_vector(64 downto 0);
signal rem_sign :  std_logic;
signal rem_div_sign :  std_logic;
signal rem_dvr_sign :  std_logic;
signal div_div_sign :  std_logic;
signal interm_zero_rem :  std_logic;
signal q_config :  std_logic_vector(4 downto 0);
signal zz :  std_logic;
signal sub_add_ulp :  std_logic_vector(64 downto 0);
signal quotient_aux :  std_logic_vector(64 downto 0);
signal quotient :  std_logic_vector(63 downto 0);
begin
--------------------------- Start of vhdl generation ---------------------------
----------------------- Non-Restoring Division algorithm -----------------------
   X_minus_two <= '1' when X = "1000000000000000000000000000000000000000000000000000000000000" else '0';
   Y_plus_one <= '1' when Y = "0100000000000000000000000000000000000000000000000000000000000" else '0';
   corner_case <= X_minus_two AND Y_plus_one;
   X_sign <= X(60);
   div <= Y;
   div_sign <= Y(60);
   diff_signs <= X_sign XOR div_sign;
   div_ge_tmp <= '1' when Y(59 downto 0) > X(59 downto 0) else '0';
   div_gr <= '0';
   n_0 <= X when div_gr='1' else (X(60) & X(60 downto 1));
   append_0 <= '0' when div_gr='1' else X(0);
   neg_div <= NOT(Y);
   one_bit <= '1' ;
   -- Iteration 1
   s_1 <= NOT(n_0(60) XOR div_sign);
   r_0 <= n_0(59 downto 0) & append_0;
   pm_div_1 <= div when s_1='0' else neg_div;
   sub_0: IntAdder_61_F0_uid14_PositDiv64
      port map ( Cin => s_1,
                 X => r_0,
                 Y => pm_div_1,
                 R => n_1);
   rem_z_0 <= '1' when n_1 = 0 else '0';
   z_1 <= rem_z_0;
   -- Iteration 2
   s_2 <= NOT(n_1(60) XOR div_sign);
   r_1 <= n_1(59 downto 0) & '0';
   pm_div_2 <= div when s_2='0' else neg_div;
   sub_1: IntAdder_61_F0_uid16_PositDiv64
      port map ( Cin => s_2,
                 X => r_1,
                 Y => pm_div_2,
                 R => n_2);
   rem_z_1 <= '1' when n_2 = 0 else '0';
   z_2 <= rem_z_1 OR z_1;
   -- Iteration 3
   s_3 <= NOT(n_2(60) XOR div_sign);
   r_2 <= n_2(59 downto 0) & '0';
   pm_div_3 <= div when s_3='0' else neg_div;
   sub_2: IntAdder_61_F0_uid18_PositDiv64
      port map ( Cin => s_3,
                 X => r_2,
                 Y => pm_div_3,
                 R => n_3);
   rem_z_2 <= '1' when n_3 = 0 else '0';
   z_3 <= rem_z_2 OR z_2;
   -- Iteration 4
   s_4 <= NOT(n_3(60) XOR div_sign);
   r_3 <= n_3(59 downto 0) & '0';
   pm_div_4 <= div when s_4='0' else neg_div;
   sub_3: IntAdder_61_F0_uid20_PositDiv64
      port map ( Cin => s_4,
                 X => r_3,
                 Y => pm_div_4,
                 R => n_4);
   rem_z_3 <= '1' when n_4 = 0 else '0';
   z_4 <= rem_z_3 OR z_3;
   -- Iteration 5
   s_5 <= NOT(n_4(60) XOR div_sign);
   r_4 <= n_4(59 downto 0) & '0';
   pm_div_5 <= div when s_5='0' else neg_div;
   sub_4: IntAdder_61_F0_uid22_PositDiv64
      port map ( Cin => s_5,
                 X => r_4,
                 Y => pm_div_5,
                 R => n_5);
   rem_z_4 <= '1' when n_5 = 0 else '0';
   z_5 <= rem_z_4 OR z_4;
   -- Iteration 6
   s_6 <= NOT(n_5(60) XOR div_sign);
   r_5 <= n_5(59 downto 0) & '0';
   pm_div_6 <= div when s_6='0' else neg_div;
   sub_5: IntAdder_61_F0_uid24_PositDiv64
      port map ( Cin => s_6,
                 X => r_5,
                 Y => pm_div_6,
                 R => n_6);
   rem_z_5 <= '1' when n_6 = 0 else '0';
   z_6 <= rem_z_5 OR z_5;
   -- Iteration 7
   s_7 <= NOT(n_6(60) XOR div_sign);
   r_6 <= n_6(59 downto 0) & '0';
   pm_div_7 <= div when s_7='0' else neg_div;
   sub_6: IntAdder_61_F0_uid26_PositDiv64
      port map ( Cin => s_7,
                 X => r_6,
                 Y => pm_div_7,
                 R => n_7);
   rem_z_6 <= '1' when n_7 = 0 else '0';
   z_7 <= rem_z_6 OR z_6;
   -- Iteration 8
   s_8 <= NOT(n_7(60) XOR div_sign);
   r_7 <= n_7(59 downto 0) & '0';
   pm_div_8 <= div when s_8='0' else neg_div;
   sub_7: IntAdder_61_F0_uid28_PositDiv64
      port map ( Cin => s_8,
                 X => r_7,
                 Y => pm_div_8,
                 R => n_8);
   rem_z_7 <= '1' when n_8 = 0 else '0';
   z_8 <= rem_z_7 OR z_7;
   -- Iteration 9
   s_9 <= NOT(n_8(60) XOR div_sign);
   r_8 <= n_8(59 downto 0) & '0';
   pm_div_9 <= div when s_9='0' else neg_div;
   sub_8: IntAdder_61_F0_uid30_PositDiv64
      port map ( Cin => s_9,
                 X => r_8,
                 Y => pm_div_9,
                 R => n_9);
   rem_z_8 <= '1' when n_9 = 0 else '0';
   z_9 <= rem_z_8 OR z_8;
   -- Iteration 10
   s_10 <= NOT(n_9(60) XOR div_sign);
   r_9 <= n_9(59 downto 0) & '0';
   pm_div_10 <= div when s_10='0' else neg_div;
   sub_9: IntAdder_61_F0_uid32_PositDiv64
      port map ( Cin => s_10,
                 X => r_9,
                 Y => pm_div_10,
                 R => n_10);
   rem_z_9 <= '1' when n_10 = 0 else '0';
   z_10 <= rem_z_9 OR z_9;
   -- Iteration 11
   s_11 <= NOT(n_10(60) XOR div_sign);
   r_10 <= n_10(59 downto 0) & '0';
   pm_div_11 <= div when s_11='0' else neg_div;
   sub_10: IntAdder_61_F0_uid34_PositDiv64
      port map ( Cin => s_11,
                 X => r_10,
                 Y => pm_div_11,
                 R => n_11);
   rem_z_10 <= '1' when n_11 = 0 else '0';
   z_11 <= rem_z_10 OR z_10;
   -- Iteration 12
   s_12 <= NOT(n_11(60) XOR div_sign);
   r_11 <= n_11(59 downto 0) & '0';
   pm_div_12 <= div when s_12='0' else neg_div;
   sub_11: IntAdder_61_F0_uid36_PositDiv64
      port map ( Cin => s_12,
                 X => r_11,
                 Y => pm_div_12,
                 R => n_12);
   rem_z_11 <= '1' when n_12 = 0 else '0';
   z_12 <= rem_z_11 OR z_11;
   -- Iteration 13
   s_13 <= NOT(n_12(60) XOR div_sign);
   r_12 <= n_12(59 downto 0) & '0';
   pm_div_13 <= div when s_13='0' else neg_div;
   sub_12: IntAdder_61_F0_uid38_PositDiv64
      port map ( Cin => s_13,
                 X => r_12,
                 Y => pm_div_13,
                 R => n_13);
   rem_z_12 <= '1' when n_13 = 0 else '0';
   z_13 <= rem_z_12 OR z_12;
   -- Iteration 14
   s_14 <= NOT(n_13(60) XOR div_sign);
   r_13 <= n_13(59 downto 0) & '0';
   pm_div_14 <= div when s_14='0' else neg_div;
   sub_13: IntAdder_61_F0_uid40_PositDiv64
      port map ( Cin => s_14,
                 X => r_13,
                 Y => pm_div_14,
                 R => n_14);
   rem_z_13 <= '1' when n_14 = 0 else '0';
   z_14 <= rem_z_13 OR z_13;
   -- Iteration 15
   s_15 <= NOT(n_14(60) XOR div_sign);
   r_14 <= n_14(59 downto 0) & '0';
   pm_div_15 <= div when s_15='0' else neg_div;
   sub_14: IntAdder_61_F0_uid42_PositDiv64
      port map ( Cin => s_15,
                 X => r_14,
                 Y => pm_div_15,
                 R => n_15);
   rem_z_14 <= '1' when n_15 = 0 else '0';
   z_15 <= rem_z_14 OR z_14;
   -- Iteration 16
   s_16 <= NOT(n_15(60) XOR div_sign);
   r_15 <= n_15(59 downto 0) & '0';
   pm_div_16 <= div when s_16='0' else neg_div;
   sub_15: IntAdder_61_F0_uid44_PositDiv64
      port map ( Cin => s_16,
                 X => r_15,
                 Y => pm_div_16,
                 R => n_16);
   rem_z_15 <= '1' when n_16 = 0 else '0';
   z_16 <= rem_z_15 OR z_15;
   -- Iteration 17
   s_17 <= NOT(n_16(60) XOR div_sign);
   r_16 <= n_16(59 downto 0) & '0';
   pm_div_17 <= div when s_17='0' else neg_div;
   sub_16: IntAdder_61_F0_uid46_PositDiv64
      port map ( Cin => s_17,
                 X => r_16,
                 Y => pm_div_17,
                 R => n_17);
   rem_z_16 <= '1' when n_17 = 0 else '0';
   z_17 <= rem_z_16 OR z_16;
   -- Iteration 18
   s_18 <= NOT(n_17(60) XOR div_sign);
   r_17 <= n_17(59 downto 0) & '0';
   pm_div_18 <= div when s_18='0' else neg_div;
   sub_17: IntAdder_61_F0_uid48_PositDiv64
      port map ( Cin => s_18,
                 X => r_17,
                 Y => pm_div_18,
                 R => n_18);
   rem_z_17 <= '1' when n_18 = 0 else '0';
   z_18 <= rem_z_17 OR z_17;
   -- Iteration 19
   s_19 <= NOT(n_18(60) XOR div_sign);
   r_18 <= n_18(59 downto 0) & '0';
   pm_div_19 <= div when s_19='0' else neg_div;
   sub_18: IntAdder_61_F0_uid50_PositDiv64
      port map ( Cin => s_19,
                 X => r_18,
                 Y => pm_div_19,
                 R => n_19);
   rem_z_18 <= '1' when n_19 = 0 else '0';
   z_19 <= rem_z_18 OR z_18;
   -- Iteration 20
   s_20 <= NOT(n_19(60) XOR div_sign);
   r_19 <= n_19(59 downto 0) & '0';
   pm_div_20 <= div when s_20='0' else neg_div;
   sub_19: IntAdder_61_F0_uid52_PositDiv64
      port map ( Cin => s_20,
                 X => r_19,
                 Y => pm_div_20,
                 R => n_20);
   rem_z_19 <= '1' when n_20 = 0 else '0';
   z_20 <= rem_z_19 OR z_19;
   -- Iteration 21
   s_21 <= NOT(n_20(60) XOR div_sign);
   r_20 <= n_20(59 downto 0) & '0';
   pm_div_21 <= div when s_21='0' else neg_div;
   sub_20: IntAdder_61_F0_uid54_PositDiv64
      port map ( Cin => s_21,
                 X => r_20,
                 Y => pm_div_21,
                 R => n_21);
   rem_z_20 <= '1' when n_21 = 0 else '0';
   z_21 <= rem_z_20 OR z_20;
   -- Iteration 22
   s_22 <= NOT(n_21(60) XOR div_sign);
   r_21 <= n_21(59 downto 0) & '0';
   pm_div_22 <= div when s_22='0' else neg_div;
   sub_21: IntAdder_61_F0_uid56_PositDiv64
      port map ( Cin => s_22,
                 X => r_21,
                 Y => pm_div_22,
                 R => n_22);
   rem_z_21 <= '1' when n_22 = 0 else '0';
   z_22 <= rem_z_21 OR z_21;
   -- Iteration 23
   s_23 <= NOT(n_22(60) XOR div_sign);
   r_22 <= n_22(59 downto 0) & '0';
   pm_div_23 <= div when s_23='0' else neg_div;
   sub_22: IntAdder_61_F0_uid58_PositDiv64
      port map ( Cin => s_23,
                 X => r_22,
                 Y => pm_div_23,
                 R => n_23);
   rem_z_22 <= '1' when n_23 = 0 else '0';
   z_23 <= rem_z_22 OR z_22;
   -- Iteration 24
   s_24 <= NOT(n_23(60) XOR div_sign);
   r_23 <= n_23(59 downto 0) & '0';
   pm_div_24 <= div when s_24='0' else neg_div;
   sub_23: IntAdder_61_F0_uid60_PositDiv64
      port map ( Cin => s_24,
                 X => r_23,
                 Y => pm_div_24,
                 R => n_24);
   rem_z_23 <= '1' when n_24 = 0 else '0';
   z_24 <= rem_z_23 OR z_23;
   -- Iteration 25
   s_25 <= NOT(n_24(60) XOR div_sign);
   r_24 <= n_24(59 downto 0) & '0';
   pm_div_25 <= div when s_25='0' else neg_div;
   sub_24: IntAdder_61_F0_uid62_PositDiv64
      port map ( Cin => s_25,
                 X => r_24,
                 Y => pm_div_25,
                 R => n_25);
   rem_z_24 <= '1' when n_25 = 0 else '0';
   z_25 <= rem_z_24 OR z_24;
   -- Iteration 26
   s_26 <= NOT(n_25(60) XOR div_sign);
   r_25 <= n_25(59 downto 0) & '0';
   pm_div_26 <= div when s_26='0' else neg_div;
   sub_25: IntAdder_61_F0_uid64_PositDiv64
      port map ( Cin => s_26,
                 X => r_25,
                 Y => pm_div_26,
                 R => n_26);
   rem_z_25 <= '1' when n_26 = 0 else '0';
   z_26 <= rem_z_25 OR z_25;
   -- Iteration 27
   s_27 <= NOT(n_26(60) XOR div_sign);
   r_26 <= n_26(59 downto 0) & '0';
   pm_div_27 <= div when s_27='0' else neg_div;
   sub_26: IntAdder_61_F0_uid66_PositDiv64
      port map ( Cin => s_27,
                 X => r_26,
                 Y => pm_div_27,
                 R => n_27);
   rem_z_26 <= '1' when n_27 = 0 else '0';
   z_27 <= rem_z_26 OR z_26;
   -- Iteration 28
   s_28 <= NOT(n_27(60) XOR div_sign);
   r_27 <= n_27(59 downto 0) & '0';
   pm_div_28 <= div when s_28='0' else neg_div;
   sub_27: IntAdder_61_F0_uid68_PositDiv64
      port map ( Cin => s_28,
                 X => r_27,
                 Y => pm_div_28,
                 R => n_28);
   rem_z_27 <= '1' when n_28 = 0 else '0';
   z_28 <= rem_z_27 OR z_27;
   -- Iteration 29
   s_29 <= NOT(n_28(60) XOR div_sign);
   r_28 <= n_28(59 downto 0) & '0';
   pm_div_29 <= div when s_29='0' else neg_div;
   sub_28: IntAdder_61_F0_uid70_PositDiv64
      port map ( Cin => s_29,
                 X => r_28,
                 Y => pm_div_29,
                 R => n_29);
   rem_z_28 <= '1' when n_29 = 0 else '0';
   z_29 <= rem_z_28 OR z_28;
   -- Iteration 30
   s_30 <= NOT(n_29(60) XOR div_sign);
   r_29 <= n_29(59 downto 0) & '0';
   pm_div_30 <= div when s_30='0' else neg_div;
   sub_29: IntAdder_61_F0_uid72_PositDiv64
      port map ( Cin => s_30,
                 X => r_29,
                 Y => pm_div_30,
                 R => n_30);
   rem_z_29 <= '1' when n_30 = 0 else '0';
   z_30 <= rem_z_29 OR z_29;
   -- Iteration 31
   s_31 <= NOT(n_30(60) XOR div_sign);
   r_30 <= n_30(59 downto 0) & '0';
   pm_div_31 <= div when s_31='0' else neg_div;
   sub_30: IntAdder_61_F0_uid74_PositDiv64
      port map ( Cin => s_31,
                 X => r_30,
                 Y => pm_div_31,
                 R => n_31);
   rem_z_30 <= '1' when n_31 = 0 else '0';
   z_31 <= rem_z_30 OR z_30;
   -- Iteration 32
   s_32 <= NOT(n_31(60) XOR div_sign);
   r_31 <= n_31(59 downto 0) & '0';
   pm_div_32 <= div when s_32='0' else neg_div;
   sub_31: IntAdder_61_F0_uid76_PositDiv64
      port map ( Cin => s_32,
                 X => r_31,
                 Y => pm_div_32,
                 R => n_32);
   rem_z_31 <= '1' when n_32 = 0 else '0';
   z_32 <= rem_z_31 OR z_31;
   -- Iteration 33
   s_33 <= NOT(n_32(60) XOR div_sign);
   r_32 <= n_32(59 downto 0) & '0';
   pm_div_33 <= div when s_33='0' else neg_div;
   sub_32: IntAdder_61_F0_uid78_PositDiv64
      port map ( Cin => s_33,
                 X => r_32,
                 Y => pm_div_33,
                 R => n_33);
   rem_z_32 <= '1' when n_33 = 0 else '0';
   z_33 <= rem_z_32 OR z_32;
   -- Iteration 34
   s_34 <= NOT(n_33(60) XOR div_sign);
   r_33 <= n_33(59 downto 0) & '0';
   pm_div_34 <= div when s_34='0' else neg_div;
   sub_33: IntAdder_61_F0_uid80_PositDiv64
      port map ( Cin => s_34,
                 X => r_33,
                 Y => pm_div_34,
                 R => n_34);
   rem_z_33 <= '1' when n_34 = 0 else '0';
   z_34 <= rem_z_33 OR z_33;
   -- Iteration 35
   s_35 <= NOT(n_34(60) XOR div_sign);
   r_34 <= n_34(59 downto 0) & '0';
   pm_div_35 <= div when s_35='0' else neg_div;
   sub_34: IntAdder_61_F0_uid82_PositDiv64
      port map ( Cin => s_35,
                 X => r_34,
                 Y => pm_div_35,
                 R => n_35);
   rem_z_34 <= '1' when n_35 = 0 else '0';
   z_35 <= rem_z_34 OR z_34;
   -- Iteration 36
   s_36 <= NOT(n_35(60) XOR div_sign);
   r_35 <= n_35(59 downto 0) & '0';
   pm_div_36 <= div when s_36='0' else neg_div;
   sub_35: IntAdder_61_F0_uid84_PositDiv64
      port map ( Cin => s_36,
                 X => r_35,
                 Y => pm_div_36,
                 R => n_36);
   rem_z_35 <= '1' when n_36 = 0 else '0';
   z_36 <= rem_z_35 OR z_35;
   -- Iteration 37
   s_37 <= NOT(n_36(60) XOR div_sign);
   r_36 <= n_36(59 downto 0) & '0';
   pm_div_37 <= div when s_37='0' else neg_div;
   sub_36: IntAdder_61_F0_uid86_PositDiv64
      port map ( Cin => s_37,
                 X => r_36,
                 Y => pm_div_37,
                 R => n_37);
   rem_z_36 <= '1' when n_37 = 0 else '0';
   z_37 <= rem_z_36 OR z_36;
   -- Iteration 38
   s_38 <= NOT(n_37(60) XOR div_sign);
   r_37 <= n_37(59 downto 0) & '0';
   pm_div_38 <= div when s_38='0' else neg_div;
   sub_37: IntAdder_61_F0_uid88_PositDiv64
      port map ( Cin => s_38,
                 X => r_37,
                 Y => pm_div_38,
                 R => n_38);
   rem_z_37 <= '1' when n_38 = 0 else '0';
   z_38 <= rem_z_37 OR z_37;
   -- Iteration 39
   s_39 <= NOT(n_38(60) XOR div_sign);
   r_38 <= n_38(59 downto 0) & '0';
   pm_div_39 <= div when s_39='0' else neg_div;
   sub_38: IntAdder_61_F0_uid90_PositDiv64
      port map ( Cin => s_39,
                 X => r_38,
                 Y => pm_div_39,
                 R => n_39);
   rem_z_38 <= '1' when n_39 = 0 else '0';
   z_39 <= rem_z_38 OR z_38;
   -- Iteration 40
   s_40 <= NOT(n_39(60) XOR div_sign);
   r_39 <= n_39(59 downto 0) & '0';
   pm_div_40 <= div when s_40='0' else neg_div;
   sub_39: IntAdder_61_F0_uid92_PositDiv64
      port map ( Cin => s_40,
                 X => r_39,
                 Y => pm_div_40,
                 R => n_40);
   rem_z_39 <= '1' when n_40 = 0 else '0';
   z_40 <= rem_z_39 OR z_39;
   -- Iteration 41
   s_41 <= NOT(n_40(60) XOR div_sign);
   r_40 <= n_40(59 downto 0) & '0';
   pm_div_41 <= div when s_41='0' else neg_div;
   sub_40: IntAdder_61_F0_uid94_PositDiv64
      port map ( Cin => s_41,
                 X => r_40,
                 Y => pm_div_41,
                 R => n_41);
   rem_z_40 <= '1' when n_41 = 0 else '0';
   z_41 <= rem_z_40 OR z_40;
   -- Iteration 42
   s_42 <= NOT(n_41(60) XOR div_sign);
   r_41 <= n_41(59 downto 0) & '0';
   pm_div_42 <= div when s_42='0' else neg_div;
   sub_41: IntAdder_61_F0_uid96_PositDiv64
      port map ( Cin => s_42,
                 X => r_41,
                 Y => pm_div_42,
                 R => n_42);
   rem_z_41 <= '1' when n_42 = 0 else '0';
   z_42 <= rem_z_41 OR z_41;
   -- Iteration 43
   s_43 <= NOT(n_42(60) XOR div_sign);
   r_42 <= n_42(59 downto 0) & '0';
   pm_div_43 <= div when s_43='0' else neg_div;
   sub_42: IntAdder_61_F0_uid98_PositDiv64
      port map ( Cin => s_43,
                 X => r_42,
                 Y => pm_div_43,
                 R => n_43);
   rem_z_42 <= '1' when n_43 = 0 else '0';
   z_43 <= rem_z_42 OR z_42;
   -- Iteration 44
   s_44 <= NOT(n_43(60) XOR div_sign);
   r_43 <= n_43(59 downto 0) & '0';
   pm_div_44 <= div when s_44='0' else neg_div;
   sub_43: IntAdder_61_F0_uid100_PositDiv64
      port map ( Cin => s_44,
                 X => r_43,
                 Y => pm_div_44,
                 R => n_44);
   rem_z_43 <= '1' when n_44 = 0 else '0';
   z_44 <= rem_z_43 OR z_43;
   -- Iteration 45
   s_45 <= NOT(n_44(60) XOR div_sign);
   r_44 <= n_44(59 downto 0) & '0';
   pm_div_45 <= div when s_45='0' else neg_div;
   sub_44: IntAdder_61_F0_uid102_PositDiv64
      port map ( Cin => s_45,
                 X => r_44,
                 Y => pm_div_45,
                 R => n_45);
   rem_z_44 <= '1' when n_45 = 0 else '0';
   z_45 <= rem_z_44 OR z_44;
   -- Iteration 46
   s_46 <= NOT(n_45(60) XOR div_sign);
   r_45 <= n_45(59 downto 0) & '0';
   pm_div_46 <= div when s_46='0' else neg_div;
   sub_45: IntAdder_61_F0_uid104_PositDiv64
      port map ( Cin => s_46,
                 X => r_45,
                 Y => pm_div_46,
                 R => n_46);
   rem_z_45 <= '1' when n_46 = 0 else '0';
   z_46 <= rem_z_45 OR z_45;
   -- Iteration 47
   s_47 <= NOT(n_46(60) XOR div_sign);
   r_46 <= n_46(59 downto 0) & '0';
   pm_div_47 <= div when s_47='0' else neg_div;
   sub_46: IntAdder_61_F0_uid106_PositDiv64
      port map ( Cin => s_47,
                 X => r_46,
                 Y => pm_div_47,
                 R => n_47);
   rem_z_46 <= '1' when n_47 = 0 else '0';
   z_47 <= rem_z_46 OR z_46;
   -- Iteration 48
   s_48 <= NOT(n_47(60) XOR div_sign);
   r_47 <= n_47(59 downto 0) & '0';
   pm_div_48 <= div when s_48='0' else neg_div;
   sub_47: IntAdder_61_F0_uid108_PositDiv64
      port map ( Cin => s_48,
                 X => r_47,
                 Y => pm_div_48,
                 R => n_48);
   rem_z_47 <= '1' when n_48 = 0 else '0';
   z_48 <= rem_z_47 OR z_47;
   -- Iteration 49
   s_49 <= NOT(n_48(60) XOR div_sign);
   r_48 <= n_48(59 downto 0) & '0';
   pm_div_49 <= div when s_49='0' else neg_div;
   sub_48: IntAdder_61_F0_uid110_PositDiv64
      port map ( Cin => s_49,
                 X => r_48,
                 Y => pm_div_49,
                 R => n_49);
   rem_z_48 <= '1' when n_49 = 0 else '0';
   z_49 <= rem_z_48 OR z_48;
   -- Iteration 50
   s_50 <= NOT(n_49(60) XOR div_sign);
   r_49 <= n_49(59 downto 0) & '0';
   pm_div_50 <= div when s_50='0' else neg_div;
   sub_49: IntAdder_61_F0_uid112_PositDiv64
      port map ( Cin => s_50,
                 X => r_49,
                 Y => pm_div_50,
                 R => n_50);
   rem_z_49 <= '1' when n_50 = 0 else '0';
   z_50 <= rem_z_49 OR z_49;
   -- Iteration 51
   s_51 <= NOT(n_50(60) XOR div_sign);
   r_50 <= n_50(59 downto 0) & '0';
   pm_div_51 <= div when s_51='0' else neg_div;
   sub_50: IntAdder_61_F0_uid114_PositDiv64
      port map ( Cin => s_51,
                 X => r_50,
                 Y => pm_div_51,
                 R => n_51);
   rem_z_50 <= '1' when n_51 = 0 else '0';
   z_51 <= rem_z_50 OR z_50;
   -- Iteration 52
   s_52 <= NOT(n_51(60) XOR div_sign);
   r_51 <= n_51(59 downto 0) & '0';
   pm_div_52 <= div when s_52='0' else neg_div;
   sub_51: IntAdder_61_F0_uid116_PositDiv64
      port map ( Cin => s_52,
                 X => r_51,
                 Y => pm_div_52,
                 R => n_52);
   rem_z_51 <= '1' when n_52 = 0 else '0';
   z_52 <= rem_z_51 OR z_51;
   -- Iteration 53
   s_53 <= NOT(n_52(60) XOR div_sign);
   r_52 <= n_52(59 downto 0) & '0';
   pm_div_53 <= div when s_53='0' else neg_div;
   sub_52: IntAdder_61_F0_uid118_PositDiv64
      port map ( Cin => s_53,
                 X => r_52,
                 Y => pm_div_53,
                 R => n_53);
   rem_z_52 <= '1' when n_53 = 0 else '0';
   z_53 <= rem_z_52 OR z_52;
   -- Iteration 54
   s_54 <= NOT(n_53(60) XOR div_sign);
   r_53 <= n_53(59 downto 0) & '0';
   pm_div_54 <= div when s_54='0' else neg_div;
   sub_53: IntAdder_61_F0_uid120_PositDiv64
      port map ( Cin => s_54,
                 X => r_53,
                 Y => pm_div_54,
                 R => n_54);
   rem_z_53 <= '1' when n_54 = 0 else '0';
   z_54 <= rem_z_53 OR z_53;
   -- Iteration 55
   s_55 <= NOT(n_54(60) XOR div_sign);
   r_54 <= n_54(59 downto 0) & '0';
   pm_div_55 <= div when s_55='0' else neg_div;
   sub_54: IntAdder_61_F0_uid122_PositDiv64
      port map ( Cin => s_55,
                 X => r_54,
                 Y => pm_div_55,
                 R => n_55);
   rem_z_54 <= '1' when n_55 = 0 else '0';
   z_55 <= rem_z_54 OR z_54;
   -- Iteration 56
   s_56 <= NOT(n_55(60) XOR div_sign);
   r_55 <= n_55(59 downto 0) & '0';
   pm_div_56 <= div when s_56='0' else neg_div;
   sub_55: IntAdder_61_F0_uid124_PositDiv64
      port map ( Cin => s_56,
                 X => r_55,
                 Y => pm_div_56,
                 R => n_56);
   rem_z_55 <= '1' when n_56 = 0 else '0';
   z_56 <= rem_z_55 OR z_55;
   -- Iteration 57
   s_57 <= NOT(n_56(60) XOR div_sign);
   r_56 <= n_56(59 downto 0) & '0';
   pm_div_57 <= div when s_57='0' else neg_div;
   sub_56: IntAdder_61_F0_uid126_PositDiv64
      port map ( Cin => s_57,
                 X => r_56,
                 Y => pm_div_57,
                 R => n_57);
   rem_z_56 <= '1' when n_57 = 0 else '0';
   z_57 <= rem_z_56 OR z_56;
   -- Iteration 58
   s_58 <= NOT(n_57(60) XOR div_sign);
   r_57 <= n_57(59 downto 0) & '0';
   pm_div_58 <= div when s_58='0' else neg_div;
   sub_57: IntAdder_61_F0_uid128_PositDiv64
      port map ( Cin => s_58,
                 X => r_57,
                 Y => pm_div_58,
                 R => n_58);
   rem_z_57 <= '1' when n_58 = 0 else '0';
   z_58 <= rem_z_57 OR z_57;
   -- Iteration 59
   s_59 <= NOT(n_58(60) XOR div_sign);
   r_58 <= n_58(59 downto 0) & '0';
   pm_div_59 <= div when s_59='0' else neg_div;
   sub_58: IntAdder_61_F0_uid130_PositDiv64
      port map ( Cin => s_59,
                 X => r_58,
                 Y => pm_div_59,
                 R => n_59);
   rem_z_58 <= '1' when n_59 = 0 else '0';
   z_59 <= rem_z_58 OR z_58;
   -- Iteration 60
   s_60 <= NOT(n_59(60) XOR div_sign);
   r_59 <= n_59(59 downto 0) & '0';
   pm_div_60 <= div when s_60='0' else neg_div;
   sub_59: IntAdder_61_F0_uid132_PositDiv64
      port map ( Cin => s_60,
                 X => r_59,
                 Y => pm_div_60,
                 R => n_60);
   rem_z_59 <= '1' when n_60 = 0 else '0';
   z_60 <= rem_z_59 OR z_59;
   -- Iteration 61
   s_61 <= NOT(n_60(60) XOR div_sign);
   r_60 <= n_60(59 downto 0) & '0';
   pm_div_61 <= div when s_61='0' else neg_div;
   sub_60: IntAdder_61_F0_uid134_PositDiv64
      port map ( Cin => s_61,
                 X => r_60,
                 Y => pm_div_61,
                 R => n_61);
   rem_z_60 <= '1' when n_61 = 0 else '0';
   z_61 <= rem_z_60 OR z_60;
   -- Iteration 62
   s_62 <= NOT(n_61(60) XOR div_sign);
   r_61 <= n_61(59 downto 0) & '0';
   pm_div_62 <= div when s_62='0' else neg_div;
   sub_61: IntAdder_61_F0_uid136_PositDiv64
      port map ( Cin => s_62,
                 X => r_61,
                 Y => pm_div_62,
                 R => n_62);
   rem_z_61 <= '1' when n_62 = 0 else '0';
   z_62 <= rem_z_61 OR z_61;
   -- Iteration 63
   s_63 <= NOT(n_62(60) XOR div_sign);
   r_62 <= n_62(59 downto 0) & '0';
   pm_div_63 <= div when s_63='0' else neg_div;
   sub_62: IntAdder_61_F0_uid138_PositDiv64
      port map ( Cin => s_63,
                 X => r_62,
                 Y => pm_div_63,
                 R => n_63);
   rem_z_62 <= '1' when n_63 = 0 else '0';
   z_63 <= rem_z_62 OR z_62;
   -- Convert the quotient to the digit set {0,1}
   q_1 <= "00" & s_1 & s_2 & s_3 & s_4 & s_5 & s_6 & s_7 & s_8 & s_9 & s_10 & s_11 & s_12 & s_13 & s_14 & s_15 & s_16 & s_17 & s_18 & s_19 & s_20 & s_21 & s_22 & s_23 & s_24 & s_25 & s_26 & s_27 & s_28 & s_29 & s_30 & s_31 & s_32 & s_33 & s_34 & s_35 & s_36 & s_37 & s_38 & s_39 & s_40 & s_41 & s_42 & s_43 & s_44 & s_45 & s_46 & s_47 & s_48 & s_49 & s_50 & s_51 & s_52 & s_53 & s_54 & s_55 & s_56 & s_57 & s_58 & s_59 & s_60 & s_61 & s_62 & s_63 ;
   q_2 <= "11" & s_1 & s_2 & s_3 & s_4 & s_5 & s_6 & s_7 & s_8 & s_9 & s_10 & s_11 & s_12 & s_13 & s_14 & s_15 & s_16 & s_17 & s_18 & s_19 & s_20 & s_21 & s_22 & s_23 & s_24 & s_25 & s_26 & s_27 & s_28 & s_29 & s_30 & s_31 & s_32 & s_33 & s_34 & s_35 & s_36 & s_37 & s_38 & s_39 & s_40 & s_41 & s_42 & s_43 & s_44 & s_45 & s_46 & s_47 & s_48 & s_49 & s_50 & s_51 & s_52 & s_53 & s_54 & s_55 & s_56 & s_57 & s_58 & s_59 & s_60 & s_61 & s_62 & s_63 ;
   sub_quotient: IntAdder_65_F0_uid140_PositDiv64
      port map ( Cin => one_bit,
                 X => q_1,
                 Y => q_2,
                 R => quotient_tmp);
   -- Correction step
   rem_sign <= n_63(60);
   rem_div_sign <= NOT(rem_z_62) AND (rem_sign XOR X_sign);
   rem_dvr_sign <= rem_sign XOR div_sign;
   div_div_sign <= X_sign XOR div_sign;
   interm_zero_rem <= NOT(rem_z_62) AND z_63;
   q_config <= '0' & div_div_sign & interm_zero_rem & rem_dvr_sign & corner_case;
   zz <= '0';
   with q_config  select  sub_add_ulp <= 
      "11111111111111111111111111111111111111111111111111111111111111111" when "10000" | "10010" | "10100" | "10110",
      "0000000000000000000000000000000000000000000000000000000000000000" & '1' when "11000" | "11010" | "11100" | "11110",
      "11111111111111111111111111111111111111111111111111111111111111111" when "00110" | "01110",
      "0000000000000000000000000000000000000000000000000000000000000000" & '1' when "00100" | "01100",
      "11111111111111111111111111111111111111111111111111111111111111111" when "00001" | "00011" | "00101" | "00111" | "01001" | "01011" | "01101" | "01111" | "10001" | "10011" | "10101" | "10111" | "11001" | "11011" | "11101" | "11111",
      "00000000000000000000000000000000000000000000000000000000000000000" when others;
   correct_quotient: IntAdder_65_F0_uid142_PositDiv64
      port map ( Cin => zz,
                 X => quotient_tmp,
                 Y => sub_add_ulp,
                 R => quotient_aux);
   quotient <= quotient_aux(64 downto 1) when div_gr='1' else (quotient_aux(63 downto 0));
   R <= quotient;
---------------------------- End of vhdl generation ----------------------------
end architecture;

--------------------------------------------------------------------------------
--                  RightShifterSticky63_by_max_63_F0_uid146_PositDiv64
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

entity RightShifterSticky63_by_max_63_F0_uid146_PositDiv64 is
    port (X : in  std_logic_vector(62 downto 0);
          S : in  std_logic_vector(5 downto 0);
          padBit : in  std_logic;
          R : out  std_logic_vector(62 downto 0);
          Sticky : out  std_logic   );
end entity;

architecture arch of RightShifterSticky63_by_max_63_F0_uid146_PositDiv64 is
signal ps :  std_logic_vector(5 downto 0);
signal Xpadded :  std_logic_vector(62 downto 0);
signal level6 :  std_logic_vector(62 downto 0);
signal stk5 :  std_logic;
signal level5 :  std_logic_vector(62 downto 0);
signal stk4 :  std_logic;
signal level4 :  std_logic_vector(62 downto 0);
signal stk3 :  std_logic;
signal level3 :  std_logic_vector(62 downto 0);
signal stk2 :  std_logic;
signal level2 :  std_logic_vector(62 downto 0);
signal stk1 :  std_logic;
signal level1 :  std_logic_vector(62 downto 0);
signal stk0 :  std_logic;
signal level0 :  std_logic_vector(62 downto 0);
begin
   ps<= S;
   Xpadded <= X;
   level6<= Xpadded;
   stk5 <= '1' when (level6(31 downto 0)/="00000000000000000000000000000000" and ps(5)='1')   else '0';
   level5 <=  level6 when  ps(5)='0'    else (31 downto 0 => padBit) & level6(62 downto 32);
   stk4 <= '1' when (level5(15 downto 0)/="0000000000000000" and ps(4)='1') or stk5 ='1'   else '0';
   level4 <=  level5 when  ps(4)='0'    else (15 downto 0 => padBit) & level5(62 downto 16);
   stk3 <= '1' when (level4(7 downto 0)/="00000000" and ps(3)='1') or stk4 ='1'   else '0';
   level3 <=  level4 when  ps(3)='0'    else (7 downto 0 => padBit) & level4(62 downto 8);
   stk2 <= '1' when (level3(3 downto 0)/="0000" and ps(2)='1') or stk3 ='1'   else '0';
   level2 <=  level3 when  ps(2)='0'    else (3 downto 0 => padBit) & level3(62 downto 4);
   stk1 <= '1' when (level2(1 downto 0)/="00" and ps(1)='1') or stk2 ='1'   else '0';
   level1 <=  level2 when  ps(1)='0'    else (1 downto 0 => padBit) & level2(62 downto 2);
   stk0 <= '1' when (level1(0 downto 0)/="0" and ps(0)='1') or stk1 ='1'   else '0';
   level0 <=  level1 when  ps(0)='0'    else (0 downto 0 => padBit) & level1(62 downto 1);
   R <= level0;
   Sticky <= stk0;
end architecture;

--------------------------------------------------------------------------------
--                      PositFastEncoder_64_2_F0_uid144_PositDiv64
-- Version: 2024.06.24 - 135043
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Raul Murillo (2021-2022)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: Sign SF Frac Guard Sticky NZN
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity PositFastEncoder_64_2_F0_uid144_PositDiv64 is
    port (Sign : in  std_logic;
          SF : in  std_logic_vector(9 downto 0);
          Frac : in  std_logic_vector(58 downto 0);
          Guard : in  std_logic;
          Sticky : in  std_logic;
          NZN : in  std_logic;
          R : out  std_logic_vector(63 downto 0)   );
end entity;

architecture arch of PositFastEncoder_64_2_F0_uid144_PositDiv64 is
   component RightShifterSticky63_by_max_63_F0_uid146_PositDiv64 is
      port ( X : in  std_logic_vector(62 downto 0);
             S : in  std_logic_vector(5 downto 0);
             padBit : in  std_logic;
             R : out  std_logic_vector(62 downto 0);
             Sticky : out  std_logic   );
   end component;

signal rc :  std_logic;
signal rcVect :  std_logic_vector(6 downto 0);
signal k :  std_logic_vector(6 downto 0);
signal sgnVect :  std_logic_vector(1 downto 0);
signal exp :  std_logic_vector(1 downto 0);
signal ovf :  std_logic;
signal regValue :  std_logic_vector(5 downto 0);
signal regNeg :  std_logic;
signal padBit :  std_logic;
signal inputShifter :  std_logic_vector(62 downto 0);
signal shiftedPosit :  std_logic_vector(62 downto 0);
signal stkBit :  std_logic;
signal unroundedPosit :  std_logic_vector(62 downto 0);
signal lsb :  std_logic;
signal rnd :  std_logic;
signal stk :  std_logic;
signal round :  std_logic;
signal roundedPosit :  std_logic_vector(62 downto 0);
signal unsignedPosit :  std_logic_vector(62 downto 0);
begin
--------------------------- Start of vhdl generation ---------------------------
----------------------------- Get value of regime -----------------------------
   rc <= SF(SF'high);
   rcVect <= (others => rc);
   k <= SF(8 downto 2) XOR rcVect;
   sgnVect <= (others => Sign);
   exp <= SF(1 downto 0) XOR sgnVect;
   -- Check for regime overflow
   ovf <= '1' when (k > "0111101") else '0';
   regValue <= k(5 downto 0) when ovf = '0' else "111110";
-------------- Generate regime - shift out exponent and fraction --------------
   regNeg <= Sign XOR rc;
   padBit <= NOT(regNeg);
   inputShifter <= regNeg & exp & Frac & Guard;
   RegimeGenerator: RightShifterSticky63_by_max_63_F0_uid146_PositDiv64
      port map ( S => regValue,
                 X => inputShifter,
                 padBit => padBit,
                 R => shiftedPosit,
                 Sticky => stkBit);
   unroundedPosit <= padBit & shiftedPosit(62 downto 1);
---------------------------- Round to nearest even ----------------------------
   lsb <= shiftedPosit(1);
   rnd <= shiftedPosit(0);
   stk <= stkBit OR Sticky;
   round <= rnd AND (lsb OR stk OR ovf);
   roundedPosit <= unroundedPosit + round;
-------------------------- Check sign & Special Cases --------------------------
   unsignedPosit <= roundedPosit when NZN = '1' else (others => '0');
   R <= Sign & unsignedPosit;
---------------------------- End of vhdl generation ----------------------------
end architecture;

--------------------------------------------------------------------------------
--                                  PositDiv64
--                          (PositDiv64_64_2_F0_uid2)
-- Version: 2024.06.24 - 135043
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Raul Murillo (2021-2022)
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

entity PositDiv64 is
    port (X : in  std_logic_vector(63 downto 0);
          Y : in  std_logic_vector(63 downto 0);
          R : out  std_logic_vector(63 downto 0)   );
end entity;

architecture arch of PositDiv64 is
   component PositFastDecoder_64_2_F0_uid4_PositDiv64 is
      port ( X : in  std_logic_vector(63 downto 0);
             Sign : out  std_logic;
             SF : out  std_logic_vector(8 downto 0);
             Frac : out  std_logic_vector(58 downto 0);
             NZN : out  std_logic   );
   end component;

   component PositFastDecoder_64_2_F0_uid8_PositDiv64 is
      port ( X : in  std_logic_vector(63 downto 0);
             Sign : out  std_logic;
             SF : out  std_logic_vector(8 downto 0);
             Frac : out  std_logic_vector(58 downto 0);
             NZN : out  std_logic   );
   end component;

   component FixDiv_1_59_F0_uid12_PositDiv64 is
      port ( X : in  std_logic_vector(60 downto 0);
             Y : in  std_logic_vector(60 downto 0);
             R : out  std_logic_vector(63 downto 0)   );
   end component;

   component PositFastEncoder_64_2_F0_uid144_PositDiv64 is
      port ( Sign : in  std_logic;
             SF : in  std_logic_vector(9 downto 0);
             Frac : in  std_logic_vector(58 downto 0);
             Guard : in  std_logic;
             Sticky : in  std_logic;
             NZN : in  std_logic;
             R : out  std_logic_vector(63 downto 0)   );
   end component;

signal X_sgn :  std_logic;
signal X_sf :  std_logic_vector(8 downto 0);
signal X_f :  std_logic_vector(58 downto 0);
signal X_nzn :  std_logic;
signal Y_sgn :  std_logic;
signal Y_sf :  std_logic_vector(8 downto 0);
signal Y_f :  std_logic_vector(58 downto 0);
signal Y_nzn :  std_logic;
signal XY_nzn :  std_logic;
signal X_nar :  std_logic;
signal Y_nar :  std_logic;
signal Y_zero :  std_logic;
signal XX_f :  std_logic_vector(60 downto 0);
signal YY_f :  std_logic_vector(60 downto 0);
signal XY_f :  std_logic_vector(63 downto 0);
signal XY_sgn :  std_logic;
signal shift_1 :  std_logic;
signal shift_2 :  std_logic;
signal shift_case :  std_logic_vector(1 downto 0);
signal XY_frac :  std_logic_vector(58 downto 0);
signal grd :  std_logic;
signal stk_tmp :  std_logic_vector(2 downto 0);
signal stk :  std_logic;
signal XY_sf :  std_logic_vector(9 downto 0);
signal XY_finalSgn :  std_logic;
begin
--------------------------- Start of vhdl generation ---------------------------
---------------------------- Decode X & Y operands ----------------------------
   X_decoder: PositFastDecoder_64_2_F0_uid4_PositDiv64
      port map ( X => X,
                 Frac => X_f,
                 NZN => X_nzn,
                 SF => X_sf,
                 Sign => X_sgn);
   Y_decoder: PositFastDecoder_64_2_F0_uid8_PositDiv64
      port map ( X => Y,
                 Frac => Y_f,
                 NZN => Y_nzn,
                 SF => Y_sf,
                 Sign => Y_sgn);
--------------------------------- Divide X & Y ---------------------------------
   -- Sign and Special Cases Computation
   XY_nzn <= X_nzn AND Y_nzn;
   X_nar <= X_sgn AND NOT(X_nzn);
   Y_nar <= Y_sgn AND NOT(Y_nzn);
   Y_zero <= NOT(Y_sgn OR Y_nzn);
   -- Divide the fractions (using FloPoCo module FixDivider)
   XX_f <= X_sgn & NOT(X_sgn) & X_f;
   YY_f <= Y_sgn & NOT(Y_sgn) & Y_f;
   FracDivider: FixDiv_1_59_F0_uid12_PositDiv64
      port map ( X => XX_f,
                 Y => YY_f,
                 R => XY_f);
   -- Normalize fraction
   XY_sgn <= XY_f(63);
   shift_1 <= XY_f(63) XNOR XY_f(62);
   shift_2 <= XY_f(63) AND XY_f(62) AND XY_f(61);
   shift_case <= shift_1 & shift_2;
   with shift_case  select  XY_frac <= 
      XY_f(59 downto 1) when "11",
      XY_f(60 downto 2) when "10",
      XY_f(61 downto 3) when others;
   with shift_case  select  grd <= 
      XY_f(0) when "11",
      XY_f(1) when "10",
      XY_f(2) when others;
   with shift_case  select  stk_tmp <= 
      "000" when "11",
      XY_f(0 downto 0) & "00" when "10",
      XY_f(1 downto 0) & "0" when others;
   stk <= '0' when (stk_tmp=0) else '1';
   -- Subtract the exponent values
   XY_sf <= (X_sf(X_sf'high) & X_sf) - (Y_sf(Y_sf'high) & Y_sf) - shift_1 - shift_2;
----------------------------- Generate final posit -----------------------------
   XY_finalSgn <= XY_sgn when XY_nzn = '1' else (X_nar OR Y_nar OR Y_zero);
   PositEncoder: PositFastEncoder_64_2_F0_uid144_PositDiv64
      port map ( Frac => XY_frac,
                 Guard => grd,
                 NZN => XY_nzn,
                 SF => XY_sf,
                 Sign => XY_finalSgn,
                 Sticky => stk,
                 R => R);
---------------------------- End of vhdl generation ----------------------------
end architecture;

