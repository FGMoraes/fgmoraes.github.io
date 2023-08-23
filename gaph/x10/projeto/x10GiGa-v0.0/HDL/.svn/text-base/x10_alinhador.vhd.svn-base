--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Comparador Full
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_unsigned.all;

entity comparadorfull is
port(
	fullmatch : out  std_logic;
	entrada   : in 	 std_logic_vector(47 downto 0) 
    );		        
end comparadorfull;

architecture comparadorfull of comparadorfull is

	signal compara   : std_logic;
	signal deslocado : std_logic_vector(47 downto 0);
	signal comp 	 : std_logic_vector(2 downto 0);
	signal p0,p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11 : std_logic;
begin
	deslocado <= entrada;
	
 	-- F
	p0 <=  (deslocado(47) and 
		deslocado(46) and 
		deslocado(45) and 
		deslocado(44));
     	-- 6
	p1 <=  ((not deslocado(43)) and 
		deslocado(42) and 
		deslocado(41) and 
		(not deslocado(40)));
	-- F
	p2 <=  (deslocado(39) and 
		deslocado(38) and 
		deslocado(37) and 
		deslocado(36));
    -- 6
	p3 <=  ((not deslocado(35)) and
		deslocado(34) and
		deslocado(33) and
		(not deslocado(32)));
	-- F
	p4 <=  (deslocado(31) and
		deslocado(30) and 
		deslocado(29) and 
		deslocado(28));
	-- 6
	p5 <=  ((not deslocado(27)) and
		deslocado(26) and 
		deslocado(25) and 
		(not deslocado(24)));        
	-- 2
	p6 <=  ((not deslocado(23)) and 
		(not deslocado(22)) and 
		deslocado(21) and 
		(not deslocado(20)));
	-- 8
	p7 <=  (deslocado(19) and 
		(not deslocado(18)) and 
		(not deslocado(17)) and
		(not deslocado(16)));
 	-- 2
	p8 <=  ((not deslocado(15)) and
		(not deslocado(14)) and
		deslocado(13) and
		(not deslocado(12)));
 	-- 8
	p9 <=  (deslocado(11) and
		(not deslocado(10)) and
		(not deslocado(9))  and
		(not deslocado(8)));
 	-- 2
	p10 <= ((not deslocado(7))  and
		(not deslocado(6))  and
		deslocado(5)  and
		(not deslocado(4)));
 	-- 8
	p11 <= (deslocado(3)  and
		(not deslocado(2))  and
		(not deslocado(1))  and
		(not deslocado(0)));         
  
	comp(0) <= (p0 and p1 and p2 and p3); 
	comp(1) <= (comp(0) and p4 and p5 and p6);
	comp(2) <= (comp(1) and p7 and p8 and p9);  
	compara <= (comp(2) and p10 and p11);

	fullmatch <= compara;

end comparadorfull;
 
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Comparadores parciais
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_unsigned.all;


entity comparador is
port(	controle : out std_logic_vector(63 downto 0) ;
		atual    : in  std_logic_vector(63 downto 0) ;
		futuro   : in  std_logic_vector(30 downto 0)
    );         
end comparador;

architecture comparador of comparador is

	signal p0,p1,p2,p3,p4,p5: std_logic_vector(63 downto 0);
	signal comp    			: std_logic_vector(63 downto 0);
	signal compara 			: std_logic_vector(63 downto 0);
	signal atualefuturo 	: std_logic_vector(94 downto 0);

