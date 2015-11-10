library ieee; 
2 USE ieee.std_logic_1164.all; 
3 USE ieee.std_logic_unsigned.all; 
4 USE ieee.std_logic_arith.all; 


entity Banco_Registrador is 
	port(
		clkPC: in std_logic;
		RegWrite: in_std_logic;
		reg1: in std_logic_vector(4 downto 0);
		reg2: in std_logic_vector(4 downto 0);
		writeReg: in std_logic_vector(4 downto 0);
		writeDado: in std_logic_vector(31 downto 0);
		dado1: out std_logic_vector(31 downto 0);
		dado2: out std_logic_vector(31 downto 0)
	);
end entity;

architecture Banco_Registrador_Arc of Banco_Registrador is

type Registers is array(31 downto 0) of std_logic_vector(31 downto 0);
signal banco: Registers;

begin
	process(clkPC, RegWrite, writeDado, writeReg)
	variable indiceRegWrite: integer;
		begin
			indiceRegWrite := conv_integer(writeReg);

			if(clkPC'event and clkPC ='1' and RegWrite = '1' and writeReg /= "0000") then
				banco(indiceRegWrite) <= writeDado;
			end if;
	end process;
	process( reg1, clkPC ) 
	begin 
		if( clkPC'event and clkPC = '0' ) then 
			if( reg1 = "00000" ) then 
				dado1 <= "00000000000000000000000000000000"; 
			else 
				dado1 <= banco( conv_integer( reg1 ) ); 
			end if; 
		end if; 
 	end process; 
 	process( reg2, clkPC ) 
	begin 
		if( clkPC'event and clkPC = '0' ) then 
			if( reg2 = "00000" ) then 
				dado2 <= "00000000000000000000000000000000"; 
			else 
				dado2 <= banco( conv_integer( reg2 ) ); 
			end if; 
		end if; 
	end process; 
 end architecture;