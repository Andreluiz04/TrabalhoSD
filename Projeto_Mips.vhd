library ieee; 
USE ieee.std_logic_1164.all; 
USE ieee.std_logic_unsigned.all; 
USE ieee.std_logic_arith.all; 

entity Projeto_Mips is
	port(
		ClkPc: in std_logic;
		reset: in std_logic;
		NovoEndereco: in std_logic_vector(31 downto 0);
		NovaInst: in std_logic_vector(31 downto 0)
	);
end entity;


architecture Projeto_Mips_Arc of Projeto_Mips is
	
	component ADD_JP is
	port(
		a: in std_logic_vector(31 downto 0);
		b: in std_logic_vector(31 downto 0);
		s: out std_logic_vector(31 downto 0)
	);
	end component;

	component Ext_Sinal_16_para_32 is
 	port( 
 		entrada: in std_logic_vector( 15 downto 0 ); 
 		saida: out std_logic_vector( 31 downto 0 ) 
 	); 
	end component; 

	component ALU is
	port( 
		op: in std_logic_vector(2 downto 0);
		a: in std_logic_vector(31 downto 0);
		b: in std_logic_vector(31 downto 0);
		zero: out std_logic;
		resultado: out std_logic_vector(31 downto 0)
	);
	end component;

	component Banco_Registrador is 
	port(
		ClkPC: in std_logic;
		RegWrite: in std_logic;
		reg1: in std_logic_vector(4 downto 0);
		reg2: in std_logic_vector(4 downto 0);
		writeReg: in std_logic_vector(4 downto 0);
		writeDado: in std_logic_vector(31 downto 0);
		dado1: out std_logic_vector(31 downto 0);
		dado2: out std_logic_vector(31 downto 0)
	);
	end component;

	component Controle_Mips is
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
	end component;

	component CONTROLE_ALU is
	port(
		ALuOp: in std_logic_vector(1 downto 0);
		funct: in std_logic_vector(5 downto 0);
		JR: out std_logic;
		operacao: out std_logic_vector(2 downto 0)
	);
	end component;

	component memoria is 
	port( 
		clk: in std_logic; 
 		MemRead: in std_logic; 
 		MemWrite: in std_logic; 
 		endereco: in std_logic_vector( 31 downto 0 ); 
 		writeDado: in std_logic_vector( 31 downto 0 ); 
 		saida: out std_logic_vector( 31 downto 0 ) 
 	); 
	end component;

	component Instrucao_Memoria is
	port(
		Escrita_Inst: in std_logic_vector(31 downto 0);
		endereco: in std_logic_vector(31 downto 0);
		Nova_Inst: in std_logic_vector(31 downto 0);
		saida: out std_logic_vector(31 downto 0)
	);
	end component;

	component PC is 
	port( 
		clk: in std_logic; 
		reset: in std_logic; 
 		input: in std_logic_vector( 31 downto 0 ); 
 		output: out std_logic_vector( 31 downto 0 ) 
 	); 
	end component; 

	component Mux_2X1_5Bits is
	port(
		selecao: in std_logic;
		a: in std_logic_vector(4 downto 0); --do 20 ao 16 na entrada do mux do banco de registradores.
		b: in std_logic_vector(4 downto 0); --do 15 ao 11 na entrada do mux do banco de registradores.
		saida: out std_logic_vector(4 downto 0)
	);
	end component;

	component Mux_2x1_32Bits is 
 	port( 
 		controle: in std_logic; 
 		a: in std_logic_vector( 31 downto 0 ); 
 		b: in std_logic_vector( 31 downto 0 ); 
		saida: out std_logic_vector( 31 downto 0 ) 
	); 
	end component; 


	component Rot_Esq is 
	port( 
		input: in std_logic_vector( 31 downto 0 ); 
		output: out std_logic_vector( 31 downto 0 ) 
 	); 
	end component; 

	constant Quatro: std_logic_vector( 31 downto 0 ) := "00000000000000000000000000000100";


	signal S_Input, S_Output, S_Inst: std_logic_vector(31 downto 0);
	signal S_RegDst, S_Branch, S_MemRead, S_MemtoReg, S_MemWrite, S_ALUSrc, S_RegWrite, S_Jump: std_logic;
	signal S_ULAOP: std_logic_vector(1 downto 0);
	signal S_Mux_5Bits: std_logic_vector(4 downto 0);
	signal S_Saida32: std_logic_vector(31 downto 0);
	signal S_JR: std_logic;
	signal S_Op: std_logic_vector(2 downto 0);
	signal S_AluOp: std_logic_vector(1 downto 0);
	signal S_RS, S_RD: std_logic_vector(4 downto 0);
	signal S_WriteDado: std_logic_vector(31 downto 0);
	signal S_Dado1, S_Dado2: std_logic_vector(31 downto 0);
	signal S_SaidaDado2: std_logic_vector(31 downto 0);
	signal S_Zero: std_logic;
	signal S_Resultado: std_logic_vector(31 downto 0);
	signal S_SaidaDadoMem: std_logic_vector(31 downto 0);
	signal S_SaidaMuxMem: std_logic_vector(31 downto 0);
	signal PC_Mais_Quatro: std_logic_vector(31 downto 0);
	signal S_Saida32Final: std_logic_vector(31 downto 0);
	signal Cond_Endereco: std_logic_vector(31 downto 0);
	signal Condicao_PC: Std_logic_vector(31 downto 0);
	signal S_Nova_Inst: std_logic_vector(31 downto 0);
	signal Selecao_Condicao: std_logic;


