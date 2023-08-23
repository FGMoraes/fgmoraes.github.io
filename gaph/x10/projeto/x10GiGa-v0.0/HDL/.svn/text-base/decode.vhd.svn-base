--SYNDROME UNIT
library IEEE;
use IEEE.Std_Logic_1164.all;
use work.fieldTable_pack.all;

entity syndrome_unit is
   port(
      clock: in std_logic;
      reset: in std_logic;
      clear: in std_logic;
      input: in std_logic_vector(int_s-1 downto 0);
      output: out rs_vector
   );
end syndrome_unit;

architecture syndrome_unit of syndrome_unit is

	signal syndrome_regs: rs_vector;
	signal mult_out: rs_vector;

begin

	output <= syndrome_regs;

	process(clock,reset)
	begin
		if reset='0' then
			syndrome_regs <= (others => (others => '0'));
		elsif clock'event and clock='1' then
      
			if clear='1' then
				syndrome_regs <= (others => input);
			else      
				syndrome_regs(0)  <= mult_out(0)  xor input;
				syndrome_regs(1)  <= mult_out(1)  xor input;
				syndrome_regs(2)  <= mult_out(2)  xor input;
				syndrome_regs(3)  <= mult_out(3)  xor input;
				syndrome_regs(4)  <= mult_out(4)  xor input;
				syndrome_regs(5)  <= mult_out(5)  xor input;
				syndrome_regs(6)  <= mult_out(6)  xor input;
				syndrome_regs(7)  <= mult_out(7)  xor input;
				syndrome_regs(8)  <= mult_out(8)  xor input;
				syndrome_regs(9)  <= mult_out(9)  xor input;
				syndrome_regs(10) <= mult_out(10) xor input;
				syndrome_regs(11) <= mult_out(11) xor input;
				syndrome_regs(12) <= mult_out(12) xor input;
				syndrome_regs(13) <= mult_out(13) xor input;
				syndrome_regs(14) <= mult_out(14) xor input;
				syndrome_regs(15) <= mult_out(15) xor input;
			end if;
		end if;
	end process;

	mult_out(0) <= syndrome_regs(0);
	MULT1 : entity work.cell_array_mult port map(input1=>syndrome_regs(1) ,input2=>"00000010",output=>mult_out(1), f=>"00011101"); --36d  -- 225 em gf
	MULT2 : entity work.cell_array_mult port map(input1=>syndrome_regs(2) ,input2=>"00000100",output=>mult_out(2), f=>"00011101"); --50d  -- 194 em gf
	MULT3 : entity work.cell_array_mult port map(input1=>syndrome_regs(3) ,input2=>"00001000",output=>mult_out(3), f=>"00011101"); --98d  -- 182 em gf
	MULT4 : entity work.cell_array_mult port map(input1=>syndrome_regs(4) ,input2=>"00010000",output=>mult_out(4), f=>"00011101"); --229d -- 169 em gf
	MULT5 : entity work.cell_array_mult port map(input1=>syndrome_regs(5) ,input2=>"00100000",output=>mult_out(5), f=>"00011101"); --41d  -- 147 em gf
	MULT6 : entity work.cell_array_mult port map(input1=>syndrome_regs(6) ,input2=>"01000000",output=>mult_out(6), f=>"00011101"); --65d  -- 191 em gf
	MULT7 : entity work.cell_array_mult port map(input1=>syndrome_regs(7) ,input2=>"10000000",output=>mult_out(7), f=>"00011101"); --163d -- 91  em gf
	MULT8 : entity work.cell_array_mult port map(input1=>syndrome_regs(8) ,input2=>"00011101",output=>mult_out(8), f=>"00011101"); --8d   -- 3   em gf
	MULT9 : entity work.cell_array_mult port map(input1=>syndrome_regs(9) ,input2=>"00111010",output=>mult_out(9), f=>"00011101"); --30d  -- 76  em gf
	MULT10: entity work.cell_array_mult port map(input1=>syndrome_regs(10),input2=>"01110100",output=>mult_out(10),f=>"00011101"); --209d -- 161 em gf
	MULT11: entity work.cell_array_mult port map(input1=>syndrome_regs(11),input2=>"11101000",output=>mult_out(11),f=>"00011101"); --68d  -- 102 em gf
	MULT12: entity work.cell_array_mult port map(input1=>syndrome_regs(12),input2=>"11001101",output=>mult_out(12),f=>"00011101"); --189d -- 109 em gf
	MULT13: entity work.cell_array_mult port map(input1=>syndrome_regs(13),input2=>"10000111",output=>mult_out(13),f=>"00011101"); --104d -- 107 em gf
	MULT14: entity work.cell_array_mult port map(input1=>syndrome_regs(14),input2=>"00010011",output=>mult_out(14),f=>"00011101"); --13d  -- 104 em gf
	MULT15: entity work.cell_array_mult port map(input1=>syndrome_regs(15),input2=>"00100110",output=>mult_out(15),f=>"00011101"); --59d  -- 120 em gf

