module ROM 
import types_pkg::*;
(
    /* verilator lint_off UNUSED */
    input  DATA_BUS addr,
    output DATA_BUS dout
);

DATA_BUS rom_array [2 ** ADDRESS_WIDTH - 1:0];

initial begin 
    $display("Loading rom.");
    $readmemh("rom.mem", rom_array);
end;

assign dout = rom_array[{2'b0, addr[31:2]}];

endmodule

