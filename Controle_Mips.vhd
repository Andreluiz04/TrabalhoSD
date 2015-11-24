library ieee; 
USE ieee.std_logic_1164.all; 
USE ieee.std_logic_unsigned.all; 
USE ieee.std_logic_arith.all;


entity Controle_Mips is
	port(
		codigo: in std_logic_vector(5 downto 0);
		RegDst: out std_logic; 
		Branch: out std_logic; 
 		MemRead: out std_logic; 
 		MemtoReg: out std_logic; 
 		MemWrite: out std_logic; 
 		ALUSrc: out std_logic; 
 		RegWrite: out std_logic; 
 		Jump: out std_logic;
 		ULAOP: out std_logic_vector( 1 downto 0 ) 
 	); 
end entity;


Architecture Controle_Mips_Arc of Controle_Mips is

begin

	process(codigo)
	begin

		if( codigo = "000000" ) then -- R TYPE: 
 			RegDst <= '1'; 
 			ALUSrc <= '0'; 
 			MemtoReg <= '0'; 
 			RegWrite <= '1'; 
 			MemRead <= '0'; 
 			MemWrite <= '0'; 
 			Branch <= '0'; 
 			ULAOP <= "11"; 
 			Jump <= '0'; 
 		elsif( codigo = "000100" ) then -- BEQ: 
 			RegDst <= '0'; 
			ALUSrc <= '0'; 
 			MemtoReg <= '0'; 
 			RegWrite <= '0'; 
 			MemRead <= '0'; 
 			MemWrite <= '0'; 
 			Branch <= '1'; 
			ULAOP <= "01"; 
 			Jump <= '0';  
 		elsif(codigo = "000010") then -- JUMP: 
 			RegDst <= '0'; 
 			ALUSrc <= '0'; 
 			MemtoReg <= '0'; 
 			RegWrite <= '0'; 
 			MemRead <= '0'; 
 			MemWrite <= '0'; 
 			Branch <= '0'; 
 			ULAOP <= "00"; 
 			Jump <= '1';
 		elsif (codigo = "001000") then -- ADDI: 
 			RegDst <= '0'; 
 			ALUSrc <= '1'; 
 			MemtoReg <= '0'; 
 			RegWrite <= '1'; 
 			MemRead <= '0'; 
 			MemWrite <= '0'; 
 			Branch <= '0'; 
 			ULAOP <= "00"; 
 			Jump <= '0'; 
 		elsif (codigo = "001100") then -- SLT: 
 			RegDst <= '0'; 
 			ALUSrc <= '1'; 
 			MemtoReg <= '0'; 
 			RegWrite <= '1'; 
 			MemRead <= '0'; 
 			MemWrite <= '0'; 
 			Branch <= '0'; 
 			ULAOP <= "10"; 
 			Jump <= '0'; 
 			 
 		end if; 
 	end process; 
end architecture; 