module ALU #(
    parameter DATA_WIDTH = 32
) (
    input  logic [DATA_WIDTH-1:0]  ALUop1,
    input  logic [DATA_WIDTH-1:0]  ALUop2,
    input  logic [2:0]             ALUctrl,
    output logic [DATA_WIDTH-1:0]  SUM,
    output logic                   EQ
);

always_comb begin
    case (ALUctrl) 
        3'b000: SUM = ALUop1 + ALUop2;
        3'b001: SUM = ALUop1 - ALUop2;
        3'b010: SUM = ALUop1 & ALUop2;
        3'b101: SUM = ALUop1 < ALUop2 ? 1 : 0;
        default: SUM = 0;
    endcase

    EQ = ALUop1 == ALUop2;
end

endmodule