begin

	atualefuturo <= atual & futuro(30 downto 0);

	add:for i in 0 to 63 generate    
	begin

		p0(i) <=(atualefuturo(94-i) and 
			 atualefuturo(93-i) and
			 atualefuturo(92-i) and			-- F
			 atualefuturo(91-i));

		p1(i) <=((not atualefuturo(90-i)) and 
			 atualefuturo(89-i) and
			 atualefuturo(88-i) and			-- 6
			 (not atualefuturo(87-i)));

		p2(i) <=(atualefuturo(78-i) and 
			 atualefuturo(77-i) and
			 atualefuturo(76-i) and			-- F
			 atualefuturo(75-i));

		p3(i) <=((not atualefuturo(74-i)) and 
			 atualefuturo(73-i) and
			 atualefuturo(72-i) and			-- 6
			 (not atualefuturo(71-i)));

		p4(i) <=((not atualefuturo(70-i)) and 
			 (not atualefuturo(69-i)) and
			 atualefuturo(68-i) and			-- 2
			 (not atualefuturo(67-i)));

		p5(i) <=(atualefuturo(66-i) and 
			 (not atualefuturo(65-i)) and
			 (not atualefuturo(64-i)) and	-- 8
			 (not atualefuturo(63-i)));

		comp(i)    <=  (p0(i) and p1(i) and p2(i) and p3(i));
		compara(i) <=  (comp(i) and p4(i) and p5(i));

	end generate;

	controle <= compara;

end comparador;

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Gerador de Endereco
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_unsigned.all;

entity enderecador is
port(
	entrada    : in  std_logic_vector(63 downto 0) ;
	enderecout : out std_logic_vector(5  downto 0) ;
	matchout   : out std_logic
    );         
end enderecador;

architecture enderecador of enderecador is

	signal parcial0 : std_logic_vector(7 downto 0);
	signal parcial1 : std_logic_vector(7 downto 0);
	signal parcial2 : std_logic_vector(7 downto 0);
	signal parcial3 : std_logic_vector(7 downto 0);
	signal parcial4 : std_logic_vector(7 downto 0);
	signal parcial5 : std_logic_vector(7 downto 0);
	
	signal controle : std_logic_vector(63 downto 0);
	signal endereco : std_logic_vector(5  downto 0);
	signal match 	: std_logic;
	
