module DATA_MEMORY

import types_pkg::*; //Import Bit Sizing

(
  input  byte_format ByteSelect, // The control signal for the byte selection
  input  logic       SignExtend,
  input  logic       DE,         // Data Enable
  input  logic       clk,        // Input Clock
  input  logic       WE,         // Write Enable
  input  DATA_BUS    A,          // Input Address
  input  DATA_BUS    WD,         // Write Data
  output DATA_BUS    RD          // Read Data
);

DATA_BUS read, write;

always_comb begin
  case(ByteSelect)
    Word: begin
      RD = read;
      write = WD;
    end
    Byte: begin
      // Reading

      // find the value of the sign bit for the byte given by A[1:0] if sign extending otherwise prepend 0s
      // then concatenate with the byte actually being read
      // thy one liners art as good as thy tricks
      RD = { SignExtend ? {24{1'((read >> (5'(A[1:0]) << 3)) >> 7)}} : {24{1'b0}}, 8'(read >> (5'(A[1:0]) << 3))}; 

      case(A[1:0])
        2'b00: write = {read[31:8], WD[7:0]};
        2'b01: write = {read[31:16], WD[7:0], read[7:0]};
        2'b10: write = {read[31:24], WD[7:0], read[15:0]};
        2'b11: write = {WD[7:0], read[23:0]};
      endcase
    end
    default: begin
      RD = read;
      write = WD;
    end
  endcase
end

CACHE cache (
  .clk(clk), // Input Clock
  .DE(DE),   // Data Enable
  .WE(WE),   // Write Enable
  .A(A),     // Input Address
  .RD(read), // Read Data
  .WD(write) // Write Data
);

endmodule










