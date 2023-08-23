--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--	Grupo de Apoio ao Projeto de Hardware  - GAPH
--	Projeto X10GiGA - FINEP/PUCRS/TERACOM
--
--	Módulo:	Top - Teste - Frames Handler
--	Autor:	Jeferson Camargo de Oliveira
--
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity top_tester is
port(
		clk		: in  std_logic;					 -- Entrada de clock
		rst		: in  std_logic;					 -- Entrada de reset
		entrada	: in  std_logic_vector(63 downto 0); -- Entrada dos frames gerados
		saida	: out std_logic_vector(63 downto 0); -- Saida da geração de frames
		we		: out std_logic
	);
end top_tester;

architecture top_tester of top_tester is
	signal assinatura	: std_logic_vector(63 downto 0);
	signal clk0_out   : std_logic; 
	signal clk180_out : std_logic;
	signal clk2x_out  : std_logic;
	signal rst_out	   : std_logic;
	signal valid_out  : std_logic;
	signal word			: std_logic_vector(63 downto 0);
begin
	
--	word  <= entrada;
--	saida <= word;

	TopV0 : entity work.top_frame_fec 
	port map(
		clock_in		=> clk,
		reset_placa	=> rst,
		entrada		=> entrada,
		saida			=> saida,
		assinatura	=> assinatura,
		clk0_out		=> clk0_out,
		clk180_out	=> clk180_out,
		clk2x_out	=> clk2x_out,
		rst_out		=> rst_out,
		valid_out	=> valid_out
	);
	
	process(clk, rst)
	begin
		if rst = '1' then 
			we <= '0';
		elsif clk'event and clk = '1' then
			if valid_out='1' then
				we <= '1';
			end if;
		end if;
	end process;
end top_tester;