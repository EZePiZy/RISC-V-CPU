module ALU 

import types_pkg::*;
(
    input  DATA_BUS ALUop1,
    input  DATA_BUS ALUop2,
    input  alu_ctrl ALUctrl,
    output DATA_BUS SUM,
    output logic    EQ
);

always_comb begin
    case (ALUctrl) 
        SUM_OP: SUM = ALUop1 + ALUop2;
        SUB_OP: SUM = ALUop1 - ALUop2;
        AND_OP: SUM = ALUop1 & ALUop2;
        SLT_OP: SUM = ALUop1 < ALUop2 ? 1 : 0;
        default: SUM = 0;
    endcase

    EQ = ALUop1 == ALUop2;
end

endmodule
