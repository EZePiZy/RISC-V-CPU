module CPU

import types_pkg::*;

(
	input logic clk,
	input logic rst,
	output DATA_BUS a0
);

// Data buses
DATA_BUS instruction, ALU_out, Imm_Op;

// control logic
logic RegWrite, PC_src, ALU_src;
alu_ctrl ALU_ctrl;
instr_format Imm_Src;

// operands
DATA_BUS Op1, RegRD2, Op2;

// flags
logic EQ_flag;

PC_ROM pc_rom (
	.ImmOp(Imm_Op),
	.clk (clk),
	.rst (rst),
	.PCsrc (PC_src),
	.dout (instruction)
);

REGFILE regfile(
	.clk(clk),
	.AD1(instruction[19:15]),
	.AD2(instruction[24:20]),
	.AD3(instruction[11:7]),
	.WE3(RegWrite),
	.WD3(ALU_out),
	.RD1(Op1),
	.RD2(RegRD2),
	.a0(a0)
);

assign Op2 = ALU_src ? Imm_Op : RegRD2; // mux to select between immediate and regfile out

ALU alu(
	.ALUop1(Op1),
	.ALUop2(Op2),
	.ALUctrl(ALU_ctrl),
	.SUM(ALU_out),
	.EQ(EQ_flag)
);

CONTROL_UNIT control_unit(
	.EQ(EQ_flag),
	.instr(instruction),
	.RegWrite(RegWrite),
	.ALUctrl(ALU_ctrl),
	.ALUsrc(ALU_src),
	.ImmSrc(Imm_Src),
	.PCsrc(PC_src)
);

SIGN_EXTEND sign_extend(
	.instr(instruction),
	.ImmSrc (Imm_Src),
	.ImmOp (Imm_Op)
);


endmodule
