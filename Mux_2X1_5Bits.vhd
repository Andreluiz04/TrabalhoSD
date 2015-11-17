library ieee; 
use ieee.std_logic_arith.all; 
use ieee.std_logic_unsigned.all; 

entity Mux_2X1_5Bits is
	port(
		selecao: in std_logic;
		a: in std_logic_vector(4 downto 0); --do 20 ao 16 na entrada do mux do banco de registradores.
		b: in std_logic_vector(4 downto 0); --do 15 ao 11 na entrada do mux do banco de registradores.
		saida: out std_logic_vector(4 downto 0)
	);
end Mux_2X1_5Bits;


architecture Mux_2X1_5Bits_Arc of Mux_2X1_5Bits is
begin
	
	process(s, a, b)
	begin
		if(selecao = '0') then
			saida <= a;
		else
			saida <= b;
		end if;
	end process;
end architecture;