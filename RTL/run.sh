#!/bin/sh

testbench="CPU_tb.cpp"

if [ $# -eq 1 ]; then
  if [ -f ../programs/$1.s ]; then
    echo "Assembling $1.s from programs"
    cd ../assembler
    ./assemble.sh $1
    echo "Deleting old program, and loading $1.mem into CPU."
    cd ../RTL/CPU
    rm -f instruction.mem
    cp ../../programs/$1.mem instruction.mem
  else
    echo "File does not exist in the programs folder!"
  fi
elif [ $# -eq 2 ]; then # passing aasembly file and testbench
  if [ -f ../programs/$1.s ]; then
    echo "Assembling $1.s from programs"
    cd ../assembler
    ./assemble.sh $1
    echo "Deleting old program, and loading $1.mem into CPU."
    cd ../RTL/CPU
    rm -f instruction.mem
    cp ../../programs/$1.mem instruction.mem
  else
    echo "File does not exist in the programs folder!"
  fi
  if [ -f ../../programs/$2.cpp ]; then
    echo "Using $2.cpp as testbench"
    cp ../../programs/$2.cpp tmp_tb.cpp
    testbench=tmp_tb.cpp
  else
    echo "Testbench file not found, using default CPU_tb.cpp"
  fi
elif [ $# -eq 0 ]; then
  echo "Running previous program!"
else
  echo "Expected one or two parameters!"
  exit 
fi


# cleanup
rm -rf obj_dir
rm -f *.vcd

# run Verilator to translate Verilog into C++, including C++ testbench
verilator --Wall --cc --trace ../TYPES/types_pkg.sv CPU.sv -I../CONTROL_UNIT -I../DATA_MEMORY -I../SIGN_EXTEND -I../PC -I../REGFILE_ALU/REGFILE -I../REGFILE_ALU/ALU --top-module CPU --exe $testbench

# build C++ project via make automatically generated by Verilator
make -j -C obj_dir/ -f VCPU.mk VCPU

if [ -f ./tmp_tb.cpp ]; then 
  echo "removing tb file"
  rm -f tmp_tb.cpp
fi

# run executable simulation file
echo "Running simulation"
obj_dir/VCPU
echo "Simulation completed"

# final cleanup
cd ..