end syndrome_unit;


--BERLEKAMP-MASSEY
library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.Std_Logic_unsigned.all;
use work.fieldTable_pack.all;

entity berlekamp_massey is
   port(
      clock: in std_logic;
      reset: in std_logic;
      clear: in std_logic;
      ready: out std_logic;
      input: in rs_vector;
      lambda: out sy_vector;
      omega: out bm_vector
   );
end berlekamp_massey;

architecture berlekamp_massey of berlekamp_massey is
	
	--armazenamento de síndromes
	signal s_x: rs_vector;
	--bancos de registradores (LFSR)	
	signal s_reg: sy_vector;
	signal c_reg: sy_vector;
	signal b_reg: sy_vector;
	signal v_reg: bm_vector;
	--saídas dos multiplicadores
	signal mult_out1: sy_vector;
	signal mult_out2: sy_vector;
	signal mult_out3: sy_vector;
	--registradores de discrepância
	signal reg_dn: std_logic_vector(7 downto 0); --dn
	signal reg_ds: std_logic_vector(7 downto 0); --d*
	--controle
	signal reg_k:  std_logic_vector(4 downto 0);
	signal reg_lm: std_logic_vector(3 downto 0);
	signal reg_i:  std_logic_vector(3 downto 0);	
	
	--Sinais temporários
	type state_bm is (idle,comp_l,clear_syn,comp_v,store);
	signal EA,PE: state_bm;

