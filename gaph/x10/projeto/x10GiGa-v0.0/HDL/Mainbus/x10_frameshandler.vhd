--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--	Grupo de Apoio ao Projeto de Hardware  - GAPH
--	Projeto X10GiGA - FINEP/PUCRS/TERACOM
--
--	Módulo:	Memória - Saída - Prototipação
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

entity frameshandler is
port(
		clk		: in  std_logic;					-- Entrada de clock
		rst		: in  std_logic;					-- Entrada de reset
		-- Write
		we		: in  std_logic; 					-- Write enable
		din		: in  std_logic_vector(63 downto 0);-- Entrada de dados
		--donew	: out std_logic;					-- Fim do armazenamento
		-- Read
		re		: in  std_logic; 					-- Read enable
		mem		: in  std_logic_vector(7  downto 0);-- Escolhe a memória que será lida
		addr	: in  std_logic_vector(9  downto 0);-- Endereço que será lido
		douthi	: out std_logic_vector(31 downto 0);-- Saída de dados parte alta
		doutlo	: out std_logic_vector(31 downto 0);-- Saída de dados parte baixa
		doner	: out std_logic						-- Fim da leitura
	);
end frameshandler;

architecture frameshandler of frameshandler is

	component RAMB16_S18_S18 is
	port(
		DOA   : out std_logic_vector(15 downto 0);	-- Port A 16-bit Data Output
		DOB   : out std_logic_vector(15 downto 0); 	-- Port B 16-bit Data Output
		DOPA  : out std_logic_vector(1  downto 0);	-- Port A 2-bit Parity Output
		DOPB  : out std_logic_vector(1  downto 0);	-- Port B 2-bit Parity Output
		ADDRA : in  std_logic_vector(9  downto 0); 	-- Port A 10-bit Address Input
		ADDRB : in  std_logic_vector(9  downto 0); 	-- Port B 10-bit Address Input
		CLKA  : in  std_logic;			 			-- Port A Clock
		CLKB  : in  std_logic;			 			-- Port B Clock
		DIA   : in  std_logic_vector(15 downto 0); 	-- Port A 16-bit Data Input
		DIB   : in  std_logic_vector(15 downto 0); 	-- Port B 16-bit Data Input
		DIPA  : in  std_logic_vector(1  downto 0); 	-- Port A 2-bit parity Input
		DIPB  : in  std_logic_vector(1  downto 0); 	-- Port-B 2-bit parity Input
		ENA   : in  std_logic;			 			-- Port A RAM Enable Input
		ENB   : in  std_logic;			 			-- Port B RAM Enable Input
		SSRA  : in  std_logic;			 			-- Port A Synchronous Set/Reset Input
		SSRB  : in  std_logic;			 			-- Port B Synchronous Set/Reset Input
		WEA   : in  std_logic;			 			-- Port A Write Enable Input
		WEB   : in  std_logic			 			-- Port B Write Enable Input
	);
	end component;
	
	signal clka		: std_logic;					-- Clock da porta A das Block RAMs (escrita)
	signal clkb		: std_logic;					-- Clock da porta B das Block RAMs (leitura)
	signal start	: std_logic;					-- Start da escrita
	signal donewr	: std_logic;					-- Sinal intermediário do sinal que identifica o fim da escrita
	signal addrw	: std_logic_vector(9 downto 0);	-- Sinal intermediário dos endereços para escrita (Porta A)
	signal addre	: std_logic_vector(9 downto 0);	-- Sinal intermediário dos endereços para leitura (Porta B)
	signal mems		: std_logic_vector(7 downto 0);	-- Sinal intermediário da seleção de memória (leitura)
	signal contram	: std_logic_vector(7 downto 0);	-- Sinal intermediário da seleção de memória (escrita)

	-- Sinais das Block RAMs
	signal do_mem00		: std_logic_vector(63 downto 0);	-- Saída de dados da memória 00
	signal we_mem00		: std_logic;						-- Write Enable  da memória 00
	signal do_mem01		: std_logic_vector(63 downto 0);	-- Saída de dados da memória 01
	signal we_mem01		: std_logic;						-- Write Enable  da memória 01
	signal do_mem02		: std_logic_vector(63 downto 0);	-- Saída de dados da memória 02
	signal we_mem02		: std_logic;						-- Write Enable  da memória 02
	signal do_mem03		: std_logic_vector(63 downto 0);	-- Saída de dados da memória 03
	signal we_mem03		: std_logic;						-- Write Enable  da memória 03
	signal do_mem04		: std_logic_vector(63 downto 0);	-- Saída de dados da memória 04
	signal we_mem04		: std_logic;						-- Write Enable  da memória 04
	signal do_mem05		: std_logic_vector(63 downto 0);	-- Saída de dados da memória 05
	signal we_mem05		: std_logic;						-- Write Enable  da memória 05
	signal do_mem06		: std_logic_vector(63 downto 0);	-- Saída de dados da memória 06
	signal we_mem06		: std_logic;						-- Write Enable  da memória 06
	signal do_mem07		: std_logic_vector(63 downto 0);	-- Saída de dados da memória 07
	signal we_mem07		: std_logic;						-- Write Enable  da memória 07
	signal do_mem08		: std_logic_vector(63 downto 0);	-- Saída de dados da memória 08
	signal we_mem08		: std_logic;						-- Write Enable  da memória 08
	signal do_mem09		: std_logic_vector(63 downto 0);	-- Saída de dados da memória 09
	signal we_mem09		: std_logic;						-- Write Enable  da memória 09

begin

	clka <= clk when we = '1' else '0';
	clkb <= clk when re = '1' else '0';

--	donew <= donewr;
	
	--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	-- Write Process
	--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	process(clk, we)
	begin
		if we = '0' then
			addrw   <= (others => '1');
			we_mem01   <= '0';
			we_mem02   <= '0';
			we_mem03   <= '0';
			we_mem04   <= '0';
			we_mem05   <= '0';
			we_mem06   <= '0';
			we_mem07   <= '0';
			we_mem08   <= '0';
			we_mem09   <= '0';
--			if start = '1' then
--				donewr	<= '1';
--				contram <= contram;
--				we_mem00<= '0';
--			else
--				donewr	<= '0';
				contram <= (others => '0');
