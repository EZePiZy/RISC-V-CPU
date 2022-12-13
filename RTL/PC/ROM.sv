module ROM 
import types_pkg::*;
(
    /* verilator lint_off UNUSED */
    input  DATA_BUS addr,
    output DATA_BUS dout
);

DATA_BUS rom_array [2 ** 16 - 1:0]; //Arbituary Width this allows for 65000 instructions within the rom, thats enough

initial begin 
    $display("Loading instruction ROM.");
    $readmemh("../CPU/instruction.mem", rom_array);
end;

assign dout = rom_array[{2'b0, addr[31:2]} - 'hBFC00000];

endmodule
