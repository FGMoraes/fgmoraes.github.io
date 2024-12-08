library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity anel is
	generic(
		--Número de inversores 
		size: integer := 10
	);
	
	port (
		reset : in STD_LOGIC;
		ring_o : out STD_LOGIC
	);
end;

architecture anel of anel is

--Declarando o inversor
component inv
	port (
		A : in STD_LOGIC;
		Z : out STD_LOGIC
	);
end component;

--Declarando a nand da biblioteca
component HS65_GS_NAND2X2
	port (
		A : in STD_LOGIC;
		B : in STD_LOGIC;
		Z : out STD_LOGIC
	);
end component;

signal ring : STD_LOGIC_VECTOR (size downto 0);

begin

	--Conectando o ultimo inversor na saída "ring_out"
	ring_o <= ring(size);

        -- nand no início do anel, para reset	
	nx : HS65_GS_NAND2X2 port map (reset, ring(size), ring(0));

	
	--Gerando o anel de inversores
	inv_instance : for i in 1 to size generate
		inv_i : inv port map (ring(i-1), ring(i));
	end generate inv_instance;
end; 