begin

	--MÁQUINA DE ESTADOS DE CONTROLE DO ALGORITMO BERLEKAMP-MASSEY
	process(clock,reset)
	begin
		if reset='0' then
			EA <= idle;
			s_x   <= (others => (others => '0'));
		elsif clock'event and clock='1' then
			EA<= PE;
			if clear='1' then
				s_x <= input;
			end if;
		end if;
	end process;

	process(clear,reg_k,reg_i,EA)
	begin
		case EA is
			when idle =>
				if clear='1' then
					PE <= comp_l;
				else
					PE <= idle;
				end if;
				
			when comp_l => 
				if reg_k=16 then
					PE <= clear_syn;
				else
					PE <= comp_l;
				end if;
				
			when clear_syn => PE <= comp_v;
				
			when comp_v =>
				if reg_i=8 then
					PE <= store;
				else
					PE <= comp_v;
				end if;
				
			when store => PE <= idle;
			
			when others => PE <= idle; --byFerlini
			
		end case;
	end process;


	process(clock)
	begin			
		if clock'event and clock='1' then
		
			case EA is
				when idle =>					
					s_reg  <= (others => (others => '0'));
					c_reg  <= (0=>"00000001",others => (others => '0'));
					b_reg  <= (7=>"00000001",others => (others => '0'));
					v_reg  <= (others => (others => '0'));
					reg_k  <= (others => '0');
					reg_lm <= (others => '0');
					reg_i  <= (others => '0');
					
					reg_ds   <= "00000001";
			
				when comp_l =>					
					reg_k <= reg_k + '1';
					
					--sindrome shift register
					s_reg(0) <= s_x(CONV_INTEGER(reg_k(3 downto 0)));
					s_reg(1) <= s_reg(0);
					s_reg(2) <= s_reg(1);
					s_reg(3) <= s_reg(2);
					s_reg(4) <= s_reg(3);
					s_reg(5) <= s_reg(4);
					s_reg(6) <= s_reg(5);
					s_reg(7) <= s_reg(6);
					s_reg(8) <= s_reg(7);
					
					--registrador C
					c_reg(0) <= mult_out2(0) xor mult_out3(0);
					c_reg(1) <= mult_out2(1) xor mult_out3(1);
					c_reg(2) <= mult_out2(2) xor mult_out3(2);
					c_reg(3) <= mult_out2(3) xor mult_out3(3);
					c_reg(4) <= mult_out2(4) xor mult_out3(4);
					c_reg(5) <= mult_out2(5) xor mult_out3(5);
					c_reg(6) <= mult_out2(6) xor mult_out3(6);
					c_reg(7) <= mult_out2(7) xor mult_out3(7);
					c_reg(8) <= mult_out2(8) xor mult_out3(8);
					
					--registrador B
					if (reg_lm & '0') >= reg_k or reg_dn=0 then
						
						b_reg(0) <= b_reg(8);
						b_reg(1) <= b_reg(0);
						b_reg(2) <= b_reg(1);
						b_reg(3) <= b_reg(2);
						b_reg(4) <= b_reg(3);
						b_reg(5) <= b_reg(4);
						b_reg(6) <= b_reg(5);
						b_reg(7) <= b_reg(6);
						b_reg(8) <= b_reg(7);
						
					else
					
						b_reg(0) <= c_reg(0);
						b_reg(1) <= c_reg(1);
						b_reg(2) <= c_reg(2);
						b_reg(3) <= c_reg(3);
						b_reg(4) <= c_reg(4);
						b_reg(5) <= c_reg(5);
						b_reg(6) <= c_reg(6);
						b_reg(7) <= c_reg(7);
						b_reg(8) <= c_reg(8);
						
						reg_lm <= reg_k(3 downto 0) - reg_lm;
						reg_ds <= reg_dn;
					end if;
				
				when clear_syn => 
					s_reg  <= (others => (others => '0'));					
					
				when comp_v =>
					reg_i <= reg_i + '1';	
					
					--sindrome shift register
					s_reg(0)  <= s_x(CONV_INTEGER(reg_i));
					s_reg(1)  <= s_reg(0);
					s_reg(2)  <= s_reg(1);
					s_reg(3)  <= s_reg(2);
					s_reg(4)  <= s_reg(3);
					s_reg(5)  <= s_reg(4);
					s_reg(6)  <= s_reg(5);
					s_reg(7)  <= s_reg(6);
					s_reg(8)  <= s_reg(7);
					
					if reg_i/=0 then
						v_reg(CONV_INTEGER(reg_i)-1) <= reg_dn;
					end if;
									
				when store =>
				when others => --byFerlini
					
			end case;			
		end if;
	end process;
	
	
	--MULTIPLICADORES C*S
	MULT0 : entity work.cell_array_mult port map(input1=>s_reg(0),input2=>c_reg(0),output=>mult_out1(0),f=>"00011101");
	MULT1 : entity work.cell_array_mult port map(input1=>s_reg(1),input2=>c_reg(1),output=>mult_out1(1),f=>"00011101"); 
	MULT2 : entity work.cell_array_mult port map(input1=>s_reg(2),input2=>c_reg(2),output=>mult_out1(2),f=>"00011101"); 
	MULT3 : entity work.cell_array_mult port map(input1=>s_reg(3),input2=>c_reg(3),output=>mult_out1(3),f=>"00011101"); 
	MULT4 : entity work.cell_array_mult port map(input1=>s_reg(4),input2=>c_reg(4),output=>mult_out1(4),f=>"00011101"); 
	MULT5 : entity work.cell_array_mult port map(input1=>s_reg(5),input2=>c_reg(5),output=>mult_out1(5),f=>"00011101"); 
	MULT6 : entity work.cell_array_mult port map(input1=>s_reg(6),input2=>c_reg(6),output=>mult_out1(6),f=>"00011101"); 
	MULT7 : entity work.cell_array_mult port map(input1=>s_reg(7),input2=>c_reg(7),output=>mult_out1(7),f=>"00011101"); 
	MULT8 : entity work.cell_array_mult port map(input1=>s_reg(8),input2=>c_reg(8),output=>mult_out1(8),f=>"00011101");
	
	--MULTIPLICADORES DN*B
	MULT9:  entity work.cell_array_mult port map(input1=>reg_dn,input2=>x"00"   ,output=>mult_out2(0),f=>"00011101");
	MULT10: entity work.cell_array_mult port map(input1=>reg_dn,input2=>b_reg(0),output=>mult_out2(1),f=>"00011101");
	MULT11: entity work.cell_array_mult port map(input1=>reg_dn,input2=>b_reg(1),output=>mult_out2(2),f=>"00011101");
	MULT12: entity work.cell_array_mult port map(input1=>reg_dn,input2=>b_reg(2),output=>mult_out2(3),f=>"00011101");
	MULT13: entity work.cell_array_mult port map(input1=>reg_dn,input2=>b_reg(3),output=>mult_out2(4),f=>"00011101");
	MULT14: entity work.cell_array_mult port map(input1=>reg_dn,input2=>b_reg(4),output=>mult_out2(5),f=>"00011101");
	MULT15: entity work.cell_array_mult port map(input1=>reg_dn,input2=>b_reg(5),output=>mult_out2(6),f=>"00011101");
	MULT16: entity work.cell_array_mult port map(input1=>reg_dn,input2=>b_reg(6),output=>mult_out2(7),f=>"00011101");
	MULT17: entity work.cell_array_mult port map(input1=>reg_dn,input2=>b_reg(7),output=>mult_out2(8),f=>"00011101");
 
	--MULTIPLICADORES DS*C
	MULT18: entity work.cell_array_mult port map(input1=>reg_ds,input2=>c_reg(0),output=>mult_out3(0),f=>"00011101");
	MULT19: entity work.cell_array_mult port map(input1=>reg_ds,input2=>c_reg(1),output=>mult_out3(1),f=>"00011101");
	MULT20: entity work.cell_array_mult port map(input1=>reg_ds,input2=>c_reg(2),output=>mult_out3(2),f=>"00011101");
	MULT21: entity work.cell_array_mult port map(input1=>reg_ds,input2=>c_reg(3),output=>mult_out3(3),f=>"00011101");
	MULT22: entity work.cell_array_mult port map(input1=>reg_ds,input2=>c_reg(4),output=>mult_out3(4),f=>"00011101");
	MULT23: entity work.cell_array_mult port map(input1=>reg_ds,input2=>c_reg(5),output=>mult_out3(5),f=>"00011101");
	MULT24: entity work.cell_array_mult port map(input1=>reg_ds,input2=>c_reg(6),output=>mult_out3(6),f=>"00011101");
	MULT25: entity work.cell_array_mult port map(input1=>reg_ds,input2=>c_reg(7),output=>mult_out3(7),f=>"00011101");
	MULT26: entity work.cell_array_mult port map(input1=>reg_ds,input2=>c_reg(8),output=>mult_out3(8),f=>"00011101");
	
	
	reg_dn <= mult_out1(0) xor mult_out1(1) xor mult_out1(2) xor mult_out1(3) xor
			  mult_out1(4) xor mult_out1(5) xor mult_out1(6) xor mult_out1(7) xor mult_out1(8);
	
	lambda <= c_reg;
	omega <= v_reg;
	ready <= '1' when EA=store else '0';
	
