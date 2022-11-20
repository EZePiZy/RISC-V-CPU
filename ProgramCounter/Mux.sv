module Mux(
    // input  logic [31:0] branch_PC,
    input  logic [31:0] PC, 
    input logic  [31:0] ImmOp, 
    // input  logic [31:0] inc_PC,
    input  logic        PCsrc,
    output logic [31:0] next_PC
); 


assign next_PC = PCsrc ? PC + ImmOp : PC + 32'b0100;


endmodule


