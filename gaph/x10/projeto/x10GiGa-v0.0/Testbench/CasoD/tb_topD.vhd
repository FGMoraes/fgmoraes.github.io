--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Conversion from string to std_logic_vector with a 64-bit word
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_unsigned.all;

package CONVERT is 
   
   function CONVERT_STR_TO_STDLOGICVECTOR(str : STRING) return std_logic_vector;
   
end CONVERT;

package body CONVERT is         
   
   function CONVERT_STR_TO_STDLOGICVECTOR(str : STRING) return std_logic_vector is
   variable result : std_logic_vector(63 downto 0) := (others => '0') ;
   begin    
      
      for i in 0 to 15 loop
         if    str( (1+(i*4)) to (4+(i*4)) ) = "0000" then result( (63-(i*4)) downto (60-(i*4)) ) := "0000" ;
         elsif str( (1+(i*4)) to (4+(i*4)) ) = "0001" then result( (63-(i*4)) downto (60-(i*4)) ) := "0001" ;
         elsif str( (1+(i*4)) to (4+(i*4)) ) = "0010" then result( (63-(i*4)) downto (60-(i*4)) ) := "0010" ;
         elsif str( (1+(i*4)) to (4+(i*4)) ) = "0011" then result( (63-(i*4)) downto (60-(i*4)) ) := "0011" ;
         elsif str( (1+(i*4)) to (4+(i*4)) ) = "0100" then result( (63-(i*4)) downto (60-(i*4)) ) := "0100" ;
         elsif str( (1+(i*4)) to (4+(i*4)) ) = "0101" then result( (63-(i*4)) downto (60-(i*4)) ) := "0101" ;
         elsif str( (1+(i*4)) to (4+(i*4)) ) = "0110" then result( (63-(i*4)) downto (60-(i*4)) ) := "0110" ;
         elsif str( (1+(i*4)) to (4+(i*4)) ) = "0111" then result( (63-(i*4)) downto (60-(i*4)) ) := "0111" ;
         elsif str( (1+(i*4)) to (4+(i*4)) ) = "1000" then result( (63-(i*4)) downto (60-(i*4)) ) := "1000" ;
         elsif str( (1+(i*4)) to (4+(i*4)) ) = "1001" then result( (63-(i*4)) downto (60-(i*4)) ) := "1001" ;
         elsif str( (1+(i*4)) to (4+(i*4)) ) = "1010" then result( (63-(i*4)) downto (60-(i*4)) ) := "1010" ;
         elsif str( (1+(i*4)) to (4+(i*4)) ) = "1011" then result( (63-(i*4)) downto (60-(i*4)) ) := "1011" ;
         elsif str( (1+(i*4)) to (4+(i*4)) ) = "1100" then result( (63-(i*4)) downto (60-(i*4)) ) := "1100" ;
         elsif str( (1+(i*4)) to (4+(i*4)) ) = "1101" then result( (63-(i*4)) downto (60-(i*4)) ) := "1101" ;
         elsif str( (1+(i*4)) to (4+(i*4)) ) = "1110" then result( (63-(i*4)) downto (60-(i*4)) ) := "1110" ;
         elsif str( (1+(i*4)) to (4+(i*4)) ) = "1111" then result( (63-(i*4)) downto (60-(i*4)) ) := "1111" ;
         else
            -- synopsys translate_off
            assert FALSE
            report "Error : cannot convert string '" & str & "' to std_logic"
            severity failure;
            -- synopsys translate_on
         end if;  
      end loop;                     
  
      return result;
   
   end CONVERT_STR_TO_STDLOGICVECTOR;  

end CONVERT;
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Testbench
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_unsigned.all;
use IEEE.STD_LOGIC_textio.ALL;

use STD.TEXTIO.all;

use work.CONVERT.all;
--use work.fieldTable_pack.all;

library SIMPRIM;
use SIMPRIM.VCOMPONENTS.ALL;
use SIMPRIM.VPACKAGE.ALL;

entity top_tb is
end top_tb;

architecture top_tb of top_tb is

signal saida	: std_logic_vector(63 downto 0);
signal assin	: std_logic_vector(63 downto 0);
signal clk		: std_logic := '1'; 
signal rst		: std_logic := '1';

signal atual    : std_logic_vector(63 downto 0):= (others => '0');

signal FWORD    : std_logic_vector(63 downto 0);
file   FRAME    : TEXT open READ_MODE is "../../Simulacao/CasoD/casoD_bin.in";

signal clk0_tb	: std_logic;
signal clk180_tb: std_logic;
signal clk2x_tb	: std_logic;
signal rst_tb	: std_logic;
signal valid_tb	: std_logic;
begin

-- clock
   process
     variable delay : time := 400 ns;
   begin
     clk <= '0';
     wait for delay;
     wait for 2.5 ns;
     clk <= '1';
     delay := 0 ns;
     wait for 2.5 ns;
   end process;
-- reset
   rst <= '0', '1' after 10 ns, '0' after 600.0 ns;
   
   file_save_output:process
      variable i : POSITIVE := 1;
      file   outputDataFile : TEXT open WRITE_MODE is "caseD_bin.out";
      procedure saveOutputData (data : in std_logic_vector) is
         variable lineAux   : line;
      begin
         write(lineAux,data);
         writeline(outputDataFile, lineAux);
      end procedure;
   begin
   	wait until valid_tb = '1';
   	wait until clk2x_tb = '1';
   	wait until clk2x_tb = '1';
   	wait until clk2x_tb = '1';
   	wait until clk2x_tb = '1';
   	--wait until clk2x_tb = '1';
   	loop
   		wait until clk2x_tb = '1';
   		saveOutputData(saida);
   	end loop;
      end process;
      

   
 --  -- save data_out_frame
--file_save_output_data:process
--   file   outputDataFile : TEXT open WRITE_MODE is "frames_out.txt";
--   procedure saveOutputData (data : in std_logic_vector) is
--      variable lineAux   : line;
--   begin
--      write(lineAux,data);
--      writeline(outputDataFile, lineAux);
--   end procedure;
--begin
--      wait until stransmitA_out = '1';
--      loop
--         wait until clk = '1';
--         saveOutputData(saida_framer);
--         wait until clk = '0';
--      end loop;
--end process;
   
--processo de leitura do arquivo de entrada
   process  (clk2x_tb, rst_tb)
       variable FRAME_LINE : LINE ;
       variable FRAME_64bitWORD : string(1 to 64) ;
   begin
      if rst_tb = '0' then
         FRAME_64bitWORD := (others => '0') ;
         FWORD <=  CONVERT_STR_TO_STDLOGICVECTOR(FRAME_64bitWORD) ;

      elsif clk2x_tb'event and clk2x_tb = '1' then 
         if NOT (endfile(FRAME)) then

            readline(FRAME, FRAME_LINE);      
            read(FRAME_LINE, FRAME_64bitWORD(1 to  FRAME_LINE'length) ) ;

            FWORD <=  CONVERT_STR_TO_STDLOGICVECTOR(FRAME_64bitWORD) ;

            atual <= FWORD;

          end if;
      end if;

   end process;
   


-- UNIT UNDER TEST      
   uut: entity work.top_frame_FEC port map 
   (
      clock_in    => clk,
      reset_placa => rst,
      
      rst_out     => rst_tb,
      clk0_out	  => clk0_tb,
      clk180_out  => clk180_tb,
      clk2x_out	  => clk2x_tb,
      --assinatura  => assin,
      
      saida		  => saida,
      entrada     => atual,
      valid_out   => valid_tb
   );

end top_tb;