end berlekamp_massey;


--CHIEN SEARCH ALGORITHM
library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.Std_Logic_unsigned.all;
use work.fieldTable_pack.all;

entity chien_location is
	port(
		clock: in std_logic;
		reset: in std_logic;
		bm_ready: in std_logic;
		input: in sy_vector;
		result_odd: out std_logic_vector(7 downto 0);
		start: out std_logic;
		result: out std_logic_vector(7 downto 0)
	);
end chien_location;

architecture chien_location of chien_location is

signal mult_out:	bm_vector;
signal chien_regs:	bm_vector;
signal mux_out:		bm_vector;
signal lambda_x:	sy_vector;
signal mux_sel:		std_logic;
signal counter:		std_logic_vector(7 downto 0);
signal result_odd_s:std_logic_vector(7 downto 0);
signal result_s:	std_logic_vector(7 downto 0);
signal buff:		std_logic_vector(7 downto 0);
signal buff_odd:	std_logic_vector(7 downto 0);
signal correcting:	std_logic;

begin

	MULT1: entity work.cell_array_mult port map(input1=>chien_regs(0),input2=>"00000010",output=>mult_out(0),f=>"00011101");
	MULT2: entity work.cell_array_mult port map(input1=>chien_regs(1),input2=>"00000100",output=>mult_out(1),f=>"00011101");
	MULT3: entity work.cell_array_mult port map(input1=>chien_regs(2),input2=>"00001000",output=>mult_out(2),f=>"00011101");
	MULT4: entity work.cell_array_mult port map(input1=>chien_regs(3),input2=>"00010000",output=>mult_out(3),f=>"00011101");
	MULT5: entity work.cell_array_mult port map(input1=>chien_regs(4),input2=>"00100000",output=>mult_out(4),f=>"00011101");
	MULT6: entity work.cell_array_mult port map(input1=>chien_regs(5),input2=>"01000000",output=>mult_out(5),f=>"00011101");
	MULT7: entity work.cell_array_mult port map(input1=>chien_regs(6),input2=>"10000000",output=>mult_out(6),f=>"00011101");
	MULT8: entity work.cell_array_mult port map(input1=>chien_regs(7),input2=>"00011101",output=>mult_out(7),f=>"00011101");

	process(clock,reset)
	begin
		if reset='0' then
			chien_regs <= (others => (others => '0'));
			lambda_x <= (others => (others => '0'));
			counter <= (others => '0');
			mux_sel <= '0';
			correcting <= '0';
			buff <= (others=>'0'); --byFerlini
			buff_odd <= (others=>'0'); --byFerlini
		elsif clock'event and clock='1' then
			chien_regs(0) <= mux_out(0);
			chien_regs(1) <= mux_out(1);
			chien_regs(2) <= mux_out(2);
			chien_regs(3) <= mux_out(3);
			chien_regs(4) <= mux_out(4);
			chien_regs(5) <= mux_out(5);
			chien_regs(6) <= mux_out(6);
			chien_regs(7) <= mux_out(7);
			if bm_ready='1' then
				lambda_x <= input;
				mux_sel <= '1';
				counter <= (others => '1');
				correcting <= '1';
			else
				mux_sel <= '0';
				counter <= counter + '1';
			end if;
			
			if counter=0 then
				buff <= result_s;
				buff_odd <= result_odd_s;
			end if;
	
		end if;
	end process;

	mux_out(0) <= mult_out(0) when mux_sel='0' else lambda_x(1);
	mux_out(1) <= mult_out(1) when mux_sel='0' else lambda_x(2);
	mux_out(2) <= mult_out(2) when mux_sel='0' else lambda_x(3);
	mux_out(3) <= mult_out(3) when mux_sel='0' else lambda_x(4);
	mux_out(4) <= mult_out(4) when mux_sel='0' else lambda_x(5);
	mux_out(5) <= mult_out(5) when mux_sel='0' else lambda_x(6);
	mux_out(6) <= mult_out(6) when mux_sel='0' else lambda_x(7);
	mux_out(7) <= mult_out(7) when mux_sel='0' else lambda_x(8);
	
	result_odd_s <= lambda_x(0) xor chien_regs(1) xor chien_regs(3) xor chien_regs(5) xor chien_regs(7);	
	result_odd <= buff_odd when counter=0 else result_odd_s;	
	result_s <= result_odd_s xor chien_regs(0) xor chien_regs(2) xor chien_regs(4) xor chien_regs(6);	
	result <= buff when counter=0 else result_s;
	start <= '1' when counter=x"00" and correcting='1' else '0';
	
