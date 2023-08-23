--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- fec_encoder
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.Std_Logic_unsigned.all;
use work.fieldTable_pack.all;

entity fec_encoder is
port(	
	clock_global	: in std_logic;
	n_clock_global	: in std_logic;
	reset_global	: in std_logic;
	fec_encA_i		: in bm_vector;
	fec_encB_i		: in bm_vector;
	fec_encA_o		: out bm_vector;
	fec_encB_o		: out bm_vector;
	validA_i		: in std_logic;
	validB_i		: in std_logic
);
end fec_encoder;

architecture fec_encoder of fec_encoder is
         
begin

     ---------------------------- Grupo A --------------------------         

   ENCODER00: entity work.encode_rs port map
   (
      clock     => clock_global,
      reset     => reset_global,
      valid     => validA_i,
      input     => fec_encA_i(0),
      output    => fec_encA_o(0)
   );

   ENCODER01: entity work.encode_rs port map
   (
      clock     => clock_global,
      reset     => reset_global,
      valid     => validA_i,
      input     => fec_encA_i(1),
      output    => fec_encA_o(1)
   );

   ENCODER02: entity work.encode_rs port map
   (
      clock     => clock_global,
      reset     => reset_global,
      valid     => validA_i,
      input     => fec_encA_i(2),
      output    => fec_encA_o(2)
   );

   ENCODER03: entity work.encode_rs port map
   (
      clock     => clock_global,
      reset     => reset_global,
      valid     => validA_i,
      input     => fec_encA_i(3),
      output    => fec_encA_o(3)
   );

   ENCODER04: entity work.encode_rs port map
   (
      clock     => clock_global,
      reset     => reset_global,
      valid     => validA_i,
      input     => fec_encA_i(4),
      output    => fec_encA_o(4)
   );

   ENCODER05: entity work.encode_rs port map
   (
      clock     => clock_global,
      reset     => reset_global,
      valid     => validA_i,
      input     => fec_encA_i(5),
      output    => fec_encA_o(5)
   );

   ENCODER06: entity work.encode_rs port map
   (
      clock     => clock_global,
      reset     => reset_global,
      valid     => validA_i,
      input     => fec_encA_i(6),
      output    => fec_encA_o(6)
   );

   ENCODER07: entity work.encode_rs port map
   (
      clock     => clock_global,
      reset     => reset_global,
      valid     => validA_i,
      input     => fec_encA_i(7),
      output    => fec_encA_o(7)
   );

   ---------------------------- Grupo B --------------------------                  

   ENCODER08: entity work.encode_rs port map
   (
      clock     => n_clock_global,
      reset     => reset_global,
      valid     => validB_i,
      input     => fec_encB_i(0),
      output    => fec_encB_o(0)
   );

   ENCODER09: entity work.encode_rs port map
   (
      clock     => n_clock_global,
      reset     => reset_global,
      valid     => validB_i,
      input     => fec_encB_i(1),
      output    => fec_encB_o(1)
   );

   ENCODER10: entity work.encode_rs port map
   (
      clock     => n_clock_global,
      reset     => reset_global,
      valid     => validB_i,
      input     => fec_encB_i(2),
      output    => fec_encB_o(2)
   );

   ENCODER11: entity work.encode_rs port map
   (
      clock     => n_clock_global,
      reset     => reset_global,
      valid     => validB_i,
      input     => fec_encB_i(3),
      output    => fec_encB_o(3)
   );

   ENCODER12: entity work.encode_rs port map
   (
      clock     => n_clock_global,
      reset     => reset_global,
      valid     => validB_i,
      input     => fec_encB_i(4),
      output    => fec_encB_o(4)
   );

   ENCODER13: entity work.encode_rs port map
   (
      clock     => n_clock_global,
      reset     => reset_global,
      valid     => validB_i,
      input     => fec_encB_i(5),
      output    => fec_encB_o(5)
   );

   ENCODER14: entity work.encode_rs port map
   (
      clock     => n_clock_global,
      reset     => reset_global,
      valid     => validB_i,
      input     => fec_encB_i(6),
      output    => fec_encB_o(6)
   );

   ENCODER15: entity work.encode_rs port map
   (
      clock     => n_clock_global,
      reset     => reset_global,
      valid     => validB_i,
      input     => fec_encB_i(7),
      output    => fec_encB_o(7)
   );

end fec_encoder;


--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- TOP FRAME SEND
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.Std_Logic_unsigned.all;
use work.fieldTable_pack.all;

