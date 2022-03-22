library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity numarator_bancnote is
port (
		enable: in std_logic;	
 	 	clk: in  std_logic;
	  	reset: in std_logic;
 		nr_bn: out std_logic_vector(6 downto 0));
	  
end entity;

architecture comportamentala of numarator_bancnote is 
signal count:std_logic_vector(6 downto 0):= "0000000"; 
signal enable_prev: std_logic;
begin	
	process(enable,reset,clk)
	begin
		if( reset ='1') then
			count <= "0000000";
		else
			if clk='1' and clk'event then 
				if (enable = '1' and enable_prev = '0') then
					count<=count+1;
				end if;	
				enable_prev <= enable; 
			end if;
		end if;	
		nr_bn <= count;
	end process;
end architecture;