begin
	SaidaPc: PC port map(ClkPc, reset, S_Input, S_Output);
	Saida_Instrucao_Memoria: Instrucao_Memoria port map(NovoEndereco,S_output,S_Nova_Inst, S_Inst);
	Saida_Controle_Mips: Controle_Mips port map(S_Inst(31 downto 26),S_RegDst, S_Branch, S_MemRead, S_MemtoReg, S_MemWrite, S_ALUSrc, S_RegWrite, S_Jump, S_ULAOP);
	Saida_Mux_2X1_5Bits: Mux_2X1_5Bits port map(S_RegDst, S_Inst(20 downto 16), S_Inst(15 downto 11), S_Mux_5Bits);
	Saida_Ext_Sinal_16_para_32: Ext_Sinal_16_para_32 port map(S_Inst(15 downto 0), S_Saida32);
	Saida_CONTROLE_ALU: CONTROLE_ALU port map(S_AluOp, S_Inst(5 downto 0),S_JR, S_Op);
	Saida_Banco_Registrador: Banco_Registrador port map(ClkPc,S_RegWrite, S_RS, S_Inst(20 downto 16), S_RD, S_WriteDado, S_Dado1, S_Dado2);
	Saida_Mux1_2X1_32Bits:Mux_2X1_32Bits port map(S_ALUSrc, S_Dado2, S_Saida32, S_SaidaDado2);
	Saida_ALU: ALU port map(S_Op, S_Dado1, S_SaidaDado2, S_Zero, S_Resultado);
	Saida_memoria: memoria port map(ClkPc, S_MemRead, S_MemWrite, S_Resultado, S_Dado2,S_SaidaDadoMem);
	Saida_Mux2_2X1_32Bits:Mux_2X1_32Bits port map(S_MemtoReg, S_Resultado, S_SaidaDadoMem, S_SaidaMuxMem);
	Saida_ADD_JP: ADD_JP port map(S_Output, Quatro, PC_Mais_Quatro);
	Saida_Rot_Esq: Rot_Esq port map(S_Saida32, S_Saida32Final);
	Saida_ADD1_JP: ADD_JP port map(PC_Mais_Quatro, S_Saida32Final, Cond_Endereco);
	Selecao_Condicao <= S_Branch AND S_Zero;
	Saida_Mux3_2X1_32Bits:Mux_2X1_32Bits port map(Selecao_Condicao, PC_Mais_Quatro, Cond_Endereco, Condicao_PC);

end architecture;