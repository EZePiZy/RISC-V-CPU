module DATA_MEMORY

import types_pkg::*; //Import Bit Sizing

(
    input   logic     clk,//Input Clock
    input   logic     WE,//Write Enable
    input   DATA_BUS  A, //Input Address
    input   DATA_BUS  WD,//Write Data
    output  DATA_BUS  RD //Read Data
);

logic [DATA_WIDTH-1:0] ram_array [2**RAM_ADDRESS_WIDTH-1:0]; //This defines a RAM array with 2^18 Addresses each of 32bits (Two bottom bits ignored giving 2^16)

always_ff @(posedge clk) begin
    if (WE == 1'b1)
        ram_array[{2'b0, A[RAM_ADDRESS_WIDTH-1:2]}] <= WD; //If Write Enable is high, write the value of Write Data to the ram location 
end

always_comb begin
    RD = ram_array[{2'b0, A[RAM_ADDRESS_WIDTH-1:2]}]; //If Write Enable is Low output the 32bit value from the address at the top 16bits of A
end

endmodule





