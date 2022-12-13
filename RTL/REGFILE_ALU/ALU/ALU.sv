module ALU 

import types_pkg::*;
(
    input  DATA_BUS ALUop1,
    input  DATA_BUS ALUop2,
    input  alu_ctrl ALUctrl,
    output DATA_BUS ALUresult,
    output logic    EQ
);

always_comb begin
    case (ALUctrl) 
        SUM_OP: ALUresult = ALUop1 + ALUop2;
        SUB_OP: ALUresult = ALUop1 - ALUop2;
        AND_OP: ALUresult = ALUop1 & ALUop2;
        SLT_OP: ALUresult = ALUop1 < ALUop2 ? 1 : 0;
        SLL_OP: ALUresult = ALUop1 << ALUop2;
        UIM_OP: ALUresult = ALUop2;  // load upper immediate
        default: ALUresult = 0;
    endcase

    EQ = ALUop1 == ALUop2;
end

endmodule
