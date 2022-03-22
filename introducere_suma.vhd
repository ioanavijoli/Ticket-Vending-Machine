library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;  
use IEEE.STD_LOGIC_ARITH.all;
entity introducere_suma is 
	port( clock, reset, exista_bilet: in std_logic;
	en_bn1, en_bn2, en_bn5, en_bn10, en_bn20, en_bn50: in std_logic;
	bn_introduse1, bn_introduse2, bn_introduse5, bn_introduse10, bn_introduse20, bn_introduse50: out std_logic_vector (6 downto 0);
	suma_introdusa: out std_logic_vector (6 downto 0);
	suma_introdusa_unit, suma_introdusa_zeci, suma_introdusa_sute: out std_logic_vector (3 downto 0));
end entity ;
architecture suma of introducere_suma is  
signal bn1, bn2, bn5, bn10, bn20, bn50: std_logic_vector (6 downto 0);
signal s1, s2, s5, s10, s20, s50: integer;
signal suma_i: integer;
signal unit, zeci, sute: integer;
component numarator_bancnote 
	port (enable: in std_logic;	
 	 	  clk: in  std_logic;
	  	  reset: in std_logic;
 		  nr_bn: out std_logic_vector(6 downto 0));
	  
end component;
begin  
	C1: numarator_bancnote port map ( enable => en_bn1, clk => clock, reset => reset, nr_bn => bn1);
	C2: numarator_bancnote port map ( enable => en_bn2, clk => clock, reset => reset, nr_bn => bn2); 
	C3: numarator_bancnote port map ( enable => en_bn5, clk => clock, reset => reset, nr_bn => bn5);
	C4: numarator_bancnote port map ( enable => en_bn10, clk => clock, reset => reset, nr_bn => bn10);
	C5: numarator_bancnote port map ( enable => en_bn20, clk => clock, reset => reset, nr_bn => bn20); 
	C6: numarator_bancnote port map ( enable => en_bn50, clk => clock, reset => reset, nr_bn => bn50); 
	process(clock, exista_bilet, bn1, bn2, bn5, bn10, bn20, bn50, s1, s2, s5, s10, s20, s50, reset, suma_i)
	begin
	if clock = '1' and clock' event then
		if reset = '0' then
		if exista_bilet = '1' then 
			s1 <= conv_integer(bn1);
			s2 <= 2*conv_integer(bn2);
			s5 <= 5*conv_integer(bn5);
			s10 <= 10*conv_integer(bn10);
			s20 <= 20*conv_integer(bn20);
			s50 <= 50*conv_integer(bn50);
			suma_i <= s1 + s2 + s5 + s10 + s20 +s50;
			unit <= suma_i mod 10;
			zeci <= (suma_i/10) mod 10;
			sute <= suma_i/100;
		end if;
		end if;
		end if;
	end process;  
	bn_introduse1 <= bn1 when exista_bilet = '1' and clock = '1' and clock' event;
	bn_introduse2 <= bn2 when exista_bilet = '1' and clock = '1' and clock' event;
	bn_introduse5 <= bn5  when exista_bilet = '1' and clock = '1' and clock' event;
	bn_introduse10 <= bn10 when exista_bilet = '1' and clock = '1' and clock' event;
	bn_introduse20 <= bn20 when exista_bilet = '1' and clock = '1' and clock' event;
	bn_introduse50 <= bn50 when exista_bilet = '1' and clock = '1' and clock' event;
	suma_introdusa <= conv_std_logic_vector(suma_i, 7) when exista_bilet = '1' and clock = '1' and clock' event;
	suma_introdusa_unit <=  conv_std_logic_vector(unit, 4) when exista_bilet = '1' and clock = '1' and clock' event;
	suma_introdusa_zeci <=  conv_std_logic_vector(zeci, 4) when exista_bilet = '1' and clock = '1' and clock' event;
	suma_introdusa_sute <= conv_std_logic_vector(sute,4) when exista_bilet = '1' and clock = '1' and clock' event;
	
end architecture ;

	
			
		