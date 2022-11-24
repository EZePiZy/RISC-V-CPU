module CONTROL_UNIT 

import types_pkg::*; // import all data type definitions

(
	input 	logic 		 EQ,
	/* verilator lint_off UNUSED */
	input 	DATA_BUS 	 instr,		// incoming instruction
	output 	logic 		 RegWrite,	// enable to write regs
	output 	alu_ctrl 	 ALUctrl,	// value to select operation in alu
	output 	logic 		 ALUsrc,		// mux to select immediate
	output 	instr_format ImmSrc,		// value to select imm type
	output 	logic 		 PCsrc		// mux to select branching
);

opcode curr_opcode = opcode'(instr[6:0]); // extract opcode and type cast it

always_comb begin
	// set default values 
	RegWrite = 0;
	ALUctrl = Sum; 	// 2'b0
	ALUsrc = 0;
	ImmSrc = Imm;	// 3'b0
	PCsrc = 0;

	case (curr_opcode)
		addi: begin					
			RegWrite = 1;
			ImmSrc = Imm;	// normal immediate (12 bits)
			ALUsrc = 1; 	// select ImmOp as operand
			ALUctrl = SUM_OP; 	// asumming this is correct format
		end
		bne: if (EQ) begin
				ImmSrc = Branch;	// branch immediate (13 bits) casted to the correct size
				PCsrc = 1; // make branching happend
				RegWrite = 0;
			end
		default: begin
			ALUsrc = 0; //do something for default
			RegWrite = 0; // make sure nothing is being written to
		end
	endcase
end

endmodule
