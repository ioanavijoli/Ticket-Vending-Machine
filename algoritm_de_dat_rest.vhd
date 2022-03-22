library IEEE;	  
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all; 
use IEEE.STD_LOGIC_ARITH.all;
entity REST is
	port(clk, reset, enable:in std_logic;
	suma_rest,suma_introdusa:in std_logic_vector(6 downto 0);
	euro1,euro2,euro5,euro10,euro20,euro50:in std_logic_vector(6 downto 0);
	rest_imposibil,stop_rest:out std_logic;
	rest1,rest2,rest5,rest10,rest20,rest50:out std_logic_vector(6 downto 0));			
end entity;

architecture algoritm of REST is 
signal bn1,bn2,bn5,bn10,bn20,bn50:STD_LOGIC_VECTOR(6 downto 0);
signal rest:STD_LOGIC_VECTOR(6 downto 0);
type stare is(st0,st1,st2,st3,st4,st5);
signal st,st_next:stare;
signal init_euro, init_rest: std_logic;	
begin	
	process(clk, reset)
	begin 
		if reset = '1' then st<=st0; 
		else 
		if clk='1' and clk'event then	
			if enable ='1'  then
				st<=st_next;
			end if;	
		end if;
		end if;
	end process; 
	
	process(reset, st, st_next, euro1, euro2, euro5, euro10, euro20, euro50, bn1, bn2, bn5, bn10, bn20, bn50, rest, enable)
	begin
	if(reset = '1')then
			bn1<="0000000";
			bn2<="0000000";
			bn5<="0000000";
			bn10<="0000000";
			bn20<="0000000";
			bn50<="0000000";
			rest<="0000000";
			rest1 <= "0000000";
			rest2 <= "0000000";
			rest5 <= "0000000";
			rest10 <= "0000000";
			rest20 <= "0000000";
			rest50 <= "0000000";
			stop_rest <= '0'; 
			rest_imposibil <= '0';
			init_euro<= '1';
			init_rest<= '1';  
	else
	if enable = '1' then
		if(init_euro = '1') then
			bn1<=euro1;
			bn2<=euro2;
			bn5<=euro5;
			bn10<=euro10;
			bn20<=euro20;
			bn50<=euro50;
			init_euro <= '0';
		end if;
		if (init_rest = '1') then
			rest<=suma_rest; 
			init_rest <= '0';
		end if;
	case st is
		when st0 =>
		if( rest > 49 and bn50 > 0) then
			rest <= rest - 50;
			bn50 <= bn50 -1;
		else
			st_next <= st1;
		end if;
			
		when st1 =>
			if( rest > 19 and bn20 > 0) then
				rest <= rest - 20;
				bn20 <= bn20 -1;
			else
				st_next <= st2;
			end if;
            
		when st2 =>
			if( rest > 9 and bn10 > 0) then
				rest <= rest - 10;
				bn10 <= bn10 -1;
			else
				st_next <= st3;
			end if;
					
		when st3 =>
			if( rest > 4 and bn5 > 0) then
				rest <= rest -5;
				bn5 <= bn5 -1;
			else
				st_next <= st4;
			end if;
					
		when st4 =>
			if( rest > 1 and bn2 > 0) then
				rest <= rest - 2;
				bn2 <= bn2 -1;
			else
				st_next <= st5;
			end if;
				
		when st5 =>
			if( rest > 0 and bn1 > 0) then
				rest <= rest -1;
				bn1 <= bn1 -1;
			else
	
				rest1<= euro1 - bn1;
				rest2<= euro2 - bn2;
				rest5<= euro5 - bn5;
				rest10 <= euro10 - bn10;
				rest20 <= euro20 - bn20;
				rest50 <= euro50 - bn50; 
				st_next <= st5;
				if( rest > 0) then
					rest_imposibil <= '1';
					rest <= suma_introdusa;
					init_euro <= '1';
				else
					rest_imposibil <= '0';
				end if;
			end if;
            stop_rest <= '1';
		end case; 
	end if;	
	end if;
	end process;
end architecture;
	