begin
	controle <= entrada;
	matchout <= match;
	enderecout <= endereco;
	
	parcial0(0) <= (controle(32) or controle(33) or controle(34) or controle(35));
	parcial0(1) <= (controle(36) or controle(37) or controle(38) or controle(39));
	parcial0(2) <= (controle(40) or controle(41) or controle(42) or controle(43));
	parcial0(3) <= (controle(44) or controle(45) or controle(46) or controle(47));
	parcial0(4) <= (controle(48) or controle(49) or controle(50) or controle(51));
	parcial0(5) <= (controle(52) or controle(53) or controle(54) or controle(55));
	parcial0(6) <= (controle(56) or controle(57) or controle(58) or controle(59));
	parcial0(7) <= (controle(60) or controle(61) or controle(62) or controle(63));

	endereco(5) <= parcial0(0) or parcial0(1) or parcial0(2) or parcial0(3) or  
		       parcial0(4) or parcial0(5) or parcial0(6) or parcial0(7); 

	parcial1(0) <= (controle(16) or controle(17) or controle(18) or controle(19));
	parcial1(1) <= (controle(20) or controle(21) or controle(22) or controle(23));
	parcial1(2) <= (controle(24) or controle(25) or controle(26) or controle(27));
	parcial1(3) <= (controle(28) or controle(29) or controle(30) or controle(31));
	parcial1(4) <= (controle(48) or controle(49) or controle(50) or controle(51));
	parcial1(5) <= (controle(52) or controle(53) or controle(54) or controle(55));
	parcial1(6) <= (controle(56) or controle(57) or controle(58) or controle(59));
	parcial1(7) <= (controle(60) or controle(61) or controle(62) or controle(63));   

	endereco(4) <= parcial1(0) or parcial1(1) or parcial1(2) or parcial1(3) or  
		       parcial1(4) or parcial1(5) or parcial1(6) or parcial1(7);      

	parcial2(0) <= (controle(8)  or controle(9)  or controle(10) or controle(11));
	parcial2(1) <= (controle(12) or controle(13) or controle(14) or controle(15));
	parcial2(2) <= (controle(24) or controle(25) or controle(26) or controle(27));
	parcial2(3) <= (controle(28) or controle(29) or controle(30) or controle(31));
	parcial2(4) <= (controle(40) or controle(41) or controle(42) or controle(43));
	parcial2(5) <= (controle(44) or controle(45) or controle(46) or controle(47));
	parcial2(6) <= (controle(56) or controle(57) or controle(58) or controle(59));
	parcial2(7) <= (controle(60) or controle(61) or controle(62) or controle(63));

	endereco(3) <= parcial2(0) or parcial2(1) or parcial2(2) or parcial2(3) or  
		       parcial2(4) or parcial2(5) or parcial2(6) or parcial2(7);             

	parcial3(0) <= (controle(4)  or controle(5)  or controle(6)  or controle(7));
	parcial3(1) <= (controle(12) or controle(13) or controle(14) or controle(15));
	parcial3(2) <= (controle(20) or controle(21) or controle(22) or controle(23));
	parcial3(3) <= (controle(28) or controle(29) or controle(30) or controle(31));
	parcial3(4) <= (controle(36) or controle(37) or controle(38) or controle(39));
	parcial3(5) <= (controle(44) or controle(45) or controle(46) or controle(47));
	parcial3(6) <= (controle(52) or controle(53) or controle(54) or controle(55));
	parcial3(7) <= (controle(60) or controle(61) or controle(62) or controle(63));              

	endereco(2) <= parcial3(0) or parcial3(1) or parcial3(2) or parcial3(3) or  
		       parcial3(4) or parcial3(5) or parcial3(6) or parcial3(7);  

	parcial4(0) <= (controle(2)  or controle(3)  or controle(6)  or controle(7));
	parcial4(1) <= (controle(10) or controle(11) or controle(14) or controle(15));
	parcial4(2) <= (controle(18) or controle(19) or controle(22) or controle(23));
	parcial4(3) <= (controle(26) or controle(27) or controle(30) or controle(31));
	parcial4(4) <= (controle(34) or controle(35) or controle(38) or controle(39));
	parcial4(5) <= (controle(42) or controle(43) or controle(46) or controle(47));
	parcial4(6) <= (controle(50) or controle(51) or controle(54) or controle(55));
	parcial4(7) <= (controle(58) or controle(59) or controle(62) or controle(63));

	endereco(1) <= parcial4(0) or parcial4(1) or parcial4(2) or parcial4(3) or  
		       parcial4(4) or parcial4(5) or parcial4(6) or parcial4(7);                

	parcial5(0) <= (controle(1)  or controle(3)  or controle(5)  or controle(7));
	parcial5(1) <= (controle(9)  or controle(11) or controle(13) or controle(15));        
	parcial5(2) <= (controle(17) or controle(19) or controle(21) or controle(23));
	parcial5(3) <= (controle(25) or controle(27) or controle(29) or controle(31));
	parcial5(4) <= (controle(33) or controle(35) or controle(37) or controle(39));
	parcial5(5) <= (controle(41) or controle(43) or controle(45) or controle(47));
	parcial5(6) <= (controle(49) or controle(51) or controle(53) or controle(55));  
	parcial5(7) <= (controle(57) or controle(59) or controle(61) or controle(63));

	endereco(0) <= parcial5(0) or parcial5(1) or parcial5(2) or parcial5(3) or  
		       parcial5(4) or parcial5(5) or parcial5(6) or parcial5(7);
		       
	match <=(controle(0)  or controle(1)  or controle(2)  or controle(3)  or controle(4)  or
		 controle(5)  or controle(6)  or controle(7)  or controle(8)  or controle(9)  or
		 controle(10) or controle(11) or controle(12) or controle(13) or controle(14) or
		 controle(15) or controle(16) or controle(17) or controle(18) or controle(19) or
		 controle(20) or controle(21) or controle(22) or controle(23) or controle(24) or
		 controle(25) or controle(26) or controle(27) or controle(28) or controle(29) or
		 controle(30) or controle(31) or controle(32) or controle(33) or controle(34) or
		 controle(35) or controle(36) or controle(37) or controle(38) or controle(39) or
		 controle(40) or controle(41) or controle(42) or controle(43) or controle(44) or
		 controle(45) or controle(46) or controle(47) or controle(48) or controle(49) or
		 controle(50) or controle(51) or controle(52) or controle(53) or controle(54) or
		 controle(55) or controle(56) or controle(57) or controle(58) or controle(59) or
		 controle(60) or controle(61) or controle(62) or controle(63));
               
