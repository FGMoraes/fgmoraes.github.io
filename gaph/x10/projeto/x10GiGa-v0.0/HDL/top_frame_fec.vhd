--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- TOP FRAMER
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.Std_Logic_unsigned.all;
use work.fieldTable_pack.all;

-- entity top_frame_fec is
	-- port(
		-- clock_in	: in  std_logic;
		-- reset_placa	: in  std_logic;
		-- entrada		: out std_logic_vector(63 downto 0);
		-- --entrada		: in  std_logic_vector(63 downto 0);
		-- saida		: out std_logic_vector(63 downto 0);
		-- clk0_out	: out std_logic;
		-- clk180_out	: out std_logic;
		-- clk2x_out	: out std_logic;
		-- rst_out		: out std_logic;
		-- we			: out std_logic
	-- );
-- end top_frame_fec;

entity top_frame_fec is
port(
		clk		: in  std_logic;					 -- Entrada de clock
		rst		: in  std_logic;					 -- Entrada de reset
		entrada	: in  std_logic_vector(63 downto 0); -- Entrada dos frames gerados
		saida	: out std_logic_vector(63 downto 0); -- Saida da geração de frames
		we		: out std_logic
	);
end top_frame_fec;

architecture top_frame_fec of top_frame_fec is

	signal feedback: std_logic_vector(63 downto 0);
	signal frames_i: std_logic_vector(63 downto 0);
        
	signal clock_global   : std_logic;
	signal n_clock_global : std_logic;
	signal reset_global   : std_logic;
	signal clock_global2x: std_logic;
	
	signal valid : std_logic;
	
begin
   
	-- rst_out 	<= reset_global;
	-- clk0_out	<= clock_global;
	-- clk180_out	<= n_clock_global;
	-- clk2x_out	<= clock_global2x;
	-- entrada		<= frames_i;
	--frames_i <= entrada;
	
	DCM_Global : entity work.dcm_ise
	port map(
		--CLKIN_IN     => clock_in,
		CLKIN_IN     => clk,
		--RST_IN       => reset_placa,
		RST_IN       => rst,
		CLKFX_OUT    => clock_global,
		CLKFX180_OUT => n_clock_global,
		CLK0_OUT     => clock_global2x,
		LOCKED_OUT   => reset_global
	);
	
	--Gerador de Frames
	GerFrames : entity work.geraframes
	port map(
		clk 	=> clock_global2x,
		rst 	=> reset_global,
		saida 	=> frames_i
	);
	
	frame_receive: entity work.frame_receive
	port map(
		clock_global	=> clock_global,
		n_clock_global	=> n_clock_global,
		clock_global2x	=> clock_global2x,
		reset_global 	=> reset_global,	
		entrada_rec  	=> frames_i,
		saida_rec    	=> feedback,		
		valid_rec	 	=> valid		
	);
	
	frame_send: entity work.frame_send
	port map(
		clock_global	=> clock_global,
		n_clock_global	=> n_clock_global,
		clock_global2x	=> clock_global2x,
		reset_global	=> reset_global,
		entrada_snd 	=> feedback,
		saida_snd		=> saida
	);
	
	-- Process que gera o write enable das BRAMS na placa
	we_proc: process(reset_global,clock_global2x)
	begin
		if reset_global = '0' then 
			we <= '0';
		elsif rising_edge(clock_global2x) then
			if valid = '1' then
				we <= '1';
			end if;
		end if;
	end process;
	
end top_frame_fec;
