#include "verilated.h"
#include "verilated_vcd_c.h"
#include "VCONTROL_UNIT.h"

#include <iostream>
#include <bitset>

int main(int argc, char **argv, char **env) {
  int simcyc;     // simulation clock count
  int tick;       // each clk cycle has two ticks for two edges
  int lights = 0; // state to toggle LED lights

  Verilated::commandArgs(argc, argv);
  // init top verilog instance
  VCONTROL_UNIT *top = new VCONTROL_UNIT;
  // init trace dump
  Verilated::traceEverOn(true);
  VerilatedVcdC *tfp = new VerilatedVcdC;
  top->trace (tfp, 99);
  tfp->open ("CONTROL_UNIT.vcd");

// addi x1, x1, 5
  // std::cout << "addi, x1, x1, 5" << std::endl;
  // top->instr = 0b00000000010100001000000010010011;
  // top->eval();
  // tfp->dump(0);
  
  // std::cout << "addi, x1, x1, -2" << std::endl;
  // top->instr = 0b11111111111000001000000010010011;
  // top->eval();
  // tfp->dump(1);

  // std::cout << "addi, x2, x1, 2" << std::endl;
  // top->instr = 0b00000000001000001000000100010011;
  // top->eval();
  // tfp->dump(2);

  std::cout << "jalr, zero, sp, 0" << std::endl;
  top->instr = 0x00010067;
  top->eval();
  tfp->dump(3);

  tfp->close(); 
  exit(0);
}