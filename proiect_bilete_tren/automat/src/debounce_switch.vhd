library IEEE;	  
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all; 
use ieee.numeric_std.all;
entity debounce is 
	port( sw: in std_logic;
	clk: in std_logic;
	reset: in std_logic;
	sw_db: out std_logic);
end entity ;
architecture structurala of debounce is
signal q1,q2,q3: std_logic;
begin
	process(reset,clk)
	begin
		if reset = '1' then q1 <= '0'; q2 <= '0'; q3 <= '0';
		else
			if clk='1' and clk' event then 
				q1 <= sw;
				q2 <= q1;
				q3 <= q2; 
			end if;
		end if;
	end process;
	sw_db <= q1 and q2 and q3;
end architecture ;
	
		
			
			