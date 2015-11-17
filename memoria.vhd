library ieee; 
use ieee.std_logic_arith.all; 
use ieee.std_logic_unsigned.all; 


 
entity memoria is 
	port( 
		clk: in std_logic; 
 		MemRead: in std_logic; 
 		MemWrite: in std_logic; 
 		endereco: in std_logic_vector( 31 downto 0 ); 
 		writeDado: in std_logic_vector( 31 downto 0 ); 
 		saida: out std_logic_vector( 31 downto 0 ) 
 	); 
end entity; 
 
 
architecture memoria_Arc of memoria is 
 
 
type Bytes is array( 255 downto 0 ) of std_logic_vector( 7 downto 0 ); 
signal celula: Bytes; 

 
begin 
 	process (clk) 
 		begin 
 		    if(clk'event and clk = '0' and MemWrite = '1' )then 
		       celula( conv_integer( endereco ) ) <= writeDado( 7 downto 0 ); 
		       celula( conv_integer( endereco )+1 ) <= writeDado( 15 downto 8 ); 
 		       celula( conv_integer( endereco )+2 ) <= writeDado( 23 downto 16 ); 
 		       celula( conv_integer( endereco )+3 ) <= writeDado( 31 downto 24 ); 
 		    end if; 
 	end process; 
 
 
	process( MemRead ) 
		begin 
	    	if( MemRead = '1' )then 
	       		saida( 7 downto 0 ) <= celula( conv_integer( endereco ) ); 
	       		saida( 15 downto 8 ) <= celula( conv_integer( endereco )+1 ); 
	       		saida( 23 downto 16 ) <= celula( conv_integer( endereco )+2 ); 
	       		saida( 31 downto 24 ) <= celula( conv_integer( endereco )+3 ); 
	    	end if; 
		end process;
end architecture;