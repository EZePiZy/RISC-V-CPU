module PC_ROM

import types_pkg::*; 

(
    input DATA_BUS ImmOp,
    input logic clk,
    input logic rst,
    input logic PCsrc,
    output DATA_BUS PC,
    output logic [29:0] dout // Divided by 4
);

logic [31:0] next_PC;



PC ProgramCounter (
    .clk (clk),
    .rst (rst),
    .next_PC (PCsrc ? PC + ImmOp : PC + 32'b0100),
    .PC (PC)
);

ROM Rom (
    .addr(PC),
    /* verilator lint_off UNUSED */
    .dout(dout) 

    
);
    
endmodule






