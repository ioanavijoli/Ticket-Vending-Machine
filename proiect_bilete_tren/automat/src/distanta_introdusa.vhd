library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
entity distanta_introdusa is 
	port(CLOCK, reset, enable_mii, enable_sute, enable_zeci: in std_logic;
	distanta_mii, distanta_sute, distanta_zeci: out std_logic_vector (3 downto 0));
end entity ; 

architecture comportamentala of distanta_introdusa is
component numarator_zecimal   
	port(enable: in std_logic;	
 	 clk: in  std_logic;
	  reset: in std_logic;
 	 bcd: out std_logic_vector(3 downto 0));
end component ;
begin 
	C1: numarator_zecimal port map ( enable => enable_mii, clk => CLOCK, reset => reset, bcd => distanta_mii);
	C2: numarator_zecimal port map ( enable => enable_sute, clk => CLOCK, reset => reset, bcd => distanta_sute); 
	C3: numarator_zecimal port map ( enable => enable_zeci, clk => CLOCK, reset => reset, bcd => distanta_zeci); 
end architecture ;
	