module EXECUTE_MEMORY_REGISTER

import types_pkg::*; 

(
    input  logic       clk,
    input  DATA_BUS    PCPlus4E_i,
    output DATA_BUS    PCPlus4M_o,
    input  DATA_BUS    ALU_outE_i,
    output DATA_BUS    ALU_outM_o,
    input  ADDR_BUS    RdE_i,
    output ADDR_BUS    RdM_o,
    input  logic       RegWriteE_i, 
    output logic       RegWriteM_o,
    input  logic       MemWriteE_i,
    output logic       MemWriteM_o,
    input  logic       ResultSrcE_i,
    output logic       ResultSrcM_o,
    input  logic       StoreNextPCE_i,
    output logic       StoreNextPCM_o,
    input  logic       MemExtendE_i,
    output logic       MemExtendM_o,
    input  byte_format ByteSelectE_i,
    output byte_format ByteSelectM_o,
    input  DATA_BUS    WriteDataE_i,
    output DATA_BUS    WriteDataM_o,
    input  DATA_BUS    InstructionE_i,
    output DATA_BUS    InstructionM_o
);

always_ff @(negedge clk) begin
    PCPlus4M_o <= PCPlus4E_i;
    ALU_outM_o <= ALU_outE_i;
    RdM_o <= RdE_i;
    RegWriteM_o <= RegWriteE_i;
    MemWriteM_o <= MemWriteE_i;
    ResultSrcM_o <= ResultSrcE_i;
    StoreNextPCM_o <= StoreNextPCE_i;
    MemExtendM_o <= MemExtendE_i;
    ByteSelectM_o <= ByteSelectE_i;
    WriteDataM_o <= WriteDataE_i;
    InstructionM_o <= InstructionE_i;
end

endmodule 
