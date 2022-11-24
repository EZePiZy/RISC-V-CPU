#include "verilated.h"
#include "verilated_vcd_c.h"
#include "VCPU.h"
#include "vbuddy.cpp"     // include vbuddy code
#define MAX_SIM_CYC 1000000

int main(int argc, char **argv, char **env) {
  int simcyc;     // simulation clock count
  int tick;       // each clk cycle has two ticks for two edges
  Verilated::commandArgs(argc, argv);

  // init top verilog instance
  VCPU * top = new VCPU;
  // init trace dump
  Verilated::traceEverOn(true);
  VerilatedVcdC* tfp = new VerilatedVcdC;
  top->trace (tfp, 99);
  tfp->open ("CPU.vcd");
 
  // init Vbuddy
  if (vbdOpen()!=1) return(-1);
  vbdHeader("CPU");

  // initialize simulation inputs

  top->clk = 1;
  top->rst = 0;
 
  
  // run simulation for MAX_SIM_CYC clock cycles
  for (simcyc=0; simcyc<MAX_SIM_CYC; simcyc++) {
    // dump variables into VCD file and toggle clock
    for (tick=0; tick<2; tick++) {
      tfp->dump (2*simcyc+tick);
      top->clk = !top->clk;
      top->eval ();
    }

    if (simcyc < 2){
      top->rst = 1;
    } else {
      top->rst = 0;
    };    


    // Display ROM value
    vbdHex(4, (int(top->a0) >> 16) & 0xF);
    vbdHex(3, (int(top->a0) >> 8) & 0xF);
    vbdHex(2, (int(top->a0) >> 4) & 0xF);
    vbdHex(1, (int(top->a0) & 0xF));

    

    
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