end enderecador;

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Deslocador  1
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_unsigned.all;

entity deslocador1 is port (		  	
	clk, rst	: in  std_logic ;						-- Clock e Reset	
	endereco	: in  std_logic_vector(5 downto 0)  ;	-- Sinal de controle (address)	
	enderecout	: out std_logic_vector(5 downto 0)  ;	-- Sinal de controle (address)	
	regdata		: in  std_logic_vector(63 downto 0) ;	-- Palavra atual	
	data     	: in  std_logic_vector(63 downto 1) ;	-- Palavra futura (Pior caso usa 63 bits)
	word1	 	: out std_logic_vector(63 downto 0) ;	-- Palavra alinhada	
	word11		: out std_logic_vector(14 downto 0)) ;
end deslocador1;			

architecture deslocador1 of deslocador1 is

	signal controle	: std_logic_vector(5 downto 0)  ;	

	signal estagio5, estagio4 : std_logic_vector (63 downto 0) ;

	signal estagio55: std_logic_vector (30 downto 0) ;
	signal estagio44: std_logic_vector (14 downto 0) ;
	
begin		

	process (clk,rst)
	begin
		if rst = '0' then
			word1 <= (others=>'0');
		elsif clk'event and clk = '1' then
			word1 		<= estagio4 ;
			word11		<= estagio44;
			enderecout	<= controle;
		end if;
	end process;
	
	controle   <= endereco;
	
	-- Desloca 32
	D32 : for i in 63 downto 32 generate
		estagio5(i) <=  regdata(i) when controle(5)='0'  else  regdata(i-32);
	end generate ;
	E32 : for i in 31 downto 0 generate
		estagio5(i) <=  regdata(i) when controle(5)='0'  else  data(i+32); 
	end generate ;
	F32 : for i in 31 downto 1 generate
		estagio55(i-1) <=  data(i+32)  when controle(5)='0'  else  data(i);
	end generate ;

	-- Desloca 16
	D16 : for i in 63 downto 16 generate
		estagio4(i) <=  estagio5(i) when controle(4)='0'  else  estagio5(i-16);
	end generate ;
	E16 : for i in 15 downto 0 generate
		estagio4(i) <=  estagio5(i) when controle(4)='0'  else  estagio55(i+15);
	end generate ;
	F16 : for i in 15 downto 1 generate
		estagio44(i-1) <=  estagio55(i+15) when controle(4)='0'  else  estagio55(i-1);
	end generate ;

end deslocador1;

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Deslocador  2
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_unsigned.all;

entity deslocador2 is port (		  	
	clk, rst	: in  std_logic ;						-- Clock e Reset	
	endereco	: in  std_logic_vector(5 downto 0)  ;	-- Sinal de controle (address)	
	enderecout	: out std_logic_vector(5 downto 0)  ;	-- Sinal de controle (address)	
	data1     	: in  std_logic_vector(63 downto 0) ;	-- Palavra futura (Pior caso usa 63 bits)
	data11		: in  std_logic_vector(14 downto 0) ;
	word2	 	: out std_logic_vector(63 downto 0) ;	-- Palavra alinhada	
	word22		: out std_logic_vector(2  downto 0)) ;