--				we_mem00<= '1';
--			end if;
		elsif clk'event and clk = '1' and donewr = '0' then
			if donewr = '0' then
				addrw <= addrw + 1;
				--start	<= '1';
			else
				addrw <= (others => '1');
			end if;
			if addrw = "1111111110" then
				contram <= contram + 1;
				case contram is
					when x"00"	=>	we_mem00 <= '1'; we_mem01 <= '0'; we_mem02 <= '0'; we_mem03 <= '0';	we_mem04 <= '0';
									we_mem05 <= '0'; we_mem06 <= '0'; we_mem07 <= '0'; we_mem08 <= '0';	we_mem09 <= '0';
									donewr	 <= '0';
					when x"01"	=>  we_mem00 <= '0'; we_mem01 <= '1'; we_mem02 <= '0'; we_mem03 <= '0'; we_mem04 <= '0'; 
									we_mem05 <= '0'; we_mem06 <= '0'; we_mem07 <= '0'; we_mem08 <= '0'; we_mem09 <= '0';
									donewr	 <= '0';
					when x"02"	=>  we_mem00 <= '0'; we_mem01 <= '0'; we_mem02 <= '1'; we_mem03 <= '0'; we_mem04 <= '0';
									we_mem05 <= '0'; we_mem06 <= '0'; we_mem07 <= '0'; we_mem08 <= '0'; we_mem09 <= '0';
									donewr	 <= '0';
					when x"03"	=>  we_mem00 <= '0'; we_mem01 <= '0'; we_mem02 <= '0'; we_mem03 <= '1'; we_mem04 <= '0';
									we_mem05 <= '0'; we_mem06 <= '0'; we_mem07 <= '0'; we_mem08 <= '0'; we_mem09 <= '0';
									donewr	 <= '0';
					when x"04"	=>  we_mem00 <= '0'; we_mem01 <= '0'; we_mem02 <= '0'; we_mem03 <= '0'; we_mem04 <= '1';
									we_mem05 <= '0'; we_mem06 <= '0'; we_mem07 <= '0'; we_mem08 <= '0'; we_mem09 <= '0';
									donewr	 <= '0';
					when x"05"	=>  we_mem00 <= '0'; we_mem01 <= '0'; we_mem02 <= '0'; we_mem03 <= '0'; we_mem04 <= '0';
									we_mem05 <= '1'; we_mem06 <= '0'; we_mem07 <= '0'; we_mem08 <= '0'; we_mem09 <= '0';
									donewr	 <= '0';
					when x"06"	=>  we_mem00 <= '0'; we_mem01 <= '0'; we_mem02 <= '0'; we_mem03 <= '0'; we_mem04 <= '0';
									we_mem05 <= '0'; we_mem06 <= '1'; we_mem07 <= '0'; we_mem08 <= '0'; we_mem09 <= '0';
									donewr	 <= '0';
					when x"07"	=>  we_mem00 <= '0'; we_mem01 <= '0'; we_mem02 <= '0'; we_mem03 <= '0'; we_mem04 <= '0';
									we_mem05 <= '0'; we_mem06 <= '0'; we_mem07 <= '1'; we_mem08 <= '0'; we_mem09 <= '0';
									donewr	 <= '0';
					when x"08"	=>  we_mem00 <= '0'; we_mem01 <= '0'; we_mem02 <= '0'; we_mem03 <= '0'; we_mem04 <= '0';
									we_mem05 <= '0'; we_mem06 <= '0'; we_mem07 <= '0'; we_mem08 <= '1'; we_mem09 <= '0';
									donewr	 <= '0';
					when x"09"	=>  we_mem00 <= '0'; we_mem01 <= '0'; we_mem02 <= '0'; we_mem03 <= '0'; we_mem04 <= '0';
									we_mem05 <= '0'; we_mem06 <= '0'; we_mem07 <= '0'; we_mem08 <= '0'; we_mem09 <= '1';
									donewr	 <= '0';
					when x"0A"	=>  we_mem00 <= '0'; we_mem01 <= '0'; we_mem02 <= '0'; we_mem03 <= '0'; we_mem04 <= '0';
									we_mem05 <= '0'; we_mem06 <= '0'; we_mem07 <= '0'; we_mem08 <= '0'; we_mem09 <= '0';
									donewr	 <= '1';
					when others =>	we_mem00 <= '0'; we_mem01 <= '0'; we_mem02 <= '0'; we_mem03 <= '0'; we_mem04 <= '0';
									we_mem05 <= '0'; we_mem06 <= '0'; we_mem07 <= '0'; we_mem08 <= '0'; we_mem09 <= '0';
									donewr	 <= '1';
				end case;
			else
				case contram is
					when x"00"	=>	we_mem00 <= '1'; we_mem01 <= '0'; we_mem02 <= '0'; we_mem03 <= '0'; we_mem04 <= '0';
									we_mem05 <= '0'; we_mem06 <= '0'; we_mem07 <= '0'; we_mem08 <= '0'; we_mem09 <= '0';
									donewr	 <= '0';
					when x"01"	=>  we_mem00 <= '0'; we_mem01 <= '1'; we_mem02 <= '0'; we_mem03 <= '0'; we_mem04 <= '0';
									we_mem05 <= '0'; we_mem06 <= '0'; we_mem07 <= '0'; we_mem08 <= '0'; we_mem09 <= '0';
									donewr	 <= '0';
					when x"02"	=>  we_mem00 <= '0'; we_mem01 <= '0'; we_mem02 <= '1'; we_mem03 <= '0'; we_mem04 <= '0';
									we_mem05 <= '0'; we_mem06 <= '0'; we_mem07 <= '0'; we_mem08 <= '0'; we_mem09 <= '0';
									donewr	 <= '0';
					when x"03"	=>  we_mem00 <= '0'; we_mem01 <= '0'; we_mem02 <= '0'; we_mem03 <= '1'; we_mem04 <= '0';
									we_mem05 <= '0'; we_mem06 <= '0'; we_mem07 <= '0'; we_mem08 <= '0'; we_mem09 <= '0';
									donewr	 <= '0';
					when x"04"	=>  we_mem00 <= '0'; we_mem01 <= '0'; we_mem02 <= '0'; we_mem03 <= '0'; we_mem04 <= '1';
									we_mem05 <= '0'; we_mem06 <= '0'; we_mem07 <= '0'; we_mem08 <= '0'; we_mem09 <= '0';
									donewr	 <= '0';
					when x"05"	=>  we_mem00 <= '0'; we_mem01 <= '0'; we_mem02 <= '0'; we_mem03 <= '0'; we_mem04 <= '0';
									we_mem05 <= '1'; we_mem06 <= '0'; we_mem07 <= '0'; we_mem08 <= '0'; we_mem09 <= '0';
									donewr	 <= '0';
					when x"06"	=>  we_mem00 <= '0'; we_mem01 <= '0'; we_mem02 <= '0'; we_mem03 <= '0'; we_mem04 <= '0';
									we_mem05 <= '0'; we_mem06 <= '1'; we_mem07 <= '0'; we_mem08 <= '0'; we_mem09 <= '0';
									donewr	 <= '0';
					when x"07"	=>  we_mem00 <= '0'; we_mem01 <= '0'; we_mem02 <= '0'; we_mem03 <= '0'; we_mem04 <= '0';
									we_mem05 <= '0'; we_mem06 <= '0'; we_mem07 <= '1'; we_mem08 <= '0'; we_mem09 <= '0';
									donewr	 <= '0';
					when x"08"	=>  we_mem00 <= '0'; we_mem01 <= '0'; we_mem02 <= '0'; we_mem03 <= '0'; we_mem04 <= '0';
									we_mem05 <= '0'; we_mem06 <= '0'; we_mem07 <= '0'; we_mem08 <= '1'; we_mem09 <= '0';
									donewr	 <= '0';
					when x"09"	=>  we_mem00 <= '0'; we_mem01 <= '0'; we_mem02 <= '0'; we_mem03 <= '0'; we_mem04 <= '0';
									we_mem05 <= '0'; we_mem06 <= '0'; we_mem07 <= '0'; we_mem08 <= '0'; we_mem09 <= '1';
									donewr	 <= '0';
					when x"0A"	=>  we_mem00 <= '0'; we_mem01 <= '0'; we_mem02 <= '0'; we_mem03 <= '0'; we_mem04 <= '0';
									we_mem05 <= '0'; we_mem06 <= '0'; we_mem07 <= '0'; we_mem08 <= '0'; we_mem09 <= '0';
									donewr	 <= '1';									
					when others =>	we_mem00 <= '0'; we_mem01 <= '0'; we_mem02 <= '0'; we_mem03 <= '0'; we_mem04 <= '0';
									we_mem05 <= '0'; we_mem06 <= '0'; we_mem07 <= '0'; we_mem08 <= '0'; we_mem09 <= '0';
									donewr	 <= '1';
				end case;
			end if;
		end if;
	end process;
	
	--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	-- Read Process
	--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	process(clk, re)
	begin
		if re = '0' then
			mems   <= (others => '0');
			addre  <= (others => '0');
			douthi <= (others => '0');
			doutlo <= (others => '0');
			doner  <= '0';
		elsif clk'event and clk = '1' then
			addre <= addr;
			mems  <= mem;
			case mems is
				when x"00"	=>  douthi <= do_mem00(63 downto 32);
								doutlo <= do_mem00(31 downto  0);
								doner <= '0';
				when x"01"	=>  douthi <= do_mem01(63 downto 32);
								doutlo <= do_mem01(31 downto  0);
								doner <= '0';
				when x"02"	=>  douthi <= do_mem02(63 downto 32);
								doutlo <= do_mem02(31 downto  0);
								doner <= '0';
				when x"03"	=>  douthi <= do_mem03(63 downto 32);
								doutlo <= do_mem03(31 downto  0);
								doner <= '0';
				when x"04"	=>  douthi <= do_mem04(63 downto 32);
								doutlo <= do_mem04(31 downto  0);
								doner <= '0';
				when x"05"	=>  douthi <= do_mem05(63 downto 32);
								doutlo <= do_mem05(31 downto  0);
								doner <= '0';
				when x"06"	=>  douthi <= do_mem06(63 downto 32);
								doutlo <= do_mem06(31 downto  0);
								doner <= '0';
				when x"07"	=>  douthi <= do_mem07(63 downto 32);
								doutlo <= do_mem07(31 downto  0);
								doner <= '0';
				when x"08"	=>  douthi <= do_mem08(63 downto 32);
								doutlo <= do_mem08(31 downto  0);
								doner <= '0';
				when x"09"	=>  douthi <= do_mem09(63 downto 32);
								doutlo <= do_mem09(31 downto  0);
								doner <= '0';
				when others =>  douthi <= (others => '0');
								doutlo <= (others => '0');
								doner <= '1';
			end case;
		end if;
	end process;
	
	--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	-- Memórias
	--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++	
	
	-- MEM00_RAMB00 instantiation
	MEM00_RAMB00 : RAMB16_S18_S18
	port map (
		DOA   => open,
	    DOB   => do_mem00(63 downto 48),-- Port 16-bit Data Output
	    DOPA  => open,
	    DOPB  => open,
	    ADDRA => addrw,					-- Port 10-bit Address Input to Write
	    ADDRB => addre,					-- Port 10-bit Address Input to Read
	    CLKA  => clka, 					-- Port A Clock
	    CLKB  => clkb, 					-- Port B Clock
	    DIA   => din(63 downto 48),		-- Port 16-bit Data Input
	    DIB   => (others => '0'),
	    DIPA  => (others => '0'),
	    DIPB  => (others => '0'),
	    ENA   => '1',
	    ENB   => '1',
	    SSRA  => '0',
	    SSRB  => '0',
	    WEA   => we_mem00,				-- Port Write Enable Input
	    WEB   => '0'
	);
	-- End of MEM00_RAMB00 instantiation
	
	-- MEM00_RAMB01 instantiation
	MEM00_RAMB01 : RAMB16_S18_S18
	port map (
		DOA   => open,
	    DOB   => do_mem00(47 downto 32),-- Port 16-bit Data Output
	    DOPA  => open,
	    DOPB  => open,
	    ADDRA => addrw,					-- Port 10-bit Address Input to Write
	    ADDRB => addre,					-- Port 10-bit Address Input to Read
	    CLKA  => clka, 					-- Port A Clock
	    CLKB  => clkb, 					-- Port B Clock
	    DIA   => din(47 downto 32),		-- Port 16-bit Data Input
	    DIB   => (others => '0'),
	    DIPA  => (others => '0'),
	    DIPB  => (others => '0'),
	    ENA   => '1',
	    ENB   => '1',
	    SSRA  => '0',
	    SSRB  => '0',
	    WEA   => we_mem00,				-- Port Write Enable Input
	    WEB   => '0'
	);
	-- End of MEM00_RAMB01 instantiation
	
	-- MEM00_RAMB02 instantiation
	MEM00_RAMB02 : RAMB16_S18_S18
	port map (
		DOA   => open,
	    DOB   => do_mem00(31 downto 16),-- Port 16-bit Data Output
	    DOPA  => open,
	    DOPB  => open,
	    ADDRA => addrw,					-- Port 10-bit Address Input to Write
	    ADDRB => addre,					-- Port 10-bit Address Input to Read
	    CLKA  => clka, 					-- Port A Clock
	    CLKB  => clkb, 					-- Port B Clock
	    DIA   => din(31 downto 16),		-- Port 16-bit Data Input
	    DIB   => (others => '0'),
	    DIPA  => (others => '0'),
	    DIPB  => (others => '0'),
	    ENA   => '1',
	    ENB   => '1',
	    SSRA  => '0',
	    SSRB  => '0',
	    WEA   => we_mem00,				-- Port Write Enable Input
	    WEB   => '0'
	);
	-- End of MEM00_RAMB02 instantiation
	
	-- MEM00_RAMB03 instantiation
	MEM00_RAMB03 : RAMB16_S18_S18
	port map (
		DOA   => open,
	    DOB   => do_mem00(15 downto 0),	-- Port 16-bit Data Output
	    DOPA  => open,
	    DOPB  => open,
	    ADDRA => addrw,					-- Port 10-bit Address Input to Write
	    ADDRB => addre,					-- Port 10-bit Address Input to Read
	    CLKA  => clka, 					-- Port A Clock
	    CLKB  => clkb, 					-- Port B Clock
	    DIA   => din(15 downto 0),		-- Port 16-bit Data Input
	    DIB   => (others => '0'),
	    DIPA  => (others => '0'),
	    DIPB  => (others => '0'),
	    ENA   => '1',
	    ENB   => '1',
	    SSRA  => '0',
	    SSRB  => '0',
	    WEA   => we_mem00,				-- Port Write Enable Input
	    WEB   => '0'
	);
	-- End of MEM00_RAMB03 instantiation
	
	-- MEM01_RAMB00 instantiation
	MEM01_RAMB00 : RAMB16_S18_S18
	port map (
		DOA   => open,
	    DOB   => do_mem01(63 downto 48),-- Port 16-bit Data Output
	    DOPA  => open,
	    DOPB  => open,
	    ADDRA => addrw,					-- Port 10-bit Address Input to Write
	    ADDRB => addre,					-- Port 10-bit Address Input to Read
	    CLKA  => clka, 					-- Port A Clock
	    CLKB  => clkb, 					-- Port B Clock
	    DIA   => din(63 downto 48),		-- Port 16-bit Data Input
	    DIB   => (others => '0'),
	    DIPA  => (others => '0'),
	    DIPB  => (others => '0'),
	    ENA   => '1',
	    ENB   => '1',
	    SSRA  => '0',
	    SSRB  => '0',
	    WEA   => we_mem01,				-- Port Write Enable Input
	    WEB   => '0'
	);
	-- End of MEM01_RAMB00 instantiation
	
	-- MEM01_RAMB01 instantiation
	MEM01_RAMB01 : RAMB16_S18_S18
	port map (
		DOA   => open,
	    DOB   => do_mem01(47 downto 32),-- Port 16-bit Data Output
	    DOPA  => open,
	    DOPB  => open,
	    ADDRA => addrw,					-- Port 10-bit Address Input to Write
	    ADDRB => addre,					-- Port 10-bit Address Input to Read
	    CLKA  => clka, 					-- Port A Clock
	    CLKB  => clkb, 					-- Port B Clock
	    DIA   => din(47 downto 32),		-- Port 16-bit Data Input
	    DIB   => (others => '0'),
	    DIPA  => (others => '0'),
	    DIPB  => (others => '0'),
	    ENA   => '1',
	    ENB   => '1',
	    SSRA  => '0',
	    SSRB  => '0',
	    WEA   => we_mem01,				-- Port Write Enable Input
	    WEB   => '0'
	);
	-- End of MEM01_RAMB01 instantiation
	
	-- MEM01_RAMB02 instantiation
	MEM01_RAMB02 : RAMB16_S18_S18
	port map (
		DOA   => open,
	    DOB   => do_mem01(31 downto 16),-- Port 16-bit Data Output
	    DOPA  => open,
	    DOPB  => open,
	    ADDRA => addrw,					-- Port 10-bit Address Input to Write
	    ADDRB => addre,					-- Port 10-bit Address Input to Read
	    CLKA  => clka, 					-- Port A Clock
	    CLKB  => clkb, 					-- Port B Clock
	    DIA   => din(31 downto 16),		-- Port 16-bit Data Input
	    DIB   => (others => '0'),
	    DIPA  => (others => '0'),
	    DIPB  => (others => '0'),
	    ENA   => '1',
	    ENB   => '1',
	    SSRA  => '0',
	    SSRB  => '0',
	    WEA   => we_mem01,				-- Port Write Enable Input
	    WEB   => '0'
	);
	-- End of MEM01_RAMB02 instantiation
	
	-- MEM01_RAMB03 instantiation
	MEM01_RAMB03 : RAMB16_S18_S18
	port map (
		DOA   => open,
	    DOB   => do_mem01(15 downto 0), -- Port 16-bit Data Output
	    DOPA  => open,
	    DOPB  => open,
	    ADDRA => addrw,					-- Port 10-bit Address Input to Write
	    ADDRB => addre,					-- Port 10-bit Address Input to Read
	    CLKA  => clka, 					-- Port A Clock
	    CLKB  => clkb, 					-- Port B Clock
	    DIA   => din(15 downto 0),		-- Port 16-bit Data Input
	    DIB   => (others => '0'),
	    DIPA  => (others => '0'),
	    DIPB  => (others => '0'),
	    ENA   => '1',
	    ENB   => '1',
	    SSRA  => '0',
	    SSRB  => '0',
	    WEA   => we_mem01,				-- Port Write Enable Input
	    WEB   => '0'
	);
	-- End of MEM01_RAMB03 instantiation
	
	-- MEM02_RAMB00 instantiation
	MEM02_RAMB00 : RAMB16_S18_S18
	port map (
		DOA   => open,
	    DOB   => do_mem02(63 downto 48),-- Port 16-bit Data Output
	    DOPA  => open,
	    DOPB  => open,
	    ADDRA => addrw,					-- Port 10-bit Address Input to Write
	    ADDRB => addre,					-- Port 10-bit Address Input to Read
	    CLKA  => clka, 					-- Port A Clock
	    CLKB  => clkb, 					-- Port B Clock
	    DIA   => din(63 downto 48),		-- Port 16-bit Data Input
	    DIB   => (others => '0'),
	    DIPA  => (others => '0'),
	    DIPB  => (others => '0'),
	    ENA   => '1',
	    ENB   => '1',
	    SSRA  => '0',
	    SSRB  => '0',
	    WEA   => we_mem02,				-- Port Write Enable Input
	    WEB   => '0'
	);
	-- End of MEM02_RAMB00 instantiation
	
	-- MEM02_RAMB01 instantiation
	MEM02_RAMB01 : RAMB16_S18_S18
	port map (
		DOA   => open,
	    DOB   => do_mem02(47 downto 32),-- Port 16-bit Data Output
	    DOPA  => open,
	    DOPB  => open,
	    ADDRA => addrw,					-- Port 10-bit Address Input to Write
	    ADDRB => addre,					-- Port 10-bit Address Input to Read
	    CLKA  => clka, 					-- Port A Clock
	    CLKB  => clkb, 					-- Port B Clock
	    DIA   => din(47 downto 32),		-- Port 16-bit Data Input
	    DIB   => (others => '0'),
	    DIPA  => (others => '0'),
	    DIPB  => (others => '0'),
	    ENA   => '1',
	    ENB   => '1',
	    SSRA  => '0',
	    SSRB  => '0',
	    WEA   => we_mem02,				-- Port Write Enable Input
	    WEB   => '0'
	);
	-- End of MEM02_RAMB01 instantiation
	
	-- MEM02_RAMB02 instantiation
	MEM02_RAMB02 : RAMB16_S18_S18
	port map (
		DOA   => open,
	    DOB   => do_mem02(31 downto 16),-- Port 16-bit Data Output
	    DOPA  => open,
	    DOPB  => open,
	    ADDRA => addrw,					-- Port 10-bit Address Input to Write
	    ADDRB => addre,					-- Port 10-bit Address Input to Read
	    CLKA  => clka, 					-- Port A Clock
	    CLKB  => clkb, 					-- Port B Clock
	    DIA   => din(31 downto 16),		-- Port 16-bit Data Input
	    DIB   => (others => '0'),
	    DIPA  => (others => '0'),
	    DIPB  => (others => '0'),
	    ENA   => '1',
	    ENB   => '1',
	    SSRA  => '0',
	    SSRB  => '0',
	    WEA   => we_mem02,				-- Port Write Enable Input
	    WEB   => '0'
	);
	-- End of MEM02_RAMB02 instantiation
	
	-- MEM02_RAMB03 instantiation
	MEM02_RAMB03 : RAMB16_S18_S18
	port map (
		DOA   => open,
	    DOB   => do_mem02(15 downto 0), -- Port 16-bit Data Output
	    DOPA  => open,
	    DOPB  => open,
	    ADDRA => addrw,					-- Port 10-bit Address Input to Write
	    ADDRB => addre,					-- Port 10-bit Address Input to Read
	    CLKA  => clka, 					-- Port A Clock
	    CLKB  => clkb, 					-- Port B Clock
	    DIA   => din(15 downto 0),		-- Port 16-bit Data Input
	    DIB   => (others => '0'),
	    DIPA  => (others => '0'),
	    DIPB  => (others => '0'),
	    ENA   => '1',
	    ENB   => '1',
	    SSRA  => '0',
	    SSRB  => '0',
	    WEA   => we_mem02,				-- Port Write Enable Input
	    WEB   => '0'
	);
	-- End of MEM02_RAMB03 instantiation
	
	-- MEM03_RAMB00 instantiation
	MEM03_RAMB00 : RAMB16_S18_S18
	port map (
		DOA   => open,
	    DOB   => do_mem03(63 downto 48),-- Port 16-bit Data Output
	    DOPA  => open,
	    DOPB  => open,
	    ADDRA => addrw,					-- Port 10-bit Address Input to Write
	    ADDRB => addre,					-- Port 10-bit Address Input to Read
	    CLKA  => clka, 					-- Port A Clock
	    CLKB  => clkb, 					-- Port B Clock
	    DIA   => din(63 downto 48),		-- Port 16-bit Data Input
	    DIB   => (others => '0'),
	    DIPA  => (others => '0'),
	    DIPB  => (others => '0'),
	    ENA   => '1',
	    ENB   => '1',
	    SSRA  => '0',
	    SSRB  => '0',
	    WEA   => we_mem03,				-- Port Write Enable Input
	    WEB   => '0'
	);
	-- End of MEM03_RAMB00 instantiation
	
	-- MEM03_RAMB01 instantiation
	MEM03_RAMB01 : RAMB16_S18_S18
	port map (
		DOA   => open,
	    DOB   => do_mem03(47 downto 32),-- Port 16-bit Data Output
	    DOPA  => open,
	    DOPB  => open,
	    ADDRA => addrw,					-- Port 10-bit Address Input to Write
	    ADDRB => addre,					-- Port 10-bit Address Input to Read
	    CLKA  => clka, 					-- Port A Clock
	    CLKB  => clkb, 					-- Port B Clock
	    DIA   => din(47 downto 32),		-- Port 16-bit Data Input
	    DIB   => (others => '0'),
	    DIPA  => (others => '0'),
	    DIPB  => (others => '0'),
	    ENA   => '1',
	    ENB   => '1',
	    SSRA  => '0',
	    SSRB  => '0',
	    WEA   => we_mem03,				-- Port Write Enable Input
	    WEB   => '0'
	);
	-- End of MEM03_RAMB01 instantiation
	
	-- MEM03_RAMB02 instantiation
	MEM03_RAMB02 : RAMB16_S18_S18
	port map (
		DOA   => open,
	    DOB   => do_mem03(31 downto 16),-- Port 16-bit Data Output
	    DOPA  => open,
	    DOPB  => open,
	    ADDRA => addrw,					-- Port 10-bit Address Input to Write
	    ADDRB => addre,					-- Port 10-bit Address Input to Read
	    CLKA  => clka, 					-- Port A Clock
	    CLKB  => clkb, 					-- Port B Clock
	    DIA   => din(31 downto 16),		-- Port 16-bit Data Input
	    DIB   => (others => '0'),
	    DIPA  => (others => '0'),
	    DIPB  => (others => '0'),
	    ENA   => '1',
	    ENB   => '1',
	    SSRA  => '0',
	    SSRB  => '0',
	    WEA   => we_mem03,				-- Port Write Enable Input
	    WEB   => '0'
	);
	-- End of MEM03_RAMB02 instantiation
	
	-- MEM03_RAMB03 instantiation
	MEM03_RAMB03 : RAMB16_S18_S18
	port map (
		DOA   => open,
	    DOB   => do_mem03(15 downto 0),	-- Port 16-bit Data Output
	    DOPA  => open,
	    DOPB  => open,
	    ADDRA => addrw,					-- Port 10-bit Address Input to Write
	    ADDRB => addre,					-- Port 10-bit Address Input to Read
	    CLKA  => clka, 					-- Port A Clock
	    CLKB  => clkb, 					-- Port B Clock
	    DIA   => din(15 downto 0),		-- Port 16-bit Data Input
	    DIB   => (others => '0'),
	    DIPA  => (others => '0'),
	    DIPB  => (others => '0'),
	    ENA   => '1',
	    ENB   => '1',
	    SSRA  => '0',
	    SSRB  => '0',
	    WEA   => we_mem03,				-- Port Write Enable Input
	    WEB   => '0'
	);
	-- End of MEM03_RAMB03 instantiation
	
	-- MEM04_RAMB00 instantiation
	MEM04_RAMB00 : RAMB16_S18_S18
	port map (
		DOA   => open,
	    DOB   => do_mem04(63 downto 48),-- Port 16-bit Data Output
	    DOPA  => open,
	    DOPB  => open,
	    ADDRA => addrw,					-- Port 10-bit Address Input to Write
	    ADDRB => addre,					-- Port 10-bit Address Input to Read
	    CLKA  => clka, 					-- Port A Clock
	    CLKB  => clkb, 					-- Port B Clock
	    DIA   => din(63 downto 48),		-- Port 16-bit Data Input
	    DIB   => (others => '0'),
	    DIPA  => (others => '0'),
	    DIPB  => (others => '0'),
	    ENA   => '1',
	    ENB   => '1',
	    SSRA  => '0',
	    SSRB  => '0',
	    WEA   => we_mem04,				-- Port Write Enable Input
	    WEB   => '0'
	);
	-- End of MEM04_RAMB00 instantiation
	
	-- MEM04_RAMB01 instantiation
	MEM04_RAMB01 : RAMB16_S18_S18
	port map (
		DOA   => open,
	    DOB   => do_mem04(47 downto 32),-- Port 16-bit Data Output
	    DOPA  => open,
	    DOPB  => open,
	    ADDRA => addrw,					-- Port 10-bit Address Input to Write
	    ADDRB => addre,					-- Port 10-bit Address Input to Read
	    CLKA  => clka, 					-- Port A Clock
	    CLKB  => clkb, 					-- Port B Clock
	    DIA   => din(47 downto 32),		-- Port 16-bit Data Input
	    DIB   => (others => '0'),
	    DIPA  => (others => '0'),
	    DIPB  => (others => '0'),
	    ENA   => '1',
	    ENB   => '1',
	    SSRA  => '0',
	    SSRB  => '0',
	    WEA   => we_mem04,				-- Port Write Enable Input
	    WEB   => '0'
	);
	-- End of MEM04_RAMB01 instantiation
	
	-- MEM04_RAMB02 instantiation
	MEM04_RAMB02 : RAMB16_S18_S18
	port map (
		DOA   => open,
	    DOB   => do_mem04(31 downto 16),-- Port 16-bit Data Output
	    DOPA  => open,
	    DOPB  => open,
	    ADDRA => addrw,					-- Port 10-bit Address Input to Write
	    ADDRB => addre,					-- Port 10-bit Address Input to Read
	    CLKA  => clka, 					-- Port A Clock
	    CLKB  => clkb, 					-- Port B Clock
	    DIA   => din(31 downto 16),		-- Port 16-bit Data Input
	    DIB   => (others => '0'),
	    DIPA  => (others => '0'),
	    DIPB  => (others => '0'),
	    ENA   => '1',
	    ENB   => '1',
	    SSRA  => '0',
	    SSRB  => '0',
	    WEA   => we_mem04,				-- Port Write Enable Input
	    WEB   => '0'
	);
	-- End of MEM04_RAMB02 instantiation
	
	-- MEM04_RAMB03 instantiation
	MEM04_RAMB03 : RAMB16_S18_S18
	port map (
		DOA   => open,
	    DOB   => do_mem04(15 downto 0),	-- Port 16-bit Data Output
	    DOPA  => open,
	    DOPB  => open,
	    ADDRA => addrw,					-- Port 10-bit Address Input to Write
	    ADDRB => addre,					-- Port 10-bit Address Input to Read
	    CLKA  => clka, 					-- Port A Clock
	    CLKB  => clkb, 					-- Port B Clock
	    DIA   => din(15 downto 0),		-- Port 16-bit Data Input
	    DIB   => (others => '0'),
	    DIPA  => (others => '0'),
	    DIPB  => (others => '0'),
	    ENA   => '1',
	    ENB   => '1',
	    SSRA  => '0',
	    SSRB  => '0',
	    WEA   => we_mem04,				-- Port Write Enable Input
	    WEB   => '0'
	);
	-- End of MEM04_RAMB03 instantiation
	
	-- MEM05_RAMB00 instantiation
	MEM05_RAMB00 : RAMB16_S18_S18
	port map (
		DOA   => open,
	    DOB   => do_mem05(63 downto 48),-- Port 16-bit Data Output
	    DOPA  => open,
	    DOPB  => open,
	    ADDRA => addrw,					-- Port 10-bit Address Input to Write
	    ADDRB => addre,					-- Port 10-bit Address Input to Read
	    CLKA  => clka, 					-- Port A Clock
	    CLKB  => clkb, 					-- Port B Clock
	    DIA   => din(63 downto 48),		-- Port 16-bit Data Input
	    DIB   => (others => '0'),
	    DIPA  => (others => '0'),
	    DIPB  => (others => '0'),
	    ENA   => '1',
	    ENB   => '1',
	    SSRA  => '0',
	    SSRB  => '0',
	    WEA   => we_mem05,				-- Port Write Enable Input
	    WEB   => '0'
	);
	-- End of MEM05_RAMB00 instantiation
	
	-- MEM05_RAMB01 instantiation
	MEM05_RAMB01 : RAMB16_S18_S18
	port map (
		DOA   => open,
	    DOB   => do_mem05(47 downto 32),-- Port 16-bit Data Output
	    DOPA  => open,
	    DOPB  => open,
	    ADDRA => addrw,					-- Port 10-bit Address Input to Write
	    ADDRB => addre,					-- Port 10-bit Address Input to Read
	    CLKA  => clka, 					-- Port A Clock
	    CLKB  => clkb, 					-- Port B Clock
	    DIA   => din(47 downto 32),		-- Port 16-bit Data Input
	    DIB   => (others => '0'),
	    DIPA  => (others => '0'),
	    DIPB  => (others => '0'),
	    ENA   => '1',
	    ENB   => '1',
	    SSRA  => '0',
	    SSRB  => '0',
	    WEA   => we_mem05,				-- Port Write Enable Input
	    WEB   => '0'
	);
	-- End of MEM05_RAMB01 instantiation
	
	-- MEM05_RAMB02 instantiation
	MEM05_RAMB02 : RAMB16_S18_S18
	port map (
		DOA   => open,
	    DOB   => do_mem05(31 downto 16),-- Port 16-bit Data Output
	    DOPA  => open,
	    DOPB  => open,
	    ADDRA => addrw,					-- Port 10-bit Address Input to Write
	    ADDRB => addre,					-- Port 10-bit Address Input to Read
	    CLKA  => clka, 					-- Port A Clock
	    CLKB  => clkb, 					-- Port B Clock
	    DIA   => din(31 downto 16),		-- Port 16-bit Data Input
	    DIB   => (others => '0'),
	    DIPA  => (others => '0'),
	    DIPB  => (others => '0'),
	    ENA   => '1',
	    ENB   => '1',
	    SSRA  => '0',
	    SSRB  => '0',
	    WEA   => we_mem05,				-- Port Write Enable Input
	    WEB   => '0'
	);
	-- End of MEM05_RAMB02 instantiation
	
	-- MEM05_RAMB03 instantiation
	MEM05_RAMB03 : RAMB16_S18_S18
	port map (
		DOA   => open,
	    DOB   => do_mem05(15 downto 0), -- Port 16-bit Data Output
	    DOPA  => open,
	    DOPB  => open,
	    ADDRA => addrw,					-- Port 10-bit Address Input to Write
	    ADDRB => addre,					-- Port 10-bit Address Input to Read
	    CLKA  => clka, 					-- Port A Clock
	    CLKB  => clkb, 					-- Port B Clock
	    DIA   => din(15 downto 0),		-- Port 16-bit Data Input
	    DIB   => (others => '0'),
	    DIPA  => (others => '0'),
	    DIPB  => (others => '0'),
	    ENA   => '1',
	    ENB   => '1',
	    SSRA  => '0',
	    SSRB  => '0',
	    WEA   => we_mem05,				-- Port Write Enable Input
	    WEB   => '0'
	);
	-- End of MEM05_RAMB03 instantiation
	
	-- MEM06_RAMB00 instantiation
	MEM06_RAMB00 : RAMB16_S18_S18
	port map (
		DOA   => open,
	    DOB   => do_mem06(63 downto 48),-- Port 16-bit Data Output
	    DOPA  => open,
	    DOPB  => open,
	    ADDRA => addrw,					-- Port 10-bit Address Input to Write
	    ADDRB => addre,					-- Port 10-bit Address Input to Read
	    CLKA  => clka, 					-- Port A Clock
	    CLKB  => clkb, 					-- Port B Clock
	    DIA   => din(63 downto 48),		-- Port 16-bit Data Input
	    DIB   => (others => '0'),
	    DIPA  => (others => '0'),
	    DIPB  => (others => '0'),
	    ENA   => '1',
	    ENB   => '1',
	    SSRA  => '0',
	    SSRB  => '0',
	    WEA   => we_mem06,				-- Port Write Enable Input
	    WEB   => '0'
	);
	-- End of MEM06_RAMB00 instantiation
	
	-- MEM06_RAMB01 instantiation
	MEM06_RAMB01 : RAMB16_S18_S18
	port map (
		DOA   => open,
	    DOB   => do_mem06(47 downto 32), -- Port 16-bit Data Output
	    DOPA  => open,
	    DOPB  => open,
	    ADDRA => addrw,					-- Port 10-bit Address Input to Write
	    ADDRB => addre,					-- Port 10-bit Address Input to Read
	    CLKA  => clka, 					-- Port A Clock
	    CLKB  => clkb, 					-- Port B Clock
	    DIA   => din(47 downto 32),		-- Port 16-bit Data Input
	    DIB   => (others => '0'),
	    DIPA  => (others => '0'),
	    DIPB  => (others => '0'),
	    ENA   => '1',
	    ENB   => '1',
	    SSRA  => '0',
	    SSRB  => '0',
	    WEA   => we_mem06,				-- Port Write Enable Input
	    WEB   => '0'
	);
	-- End of MEM06_RAMB01 instantiation
	
	-- MEM06_RAMB02 instantiation
	MEM06_RAMB02 : RAMB16_S18_S18
	port map (
		DOA   => open,
	    DOB   => do_mem06(31 downto 16),-- Port 16-bit Data Output
	    DOPA  => open,
	    DOPB  => open,
	    ADDRA => addrw,					-- Port 10-bit Address Input to Write
	    ADDRB => addre,					-- Port 10-bit Address Input to Read
	    CLKA  => clka, 					-- Port A Clock
	    CLKB  => clkb, 					-- Port B Clock
	    DIA   => din(31 downto 16),		-- Port 16-bit Data Input
	    DIB   => (others => '0'),
	    DIPA  => (others => '0'),
	    DIPB  => (others => '0'),
	    ENA   => '1',
	    ENB   => '1',
	    SSRA  => '0',
	    SSRB  => '0',
	    WEA   => we_mem06,				-- Port Write Enable Input
	    WEB   => '0'
	);
	-- End of MEM06_RAMB02 instantiation
	
	-- MEM06_RAMB03 instantiation
	MEM06_RAMB03 : RAMB16_S18_S18
	port map (
		DOA   => open,
	    DOB   => do_mem06(15 downto 0), -- Port 16-bit Data Output
	    DOPA  => open,
	    DOPB  => open,
	    ADDRA => addrw,					-- Port 10-bit Address Input to Write
	    ADDRB => addre,					-- Port 10-bit Address Input to Read
	    CLKA  => clka, 					-- Port A Clock
	    CLKB  => clkb, 					-- Port B Clock
	    DIA   => din(15 downto 0),		-- Port 16-bit Data Input
	    DIB   => (others => '0'),
	    DIPA  => (others => '0'),
	    DIPB  => (others => '0'),
	    ENA   => '1',
	    ENB   => '1',
	    SSRA  => '0',
	    SSRB  => '0',
	    WEA   => we_mem06,				-- Port Write Enable Input
	    WEB   => '0'
	);
	-- End of MEM06_RAMB03 instantiation
	
	-- MEM07_RAMB00 instantiation
	MEM07_RAMB00 : RAMB16_S18_S18
	port map (
		DOA   => open,
	    DOB   => do_mem07(63 downto 48),-- Port 16-bit Data Output
	    DOPA  => open,
	    DOPB  => open,
	    ADDRA => addrw,					-- Port 10-bit Address Input to Write
	    ADDRB => addre,					-- Port 10-bit Address Input to Read
	    CLKA  => clka, 					-- Port A Clock
	    CLKB  => clkb, 					-- Port B Clock
	    DIA   => din(63 downto 48),		-- Port 16-bit Data Input
	    DIB   => (others => '0'),
	    DIPA  => (others => '0'),
	    DIPB  => (others => '0'),
	    ENA   => '1',
	    ENB   => '1',
	    SSRA  => '0',
	    SSRB  => '0',
	    WEA   => we_mem07,				-- Port Write Enable Input
	    WEB   => '0'
	);
	-- End of MEM07_RAMB00 instantiation
	
	-- MEM07_RAMB01 instantiation
	MEM07_RAMB01 : RAMB16_S18_S18
	port map (
		DOA   => open,
	    DOB   => do_mem07(47 downto 32),-- Port 16-bit Data Output
	    DOPA  => open,
	    DOPB  => open,
	    ADDRA => addrw,					-- Port 10-bit Address Input to Write
	    ADDRB => addre,					-- Port 10-bit Address Input to Read
	    CLKA  => clka, 					-- Port A Clock
	    CLKB  => clkb, 					-- Port B Clock
	    DIA   => din(47 downto 32),		-- Port 16-bit Data Input
	    DIB   => (others => '0'),
	    DIPA  => (others => '0'),
	    DIPB  => (others => '0'),
	    ENA   => '1',
	    ENB   => '1',
	    SSRA  => '0',
	    SSRB  => '0',
	    WEA   => we_mem07,				-- Port Write Enable Input
	    WEB   => '0'
	);
	-- End of MEM07_RAMB01 instantiation
	
	-- MEM07_RAMB02 instantiation
	MEM07_RAMB02 : RAMB16_S18_S18
	port map (
		DOA   => open,
	    DOB   => do_mem07(31 downto 16),-- Port 16-bit Data Output
	    DOPA  => open,
	    DOPB  => open,
	    ADDRA => addrw,					-- Port 10-bit Address Input to Write
	    ADDRB => addre,					-- Port 10-bit Address Input to Read
	    CLKA  => clka, 					-- Port A Clock
	    CLKB  => clkb, 					-- Port B Clock
	    DIA   => din(31 downto 16),		-- Port 16-bit Data Input
	    DIB   => (others => '0'),
	    DIPA  => (others => '0'),
	    DIPB  => (others => '0'),
	    ENA   => '1',
	    ENB   => '1',
	    SSRA  => '0',
	    SSRB  => '0',
	    WEA   => we_mem07,				-- Port Write Enable Input
	    WEB   => '0'
	);
	-- End of MEM07_RAMB02 instantiation
	
	-- MEM07_RAMB03 instantiation
	MEM07_RAMB03 : RAMB16_S18_S18
	port map (
		DOA   => open,
	    DOB   => do_mem07(15 downto 0), -- Port 16-bit Data Output
	    DOPA  => open,
	    DOPB  => open,
	    ADDRA => addrw,					-- Port 10-bit Address Input to Write
	    ADDRB => addre,					-- Port 10-bit Address Input to Read
	    CLKA  => clka, 					-- Port A Clock
	    CLKB  => clkb, 					-- Port B Clock
	    DIA   => din(15 downto 0),		-- Port 16-bit Data Input
	    DIB   => (others => '0'),
	    DIPA  => (others => '0'),
	    DIPB  => (others => '0'),
	    ENA   => '1',
	    ENB   => '1',
	    SSRA  => '0',
	    SSRB  => '0',
	    WEA   => we_mem07,				-- Port Write Enable Input
	    WEB   => '0'
	);
	-- End of MEM07_RAMB03 instantiation
	
	-- MEM08_RAMB00 instantiation
	MEM08_RAMB00 : RAMB16_S18_S18
	port map (
		DOA   => open,
	    DOB   => do_mem08(63 downto 48),-- Port 16-bit Data Output
	    DOPA  => open,
	    DOPB  => open,
	    ADDRA => addrw,					-- Port 10-bit Address Input to Write
	    ADDRB => addre,					-- Port 10-bit Address Input to Read
	    CLKA  => clka, 					-- Port A Clock
	    CLKB  => clkb, 					-- Port B Clock
	    DIA   => din(63 downto 48),		-- Port 16-bit Data Input
	    DIB   => (others => '0'),
	    DIPA  => (others => '0'),
	    DIPB  => (others => '0'),
	    ENA   => '1',
	    ENB   => '1',
	    SSRA  => '0',
	    SSRB  => '0',
	    WEA   => we_mem08,				-- Port Write Enable Input
	    WEB   => '0'
	);
	-- End of MEM08_RAMB00 instantiation
	
	-- MEM08_RAMB01 instantiation
	MEM08_RAMB01 : RAMB16_S18_S18
	port map (
		DOA   => open,
	    DOB   => do_mem08(47 downto 32),-- Port 16-bit Data Output
	    DOPA  => open,
	    DOPB  => open,
	    ADDRA => addrw,					-- Port 10-bit Address Input to Write
	    ADDRB => addre,					-- Port 10-bit Address Input to Read
	    CLKA  => clka, 					-- Port A Clock
	    CLKB  => clkb, 					-- Port B Clock
	    DIA   => din(47 downto 32),		-- Port 16-bit Data Input
	    DIB   => (others => '0'),
	    DIPA  => (others => '0'),
	    DIPB  => (others => '0'),
	    ENA   => '1',
	    ENB   => '1',
	    SSRA  => '0',
	    SSRB  => '0',
	    WEA   => we_mem08,				-- Port Write Enable Input
	    WEB   => '0'
	);
	-- End of MEM08_RAMB01 instantiation
	
	-- MEM08_RAMB02 instantiation
	MEM08_RAMB02 : RAMB16_S18_S18
	port map (
		DOA   => open,
	    DOB   => do_mem08(31 downto 16),-- Port 16-bit Data Output
	    DOPA  => open,
	    DOPB  => open,
	    ADDRA => addrw,					-- Port 10-bit Address Input to Write
	    ADDRB => addre,					-- Port 10-bit Address Input to Read
	    CLKA  => clka, 					-- Port A Clock
	    CLKB  => clkb, 					-- Port B Clock
	    DIA   => din(31 downto 16),		-- Port 16-bit Data Input
	    DIB   => (others => '0'),
	    DIPA  => (others => '0'),
	    DIPB  => (others => '0'),
	    ENA   => '1',
	    ENB   => '1',
	    SSRA  => '0',
	    SSRB  => '0',
	    WEA   => we_mem08,				-- Port Write Enable Input
	    WEB   => '0'
	);
	-- End of MEM08_RAMB02 instantiation
	
	-- MEM08_RAMB03 instantiation
	MEM08_RAMB03 : RAMB16_S18_S18
	port map (
		DOA   => open,
	    DOB   => do_mem08(15 downto 0), -- Port 16-bit Data Output
	    DOPA  => open,
	    DOPB  => open,
	    ADDRA => addrw,					-- Port 10-bit Address Input to Write
	    ADDRB => addre,					-- Port 10-bit Address Input to Read
	    CLKA  => clka, 					-- Port A Clock
	    CLKB  => clkb, 					-- Port B Clock
	    DIA   => din(15 downto 0),		-- Port 16-bit Data Input
	    DIB   => (others => '0'),
	    DIPA  => (others => '0'),
	    DIPB  => (others => '0'),
	    ENA   => '1',
	    ENB   => '1',
	    SSRA  => '0',
	    SSRB  => '0',
	    WEA   => we_mem08,				-- Port Write Enable Input
	    WEB   => '0'
	);
	-- End of MEM08_RAMB03 instantiation
	
	-- MEM09_RAMB00 instantiation
	MEM09_RAMB00 : RAMB16_S18_S18
	port map (
		DOA   => open,
	    DOB   => do_mem09(63 downto 48),-- Port 16-bit Data Output
	    DOPA  => open,
	    DOPB  => open,
	    ADDRA => addrw,					-- Port 10-bit Address Input to Write
	    ADDRB => addre,					-- Port 10-bit Address Input to Read
	    CLKA  => clka, 					-- Port A Clock
	    CLKB  => clkb, 					-- Port B Clock
	    DIA   => din(63 downto 48),		-- Port 16-bit Data Input
	    DIB   => (others => '0'),
	    DIPA  => (others => '0'),
	    DIPB  => (others => '0'),
	    ENA   => '1',
	    ENB   => '1',
	    SSRA  => '0',
	    SSRB  => '0',
	    WEA   => we_mem09,				-- Port Write Enable Input
	    WEB   => '0'
	);
	-- End of MEM09_RAMB00 instantiation
	
	-- MEM09_RAMB01 instantiation
	MEM09_RAMB01 : RAMB16_S18_S18
	port map (
		DOA   => open,
	    DOB   => do_mem09(47 downto 32),-- Port 16-bit Data Output
	    DOPA  => open,
	    DOPB  => open,
	    ADDRA => addrw,					-- Port 10-bit Address Input to Write
	    ADDRB => addre,					-- Port 10-bit Address Input to Read
	    CLKA  => clka, 					-- Port A Clock
	    CLKB  => clkb, 					-- Port B Clock
	    DIA   => din(47 downto 32),		-- Port 16-bit Data Input
	    DIB   => (others => '0'),
	    DIPA  => (others => '0'),
	    DIPB  => (others => '0'),
	    ENA   => '1',
	    ENB   => '1',
	    SSRA  => '0',
	    SSRB  => '0',
	    WEA   => we_mem09,				-- Port Write Enable Input
	    WEB   => '0'
	);
	-- End of MEM09_RAMB01 instantiation
	
	-- MEM09_RAMB02 instantiation
	MEM09_RAMB02 : RAMB16_S18_S18
	port map (
		DOA   => open,
	    DOB   => do_mem09(31 downto 16),-- Port 16-bit Data Output
	    DOPA  => open,
	    DOPB  => open,
	    ADDRA => addrw,					-- Port 10-bit Address Input to Write
	    ADDRB => addre,					-- Port 10-bit Address Input to Read
	    CLKA  => clka, 					-- Port A Clock
	    CLKB  => clkb, 					-- Port B Clock
	    DIA   => din(31 downto 16),		-- Port 16-bit Data Input
	    DIB   => (others => '0'),
	    DIPA  => (others => '0'),
	    DIPB  => (others => '0'),
	    ENA   => '1',
	    ENB   => '1',
	    SSRA  => '0',
	    SSRB  => '0',
	    WEA   => we_mem09,				-- Port Write Enable Input
	    WEB   => '0'
	);
	-- End of MEM09_RAMB02 instantiation
	
	-- MEM09_RAMB03 instantiation
	MEM09_RAMB03 : RAMB16_S18_S18
	port map (
		DOA   => open,
	    DOB   => do_mem09(15 downto 0),	-- Port 16-bit Data Output
	    DOPA  => open,
	    DOPB  => open,
	    ADDRA => addrw,					-- Port 10-bit Address Input to Write
	    ADDRB => addre,					-- Port 10-bit Address Input to Read
	    CLKA  => clka, 					-- Port A Clock
	    CLKB  => clkb, 					-- Port B Clock
	    DIA   => din(15 downto 0),		-- Port 16-bit Data Input
	    DIB   => (others => '0'),
	    DIPA  => (others => '0'),
	    DIPB  => (others => '0'),
	    ENA   => '1',
	    ENB   => '1',
	    SSRA  => '0',
	    SSRB  => '0',
	    WEA   => we_mem09,				-- Port Write Enable Input
	    WEB   => '0'
	);
	-- End of MEM09_RAMB03 instantiation

end frameshandler;