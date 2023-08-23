--CELL
library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.Std_Logic_unsigned.all;

entity cell is
        port(
                a:  in std_logic;
                b:  in std_logic;
                f:  in std_logic;
                y:  in std_logic;
                z:  in std_logic;
                yy: out std_logic               
        );
end cell;

architecture cell of cell is

begin

        yy<=(a and b) xor (f and y) xor z;

end cell;

--Celular array Multiplier
library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.Std_Logic_unsigned.all;

entity cell_array_mult is
	port(
		input1: in std_logic_vector(7 downto 0);
        input2: in std_logic_vector(7 downto 0);
        output: out std_logic_vector(7 downto 0);
        f:  in std_logic_vector(7 downto 0)
	);
end cell_array_mult;

architecture cell_array_mult of cell_array_mult is
        
        signal yy11_y21: std_logic;
        signal yy21_y31: std_logic;
        signal yy31_y41: std_logic;
        signal yy41_y51: std_logic;
        signal yy51_y61: std_logic;
        signal yy61_y71: std_logic;
        signal yy71_y81: std_logic;
        
        signal yy12_z21: std_logic;
        signal yy13_z22: std_logic;
        signal yy14_z23: std_logic;
        signal yy15_z24: std_logic;
        signal yy16_z25: std_logic;
        signal yy17_z26: std_logic;
        signal yy18_z27: std_logic;
        
        signal yy22_z31: std_logic;
        signal yy23_z32: std_logic;
        signal yy24_z33: std_logic;
        signal yy25_z34: std_logic;
        signal yy26_z35: std_logic;
        signal yy27_z36: std_logic;
        signal yy28_z37: std_logic;        
        
        signal yy32_z41: std_logic;
        signal yy33_z42: std_logic;
        signal yy34_z43: std_logic;
        signal yy35_z44: std_logic;
        signal yy36_z45: std_logic;
        signal yy37_z46: std_logic;
        signal yy38_z47: std_logic;        
        
        signal yy42_z51: std_logic;
        signal yy43_z52: std_logic;
        signal yy44_z53: std_logic;
        signal yy45_z54: std_logic;
        signal yy46_z55: std_logic;
        signal yy47_z56: std_logic;
        signal yy48_z57: std_logic;        
        
        signal yy52_z61: std_logic;
        signal yy53_z62: std_logic;
        signal yy54_z63: std_logic;
        signal yy55_z64: std_logic;
        signal yy56_z65: std_logic;
        signal yy57_z66: std_logic;
        signal yy58_z67: std_logic;
        
        signal yy62_z71: std_logic;
        signal yy63_z72: std_logic;
        signal yy64_z73: std_logic;
        signal yy65_z74: std_logic;
        signal yy66_z75: std_logic;
        signal yy67_z76: std_logic;
        signal yy68_z77: std_logic;        
        
        signal yy72_z81: std_logic;
        signal yy73_z82: std_logic;
        signal yy74_z83: std_logic;
        signal yy75_z84: std_logic;
        signal yy76_z85: std_logic;
        signal yy77_z86: std_logic;
        signal yy78_z87: std_logic;        
        
