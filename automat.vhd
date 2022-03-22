library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;

entity automat is port( clock, reset, confirm: in std_logic;
	en_mii, en_sute, en_zeci, en_bn1, en_bn2, en_bn5, en_bn10, en_bn20, en_bn50: in std_logic;
	LD_lipsa_bilet, LD_suma_insuficienta, LD_rest_imposibil, LD_restituie_suma: out std_logic;
	anod: out std_logic_vector (3 downto 0);
	catod: out std_logic_vector (6 downto 0));
end entity ;

architecture cod of automat is
component distanta_introdusa 
	  port(CLOCK, reset, enable_mii, enable_sute, enable_zeci: in std_logic;
	distanta_mii, distanta_sute, distanta_zeci: out std_logic_vector (3 downto 0));
end component ;	
component debounce  
	port( sw: in std_logic;
	clk: in std_logic;
	reset: in std_logic;
	sw_db: out std_logic);
end component ;
component afisare 
	 port(clock: in std_logic;
	data0, data1, data2, data3: in std_logic_vector (3 downto 0);	
	anod: out std_logic_vector (3 downto 0);
	catod: out std_logic_vector (6 downto 0));
end component ;	 
component verifica_bilet  
	port ( enable: in std_logic;  
	distanta_mii, distanta_sute, distanta_zeci: in std_logic_vector (3 downto 0) ;
	exista_bilet: out std_logic);
end component ;
component cost 
	port( enable: in std_logic;
	distanta_mii, distanta_sute, distanta_zeci: in std_logic_vector (3 downto 0) ;
	cost_bilet_unit, cost_bilet_zeci, cost_bilet_sute: out std_logic_vector (3 downto 0);
	cost_bilet: out  std_logic_vector (6 downto 0));
end component ;
component introducere_suma  
	port( clock, reset, exista_bilet: in std_logic;
	en_bn1, en_bn2, en_bn5, en_bn10, en_bn20, en_bn50: in std_logic;
	bn_introduse1, bn_introduse2, bn_introduse5, bn_introduse10, bn_introduse20, bn_introduse50: out std_logic_vector (6 downto 0);
	suma_introdusa: out std_logic_vector (6 downto 0);
	suma_introdusa_unit, suma_introdusa_zeci, suma_introdusa_sute: out std_logic_vector (3 downto 0));
end component ;	
component verificare_suma 
	port( enable: in std_logic;
	suma_introdusa, cost_bilet: in std_logic_vector (6 downto 0);
	enable_rest, suma_suficienta: out std_logic;
	suma_rest: out std_logic_vector (6 downto 0));
end component ;
component etapa_afisare 
port ( enable: in std_logic;	
 	  clk: in  std_logic;
	  reset: in std_logic;
 	  etapa_curenta: out std_logic_vector(1 downto 0));	  
end component; 
component casa_bani 
	port( reset, clk: in std_logic;
	en_suma_introdusa, en_da_rest: in std_logic;
	rest1,rest2,rest5,rest10,rest20,rest50: in std_logic_vector (6 downto 0);
	bn1, bn2, bn5, bn10, bn20, bn50: in std_logic_vector (6 downto 0);
	euro1, euro2, euro5, euro10, euro20, euro50: inout std_logic_vector (6 downto 0));  
end component;
component REST 
	port(clk, reset, enable:in std_logic;
	suma_rest,suma_introdusa:in std_logic_vector(6 downto 0);
	euro1,euro2,euro5,euro10,euro20,euro50:in std_logic_vector(6 downto 0);
	rest_imposibil,stop_rest:out std_logic;
	rest1,rest2,rest5,rest10,rest20,rest50:out std_logic_vector(6 downto 0));			
end component; 
component afisare_rest 
	port (enable, clock, reset: in std_logic;
	suma_rest: in std_logic_vector (6 downto 0);
	r1, r2, r5, r10, r20, r50: in std_logic_vector (6 downto 0);
	digit0, digit1, digit2: out std_logic_vector (3 downto 0));
end component; 

signal mii, sute,zeci: std_logic_vector(3 downto 0); 
signal mii_db, sute_db, zeci_db: std_logic;
signal confirm_dist, confirm_suma, e_bilet, en_calcul_cost, intr_suma: std_logic;
signal cost_u, cost_z, cost_s, suma_u, suma_z, suma_s: std_logic_vector (3 downto 0) := "0000";
signal cost_b: std_logic_vector (6 downto 0);
signal b1, b2, b5, b10, b20, b50, suma:  std_logic_vector (6 downto 0);	 
signal r1, r2, r5, r10, r20, r50:  std_logic_vector (6 downto 0);
signal e1, e2, e5, e10, e20, e50:  std_logic_vector (6 downto 0);
signal cifra0, cifra1, cifra2, cifra3, rest_s, rest_z, rest_u: std_logic_vector (3 downto 0);  
signal etapa: std_logic_vector(1 downto 0):="00";
signal en_rest, en_alg_rest, suma_suficienta, en_afisare_rest: std_logic := '0'; 
signal sum_rest: std_logic_vector (6 downto 0);	 
signal rest_gata, rest_imposibil, init_rest: std_logic:='0'; 
signal db_en_bn1, db_en_bn2, db_en_bn5, db_en_bn10, db_en_bn20, db_en_bn50: std_logic;

