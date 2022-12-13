module FETCH_DECODE_REGISTER

import types_pkg::*; 

(
    input   logic       clk,
    input   DATA_BUS    instructionF_i,
    output  DATA_BUS    instructionD_o,
    input   DATA_BUS    PCF_i,
    output  DATA_BUS    PCD_o,
    input   DATA_BUS    PCPlus4F_i,
    output  DATA_BUS    PCPlus4D_o
);

always_ff @(negedge clk) begin
    instructionD_o <= instructionF_i;
    PCD_o <= PCF_i;
    PCPlus4D_o <= PCPlus4F_i;
end

endmodule 

