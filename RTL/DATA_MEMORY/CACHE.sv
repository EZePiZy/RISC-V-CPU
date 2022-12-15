module CACHE

import types_pkg::*; //Import Bit Sizing

(
    input   logic     clk,//Input Clock
    input   logic     WE,//Write Enable
    /* verilator lint_off UNUSED */
    input   DATA_BUS  A, //Input Address
    input   DATA_BUS  WD,//Write Data
    output  DATA_BUS  RD //Read Data
);

DATA_BUS RAM_R;

CacheBlock Cache_Array [2**SET_SIZE-1:0];

always_comb begin

  // Address format:
  // 32      TAG       set_size + 2 | set_size + 1 SET 2 | 1 byte address 0
  // example for set_size = 3
  // 32       TAG      5 | 4    SET   2 | 1    byte address   0
  // index into Cache array with set bits, first bits after byte address bits hence SET_SIZE + 2
  // compare Cache tag to Address going from bit 32 to 32 - Set_size 
  if (Cache_Array[A[(SET_SIZE+2)-1:2]].V && Cache_Array[A[(SET_SIZE+2)-1:2]].Tag == A[DATA_WIDTH-1:(SET_SIZE+2)]) begin  // check if hit
    $display("hit", A);
    RD = Cache_Array[A[(SET_SIZE+2)-1:2]].Cache_Data;
  end 
  else begin                                                                                // mrs, go 2 🐏
    RD = RAM_R;
    $display("Miss", A);
  end

end

always_ff@(posedge clk) begin
  if(WE) begin
    Cache_Array[A[(SET_SIZE+2)-1:2]].Cache_Data <= WD;                 
    Cache_Array[A[(SET_SIZE+2)-1:2]].V <= 1'b1;
    Cache_Array[A[(SET_SIZE+2)-1:2]].Tag <= A[DATA_WIDTH-1:(SET_SIZE+2)];
  end 
  //Update cache if V is Low or Tag is different from Address
  else if((!Cache_Array[A[(SET_SIZE+2)-1:2]].V || !(Cache_Array[A[(SET_SIZE+2)-1:2]].Tag == A[DATA_WIDTH-1:(SET_SIZE+2)]))) begin
    $display("Miss Clock", A);
    //--------------------------------Updating Cache value ----------------------------------------------------------------
    Cache_Array[A[(SET_SIZE+2)-1:2]].Cache_Data <= RAM_R;//asynchronous write to cache, allowed as no reading from cache
    Cache_Array[A[(SET_SIZE+2)-1:2]].V <= 1'b1;          //
    Cache_Array[A[(SET_SIZE+2)-1:2]].Tag <= A[DATA_WIDTH-1:(SET_SIZE+2)];
    //---------------------------------------------------------------------------------------------------------------------
  end
end

RAM ram (
    .clk (clk),
    .WE  (WE),
    .A   (A),
    .WD  (WD),
    .RD  (RAM_R)
);

endmodule





