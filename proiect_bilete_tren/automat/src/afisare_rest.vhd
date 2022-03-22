library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;

entity afisare_rest is
	port (enable, clock, reset: in std_logic;
	suma_rest: in std_logic_vector (6 downto 0);
	r1, r2, r5, r10, r20, r50: in std_logic_vector (6 downto 0);
	digit0, digit1, digit2: out std_logic_vector (3 downto 0));
end entity ;

architecture arhitectura of afisare_rest is

component pregatire_numar
	port ( number: in std_logic_vector (6 downto 0);
	nr_unit, nr_zeci, nr_sute: out std_logic_vector (3 downto 0));
end component; 

signal one_second_counter: STD_LOGIC_VECTOR (27 downto 0);
signal one_second_enable: std_logic;
signal displayed_number: STD_LOGIC_VECTOR (6 downto 0); 
signal count: std_logic_vector (3 downto 0):="0000";
begin 
process(clock, reset, enable)
begin
		if(reset='1' or enable = '0') then
            one_second_counter <= (others => '0');
        elsif(clock = '1' and clock' event) then
            if(one_second_counter>=x"5F5E0FF") then
                one_second_counter <= (others => '0');
            else 
				if enable = '1' then
                one_second_counter <= one_second_counter + "0000001" ;	 
				end if;
            end if;
        end if;	
end process;
one_second_enable <= '1' when one_second_counter=x"5F5E0FF" else '0';
process(clock, reset, enable)
begin
        if(reset='1' or enable = '0') then
            count <= (others => '0');
        elsif(clock = '1' and clock' event) then
             if(one_second_enable='1') then
               count <= count + "0001";
             end if;
        end if;
end process;
process(clock)
begin 
	if clock = '1' and clock' event	  then	  
	if enable = '1' then
	case count is
		when "0000" => displayed_number <= suma_rest;
		when "0001" => displayed_number <= "0000001";
		when "0010" => displayed_number <= r1;
		when "0011" => displayed_number <= "0000010";
		when "0100" => displayed_number <= r2; 
		when "0101" => displayed_number <= "0000101";
		when "0110" => displayed_number <= r5;
		when "0111" => displayed_number <= "0001010";
		when "1000" => displayed_number <= r10;
		when "1001" => displayed_number <= "0010100";
		when "1010" => displayed_number <= r20;
		when "1011" => displayed_number <= "0110010";
		when others => displayed_number <= r50;
	end case;
	end if;	
	end if;
end process; 
C1: pregatire_numar port map (number => displayed_number, nr_unit => digit0, nr_zeci => digit1, nr_sute => digit2); 
end architecture ;
	
		
			

			