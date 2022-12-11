package types_pkg;
  parameter DATA_WIDTH = 32; 
  parameter IMM_WIDTH = 3; // number of bits needed to encode possible immediate formats
  parameter ALU_WIDTH = 3; // number of bits needed to encode possible ALU commands
  parameter OPCODE_WIDTH = 7; // number of bits to encode opcodes
  parameter ADDRESS_WIDTH = 5; //The address_width of a given register
  /* verilator lint_off UNUSED */ // UNUSED IN INDIVIDUAL COMPONENT TESTBENCHES
  parameter RAM_ADDRESS_WIDTH = 18; //The address of a given location in data_memory this is an arbitrary value 

  typedef logic [ADDRESS_WIDTH-1:0] ADDR_BUS;
  typedef logic [DATA_WIDTH-1:0] DATA_BUS;

  // possible formats for immediates
  typedef enum bit[IMM_WIDTH-1:0] {I = 3'b000, UI = 3'b001, S = 3'b010, B = 3'b011, J = 3'b100} instr_format;

  // mapping opcode types to binary values
  typedef enum bit[OPCODE_WIDTH-1:0] {R = 7'b0110011, I1 = 7'b0000011, I2 = 7'b0010011, S = 7'b0100011, B = 7'b1100011, U1 = 7'b0010111, U2 = 7'b0110111, I3 = 7'b1100111, J = 7'b1101111} opcode;

  // typedef enum bit[9:0] {add}

  // mapping ALU operations
  typedef enum bit[ALU_WIDTH-1:0] {SUM_OP = 3'b000, SUB_OP = 3'b001, AND_OP = 3'b010, SLT_OP = 3'b101, SLL_OP = 3'b100} alu_ctrl;
endpackage