begin 
	
	process(clock)									
	begin
		if (clock = '1' and clock'event) then
			case etapa is
				when "00" =>
				cifra0 <= "0000";
				cifra1 <= zeci;
				cifra2 <= sute;
				cifra3 <= mii;
				when "01" => 
				cifra0 <= cost_u;
				cifra1 <= cost_z;
				cifra2 <= cost_s;
				cifra3 <= "0000";
				when "10" => 
				cifra0 <= suma_u;
				cifra1 <= suma_z ;
				cifra2 <= suma_s ;
				cifra3 <= "0000"; 
				when others => 	
	            cifra0 <= rest_u;
				cifra1 <= rest_z ;
				cifra2 <= rest_s;
				cifra3 <= "0000";
			end case;
		end if;
	end process; 
	
	LD_suma_insuficienta <= not suma_suficienta and intr_suma;
	LD_rest_imposibil <= rest_imposibil;
	LD_restituie_suma <= (reset and confirm_suma) or rest_imposibil;  
	LD_lipsa_bilet <= not e_bilet and (etapa(0) or etapa(1));  
	
	confirm_dist <= etapa(0) and not etapa(1); -- confirm_dist = '1' daca etapa = "01"
	en_calcul_cost <= confirm_dist and e_bilet; 
	intr_suma <= not etapa (0) and etapa(1)	and e_bilet ;
	confirm_suma <= etapa (0) and etapa(1)	and e_bilet ;
	en_alg_rest <= confirm_suma and en_rest when clock= '1' and clock' event;  	 --pentru ca sa apuce sa puna in banca
	init_rest <= not en_alg_rest;
	
	DEBOUNCER: debounce port map (sw=>en_bn1, clk => clock, reset => reset, sw_db => db_en_bn1);  
	DEBOUNCER1: debounce port map (sw=>en_bn2, clk => clock, reset => reset, sw_db => db_en_bn2); 
	DEBOUNCER2: debounce port map (sw=>en_bn5, clk => clock, reset => reset, sw_db => db_en_bn5); 
	DEBOUNCER3: debounce port map (sw=>en_bn10, clk => clock, reset => reset, sw_db => db_en_bn10); 
	DEBOUNCER4: debounce port map (sw=>en_bn20, clk => clock, reset => reset, sw_db => db_en_bn20); 
	DEBOUNCER5: debounce port map (sw=>en_bn50, clk => clock, reset => reset, sw_db => db_en_bn50); 
	
	ETAPA_DIN_AFISARE: etapa_afisare port map (enable => confirm, clk => clock, reset => reset, etapa_curenta => etapa); 
	
	DISTANTA: distanta_introdusa port map (CLOCK => clock, reset =>reset, enable_mii =>en_mii, enable_sute => en_sute, enable_zeci => en_zeci,
	distanta_mii => mii, distanta_sute =>sute, distanta_zeci => zeci); 
	
	VERIFICARE_BILET: verifica_bilet port map (enable => confirm_dist, distanta_mii => mii, distanta_sute =>sute, distanta_zeci => zeci, exista_bilet => e_bilet);
	
	COST_BILET: cost port map (enable => en_calcul_cost, distanta_mii => mii, distanta_sute => sute, distanta_zeci => zeci, cost_bilet_unit => cost_u, cost_bilet_zeci => cost_z, cost_bilet_sute => cost_s, 
	cost_bilet => cost_b);
	
	SUMA_INTRODUSA: introducere_suma port map ( clock, reset, intr_suma, db_en_bn1, db_en_bn2, db_en_bn5, db_en_bn10, db_en_bn20, db_en_bn50, b1, b2, b5, b10, b20, b50, suma, suma_u, suma_z, suma_s);
	
	VERIFICARE_SUMA_INTRODUSA: verificare_suma	port map (enable => intr_suma, suma_introdusa => suma, cost_bilet => cost_b, enable_rest=>en_rest, suma_suficienta=>suma_suficienta, suma_rest => sum_rest);
	
	ALGORITM_DE_DAT_REST: REST port map ( clk=>clock, reset=>init_rest, enable=>en_alg_rest, suma_rest=>sum_rest, suma_introdusa=>suma, euro1 =>e1,euro2=>e2, euro5=>e5,euro10=>e10,
	euro20=>e20, euro50=>e50, rest_imposibil=>rest_imposibil, stop_rest=>rest_gata, rest1=>r1, rest2=>r2, rest5=>r5, rest10=>r10, rest20=>r20, rest50=>r50);  
	
	CASA_DE_BANI: casa_bani port map (reset, clock, confirm_suma, rest_gata, r1, r2, r5, r10, r20, r50, b1, b2, b5, b10, b20, b50, e1, e2, e5, e10, e20, e50);
	
	AFISAREA_RESTULUI: afisare_rest port map ( enable => rest_gata, clock => clock, reset => reset, suma_rest => sum_rest, r1=>r1, r2=> r2, r5=>r5, r10=>r10, r20=>r20, r50=>r50, digit0=> rest_u, digit1=>rest_z, digit2=>rest_s);   
	
	AFISARE_PE_PLACA: afisare port map (clock => clock, data0 => cifra0, data1 => cifra1, data2 => cifra2, data3 => cifra3, anod => anod, catod => catod);
end architecture ;