module REGFILE 

import types_pkg::*;

(
    input  logic    clk,
    input  ADDR_BUS AD1,
    input  ADDR_BUS AD2,
    input  ADDR_BUS AD3,
    input  logic    WE3,
    input  DATA_BUS WD3,
    output DATA_BUS RD1,
    output DATA_BUS RD2,
    output DATA_BUS a0
);

logic [DATA_WIDTH-1:0] ram_array [2 ** ADDRESS_WIDTH - 1:0];

always_comb begin
    RD1 = ram_array [AD1];
    RD2 = ram_array [AD2];
    a0  = ram_array [10]; // hard coded output register 10.
end

always_ff @(posedge clk) begin
    if (WE3) ram_array [AD3] <= WD3; 
end

endmodule
