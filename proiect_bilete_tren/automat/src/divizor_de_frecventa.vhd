library IEEE;	  
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all; 
use ieee.numeric_std.all;
entity divizor_de_frecventa is
	port(CLK: in std_logic ;
	clk_div: out std_logic);
end entity ;
architecture comportamentala of divizor_de_frecventa is
begin
	process(CLK)
	variable count: std_logic_vector (15 downto 0):=(others =>'0');	  
	begin 
		if CLK' event and CLK='1' then
			count := count +1;
		end if;
		clk_div <= count(15);
	end process; 
end architecture ;
	
		
			
	