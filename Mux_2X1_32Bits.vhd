library ieee; 
USE ieee.std_logic_1164.all; 
USE ieee.std_logic_unsigned.all; 
USE ieee.std_logic_arith.all;
 
entity Mux_2x1_32Bits is 
 	port( 
 		controle: in std_logic; 
 		a: in std_logic_vector( 31 downto 0 ); 
 		b: in std_logic_vector( 31 downto 0 ); 
		saida: out std_logic_vector( 31 downto 0 ) 
	); 
end entity;
 
 
architecture Mux_2x1_32Bits_Arc of Mux_2x1_32Bits is 
begin 
	process( controle, a, b ) 
 	begin 
 		if( controle = '0' )then  
 			saida <= a; 
 		else  
 			saida <= b; 
 		end if; 
 	end process; 
end architecture; 
