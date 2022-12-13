module PC 

import types_pkg::*; 

(
    input   DATA_BUS  next_PC,
    input   logic     clk,
    input   logic     rst,
    output  DATA_BUS  PC
);

initial begin
    PC = 32'hBFC00000;
end

always_ff @(posedge clk) begin
    if (rst)
        PC <= 32'hBFC00000;
    else
        PC <= next_PC;
end

endmodule 

