library ieee; 
2 USE ieee.std_logic_1164.all; 
3 USE ieee.std_logic_unsigned.all; 
4 USE ieee.std_logic_arith.all; 


entity ADD_JP is
	port(
		a: in std_logic_vector(31 downto 0);
		b: in std_logic_vector(31 downto 0);
		s: out std_logic_vector(31 downto 0)
	);
end entity;

architecture ADD_JP_Arc of ADD_JP is
begin
	process(a, b)
		begin
		s <= a + b;
	end process;
end architecture;