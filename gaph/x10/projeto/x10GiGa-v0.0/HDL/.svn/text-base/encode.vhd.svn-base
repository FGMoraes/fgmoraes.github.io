library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.Std_Logic_unsigned.all;
use work.fieldTable_pack.all;

entity encode_rs is
   port(
      clock: in std_logic;
      reset: in std_logic;
      valid: in std_logic;
      input: in std_logic_vector(int_s-1 downto 0);
      output: out std_logic_vector(int_s-1 downto 0)
   );
end encode_rs;

architecture encode_rs of encode_rs is

	signal rs_registers: rs_vector;
	signal mult_out: rs_vector;
	signal feedback: std_logic_vector(int_s-1 downto 0);
	signal input_reg: std_logic_vector(7 downto 0);
	signal valid_reg: std_logic;

begin
   
   feedback <= (rs_registers(int_e-1) xor input_reg) when valid_reg='1' else (others => '0');
   output <= input_reg when valid_reg='1' else rs_registers(int_e-1);
   
--	process(clock)
--	begin
--   		if clock'event and clock='1' then
--   			input_reg <= input;
--   			valid_reg <= valid;
--		end if;
--	end process;

	--byFerlini	
	process(clock,reset)
	begin
		if reset = '0' then
			input_reg <= (others=>'0');
			valid_reg <= '0';
			
		elsif clock'event and clock='1' then
			input_reg <= input;
			valid_reg <= valid;
		end if;
	end process;
	
   
	process(clock,reset)
	begin
		if reset='0' then
			rs_registers <= (others => (others => '0'));

		elsif clock'event and clock='1' then
			
			rs_registers(0)  <= mult_out(0);
			rs_registers(1)  <= mult_out(1) xor rs_registers(0);
			rs_registers(2)  <= mult_out(2) xor rs_registers(1);
			rs_registers(3)  <= mult_out(3) xor rs_registers(2);
			rs_registers(4)  <= mult_out(4) xor rs_registers(3);
			rs_registers(5)  <= mult_out(5) xor rs_registers(4);
			rs_registers(6)  <= mult_out(6) xor rs_registers(5);
			rs_registers(7)  <= mult_out(7) xor rs_registers(6);
			rs_registers(8)  <= mult_out(8) xor rs_registers(7);
			rs_registers(9)  <= mult_out(9) xor rs_registers(8);
			rs_registers(10) <= mult_out(10) xor rs_registers(9);
			rs_registers(11) <= mult_out(11) xor rs_registers(10);
			rs_registers(12) <= mult_out(12) xor rs_registers(11);
			rs_registers(13) <= mult_out(13) xor rs_registers(12);
			rs_registers(14) <= mult_out(14) xor rs_registers(13);
			rs_registers(15) <= mult_out(15) xor rs_registers(14);
			
		end if;
	end process;
   
	MULT0 : entity work.cell_array_mult  port map(input1=>feedback,input2=>"00111011",output=>mult_out(0), f=>"00011101"); --59d  -- 120 em gf
	MULT1 : entity work.cell_array_mult  port map(input1=>feedback,input2=>"00100100",output=>mult_out(1), f=>"00011101"); --36d  -- 225 em gf
	MULT2 : entity work.cell_array_mult  port map(input1=>feedback,input2=>"00110010",output=>mult_out(2), f=>"00011101"); --50d  -- 194 em gf
	MULT3 : entity work.cell_array_mult  port map(input1=>feedback,input2=>"01100010",output=>mult_out(3), f=>"00011101"); --98d  -- 182 em gf
	MULT4 : entity work.cell_array_mult  port map(input1=>feedback,input2=>"11100101",output=>mult_out(4), f=>"00011101"); --229d -- 169 em gf
	MULT5 : entity work.cell_array_mult  port map(input1=>feedback,input2=>"00101001",output=>mult_out(5), f=>"00011101"); --41d  -- 147 em gf
	MULT6 : entity work.cell_array_mult  port map(input1=>feedback,input2=>"01000001",output=>mult_out(6), f=>"00011101"); --65d  -- 191 em gf
	MULT7 : entity work.cell_array_mult  port map(input1=>feedback,input2=>"10100011",output=>mult_out(7), f=>"00011101"); --163d -- 91  em gf
	MULT8 : entity work.cell_array_mult  port map(input1=>feedback,input2=>"00001000",output=>mult_out(8), f=>"00011101"); --8d   -- 3   em gf
	MULT9 : entity work.cell_array_mult  port map(input1=>feedback,input2=>"00011110",output=>mult_out(9), f=>"00011101"); --30d  -- 76  em gf
	MULT10: entity work.cell_array_mult  port map(input1=>feedback,input2=>"11010001",output=>mult_out(10),f=>"00011101"); --209d -- 161 em gf
	MULT11: entity work.cell_array_mult  port map(input1=>feedback,input2=>"01000100",output=>mult_out(11),f=>"00011101"); --68d  -- 102 em gf
	MULT12: entity work.cell_array_mult  port map(input1=>feedback,input2=>"10111101",output=>mult_out(12),f=>"00011101"); --189d -- 109 em gf
	MULT13: entity work.cell_array_mult  port map(input1=>feedback,input2=>"01101000",output=>mult_out(13),f=>"00011101"); --104d -- 107 em gf
	MULT14: entity work.cell_array_mult  port map(input1=>feedback,input2=>"00001101",output=>mult_out(14),f=>"00011101"); --13d  -- 104 em gf
	MULT15: entity work.cell_array_mult  port map(input1=>feedback,input2=>"00111011",output=>mult_out(15),f=>"00011101"); --59d  -- 120 em gf
	
end encode_rs;