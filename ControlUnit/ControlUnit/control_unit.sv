module control_unit #(
	parameter DATA_WIDHT = 32, 
	parameter IMM_WIDTH = 3, // number of bits needed to encode possible immediate formats
	parameter ALU_WIDTH = 2, // number of bits needed to encode possible ALU commands
	parameter OPCODE_WIDTH = 7 // number of bits to encode opcodes
)(
	input 	logic 					EQ,
	input 	logic [DATA_WIDHT-1:0] 	instr,		// incoming instruction
	output 	logic 					RegWrite,	// enable to write regs
	output 	logic [ALU_WIDTH-1:0] 	ALUctrl,	// value to select operation in alu
	output 	logic 					ALUsrc,		// mux to select immediate
	output 	logic [IMM_WIDTH-1:0] 	ImmSrc,		// value to select imm type
	output 	logic 					PCsrc		// mux to select branching
);

typedef enum bit[IMM_WIDTH-1:0] {Imm, UpperImm, Store, Branch, Jump } instr_format;

typedef enum bit[OPCODE_WIDTH-1:0] {addi = 7'b0010011, bne = 7'b1100011, lw = 7'b0000011} opcode;

opcode curr_opcode = opcode'(instr[6:0]); // extract opcode and type cast it

always_comb begin
	case (curr_opcode)
		addi: begin					
			RegWrite = 1;
			instr_format ImmOut = Imm; 	// jank code
			ImmSrc = ImmOut;			// jank code
			ALUsrc = 1; // select ImmOp as operand
			ALUctrl = 2'b0; // asumming this is correct format
		end
		bne: if (EQ) begin
				instr_format ImmOut = Branch; 	// jank code
				ImmSrc = ImmOut;				// jank code
				PCsrc = 1; // make branching happend
			end
		default: ALUsrc = 0; //do something for default
	endcase
end

endmodule