end chien_location;

library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.Std_Logic_unsigned.all;
use work.fieldTable_pack.all;

use ieee.std_logic_arith.all;

entity chien_value is
	port(
		clock: in std_logic;
		reset: in std_logic;
		bm_ready: in std_logic;
		input: in bm_vector;
		result: out std_logic_vector(7 downto 0)
	);
end chien_value;

architecture chien_value of chien_value is

type val_vector is array(0 to 6) of std_logic_vector(7 downto 0);

	signal mult_out: val_vector;
	signal chien_regs: val_vector;
	signal mux_out: val_vector;
	signal omega_x:	bm_vector;
	signal mux_sel: std_logic;
	signal result_s:std_logic_vector(7 downto 0);
	signal counter: std_logic_vector(7 downto 0);
	signal buff:	std_logic_vector(7 downto 0);

begin
	
	MULT2: entity work.cell_array_mult port map(input1=>chien_regs(0),input2=>"00000010",output=>mult_out(0),f=>"00011101");
	MULT3: entity work.cell_array_mult port map(input1=>chien_regs(1),input2=>"00000100",output=>mult_out(1),f=>"00011101");
	MULT4: entity work.cell_array_mult port map(input1=>chien_regs(2),input2=>"00001000",output=>mult_out(2),f=>"00011101");
	MULT5: entity work.cell_array_mult port map(input1=>chien_regs(3),input2=>"00010000",output=>mult_out(3),f=>"00011101");
	MULT6: entity work.cell_array_mult port map(input1=>chien_regs(4),input2=>"00100000",output=>mult_out(4),f=>"00011101");
	MULT7: entity work.cell_array_mult port map(input1=>chien_regs(5),input2=>"01000000",output=>mult_out(5),f=>"00011101");
	MULT8: entity work.cell_array_mult port map(input1=>chien_regs(6),input2=>"10000000",output=>mult_out(6),f=>"00011101");

	process(clock,reset)
	begin
		if reset='0' then
			chien_regs <= (others => (others => '0'));
			omega_x <= (others => (others => '0'));
			counter <= (others => '0');
			mux_sel <= '0';
			buff <= (others=>'0');--byFerlini
		elsif clock'event and clock='1' then
			chien_regs(0) <= mux_out(0);
			chien_regs(1) <= mux_out(1);
			chien_regs(2) <= mux_out(2);
			chien_regs(3) <= mux_out(3);
			chien_regs(4) <= mux_out(4);
			chien_regs(5) <= mux_out(5);
			chien_regs(6) <= mux_out(6);
			if bm_ready='1' then
				omega_x <= input;
							
				mux_sel <= '1';
				counter <= (others => '1');
			else
				mux_sel <= '0';
				counter <= counter + '1';
			end if;
			
			if counter=0 then
				buff <= result_s;
			end if;
			
		end if;
	end process;			
			
	result_s <= omega_x(0)    xor chien_regs(0) xor chien_regs(1) xor chien_regs(2) xor 
				chien_regs(3) xor chien_regs(4) xor chien_regs(5) xor chien_regs(6);
				
	result <= buff when counter=0 else result_s;
	
	mux_out(0) <= mult_out(0) when mux_sel='0' else omega_x(1);
	mux_out(1) <= mult_out(1) when mux_sel='0' else omega_x(2);
	mux_out(2) <= mult_out(2) when mux_sel='0' else omega_x(3);
	mux_out(3) <= mult_out(3) when mux_sel='0' else omega_x(4);
	mux_out(4) <= mult_out(4) when mux_sel='0' else omega_x(5);
	mux_out(5) <= mult_out(5) when mux_sel='0' else omega_x(6);
	mux_out(6) <= mult_out(6) when mux_sel='0' else omega_x(7);
	
