# Control Unit

![control_unit](./images/CONTROL_UNIT.png)

### The following instructions are to be implemented:
#### `addi`

Add immediate. Add the value of an immediate to the value of a register and store the result in another register.

*Required control signals*

* Enable `RegWrite` so value can be stored in reg
* Set `ImmSrc` to the correct format
* Set `ALUsrc` to `1` to select `ImmOp` as the second operand
* Set `ALUctrl` to value that selects the *SUM* operation

#### `bne`

Branch not equal. If the operands from the previous instruction are not the same then change the PC to PC + the value of the immediate.

**NOTE:** 
*The implementation is based on the diagram in the lab, where the branching is based only on the value of the immediate and not of the register*

*Required control signals*

* Check on input `EQ` to decide whether to branch or not
* Set `ImmSrc` to the correct format
* If branching is happending then set `PCsrc` to `1` to change the next program counter to PC + Imm

#### `lw` 

Load word. Load into a register the word at the address given by another register and offset by the immediate.

***Requires significant changes to the components***

### Technical details

Instruction | opcode | funct3 | funct7 | Type
--- | :---: | :---: | :---: | :---: 
*`addi`* | `0010011` | `000` | - | I 
*`lw`* | `0000011` | `010` | - | I 
*`bne`* | `1100011` | `001` | - | B 

It can be observed that each opcode uniquely identifies each instructions so the funct are redudant for now.

### Testing

```
Running simulation
ADDI 
RegWrite: 1
ALUctrl: 00
ALUsrc: 1
ImmSrc: 000
PCsrc: 0

BNE false
RegWrite: 0
ALUctrl: 00
ALUsrc: 0
ImmSrc: 000
PCsrc: 0

BNE true
RegWrite: 0
ALUctrl: 00
ALUsrc: 0
ImmSrc: 011
PCsrc: 1
Simulation completed
```

Outputs are as intended.


### Adding Data Memory Signals

With the data memory additional signals needed to be added to allow for the control of storing data, as well as fetching the addresses correctly and reading data from the RAM. 

This includes the ImmSrc, MemWrite, ResultSrc and AluSrc signals

#### `Sw`

Store Word, this is the instruction to save data from a register into a given address of the data memory, this is done by controlling the Write Enable section of the data_memory and taking the output from the regfile at RD2 as the data and the data from RD1 + Imm to get the address to write the data to.


*Required Control Signals*
* Enable `MemWrite` to allow data to be written to the Data Memory
* Enable `AluSrc` to set the input to the alu to be the immediate value
* Enable `ImmSrc` to make sure that sign extenstion occours
* Set `AluCtrl` to the SUM operation  

### Testing

Further testing was then added to make sure that the control signals for the `sw` instruction is correctly controlled, also a test program was tested which stored and loaded instructions to check proper operation of the data memory block. 

During this an issue was found in which the Program Counter would loop after 32 instructions of a program, this was due to simple miss labeling of a parameter and as such, would set the program counter to have a size 2^5, this was then changed to a larger value to allow for more complex programs to be ran.

**NOTE:** 
*The size of the program counter is arbituary and as such needs to be kept to a reasonable value for simulation sizes but large enough to store instructions of large programs*


### Notes

* A package was created to hold the type definitions common to the control logic blocks. This can be further extended to other modules in the CPU.
	* To have proper compilation the package (`types_pkg.sv` in this case) must be placed before the other files. In turn the `--top-module` flag must be specified in order to get the correct file names and structure. For example:
		```sh
		verilator -Wall --cc --trace types_pkg.sv control_unit.sv --top-module control_unit --exe control_unit_tb.cpp
		```
* In the combinational logic block the outputs are initialized to zero so that they always hold that default value. This prevents rogue HIGH signals where not desired.

