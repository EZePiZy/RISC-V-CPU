#include "verilated.h"
#include "verilated_vcd_c.h"
#include "VCPU.h"

#include <fstream>
#include <iostream>
#include <chrono>
#include <string>

#define MAX_SIM_CYC 1000000

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
  vbdHeader("Computing PDF");
  vbdSetMode(0); 
  #endif

  // CSV output

  std::string filename = "out.csv";
  std::fstream file_out;

  file_out.open(filename, std::ios_base::out);

  if (!file_out.is_open()){
    std::cout << "csv file is not open" << std::endl;
  } else {
    file_out << "val, freq" << std::endl;
  }

  // initialize simulation inputs

  top->clk = 1;
  top->rst = 0;
  top->write_in_EN = 0;
  top->input_reg = 0;

  int display = 0;

  bool readVal = 0;
  int counter = 0;
  int vals[256];
  
  // run simulation for MAX_SIM_CYC clock cycles
  for (simcyc=0; simcyc<MAX_SIM_CYC; simcyc++) {
    // dump variables into VCD file and toggle clock
    for (tick=0; tick<2; tick++) {
      top->eval ();
      tfp->dump (2*simcyc+tick);
      top->clk = !top->clk;
    }

    // std::cout << top->a0 << std::endl;
    if (readVal) {
      if (counter <= 255) {
        // std::cout << top->a0 << std::endl;
        file_out << counter << ", " << int(top->a0) << std::endl;
        vals[counter] = top->a0;
        counter++;
        readVal = 0;
      } else {
        break;
      }
    }

    if (int(top->a0) == -1) readVal = 1;

    
    if (Verilated::gotFinish())
    {
      tfp->close();
      exit(0);
    } 
  }

  vbdHeader("PDF");
  for (int i = 0; i < 240; ++i){
    std::cout << i << ": " << vals[i] << std::endl;
    vbdPlot(vals[i], 0, 200);
  }

  #ifdef VBUDDY 
  vbdClose();
  #endif
  tfp->close(); 
  exit(0);
}
