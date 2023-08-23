--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- 64-bit register  
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
library IEEE;
use IEEE.std_logic_1164.all;

entity reg64bit is
   generic( INIT_VALUE : std_logic_vector(63 downto 0) := (others=>'0') );
   
   port( clk, rst, ce   : in  std_logic;
         D     : in  std_logic_vector(63 downto 0);
         Q     : out std_logic_vector(63 downto 0)
        );
end reg64bit;

architecture reg64 of reg64bit is
   signal Din  : std_logic_vector(63 downto 0);
   signal Qout : std_logic_vector(63 downto 0);
begin
   Din <= D;
   Q   <= Qout;
   process(clk, rst)
   begin
      if rst = '0' then
        Qout <= INIT_VALUE(63 downto 0);
      elsif clk'event and clk = '1' then
         if ce = '1' then
           Qout <= Din; 
         end if;
      end if;
   end process;        
end reg64;

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- 6-bit register  
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
library IEEE;
use IEEE.std_logic_1164.all;

entity reg6bit is
   generic( INIT_VALUE : std_logic_vector(5 downto 0) := (others=>'0') );
   
   port( clk, rst, ce   : in  std_logic;
         D     : in  std_logic_vector(5 downto 0);
         Q     : out std_logic_vector(5 downto 0)
        );
end reg6bit;

architecture reg6 of reg6bit is 
   signal Din  : std_logic_vector(5 downto 0);
   signal Qout : std_logic_vector(5 downto 0);
begin
   Din <= D;
   Q   <= Qout;   
   process(clk, rst)
   begin
      if rst = '0' then
        Qout <= INIT_VALUE(5 downto 0);
      elsif clk'event and clk = '1' then
         if ce = '1' then
           Qout <= Din; 
         end if;
      end if;
   end process;        
end reg6;

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- 1-bit register  
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
library IEEE;
use IEEE.std_logic_1164.all;

entity regbit is
   generic( INIT_VALUE : std_logic := '0' );
   
   port( clk, rst, ce   : in  std_logic;
         D     : in  std_logic;
         Q     : out std_logic
        );
end regbit;

architecture reg of regbit is 
   signal Din  : std_logic;
   signal Qout : std_logic;
begin
   Din <= D;
   Q   <= Qout;   
   process(clk, rst)
   begin
      if rst = '0' then
        Qout <= INIT_VALUE;
      elsif clk'event and clk = '1' then
         if ce = '1' then
           Qout <= Din; 
         end if;
      end if;
   end process;        
end reg;

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Framer
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity framer is
port(    
	clk			: in  std_logic;
	rst			: in  std_logic;
	entrada     : in  std_logic_vector(63 downto 0);
	saida       : out std_logic_vector(63 downto 0);
	sync_o		: out std_logic;
	clear_sig   : out std_logic
);
end framer;

architecture framer of framer is
   -- Sinais de IO
   signal regout     : std_logic_vector(63 downto 0);

   -- Sinais do pipeline
   signal estagio0      : std_logic_vector(63 downto 0);
   signal estagio1      : std_logic_vector(63 downto 0);
   signal estagio2      : std_logic_vector(63 downto 0);
   signal estagio3      : std_logic_vector(63 downto 0);
   signal estagio4      : std_logic_vector(63 downto 0);
   signal estagio5      : std_logic_vector(63 downto 0);

   signal estagioCin    : std_logic_vector(63 downto 0); 
   signal estagioCout   : std_logic_vector(63 downto 0);

   signal estagioE1in   : std_logic_vector(5 downto 0);
   signal estagioE2in   : std_logic_vector(5 downto 0);
   signal estagioE3in   : std_logic_vector(5 downto 0);
   signal estagioE1out  : std_logic_vector(5 downto 0);

   signal alinhadorout  : std_logic_vector(63 downto 0);
   signal alinhador1out: std_logic_vector(63 downto 0);
   signal alinhador11out:std_logic_vector(14 downto 0);
   signal alinhador2out: std_logic_vector(63 downto 0);
   signal alinhador22out:std_logic_vector(2  downto 0);

   signal estagioF1out  : std_logic;
   signal estagioF2out  : std_logic;

   signal ce         : std_logic;
   
   -- Sinais do comparador
   signal inframe    : std_logic;
   signal fullmatch  : std_logic;
   signal match      : std_logic;   
   -- Sinais do descrambler
   signal descram_init  : std_logic;
   signal descram_rst   : std_logic;
   signal address_a  : std_logic_vector(9  downto 0);
   signal address_b  : std_logic_vector(9  downto 0);
   signal sa         : std_logic_vector(63 downto 0);
   signal sb         : std_logic_vector(63 downto 0);
   -- Sinais da maquina de sincronismo
   type   states is (INIT, IDLE, OUTOFFRAME, INOFFRAME);
   signal EA, PE	: states;
   signal palavras	: std_logic_vector(10 downto 0);
   signal framesout	: std_logic_vector(2  downto 0);

