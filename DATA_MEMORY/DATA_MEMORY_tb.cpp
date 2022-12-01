#include "verilated.h"
#include "verilated_vcd_c.h"
#include "VDATA_MEMORY.h"
#include "vbuddy.cpp"     // include vbuddy code
#define MAX_SIM_CYC 1000000

int main(int argc, char **argv, char **env) {
  int simcyc;     // simulation clock count
  int tick;       // each clk cycle has two ticks for two edges
  int lights = 0; // state to toggle LED lights

  Verilated::commandArgs(argc, argv);
  // init top verilog instance
  VDATA_MEMORY * top = new VDATA_MEMORY;
  // init trace dump
  Verilated::traceEverOn(true);
  VerilatedVcdC* tfp = new VerilatedVcdC;
  top->trace (tfp, 99);
  tfp->open ("DATA_MEMORY.vcd");
 
  // init Vbuddy
  if (vbdOpen()!=1) return(-1);
  vbdHeader("DATA_MEMORY");

  // initialize simulation inputs
  top->clk = 1;
  
  // run simulation for MAX_SIM_CYC clock cycles
  for (simcyc=0; simcyc<MAX_SIM_CYC; simcyc++) {
    // dump variables into VCD file and toggle clock
    for (tick=0; tick<2; tick++) {
      tfp->dump (2*simcyc+tick);
      top->clk = !top->clk;
      top->eval ();
    }

    top->A = 0;

    // Display RAM value
    if(simcyc % 2 == 0) {
      top->WE = 0; //Set Write Enable Low (To allow reading from the RAM)

      vbdHex(4, (int(top->RD) >> 16) & 0xF); //Display the output in address 0
      vbdHex(3, (int(top->RD) >> 8) & 0xF);
      vbdHex(2, (int(top->RD) >> 4) & 0xF);
      vbdHex(1, (int(top->RD) & 0xF));

      std::cout << int(top->RD) << std::endl;//Print the output to the console
    }else {
      top->WE = 1;//Set Write Enable High

      top->WD = simcyc;//Write the value 5 to the DATA Pin
    }

    vbdCycle(simcyc);
  
    if (Verilated::gotFinish() || (vbdGetkey()=='q')) {
      vbdClose();
      tfp->close();
      exit(0);
    } 
  }

  vbdClose();     // ++++
  tfp->close(); 
  exit(0);
}