entity frame_send is
   port(
      clock_global2x: in  std_logic;
      clock_global	: in  std_logic;
      n_clock_global: in  std_logic;
      reset_global	: in  std_logic;
      entrada_snd	: in  std_logic_vector(63 downto 0);
	  saida_snd		: out std_logic_vector(63 downto 0)
   );
end frame_send;

architecture frame_send of frame_send is
	
	signal fullmatch		: std_logic;
	signal scram_init		: std_logic;
	signal scram_rst		: std_logic;
	signal address_a		: std_logic_vector(9  downto 0);
	signal address_b		: std_logic_vector(9  downto 0);
	signal address_a_mem	: std_logic_vector(9  downto 0);
	signal address_b_mem	: std_logic_vector(9  downto 0);
	signal sa				: std_logic_vector(63 downto 0);
	signal sb				: std_logic_vector(63 downto 0);
	signal output_enc		: std_logic_vector(63 downto 0);
	signal input_enc		: std_logic_vector(63 downto 0);
	signal valid_snd		: std_logic;
	signal input_encA		: bm_vector;
	signal input_encB		: bm_vector;
	signal output_encA		: bm_vector;
	signal output_encB		: bm_vector;
	signal validA			: std_logic;
	signal validB			: std_logic;
	signal reg_cnt			: std_logic_vector(8 downto 0);
	signal cnt_frame		: std_logic_vector(1 downto 0);
	
	type   snd_st1 is (IDLE, START, VALID, INVALID);
	signal reg_st1, nxt_st1: snd_st1;
	
	type   snd_st2 is (IDLE, GRP_A, GRP_B);
	signal reg_st2, nxt_st2: snd_st2;
	
	type   snd_st3 is (ONN, OFF);
	signal reg_st3 : snd_st3;
	
