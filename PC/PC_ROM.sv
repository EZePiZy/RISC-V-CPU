module PC_ROM

import types_pkg::*; 

(
    input   DATA_BUS  ImmOp,
    input   logic     clk,
    input   logic     rst,
    input   logic     PCsrc,
    output  DATA_BUS  dout 
);

DATA_BUS PC;

PC ProgramCounter (
    .clk (clk),
    .rst (rst),
    .next_PC (PCsrc ? PC + ImmOp : PC + 32'b0100),
    .PC (PC)
);

ROM Rom (
    .addr(PC),
    .dout(dout)
);
    
endmodule






