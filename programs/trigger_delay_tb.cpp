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

  vbdSetMode(1); 

  // initialize simulation inputs

  top->clk = 1;
  top->rst = 0;

 

  auto start_time = std::chrono::high_resolution_clock::now();
  auto end_time = std::chrono::high_resolution_clock::now();

  // vars for 1 second pulse
  auto prev_time = std::chrono::high_resolution_clock::now();
  int elapased_time = 0;
  bool sec_pulse = 0;

  long int total_duration = 0;
  
  // run simulation for MAX_SIM_CYC clock cycles
  for (simcyc=0; simcyc<MAX_SIM_CYC; simcyc++) {
    start_time = std::chrono::high_resolution_clock::now();

    // in order to have precise 1 second pulses
    elapased_time = std::chrono::duration_cast<std::chrono::milliseconds>(start_time - prev_time).count();
    
    // dump variables into VCD file and toggle clock
    for (tick=0; tick<2; tick++) {
      top->eval ();
      tfp->dump (2*simcyc+tick);
      top->clk = !top->clk;
    }

    // set input registers to 0 
    top->write_in_EN = 0;

    uint32_t output = top->x31;


    if ((top->x31 & 2 ) == 0) { // check trigger bit is reset
      top->write_in_EN = 1;
      output = vbdFlag() ? output | 2 : output;  
    }

    if (elapased_time > 1000){
      elapased_time = 0;
      prev_time = start_time;
      std::cout << "1 second elapsed!" << std::endl;

      top->write_in_EN = 1;
      output = output | 1;
    }
    
    top->input_reg = output;

    std::cout << top->x31 << ", " << int32_t(top->a0) << std::endl;

    
    // END OF LOOP
    end_time = std::chrono::high_resolution_clock::now();

    auto duration = std::chrono::duration_cast<std::chrono::microseconds>(end_time - start_time);
    total_duration += duration.count();

    #ifdef VBUDDY 
    vbdBar(top->a0);
    vbdCycle(simcyc);
    if (Verilated::gotFinish() || (vbdGetkey()=='q'))
    {
      vbdClose();
    #else   
    if (Verilated::gotFinish())
    {
    #endif
      tfp->close();
      std::cout << "Average time per clock cycle: " << (total_duration/simcyc) << " us" << std::endl;
      std::cout << "Average frequency: " << (double(1)/((total_duration * 10e-6)/simcyc)  )  << " Hz" << std::endl;
      exit(0);
    } 
  }

  #ifdef VBUDDY 
  vbdClose();
  #endif
  
  std::cout << "Average time per clock cycle: " << (total_duration/MAX_SIM_CYC) << " us" << std::endl;
  std::cout << "Average frequency: " << (double(MAX_SIM_CYC)/total_duration) * 10e6 << " Hz" << std::endl;
  tfp->close(); 
  exit(0);
}
