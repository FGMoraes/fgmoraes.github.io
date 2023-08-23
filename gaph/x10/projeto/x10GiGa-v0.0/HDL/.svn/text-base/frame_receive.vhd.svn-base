--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- DECODER's
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.Std_Logic_unsigned.all;
use work.fieldTable_pack.all;

entity fec_decoder is
   port(
      clock_global	: in  std_logic;
      n_clock_global: in  std_logic;
      reset_global	: in  std_logic;
      fec_decA_i	: in  bm_vector;
      fec_decB_i	: in  bm_vector;
      fec_decA_o	: out bm_vector;
      fec_decB_o	: out bm_vector;
      clearA_i		: in  std_logic;
      clearB_i		: in  std_logic;
      start_o		: out std_logic
   );
end fec_decoder;

architecture fec_decoder of fec_decoder is
	
	signal start00, start01, start02, start03, start04, start05, start06, start07: std_logic;
	signal start08, start09, start10, start11, start12, start13, start14, start15: std_logic;

begin

   ---------------------------- Grupo A --------------------------

   DECODER00: entity work.decode_rs port map
   (
      clock     => clock_global,
      reset     => reset_global,
      clear_syn => clearA_i,
      input     => fec_decA_i(0),
      output    => fec_decA_o(0),
      start		=> start00
   );

   DECODER01: entity work.decode_rs port map
   (
      clock     => clock_global,
      reset     => reset_global,
      clear_syn => clearA_i,
      input     => fec_decA_i(1),
      output    => fec_decA_o(1),
      start		=> start01
   );

   DECODER02: entity work.decode_rs port map
   (
      clock     => clock_global,
      reset     => reset_global,
      clear_syn => clearA_i,
      input     => fec_decA_i(2),
      output    => fec_decA_o(2),
      start		=> start02
   );

   DECODER03: entity work.decode_rs port map
   (
      clock     => clock_global,
      reset     => reset_global,
      clear_syn => clearA_i,
      input     => fec_decA_i(3),
      output    => fec_decA_o(3),
      start		=> start03
   );

   DECODER04: entity work.decode_rs port map
   (
      clock     => clock_global,
      reset     => reset_global,
      clear_syn => clearA_i,
      input     => fec_decA_i(4),
      output    => fec_decA_o(4),
      start		=> start04
   );

   DECODER05: entity work.decode_rs port map
   (
      clock     => clock_global,
      reset     => reset_global,
      clear_syn => clearA_i,
      input     => fec_decA_i(5),
      output    => fec_decA_o(5),
      start		=> start05
   );

   DECODER06: entity work.decode_rs port map
   (
      clock     => clock_global,
      reset     => reset_global,
      clear_syn => clearA_i,
      input     => fec_decA_i(6),
      output    => fec_decA_o(6),
      start		=> start06
   );

   DECODER07: entity work.decode_rs port map
   (
      clock     => clock_global,
      reset     => reset_global,
      clear_syn => clearA_i,
      input     => fec_decA_i(7),
      output    => fec_decA_o(7),
      start		=> start07
   );

 ---------------------------- Grupo B --------------------------                  

   DECODER08: entity work.decode_rs port map
   (
      clock     => n_clock_global,
      reset     => reset_global,
      clear_syn => clearB_i,
      input     => fec_decB_i(0),
      output    => fec_decB_o(0),
      start		=> start08
   );

   DECODER09: entity work.decode_rs port map
   (
      clock     => n_clock_global,
      reset     => reset_global,
      clear_syn => clearB_i,
      input     => fec_decB_i(1),
      output    => fec_decB_o(1),
      start		=> start09
   );

   DECODER10: entity work.decode_rs port map
   (
      clock     => n_clock_global,
      reset     => reset_global,
      clear_syn => clearB_i,
      input     => fec_decB_i(2),
      output    => fec_decB_o(2),
      start		=> start10
   );

   DECODER11: entity work.decode_rs port map
   (
      clock     => n_clock_global,
      reset     => reset_global,
      clear_syn => clearB_i,
      input     => fec_decB_i(3),
      output    => fec_decB_o(3),
      start		=> start11
   );

   DECODER12: entity work.decode_rs port map
   (
      clock     => n_clock_global,
      reset     => reset_global,
      clear_syn => clearB_i,
      input     => fec_decB_i(4),
      output    => fec_decB_o(4),
      start		=> start12
   );

   DECODER13: entity work.decode_rs port map
   (
      clock     => n_clock_global,
      reset     => reset_global,
      clear_syn => clearB_i,
      input     => fec_decB_i(5),
      output    => fec_decB_o(5),
      start		=> start13
   );

   DECODER14: entity work.decode_rs port map
   (
      clock     => n_clock_global,
      reset     => reset_global,
      clear_syn => clearB_i,
      input     => fec_decB_i(6),
      output    => fec_decB_o(6),
      start		=> start14
   );

   DECODER15: entity work.decode_rs port map
   (
      clock     => n_clock_global,
      reset     => reset_global,
      clear_syn => clearB_i,
      input     => fec_decB_i(7),
      output    => fec_decB_o(7),
      start		=> start15
   );
   
	start_o <= ((start00 or start01 or start02 or start03) or
			    (start04 or start05 or start06 or start07) or
				(start08 or start09 or start10 or start11) or
				(start12 or start13 or start14 or start15));

