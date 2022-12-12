module CPU

import types_pkg::*;

(
  input   logic     clk,
  input   logic     rst,
  input   DATA_BUS  input_reg,
  input   logic     write_in_EN,
  output  DATA_BUS  x31,
  output  DATA_BUS  a0,
  output  DATA_BUS  PC
);

// Data buses
DATA_BUS instruction, ALU_out, Imm_Op, ReadData, Result;

// control logic
logic RegWrite, PC_src, ALU_src, MemWrite, ResultSrc, StoreNextPC, JumpImmType, JumpResultType, BranchType, MemExtend;
alu_ctrl ALU_ctrl;
instr_format Imm_Src;
byte_format ByteSelect;

// operands
DATA_BUS OP1, RegRD2, OP2;

// flags
logic EQ_flag;


assign PC_src = JumpImmType | JumpResultType | (BranchType & !EQ_flag);

PC pc(
  .next_PC (PC_src ? (JumpResultType ? Result : (PC + Imm_Op)) : (PC + 32'h4)), 
  .clk (clk),
  .rst (rst),
  .PC (PC)
);


ROM rom(
  .addr(PC),
  .dout(instruction)
);


REGFILE regfile(
  .clk(clk),
  .AD1(instruction[19:15]),
  .AD2(instruction[24:20]),
  .AD3(instruction[11:7]),
  .WE3(RegWrite),
  .WD3(StoreNextPC ? (PC + 32'b0100) : Result),
  .x31_in(input_reg),
  .in_EN(write_in_EN),
  .RD1(OP1),
  .RD2(RegRD2),
  .a0(a0),
  .x31_out(x31)
);

assign OP2 = ALU_src ? Imm_Op : RegRD2; // mux to select between immediate and regfile out

ALU alu(
  .ALUop1(OP1),
  .ALUop2(OP2),
  .ALUctrl(ALU_ctrl),
  .ALUresult(ALU_out),
  .EQ(EQ_flag)
);

DATA_MEMORY DATA_MEMORY(
  .clk(clk),
  .A(ALU_out),
  .WE(MemWrite),
  .WD(RegRD2),
  .RD(ReadData),
  .ByteSelect(ByteSelect),
  .SignExtend(MemExtend)
);

assign Result = ResultSrc ?  ReadData : ALU_out; // Mux to select between ALU's output and the Data Memories Output

CONTROL_UNIT control_unit(
  .instr(instruction),
  .RegWrite(RegWrite),
  .ALUctrl(ALU_ctrl),
  .ALUsrc(ALU_src),
  .ImmSrc(Imm_Src),
  .MemWrite(MemWrite),
  .ResultSrc(ResultSrc),
  .WriteNextPC (StoreNextPC),
  .ByteSelect (ByteSelect),
  .MemExtend(MemExtend),
  .BranchType(BranchType),
  .JumpImmType(JumpImmType),
  .JumpResultType(JumpResultType)
);

SIGN_EXTEND sign_extend(
  .instr(instruction),
  .ImmSrc (Imm_Src),
  .ImmOp (Imm_Op)
);


endmodule