end chien_value;

--FORNEY's ALGORITHM
library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.Std_Logic_unsigned.all;
use work.fieldTable_pack.all;

entity forney is
   port(
      l_result_odd: in std_logic_vector(7 downto 0);
      l_result:		in std_logic_vector(7 downto 0);
      v_result:		in std_logic_vector(7 downto 0);
      correction:	out std_logic_vector(7 downto 0)    
   );
end forney;

architecture forney of forney is

signal l_result_odd_i: std_logic_vector(7 downto 0);
signal mult_out: std_logic_vector(7 downto 0);

begin

	INV1: entity work.inv_module port map(input=>l_result_odd,output=>l_result_odd_i);
	
	MULT: entity work.cell_array_mult port map(input1=>v_result,input2=>l_result_odd_i,output=>mult_out,f=>"00011101");
	
	correction <= mult_out when l_result=0 else (others => '0');

end forney;

--DELAY UNIT
library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.Std_Logic_unsigned.all;

entity delay is
	port(
		clock: in std_logic;
		reset: in std_logic;
		input: in std_logic_vector(7 downto 0);
   		output: out std_logic_vector(7 downto 0)
	);
end delay;

architecture delay of delay is

	type buff_delay is array(0 to 511) of std_logic_vector(7 downto 0);
	signal buff: buff_delay;
	
	signal addr_read:  std_logic_vector(8 downto 0);
	signal addr_write: std_logic_vector(8 downto 0);
	
	type delay_st is (ONN,OFF);
	signal reg_st : delay_st;

