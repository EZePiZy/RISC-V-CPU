module PC_target(
  // Write your IO Port Declarations here
  input [31:0] PC,
  input [31:0] ImmExt,
  output [31:0] PC_target
);  
  // Write your Assignments here
  assign PC_target = PC + ImmExt;
  
  
endmodule