begin

	compfull: entity work.comparadorfull
	port map(
		entrada   => entrada_snd(63 downto 16), -- (in)
		fullmatch => fullmatch            -- (out)
	);

	reg_st1_p:process(reset_global,clock_global2x)
	begin
		if reset_global = '0' then
			reg_st1 <= IDLE;
		
		elsif rising_edge(clock_global2x) then
			if reg_st1 = IDLE then
				reg_st1 <= START;
			else
				reg_st1 <= nxt_st1;
			end if;
		end if;
	end process;
	
	process(reg_st1,fullmatch,reg_cnt)
	begin
		nxt_st1 <= reg_st1;
		case reg_st1 is
			when IDLE => nxt_st1 <= IDLE;
			when START =>
				if fullmatch = '1' then
					nxt_st1 <= VALID;
				end if;
				
			when VALID =>
				if reg_cnt = 478 then
					nxt_st1 <= INVALID;
				end if;
				
			when INVALID =>
				if reg_cnt = 510 then
					nxt_st1 <= VALID;
				end if;
				
			when others => nxt_st1 <= IDLE;
		end case;
	end process;
	
	process(reset_global,clock_global2x)
	begin
		if reset_global = '0' then
			reg_cnt <= (others=>'0');
			cnt_frame <= (others=>'0');
		
		elsif rising_edge(clock_global2x) then
			case reg_st1 is
				when IDLE =>
					reg_cnt <= (others=>'0');
					cnt_frame <= (others=>'0');
					
				when START =>
					reg_cnt <= (0=>'1',others=>'0');
					
				when VALID =>
					reg_cnt <= reg_cnt + 1;
					
				when INVALID =>
					if reg_cnt = 510 then --2x255
						reg_cnt <= (0=>'1',others=>'0');
						cnt_frame <= cnt_frame + 1;
					else
						reg_cnt <= reg_cnt + 1;
					end if;				
					
				when others =>
			end case;
		end if;
	end process;
	
	valid_snd <= '1' when reg_st1 = VALID else '0';
	
	-------
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
	
	cmb_st2_p:process(reg_st2)
	begin
		case reg_st2 is
			when IDLE => nxt_st2 <= IDLE;
			when GRP_A => nxt_st2 <= GRP_B;
			when GRP_B => nxt_st2 <= GRP_A;
			when others => nxt_st2 <= IDLE;
		end case;
	end process;
	
	out_st2_p:process(reset_global,clock_global2x)
	begin
		if reset_global = '0' then
			validA <= '0';
			validB <= '0';
			
			input_enc <= (others=>'0');
			
			input_encA <= (others=>(others=>'0'));
			input_encB <= (others=>(others=>'0'));
			
			output_enc <= (others=>'0');
			
		elsif rising_edge(clock_global2x) then
			case reg_st2 is
				when IDLE =>
					validA <= '0';
					validB <= '0';
					
					input_enc <= (others=>'0');
					
					input_encA <= (others=>(others=>'0'));
					input_encB <= (others=>(others=>'0'));
					
					output_enc <= (others=>'0');
				
				when GRP_A =>
					validA <= valid_snd;
					
					input_enc <= entrada_snd;
				
					input_encA(7) <= input_enc(  int_s-1 downto 0      );
					input_encA(6) <= input_enc(2*int_s-1 downto   int_s);
					input_encA(5) <= input_enc(3*int_s-1 downto 2*int_s);
					input_encA(4) <= input_enc(4*int_s-1 downto 3*int_s);
					input_encA(3) <= input_enc(5*int_s-1 downto 4*int_s);
					input_encA(2) <= input_enc(6*int_s-1 downto 5*int_s);
					input_encA(1) <= input_enc(7*int_s-1 downto 6*int_s);
					input_encA(0) <= input_enc(8*int_s-1 downto 7*int_s);
					
					output_enc <= output_encA(0) & output_encA(1) & output_encA(2) & output_encA(3) &
								  output_encA(4) & output_encA(5) & output_encA(6) & output_encA(7);
				when GRP_B =>
					validB <= valid_snd;
					
					input_enc <= entrada_snd;
				
					input_encB(7) <= input_enc(  int_s-1 downto 0      );
					input_encB(6) <= input_enc(2*int_s-1 downto   int_s);
					input_encB(5) <= input_enc(3*int_s-1 downto 2*int_s);
					input_encB(4) <= input_enc(4*int_s-1 downto 3*int_s);
					input_encB(3) <= input_enc(5*int_s-1 downto 4*int_s);
					input_encB(2) <= input_enc(6*int_s-1 downto 5*int_s);
					input_encB(1) <= input_enc(7*int_s-1 downto 6*int_s);
					input_encB(0) <= input_enc(8*int_s-1 downto 7*int_s);
					
					output_enc <= output_encB(0) & output_encB(1) & output_encB(2) & output_encB(3) &
								  output_encB(4) & output_encB(5) & output_encB(6) & output_encB(7);
				when others=>
			end case;
		end if;
	end process;
	
	encoders16 : entity work.fec_encoder port map
	(
		clock_global	=> clock_global,
		n_clock_global	=> n_clock_global,
		reset_global	=> reset_global,
		fec_encA_i		=> input_encA,
		fec_encB_i		=> input_encB,
		fec_encA_o		=> output_encA,
		fec_encB_o		=> output_encB,
		validA_i		=> validA,
		validB_i		=> validB
	);
	
	SCRAMBLER:  entity work.scrambler port map
	(
		clk        => clock_global2x, -- (in)
		rst        => scram_rst,    -- (in)
		init       => scram_init,   -- (in)
		addressin  => address_a,    -- (in)
		sain       => sa,           -- (in)
		sbin       => sb,           -- (in)
		word64in   => output_enc,	-- (in)
		word64out  => saida_snd 	-- (out)
	);
   
    MEMORIA_SCRAMBLER:  entity work.memoriascram port map
    (
		addra      => address_a_mem,    -- (in)
		addrb      => address_b_mem,    -- (in)
		clka       => clock_global2x,	-- (in)
		clkb       => clock_global2x,	-- (in)
		douta      => sa,				-- (out)
		doutb      => sb				-- (out)
    );
	
	address_a_mem <= (others=>'0') when reg_cnt = 3 and cnt_frame = 0 else address_a;
	address_b_mem <= "0000000001"  when reg_cnt = 3 and cnt_frame = 0 else address_b;
	
	proc_addr:process(clock_global2x,reset_global)
	begin
		if reset_global = '0' then
			reg_st3 <= OFF;
			address_a   <= (others=>'0');
			address_b   <= (others=>'0');
			scram_rst <= '1';
			scram_init <= '1';
			
		elsif rising_edge(clock_global2x) then
			if reg_st3 = OFF then
				reg_st3 <= ONN;
				address_a   <= (others=>'0');
				address_b   <= (others=>'0');
				scram_rst <= '1';
				scram_init <= '1';
			else
				reg_st3 <= ONN;
				if reg_cnt = 3 and cnt_frame = 0 then
					address_a   <= "0000000001";
					address_b   <= "0000000010";
					scram_rst <= '0';
					scram_init <= '0';
				else
					address_a   <= address_a + 1;
					address_b   <= address_b + 1;
					scram_init <= '1';
				end if;
			end if;
		end if;
	end process;
	         
end frame_send;