end fec_decoder;

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- TOP FRAME RECEIVE
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.Std_Logic_unsigned.all;
use work.fieldTable_pack.all;

entity frame_receive is
   port(
      clock_global	: in  std_logic;
      n_clock_global: in  std_logic;
      clock_global2x: in  std_logic;
      reset_global	: in  std_logic;
      entrada_rec	: in  std_logic_vector(63 downto 0);
      saida_rec		: out std_logic_vector(63 downto 0);
      valid_rec		: out std_logic
   );
end frame_receive;

architecture frame_receive of frame_receive is
	signal clear_sig 	: std_logic;
	signal clearA 		: std_logic;
	signal clearB 		: std_logic;
	signal output_frame : std_logic_vector(63 downto 0);
	signal input_decA 	: bm_vector;
	signal input_decB 	: bm_vector;
	signal output_decA 	: bm_vector;
	signal output_decB 	: bm_vector;
	signal output_dec 	: std_logic_vector(63 downto 0);
	signal sync 		: std_logic;
	signal start_reg 	: std_logic;
	signal reg_cnt		: std_logic_vector(8 downto 0);
	
	type   rec_st1 is (IDLE, ASYNC, START1, VALID, INVALID);
	signal reg_st1, nxt_st1: rec_st1;
	
	type   rec_st2 is (IDLE, GRP_A, GRP_B);
	signal reg_st2, nxt_st2: rec_st2;
	
