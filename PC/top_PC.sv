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
    .next_PC (PCsrc ? PC + ImmOp : PC + 32'b0100),
    .PC (PC)
);

rom Rom (
    .addr(PC),
    /* verilator lint_off UNUSED */
    .dout(dout) 

    
);
    
endmodule






