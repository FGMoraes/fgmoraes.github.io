--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--	Grupo de Apoio ao Projeto de Hardware  - GAPH
--	Projeto X10GiGA - FINEP/PUCRS/TERACOM
--
--	Módulo:	Saída - Prototipação
--	Autor:	Jeferson Camargo de Oliveira
--
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

----Pragma translate_off
library unisim ;
use unisim.vcomponents.all ;
----Pragma translate_on

entity slavehandler is
port(
		clk		: in  std_logic;					-- Entrada de clock
		rst		: in  std_logic;					-- Entrada de reset
		-- Comunicação com o FramesHandler
		re		: out std_logic; 					-- Read enable para o frames handler
		mem		: out std_logic_vector(7  downto 0);-- Escolhe a memória que será lida do frames handler
		addre	: out std_logic_vector(9  downto 0);-- Endereco a ser lido pelo frames handler
		dinhi	: in  std_logic_vector(31 downto 0);-- Entrada de dados vindos do frames handler (high)
		dinlo	: in  std_logic_vector(31 downto 0);-- Entrada de dados vindos do frames handler (low)
		doner	: in  std_logic;					-- Fim da leitura
		-- Comunicação com o Slave
		dinMB	: in  std_logic_vector(31 downto 0);-- Entrada de dados vindo do slave do Main Bus
		douthi	: out std_logic_vector(31 downto 0);-- Saída de dados para o slave do Main Bus (high)
		doutlo	: out std_logic_vector(31 downto 0);-- Saída de dados para o slave do Main Bus (low)
		doutMB	: out std_logic_vector(31 downto 0)-- Saída de dados para o slave do Main Bus
	);
end slavehandler;

architecture slavehandler of slavehandler is

	constant MBmatch : std_logic_vector(13 downto 0) := "01101010111100";
	constant MBdone  : std_logic_vector(31 downto 0) := x"BEEFBAF0";

begin
	--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	--Pooling
	--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	process(clk,rst,doner)
	begin
		if rst = '1' then
			re		<= '0';
			mem		<= (others => '0');
		    addre	<= (others => '0');
		    doutMB	<= (others => '0');
		    douthi	<= (others => '0');
		    doutlo	<= (others => '0');
		elsif clk'event and clk = '1' then
			if dinMB(31 downto 18) = MBmatch then
				if doner = '0' then
					re		<= '1';
					mem		<= dinMB(17 downto 10);
					addre	<= dinMB(9  downto  0);
					doutMB	<= dinMB;
					douthi	<= dinhi;
					doutlo	<= dinlo;
				else
					re		<= '0';
					mem		<= (others => '0');
					addre	<= (others => '0');
					doutMB	<= MBdone;
					douthi	<= (others => '0');
					doutlo	<= (others => '0');
				end if;
			else
				re		<= '0';
				mem		<= (others => '0');
				addre	<= (others => '0');
				doutMB	<= (others => '0');
				douthi	<= (others => '0');
				doutlo	<= (others => '0');
			end if;
		end if;
	end process;

end slavehandler;