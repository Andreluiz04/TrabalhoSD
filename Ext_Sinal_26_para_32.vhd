library ieee; 
USE ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 
 
 
entity Ext_Sinal_26_para_32 is
 	port( 
 		entrada: in std_logic_vector( 25 downto 0 ); 
 		saida: out std_logic_vector( 31 downto 0 ) 
 	); 
end entity; 
 
 
architecture Ext_Sinal_26_para_32_Arc of Ext_Sinal_26_para_32 is 
 
begin 
 	saida <= std_logic_vector(resize( signed(entrada), 32 ) ); 
end architecture; 
