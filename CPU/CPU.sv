module CPU

import types_pkg::*;

(
  input logic clk,
  input logic rst,
  output DATA_BUS a0
);

// Data buses
DATA_BUS instruction, ALU_out, Imm_Op, ReadData, Result, PCPlus4;

// control logic
logic RegWrite, PC_src, ALU_src, MemWrite, ResultSrc, PC2Result, StoreNextPC;
alu_ctrl ALU_ctrl;
instr_format Imm_Src;

// operands
DATA_BUS OP1, RegRD2, OP2;

// flags
logic EQ_flag;

PC_ROM pc_rom (
  .ImmOp(Imm_Op),
  .Result(Result),
  .PC2Result(PC2Result),
  .clk (clk),
  .rst (rst),
  .PCsrc (PC_src),
  .dout (instruction),
  .PCPlus4(PCPlus4)
);

REGFILE regfile(
  .clk(clk),
  .AD1(instruction[19:15]),
  .AD2(instruction[24:20]),
  .AD3(instruction[11:7]),
  .WE3(RegWrite),
  .WD3(StoreNextPC ? PCPlus4 : Result),
  .RD1(OP1),
  .RD2(RegRD2),
  .a0(a0)
);

assign OP2 = ALU_src ? Imm_Op : RegRD2; // muxto select between immediate and regfile out

ALU alu(
  .ALUop1(OP1),
  .ALUop2(OP2),
  .ALUctrl(ALU_ctrl),
  .SUM(ALU_out),
  .EQ(EQ_flag)
);

DATA_MEMORY data_memory(
  .clk(clk),
  .A(ALU_out),
  .WE(MemWrite),
  .WD(RegRD2),
  .RD(ReadData)
);

assign Result = ResultSrc ?  ReadData : ALU_out; // Mux to select between ALU's output and the Data Memories Output

CONTROL_UNIT control_unit(
  .EQ(EQ_flag),
  .instr(instruction),
  .RegWrite(RegWrite),
  .ALUctrl(ALU_ctrl),
  .ALUsrc(ALU_src),
  .ImmSrc(Imm_Src),
  .PCsrc(PC_src),
  .MemWrite(MemWrite),
  .ResultSrc(ResultSrc),
  .jumpSaveNext (StoreNextPC),
  .PC2Result (PC2Result)
);

SIGN_EXTEND sign_extend(
  .instr(instruction),
  .ImmSrc (Imm_Src),
  .ImmOp (Imm_Op)
);


endmodule
