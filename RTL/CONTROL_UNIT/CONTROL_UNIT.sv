module CONTROL_UNIT 

import types_pkg::*; // import all data type definitions

(
  /* verilator lint_off UNUSED */   // ignore unused parts of instruction
  input  DATA_BUS     instr,        // incoming instruction
  output logic        RegWrite,     // enable to write regs
  output alu_ctrl     ALUctrl,      // value to select operation in alu
  output logic        ALUsrc,       // mux to select immediate
  output instr_format ImmSrc,       // value to select imm type
  output logic        MemWrite,     // Sets the Data Memory Write Enable
  output logic        ResultSrc,    // Sets the output value to be that of the ALU or Data Memory
  output logic        WriteNextPC, // Sets MUX to write PC + 4 to the REGFILE
  output logic        JumpResultType,// Sets the PC to the value of the Result
  output logic        JumpImmType,   // Sets the PC to the Value of the PC + Imm
  output logic        BranchType,  //Sets the control flag for a branch type
  output byte_format  ByteSelect,    // Sets the size for the given instruction(Word, Half Word, Byte)
  output logic        MemExtend     //Set the Signal to extend a byte or half word once loaded
);

opcode curr_opcode = opcode'(instr[6:0]); // extract opcode and type cast it

logic[2:0] funct3 = {instr[14:12]};
logic[6:0] funct7 = {instr[31:25]};

always_comb begin
// set default values
  RegWrite = 0;
  ALUctrl = SUM_OP; // 2'b0
  ALUsrc = 0;
  ImmSrc = Imm; // 3'b0
  MemWrite = 0;
  ResultSrc = 0;
  WriteNextPC = 0;
  JumpResultType = 0;
  JumpImmType = 0;
  BranchType = 0;
  ByteSelect = Word; // 2'b0;
  MemExtend = 1;  // set default to 1 (always sign extend)

  case (curr_opcode)

    /* R-TYPE */ 
    R: begin                  // register to register instructions (no immediates used)
      ResultSrc = 0; // care about the ALU output
      RegWrite = 1;
      ALUsrc = 0;
      MemWrite = 0;
      case({funct3, funct7})
        10'b0000000000: begin // add

        end
        10'b0000100000: begin // sub

        end
        10'b0010000000: begin // sll
        
        end
        10'b0100000000: begin // slt
        
        end
        10'b0110000000: begin // sltu
        
        end
        10'b1000000000: begin // xor
        
        end
        10'b1010000000: begin // srl
        
        end
        10'b1010100000: begin // sra

        end
        10'b1100000000: begin // or

        end
        10'b1110000000: begin // and
        
        end
        default: begin 
          ALUsrc = 0; //do something for default
          RegWrite = 0; // make sure nothing is being written to
        end
      endcase
    end

    /* I1-TYPE */ 
    I1: begin // instruction of form l** (load byte, load half etc..)
      RegWrite = 1;       // Allow writing to Registers
      ALUctrl = SUM_OP;   // Set the ALU to complete an sum operation
      ResultSrc = 1;      // Set the mux to take the value of the Data Memory
      ALUsrc = 1;         // Use immOp as second operand
      ImmSrc = Imm;     // 12 bit imm
      case({funct3})
        3'b000: begin // lb Load Byte
          ByteSelect = Byte;
          MemExtend = 1;
        end 
        3'b001: begin // lh Load Half Word
          ByteSelect = HalfWord;
          MemExtend = 1;
        end
        3'b010: begin // lw Load Word
          ByteSelect = Word;
          MemExtend = 1; // doesnt actually matter
        end
        3'b100: begin // lbu Load Byte unsigned
          ByteSelect = Byte;
          MemExtend = 0; // 0 extend
        end 
        3'b101: begin  // lhu Load Half Word unsigned
          ByteSelect = HalfWord;
          MemExtend = 0; // 0 extend
        end
        default: begin
          ByteSelect = Word;
          MemExtend = 1;
        end 
      endcase
    end

    /* I2-TYPE */ 
    I2: begin               // ALU operations that use immediates
      RegWrite = 1;             // write result to register
      ImmSrc = Imm;             // 12 bit immediate
      ALUsrc = 1;               // select ImmOp as operand
      case({funct3})
        3'b000: begin           // ADDI
          ALUctrl = SUM_OP;     // ALU is doing addition
        end
        3'b001: begin           // SLLI
          if ({funct7} == 7'b000000) begin 
            ALUctrl = SLL_OP; // do the shifting
          end
        end
        3'b010: begin // slti

        end
        3'b011: begin // sltiu

        end
        3'b100: begin // xori

        end
        3'b101: begin // srli and srai
          if ({funct7} == 7'b0000000) begin // srli

          end
          else if ({funct7} == 7'b0100000) begin // srai
            
          end
        end
        3'b110: begin // ori

        end
        3'b111: begin // andi
          ALUctrl = AND_OP; // do the anding
        end
        default: begin 
          //TODO
        end
      endcase
    end

    /* I3-TYPE */ 
    I3: begin
    case({funct3})
      3'b000: begin // jalr 

        RegWrite = 1;
        ALUctrl = SUM_OP; // 2'b0
        ALUsrc = 1;
        ImmSrc = Imm; // 3'b0
        WriteNextPC = 1;
        JumpResultType = 1;
        JumpImmType = 0;
        BranchType = 0;
        
      end
      default: begin
        //TODO
      end 
    endcase
    end

    /* S-TYPE */ 
    S: begin
      MemWrite = 1; // As we are storing, writing to memory enable
      ImmSrc = Store; // In the SignExtend Unit, all the S-type instructions use Store. Set the ImmSrc type to that of a Store instruction 
      ResultSrc = 0; // Bypassing Data Memory, using ALUResult (not ReadData)
      ALUsrc = 1; // Always using ImmExt (not RD2)
      ALUctrl = SUM_OP; //Set the ALU to complete a sum operation
      case({funct3})
        3'b000: begin // sb Store Byte
          ByteSelect = Byte;
  
        end
        3'b001: begin // sh Store Half Word
          ByteSelect = HalfWord;

        end
        3'b010: begin // sw Store Word
          ByteSelect = Word;
  
        end
        default: begin

      end
      endcase
    end

    /* B-TYPE */ 
    B: begin            // Branching instructions
      ImmSrc = Branch;  // branch immediate (13 bits where bit 0 is ignored)
      BranchType = 1;
      JumpImmType = 0;
      JumpResultType = 0;
    end

    /* U1-TYPE */
    U1: begin // auipc
      
    end

    /* U2-TYPE */
    U2: begin // lui : rd = {UpperImm, 12'b0}
      RegWrite = 1;
      ALUctrl = UIM_OP; 
      ALUsrc = 1;
      ImmSrc = UpperImm;
      ResultSrc = 0; // choose ALU result
      WriteNextPC = 0; // dont store next pc
    end

    /* J-TYPE */
    J: begin // jal
      WriteNextPC = 1; // save next PC to REG
      ImmSrc = Jump;
      RegWrite = 1;
      JumpResultType = 0;
      JumpImmType = 1;
      BranchType = 0;
    end

  default: begin  // Default case for global case(curr_opc)
    //TODO
  end 
  endcase
end


endmodule
