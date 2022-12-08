module PC_ROM

import types_pkg::*; 

//TODO CHANGE TO BE IN TOP FILE!!!!!!!!! --CONFUSING >:(

(
    input   DATA_BUS  ImmOp,
    input   DATA_BUS  Result,
    input   logic     clk,
    input   logic     rst,
    input   logic     PCsrc,
    input   logic     PC2Result,
    output  DATA_BUS  dout 
);

DATA_BUS PC;

PC ProgramCounter (
    .clk (clk),
    .rst (rst),
    .next_PC (PCsrc ? PC + ImmOp : (PC2Result ? Result : PC + 32'b0100)),
    .PC (PC)
);

ROM Rom (
    .addr(PC),
    .dout(dout)
);
    
endmodule






