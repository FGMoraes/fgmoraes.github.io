--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--	Grupo de Apoio ao Projeto de Hardware  - GAPH
--	Projeto X10GiGA - FINEP/PUCRS/TERACOM
-- 
--	Módulo:	Memoria - Gerador de Frames - Prototipação
--	Autor:	Jeferson Camargo de Oliveira
--
--	Módulo gerado em 17 de July de 2008 às 21h03min pelo
--	pelo programa gerador de frames OTN do projeto X10GiGA.
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity geraframes is
port(
	clk, rst	: in  std_logic;
	saida		: out std_logic_vector(63 downto 0)
);
end entity;

architecture geraframes of geraframes is
	signal counter		: std_logic_vector(10 downto 0);
	signal counter_ram	: std_logic_vector(7  downto 0);
	signal address		: std_logic_vector(9  downto 0);
	signal conjunto		: std_logic;
	signal start		: std_logic;
	signal saida_a_000	: std_logic_vector(63 downto 0);
	signal saida_b_000	: std_logic_vector(63 downto 0);
	signal saida_a_001	: std_logic_vector(63 downto 0);
	signal saida_b_001	: std_logic_vector(63 downto 0);
	signal saida_a_002	: std_logic_vector(63 downto 0);
	signal saida_b_002	: std_logic_vector(63 downto 0);
	signal saida_a_003	: std_logic_vector(63 downto 0);
	signal saida_b_003	: std_logic_vector(63 downto 0);
	signal saida_a_004	: std_logic_vector(63 downto 0);
	signal saida_b_004	: std_logic_vector(63 downto 0);
