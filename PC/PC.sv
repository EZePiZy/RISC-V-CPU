module PC 

import types_pkg::*; 

(
    input DATA_BUS next_PC,
    input logic clk,
    input logic rst,
    output DATA_BUS PC
);

always_ff @(posedge clk) begin
    if (rst)
        PC <= 32'b0;
    else
        PC <= next_PC;
end

endmodule 

