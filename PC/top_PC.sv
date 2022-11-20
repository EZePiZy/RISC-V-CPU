module top_PC (
    input logic [31:0] ImmOp,
    input logic clk,
    input logic rst,
    input logic PCsrc,
    output logic [31:0] PC,
    output logic [29:0] dout
);

logic [31:0] next_PC;



PC ProgramCounter (
    .clk (clk),
    .rst (rst),
    .next_PC (next_PC),
    .PC (PC)
);

Mux Multiplexor (
    .PCsrc (PCsrc),
    .PC (PC),
    .ImmOp (ImmOp),
    .next_PC (next_PC)
);

rom sineRom (
    .addr(PC),
    /* verilator lint_off UNUSED */
    .dout(dout) 

    
);
    
endmodule






