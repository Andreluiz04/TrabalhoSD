
LIBRARY ieee; 
USE ieee.std_logic_1164.ALL; 
   
 ENTITY tb_Projeto_Mips IS 
 END tb_Projeto_Mips; 
   
 ARCHITECTURE behavior OF tb_Projeto_Mips IS   
   
 	COMPONENT Projeto_Mips
 	PORT( 
 		ClkPc: in std_logic;
		reset: in std_logic;
		NovoEndereco: in std_logic_vector(31 downto 0);
		NovaInst: in std_logic_vector(31 downto 0)
 	); 
 	END COMPONENT; 
 	 
 
 	--ENTRADAS 
 	signal ClkPc : std_logic := '0'; 
 	signal reset : std_logic := '0'; 
 	signal NovoEndereco : std_logic_vector(31 downto 0) := (others => '0'); 
 	signal NovaInst : std_logic_vector(31 downto 0) := (others => '0'); 
 
 	constant clk_period : time := 40 ns; 
 BEGIN 
   
 	-- Instantiate the Unit Under Test (UUT) 
 	pm1: Projeto_Mips PORT MAP ( 
 		ClkPc 						=> ClkPc, 
 		reset 					=> reset, 
 		NovoEndereco => NovoEndereco,
 		NovaInst => NovaInst
 	); 

 	process
 	begin 
 		ClkPc <= '0'; 
 		wait for clk_period/2; 
 		ClkPc <= '1'; 
 		wait for clk_period/2; 
	end process; 
  
    process 
 	begin				 
 		reset <= '0'; 
 		wait for 20 ns; 
 		wait for clk_period*10; 
 
		--TEST ADD  (1+2) 
		wait for clk_period; 
 		NovoEndereco	 <= "00000010000100011010000000100000";  
 		 
 		--TEST SLT

 		wait for clk_period; 
 		NovoEndereco	 <= "00000010001100101100000000101010";	 
 		  
 		wait for clk_period; 
 		NovoEndereco	 <= "00000010001100011100100000101010";	 
 		
 		wait for clk_period; 
 		NovoEndereco	 <= "00000010010100011101000000101010";	 
 		 
 		--TEST ADD  (4+1)
 		wait for clk_period; 
 		NovaInst 	<= NovoEndereco; 
 	
 		NovoEndereco	 <= "00000010000110111110000000100000"; 
 		wait for clk_period;

 		NovaInst 	<= NovoEndereco; 
 				 
		--JUMP 
 		wait for clk_period;
 		NovoEndereco	 <= "00001000000000000000000000000000"; 
			 
 		wait for clk_period;
		NovoEndereco	 <= "00001000000000001111000000001111";	 
 		 
		wait for clk_period; 
		 
 		wait; 
 	end process; 

END;