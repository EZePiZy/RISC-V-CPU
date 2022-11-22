#include "VREGFILE_ALU.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include "vbuddy.cpp"

int main(int argc, char **argv, char **env) {
    int i;
    int clk;

    Verilated::commandArgs(argc, argv);

    VREGFILE_ALU *top = new VREGFILE_ALU;

    Verilated::traceEverOn(true);
    VerilatedVcdC *tfp = new VerilatedVcdC;
    top->trace(tfp, 99);
    tfp->open("out.vcd");

    // if (vbdOpen() != 1) return (-1);
    // vbdHeader("REGFILE_ALU");

    top->clk = 1;

    for (i = 0; i < 300; i++) {
        for (clk = 0; clk < 2; clk++) {
            tfp->dump(2 * i + clk);
            top->clk = !top->clk;
            top->eval();
        }
        switch (i) {
            case 1: // set x10 to 1
            top->rs1 = 0;
            top->ALUsrc = 1;
            top->ALUctrl = 0;
            top->rd = 10;
            top->RegWrite = 1;
            top->ImmOp = 1;
            break;
            case 2: // set x11 to 2
            top->rd = 11;
            top->ImmOp = 2;
            break;
            case 3: // sum both and write to x12
            top->rs1 = 10;
            top->rs2 = 11;
            top->rd = 12;
            top->ALUsrc = 0;
            break;
            case 4: // write difference to x13
            top->rd = 13;
            top->ALUctrl = 1;
            break;
            case 5: // write AND to x14
            top->rd = 14;
            top->ALUctrl = 2;
            break;
            case 6: // write SLT to x15
            top->rd = 15;
            top->ALUctrl = 5;
            break;
            case 7: // set x10 higher than x11
            top->ALUsrc = 1;
            top->ALUctrl = 0;
            top->ImmOp = 5;
            top->rd = 10;
            top->rs1 = 0;
            break;
            case 8: // write SLT to x16
            top->ALUsrc = 0;
            top->ALUctrl = 5;
            top->rd = 16;
            top->rs1 = 10;
            break;
        }

        if (Verilated::gotFinish() /*|| (vbdGetkey() == 'q') */ ) exit(0);
    }
    // vbdClose();
    tfp->close();
    exit(0);
}