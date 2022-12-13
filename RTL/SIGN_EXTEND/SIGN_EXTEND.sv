module SIGN_EXTEND 

import types_pkg::*;

(
  // trick to compile even with -Wall option
  /* verilator lint_off UNUSED */
  input  DATA_BUS     instr,
  /* verilator lint_on UNUSED */
  input  instr_format ImmSrc,
  output DATA_BUS     ImmOp
);

always_comb 
  case (ImmSrc)
    Imm:      ImmOp = {instr[31] ? 20'hFFFFF : 20'h0, instr[31:20]}; // sign extend and concat with original 
    Store:    ImmOp = {instr[31] ? 20'hFFFFF : 20'h0, instr[31:25], instr[11:7]};
    UpperImm: ImmOp = {instr[31:12], 12'b0}; //Extended bottom 12 bits as 0's
    Branch:   ImmOp = {instr[31] ? 19'h7FFFF : 19'h0, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0};
    Jump:     ImmOp = {instr[31] ? 11'h7FF : 11'h0, instr[31], instr[19:12], instr[20], instr[30:21], 1'b0};
    default:  ImmOp = {instr[31] ? 20'hFFFFF : 20'h0, instr[31:20]}; // in the defualt case treat as if it were a normal immediate
  endcase

endmodule
