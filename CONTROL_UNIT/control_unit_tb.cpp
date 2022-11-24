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
	VCONTROL_UNIT * top = new VCONTROL_UNIT;
	// init trace dump
	Verilated::traceEverOn(true);
	VerilatedVcdC* tfp = new VerilatedVcdC;
	top->trace (tfp, 99);
	tfp->open ("CONTROL_UNIT.vcd");

	top->instr = 0b00000000000000000000000000010011; // addi 
	top->eval();

	std::cout << "ADDI \n";

	std::cout << "RegWrite: " << int(top->RegWrite) << "\nALUctrl: " << std::bitset<2>(top->ALUctrl) << "\nALUsrc: " << int(top->ALUsrc) << "\nImmSrc: " << std::bitset<3>(top->ImmSrc) << "\nPCsrc: " << int(top->PCsrc) << std::endl;

	top->instr = 0b00000000000000000000000001100011; // bne 
	top->EQ = 0;
	top->eval();

	std::cout << "\nBNE false\n";

	std::cout << "RegWrite: " << int(top->RegWrite) << "\nALUctrl: " << std::bitset<2>(top->ALUctrl) << "\nALUsrc: " << int(top->ALUsrc) << "\nImmSrc: " << std::bitset<3>(top->ImmSrc) << "\nPCsrc: " << int(top->PCsrc) << std::endl;

	top->instr = 0b00000000000000000000000001100011; // bne 
	top->EQ = 1;
	top->eval();

	std::cout << "\nBNE true\n";

	std::cout << "RegWrite: " << int(top->RegWrite) << "\nALUctrl: " << std::bitset<2>(top->ALUctrl) << "\nALUsrc: " << int(top->ALUsrc) << "\nImmSrc: " << std::bitset<3>(top->ImmSrc) << "\nPCsrc: " << int(top->PCsrc) << std::endl;


	tfp->close(); 
	exit(0);
}