library ieee; 
use ieee.std_logic_arith.all; 
use ieee.std_logic_unsigned.all; 

entity PC is 
	port( 
		clk: in std_logic; 
		reset: in std_logic; 
 		input: in std_logic_vector( 31 downto 0 ); 
 		output: out std_logic_vector( 31 downto 0 ) 
 	); 
end entity; 
 

architecture PC_Arc of PC is 
 	signal aux: std_logic_vector( 31 downto 0 ); 
 begin 
 
 
 	process( clk, reset ) 
 	begin 
 		if( reset = '1' ) then 
 			aux <= "00000000000000000000000000000000"; 
 		elsif( clk'event and clk = '1' ) then 
 			aux <= input; 
		end if; 
 	end process; 
 	output <= aux; 
end architecture; 
