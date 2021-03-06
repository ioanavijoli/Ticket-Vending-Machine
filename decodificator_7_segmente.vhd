library IEEE;	  
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all; 
use ieee.numeric_std.all;

entity segment_decoder is 
	port(digit: in std_logic_vector (3 downto 0);
	segment: out std_logic_vector (6 downto 0));
end entity; 
architecture comportamentala of segment_decoder is
begin
	process(digit)
	begin
		case digit is
		when "0000" => segment <= "1000000";
        when "0001" => segment <= "1111001";
        when "0010" => segment <= "0100100";
        when "0011" => segment <= "0110000";
        when "0100" => segment <= "0011001";
		when "0101" => segment <= "0010010";
        when "0110" => segment <= "0000010";
        when "0111" => segment <= "1111000";
        when "1000" => segment <= "0000000";
        when "1001" => segment <= "0010000";
        when "1010" => segment <= "0001000";
        when "1011" => segment <= "0000011";
        when "1100" => segment <= "1000110";
        when "1101" => segment <= "0100001";
        when "1110" => segment <= "0000110";
        when "1111" => segment <= "0001110";
        when others => segment <= "1111111";
		end case;
	end process;
end architecture ;

			
	