module MEMORY_WRITEBACK_REGISTER

import types_pkg::*; 

(
    input   logic           clk,
    input   DATA_BUS        ReadDataM_i,
    output  DATA_BUS        ReadDataW_o,
    input   DATA_BUS        PCPlus4M_i,
    output  DATA_BUS        PCPlus4W_o,
    input   DATA_BUS        ALU_outM_i,
    output  DATA_BUS        ALU_outW_o,
    input   logic           RegWriteM_i,
    output  logic           RegWriteW_o,
    input   logic           ResultSrcM_i,
    output  logic           ResultSrcW_o,
    input   logic           StoreNextPCM_i,
    output  logic           StoreNextPCW_o,
    input   ADDR_BUS   RdM_i,
    output  ADDR_BUS   RdW_o
);

always_ff @(negedge clk) begin
    ReadDataW_o <= ReadDataM_i;
    PCPlus4W_o <= PCPlus4M_i;
    ALU_outW_o <= ALU_outM_i;
    RegWriteW_o <= RegWriteM_i;
    ResultSrcW_o <= ResultSrcM_i;
    StoreNextPCW_o <= StoreNextPCM_i;
    RdW_o <= RdM_i;
end

endmodule 

