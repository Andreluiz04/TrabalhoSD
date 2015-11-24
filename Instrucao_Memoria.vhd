library ieee; 
USE ieee.std_logic_1164.all; 
USE ieee.std_logic_unsigned.all; 
USE ieee.std_logic_arith.all; 

entity Instrucao_Memoria is
	port(
		Escrita_Inst: in std_logic_vector(31 downto 0);
		endereco: in std_logic_vector(31 downto 0);
		Nova_Inst: in std_logic_vector(31 downto 0);
		saida: out std_logic_vector(31 downto 0)
	);
end entity;

architecture Instrucao_Memoria_Arc of Instrucao_Memoria is
	type Inst is array( 255 downto 0 ) of std_logic_vector( 7 downto 0 ); 
    signal instrucao: Inst; 

begin 
   	process(endereco) 
      begin 
       	    saida( 7 downto 0 ) <= instrucao( conv_integer( endereco ) ); 
            saida( 15 downto 8 ) <= instrucao( conv_integer( endereco )+1 ); 
         	saida( 23 downto 16 ) <= instrucao( conv_integer( endereco )+2 ); 
 		    saida( 31 downto 24 ) <= instrucao( conv_integer( endereco )+3 ); 
 	end process; 
 	process( Escrita_Inst ) 
 	begin 
 		instrucao( conv_integer( Escrita_Inst ) ) <= Nova_Inst( 7 downto 0 ); 
 		instrucao( conv_integer(Escrita_Inst )+1 ) <= Nova_Inst( 15 downto 8 ); 
		instrucao( conv_integer(Escrita_Inst )+2 ) <= Nova_Inst( 23 downto 16 ); 
 		instrucao( conv_integer( Escrita_Inst )+3 ) <= Nova_Inst( 31 downto 24 ); 
 	end process; 
end architecture; 
