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
end Mux_2x1_32Bits; 
 
 
16 architecture Mux_2x1_32Bits_Arc of Mux_2x1_32Bits is 
17 begin 
18 	process( controle, a, b ) 
19 	begin 
20 		if( controle = '0' )then  
21 			saida <= a; 
22 		else  
23 			saida <= b; 
24 		end if; 
25 	end process; 
26 end architecture; 
