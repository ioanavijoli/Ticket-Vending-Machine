library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity etapa_afisare is
port ( enable: in std_logic;	
 	  clk: in  std_logic;
	  reset: in std_logic;
 	  etapa_curenta: out std_logic_vector(1 downto 0));	  
end entity;

architecture comportamentala of etapa_afisare is 
signal count:std_logic_vector(1 downto 0):= "00"; 
signal enable_prev: std_logic;
begin	
	process(enable,reset,clk)
	begin
		if( reset ='1') then
			count <= "00";
		else
			if clk='1' and clk'event then 
				if (enable = '1' and enable_prev = '0') then
					if count = "11" then null;
					else
						count<=count+1;
					end if;
				end if;	
				enable_prev <= enable; 
			end if;
		end if;	
		etapa_curenta <= count;
	end process;
end architecture;
