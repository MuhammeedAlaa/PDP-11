Library ieee;
use ieee.std_logic_1164.all;

entity ALU is 
GENERIC (n : integer := 16);  
	port(
  	  A, B:  in std_logic_vector (n-1 downto 0);
  	  S:     in std_logic_vector (3 downto 0);
  	  F:     out std_logic_vector (n-1 downto 0);
  	  COUT:  out std_logic);
end entity;

Architecture archALU of ALU is

   component partA is
       GENERIC (n : integer := 16);
       port(
	S1, S0, CIN : in std_logic;
	A, B : in std_logic_vector (n-1 downto 0);
	F : out std_logic_vector (n-1 downto 0);
	COUT : out std_logic);
   end component;
   
   component partB is 
        GENERIC (n : integer := 16);
	port(
       	     S1, S0 : in std_logic;
	     A, B: in std_logic_vector (n-1 downto 0);
	     F : out std_logic_vector (n-1 downto 0));
   end component;

   component partC is 
	GENERIC (n : integer := 16);
	port(
	  S1, S0, CIN : in std_logic;
	  A : in std_logic_vector (n-1 downto 0);
	  F : out std_logic_vector (n-1 downto 0);
	  COUT : out std_logic);
   end component;

   component partD is 
        GENERIC (n : integer := 16);
	port(
	S1, S0, CIN : in std_logic;
	A : in std_logic_vector (n-1 downto 0);
	F : out std_logic_vector (n-1 downto 0);
	COUT : out std_logic);
   end component;
   
   signal FA, FB, FC, FD: std_logic_vector (n-1 downto 0);
   signal coutA, coutC, coutD: std_logic;

begin

	ua: partA generic map(n) port map (S(1), S(0), CIN, A, B, FA, coutA);
	ub: partB generic map(n) port map (S(1), S(0), A, B, FB);
	uc: partC generic map(n) port map (S(1), S(0), CIN, A, FC, coutC);
	ud: partD generic map(n) port map (S(1), S(0), CIN, A, FD, coutD);

	F <= FA when (S(3 downto 2)="00")
	else FB when (S(3 downto 2)="01")
	else FC when (S(3 downto 2)="10")
	else FD when (S(3 downto 2)="11");

	COUT <= coutA when (S(3 downto 2)="00")
	else	coutC when (S(3 downto 2)="10")
	else    coutD when (S(3 downto 2)="11")
	else '0';

end archALU;
