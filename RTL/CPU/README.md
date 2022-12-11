# Testing and Verification

![CPU_Full](./images/MICROARCHITECTURE.jpg)


## Testing Steps:

### Syntax Checking

* Pass over all components and check for correct naming conventions (`SCREAMING SNAKE CASE` for files, `Pascal Case` for Pins and Wires) of components and labels for connections

* Check for correct naming of components to match that of given diagrams, as well as file names for simplicity

### Component Tests

* Each component needs to be tested on a range of inputs and compared against the corrosponding correct waveforms

* The correct output is recieved from the given input signals for each component, with there respective inputs

### Top File Tests

* Develop a set of test files to run that can be used to check the correct function of the single cycle CPU

* Test each one and see if the desired functions are ran

# Syntax Checking:

## Repo Tree Cleaning
```
RISC-V-CPU
│   README.md    
│   .gitignore
|
└───CONTROL_UNIT
|   |───images
|   |       CONTROL_UNIT.png
│   │   CONTROL_UNIT_tb.cpp
|   |   CONTROL_UNIT.sv
|   |   exe.sh
|   |   README.md
│   
└───CPU
|   |───images
|   |       microarchitechture.jpg
|   │   CPU_tb.cpp
|   |   CPU.sv
|   |   exe.sh
|   |   README.md
|   |   rom.mem
|   │   vbuddy.cfg
|   |   vbuddy.cpp
└───PC
|   |───images
|   |       ASSERT_RST_PC.png
|   |       BRANCH_PC_ASSERT.png
|   |       INSTR_MEM_ROM.png
|   |       PC_IMAGE.PNG
|   |       PC_INC_ASSERT.png
|   |       ROM_MEM.png
|   │   exe.sh
|   |   PC_ROM_tb.cpp
|   |   PC_ROM.sv
|   |   PC.sv
|   |   README.md
|   │   rom.mem
|   |   top_PC_tb.cpp
|   |   vbuddy.cfg
|   |   vbuddy.cpp
└───REGFILE
|   |───images
|   |       SCHEMATIC.png
|   |       WAVEFORM1.png
|   |       WAVEFORM2.png
|   |   ALU.sv
|   │   exe.sh
|   |   README.md
|   |   REGFILE_ALU_tb.cpp
|   |   REGFILE_ALU.sv
|   │   REGFILE.sv
└───SIGNEXTEND
|   |───images
|   |       INSTRUCTION.png
|   |       SIGN_EXTEND.png
|   │   exe.sh
|   |   README.md
|   |   SIGN_EXTEND_tb.cpp
|   |   SIGN_EXTEND.sv
└───TYPES
    |───types_pkg.sv
```
### Steps for cleaning Tree:
1. Apply Naming Convention (Screaming Snake Case/Pascal Case/Snake Case)
2. Add vbuddy.cfg and vbuddy.cpp to each dir
3. Create Heighrachal structure 
4.  