library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;

entity casa_bani is
	port( reset, clk: in std_logic;
	en_suma_introdusa, en_da_rest: in std_logic;
	rest1,rest2,rest5,rest10,rest20,rest50: in std_logic_vector (6 downto 0);
	bn1, bn2, bn5, bn10, bn20, bn50: in std_logic_vector (6 downto 0);
	euro1, euro2, euro5, euro10, euro20, euro50: inout std_logic_vector (6 downto 0));  
end entity ;
architecture comportamentala of casa_bani is  
signal init_banca: std_logic := '1';  
signal init_suma, init_rest: std_logic := '0';
begin
	process(clk, reset, en_suma_introdusa, en_da_rest)
	begin
	if clk = '1' and clk' event then
		if(reset = '1') then
			euro1 <= "0110010";
			euro2 <= "0110010";
		    euro5 <= "0110010";
			euro10 <= "0110010";
			euro20 <= "0110010";
			euro50 <= "0110010";   
		else  
			if init_banca = '1' then
			euro1 <= "0110010";
			euro2 <= "0110010";
		    euro5 <= "0110010";
			euro10 <= "0110010";
			euro20 <= "0110010";
			euro50 <= "0110010"; 
			init_banca <= '0';
			end if;
			if (en_suma_introdusa = '1' and init_suma = '0') then
			euro1 <= euro1 + bn1;
			euro2 <= euro2 + bn2;
			euro5 <= euro5 + bn5;
			euro10 <= euro10 + bn10;
			euro20 <= euro20 + bn20;
			euro50 <= euro50 + bn50;  
			init_suma <= '1';
			end if;	
			
			if (en_da_rest = '1' and init_rest = '0') then
			euro1 <= euro1 - rest1;
			euro2 <= euro2 - rest2;
			euro5 <= euro5 - rest5;
			euro10 <= euro10 - rest10;
			euro20 <= euro20 - rest20;
			euro50 <= euro50 - rest50; 
			init_rest <= '1';
			end if;
		end if;
	end if;
	end process;
end architecture ;

			