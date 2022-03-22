library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity verifica_bilet is 
	port ( enable: in std_logic;  
	distanta_mii, distanta_sute, distanta_zeci: in std_logic_vector (3 downto 0) ;
	exista_bilet: out std_logic);
end entity ;
architecture comportamentala of verifica_bilet is
begin
	process( enable, distanta_mii, distanta_sute, distanta_zeci)
	begin
		if enable = '0' then null;
		else
			if distanta_mii = "0000" then exista_bilet <= '1';
			else
				if distanta_mii = "0001" then
					if distanta_sute = "0000" and distanta_zeci = "0000" then exista_bilet <= '1';
					else
						exista_bilet <= '0';
					end if;
				else
					exista_bilet <= '0';
				end if;
			end if;
		end if;	
	end process;
end architecture ;
		
			
				
					
						
	