module REGFILE 

import types_pkg::*;

(
  input  logic    clk,
  input  ADDR_BUS AD1,
  input  ADDR_BUS AD2,
  input  ADDR_BUS AD3,
  input  logic    WE3,
  input  DATA_BUS WD3,
  input  logic    in_EN,  // enable to write to input register
  input  DATA_BUS x31,    // input register to set 1 second clock
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
    if (in_EN) ram_array[31] <= x31;             // hard coded input to x31 register to interact with outside world, clocked and with enable
    if (WE3 && AD3 != 0) ram_array [AD3] <= WD3; // DO NOT WRITE TO REG 0
end

endmodule
