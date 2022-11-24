package types_pkg;
	parameter DATA_WIDHT = 32; 
	parameter IMM_WIDTH = 3; // number of bits needed to encode possible immediate formats
	parameter ALU_WIDTH = 2; // number of bits needed to encode possible ALU commands
	parameter OPCODE_WIDTH = 7; // number of bits to encode opcodes

	// possible formats for immediates
	typedef enum bit[IMM_WIDTH-1:0] {Imm, UpperImm, Store, Branch, Jump } instr_format;

	// mapping of opcodes to binary value
	typedef enum bit[OPCODE_WIDTH-1:0] {addi = 7'b0010011, bne = 7'b1100011, lw = 7'b0000011} opcode;
	
	// mapping ALU operations
	typedef enum bit[ALU_WIDTH-1:0] {Sum, Sub, And} alu_ctrl;

	typedef logic [DATA_WIDHT-1:0] DATA_BUS;
endpackage
