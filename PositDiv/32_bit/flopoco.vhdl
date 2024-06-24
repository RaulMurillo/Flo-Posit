--------------------------------------------------------------------------------
--                       Normalizer_ZO_30_30_30_F0_uid6_PositDiv32
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

entity Normalizer_ZO_30_30_30_F0_uid6_PositDiv32 is
    port (X : in  std_logic_vector(29 downto 0);
          OZb : in  std_logic;
          Count : out  std_logic_vector(4 downto 0);
          R : out  std_logic_vector(29 downto 0)   );
end entity;

architecture arch of Normalizer_ZO_30_30_30_F0_uid6_PositDiv32 is
signal level5 :  std_logic_vector(29 downto 0);
signal sozb :  std_logic;
signal count4 :  std_logic;
signal level4 :  std_logic_vector(29 downto 0);
signal count3 :  std_logic;
signal level3 :  std_logic_vector(29 downto 0);
signal count2 :  std_logic;
signal level2 :  std_logic_vector(29 downto 0);
signal count1 :  std_logic;
signal level1 :  std_logic_vector(29 downto 0);
signal count0 :  std_logic;
signal level0 :  std_logic_vector(29 downto 0);
signal sCount :  std_logic_vector(4 downto 0);
begin
   level5 <= X ;
   sozb<= OZb;
   count4<= '1' when level5(29 downto 14) = (29 downto 14=>sozb) else '0';
   level4<= level5(29 downto 0) when count4='0' else level5(13 downto 0) & (15 downto 0 => '0');

   count3<= '1' when level4(29 downto 22) = (29 downto 22=>sozb) else '0';
   level3<= level4(29 downto 0) when count3='0' else level4(21 downto 0) & (7 downto 0 => '0');

   count2<= '1' when level3(29 downto 26) = (29 downto 26=>sozb) else '0';
   level2<= level3(29 downto 0) when count2='0' else level3(25 downto 0) & (3 downto 0 => '0');

   count1<= '1' when level2(29 downto 28) = (29 downto 28=>sozb) else '0';
   level1<= level2(29 downto 0) when count1='0' else level2(27 downto 0) & (1 downto 0 => '0');

   count0<= '1' when level1(29 downto 29) = (29 downto 29=>sozb) else '0';
   level0<= level1(29 downto 0) when count0='0' else level1(28 downto 0) & (0 downto 0 => '0');

   R <= level0;
   sCount <= count4 & count3 & count2 & count1 & count0;
   Count <= sCount;
end architecture;

--------------------------------------------------------------------------------
--                       PositFastDecoder_32_2_F0_uid4_PositDiv32
-- Version: 2024.06.24 - 135042
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

entity PositFastDecoder_32_2_F0_uid4_PositDiv32 is
    port (X : in  std_logic_vector(31 downto 0);
          Sign : out  std_logic;
          SF : out  std_logic_vector(7 downto 0);
          Frac : out  std_logic_vector(26 downto 0);
          NZN : out  std_logic   );
end entity;

architecture arch of PositFastDecoder_32_2_F0_uid4_PositDiv32 is
   component Normalizer_ZO_30_30_30_F0_uid6_PositDiv32 is
      port ( X : in  std_logic_vector(29 downto 0);
             OZb : in  std_logic;
             Count : out  std_logic_vector(4 downto 0);
             R : out  std_logic_vector(29 downto 0)   );
   end component;

signal sgn :  std_logic;
signal pNZN :  std_logic;
signal rc :  std_logic;
signal regPosit :  std_logic_vector(29 downto 0);
signal regLength :  std_logic_vector(4 downto 0);
signal shiftedPosit :  std_logic_vector(29 downto 0);
signal k :  std_logic_vector(5 downto 0);
signal sgnVect :  std_logic_vector(1 downto 0);
signal exp :  std_logic_vector(1 downto 0);
signal pSF :  std_logic_vector(7 downto 0);
signal pFrac :  std_logic_vector(26 downto 0);
begin
--------------------------- Start of vhdl generation ---------------------------
--------------------------- Sign bit & special cases ---------------------------
   sgn <= X(31);
   pNZN <= '0' when (X(30 downto 0) = "0000000000000000000000000000000") else '1';
-------------- Count leading zeros/ones of regime & shift it out --------------
   rc <= X(30);
   regPosit <= X(29 downto 0);
   RegimeCounter: Normalizer_ZO_30_30_30_F0_uid6_PositDiv32
      port map ( OZb => rc,
                 X => regPosit,
                 Count => regLength,
                 R => shiftedPosit);
----------------- Determine the scaling factor - regime & exp -----------------
   k <= "0" & regLength when rc /= sgn else "1" & NOT(regLength);
   sgnVect <= (others => sgn);
   exp <= shiftedPosit(28 downto 27) XOR sgnVect;
   pSF <= k & exp;
------------------------------- Extract fraction -------------------------------
   pFrac <= shiftedPosit(26 downto 0);
   Sign <= sgn;
   SF <= pSF;
   Frac <= pFrac;
   NZN <= pNZN;
---------------------------- End of vhdl generation ----------------------------
end architecture;

--------------------------------------------------------------------------------
--                      Normalizer_ZO_30_30_30_F0_uid10_PositDiv32
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

entity Normalizer_ZO_30_30_30_F0_uid10_PositDiv32 is
    port (X : in  std_logic_vector(29 downto 0);
          OZb : in  std_logic;
          Count : out  std_logic_vector(4 downto 0);
          R : out  std_logic_vector(29 downto 0)   );
end entity;

architecture arch of Normalizer_ZO_30_30_30_F0_uid10_PositDiv32 is
signal level5 :  std_logic_vector(29 downto 0);
signal sozb :  std_logic;
signal count4 :  std_logic;
signal level4 :  std_logic_vector(29 downto 0);
signal count3 :  std_logic;
signal level3 :  std_logic_vector(29 downto 0);
signal count2 :  std_logic;
signal level2 :  std_logic_vector(29 downto 0);
signal count1 :  std_logic;
signal level1 :  std_logic_vector(29 downto 0);
signal count0 :  std_logic;
signal level0 :  std_logic_vector(29 downto 0);
signal sCount :  std_logic_vector(4 downto 0);
begin
   level5 <= X ;
   sozb<= OZb;
   count4<= '1' when level5(29 downto 14) = (29 downto 14=>sozb) else '0';
   level4<= level5(29 downto 0) when count4='0' else level5(13 downto 0) & (15 downto 0 => '0');

   count3<= '1' when level4(29 downto 22) = (29 downto 22=>sozb) else '0';
   level3<= level4(29 downto 0) when count3='0' else level4(21 downto 0) & (7 downto 0 => '0');

   count2<= '1' when level3(29 downto 26) = (29 downto 26=>sozb) else '0';
   level2<= level3(29 downto 0) when count2='0' else level3(25 downto 0) & (3 downto 0 => '0');

   count1<= '1' when level2(29 downto 28) = (29 downto 28=>sozb) else '0';
   level1<= level2(29 downto 0) when count1='0' else level2(27 downto 0) & (1 downto 0 => '0');

   count0<= '1' when level1(29 downto 29) = (29 downto 29=>sozb) else '0';
   level0<= level1(29 downto 0) when count0='0' else level1(28 downto 0) & (0 downto 0 => '0');

   R <= level0;
   sCount <= count4 & count3 & count2 & count1 & count0;
   Count <= sCount;
end architecture;

--------------------------------------------------------------------------------
--                       PositFastDecoder_32_2_F0_uid8_PositDiv32
-- Version: 2024.06.24 - 135042
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

entity PositFastDecoder_32_2_F0_uid8_PositDiv32 is
    port (X : in  std_logic_vector(31 downto 0);
          Sign : out  std_logic;
          SF : out  std_logic_vector(7 downto 0);
          Frac : out  std_logic_vector(26 downto 0);
          NZN : out  std_logic   );
end entity;

architecture arch of PositFastDecoder_32_2_F0_uid8_PositDiv32 is
   component Normalizer_ZO_30_30_30_F0_uid10_PositDiv32 is
      port ( X : in  std_logic_vector(29 downto 0);
             OZb : in  std_logic;
             Count : out  std_logic_vector(4 downto 0);
             R : out  std_logic_vector(29 downto 0)   );
   end component;

