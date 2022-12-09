#include "verilated.h"
#include "verilated_vcd_c.h"
#include "VSIGN_EXTEND.h"

#include <iostream>

int main(int argc, char **argv, char **env) {
	int simcyc;     // simulation clock count
	int tick;       // each clk cycle has two ticks for two edges
	int lights = 0; // state to toggle LED lights

	Verilated::commandArgs(argc, argv);
	// init top verilog instance
	VSIGN_EXTEND * top = new VSIGN_EXTEND;
	// init trace dump
	Verilated::traceEverOn(true);
	VerilatedVcdC* tfp = new VerilatedVcdC;
	top->trace (tfp, 99);
	tfp->open ("SIGN_EXTEND.vcd");

	

	top->ImmSrc = 0b000; // Normal immediate
	top->instr = 0b00000011100100000000000000000000; // 32 bits where from [31:20] there's 57 in binary
	top->eval();
	std::cout << "57: " << int(top->ImmOp) << std::endl;

	top->instr = 0b11111100011100000000000000000000; // -57
	top->eval();
	std::cout << "-57: " << int(top->ImmOp) << std::endl;

	top->ImmSrc = 0b001; // Upper immediate
	// number is now 59.768.832
	top->instr = 0b00000011100100000000000000000000; // 32 bits where from [31:20] there's 57 in binary
	top->eval();
	std::cout << "big num: " << int(top->ImmOp) << std::endl;

	top->instr = 0b00000011100100000000000000001100; // 32 bits where from [31:20] there's 57 in binary
	top->eval();
	std::cout << "another big: " << int(top->ImmOp) << " original: " << int(top->instr) << std::endl;

	top->instr = 0b11111100011100000000000000000000; 
	top->eval();
	std::cout << "negative big: " << int(top->ImmOp) << std::endl;

	top->ImmSrc = 0b010; // store instruction

	top->instr = 0x06112223; // 100 
	top->eval();
	std::cout << "100: " << int(top->ImmOp) << std::endl;

	top->instr = 0xf8112e23; // -100
	top->eval();
	
	std::cout << "-100: " << int(top->ImmOp) << std::endl;

	top->ImmSrc = 0b011; // branch instruction

	// number 114 0 0000 0111 0010 in 13 bits
	// becomes 0 000011 00000 00000 000 1001 0

	top->instr = 0b00000110000000000000100100000000;
	top->eval();

	std::cout << "57 x 2: " << int(top->ImmOp) << std::endl;

	// number -57 1 1111 1100 0111 in 13 bits
	// becomes 1 111110 00000 00000 000 0011 1

	top->instr = 0b11111100000000000000001110000000; // branch 3
	top->eval();

	std::cout << "-57: " << int(top->ImmOp) << std::endl;


	top->ImmSrc = 0b100; // Jump instruction
	
	// number 57 in 21 bits 0 0000 0000 0000 0011 1001
	// becomes 0 0000011100 0 0000000 00000 000000

	top->instr = 0b00000011100000000000000000000000;
	top->eval();

	std::cout << "57: " << int(top->ImmOp) << std::endl;

	// number -57 in 21 bits 1 1111 1111 1111 1100 0111
	// becomes 1 1111100011 1 11111111 00000 0000000

	top->instr = 0b11111100011111111111000000000000;
	top->eval();

	std::cout << "-57: " << int(top->ImmOp) << std::endl;


	tfp->close(); 
	exit(0);
}