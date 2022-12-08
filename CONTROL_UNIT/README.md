# Control Unit

![control_unit](./images/microarchitecture.jpg)

### Instruction types

All instructions are part of a *Type* which identifies how they interpret the bits of the immediate.

Type | Opcode | Description | Implemented instructions | Shared Control Signals 
--- | --- | --- | --- | --- 
**`R`** | `0110011` | Register to Register instructions | None
**`I1`** | `0000011` | Load instructions that use 12-bit immediate | `lw`
**`I2`** | `0010011` | ALU instructions that use 12-bit immediate | `addi` , `slli` | set `RegWrite` to enable writing to register <br /> set `ImmSrc` to `Imm` <br /> set `ALUsrc` to select `ImmOp` as second operand
**`I3`** | `1100111` | Jump with 12-bit immediate | `jalr`
**`S`** | `0100011` | Store instruction with 12-bit immediate | `sw`
**`B`** | `1100011` | Branch instructions with 13-bit immediate | `bne`
**`U`** | `0010111` <br /> `0110111` | Upper immediate instructions | None
**`J`** | `1101111` | Jump instructions with 20-bit immediate | `jal` | Only one instruction is implemented so no shared signals

### Implemented instructions
#### `addi`

Add immediate. Add the value of an immediate to the value of a register and store the result in another register.

*Required control signals*

* Set `ALUctrl` to value that selects the *SUM* operation

#### `bne`

Branch not equal. If the operands from the previous instruction are not the same then change the PC to PC + the value of the immediate.

*Required control signals*

* Check on input `EQ` to decide whether to branch or not
* If branching is happending then set `PCsrc` to `1` to change the next program counter to PC + Imm

#### `lw` 

Load word. Load into a register the word at the address given by another register and offset by the immediate.

*Required Control Signals*
* Set `RegWrite` to high to allow writing to registers
* Set `ALUctrl` to execute sum operation
* Set `ResultSrc` to high to select Data Memory output as write content
* Set `ALUsrc` to high to select `ImmOp` as the second operand

#### `sw`

Store Word, this is the instruction to save data from a register into a given address of the data memory, this is done by controlling the Write Enable section of the data_memory and taking the output from the regfile at RD2 as the data and the data from RD1 + Imm to get the address to write the data to.


*Required Control Signals*
* Enable `MemWrite` to allow data to be written to the Data Memory
* Enable `AluSrc` to set the input to the alu to be the immediate value
* Enable `ImmSrc` to make sure that sign extenstion occours
* Set `AluCtrl` to the SUM operation  

#### `slli`

Shift logical left immediate, this instruction shifts the contents of a given register left by the amount specified in the immediate. 

*Required Control Signals*

* Set `ALUCtrl` to the *SLL_OP* operation, which shifts left

#### `jal`

This instructions changes the `PC` to `PC + ImmOP` and saves what would have been the next instruction to a given register

*Required Control Signals*

* Enable `jumpSaveNext` to connect `WD3` to `nextPC`
* Enable `RegWrite` to enable writing to registers
* Enable `PCsrc` to make the next PC be given by `PC + ImmOp`

#### `jalr`

This instruction changes the `PC` to the sum of a given register and the immediate. It then saves what would have been the next instruction address to another given register. The instructions is used to return from subroutines. To do this we need to add an additional mux that will allow us to set `PC` to the value of the output `Result`. 

* Enable `jumpSaveNext` to connect `WD3` to `nextPC`
* Enable `RegWrite` to enable writing to registers
* Enable `ALUsrc` to make the ALU add an immediate and a register value
* Enable `PC2Result` A new signal to set a mux to set the PC to the Result Value
* Enable `Resultsrc` This changes the output of result to be from the ALU instead of Data Memory
* set `ImmSrc` to make sure the immediate value is that for a jump instruction as well as it is sign extended
* set `AluCtrl` to the SUM operation

**TODO**

* Change PC_ROM components to be a single block with the muxs controlling them to be within the top file.

#### Opcode and funct mapping

Instruction | opcode | funct3 | funct7 | Type
--- | :---: | :---: | :---: | :---: 
*`addi`* | `0010011` | `000` | - | I 
*`lw`* | `0000011` | `010` | - | I 
*`bne`* | `1100011` | `001` | - | B 

**TODO add other instructions**

### First implementation
A package was created to hold the type definitions common to the control logic blocks. This can be further extended to other modules in the CPU.
To have proper compilation the package (`types_pkg.sv` in this case) must be placed before the other files. In turn the `--top-module` flag must be specified in order to get the correct file names and structure, for example:
  ```sh
  verilator -Wall --cc --trace types_pkg.sv control_unit.sv --top-module control_unit --exe control_unit_tb.cpp
  ```

In the combinational logic block the outputs are initialized to zero so that they always hold that default value. This prevents rogue HIGH signals where not desired.

#### Testing

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

#### Testing

  Further testing was then added to make sure that the control signals for the `sw` instruction is correctly controlled, also a test program was tested which stored and loaded instructions to check proper operation of the data memory block. 

  During this an issue was found in which the Program Counter would loop after 32 instructions of a program, this was due to simple miss labeling of a parameter and as such, would set the program counter to have a size 2^5, this was then changed to a larger value to allow for more complex programs to be ran.

  **NOTE:** 
  *The size of the program counter is arbituary and as such needs to be kept to a reasonable value for simulation sizes but large enough to store instructions of large programs*



## Control Unit Refactor
The motivation for refactoring the control unit was the fact that depending on the instruction type, the CPU requires more or less of the instruction to correctly set the control signals.

For example, R-Type instructions need the following parts of the instruction to set control signals appropriately: 
`opcode: instr[6:0], func3: instr[14:12], funct7: instr[31:25]`.

On the other hand, B-Type instructions only require `opcode: instr[6:0]` to set the control signals.
### Hardware changes

A simple switch `case(instr)` could have been used, but this would have most likely quickly gotten out of hand, as this switch would list the encoding for every single RISC-V instruction implemented.

Instead, a nested switch approach will be used, where the top level switch checks the opcode, which sepecifies the instruction format, and nested switches for every instruction format so that the switch can check `funct3`, `funct7` or neither as required.

### Testing

Each instruction will be tested in turn, with the control unit isolated from other CPU components.

#### `addi`

