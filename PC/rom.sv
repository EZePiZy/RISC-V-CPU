module rom #(
    parameter ADDRESS_WIDTH = 5,
              DATA_WIDTH = 32
)(
    /* verilator lint_off UNUSED */
    input logic  [ADDRESS_WIDTH-1:0] addr,
    output logic [DATA_WIDTH-1:0]    dout
);

logic [DATA_WIDTH-1:0] rom_array [2 ** ADDRESS_WIDTH-1:0];

initial begin 
    $display("Loading rom.");
    $readmemh("rom.mem", rom_array);
end;

always_comb begin
    dout = rom_array [ addr[31:2] ];
end
    

endmodule

