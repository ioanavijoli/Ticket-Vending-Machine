library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all; 
use IEEE.STD_LOGIC_ARITH.all;
entity afisare is 
	port(clock: in std_logic;
	data0, data1, data2, data3: in std_logic_vector (3 downto 0);	
	anod: out std_logic_vector (3 downto 0);
	catod: out std_logic_vector (6 downto 0));
end entity ;		   

architecture arh of afisare is 
component segment_decoder  
	port(digit: in std_logic_vector (3 downto 0);
	segment: out std_logic_vector (6 downto 0));
end component;
component divizor_de_frecventa 
	port(CLK: in std_logic ;
	clk_div: out std_logic);
end component ;	  

signal display: std_logic_vector (3 downto 0);
signal clk_slow: std_logic;	 
signal cifra: std_logic_vector (3 downto 0);

begin 
	C1: segment_decoder port map (digit => cifra, segment => catod);
	C2: divizor_de_frecventa port map (CLK => clock, clk_div => clk_slow);	
	
	process(clk_slow)
	variable display_selection: std_logic_vector (1 downto 0);
	begin
		if clk_slow'event and clk_slow = '1' then 
			case display_selection is 
				when "00" => cifra <= data0;
				display(0) <= '0';
				display(1) <= '1';
				display(2) <= '1';
				display(3) <= '1';
				display_selection := display_selection + '1'; 
				
				when "01" => cifra <= data1;
				display(0) <= '1';
				display(1) <= '0';
				display(2) <= '1';
				display(3) <= '1';
				display_selection := display_selection + '1'; 
				
				when "10" => cifra <= data2;
				display(0) <= '1';
				display(1) <= '1';
				display(2) <= '0';
				display(3) <= '1';
				display_selection := display_selection + '1'; 
				
				when others => cifra <= data3;
				display(0) <= '1';
				display(1) <= '1';
				display(2) <= '1';
				display(3) <= '0';
				display_selection := display_selection + '1'; 
			end case;
		end if;		
	anod <= display; 
	end process;
end architecture ;
	
		
	
	
	