begin

	reg_st1_p:process(reset_global,clock_global2x)
	begin
		if reset_global = '0' then
			reg_st1 <= IDLE;
		elsif rising_edge(clock_global2x) then
			if reg_st1 = IDLE then
				reg_st1 <= ASYNC;
			else
				reg_st1 <= nxt_st1;
			end if;
		end if;
	end process;
	
	cmb_fsm1_p:process(reg_st1,start_reg,reg_cnt,sync)
	begin
		case reg_st1 is
			when IDLE =>
				nxt_st1 <= IDLE;
			when ASYNC =>
				if start_reg = '1' then
					nxt_st1 <= START1;
				else
					nxt_st1 <= ASYNC;
				end if;
				
			when START1 =>
				if reg_cnt = 0 then
					nxt_st1 <= VALID;
				elsif sync = '0' then --erro
					nxt_st1 <= ASYNC;
				else
					nxt_st1 <= START1;
				end if;
				
			when VALID =>
				if reg_cnt = 478 then
					nxt_st1 <= INVALID;
				elsif sync = '0' then
					nxt_st1 <= ASYNC;
				else
					nxt_st1 <= VALID;
				end if;
			
			when INVALID => 
				if reg_cnt = 510 then
					nxt_st1 <= VALID;
				elsif sync = '0' then --erro
					nxt_st1 <= ASYNC;
				else
					nxt_st1 <= INVALID;
				end if;
				
			when others => nxt_st1 <= IDLE;
		end case;
	end process;
	
	reg_out1_p:process(reset_global,clock_global2x)
	begin
		if reset_global = '0' then
			reg_cnt <= (others=>'1');
			saida_rec <= (others=>'0');
			valid_rec <= '0';

		elsif rising_edge(clock_global2x) then
			case reg_st1 is
				when IDLE =>
					reg_cnt <= (others=>'1');
					saida_rec <= (others=>'0');
					valid_rec <= '0';
					
				when ASYNC =>
					reg_cnt <= (0=>'1',others=>'0');
					saida_rec <= (others=>'0');
					valid_rec <= '0';

				when START1 =>
					reg_cnt <= reg_cnt + 1;

				when VALID =>
					valid_rec <= '1';
					saida_rec <= output_dec;
					reg_cnt <= reg_cnt + 1;
					
				when INVALID =>
					if reg_cnt = 510 then --2x255
						reg_cnt <= (0=>'1',others=>'0');
					else
						reg_cnt <= reg_cnt + 1;
					end if;
					valid_rec <= '0';
					--saida_rec <= output_dec;
					saida_rec <= (others=>'0');

				when others => 
					reg_cnt <= (others=>'0');
					saida_rec <= (others=>'0');
					valid_rec <= '0';
					
			end case;
		end if;
	end process;

	FRAME : entity work.framer port map
	(
		clk			=> clock_global2x,
		rst			=> reset_global,
		saida		=> output_frame,
		entrada		=> entrada_rec,
		sync_o		=> sync,
		clear_sig	=> clear_sig
	);
	
	reg_st2_p:process(reset_global,clock_global2x)
	begin
		if reset_global = '0' then
			reg_st2 <= IDLE;
		elsif rising_edge(clock_global2x) then
			if reg_st2 = IDLE then
				reg_st2 <= GRP_A;
			else
				reg_st2 <= nxt_st2;
			end if;
		end if;
	end process;
	
	comb_st2_p:process(reg_st2)
	begin
		case reg_st2 is
			when IDLE  => nxt_st2 <= IDLE;
			when GRP_A => nxt_st2 <= GRP_B;
			when GRP_B => nxt_st2 <= GRP_A;
			when others=> nxt_st2 <= IDLE;
		end case;
	end process;
	
	reg_out2_p:process(reset_global,clock_global2x)
	begin
		if reset_global = '0' then		
			clearA <= '0';
			clearB <= '0';

			input_decA <= (others=>(others=>'0'));
			input_decB <= (others=>(others=>'0'));

			output_dec <= (others=>'0');
			
		elsif rising_edge(clock_global2x) then
			case reg_st2 is
				when IDLE =>
					clearA <= '0';
					clearB <= '0';
				
					input_decA <= (others=>(others=>'0'));
					input_decB <= (others=>(others=>'0'));
					
					output_dec <= (others=>'0');
					
				when GRP_A =>
					clearA <= clear_sig;
					
					input_decA(7) <= output_frame(  int_s-1 downto 0      );
					input_decA(6) <= output_frame(2*int_s-1 downto   int_s);
					input_decA(5) <= output_frame(3*int_s-1 downto 2*int_s);
					input_decA(4) <= output_frame(4*int_s-1 downto 3*int_s);
					input_decA(3) <= output_frame(5*int_s-1 downto 4*int_s);
					input_decA(2) <= output_frame(6*int_s-1 downto 5*int_s);
					input_decA(1) <= output_frame(7*int_s-1 downto 6*int_s);
					input_decA(0) <= output_frame(8*int_s-1 downto 7*int_s);
					
					output_dec <= output_decA(0) & output_decA(1) & output_decA(2) & output_decA(3)
								& output_decA(4) & output_decA(5) & output_decA(6) & output_decA(7);
				when GRP_B =>
					clearB <= clear_sig;
					
					input_decB(7) <= output_frame(  int_s-1 downto 0      );
					input_decB(6) <= output_frame(2*int_s-1 downto   int_s);
					input_decB(5) <= output_frame(3*int_s-1 downto 2*int_s);
					input_decB(4) <= output_frame(4*int_s-1 downto 3*int_s);
					input_decB(3) <= output_frame(5*int_s-1 downto 4*int_s);
					input_decB(2) <= output_frame(6*int_s-1 downto 5*int_s);
					input_decB(1) <= output_frame(7*int_s-1 downto 6*int_s);
					input_decB(0) <= output_frame(8*int_s-1 downto 7*int_s);
					
					output_dec <= output_decB(0) & output_decB(1) & output_decB(2) & output_decB(3)
								& output_decB(4) & output_decB(5) & output_decB(6) & output_decB(7);
				when others=>
			end case;
		end if;
	end process;
   	
   	decoders16 : entity work.fec_decoder port map
   	(
   		clock_global	=> clock_global,
   		n_clock_global	=> n_clock_global,
   		reset_global	=> reset_global,
   		fec_decA_i		=> input_decA,
   		fec_decB_i		=> input_decB,
   		fec_decA_o		=> output_decA,
   		fec_decB_o		=> output_decB,
   		clearA_i		=> clearA,
   		clearB_i		=> clearB,
   		start_o			=> start_reg
   	);
	
   	
end frame_receive;