begin

	process(clk, rst)
	begin
		--if rst = '1' then
		if rst = '0' then
			counter     <= "00000000001";
			counter_ram <= (others => '0');
			address     <= (others => '0');
			saida       <= (others => '0');
			start       <= '1';
			conjunto    <= '0';
		elsif clk'event and clk = '1' then
			if counter ="11111111000"then
				counter <= "00000000001";
				address <= (others => '0');
				case counter_ram is
					when x"00"	=>  saida <= saida_b_000;
					when x"01"	=>  saida <= saida_b_001;
					when x"02"	=>  saida <= saida_b_002;
					when x"03"	=>  saida <= saida_b_003;
					when x"04"	=>  saida <= saida_b_004;
					when others =>	saida <= (others => '0');
				end case;
			elsif counter = "00000000001" then
				if start = '0' then
					counter_ram <= counter_ram + 1;
					case counter_ram is
						when x"00"	=>  saida <= saida_b_000;
						when x"01"	=>  saida <= saida_b_001;
						when x"02"	=>  saida <= saida_b_002;
						when x"03"	=>  saida <= saida_b_003;
						when x"04"	=>  saida <= saida_b_004;
						when others =>	saida <= (others => '0');
					end case;
				else
					counter_ram <= (others => '0');
					saida       <= (others => '0');
				end if;
				address <= address + 1;
				counter <= counter + 1;
			elsif counter = "00000000010" then
				case counter_ram is
					when x"00"	=>  saida <= saida_a_000;
					when x"01"	=>  saida <= saida_a_001;
					when x"02"	=>  saida <= saida_a_002;
					when x"03"	=>  saida <= saida_a_003;
					when x"04"	=>  saida <= saida_a_004;
					when others =>	saida <= (others => '0');
				end case;
				conjunto<= '0';
				address <= address + 1;
				counter <= counter + 1;
			else
				if address = "1111111111" then
					start	<= '0';
					conjunto    <= '1';
					case counter_ram is
								when x"00"	=>  saida <= saida_a_000;
								when x"01"	=>  saida <= saida_a_001;
								when x"02"	=>  saida <= saida_a_002;
								when x"03"	=>  saida <= saida_a_003;
								when x"04"	=>  saida <= saida_a_004;
						when others =>	saida <= (others => '0');
					end case;
				else
					if conjunto = '0' then
						case counter_ram is
								when x"00"	=>  saida <= saida_a_000;
								when x"01"	=>  saida <= saida_a_001;
								when x"02"	=>  saida <= saida_a_002;
								when x"03"	=>  saida <= saida_a_003;
								when x"04"	=>  saida <= saida_a_004;
							when others =>	saida <= (others => '0');
						end case;
					else
						if address = "0000000000" then
							case counter_ram is
								when x"00"	=>  saida <= saida_a_000;
								when x"01"	=>  saida <= saida_a_001;
								when x"02"	=>  saida <= saida_a_002;
								when x"03"	=>  saida <= saida_a_003;
								when x"04"	=>  saida <= saida_a_004;
								when others =>	saida <= (others => '0');
							end case;
						else
							case counter_ram is
								when x"00"	=>  saida <= saida_b_000;
								when x"01"	=>  saida <= saida_b_001;
								when x"02"	=>  saida <= saida_b_002;
								when x"03"	=>  saida <= saida_b_003;
								when x"04"	=>  saida <= saida_b_004;
								when others =>	saida <= (others => '0');
							end case;
						end if;
					end if;
				end if;	
				address <= address + 1;
				counter <= counter + 1;
			end if;
		end if;
	end process;

	RAMB000_A0:  entity work.FRAME0000_A0 port map
			(
			  addr	    => address,						-- (in)
			  clk	    => clk,							-- (in)
	 	  	  dout	    => saida_a_000(63 downto 48)	-- (out)
			);
	RAMB000_B0:  entity work.FRAME0000_B0 port map
			(
			  addr	    => address,						-- (in)
			  clk	    => clk,							-- (in)
	 	  	  dout	    => saida_b_000(63 downto 48)	-- (out)
			);
	RAMB000_A1:  entity work.FRAME0000_A1 port map
			(
			  addr	    => address,						-- (in)
			  clk	    => clk,							-- (in)
	 	  	  dout	    => saida_a_000(47 downto 32)	-- (out)
			);
	RAMB000_B1:  entity work.FRAME0000_B1 port map
			(
			  addr	    => address,						-- (in)
			  clk	    => clk,							-- (in)
	 	  	  dout	    => saida_b_000(47 downto 32)	-- (out)
			);
	RAMB000_A2:  entity work.FRAME0000_A2 port map
			(
			  addr	    => address,						-- (in)
			  clk	    => clk,							-- (in)
	 	  	  dout	    => saida_a_000(31 downto 16)	-- (out)
			);
	RAMB000_B2:  entity work.FRAME0000_B2 port map
			(
			  addr	    => address,						-- (in)
			  clk	    => clk,							-- (in)
	 	  	  dout	    => saida_b_000(31 downto 16)	-- (out)
			);
	RAMB000_A3:  entity work.FRAME0000_A3 port map
			(
			  addr	    => address,						-- (in)
			  clk	    => clk,							-- (in)
	 	  	  dout	    => saida_a_000(15 downto 00)	-- (out)
			);
	RAMB000_B3:  entity work.FRAME0000_B3 port map
			(
			  addr	    => address,						-- (in)
			  clk	    => clk,							-- (in)
	 	  	  dout	    => saida_b_000(15 downto 00)	-- (out)
			);
	RAMB001_A0:  entity work.FRAME0001_A0 port map
			(
			  addr	    => address,						-- (in)
			  clk	    => clk,							-- (in)
	 	  	  dout	    => saida_a_001(63 downto 48)	-- (out)
			);
	RAMB001_B0:  entity work.FRAME0001_B0 port map
			(
			  addr	    => address,						-- (in)
			  clk	    => clk,							-- (in)
	 	  	  dout	    => saida_b_001(63 downto 48)	-- (out)
			);
	RAMB001_A1:  entity work.FRAME0001_A1 port map
			(
			  addr	    => address,						-- (in)
			  clk	    => clk,							-- (in)
	 	  	  dout	    => saida_a_001(47 downto 32)	-- (out)
			);
	RAMB001_B1:  entity work.FRAME0001_B1 port map
			(
			  addr	    => address,						-- (in)
			  clk	    => clk,							-- (in)
	 	  	  dout	    => saida_b_001(47 downto 32)	-- (out)
			);
	RAMB001_A2:  entity work.FRAME0001_A2 port map
			(
			  addr	    => address,						-- (in)
			  clk	    => clk,							-- (in)
	 	  	  dout	    => saida_a_001(31 downto 16)	-- (out)
			);
	RAMB001_B2:  entity work.FRAME0001_B2 port map
			(
			  addr	    => address,						-- (in)
			  clk	    => clk,							-- (in)
	 	  	  dout	    => saida_b_001(31 downto 16)	-- (out)
			);
	RAMB001_A3:  entity work.FRAME0001_A3 port map
			(
			  addr	    => address,						-- (in)
			  clk	    => clk,							-- (in)
	 	  	  dout	    => saida_a_001(15 downto 00)	-- (out)
			);
	RAMB001_B3:  entity work.FRAME0001_B3 port map
			(
			  addr	    => address,						-- (in)
			  clk	    => clk,							-- (in)
	 	  	  dout	    => saida_b_001(15 downto 00)	-- (out)
			);
	RAMB002_A0:  entity work.FRAME0002_A0 port map
			(
			  addr	    => address,						-- (in)
			  clk	    => clk,							-- (in)
	 	  	  dout	    => saida_a_002(63 downto 48)	-- (out)
			);
	RAMB002_B0:  entity work.FRAME0002_B0 port map
			(
			  addr	    => address,						-- (in)
			  clk	    => clk,							-- (in)
	 	  	  dout	    => saida_b_002(63 downto 48)	-- (out)
			);
	RAMB002_A1:  entity work.FRAME0002_A1 port map
			(
			  addr	    => address,						-- (in)
			  clk	    => clk,							-- (in)
	 	  	  dout	    => saida_a_002(47 downto 32)	-- (out)
			);
	RAMB002_B1:  entity work.FRAME0002_B1 port map
			(
			  addr	    => address,						-- (in)
			  clk	    => clk,							-- (in)
	 	  	  dout	    => saida_b_002(47 downto 32)	-- (out)
			);
	RAMB002_A2:  entity work.FRAME0002_A2 port map
			(
			  addr	    => address,						-- (in)
			  clk	    => clk,							-- (in)
	 	  	  dout	    => saida_a_002(31 downto 16)	-- (out)
			);
	RAMB002_B2:  entity work.FRAME0002_B2 port map
			(
			  addr	    => address,						-- (in)
			  clk	    => clk,							-- (in)
	 	  	  dout	    => saida_b_002(31 downto 16)	-- (out)
			);
	RAMB002_A3:  entity work.FRAME0002_A3 port map
			(
			  addr	    => address,						-- (in)
			  clk	    => clk,							-- (in)
	 	  	  dout	    => saida_a_002(15 downto 00)	-- (out)
			);
	RAMB002_B3:  entity work.FRAME0002_B3 port map
			(
			  addr	    => address,						-- (in)
			  clk	    => clk,							-- (in)
	 	  	  dout	    => saida_b_002(15 downto 00)	-- (out)
			);
	RAMB003_A0:  entity work.FRAME0003_A0 port map
			(
			  addr	    => address,						-- (in)
			  clk	    => clk,							-- (in)
	 	  	  dout	    => saida_a_003(63 downto 48)	-- (out)
			);
	RAMB003_B0:  entity work.FRAME0003_B0 port map
			(
			  addr	    => address,						-- (in)
			  clk	    => clk,							-- (in)
	 	  	  dout	    => saida_b_003(63 downto 48)	-- (out)
			);
	RAMB003_A1:  entity work.FRAME0003_A1 port map
			(
			  addr	    => address,						-- (in)
			  clk	    => clk,							-- (in)
	 	  	  dout	    => saida_a_003(47 downto 32)	-- (out)
			);
	RAMB003_B1:  entity work.FRAME0003_B1 port map
			(
			  addr	    => address,						-- (in)
			  clk	    => clk,							-- (in)
	 	  	  dout	    => saida_b_003(47 downto 32)	-- (out)
			);
	RAMB003_A2:  entity work.FRAME0003_A2 port map
			(
			  addr	    => address,						-- (in)
			  clk	    => clk,							-- (in)
	 	  	  dout	    => saida_a_003(31 downto 16)	-- (out)
			);
	RAMB003_B2:  entity work.FRAME0003_B2 port map
			(
			  addr	    => address,						-- (in)
			  clk	    => clk,							-- (in)
	 	  	  dout	    => saida_b_003(31 downto 16)	-- (out)
			);
	RAMB003_A3:  entity work.FRAME0003_A3 port map
			(
			  addr	    => address,						-- (in)
			  clk	    => clk,							-- (in)
	 	  	  dout	    => saida_a_003(15 downto 00)	-- (out)
			);
	RAMB003_B3:  entity work.FRAME0003_B3 port map
			(
			  addr	    => address,						-- (in)
			  clk	    => clk,							-- (in)
	 	  	  dout	    => saida_b_003(15 downto 00)	-- (out)
			);
	RAMB004_A0:  entity work.FRAME0004_A0 port map
			(
			  addr	    => address,						-- (in)
			  clk	    => clk,							-- (in)
	 	  	  dout	    => saida_a_004(63 downto 48)	-- (out)
			);
	RAMB004_B0:  entity work.FRAME0004_B0 port map
			(
			  addr	    => address,						-- (in)
			  clk	    => clk,							-- (in)
	 	  	  dout	    => saida_b_004(63 downto 48)	-- (out)
			);
	RAMB004_A1:  entity work.FRAME0004_A1 port map
			(
			  addr	    => address,						-- (in)
			  clk	    => clk,							-- (in)
	 	  	  dout	    => saida_a_004(47 downto 32)	-- (out)
			);
	RAMB004_B1:  entity work.FRAME0004_B1 port map
			(
			  addr	    => address,						-- (in)
			  clk	    => clk,							-- (in)
	 	  	  dout	    => saida_b_004(47 downto 32)	-- (out)
			);
	RAMB004_A2:  entity work.FRAME0004_A2 port map
			(
			  addr	    => address,						-- (in)
			  clk	    => clk,							-- (in)
	 	  	  dout	    => saida_a_004(31 downto 16)	-- (out)
			);
	RAMB004_B2:  entity work.FRAME0004_B2 port map
			(
			  addr	    => address,						-- (in)
			  clk	    => clk,							-- (in)
	 	  	  dout	    => saida_b_004(31 downto 16)	-- (out)
			);
	RAMB004_A3:  entity work.FRAME0004_A3 port map
			(
			  addr	    => address,						-- (in)
			  clk	    => clk,							-- (in)
	 	  	  dout	    => saida_a_004(15 downto 00)	-- (out)
			);
	RAMB004_B3:  entity work.FRAME0004_B3 port map
			(
			  addr	    => address,						-- (in)
			  clk	    => clk,							-- (in)
	 	  	  dout	    => saida_b_004(15 downto 00)	-- (out)
			);

end geraframes;