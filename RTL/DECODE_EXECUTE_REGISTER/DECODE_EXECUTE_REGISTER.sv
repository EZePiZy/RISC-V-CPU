module DECODE_EXECUTE_REGISTER

import types_pkg::*; 

(
    input   logic           clk,
    input   DATA_BUS        PCD_i,
    output  DATA_BUS        PCE_o,
    input   DATA_BUS        PCPlus4D_i,
    output  DATA_BUS        PCPlus4E_o,
    input   DATA_BUS        Imm_OpD_i,
    output  DATA_BUS        Imm_OpE_o,
    input   DATA_BUS        RegWriteD_i,
    output  DATA_BUS        RegWriteE_o,
    input   DATA_BUS        ALU_srcD_i,
    output  DATA_BUS        ALU_srcE_o,
    input   logic           MemWriteD_i,
    output  logic           MemWriteE_o,
    input   logic           ResultSrcD_i,
    output  logic           ResultSrcE_o,
    input   logic           StoreNextPCD_i,
    output  logic           StoreNextPCE_o,
    input   logic           JumpImmTypeD_i,
    output  logic           JumpImmTypeE_o,
    input   logic           JumpResultTypeD_i,
    output  logic           JumpResultTypeE_o,
    input   logic           BranchTypeD_i,
    output  logic           BranchTypeE_o,
    input   logic           MemExtendD_i,
    output  logic           MemExtendE_o,
    input   alu_ctrl        ALU_ctrlD_i,
    output  alu_ctrl        ALU_ctrlE_o,
    input   byte_format     ByteSelectD_i,
    output  byte_format     ByteSelectE_o,
    input   DATA_BUS        OP1D_i,
    output  DATA_BUS        OP1E_o,
    input   DATA_BUS        RegRD2D_i,
    output  DATA_BUS        RegRD2E_o,
    input   address_width   RdD_i,
    output  address_width   RdE_o  
);

always_ff @(negedge clk) begin
    PCE_o <= PCD_i;
    PCPlus4E_o <= PCPlus4D_i;
    Imm_OpE_o <= Imm_OpD_i;
    RegWriteE_o <= RegWriteD_i;
    ALU_srcE_o <= ALU_srcD_i;
    MemWriteE_o <= MemWriteD_i;
    ResultSrcE_o <= ResultSrcD_i;
    StoreNextPCE_o <= StoreNextPCD_i;
    JumpImmTypeE_o <= JumpImmTypeD_i;
    JumpResultTypeE_o <= JumpResultTypeD_i;
    BranchTypeE_o <= BranchTypeD_i;
    MemExtendE_o <= MemExtendD_i;
    ALU_ctrlE_o <= ALU_ctrlD_i;
    ByteSelectE_o <= ByteSelectD_i;
    OP1E_o <= OP1D_i;
    RegRD2E_o <= RegRD2D_i;
    RdE_o <= RdD_i;
end

endmodule 
