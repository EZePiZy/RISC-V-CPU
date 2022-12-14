module CPU

import types_pkg::*;

(
  input   logic     clk,
  input   logic     rst,
  output  DATA_BUS  a0
  );

//----------------------------------------------------------------------- Wire Definition

//------------------ Register Addresses
//Fetch

//Decode

//Execute
ADDR_BUS RdE;
// Delayed AD3 {5} |

//Memory
ADDR_BUS RdM;
// Delayed AD3 {5} |

//Write Back
ADDR_BUS RdW;
// Delayed AD3 {5} |

//------------------ Data buses

//Fetch
DATA_BUS PCF, InstructionF, PCPlus4F,  Next_PCF;
//Program Counter{32} | Instruction{32} | Program Counter + 4 {32} | Next PC to load {32} |

//Decode
DATA_BUS PCD, InstructionD, PCPlus4D, Imm_OpD;
//Program Counter{32} | Instruction{32} | Program Counter + 4 {32} | Sign Extended Immediate Op {32} |

//Execute
DATA_BUS PCE, InstructionE, PCPlus4E, Imm_OpE, ALU_outE, PCTargetE;
//Program Counter{32} | Program Counter + 4 {32} | Sign Extended Immediate Op {32} | Output of the ALU {32} | Either current Pc or Imm {32} |

//Memory
DATA_BUS InstructionM, ReadDataM, PCPlus4M, ALU_outM;
//Data Output From Data Memory {32} | Program Counter + 4 {32} | Output of the ALU {32} |

//Write Back
DATA_BUS InstructionW, ReadDataW, ResultW, PCPlus4W, ALU_outW;

// ----------------control logic

//Fetch
//--------------Empty as no control logic comes from the fetch section

//Decode
logic RegWriteD, ALU_srcD, MemWriteD, ResultSrcD, StoreNextPCD, JumpImmTypeD, JumpResultTypeD, BranchTypeD, MemExtendD;
alu_ctrl ALU_ctrlD;
instr_format Imm_SrcD; 
byte_format ByteSelectD;

//Execute
logic RegWriteE, ALU_srcE, MemWriteE, ResultSrcE, StoreNextPCE, JumpImmTypeE, JumpResultTypeE, BranchTypeE, MemExtendE, PC_srcE;
alu_ctrl ALU_ctrlE;
byte_format ByteSelectE;

//Memory
logic RegWriteM, MemWriteM, ResultSrcM, StoreNextPCM, MemExtendM;
byte_format ByteSelectM;

//Write Back
logic RegWriteW, ResultSrcW, StoreNextPCW;

// ----------------operands
//Fetch

//Decode
DATA_BUS OP1D, RegRD2D;
//Execute
DATA_BUS OP1E, RegRD2E, OP2E;
//Memory
DATA_BUS WriteDataM;
//Write Back

// ----------------flags

//Fetch

//Decode

//Execute
logic EQ_flagE;

//Memory

//Write Back


//-------------------------------------------------------------------------------Fetch Block


assign PCPlus4F = PCF + 32'h4; // Set the wire PCPlus4F to the value of the fetch block PC plus 4
assign Next_PCF = PC_srcE ? (JumpResultTypeE ? ResultW : PCTargetE) : (PCPlus4F); //Use PCTarget, PC_src from execute with result from write back to find the next pc value

PC pc(
  .next_PC (Next_PCF), 
  .clk (clk),
  .rst (rst),
  .PC (PCF)
);


ROM rom(
  .addr(PCF),
  .dout(InstructionF)
);

//--------------------------------------------------------------------------------Register Block

FETCH_DECODE_REGISTER fetch_decode_register (
  .clk(clk),
  .InstructionF_i(InstructionF),
  .InstructionD_o(InstructionD),
  .PCF_i(PCF),
  .PCD_o(PCD),
  .PCPlus4F_i(PCPlus4F),
  .PCPlus4D_o(PCPlus4D)
);

//--------------------------------------------------------------------------------Decode Block


REGFILE regfile(
  .clk(clk),
  .AD1(InstructionD[19:15]),
  .AD2(InstructionD[24:20]),
  .AD3(RdW),
  .WE3(RegWriteW),
  .WD3(StoreNextPCW ? PCPlus4W : ResultW),  
  .RD1(OP1D),
  .RD2(RegRD2D),
  .a0(a0)
);

CONTROL_UNIT control_unit(
  .instr(InstructionD),
  .RegWrite(RegWriteD),
  .ALUctrl(ALU_ctrlD),
  .ALUsrc(ALU_srcD),
  .ImmSrc(Imm_SrcD),
  .MemWrite(MemWriteD),
  .ResultSrc(ResultSrcD),
  .WriteNextPC (StoreNextPCD),
  .ByteSelect (ByteSelectD),
  .MemExtend(MemExtendD),
  .BranchType(BranchTypeD),
  .JumpImmType(JumpImmTypeD),
  .JumpResultType(JumpResultTypeD)
);

SIGN_EXTEND sign_extend(
  .instr(InstructionD),
  .ImmSrc (Imm_SrcD),
  .ImmOp (Imm_OpD)
);

//--------------------------------------------------------------------------------------- Register Block

