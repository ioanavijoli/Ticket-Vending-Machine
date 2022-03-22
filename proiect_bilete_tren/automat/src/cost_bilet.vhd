library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;

entity cost is
	port( enable: in std_logic;
	distanta_mii, distanta_sute, distanta_zeci: in std_logic_vector (3 downto 0) ;
	cost_bilet_unit, cost_bilet_zeci, cost_bilet_sute: out std_logic_vector (3 downto 0);
	cost_bilet: out  std_logic_vector (6 downto 0));
end entity ;
architecture comportamentala of cost is
signal cost: integer := 0 ;
signal mii, sute, zeci: integer := 0; 
begin 	
	process( enable, distanta_mii, distanta_zeci, distanta_sute, mii, sute, zeci) 
	begin 
		if enable = '0' then null;
		else
		mii <= conv_integer (distanta_mii)*100;
		sute <= conv_integer (distanta_sute)*10; 
		zeci <= conv_integer (distanta_zeci);
		cost <= mii + sute + zeci;
		end if;
	end process;
	cost_bilet_sute <= distanta_mii;
	cost_bilet_zeci <= distanta_sute;
	cost_bilet_unit <= distanta_zeci;
	cost_bilet <= conv_std_logic_vector(cost,7) ;  
end architecture ;
	
		
		
		
		
	
	