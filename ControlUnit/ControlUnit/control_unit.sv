module control_unit 

import types_pkg::*; // import all data type definitions

// #(
// 	parameter DATA_WIDHT = 32, 
// 	parameter IMM_WIDTH = 3, // number of bits needed to encode possible immediate formats
// 	parameter ALU_WIDTH = 2, // number of bits needed to encode possible ALU commands
// 	parameter OPCODE_WIDTH = 7 // number of bits to encode opcodes
// )
(
	input 	logic 					EQ,
	/* verilator lint_off UNUSED */
	input 	logic [DATA_WIDHT-1:0] 	instr,		// incoming instruction
	output 	logic 					RegWrite,	// enable to write regs
	output 	alu_ctrl 				ALUctrl,	// value to select operation in alu
	output 	logic 					ALUsrc,		// mux to select immediate
	// output 	logic [IMM_WIDTH-1:0] 	ImmSrc,		// value to select imm type  OLD way
	output 	instr_format 			ImmSrc,		// value to select imm type
	output 	logic 					PCsrc		// mux to select branching
);

opcode curr_opcode = opcode'(instr[6:0]); // extract opcode and type cast it

always_comb begin
	case (curr_opcode)
		addi: begin					
			RegWrite = 1;
			ImmSrc = Imm;	// normal immediate (12 bits)
			ALUsrc = 1; 	// select ImmOp as operand
			ALUctrl = Sum; 	// asumming this is correct format
		end
		bne: if (EQ) begin
				ImmSrc = Branch;	// branch immediate (13 bits) casted to the correct size
				PCsrc = 1; // make branching happend
			end
		default: ALUsrc = 0; //do something for default
	endcase
end

endmodule
