library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;

entity verificare_suma is
	port( enable: in std_logic;
	suma_introdusa, cost_bilet: in std_logic_vector (6 downto 0);
	enable_rest, suma_suficienta: out std_logic;
	suma_rest: out std_logic_vector (6 downto 0));
end entity ;

architecture comportamentala of verificare_suma is
begin
	process( enable, suma_introdusa, cost_bilet)
	begin
	if enable = '1' then
		if suma_introdusa > cost_bilet then
			enable_rest <= '1';
			suma_suficienta <= '1';
			suma_rest <= suma_introdusa - cost_bilet;
		elsif suma_introdusa = cost_bilet then
			enable_rest <= '0';
			suma_suficienta <= '1';
		else
			enable_rest <= '0';
			suma_suficienta <= '0';
		end if;
		end if;
	end process;
end architecture ;
	
		