signal sgn :  std_logic;
signal pNZN :  std_logic;
signal rc :  std_logic;
signal regPosit :  std_logic_vector(29 downto 0);
signal regLength :  std_logic_vector(4 downto 0);
signal shiftedPosit :  std_logic_vector(29 downto 0);
signal k :  std_logic_vector(5 downto 0);
signal sgnVect :  std_logic_vector(1 downto 0);
signal exp :  std_logic_vector(1 downto 0);
signal pSF :  std_logic_vector(7 downto 0);
signal pFrac :  std_logic_vector(26 downto 0);
begin
--------------------------- Start of vhdl generation ---------------------------
--------------------------- Sign bit & special cases ---------------------------
   sgn <= X(31);
   pNZN <= '0' when (X(30 downto 0) = "0000000000000000000000000000000") else '1';
-------------- Count leading zeros/ones of regime & shift it out --------------
   rc <= X(30);
   regPosit <= X(29 downto 0);
   RegimeCounter: Normalizer_ZO_30_30_30_F0_uid10_PositDiv32
      port map ( OZb => rc,
                 X => regPosit,
                 Count => regLength,
                 R => shiftedPosit);
----------------- Determine the scaling factor - regime & exp -----------------
   k <= "0" & regLength when rc /= sgn else "1" & NOT(regLength);
   sgnVect <= (others => sgn);
   exp <= shiftedPosit(28 downto 27) XOR sgnVect;
   pSF <= k & exp;
------------------------------- Extract fraction -------------------------------
   pFrac <= shiftedPosit(26 downto 0);
   Sign <= sgn;
   SF <= pSF;
   Frac <= pFrac;
   NZN <= pNZN;
---------------------------- End of vhdl generation ----------------------------
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_29_F0_uid14_PositDiv32
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

