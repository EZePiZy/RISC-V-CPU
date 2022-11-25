#!/bin/sh

# cleanup
rm -rf obj_dir
rm -f *.vcd

# run Verilator to translate Verilog into C++, including C++ testbench
verilator --Wall --cc --trace ../TYPES/types_pkg.sv CPU.sv -I../CONTROL_UNIT -I../SIGN_EXTEND -I../PC -I../REGFILE_ALU/REGFILE -I../REGFILE_ALU/ALU --top-module CPU --exe CPU_tb.cpp

# build C++ project via make automatically generated by Verilator
make -j -C obj_dir/ -f VCPU.mk VCPU

# run executable simulation file
echo "Running simulation"
obj_dir/VCPU
echo "Simulation completed"