end deslocador2;			

architecture deslocador2 of deslocador2 is

	signal controle	: std_logic_vector(5 downto 0)  ;	

	signal estagio4, estagio3, estagio2 : std_logic_vector (63 downto 0) ;

	signal estagio44: std_logic_vector (14 downto 0) ;
	signal estagio33: std_logic_vector (6  downto 0) ;
	signal estagio22: std_logic_vector (2  downto 0) ;

begin	
	estagio4   <= data1;
	estagio44  <= data11;
	
	process (clk,rst)
	begin
		if rst = '0' then
			word2 <= (others=>'0');
		elsif clk'event and clk = '1' then
			word2 	   <= estagio2 ;
			word22	   <= estagio22;
			enderecout <= controle;
		end if;
	end process;
	
	controle <= endereco;
	
	-- Desloca 8
	D8 : for i in 63 downto 8 generate
		estagio3(i) <=  estagio4(i) when controle(3)='0'  else  estagio4(i-8);
	end generate ;
	E8 : for i in 7 downto 0 generate
		estagio3(i) <=  estagio4(i) when controle(3)='0'  else  estagio44(i+7);
	end generate ;
	F8 : for i in 7 downto 1 generate
		estagio33(i-1) <= estagio44(i+7) when controle(3)='0' else estagio44(i-1);
	end generate ;

	-- Desloca 4
	D4 : for i in 63 downto 4 generate
		estagio2(i) <= estagio3(i)  when controle(2)='0'  else  estagio3(i-4);
	end generate ;
	E4 : for i in 3 downto 0 generate
		estagio2(i) <=  estagio3(i) when controle(2)='0'  else  estagio33(i+3);
	end generate ;
	F4 : for i in 3 downto 1 generate
		estagio22(i-1) <=  estagio33(i+3) when controle(2)='0'  else  estagio33(i-1);
	end generate ;

end deslocador2;

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Deslocador  3
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_unsigned.all;

entity deslocador3 is port (		  	
	clk, rst	: in  std_logic ;						-- Clock e Reset	
	endereco	: in  std_logic_vector(5 downto 0)  ;	-- Sinal de controle (address)	
	data2     	: in  std_logic_vector(63 downto 0) ;	-- Palavra futura (Pior caso usa 63 bits)
	data22		: in  std_logic_vector(2  downto 0) ;
	word3	 	: out std_logic_vector(63 downto 0)) ;	-- Palavra alinhada
end deslocador3;			

architecture deslocador3 of deslocador3 is

	signal controle	: std_logic_vector(5 downto 0)  ;	

	signal estagio2, estagio1, estagio0 : std_logic_vector (63 downto 0) ;

	signal estagio22: std_logic_vector (2  downto 0) ;
	signal estagio11: std_logic ;

begin	

	estagio2  <= data2;
	estagio22 <= data22;

	process (clk,rst)
	begin
		if rst = '0' then
			word3 <= (others=>'0');
		elsif clk'event and clk = '1' then
			word3 <= estagio0 ;
		end if;
	end process;
	
	controle <= endereco;
	
	-- Desloca 2
	D2 : for i in 63 downto 2 generate
		estagio1(i) <=  estagio2(i) when controle(1)='0'  else  estagio2(i-2);
	end generate ;
	E2 : for i in 1 downto 0 generate
		estagio1(i) <=  estagio2(i) when controle(1)='0'  else  estagio22(i+1);
	end generate ;

	estagio11 <= estagio22(2) when controle(1)='0'  else  estagio22(0);

	-- Desloca 1
	D1 : for i in 63 downto 1 generate
		estagio0(i)  <=  estagio1(i)  when controle(0)='0'  else  estagio1(i-1);
	end generate ;
	estagio0(0) <=  estagio1(0) when controle(0)='0'  else  estagio11;

end deslocador3;