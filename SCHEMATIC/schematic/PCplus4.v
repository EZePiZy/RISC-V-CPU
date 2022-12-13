module PC_plus4(
  // Write your IO Port Declarations here
  input [31:0] PC,
  output [31:0] PC_plus4
);  
  // Write your Assignments here
  
  assign PC_plus4 = PC + 32'h4;
  
endmodule