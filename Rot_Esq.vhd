library ieee; 
USE ieee.std_logic_1164.all; 
USE ieee.std_logic_unsigned.all; 
USE ieee.std_logic_arith.all; 

 
entity Rot_Esq is 
	port( 
		input: in std_logic_vector( 31 downto 0 ); 
		output: out std_logic_vector( 31 downto 0 ) 
 	); 
end entity; 
 
architecture Rot_Esq_Arc of Rot_Esq is 
 begin 
 	output <= input( 29 downto 0 ) & "00"; 
end architecture; 
