module PC (
    input logic [31:0] next_PC,
    input logic clk,
    input logic rst,
    output logic [31:0] PC
);

always_ff @(posedge clk) begin
    if (rst)
        PC <= 32'b0;
    else
        PC <= next_PC;
end

endmodule 

