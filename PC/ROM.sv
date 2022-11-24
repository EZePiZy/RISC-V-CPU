module ROM 
import types_pkg::*; 
#(
    parameter ADDRESS_WIDTH = 5
)


(
    /* verilator lint_off UNUSED */
    input logic     [ADDRESS_WIDTH-1:0] addr,
    output DATA_BUS dout
);

DATA_BUS rom_array [2 ** ADDRESS_WIDTH-1:0];

initial begin 
    $display("Loading rom.");
    $readmemh("rom.mem", rom_array);
end;

always_comb begin
    dout = rom_array [ addr[31:2] ];
end
    

endmodule