entity IntAdder_29_F0_uid14_PositDiv32 is
    port (X : in  std_logic_vector(28 downto 0);
          Y : in  std_logic_vector(28 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(28 downto 0)   );
end entity;

architecture arch of IntAdder_29_F0_uid14_PositDiv32 is
signal Rtmp :  std_logic_vector(28 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_29_F0_uid16_PositDiv32
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

entity IntAdder_29_F0_uid16_PositDiv32 is
    port (X : in  std_logic_vector(28 downto 0);
          Y : in  std_logic_vector(28 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(28 downto 0)   );
end entity;

architecture arch of IntAdder_29_F0_uid16_PositDiv32 is
signal Rtmp :  std_logic_vector(28 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_29_F0_uid18_PositDiv32
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

entity IntAdder_29_F0_uid18_PositDiv32 is
    port (X : in  std_logic_vector(28 downto 0);
          Y : in  std_logic_vector(28 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(28 downto 0)   );
end entity;

architecture arch of IntAdder_29_F0_uid18_PositDiv32 is
signal Rtmp :  std_logic_vector(28 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_29_F0_uid20_PositDiv32
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

entity IntAdder_29_F0_uid20_PositDiv32 is
    port (X : in  std_logic_vector(28 downto 0);
          Y : in  std_logic_vector(28 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(28 downto 0)   );
end entity;

architecture arch of IntAdder_29_F0_uid20_PositDiv32 is
signal Rtmp :  std_logic_vector(28 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_29_F0_uid22_PositDiv32
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

entity IntAdder_29_F0_uid22_PositDiv32 is
    port (X : in  std_logic_vector(28 downto 0);
          Y : in  std_logic_vector(28 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(28 downto 0)   );
end entity;

architecture arch of IntAdder_29_F0_uid22_PositDiv32 is
signal Rtmp :  std_logic_vector(28 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_29_F0_uid24_PositDiv32
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

entity IntAdder_29_F0_uid24_PositDiv32 is
    port (X : in  std_logic_vector(28 downto 0);
          Y : in  std_logic_vector(28 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(28 downto 0)   );
end entity;

architecture arch of IntAdder_29_F0_uid24_PositDiv32 is
signal Rtmp :  std_logic_vector(28 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_29_F0_uid26_PositDiv32
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

entity IntAdder_29_F0_uid26_PositDiv32 is
    port (X : in  std_logic_vector(28 downto 0);
          Y : in  std_logic_vector(28 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(28 downto 0)   );
end entity;

architecture arch of IntAdder_29_F0_uid26_PositDiv32 is
signal Rtmp :  std_logic_vector(28 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_29_F0_uid28_PositDiv32
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

entity IntAdder_29_F0_uid28_PositDiv32 is
    port (X : in  std_logic_vector(28 downto 0);
          Y : in  std_logic_vector(28 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(28 downto 0)   );
end entity;

architecture arch of IntAdder_29_F0_uid28_PositDiv32 is
signal Rtmp :  std_logic_vector(28 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_29_F0_uid30_PositDiv32
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

entity IntAdder_29_F0_uid30_PositDiv32 is
    port (X : in  std_logic_vector(28 downto 0);
          Y : in  std_logic_vector(28 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(28 downto 0)   );
end entity;

architecture arch of IntAdder_29_F0_uid30_PositDiv32 is
signal Rtmp :  std_logic_vector(28 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_29_F0_uid32_PositDiv32
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

entity IntAdder_29_F0_uid32_PositDiv32 is
    port (X : in  std_logic_vector(28 downto 0);
          Y : in  std_logic_vector(28 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(28 downto 0)   );
end entity;

architecture arch of IntAdder_29_F0_uid32_PositDiv32 is
signal Rtmp :  std_logic_vector(28 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_29_F0_uid34_PositDiv32
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

entity IntAdder_29_F0_uid34_PositDiv32 is
    port (X : in  std_logic_vector(28 downto 0);
          Y : in  std_logic_vector(28 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(28 downto 0)   );
end entity;

architecture arch of IntAdder_29_F0_uid34_PositDiv32 is
signal Rtmp :  std_logic_vector(28 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_29_F0_uid36_PositDiv32
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

entity IntAdder_29_F0_uid36_PositDiv32 is
    port (X : in  std_logic_vector(28 downto 0);
          Y : in  std_logic_vector(28 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(28 downto 0)   );
end entity;

architecture arch of IntAdder_29_F0_uid36_PositDiv32 is
signal Rtmp :  std_logic_vector(28 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_29_F0_uid38_PositDiv32
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

entity IntAdder_29_F0_uid38_PositDiv32 is
    port (X : in  std_logic_vector(28 downto 0);
          Y : in  std_logic_vector(28 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(28 downto 0)   );
end entity;

architecture arch of IntAdder_29_F0_uid38_PositDiv32 is
signal Rtmp :  std_logic_vector(28 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_29_F0_uid40_PositDiv32
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

entity IntAdder_29_F0_uid40_PositDiv32 is
    port (X : in  std_logic_vector(28 downto 0);
          Y : in  std_logic_vector(28 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(28 downto 0)   );
end entity;

architecture arch of IntAdder_29_F0_uid40_PositDiv32 is
signal Rtmp :  std_logic_vector(28 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_29_F0_uid42_PositDiv32
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

entity IntAdder_29_F0_uid42_PositDiv32 is
    port (X : in  std_logic_vector(28 downto 0);
          Y : in  std_logic_vector(28 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(28 downto 0)   );
end entity;

architecture arch of IntAdder_29_F0_uid42_PositDiv32 is
signal Rtmp :  std_logic_vector(28 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_29_F0_uid44_PositDiv32
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

entity IntAdder_29_F0_uid44_PositDiv32 is
    port (X : in  std_logic_vector(28 downto 0);
          Y : in  std_logic_vector(28 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(28 downto 0)   );
end entity;

architecture arch of IntAdder_29_F0_uid44_PositDiv32 is
signal Rtmp :  std_logic_vector(28 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_29_F0_uid46_PositDiv32
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

entity IntAdder_29_F0_uid46_PositDiv32 is
    port (X : in  std_logic_vector(28 downto 0);
          Y : in  std_logic_vector(28 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(28 downto 0)   );
end entity;

architecture arch of IntAdder_29_F0_uid46_PositDiv32 is
signal Rtmp :  std_logic_vector(28 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_29_F0_uid48_PositDiv32
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

entity IntAdder_29_F0_uid48_PositDiv32 is
    port (X : in  std_logic_vector(28 downto 0);
          Y : in  std_logic_vector(28 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(28 downto 0)   );
end entity;

architecture arch of IntAdder_29_F0_uid48_PositDiv32 is
signal Rtmp :  std_logic_vector(28 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_29_F0_uid50_PositDiv32
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

entity IntAdder_29_F0_uid50_PositDiv32 is
    port (X : in  std_logic_vector(28 downto 0);
          Y : in  std_logic_vector(28 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(28 downto 0)   );
end entity;

architecture arch of IntAdder_29_F0_uid50_PositDiv32 is
signal Rtmp :  std_logic_vector(28 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_29_F0_uid52_PositDiv32
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

entity IntAdder_29_F0_uid52_PositDiv32 is
    port (X : in  std_logic_vector(28 downto 0);
          Y : in  std_logic_vector(28 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(28 downto 0)   );
end entity;

architecture arch of IntAdder_29_F0_uid52_PositDiv32 is
signal Rtmp :  std_logic_vector(28 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_29_F0_uid54_PositDiv32
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

entity IntAdder_29_F0_uid54_PositDiv32 is
    port (X : in  std_logic_vector(28 downto 0);
          Y : in  std_logic_vector(28 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(28 downto 0)   );
end entity;

architecture arch of IntAdder_29_F0_uid54_PositDiv32 is
signal Rtmp :  std_logic_vector(28 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_29_F0_uid56_PositDiv32
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

entity IntAdder_29_F0_uid56_PositDiv32 is
    port (X : in  std_logic_vector(28 downto 0);
          Y : in  std_logic_vector(28 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(28 downto 0)   );
end entity;

architecture arch of IntAdder_29_F0_uid56_PositDiv32 is
signal Rtmp :  std_logic_vector(28 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_29_F0_uid58_PositDiv32
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

entity IntAdder_29_F0_uid58_PositDiv32 is
    port (X : in  std_logic_vector(28 downto 0);
          Y : in  std_logic_vector(28 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(28 downto 0)   );
end entity;

architecture arch of IntAdder_29_F0_uid58_PositDiv32 is
signal Rtmp :  std_logic_vector(28 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_29_F0_uid60_PositDiv32
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

entity IntAdder_29_F0_uid60_PositDiv32 is
    port (X : in  std_logic_vector(28 downto 0);
          Y : in  std_logic_vector(28 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(28 downto 0)   );
end entity;

architecture arch of IntAdder_29_F0_uid60_PositDiv32 is
signal Rtmp :  std_logic_vector(28 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_29_F0_uid62_PositDiv32
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

entity IntAdder_29_F0_uid62_PositDiv32 is
    port (X : in  std_logic_vector(28 downto 0);
          Y : in  std_logic_vector(28 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(28 downto 0)   );
end entity;

architecture arch of IntAdder_29_F0_uid62_PositDiv32 is
signal Rtmp :  std_logic_vector(28 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_29_F0_uid64_PositDiv32
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

entity IntAdder_29_F0_uid64_PositDiv32 is
    port (X : in  std_logic_vector(28 downto 0);
          Y : in  std_logic_vector(28 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(28 downto 0)   );
end entity;

architecture arch of IntAdder_29_F0_uid64_PositDiv32 is
signal Rtmp :  std_logic_vector(28 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_29_F0_uid66_PositDiv32
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

entity IntAdder_29_F0_uid66_PositDiv32 is
    port (X : in  std_logic_vector(28 downto 0);
          Y : in  std_logic_vector(28 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(28 downto 0)   );
end entity;

architecture arch of IntAdder_29_F0_uid66_PositDiv32 is
signal Rtmp :  std_logic_vector(28 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_29_F0_uid68_PositDiv32
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

entity IntAdder_29_F0_uid68_PositDiv32 is
    port (X : in  std_logic_vector(28 downto 0);
          Y : in  std_logic_vector(28 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(28 downto 0)   );
end entity;

architecture arch of IntAdder_29_F0_uid68_PositDiv32 is
signal Rtmp :  std_logic_vector(28 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_29_F0_uid70_PositDiv32
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

entity IntAdder_29_F0_uid70_PositDiv32 is
    port (X : in  std_logic_vector(28 downto 0);
          Y : in  std_logic_vector(28 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(28 downto 0)   );
end entity;

architecture arch of IntAdder_29_F0_uid70_PositDiv32 is
signal Rtmp :  std_logic_vector(28 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_29_F0_uid72_PositDiv32
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

entity IntAdder_29_F0_uid72_PositDiv32 is
    port (X : in  std_logic_vector(28 downto 0);
          Y : in  std_logic_vector(28 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(28 downto 0)   );
end entity;

architecture arch of IntAdder_29_F0_uid72_PositDiv32 is
signal Rtmp :  std_logic_vector(28 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_29_F0_uid74_PositDiv32
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

entity IntAdder_29_F0_uid74_PositDiv32 is
    port (X : in  std_logic_vector(28 downto 0);
          Y : in  std_logic_vector(28 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(28 downto 0)   );
end entity;

architecture arch of IntAdder_29_F0_uid74_PositDiv32 is
signal Rtmp :  std_logic_vector(28 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_33_F0_uid76_PositDiv32
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

entity IntAdder_33_F0_uid76_PositDiv32 is
    port (X : in  std_logic_vector(32 downto 0);
          Y : in  std_logic_vector(32 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(32 downto 0)   );
end entity;

architecture arch of IntAdder_33_F0_uid76_PositDiv32 is
signal Rtmp :  std_logic_vector(32 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            IntAdder_33_F0_uid78_PositDiv32
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

entity IntAdder_33_F0_uid78_PositDiv32 is
    port (X : in  std_logic_vector(32 downto 0);
          Y : in  std_logic_vector(32 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(32 downto 0)   );
end entity;

architecture arch of IntAdder_33_F0_uid78_PositDiv32 is
signal Rtmp :  std_logic_vector(32 downto 0);
begin
   Rtmp <= X + Y + Cin;
   R <= Rtmp;
end architecture;

--------------------------------------------------------------------------------
--                            FixDiv_1_27_F0_uid12_PositDiv32
-- Version: 2024.06.24 - 135042
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

entity FixDiv_1_27_F0_uid12_PositDiv32 is
    port (X : in  std_logic_vector(28 downto 0);
          Y : in  std_logic_vector(28 downto 0);
          R : out  std_logic_vector(31 downto 0)   );
end entity;

architecture arch of FixDiv_1_27_F0_uid12_PositDiv32 is
   component IntAdder_29_F0_uid14_PositDiv32 is
      port ( X : in  std_logic_vector(28 downto 0);
             Y : in  std_logic_vector(28 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(28 downto 0)   );
   end component;

   component IntAdder_29_F0_uid16_PositDiv32 is
      port ( X : in  std_logic_vector(28 downto 0);
             Y : in  std_logic_vector(28 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(28 downto 0)   );
   end component;

   component IntAdder_29_F0_uid18_PositDiv32 is
      port ( X : in  std_logic_vector(28 downto 0);
             Y : in  std_logic_vector(28 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(28 downto 0)   );
   end component;

   component IntAdder_29_F0_uid20_PositDiv32 is
      port ( X : in  std_logic_vector(28 downto 0);
             Y : in  std_logic_vector(28 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(28 downto 0)   );
   end component;

   component IntAdder_29_F0_uid22_PositDiv32 is
      port ( X : in  std_logic_vector(28 downto 0);
             Y : in  std_logic_vector(28 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(28 downto 0)   );
   end component;

   component IntAdder_29_F0_uid24_PositDiv32 is
      port ( X : in  std_logic_vector(28 downto 0);
             Y : in  std_logic_vector(28 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(28 downto 0)   );
   end component;

   component IntAdder_29_F0_uid26_PositDiv32 is
      port ( X : in  std_logic_vector(28 downto 0);
             Y : in  std_logic_vector(28 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(28 downto 0)   );
   end component;

   component IntAdder_29_F0_uid28_PositDiv32 is
      port ( X : in  std_logic_vector(28 downto 0);
             Y : in  std_logic_vector(28 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(28 downto 0)   );
   end component;

   component IntAdder_29_F0_uid30_PositDiv32 is
      port ( X : in  std_logic_vector(28 downto 0);
             Y : in  std_logic_vector(28 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(28 downto 0)   );
   end component;

   component IntAdder_29_F0_uid32_PositDiv32 is
      port ( X : in  std_logic_vector(28 downto 0);
             Y : in  std_logic_vector(28 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(28 downto 0)   );
   end component;

   component IntAdder_29_F0_uid34_PositDiv32 is
      port ( X : in  std_logic_vector(28 downto 0);
             Y : in  std_logic_vector(28 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(28 downto 0)   );
   end component;

   component IntAdder_29_F0_uid36_PositDiv32 is
      port ( X : in  std_logic_vector(28 downto 0);
             Y : in  std_logic_vector(28 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(28 downto 0)   );
   end component;

   component IntAdder_29_F0_uid38_PositDiv32 is
      port ( X : in  std_logic_vector(28 downto 0);
             Y : in  std_logic_vector(28 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(28 downto 0)   );
   end component;

   component IntAdder_29_F0_uid40_PositDiv32 is
      port ( X : in  std_logic_vector(28 downto 0);
             Y : in  std_logic_vector(28 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(28 downto 0)   );
   end component;

   component IntAdder_29_F0_uid42_PositDiv32 is
      port ( X : in  std_logic_vector(28 downto 0);
             Y : in  std_logic_vector(28 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(28 downto 0)   );
   end component;

   component IntAdder_29_F0_uid44_PositDiv32 is
      port ( X : in  std_logic_vector(28 downto 0);
             Y : in  std_logic_vector(28 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(28 downto 0)   );
   end component;

   component IntAdder_29_F0_uid46_PositDiv32 is
      port ( X : in  std_logic_vector(28 downto 0);
             Y : in  std_logic_vector(28 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(28 downto 0)   );
   end component;

   component IntAdder_29_F0_uid48_PositDiv32 is
      port ( X : in  std_logic_vector(28 downto 0);
             Y : in  std_logic_vector(28 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(28 downto 0)   );
   end component;

   component IntAdder_29_F0_uid50_PositDiv32 is
      port ( X : in  std_logic_vector(28 downto 0);
             Y : in  std_logic_vector(28 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(28 downto 0)   );
   end component;

   component IntAdder_29_F0_uid52_PositDiv32 is
      port ( X : in  std_logic_vector(28 downto 0);
             Y : in  std_logic_vector(28 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(28 downto 0)   );
   end component;

   component IntAdder_29_F0_uid54_PositDiv32 is
      port ( X : in  std_logic_vector(28 downto 0);
             Y : in  std_logic_vector(28 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(28 downto 0)   );
   end component;

   component IntAdder_29_F0_uid56_PositDiv32 is
      port ( X : in  std_logic_vector(28 downto 0);
             Y : in  std_logic_vector(28 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(28 downto 0)   );
   end component;

   component IntAdder_29_F0_uid58_PositDiv32 is
      port ( X : in  std_logic_vector(28 downto 0);
             Y : in  std_logic_vector(28 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(28 downto 0)   );
   end component;

   component IntAdder_29_F0_uid60_PositDiv32 is
      port ( X : in  std_logic_vector(28 downto 0);
             Y : in  std_logic_vector(28 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(28 downto 0)   );
   end component;

   component IntAdder_29_F0_uid62_PositDiv32 is
      port ( X : in  std_logic_vector(28 downto 0);
             Y : in  std_logic_vector(28 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(28 downto 0)   );
   end component;

   component IntAdder_29_F0_uid64_PositDiv32 is
      port ( X : in  std_logic_vector(28 downto 0);
             Y : in  std_logic_vector(28 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(28 downto 0)   );
   end component;

   component IntAdder_29_F0_uid66_PositDiv32 is
      port ( X : in  std_logic_vector(28 downto 0);
             Y : in  std_logic_vector(28 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(28 downto 0)   );
   end component;

   component IntAdder_29_F0_uid68_PositDiv32 is
      port ( X : in  std_logic_vector(28 downto 0);
             Y : in  std_logic_vector(28 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(28 downto 0)   );
   end component;

   component IntAdder_29_F0_uid70_PositDiv32 is
      port ( X : in  std_logic_vector(28 downto 0);
             Y : in  std_logic_vector(28 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(28 downto 0)   );
   end component;

   component IntAdder_29_F0_uid72_PositDiv32 is
      port ( X : in  std_logic_vector(28 downto 0);
             Y : in  std_logic_vector(28 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(28 downto 0)   );
   end component;

   component IntAdder_29_F0_uid74_PositDiv32 is
      port ( X : in  std_logic_vector(28 downto 0);
             Y : in  std_logic_vector(28 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(28 downto 0)   );
   end component;

   component IntAdder_33_F0_uid76_PositDiv32 is
      port ( X : in  std_logic_vector(32 downto 0);
             Y : in  std_logic_vector(32 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(32 downto 0)   );
   end component;

   component IntAdder_33_F0_uid78_PositDiv32 is
      port ( X : in  std_logic_vector(32 downto 0);
             Y : in  std_logic_vector(32 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(32 downto 0)   );
   end component;

signal X_minus_two :  std_logic;
signal Y_plus_one :  std_logic;
signal corner_case :  std_logic;
signal X_sign :  std_logic;
signal div :  std_logic_vector(28 downto 0);
signal div_sign :  std_logic;
signal diff_signs :  std_logic;
signal div_ge_tmp :  std_logic;
signal div_gr :  std_logic;
signal n_0 :  std_logic_vector(28 downto 0);
signal append_0 :  std_logic;
signal neg_div :  std_logic_vector(28 downto 0);
signal one_bit :  std_logic;
signal s_1 :  std_logic;
signal r_0 :  std_logic_vector(28 downto 0);
signal pm_div_1 :  std_logic_vector(28 downto 0);
signal n_1 :  std_logic_vector(28 downto 0);
signal rem_z_0 :  std_logic;
signal z_1 :  std_logic;
signal s_2 :  std_logic;
signal r_1 :  std_logic_vector(28 downto 0);
signal pm_div_2 :  std_logic_vector(28 downto 0);
signal n_2 :  std_logic_vector(28 downto 0);
signal rem_z_1 :  std_logic;
signal z_2 :  std_logic;
signal s_3 :  std_logic;
signal r_2 :  std_logic_vector(28 downto 0);
signal pm_div_3 :  std_logic_vector(28 downto 0);
signal n_3 :  std_logic_vector(28 downto 0);
signal rem_z_2 :  std_logic;
signal z_3 :  std_logic;
signal s_4 :  std_logic;
signal r_3 :  std_logic_vector(28 downto 0);
signal pm_div_4 :  std_logic_vector(28 downto 0);
signal n_4 :  std_logic_vector(28 downto 0);
signal rem_z_3 :  std_logic;
signal z_4 :  std_logic;
signal s_5 :  std_logic;
signal r_4 :  std_logic_vector(28 downto 0);
signal pm_div_5 :  std_logic_vector(28 downto 0);
signal n_5 :  std_logic_vector(28 downto 0);
signal rem_z_4 :  std_logic;
signal z_5 :  std_logic;
signal s_6 :  std_logic;
signal r_5 :  std_logic_vector(28 downto 0);
signal pm_div_6 :  std_logic_vector(28 downto 0);
signal n_6 :  std_logic_vector(28 downto 0);
signal rem_z_5 :  std_logic;
signal z_6 :  std_logic;
signal s_7 :  std_logic;
signal r_6 :  std_logic_vector(28 downto 0);
signal pm_div_7 :  std_logic_vector(28 downto 0);
signal n_7 :  std_logic_vector(28 downto 0);
signal rem_z_6 :  std_logic;
signal z_7 :  std_logic;
signal s_8 :  std_logic;
signal r_7 :  std_logic_vector(28 downto 0);
signal pm_div_8 :  std_logic_vector(28 downto 0);
signal n_8 :  std_logic_vector(28 downto 0);
signal rem_z_7 :  std_logic;
signal z_8 :  std_logic;
signal s_9 :  std_logic;
signal r_8 :  std_logic_vector(28 downto 0);
signal pm_div_9 :  std_logic_vector(28 downto 0);
signal n_9 :  std_logic_vector(28 downto 0);
signal rem_z_8 :  std_logic;
signal z_9 :  std_logic;
signal s_10 :  std_logic;
signal r_9 :  std_logic_vector(28 downto 0);
signal pm_div_10 :  std_logic_vector(28 downto 0);
signal n_10 :  std_logic_vector(28 downto 0);
signal rem_z_9 :  std_logic;
signal z_10 :  std_logic;
signal s_11 :  std_logic;
signal r_10 :  std_logic_vector(28 downto 0);
signal pm_div_11 :  std_logic_vector(28 downto 0);
signal n_11 :  std_logic_vector(28 downto 0);
signal rem_z_10 :  std_logic;
signal z_11 :  std_logic;
signal s_12 :  std_logic;
signal r_11 :  std_logic_vector(28 downto 0);
signal pm_div_12 :  std_logic_vector(28 downto 0);
signal n_12 :  std_logic_vector(28 downto 0);
signal rem_z_11 :  std_logic;
signal z_12 :  std_logic;
signal s_13 :  std_logic;
signal r_12 :  std_logic_vector(28 downto 0);
signal pm_div_13 :  std_logic_vector(28 downto 0);
signal n_13 :  std_logic_vector(28 downto 0);
signal rem_z_12 :  std_logic;
signal z_13 :  std_logic;
signal s_14 :  std_logic;
signal r_13 :  std_logic_vector(28 downto 0);
signal pm_div_14 :  std_logic_vector(28 downto 0);
signal n_14 :  std_logic_vector(28 downto 0);
signal rem_z_13 :  std_logic;
signal z_14 :  std_logic;
signal s_15 :  std_logic;
signal r_14 :  std_logic_vector(28 downto 0);
signal pm_div_15 :  std_logic_vector(28 downto 0);
signal n_15 :  std_logic_vector(28 downto 0);
signal rem_z_14 :  std_logic;
signal z_15 :  std_logic;
signal s_16 :  std_logic;
signal r_15 :  std_logic_vector(28 downto 0);
signal pm_div_16 :  std_logic_vector(28 downto 0);
signal n_16 :  std_logic_vector(28 downto 0);
signal rem_z_15 :  std_logic;
signal z_16 :  std_logic;
signal s_17 :  std_logic;
signal r_16 :  std_logic_vector(28 downto 0);
signal pm_div_17 :  std_logic_vector(28 downto 0);
signal n_17 :  std_logic_vector(28 downto 0);
signal rem_z_16 :  std_logic;
signal z_17 :  std_logic;
signal s_18 :  std_logic;
signal r_17 :  std_logic_vector(28 downto 0);
signal pm_div_18 :  std_logic_vector(28 downto 0);
signal n_18 :  std_logic_vector(28 downto 0);
signal rem_z_17 :  std_logic;
signal z_18 :  std_logic;
signal s_19 :  std_logic;
signal r_18 :  std_logic_vector(28 downto 0);
signal pm_div_19 :  std_logic_vector(28 downto 0);
signal n_19 :  std_logic_vector(28 downto 0);
signal rem_z_18 :  std_logic;
signal z_19 :  std_logic;
signal s_20 :  std_logic;
signal r_19 :  std_logic_vector(28 downto 0);
signal pm_div_20 :  std_logic_vector(28 downto 0);
signal n_20 :  std_logic_vector(28 downto 0);
signal rem_z_19 :  std_logic;
signal z_20 :  std_logic;
signal s_21 :  std_logic;
signal r_20 :  std_logic_vector(28 downto 0);
signal pm_div_21 :  std_logic_vector(28 downto 0);
signal n_21 :  std_logic_vector(28 downto 0);
signal rem_z_20 :  std_logic;
signal z_21 :  std_logic;
signal s_22 :  std_logic;
signal r_21 :  std_logic_vector(28 downto 0);
signal pm_div_22 :  std_logic_vector(28 downto 0);
signal n_22 :  std_logic_vector(28 downto 0);
signal rem_z_21 :  std_logic;
signal z_22 :  std_logic;
signal s_23 :  std_logic;
signal r_22 :  std_logic_vector(28 downto 0);
signal pm_div_23 :  std_logic_vector(28 downto 0);
signal n_23 :  std_logic_vector(28 downto 0);
signal rem_z_22 :  std_logic;
signal z_23 :  std_logic;
signal s_24 :  std_logic;
signal r_23 :  std_logic_vector(28 downto 0);
signal pm_div_24 :  std_logic_vector(28 downto 0);
signal n_24 :  std_logic_vector(28 downto 0);
signal rem_z_23 :  std_logic;
signal z_24 :  std_logic;
signal s_25 :  std_logic;
signal r_24 :  std_logic_vector(28 downto 0);
signal pm_div_25 :  std_logic_vector(28 downto 0);
signal n_25 :  std_logic_vector(28 downto 0);
signal rem_z_24 :  std_logic;
signal z_25 :  std_logic;
signal s_26 :  std_logic;
signal r_25 :  std_logic_vector(28 downto 0);
signal pm_div_26 :  std_logic_vector(28 downto 0);
signal n_26 :  std_logic_vector(28 downto 0);
signal rem_z_25 :  std_logic;
signal z_26 :  std_logic;
signal s_27 :  std_logic;
signal r_26 :  std_logic_vector(28 downto 0);
signal pm_div_27 :  std_logic_vector(28 downto 0);
signal n_27 :  std_logic_vector(28 downto 0);
signal rem_z_26 :  std_logic;
signal z_27 :  std_logic;
signal s_28 :  std_logic;
signal r_27 :  std_logic_vector(28 downto 0);
signal pm_div_28 :  std_logic_vector(28 downto 0);
signal n_28 :  std_logic_vector(28 downto 0);
signal rem_z_27 :  std_logic;
signal z_28 :  std_logic;
signal s_29 :  std_logic;
signal r_28 :  std_logic_vector(28 downto 0);
signal pm_div_29 :  std_logic_vector(28 downto 0);
signal n_29 :  std_logic_vector(28 downto 0);
signal rem_z_28 :  std_logic;
signal z_29 :  std_logic;
signal s_30 :  std_logic;
signal r_29 :  std_logic_vector(28 downto 0);
signal pm_div_30 :  std_logic_vector(28 downto 0);
signal n_30 :  std_logic_vector(28 downto 0);
signal rem_z_29 :  std_logic;
signal z_30 :  std_logic;
signal s_31 :  std_logic;
signal r_30 :  std_logic_vector(28 downto 0);
signal pm_div_31 :  std_logic_vector(28 downto 0);
signal n_31 :  std_logic_vector(28 downto 0);
signal rem_z_30 :  std_logic;
signal z_31 :  std_logic;
signal q_1 :  std_logic_vector(32 downto 0);
signal q_2 :  std_logic_vector(32 downto 0);
signal quotient_tmp :  std_logic_vector(32 downto 0);
signal rem_sign :  std_logic;
signal rem_div_sign :  std_logic;
signal rem_dvr_sign :  std_logic;
signal div_div_sign :  std_logic;
signal interm_zero_rem :  std_logic;
signal q_config :  std_logic_vector(4 downto 0);
signal zz :  std_logic;
signal sub_add_ulp :  std_logic_vector(32 downto 0);
signal quotient_aux :  std_logic_vector(32 downto 0);
signal quotient :  std_logic_vector(31 downto 0);
begin
--------------------------- Start of vhdl generation ---------------------------
----------------------- Non-Restoring Division algorithm -----------------------
   X_minus_two <= '1' when X = "10000000000000000000000000000" else '0';
   Y_plus_one <= '1' when Y = "01000000000000000000000000000" else '0';
   corner_case <= X_minus_two AND Y_plus_one;
   X_sign <= X(28);
   div <= Y;
   div_sign <= Y(28);
   diff_signs <= X_sign XOR div_sign;
   div_ge_tmp <= '1' when Y(27 downto 0) > X(27 downto 0) else '0';
   div_gr <= '0';
   n_0 <= X when div_gr='1' else (X(28) & X(28 downto 1));
   append_0 <= '0' when div_gr='1' else X(0);
   neg_div <= NOT(Y);
   one_bit <= '1' ;
   -- Iteration 1
   s_1 <= NOT(n_0(28) XOR div_sign);
   r_0 <= n_0(27 downto 0) & append_0;
   pm_div_1 <= div when s_1='0' else neg_div;
   sub_0: IntAdder_29_F0_uid14_PositDiv32
      port map ( Cin => s_1,
                 X => r_0,
                 Y => pm_div_1,
                 R => n_1);
   rem_z_0 <= '1' when n_1 = 0 else '0';
   z_1 <= rem_z_0;
   -- Iteration 2
   s_2 <= NOT(n_1(28) XOR div_sign);
   r_1 <= n_1(27 downto 0) & '0';
   pm_div_2 <= div when s_2='0' else neg_div;
   sub_1: IntAdder_29_F0_uid16_PositDiv32
      port map ( Cin => s_2,
                 X => r_1,
                 Y => pm_div_2,
                 R => n_2);
   rem_z_1 <= '1' when n_2 = 0 else '0';
   z_2 <= rem_z_1 OR z_1;
   -- Iteration 3
   s_3 <= NOT(n_2(28) XOR div_sign);
   r_2 <= n_2(27 downto 0) & '0';
   pm_div_3 <= div when s_3='0' else neg_div;
   sub_2: IntAdder_29_F0_uid18_PositDiv32
      port map ( Cin => s_3,
                 X => r_2,
                 Y => pm_div_3,
                 R => n_3);
   rem_z_2 <= '1' when n_3 = 0 else '0';
   z_3 <= rem_z_2 OR z_2;
   -- Iteration 4
   s_4 <= NOT(n_3(28) XOR div_sign);
   r_3 <= n_3(27 downto 0) & '0';
   pm_div_4 <= div when s_4='0' else neg_div;
   sub_3: IntAdder_29_F0_uid20_PositDiv32
      port map ( Cin => s_4,
                 X => r_3,
                 Y => pm_div_4,
                 R => n_4);
   rem_z_3 <= '1' when n_4 = 0 else '0';
   z_4 <= rem_z_3 OR z_3;
   -- Iteration 5
   s_5 <= NOT(n_4(28) XOR div_sign);
   r_4 <= n_4(27 downto 0) & '0';
   pm_div_5 <= div when s_5='0' else neg_div;
   sub_4: IntAdder_29_F0_uid22_PositDiv32
      port map ( Cin => s_5,
                 X => r_4,
                 Y => pm_div_5,
                 R => n_5);
   rem_z_4 <= '1' when n_5 = 0 else '0';
   z_5 <= rem_z_4 OR z_4;
   -- Iteration 6
   s_6 <= NOT(n_5(28) XOR div_sign);
   r_5 <= n_5(27 downto 0) & '0';
   pm_div_6 <= div when s_6='0' else neg_div;
   sub_5: IntAdder_29_F0_uid24_PositDiv32
      port map ( Cin => s_6,
                 X => r_5,
                 Y => pm_div_6,
                 R => n_6);
   rem_z_5 <= '1' when n_6 = 0 else '0';
   z_6 <= rem_z_5 OR z_5;
   -- Iteration 7
   s_7 <= NOT(n_6(28) XOR div_sign);
   r_6 <= n_6(27 downto 0) & '0';
   pm_div_7 <= div when s_7='0' else neg_div;
   sub_6: IntAdder_29_F0_uid26_PositDiv32
      port map ( Cin => s_7,
                 X => r_6,
                 Y => pm_div_7,
                 R => n_7);
   rem_z_6 <= '1' when n_7 = 0 else '0';
   z_7 <= rem_z_6 OR z_6;
   -- Iteration 8
   s_8 <= NOT(n_7(28) XOR div_sign);
   r_7 <= n_7(27 downto 0) & '0';
   pm_div_8 <= div when s_8='0' else neg_div;
   sub_7: IntAdder_29_F0_uid28_PositDiv32
      port map ( Cin => s_8,
                 X => r_7,
                 Y => pm_div_8,
                 R => n_8);
   rem_z_7 <= '1' when n_8 = 0 else '0';
   z_8 <= rem_z_7 OR z_7;
   -- Iteration 9
   s_9 <= NOT(n_8(28) XOR div_sign);
   r_8 <= n_8(27 downto 0) & '0';
   pm_div_9 <= div when s_9='0' else neg_div;
   sub_8: IntAdder_29_F0_uid30_PositDiv32
      port map ( Cin => s_9,
                 X => r_8,
                 Y => pm_div_9,
                 R => n_9);
   rem_z_8 <= '1' when n_9 = 0 else '0';
   z_9 <= rem_z_8 OR z_8;
   -- Iteration 10
   s_10 <= NOT(n_9(28) XOR div_sign);
   r_9 <= n_9(27 downto 0) & '0';
   pm_div_10 <= div when s_10='0' else neg_div;
   sub_9: IntAdder_29_F0_uid32_PositDiv32
      port map ( Cin => s_10,
                 X => r_9,
                 Y => pm_div_10,
                 R => n_10);
   rem_z_9 <= '1' when n_10 = 0 else '0';
   z_10 <= rem_z_9 OR z_9;
   -- Iteration 11
   s_11 <= NOT(n_10(28) XOR div_sign);
   r_10 <= n_10(27 downto 0) & '0';
   pm_div_11 <= div when s_11='0' else neg_div;
   sub_10: IntAdder_29_F0_uid34_PositDiv32
      port map ( Cin => s_11,
                 X => r_10,
                 Y => pm_div_11,
                 R => n_11);
   rem_z_10 <= '1' when n_11 = 0 else '0';
   z_11 <= rem_z_10 OR z_10;
   -- Iteration 12
   s_12 <= NOT(n_11(28) XOR div_sign);
   r_11 <= n_11(27 downto 0) & '0';
   pm_div_12 <= div when s_12='0' else neg_div;
   sub_11: IntAdder_29_F0_uid36_PositDiv32
      port map ( Cin => s_12,
                 X => r_11,
                 Y => pm_div_12,
                 R => n_12);
   rem_z_11 <= '1' when n_12 = 0 else '0';
   z_12 <= rem_z_11 OR z_11;
   -- Iteration 13
   s_13 <= NOT(n_12(28) XOR div_sign);
   r_12 <= n_12(27 downto 0) & '0';
   pm_div_13 <= div when s_13='0' else neg_div;
   sub_12: IntAdder_29_F0_uid38_PositDiv32
      port map ( Cin => s_13,
                 X => r_12,
                 Y => pm_div_13,
                 R => n_13);
   rem_z_12 <= '1' when n_13 = 0 else '0';
   z_13 <= rem_z_12 OR z_12;
   -- Iteration 14
   s_14 <= NOT(n_13(28) XOR div_sign);
   r_13 <= n_13(27 downto 0) & '0';
   pm_div_14 <= div when s_14='0' else neg_div;
   sub_13: IntAdder_29_F0_uid40_PositDiv32
      port map ( Cin => s_14,
                 X => r_13,
                 Y => pm_div_14,
                 R => n_14);
   rem_z_13 <= '1' when n_14 = 0 else '0';
   z_14 <= rem_z_13 OR z_13;
   -- Iteration 15
   s_15 <= NOT(n_14(28) XOR div_sign);
   r_14 <= n_14(27 downto 0) & '0';
   pm_div_15 <= div when s_15='0' else neg_div;
   sub_14: IntAdder_29_F0_uid42_PositDiv32
      port map ( Cin => s_15,
                 X => r_14,
                 Y => pm_div_15,
                 R => n_15);
   rem_z_14 <= '1' when n_15 = 0 else '0';
   z_15 <= rem_z_14 OR z_14;
   -- Iteration 16
   s_16 <= NOT(n_15(28) XOR div_sign);
   r_15 <= n_15(27 downto 0) & '0';
   pm_div_16 <= div when s_16='0' else neg_div;
   sub_15: IntAdder_29_F0_uid44_PositDiv32
      port map ( Cin => s_16,
                 X => r_15,
                 Y => pm_div_16,
                 R => n_16);
   rem_z_15 <= '1' when n_16 = 0 else '0';
   z_16 <= rem_z_15 OR z_15;
   -- Iteration 17
   s_17 <= NOT(n_16(28) XOR div_sign);
   r_16 <= n_16(27 downto 0) & '0';
   pm_div_17 <= div when s_17='0' else neg_div;
   sub_16: IntAdder_29_F0_uid46_PositDiv32
      port map ( Cin => s_17,
                 X => r_16,
                 Y => pm_div_17,
                 R => n_17);
   rem_z_16 <= '1' when n_17 = 0 else '0';
   z_17 <= rem_z_16 OR z_16;
   -- Iteration 18
   s_18 <= NOT(n_17(28) XOR div_sign);
   r_17 <= n_17(27 downto 0) & '0';
   pm_div_18 <= div when s_18='0' else neg_div;
   sub_17: IntAdder_29_F0_uid48_PositDiv32
      port map ( Cin => s_18,
                 X => r_17,
                 Y => pm_div_18,
                 R => n_18);
   rem_z_17 <= '1' when n_18 = 0 else '0';
   z_18 <= rem_z_17 OR z_17;
   -- Iteration 19
   s_19 <= NOT(n_18(28) XOR div_sign);
   r_18 <= n_18(27 downto 0) & '0';
   pm_div_19 <= div when s_19='0' else neg_div;
   sub_18: IntAdder_29_F0_uid50_PositDiv32
      port map ( Cin => s_19,
                 X => r_18,
                 Y => pm_div_19,
                 R => n_19);
   rem_z_18 <= '1' when n_19 = 0 else '0';
   z_19 <= rem_z_18 OR z_18;
   -- Iteration 20
   s_20 <= NOT(n_19(28) XOR div_sign);
   r_19 <= n_19(27 downto 0) & '0';
   pm_div_20 <= div when s_20='0' else neg_div;
   sub_19: IntAdder_29_F0_uid52_PositDiv32
      port map ( Cin => s_20,
                 X => r_19,
                 Y => pm_div_20,
                 R => n_20);
   rem_z_19 <= '1' when n_20 = 0 else '0';
   z_20 <= rem_z_19 OR z_19;
   -- Iteration 21
   s_21 <= NOT(n_20(28) XOR div_sign);
   r_20 <= n_20(27 downto 0) & '0';
   pm_div_21 <= div when s_21='0' else neg_div;
   sub_20: IntAdder_29_F0_uid54_PositDiv32
      port map ( Cin => s_21,
                 X => r_20,
                 Y => pm_div_21,
                 R => n_21);
   rem_z_20 <= '1' when n_21 = 0 else '0';
   z_21 <= rem_z_20 OR z_20;
   -- Iteration 22
   s_22 <= NOT(n_21(28) XOR div_sign);
   r_21 <= n_21(27 downto 0) & '0';
   pm_div_22 <= div when s_22='0' else neg_div;
   sub_21: IntAdder_29_F0_uid56_PositDiv32
      port map ( Cin => s_22,
                 X => r_21,
                 Y => pm_div_22,
                 R => n_22);
   rem_z_21 <= '1' when n_22 = 0 else '0';
   z_22 <= rem_z_21 OR z_21;
   -- Iteration 23
   s_23 <= NOT(n_22(28) XOR div_sign);
   r_22 <= n_22(27 downto 0) & '0';
   pm_div_23 <= div when s_23='0' else neg_div;
   sub_22: IntAdder_29_F0_uid58_PositDiv32
      port map ( Cin => s_23,
                 X => r_22,
                 Y => pm_div_23,
                 R => n_23);
   rem_z_22 <= '1' when n_23 = 0 else '0';
   z_23 <= rem_z_22 OR z_22;
   -- Iteration 24
   s_24 <= NOT(n_23(28) XOR div_sign);
   r_23 <= n_23(27 downto 0) & '0';
   pm_div_24 <= div when s_24='0' else neg_div;
   sub_23: IntAdder_29_F0_uid60_PositDiv32
      port map ( Cin => s_24,
                 X => r_23,
                 Y => pm_div_24,
                 R => n_24);
   rem_z_23 <= '1' when n_24 = 0 else '0';
   z_24 <= rem_z_23 OR z_23;
   -- Iteration 25
   s_25 <= NOT(n_24(28) XOR div_sign);
   r_24 <= n_24(27 downto 0) & '0';
   pm_div_25 <= div when s_25='0' else neg_div;
   sub_24: IntAdder_29_F0_uid62_PositDiv32
      port map ( Cin => s_25,
                 X => r_24,
                 Y => pm_div_25,
                 R => n_25);
   rem_z_24 <= '1' when n_25 = 0 else '0';
   z_25 <= rem_z_24 OR z_24;
   -- Iteration 26
   s_26 <= NOT(n_25(28) XOR div_sign);
   r_25 <= n_25(27 downto 0) & '0';
   pm_div_26 <= div when s_26='0' else neg_div;
   sub_25: IntAdder_29_F0_uid64_PositDiv32
      port map ( Cin => s_26,
                 X => r_25,
                 Y => pm_div_26,
                 R => n_26);
   rem_z_25 <= '1' when n_26 = 0 else '0';
   z_26 <= rem_z_25 OR z_25;
   -- Iteration 27
   s_27 <= NOT(n_26(28) XOR div_sign);
   r_26 <= n_26(27 downto 0) & '0';
   pm_div_27 <= div when s_27='0' else neg_div;
   sub_26: IntAdder_29_F0_uid66_PositDiv32
      port map ( Cin => s_27,
                 X => r_26,
                 Y => pm_div_27,
                 R => n_27);
   rem_z_26 <= '1' when n_27 = 0 else '0';
   z_27 <= rem_z_26 OR z_26;
   -- Iteration 28
   s_28 <= NOT(n_27(28) XOR div_sign);
   r_27 <= n_27(27 downto 0) & '0';
   pm_div_28 <= div when s_28='0' else neg_div;
   sub_27: IntAdder_29_F0_uid68_PositDiv32
      port map ( Cin => s_28,
                 X => r_27,
                 Y => pm_div_28,
                 R => n_28);
   rem_z_27 <= '1' when n_28 = 0 else '0';
   z_28 <= rem_z_27 OR z_27;
   -- Iteration 29
   s_29 <= NOT(n_28(28) XOR div_sign);
   r_28 <= n_28(27 downto 0) & '0';
   pm_div_29 <= div when s_29='0' else neg_div;
   sub_28: IntAdder_29_F0_uid70_PositDiv32
      port map ( Cin => s_29,
                 X => r_28,
                 Y => pm_div_29,
                 R => n_29);
   rem_z_28 <= '1' when n_29 = 0 else '0';
   z_29 <= rem_z_28 OR z_28;
   -- Iteration 30
   s_30 <= NOT(n_29(28) XOR div_sign);
   r_29 <= n_29(27 downto 0) & '0';
   pm_div_30 <= div when s_30='0' else neg_div;
   sub_29: IntAdder_29_F0_uid72_PositDiv32
      port map ( Cin => s_30,
                 X => r_29,
                 Y => pm_div_30,
                 R => n_30);
   rem_z_29 <= '1' when n_30 = 0 else '0';
   z_30 <= rem_z_29 OR z_29;
   -- Iteration 31
   s_31 <= NOT(n_30(28) XOR div_sign);
   r_30 <= n_30(27 downto 0) & '0';
   pm_div_31 <= div when s_31='0' else neg_div;
   sub_30: IntAdder_29_F0_uid74_PositDiv32
      port map ( Cin => s_31,
                 X => r_30,
                 Y => pm_div_31,
                 R => n_31);
   rem_z_30 <= '1' when n_31 = 0 else '0';
   z_31 <= rem_z_30 OR z_30;
   -- Convert the quotient to the digit set {0,1}
   q_1 <= "00" & s_1 & s_2 & s_3 & s_4 & s_5 & s_6 & s_7 & s_8 & s_9 & s_10 & s_11 & s_12 & s_13 & s_14 & s_15 & s_16 & s_17 & s_18 & s_19 & s_20 & s_21 & s_22 & s_23 & s_24 & s_25 & s_26 & s_27 & s_28 & s_29 & s_30 & s_31 ;
   q_2 <= "11" & s_1 & s_2 & s_3 & s_4 & s_5 & s_6 & s_7 & s_8 & s_9 & s_10 & s_11 & s_12 & s_13 & s_14 & s_15 & s_16 & s_17 & s_18 & s_19 & s_20 & s_21 & s_22 & s_23 & s_24 & s_25 & s_26 & s_27 & s_28 & s_29 & s_30 & s_31 ;
   sub_quotient: IntAdder_33_F0_uid76_PositDiv32
      port map ( Cin => one_bit,
                 X => q_1,
                 Y => q_2,
                 R => quotient_tmp);
   -- Correction step
   rem_sign <= n_31(28);
   rem_div_sign <= NOT(rem_z_30) AND (rem_sign XOR X_sign);
   rem_dvr_sign <= rem_sign XOR div_sign;
   div_div_sign <= X_sign XOR div_sign;
   interm_zero_rem <= NOT(rem_z_30) AND z_31;
   q_config <= '0' & div_div_sign & interm_zero_rem & rem_dvr_sign & corner_case;
   zz <= '0';
   with q_config  select  sub_add_ulp <= 
      "111111111111111111111111111111111" when "10000" | "10010" | "10100" | "10110",
      "00000000000000000000000000000000" & '1' when "11000" | "11010" | "11100" | "11110",
      "111111111111111111111111111111111" when "00110" | "01110",
      "00000000000000000000000000000000" & '1' when "00100" | "01100",
      "111111111111111111111111111111111" when "00001" | "00011" | "00101" | "00111" | "01001" | "01011" | "01101" | "01111" | "10001" | "10011" | "10101" | "10111" | "11001" | "11011" | "11101" | "11111",
      "000000000000000000000000000000000" when others;
   correct_quotient: IntAdder_33_F0_uid78_PositDiv32
      port map ( Cin => zz,
                 X => quotient_tmp,
                 Y => sub_add_ulp,
                 R => quotient_aux);
   quotient <= quotient_aux(32 downto 1) when div_gr='1' else (quotient_aux(31 downto 0));
   R <= quotient;
---------------------------- End of vhdl generation ----------------------------
end architecture;

--------------------------------------------------------------------------------
--                  RightShifterSticky31_by_max_31_F0_uid82_PositDiv32
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

entity RightShifterSticky31_by_max_31_F0_uid82_PositDiv32 is
    port (X : in  std_logic_vector(30 downto 0);
          S : in  std_logic_vector(4 downto 0);
          padBit : in  std_logic;
          R : out  std_logic_vector(30 downto 0);
          Sticky : out  std_logic   );
end entity;

architecture arch of RightShifterSticky31_by_max_31_F0_uid82_PositDiv32 is
signal ps :  std_logic_vector(4 downto 0);
signal Xpadded :  std_logic_vector(30 downto 0);
signal level5 :  std_logic_vector(30 downto 0);
signal stk4 :  std_logic;
signal level4 :  std_logic_vector(30 downto 0);
signal stk3 :  std_logic;
signal level3 :  std_logic_vector(30 downto 0);
signal stk2 :  std_logic;
signal level2 :  std_logic_vector(30 downto 0);
signal stk1 :  std_logic;
signal level1 :  std_logic_vector(30 downto 0);
signal stk0 :  std_logic;
signal level0 :  std_logic_vector(30 downto 0);
begin
   ps<= S;
   Xpadded <= X;
   level5<= Xpadded;
   stk4 <= '1' when (level5(15 downto 0)/="0000000000000000" and ps(4)='1')   else '0';
   level4 <=  level5 when  ps(4)='0'    else (15 downto 0 => padBit) & level5(30 downto 16);
   stk3 <= '1' when (level4(7 downto 0)/="00000000" and ps(3)='1') or stk4 ='1'   else '0';
   level3 <=  level4 when  ps(3)='0'    else (7 downto 0 => padBit) & level4(30 downto 8);
   stk2 <= '1' when (level3(3 downto 0)/="0000" and ps(2)='1') or stk3 ='1'   else '0';
   level2 <=  level3 when  ps(2)='0'    else (3 downto 0 => padBit) & level3(30 downto 4);
   stk1 <= '1' when (level2(1 downto 0)/="00" and ps(1)='1') or stk2 ='1'   else '0';
   level1 <=  level2 when  ps(1)='0'    else (1 downto 0 => padBit) & level2(30 downto 2);
   stk0 <= '1' when (level1(0 downto 0)/="0" and ps(0)='1') or stk1 ='1'   else '0';
   level0 <=  level1 when  ps(0)='0'    else (0 downto 0 => padBit) & level1(30 downto 1);
   R <= level0;
   Sticky <= stk0;
end architecture;

--------------------------------------------------------------------------------
--                       PositFastEncoder_32_2_F0_uid80_PositDiv32
-- Version: 2024.06.24 - 135042
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

entity PositFastEncoder_32_2_F0_uid80_PositDiv32 is
    port (Sign : in  std_logic;
          SF : in  std_logic_vector(8 downto 0);
          Frac : in  std_logic_vector(26 downto 0);
          Guard : in  std_logic;
          Sticky : in  std_logic;
          NZN : in  std_logic;
          R : out  std_logic_vector(31 downto 0)   );
end entity;

architecture arch of PositFastEncoder_32_2_F0_uid80_PositDiv32 is
   component RightShifterSticky31_by_max_31_F0_uid82_PositDiv32 is
      port ( X : in  std_logic_vector(30 downto 0);
             S : in  std_logic_vector(4 downto 0);
             padBit : in  std_logic;
             R : out  std_logic_vector(30 downto 0);
             Sticky : out  std_logic   );
   end component;

signal rc :  std_logic;
signal rcVect :  std_logic_vector(5 downto 0);
signal k :  std_logic_vector(5 downto 0);
signal sgnVect :  std_logic_vector(1 downto 0);
signal exp :  std_logic_vector(1 downto 0);
signal ovf :  std_logic;
signal regValue :  std_logic_vector(4 downto 0);
signal regNeg :  std_logic;
signal padBit :  std_logic;
signal inputShifter :  std_logic_vector(30 downto 0);
signal shiftedPosit :  std_logic_vector(30 downto 0);
signal stkBit :  std_logic;
signal unroundedPosit :  std_logic_vector(30 downto 0);
signal lsb :  std_logic;
signal rnd :  std_logic;
signal stk :  std_logic;
signal round :  std_logic;
signal roundedPosit :  std_logic_vector(30 downto 0);
signal unsignedPosit :  std_logic_vector(30 downto 0);
begin
--------------------------- Start of vhdl generation ---------------------------
----------------------------- Get value of regime -----------------------------
   rc <= SF(SF'high);
   rcVect <= (others => rc);
   k <= SF(7 downto 2) XOR rcVect;
   sgnVect <= (others => Sign);
   exp <= SF(1 downto 0) XOR sgnVect;
   -- Check for regime overflow
   ovf <= '1' when (k > "011101") else '0';
   regValue <= k(4 downto 0) when ovf = '0' else "11110";
-------------- Generate regime - shift out exponent and fraction --------------
   regNeg <= Sign XOR rc;
   padBit <= NOT(regNeg);
   inputShifter <= regNeg & exp & Frac & Guard;
   RegimeGenerator: RightShifterSticky31_by_max_31_F0_uid82_PositDiv32
      port map ( S => regValue,
                 X => inputShifter,
                 padBit => padBit,
                 R => shiftedPosit,
                 Sticky => stkBit);
   unroundedPosit <= padBit & shiftedPosit(30 downto 1);
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
--                                  PositDiv32
--                          (PositDiv32_32_2_F0_uid2)
-- Version: 2024.06.24 - 135042
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

entity PositDiv32 is
    port (X : in  std_logic_vector(31 downto 0);
          Y : in  std_logic_vector(31 downto 0);
          R : out  std_logic_vector(31 downto 0)   );
end entity;

architecture arch of PositDiv32 is
   component PositFastDecoder_32_2_F0_uid4_PositDiv32 is
      port ( X : in  std_logic_vector(31 downto 0);
             Sign : out  std_logic;
             SF : out  std_logic_vector(7 downto 0);
             Frac : out  std_logic_vector(26 downto 0);
             NZN : out  std_logic   );
   end component;

   component PositFastDecoder_32_2_F0_uid8_PositDiv32 is
      port ( X : in  std_logic_vector(31 downto 0);
             Sign : out  std_logic;
             SF : out  std_logic_vector(7 downto 0);
             Frac : out  std_logic_vector(26 downto 0);
             NZN : out  std_logic   );
   end component;

   component FixDiv_1_27_F0_uid12_PositDiv32 is
      port ( X : in  std_logic_vector(28 downto 0);
             Y : in  std_logic_vector(28 downto 0);
             R : out  std_logic_vector(31 downto 0)   );
   end component;

   component PositFastEncoder_32_2_F0_uid80_PositDiv32 is
      port ( Sign : in  std_logic;
             SF : in  std_logic_vector(8 downto 0);
             Frac : in  std_logic_vector(26 downto 0);
             Guard : in  std_logic;
             Sticky : in  std_logic;
             NZN : in  std_logic;
             R : out  std_logic_vector(31 downto 0)   );
   end component;

signal X_sgn :  std_logic;
signal X_sf :  std_logic_vector(7 downto 0);
signal X_f :  std_logic_vector(26 downto 0);
signal X_nzn :  std_logic;
signal Y_sgn :  std_logic;
signal Y_sf :  std_logic_vector(7 downto 0);
signal Y_f :  std_logic_vector(26 downto 0);
signal Y_nzn :  std_logic;
signal XY_nzn :  std_logic;
signal X_nar :  std_logic;
signal Y_nar :  std_logic;
signal Y_zero :  std_logic;
signal XX_f :  std_logic_vector(28 downto 0);
signal YY_f :  std_logic_vector(28 downto 0);
signal XY_f :  std_logic_vector(31 downto 0);
signal XY_sgn :  std_logic;
signal shift_1 :  std_logic;
signal shift_2 :  std_logic;
signal shift_case :  std_logic_vector(1 downto 0);
signal XY_frac :  std_logic_vector(26 downto 0);
signal grd :  std_logic;
signal stk_tmp :  std_logic_vector(2 downto 0);
signal stk :  std_logic;
signal XY_sf :  std_logic_vector(8 downto 0);
signal XY_finalSgn :  std_logic;
begin
--------------------------- Start of vhdl generation ---------------------------
---------------------------- Decode X & Y operands ----------------------------
   X_decoder: PositFastDecoder_32_2_F0_uid4_PositDiv32
      port map ( X => X,
                 Frac => X_f,
                 NZN => X_nzn,
                 SF => X_sf,
                 Sign => X_sgn);
   Y_decoder: PositFastDecoder_32_2_F0_uid8_PositDiv32
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
   FracDivider: FixDiv_1_27_F0_uid12_PositDiv32
      port map ( X => XX_f,
                 Y => YY_f,
                 R => XY_f);
   -- Normalize fraction
   XY_sgn <= XY_f(31);
   shift_1 <= XY_f(31) XNOR XY_f(30);
   shift_2 <= XY_f(31) AND XY_f(30) AND XY_f(29);
   shift_case <= shift_1 & shift_2;
   with shift_case  select  XY_frac <= 
      XY_f(27 downto 1) when "11",
      XY_f(28 downto 2) when "10",
      XY_f(29 downto 3) when others;
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
   PositEncoder: PositFastEncoder_32_2_F0_uid80_PositDiv32
      port map ( Frac => XY_frac,
                 Guard => grd,
                 NZN => XY_nzn,
                 SF => XY_sf,
                 Sign => XY_finalSgn,
                 Sticky => stk,
                 R => R);
---------------------------- End of vhdl generation ----------------------------
end architecture;