begin  
   ce  <= '1';
   
   --++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   -- Registradores - Pipeline
   --++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   
   -- Estagio 1
   ff1    : entity work.reg64bit port map(clk=>clk, rst=>rst, ce=>ce,   D=>estagio0,       Q=>estagio1);
   
   -- Estagio 2
   ff2    : entity work.reg64bit port map(clk=>clk, rst=>rst, ce=>ce,   D=>estagio1,    Q=>estagio2);
   ffc    : entity work.reg64bit port map(clk=>clk, rst=>rst, ce=>ce,   D=>estagioCin,  Q=>estagioCout);

   -- Estagio 3
   ff3    : entity work.reg64bit port map(clk=>clk, rst=>rst, ce=>ce,   D=>estagio2,    Q=>estagio3);
   ffend1 : entity work.reg6bit  port map(clk=>clk, rst=>rst, ce=>match,D=>estagioE1in, Q=>estagioE1out);
   
   -- Estagio 4
   ff4    : entity work.reg64bit port map(clk=>clk, rst=>rst, ce=>ce,   D=>alinhadorout,Q=>estagio4);
   ffull1 : entity work.regbit   port map(clk=>clk, rst=>rst, ce=>ce,   D=>fullmatch   ,Q=>estagioF1out);
   
   -- Estagio 5
   ff5    : entity work.reg64bit port map(clk=>clk, rst=>rst, ce=>ce,   D=>estagio4,    Q=>estagio5);
   --ffull2 : entity work.regbit   port map(clk=>clk, rst=>rst, ce=>ce,   D=>estagioF1out,Q=>estagioF2out);
   
   ffentrada : entity work.reg64bit port map(clk=>clk, rst=>rst, ce=>ce,D=>entrada,    Q=>estagio0);
   ffsaida   : entity work.reg64bit port map(clk=>clk, rst=>rst, ce=>ce,D=>regout,     Q=>saida);
   --++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   -- Sincronia do descrambler
   --++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   
	process(clk,rst)
	begin
		if rst = '0' then
			descram_init <= '0';
			
			descram_rst <= '0';
		
			address_a   <= (others=>'0');
			address_b   <= (others=>'0');
		
		elsif rising_edge(clk) then
			case EA is
				when INIT =>
					descram_init <= '0';
					
					descram_rst <= '0';
					
					address_a   <= (others=>'0');
					address_b   <= (others=>'0');
					
				when others=>
					if inframe = '1' or estagioF1out = '1' then
						descram_rst  <= '0';
					else
						descram_rst  <= '1';
					end if;
					
					if ((inframe = '1' or descram_rst = '1') and estagioF1out = '0') then
						descram_init <=  '1';
					else
						descram_init <= '0';
					end if;
					
					if fullmatch = '1' then
						address_a   <= (others=>'0');
						address_b   <= (0=>'1',others=>'0');
					else
						address_a   <= address_a + 1;
						address_b   <= address_b + 1;
					end if;
			end case;
		end if;
	end process;
	
   --++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   -- Maquina de Estados do Frame
   --++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
	reg_st_p:process(clk, rst)
	begin
		if rst = '0' then
			EA <= INIT;
		elsif rising_edge(clk) then
			if EA = INIT then
				EA <= IDLE;
			else
				EA <= PE;
			end if;
		end if;
	end process;
   
	process (EA, fullmatch, palavras, framesout)
	begin
		case EA is 
			when INIT => PE <= INIT;
			when IDLE =>
				if fullmatch = '1' then
					PE <= OUTOFFRAME;
				else
					PE <= IDLE;
				end if;

			when OUTOFFRAME =>
				if palavras = 2040 and fullmatch = '1' then
					PE <= INOFFRAME;
				else
					PE <= OUTOFFRAME;
				end if;

			when INOFFRAME  => 
				if palavras = 2040 and fullmatch = '0' and framesout = 4 then
					PE <= OUTOFFRAME;
				else
					PE <= INOFFRAME;
				end if;

			when others => PE <= INIT;
		end case;
	end process;

   -- Registradores controlados pela maquina de estados
	reg_out_p:process(clk, rst)
	begin
		if rst = '0' then
			palavras <= (others=>'0');
			framesout<= (others=>'0');
			inframe  <= '0';
			sync_o <= '0';

		elsif rising_edge(clk) then
			case EA is
				when INIT =>
					inframe  <= '0';
					palavras <= (others=>'0');
					framesout<= (others=>'0');
					sync_o <= '0';
					
				when IDLE =>
					inframe  <= '0';
					framesout<= (others=>'0');
					if fullmatch = '1' then
						palavras <= (0=>'1',others=>'0');
					else
						palavras <= (others=>'0');
					end if;
					sync_o <= '0';

				when OUTOFFRAME =>
					inframe  <= '0';
					framesout<= (others=>'0');
					if palavras = 2040 and fullmatch = '1' then
						palavras <= (0=>'1',others=>'0');
					else
						palavras <= palavras + 1;
					end if;

				when INOFFRAME =>
					inframe  <= '1';
					if palavras = 2040 and fullmatch = '1' then
						framesout<= (others=>'0');
						palavras <= (0=>'1',others=>'0');
					elsif palavras = 2040 and fullmatch = '0' then
						framesout <= framesout + 1;
						if framesout = 4 then
							palavras <= (others=>'0');
						else
							palavras <= (0=>'1',others=>'0');
						end if;
					else
						palavras <= palavras + 1;
					end if;
					sync_o <= '1';

				when others =>
					inframe  <= '0';
					palavras <= (others => '0');
					framesout<= (others => '0');
					sync_o <= '0';
			end case;
		------ moraes
		end if;
	end process;
                         
   clear_sig  <= '1' when (ea       =   INOFFRAME     and (
                          (palavras = "00000000100")  or (palavras = "00000000101")  or
                          (palavras = "01000000010")  or (palavras = "01000000011")  or
                          (palavras = "10000000000")  or (palavras = "10000000001")  or
                          (palavras = "10111111110")  or (palavras = "10111111111")))else '0';
   
   --++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   -- Maquina de Estados do Multiframe
   --++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 

   
   --++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   -- Mapeamento dos modulos
   --++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   
	compara:  entity work.comparador port map 
	( 
		atual    => estagio1,				-- (in)
		futuro   => estagio0(63 downto 33),	-- (in)
		controle => estagioCin				-- (out) 
	);

	endereca: entity work.enderecador port map 
	( 
		entrada   => estagioCout,	-- (in)
		enderecout=> estagioE1in,	-- (out)
		matchout  => match			-- (out)
	);

	desloca1:  entity work.deslocador1 port map 
	( 
		rst			=> rst,						-- (in)
		clk			=> clk,						-- (in)
		regdata		=> estagio3,				-- (in)
		data		=> estagio2(63 downto 1),	-- (in)
		endereco	=> estagioE1out,			-- (in)
		enderecout	=> estagioE2in,				-- (out)
		word1		=> alinhador1out,			-- (out)
		word11		=> alinhador11out			-- (out)
	);
         
	desloca2:  entity work.deslocador2 port map 
	( 
		rst			=> rst,				-- (in)
		clk			=> clk,				-- (in)
		data1		=> alinhador1out,	-- (in)
		data11		=> alinhador11out,	-- (in)
		endereco	=> estagioE2in,		-- (in)
		enderecout	=> estagioE3in,		-- (out)
		word2		=> alinhador2out,	-- (out)
		word22		=> alinhador22out	-- (out)
	);
         
	desloca3:  entity work.deslocador3 port map 
	( 
		rst		=> rst,				-- (in)
		clk		=> clk,				-- (in)
		data2	=> alinhador2out,	-- (in)
		data22	=> alinhador22out,	-- (in)
		endereco=> estagioE3in,		-- (in)
		word3	=> alinhadorout		-- (out)
	);

	compfull: entity work.comparadorfull port map 
	( 
		entrada   => alinhadorout(63 downto 16),-- (in)
		fullmatch => fullmatch					-- (out)
	);

	memoria:  entity work.memoriascram port map
	(
		addra      => address_a,-- (in)
		addrb      => address_b,-- (in)
		clka       => clk,		-- (in)
		clkb       => clk,		-- (in)
		douta      => sa,		-- (out)
		doutb      => sb		-- (out)
	);
   
	descram:  entity work.scrambler port map
	(
		clk			=> clk,				-- (in)
		rst			=> descram_rst,		-- (in)
		init		=> descram_init,	-- (in)
		addressin	=> address_a,		-- (in)
		sain		=> sa,				-- (in)
		sbin		=> sb,				-- (in)
		word64in	=> estagio5,		-- (in)
		word64out	=> regout			-- (out)
	);

   --++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   -- Assinatura
   --++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   --rstassin <= not(inframe);
   --ffassin:  entity work.regbit port map(clk=>clk, rst=>rst, ce=>ce, D=>rstassin, Q=>rstassout);
   ----ffassin2:  entity work.regbit port map(clk=>clk, rst=>rst, ce=>ce, D=>rstassout, Q=>rstassout2);
   
   --assinat:  entity work.assinatura port map
   --      (
   --        clk    => clk,
   --        rst    => rstassout,
   --        entrada   => regout,
   --        assinatura=> assinatura
   --      );
   
end framer;