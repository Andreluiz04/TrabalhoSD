library ieee; 
2 USE ieee.std_logic_1164.all; 
3 USE ieee.std_logic_unsigned.all; 
4 USE ieee.std_logic_arith.all; 

entity ALU is
	port( 
		op: in std_logic_vetor(1 downto 0);
		a: in std_logic_vector(31 downto 0);
		b: in std_logic_vector(31 downto 0);
		zero: in std_logic;
		resultado: out std_logic_vector(31 downto 0)
	);
end ALU;

architecture ALU_ARC of ALU is
	signal result: std_logic_vector(31 downto 0);
begin
	process(op, a, b)
		begin
			if(op = "000") then
				result <= a and b;
			elsif(op = "001") then
				result <= a or b;
			elsif(op = "010") then
				result <= a + b;
			elsif(op = "110") then
				result <= a - b;
			elsif(op = "111") then 
				if(conv_integer(a) < conv_integer(b)) then
					result <= "00000000000000000000000000000001";
				else
					result <= "00000000000000000000000000000000";
				end if;
			end if;
			if(a = b) then -- verificação se um valor é menor ou igual ao outro valor. o valor é para atualizar o pc.
				zero <= '1';
			else
				zero <= '0';
			end if;
	end process;
	resultado <= result;
end architecture;
