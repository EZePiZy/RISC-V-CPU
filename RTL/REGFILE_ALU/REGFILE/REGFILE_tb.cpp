#include "VREGFILE.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include "vbuddy.cpp"

int main(int argc, char **argv, char **env) {
    int i;
    int clk;

    Verilated::commandArgs(argc, argv);

    VREGFILE *top = new VREGFILE;

    Verilated::traceEverOn(true);
    VerilatedVcdC *tfp = new VerilatedVcdC;
    top->trace(tfp, 99);
    tfp->open("REGFILE.vcd");

    // if (vbdOpen() != 1) return (-1);
    // vbdHeader("REGFILE");

    top->clk = 1;

    for (i = 0; i < 300; i++) {
        for (clk = 0; clk < 2; clk++) {
            tfp->dump(2 * i + clk);
            top->clk = !top->clk;
            top->eval();
        }
    }

    if (Verilated::gotFinish() /*|| (vbdGetkey() == 'q') */ ) exit(0);
    // vbdClose();
    tfp->close();
    exit(0);
}