module sign_extend #(
	parameter DATA_WIDHT = 32,
	parameter IMM_BIT = 3 // how many bits are needed to encode all instructions formats
)(
	// trick to compile even with -Wall option
	/* verilator lint_off UNUSED */ 
	input logic 	[DATA_WIDHT-1:0] 	instr,
	input logic 	[IMM_BIT-1:0] 		ImmSrc,
	output logic 	[DATA_WIDHT-1:0] 	ImmOp
);

typedef enum bit[IMM_BIT-1:0] {Imm, UpperImm, Store, Branch, Jump } instr_format;

instr_format ImmFormat = instr_format'(ImmSrc); // casting ImmSrc to instr format for readablity
always_comb 
	case (ImmFormat)
		Imm: 		ImmOp = {instr[31] ? 20'hFFFFF : 20'h0, instr[31:20]}; // sign extend and concat with original 
		UpperImm: 	ImmOp = {instr[31:20], 20'b0}; // no sign extension
		Store: 		ImmOp = {instr[31] ? 20'hFFFFF : 20'h0, instr[31:25], instr[11:7]};
		Branch: 	ImmOp = {instr[31] ? 19'h7FFFF : 19'h0, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0};
		Jump: 		ImmOp = {instr[31] ? 11'h7FF : 11'h0, instr[31], instr[19:12], instr[20], instr[30:21], 1'b0};
		default:	ImmOp = {instr[31] ? 20'hFFFFF : 20'h0, instr[31:20]}; // in the defualt case treat as if it were a normal immediate
	endcase

endmodule