begin

        MULT_1_1: entity work.cell port map(a=>input1(7),b=>input2(7),f=>f(7),y=>'0',z=>'0',yy=>yy11_y21);
        MULT_1_2: entity work.cell port map(a=>input1(6),b=>input2(7),f=>f(6),y=>'0',z=>'0',yy=>yy12_z21);
        MULT_1_3: entity work.cell port map(a=>input1(5),b=>input2(7),f=>f(5),y=>'0',z=>'0',yy=>yy13_z22);
        MULT_1_4: entity work.cell port map(a=>input1(4),b=>input2(7),f=>f(4),y=>'0',z=>'0',yy=>yy14_z23);
        MULT_1_5: entity work.cell port map(a=>input1(3),b=>input2(7),f=>f(3),y=>'0',z=>'0',yy=>yy15_z24);
        MULT_1_6: entity work.cell port map(a=>input1(2),b=>input2(7),f=>f(2),y=>'0',z=>'0',yy=>yy16_z25);
        MULT_1_7: entity work.cell port map(a=>input1(1),b=>input2(7),f=>f(1),y=>'0',z=>'0',yy=>yy17_z26);
        MULT_1_8: entity work.cell port map(a=>input1(0),b=>input2(7),f=>f(0),y=>'0',z=>'0',yy=>yy18_z27);
        
        MULT_2_1: entity work.cell port map(a=>input1(7),b=>input2(6),f=>f(7),y=>yy11_y21,z=>yy12_z21,yy=>yy21_y31);
        MULT_2_2: entity work.cell port map(a=>input1(6),b=>input2(6),f=>f(6),y=>yy11_y21,z=>yy13_z22,yy=>yy22_z31);
        MULT_2_3: entity work.cell port map(a=>input1(5),b=>input2(6),f=>f(5),y=>yy11_y21,z=>yy14_z23,yy=>yy23_z32);
        MULT_2_4: entity work.cell port map(a=>input1(4),b=>input2(6),f=>f(4),y=>yy11_y21,z=>yy15_z24,yy=>yy24_z33);
        MULT_2_5: entity work.cell port map(a=>input1(3),b=>input2(6),f=>f(3),y=>yy11_y21,z=>yy16_z25,yy=>yy25_z34);
        MULT_2_6: entity work.cell port map(a=>input1(2),b=>input2(6),f=>f(2),y=>yy11_y21,z=>yy17_z26,yy=>yy26_z35);
        MULT_2_7: entity work.cell port map(a=>input1(1),b=>input2(6),f=>f(1),y=>yy11_y21,z=>yy18_z27,yy=>yy27_z36);
        MULT_2_8: entity work.cell port map(a=>input1(0),b=>input2(6),f=>f(0),y=>yy11_y21,z=>'0',yy=>yy28_z37);        
        
        MULT_3_1: entity work.cell port map(a=>input1(7),b=>input2(5),f=>f(7),y=>yy21_y31,z=>yy22_z31,yy=>yy31_y41);
        MULT_3_2: entity work.cell port map(a=>input1(6),b=>input2(5),f=>f(6),y=>yy21_y31,z=>yy23_z32,yy=>yy32_z41);
        MULT_3_3: entity work.cell port map(a=>input1(5),b=>input2(5),f=>f(5),y=>yy21_y31,z=>yy24_z33,yy=>yy33_z42);
        MULT_3_4: entity work.cell port map(a=>input1(4),b=>input2(5),f=>f(4),y=>yy21_y31,z=>yy25_z34,yy=>yy34_z43);
        MULT_3_5: entity work.cell port map(a=>input1(3),b=>input2(5),f=>f(3),y=>yy21_y31,z=>yy26_z35,yy=>yy35_z44);
        MULT_3_6: entity work.cell port map(a=>input1(2),b=>input2(5),f=>f(2),y=>yy21_y31,z=>yy27_z36,yy=>yy36_z45);
        MULT_3_7: entity work.cell port map(a=>input1(1),b=>input2(5),f=>f(1),y=>yy21_y31,z=>yy28_z37,yy=>yy37_z46);
        MULT_3_8: entity work.cell port map(a=>input1(0),b=>input2(5),f=>f(0),y=>yy21_y31,z=>'0',yy=>yy38_z47);        
        
        MULT_4_1: entity work.cell port map(a=>input1(7),b=>input2(4),f=>f(7),y=>yy31_y41,z=>yy32_z41,yy=>yy41_y51);
        MULT_4_2: entity work.cell port map(a=>input1(6),b=>input2(4),f=>f(6),y=>yy31_y41,z=>yy33_z42,yy=>yy42_z51);
        MULT_4_3: entity work.cell port map(a=>input1(5),b=>input2(4),f=>f(5),y=>yy31_y41,z=>yy34_z43,yy=>yy43_z52);
        MULT_4_4: entity work.cell port map(a=>input1(4),b=>input2(4),f=>f(4),y=>yy31_y41,z=>yy35_z44,yy=>yy44_z53);
        MULT_4_5: entity work.cell port map(a=>input1(3),b=>input2(4),f=>f(3),y=>yy31_y41,z=>yy36_z45,yy=>yy45_z54);
        MULT_4_6: entity work.cell port map(a=>input1(2),b=>input2(4),f=>f(2),y=>yy31_y41,z=>yy37_z46,yy=>yy46_z55);
        MULT_4_7: entity work.cell port map(a=>input1(1),b=>input2(4),f=>f(1),y=>yy31_y41,z=>yy38_z47,yy=>yy47_z56);
        MULT_4_8: entity work.cell port map(a=>input1(0),b=>input2(4),f=>f(0),y=>yy31_y41,z=>'0',yy=>yy48_z57);        

        MULT_5_1: entity work.cell port map(a=>input1(7),b=>input2(3),f=>f(7),y=>yy41_y51,z=>yy42_z51,yy=>yy51_y61);
        MULT_5_2: entity work.cell port map(a=>input1(6),b=>input2(3),f=>f(6),y=>yy41_y51,z=>yy43_z52,yy=>yy52_z61);
        MULT_5_3: entity work.cell port map(a=>input1(5),b=>input2(3),f=>f(5),y=>yy41_y51,z=>yy44_z53,yy=>yy53_z62);
        MULT_5_4: entity work.cell port map(a=>input1(4),b=>input2(3),f=>f(4),y=>yy41_y51,z=>yy45_z54,yy=>yy54_z63);
        MULT_5_5: entity work.cell port map(a=>input1(3),b=>input2(3),f=>f(3),y=>yy41_y51,z=>yy46_z55,yy=>yy55_z64);
        MULT_5_6: entity work.cell port map(a=>input1(2),b=>input2(3),f=>f(2),y=>yy41_y51,z=>yy47_z56,yy=>yy56_z65);
        MULT_5_7: entity work.cell port map(a=>input1(1),b=>input2(3),f=>f(1),y=>yy41_y51,z=>yy48_z57,yy=>yy57_z66);
        MULT_5_8: entity work.cell port map(a=>input1(0),b=>input2(3),f=>f(0),y=>yy41_y51,z=>'0',yy=>yy58_z67);
        
        MULT_6_1: entity work.cell port map(a=>input1(7),b=>input2(2),f=>f(7),y=>yy51_y61,z=>yy52_z61,yy=>yy61_y71);
        MULT_6_2: entity work.cell port map(a=>input1(6),b=>input2(2),f=>f(6),y=>yy51_y61,z=>yy53_z62,yy=>yy62_z71);
        MULT_6_3: entity work.cell port map(a=>input1(5),b=>input2(2),f=>f(5),y=>yy51_y61,z=>yy54_z63,yy=>yy63_z72);
        MULT_6_4: entity work.cell port map(a=>input1(4),b=>input2(2),f=>f(4),y=>yy51_y61,z=>yy55_z64,yy=>yy64_z73);
        MULT_6_5: entity work.cell port map(a=>input1(3),b=>input2(2),f=>f(3),y=>yy51_y61,z=>yy56_z65,yy=>yy65_z74);
        MULT_6_6: entity work.cell port map(a=>input1(2),b=>input2(2),f=>f(2),y=>yy51_y61,z=>yy57_z66,yy=>yy66_z75);
        MULT_6_7: entity work.cell port map(a=>input1(1),b=>input2(2),f=>f(1),y=>yy51_y61,z=>yy58_z67,yy=>yy67_z76);
        MULT_6_8: entity work.cell port map(a=>input1(0),b=>input2(2),f=>f(0),y=>yy51_y61,z=>'0',yy=>yy68_z77);        
        
        MULT_7_1: entity work.cell port map(a=>input1(7),b=>input2(1),f=>f(7),y=>yy61_y71,z=>yy62_z71,yy=>yy71_y81);
        MULT_7_2: entity work.cell port map(a=>input1(6),b=>input2(1),f=>f(6),y=>yy61_y71,z=>yy63_z72,yy=>yy72_z81);
        MULT_7_3: entity work.cell port map(a=>input1(5),b=>input2(1),f=>f(5),y=>yy61_y71,z=>yy64_z73,yy=>yy73_z82);
        MULT_7_4: entity work.cell port map(a=>input1(4),b=>input2(1),f=>f(4),y=>yy61_y71,z=>yy65_z74,yy=>yy74_z83);
        MULT_7_5: entity work.cell port map(a=>input1(3),b=>input2(1),f=>f(3),y=>yy61_y71,z=>yy66_z75,yy=>yy75_z84);
        MULT_7_6: entity work.cell port map(a=>input1(2),b=>input2(1),f=>f(2),y=>yy61_y71,z=>yy67_z76,yy=>yy76_z85);
        MULT_7_7: entity work.cell port map(a=>input1(1),b=>input2(1),f=>f(1),y=>yy61_y71,z=>yy68_z77,yy=>yy77_z86);
        MULT_7_8: entity work.cell port map(a=>input1(0),b=>input2(1),f=>f(0),y=>yy61_y71,z=>'0',yy=>yy78_z87);        
        
        MULT_8_1: entity work.cell port map(a=>input1(7),b=>input2(0),f=>f(7),y=>yy71_y81,z=>yy72_z81,yy=>output(7));
        MULT_8_2: entity work.cell port map(a=>input1(6),b=>input2(0),f=>f(6),y=>yy71_y81,z=>yy73_z82,yy=>output(6));
        MULT_8_3: entity work.cell port map(a=>input1(5),b=>input2(0),f=>f(5),y=>yy71_y81,z=>yy74_z83,yy=>output(5));
        MULT_8_4: entity work.cell port map(a=>input1(4),b=>input2(0),f=>f(4),y=>yy71_y81,z=>yy75_z84,yy=>output(4));
        MULT_8_5: entity work.cell port map(a=>input1(3),b=>input2(0),f=>f(3),y=>yy71_y81,z=>yy76_z85,yy=>output(3));
        MULT_8_6: entity work.cell port map(a=>input1(2),b=>input2(0),f=>f(2),y=>yy71_y81,z=>yy77_z86,yy=>output(2));
        MULT_8_7: entity work.cell port map(a=>input1(1),b=>input2(0),f=>f(1),y=>yy71_y81,z=>yy78_z87,yy=>output(1));
        MULT_8_8: entity work.cell port map(a=>input1(0),b=>input2(0),f=>f(0),y=>yy71_y81,z=>'0',yy=>output(0));        

end cell_array_mult;