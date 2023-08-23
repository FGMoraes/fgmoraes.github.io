--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- TOP FRAME RECEIVE
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.Std_Logic_unsigned.all;
use work.fieldTable_pack.all;

entity top_frame_fec is
	port(
		clock_in	: in  std_logic;
		reset_placa	: in  std_logic;
		entrada		: in  std_logic_vector(63 downto 0);
		saida		: out std_logic_vector(63 downto 0);
		assinatura	: out std_logic_vector(63 downto 0);
		clk0_out	: out std_logic;
		clk180_out	: out std_logic;
		clk2x_out	: out std_logic;
		rst_out		: out std_logic;
		valid_out	: out std_logic
	);
end top_frame_fec;

architecture top_frame_fec of top_frame_fec is

	signal feedback: std_logic_vector(63 downto 0);
        
	signal clock_global   : std_logic := '0';
	signal n_clock_global : std_logic := '0';
	signal reset_global   : std_logic := '0';
	signal clock_global_2x: std_logic := '0';
	
	signal valid_sig : std_logic;
	
begin
   
	rst_out 	<= reset_global;
	clk0_out	<= clock_global;
	clk180_out	<= n_clock_global;
	clk2x_out	<= clock_global_2x;
	valid_out 	<= valid_sig;
	
	DCM_Global : entity work.dcm_ise
	port map(
		CLKIN_IN     => clock_in,
		RST_IN       => reset_placa,
		CLKFX_OUT    => clock_global,
		CLKFX180_OUT => n_clock_global,
		CLK0_OUT     => clock_global_2x,
		LOCKED_OUT   => reset_global
	);
	
	frame_receive: entity work.frame_receive
	port map(
		clock_global =>	clock_global,	-- in  std_logic;
		n_clock_global=> n_clock_global,		-- in
		clock_global2x=> clock_global_2x,	-- in
		reset_global =>	reset_global,	-- in  std_logic;
		--assinatura   =>	assinatura,		-- out std_logic_vector(63 downto 0);
		entrada_rec  =>	entrada,		-- in  std_logic_vector(63 downto 0);
		saida_rec    => feedback,		-- out std_logic_vector(63 downto 0);
		valid_rec	 => valid_sig			-- out
	);
	
	frame_send: entity work.frame_send
	port map(
		clock_global => clock_global,	-- in  std_logic;
		n_clock_global=> n_clock_global,		-- in
		clock_global2x=> clock_global_2x,-- in
		reset_global => reset_global, 	-- in  std_logic;
		entrada_snd  => feedback,	 	-- in  std_logic_vector(63 downto 0);
		--valid_snd	 => valid_sig,		 	-- in  std_logic;
		saida_snd    => saida		 	-- out std_logic_vector(63 downto 0);
	);	
	
end top_frame_fec;
