library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;

entity pregatire_numar is
	port ( number: in std_logic_vector (6 downto 0);
	nr_unit, nr_zeci, nr_sute: out std_logic_vector (3 downto 0));
end entity;

architecture comportamentala of pregatire_numar is
signal unit, zeci, sute, nr: integer;
begin
	nr <= conv_integer(number);
	unit <= nr mod 10;
	zeci <= (nr/10) mod 10;
	sute <= nr/100;	 
	nr_unit <= conv_std_logic_vector(unit, 4);
	nr_zeci <= conv_std_logic_vector(zeci, 4);
	nr_sute <= conv_std_logic_vector(sute,4);  
end architecture ;
