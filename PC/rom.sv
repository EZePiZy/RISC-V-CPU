module rom #(
    parameter ADDRESS_WIDTH = 32,
              DATA_WIDTH = 32,
              ROM_SIZE = 30

)(
    /* verilator lint_off UNUSED */
    input logic  [ADDRESS_WIDTH-1:0] addr,
    output logic [ROM_SIZE-1:0]    dout
);

logic [DATA_WIDTH-1:0] rom_array [2 ** ADDRESS_WIDTH-1:0];

initial begin 
    $display("Loading rom.");
    $readmemh("rom.mem", rom_array);
end;

always @(*) begin
    dout = rom_array [ addr[31:2] ];
end
    

endmodule

