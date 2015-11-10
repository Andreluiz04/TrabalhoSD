library ieee; 
2 USE ieee.std_logic_1164.all; 
3 USE ieee.std_logic_unsigned.all; 
4 USE ieee.std_logic_arith.all; 

-- controle da ALU

entity CONTROLE_ALU is
	port(
		ALuOp: in std_logic_vector(1 downto 0);
		funct: in std_logic_vector(5 downto 0);
		JR: out std_logic;
		operacao: out std_logic_vector(2 downto 0);
	);
end entity;

architecture CONTROLE_ALU_Arc of CONTROLE_ALU is
begin
	process(ALuOp, funct)
		begin
			JR <= '0';
			if(ALuOP = "00") then -- soma :ADDI
				operacao <= "010";
			elsif(ALuOP = "01") then --subtração: BEQ
				operacao <= "110";
			elsif(ALuOp = "10") then
				operacao <= "111";  --SLT
			else
				if(funct(3 downto 0) = "0000")then
					operacao <= "010";
				elsif(funct(3 downto 0) = "0010") then
					operacao <= "110";
				elsif(funct(3 downto 0) = "0100") then
					operacao <= "000";
				elsif(funct(3 downto 0) = "0101") then
					operacao <= "001";
				elsif(funct(3 downto 0) = "1010") then
					operacao <= "111";
				elsif(funct(3 downto 0) = "1000") then
					JR <= 1;
				end if;
			end if;
	end process;
end architecture;