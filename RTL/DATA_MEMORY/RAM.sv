module RAM

import types_pkg::*; //Import Bit Sizing

(
    input   logic     clk,//Input Clock
    input   logic     WE,//Write Enable
    /* verilator lint_off UNUSED */
    input   DATA_BUS  A, //Input Address
    input   DATA_BUS  WD,//Write Data
    output  DATA_BUS  RD //Read Data
);

logic [7:0] ram_array [32'h1FFFF:0]; //This defines a RAM array with 2^18 Addresses each of 32bits (Two bottom bits ignored giving 2^16)

initial begin
    $readmemh("../CPU/data.mem", ram_array, 'h10000); //This allows for loading of data into the data memory from intially running the program
end

always_ff @(posedge clk) begin
    if (WE == 1'b1) begin
        // Need to always read entire word, exluding offset that could be induced by word
        ram_array[{A[31:2], 2'b00}] <= WD[7:0]; //If Write Enable is high, write the value of Write Data to the ram location 
        ram_array[{A[31:2], 2'b01}] <= WD[15:8];
        ram_array[{A[31:2], 2'b10}] <= WD[23:16];
        ram_array[{A[31:2], 2'b11}] <= WD[31:24];
    end
end

always_comb begin
    RD = {ram_array[{A[31:2], 2'b11}], ram_array[{A[31:2], 2'b10}], ram_array[{A[31:2], 2'b01}], ram_array[{A[31:2], 2'b00}]}; //If Write Enable is Low output the 32bit value from the address at the top 16bits of A
    
end

endmodule