DECODE_EXECUTE_REGISTER decode_execute_register (
  .clk(clk),
  .PCD_i(PCD),
  .PCE_o(PCE),
  .PCPlus4D_i(PCPlus4D),
  .PCPlus4E_o(PCPlus4E),
  .Imm_OpD_i(Imm_OpD),
  .Imm_OpE_o(Imm_OpE),
  .RegWriteD_i(RegWriteD),
  .RegWriteE_o(RegWriteE),
  .ALU_srcD_i(ALU_srcD),
  .ALU_srcE_o(ALU_srcE),
  .MemWriteD_i(MemWriteD),
  .MemWriteE_o(MemWriteE),
  .ResultSrcD_i(ResultSrcD),
  .ResultSrcE_o(ResultSrcE),
  .StoreNextPCD_i(StoreNextPCD),
  .StoreNextPCE_o(StoreNextPCE),
  .JumpImmTypeD_i(JumpImmTypeD),
  .JumpImmTypeE_o(JumpImmTypeE),
  .JumpResultTypeD_i(JumpResultTypeD),
  .JumpResultTypeE_o(JumpResultTypeE),
  .BranchTypeD_i(BranchTypeD),
  .BranchTypeE_o(BranchTypeE),
  .MemExtendD_i(MemExtendD),
  .MemExtendE_o(MemExtendE),
  .ALU_ctrlD_i(ALU_ctrlD),
  .ALU_ctrlE_o(ALU_ctrlE),
  .ByteSelectD_i(ByteSelectD),
  .ByteSelectE_o(ByteSelectE),
  .OP1D_i(OP1D),
  .OP1E_o(OP1E),
  .RegRD2D_i(RegRD2D),
  .RegRD2E_o(RegRD2E),
  .RdD_i(InstructionD[11:7]),
  .RdE_o(RdE),
  .InstructionD_i(InstructionD),
  .InstructionE_o(InstructionE)
);

//--------------------------------------------------------------------------------------- Execute Block

assign OP2E = ALU_srcE ? Imm_OpE : RegRD2E; // mux to select between immediate and regfile out

assign PCTargetE = PCE + Imm_OpE; //Calculate the value of PC + Imm_Op from 2 cycles before

ALU alu(
  .ALUop1(OP1E),
  .ALUop2(OP2E),
  .ALUctrl(ALU_ctrlE),
  .ALUresult(ALU_outE),
  .EQ(EQ_flagE)
);


assign PC_srcE = JumpImmTypeE | JumpResultTypeE | (BranchTypeE & !EQ_flagE); //Logic to decide how pc should be changed for the next cycle

//-------------------------------------------------------------------------------------- Register Block

EXECUTE_MEMORY_REGISTER execute_memory_register (
  .clk(clk),
  .PCPlus4E_i(PCPlus4E),
  .PCPlus4M_o(PCPlus4M),
  .ALU_outE_i(ALU_outE),
  .ALU_outM_o(ALU_outM),
  .RdE_i(RdE),
  .RdM_o(RdM),
  .RegWriteE_i(RegWriteE),
  .RegWriteM_o(RegWriteM),
  .MemWriteE_i(MemWriteE),
  .MemWriteM_o(MemWriteM),
  .ResultSrcE_i(ResultSrcE),
  .ResultSrcM_o(ResultSrcM),
  .StoreNextPCE_i(StoreNextPCE),
  .StoreNextPCM_o(StoreNextPCM),
  .MemExtendE_i(MemExtendE),
  .MemExtendM_o(MemExtendM),
  .ByteSelectE_i(ByteSelectE),
  .ByteSelectM_o(ByteSelectM),
  .WriteDataE_i(RegRD2E),
  .WriteDataM_o(WriteDataM),
  .InstructionE_i(InstructionE),
  .InstructionM_o(InstructionM)
);

//-------------------------------------------------------------------------------------- Memory Block

DATA_MEMORY DATA_MEMORY(
  .clk(clk),
  .A(ALU_outM),
  .WE(MemWriteM),
  .WD(WriteDataM),
  .RD(ReadDataM),
  .ByteSelect(ByteSelectM),
  .SignExtend(MemExtendM)
);

//------------------------------------------------------------------------------------- Register Block

MEMORY_WRITEBACK_REGISTER memory_writeback_register (
  .clk(clk),
  .ReadDataM_i(ReadDataM),
  .ReadDataW_o(ReadDataW),
  .PCPlus4M_i(PCPlus4M),
  .PCPlus4W_o(PCPlus4W),
  .ALU_outM_i(ALU_outM),
  .ALU_outW_o(ALU_outW),
  .RegWriteM_i(RegWriteM),
  .RegWriteW_o(RegWriteW),
  .ResultSrcM_i(ResultSrcM),
  .ResultSrcW_o(ResultSrcW),
  .StoreNextPCM_i(StoreNextPCM),
  .StoreNextPCW_o(StoreNextPCW),
  .RdM_i(RdM),
  .RdW_o(RdW),
  .InstructionM_i(InstructionM),
  .InstructionW_o(InstructionW)
);

//------------------------------------------------------------------------------------- Write Back Block

assign ResultW = ResultSrcW ?  ReadDataW : ALU_outW; // Mux to select between ALU's output and the Data Memories Output
endmodule
