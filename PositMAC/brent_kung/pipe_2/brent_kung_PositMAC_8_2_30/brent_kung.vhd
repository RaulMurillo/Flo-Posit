--///////////////////////////////////////////////////////////////////////
-- By Alberto A. Del Barrio (UCM)
-- This is a generic n-bit Brent-Kung adder
--///////////////////////////////////////////////////////////////////////

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity brent_kung is
   generic(N: integer;
           S: integer);--Number of stages=log(N)
	port(
		a: in std_logic_vector((N-1) downto 0);
		b: in std_logic_vector((N-1) downto 0);
		cin: in std_logic;
		z: out std_logic_vector((N-1) downto 0);
		cout: out std_logic
	);
end brent_kung;


architecture estr of brent_kung is
   
   --Types
   
   type matrix is array(0 to 2*S-1) of std_logic_vector((N-1) downto 0);
    
   --Signals
   signal carrys: std_logic_vector((N-1) downto 0);
   
   signal psMatrix: matrix;
   signal gsMatrix: matrix;
    
begin
    
   --Stage 0
   psMatrix(0)(0) <= (a(0) xor b(0));
   gsMatrix(0)(0) <= (a(0) and b(0)) or (a(0) and cin) or (b(0) and cin);
   z(0) <= psMatrix(0)(0) xor cin;
   genStage0:
   for i in 1 to (N-1) generate
      psMatrix(0)(i) <= a(i) xor b(i);
      gsMatrix(0)(i) <= a(i) and b(i);
   end generate genStage0;
   
   
   --StagesI
   genStagesI1st:
   for i in 1 to S generate
      genStageI1st:
      for j in 0 to (N-1) generate
         ifgenCopy1st:
         if (j mod (2**i)/=2**i-1) generate
            psMatrix(i)(j) <= psMatrix(i-1)(j);
            gsMatrix(i)(j) <= gsMatrix(i-1)(j);
         end generate ifgenCopy1st;
         ifgenCalculate1st:
         if (j mod (2**i)=2**i-1) generate
            psMatrix(i)(j) <= psMatrix(i-1)(j) and psMatrix(i-1)(j-2**(i-1));
            gsMatrix(i)(j) <= gsMatrix(i-1)(j) or (gsMatrix(i-1)(j-2**(i-1)) and psMatrix(i-1)(j));
         end generate ifgenCalculate1st;
      end generate genStageI1st;
   end generate genStagesI1st;
   
   genStagesI2nd:
   for i in 1 to (S-1) generate
      genStageI2nd:
      for j in 0 to (N-1) generate
         ifgenCopy2nd:
         if (not ((j-2**(S-i)>=0) and ((j-2**(S-i)) mod 2**(S-i) = 2**(S-i-1)-1))) generate
            psMatrix(S+i)(j) <= psMatrix(S+i-1)(j);
            gsMatrix(S+i)(j) <= gsMatrix(S+i-1)(j);
         end generate ifgenCopy2nd;
         ifgenCalculate2nd:
         if ((j-2**(S-i)>=0) and ((j-2**(S-i)) mod 2**(S-i) = 2**(S-i-1)-1)) generate
            psMatrix(S+i)(j) <= psMatrix(S+i-1)(j) and psMatrix(S+i-1)(j-2**(S-i-1));
            gsMatrix(S+i)(j) <= gsMatrix(S+i-1)(j) or (gsMatrix(S+i-1)(j-2**(S-i-1)) and psMatrix(S+i-1)(j));
         end generate ifgenCalculate2nd;
      end generate genStageI2nd;
   end generate genStagesI2nd;
   
   --CopyLastCarrys
   copyLastCarrys:
   for i in 0 to (N-1) generate
      carrys(i) <= gsMatrix(2*S-1)(i);
   end generate copyLastCarrys;
   
   --Output
   cout <= carrys(N-1);
   genOutput:
   for i in 1 to (N-1) generate
      z(i) <= a(i) xor b(i) xor carrys(i-1);
   end generate genOutput;
    
end estr;



