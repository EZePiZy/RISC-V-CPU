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

// addi
top->instr = 0b00000000000000000000000000010011;
top->eval();
tfp->dump(0);

// bne
top->instr = 0b00000000000000000001000001100011;
top->eval();
tfp->dump(1);

// lw
top->instr = 0b00000000000000000010000000000011;
top->eval();
tfp->dump(2);

// sw
top->instr = 0b00000000000000000010000000100011;
top->eval();
tfp->dump(3);

// slli
top->instr = 0b00000000000000000001000000010011;
top->eval();
tfp->dump(4);

// jal
top->instr = 0b00000000000000000000000001101111;
top->eval();
tfp->dump(5);

// jalr
top->instr = 0b00000000000000000000000001100111;
top->eval();
tfp->dump(6);

top->eval();
tfp->dump(7);

  tfp->close(); 
  exit(0);
}