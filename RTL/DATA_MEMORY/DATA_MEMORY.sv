module DATA_MEMORY

import types_pkg::*; //Import Bit Sizing

(
    input byte_format ByteSelect, //The control signal for the byte selection
    input   logic     clk,//Input Clock
    input   logic     WE,//Write Enable
    /* verilator lint_off UNUSED */
    input   DATA_BUS  A, //Input Address
    input   DATA_BUS  WD,//Write Data
    output  DATA_BUS  RD //Read Data
);

RAM ram (
    .clk (clk),
    .WE  (WE),
    .A   (A),
    .WD  (WD),
    .RD  (RD)
);

endmodule





