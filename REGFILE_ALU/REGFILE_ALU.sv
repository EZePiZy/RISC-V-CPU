module REGFILE_ALU #(
    parameter ADDRESS_WIDTH = 5,
              DATA_WIDTH = 32
) (
    input  logic                     clk,
    input  logic                     ALUsrc,
    input  logic                     RegWrite,
    input  logic                     jumpSaveNext
    input  DATA_BUS                  next_PC
    input  logic [31:0]              ImmOp,
    input  logic [2:0]               ALUctrl,
    input  logic [ADDRESS_WIDTH-1:0] rs1,
    input  logic [ADDRESS_WIDTH-1:0] rs2,
    input  logic [ADDRESS_WIDTH-1:0] rd,
    output logic                     EQ,
    output logic [DATA_WIDTH-1:0]    a0
);

logic [DATA_WIDTH-1:0] WD3;
logic [DATA_WIDTH-1:0] ALUop1;
logic [DATA_WIDTH-1:0] regOp2;

REGFILE regfile (
    .clk(clk),
    .AD1(rs1),
    .AD2(rs2),
    .AD3(rd),
    .WE3(RegWrite),
    .WD3(jumpSaveNext ? next_PC : WD3),
    .RD1(ALUop1),
    .RD2(regOp2),
    .a0(a0)
);

ALU alu (
    .ALUop1(ALUop1),
    .ALUop2(ALUsrc ? ImmOp : regOp2),
    .ALUctrl(ALUctrl),
    .SUM(WD3),
    .EQ(EQ)
);

endmodule
