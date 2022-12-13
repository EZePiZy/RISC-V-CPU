module PC_ROM

import types_pkg::*; 

//TODO CHANGE TO BE IN TOP FILE!!!!!!!!! --CONFUSING >:(

(
    input   DATA_BUS  ImmOp,
    input   DATA_BUS  Result,
    input   logic     clk,
    input   logic     rst,
    input   logic     PCsrc,
    input   logic     JumpType,
    output  DATA_BUS  dout,
    output  DATA_BUS  PCPlus4 
);

DATA_BUS PC;
assign PCPlus4 = PC + 32'b0100;

PC ProgramCounter (
    .clk (clk),
    .rst (rst),
    .next_PC (PCsrc ? PC + ImmOp : (JumpType ? Result : PC + 32'b0100)),
    .PC (PC)
);

ROM Rom (
    .addr(PC),
    .dout(dout)
);
    
endmodule






