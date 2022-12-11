#include "verilated.h"
#include "verilated_vcd_c.h"
#include "VCPU.h"
#include <iostream>
#include <chrono>

#define MAX_SIM_CYC 2000

#define VBUDDY
#ifdef VBUDDY
#include "vbuddy.cpp"     // include vbuddy code
#endif

int main(int argc, char **argv, char **env) {
  int simcyc;     // simulation clock count
  int tick;       // each clk cycle has two ticks for two edges
  Verilated::commandArgs(argc, argv);

  // init top verilog instance
  VCPU *top = new VCPU;
  // init trace dump
  Verilated::traceEverOn(true);
  VerilatedVcdC* tfp = new VerilatedVcdC;
  top->trace (tfp, 99);
  tfp->open ("CPU.vcd");
 
  // init Vbuddy

  #ifdef VBUDDY
  if (vbdOpen()!=1) return(-1);
  vbdHeader("RISC-V");
  #endif

  vbdSetMode(0); 

  // initialize simulation inputs

  top->clk = 1;
<<<<<<< Updated upstream:programs/pc_test_tb.cpp
  top->rst = 0;
  top->write_in_EN = 0;
  top->input_reg = 0;


=======
  top->rst = 1;
 
>>>>>>> Stashed changes:CPU/CPU_tb.cpp
  
  // run simulation for MAX_SIM_CYC clock cycles
  for (simcyc=0; simcyc<MAX_SIM_CYC; simcyc++) {
  
    // dump variables into VCD file and toggle clock
    for (tick=0; tick<2; tick++) {
      top->eval ();
      tfp->dump (2*simcyc+tick);
      top->clk = !top->clk;
    }
<<<<<<< Updated upstream:programs/pc_test_tb.cpp
=======

    if (simcyc < 2){
      top->rst = 1;
    } else {
      top->rst = 0;
    }   

    // top->rst = 0;

    std::cout << top->a0 << std::endl;


>>>>>>> Stashed changes:CPU/CPU_tb.cpp
    
    std::cout << top->PC << std::endl;
    vbdBar(top->a0);
    

    #ifdef VBUDDY 
    vbdCycle(simcyc);
    if (Verilated::gotFinish() || (vbdGetkey()=='q'))
    {
      vbdClose();
    #else   
    if (Verilated::gotFinish())
    {
    #endif
      tfp->close();
      exit(0);
    } 
  }

  #ifdef VBUDDY 
  vbdClose();
  #endif
  tfp->close(); 
  exit(0);
}