begin	
	
	process(reset,clock)
	begin
		if reset = '0' then
			reg_st <= OFF;
			addr_write <= "000000000";
			addr_read <= "011100011";
			
		elsif rising_edge(clock) then
			if reg_st = OFF then
				reg_st <= ONN;
				addr_write <= "000000000";
				addr_read <= "011100011";
			else
				reg_st <= ONN;				
				addr_write <= addr_write + '1';
				addr_read <= addr_read + '1';
			end if;
		end if;
	end process;
	
	process(clock)
	begin
		if rising_edge(clock) then
			buff(CONV_INTEGER(addr_write)) <= input;
		end if;
	end process;
	
	process(clock)
	begin
		if rising_edge(clock) then
			output <= buff(CONV_INTEGER(addr_read));
		end if;
	end process;

end delay;

--TOP DO DECODER
library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.Std_Logic_unsigned.all;
use work.fieldTable_pack.all;

entity decode_rs is
	port(
		clock: in std_logic;
		reset: in std_logic;
		clear_syn: in std_logic;
		input: in std_logic_vector(7 downto 0);
		start: out std_logic;
		output: out std_logic_vector(7 downto 0)
	);
end decode_rs;

architecture decode_rs of decode_rs is

	signal s_x: rs_vector;
	signal omega_x: bm_vector;
	signal lambda_x: sy_vector;
	signal bm_ready: std_logic;
	signal l_result_odd, l_result, v_result: std_logic_vector(7 downto 0);
	signal correction: std_logic_vector(7 downto 0);
	signal input_d: std_logic_vector(7 downto 0);
	--by F.Ferlini
	signal start_sig: std_logic;
	
	signal cont : std_logic_vector(6 downto 0);
	

begin

	SYNDROME_UNIT: entity work.syndrome_unit
	port map(
		clock => clock,
		reset => reset,
		clear => clear_syn,
		input => input,
		output => s_x
	);
	
	BERLEKAMP_MASSEY: entity work.berlekamp_massey
	port map(
		clock => clock,
		reset => reset,
		clear => clear_syn,
		ready => bm_ready,
		input => s_x,
		lambda => lambda_x,
		omega => omega_x
	);
	
	CHIEN: entity work.chien_location
	port map(
		clock => clock,
		reset => reset,
		bm_ready => bm_ready,
		input => lambda_x,
		result_odd => l_result_odd,
		start => start_sig,
		result => l_result
	);
	
	CHIEN_VALUE: entity work.chien_value
	port map(
		clock => clock,
		reset => reset,
		bm_ready => bm_ready,
		input => omega_x,
		result => v_result
	);
	
	FORNEY: entity work.forney
	port map(
		l_result_odd => l_result_odd,
		l_result	 => l_result,
		v_result	 => v_result,
		correction	 => correction
	);
	
	DELAY: entity work.delay
	port map(
		clock => clock,
		reset => reset,
		input => input,
		output => input_d
	);
	
	-- start_sig <= '1' when cont = 30  else '0';
	-- correction <= (others=>'0');

	process(clock,reset)
	begin
		if reset='0' then
			output <= (others=>'0');
			start <= '0';
			cont <= (others=>'0');
			
		elsif rising_edge(clock) then
			output <= input_d xor correction;
			--by F.Ferlini
			start <= start_sig;
			-- if clear_syn = '1' then
				-- cont <= (0=>'1',others=>'0');
			-- elsif cont /= 0 then
				-- cont <= cont + 1;
			-- else
				-- cont <= (others=>'0');
			-- end if;
		end if;
	end process;

end decode_rs;
