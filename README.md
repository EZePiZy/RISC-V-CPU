# <center>**IAC RISC-V**</center>
---
## <center> **RISC-V Design - 2nd year EIE IAC coursework** </center>
---

- [**IAC RISC-V**](#iac-risc-v)
  - [ **RISC-V Design - 2nd year EIE IAC coursework** ](#-risc-v-design---2nd-year-eie-iac-coursework-)
    - [**Team members \& Single-cycle CPU tasks allocations**](#team-members--single-cycle-cpu-tasks-allocations)
    - [**High level description**](#high-level-description)
    - [**Links to README in RTL**](#links-to-readme-in-rtl)
    - [**Explanation and testing of our selected programs**](#explanation-and-testing-of-our-selected-programs)
    - [F1 assembly basic:](#f1-assembly-basic)
    - [F1 assembly I/O:](#f1-assembly-io)
    - [PDF assembly:](#pdf-assembly)
    - [**Explanation of _run.sh_**](#explanation-of-runsh)
    - [**Branch Protection Policy**](#branch-protection-policy)
    - [**Directory Format**](#directory-format)
    - [**Table of tasks**](#table-of-tasks)

---

### **Team members & Single-cycle CPU tasks allocations**
* Luigi Rinaldi: 
  * Task: The Control Unit, the Sign-extension Unit and the instruction memory. 
* Diego Van Overberghe
  * Task: The Register File, ALU and the related MUX.
* Corey O'Malley: 
  * Task: The testbench and verification of the design working via gtkWave and Vbuddy (where appropriate).
* Ezra Reich: 
  * Task: Program Counter and related adders.




---

### **High level description**

  *  Design a **SINGLE CYCLE CPU** that executes two (or three) RISC-V instructions. 
  *  Same function as the **8-bit binary counter** designed in Lab 1
  *  The CPU fetches the next instruction from memory.
  * The instruction is decoded to determine what operation it specifies.
  * The CPU retrieves the operands for the instruction from registers or memory, as needed.
  * The CPU executes the instruction using the operands.
  * The CPU stores the result of the instruction in a register or memory, as needed.
  * The CPU increments the program counter to move on to the next instruction.

**/!\ For more in depth explanation please see the README in the RTL folder /!\ (Links below)**

---
### **Links to README in RTL**

- [Control Unit](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/tree/develop/RTL/CONTROL_UNIT#readme)
- [CPU](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/tree/develop/RTL/CPU#readme)
- [Data Memory](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/tree/develop/RTL/DATA_MEMORY#readme)
- [PC & ROM](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/tree/develop/RTL/PC#readme)
- [Regfile & ALU](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/tree/develop/RTL/REGFILE_ALU#readme)
- [Sign Extension](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/tree/develop/RTL/SIGN_EXTEND#readme)
- [Types](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/tree/develop/RTL/TYPES#readme)
- [Programs](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/tree/develop/programs#readme)

---

### **Explanation and testing of our selected programs**


### F1 assembly basic: 

This program is a simple program written in RISC-V assembly language that counts down from 8 and displays a pattern on VBuddy at each iteration, then loops indefinitely repeating this process. It uses a loop labeled "countdown" to count down from 8 and another loop labeled "delay" to pause for a certain number of iterations before resetting a register and returning to the start of the program.

* The program begins at the "start" label and initializes two registers, a0 and a1.
  
* It then enters a loop labeled "countdown", which decrements a1 and shifts the value in a0 left by 1 before adding 1 to it. This has the effect of counting down from 8 and displaying a pattern on the external device at each iteration.
  
* When a1 reaches 0, the program jumps to the "delay" label, which implements a loop that does nothing for 10 iterations.
  
* After the delay, the program resets the value in a0 to 0 and jumps back to the "start" label to repeat the countdown and display sequence indefinitely.



### F1 assembly I/O: 

  * The program begins by entering a loop that waits for the trigger signal to be set (the trigger signal is represented by bit 1 of register x31, also known as t6). The loop will continue until the trigger signal is set.
  
  * Once the trigger signal is set, the program resets the trigger signal back to 0 and then starts a countdown from a certain number (8 in this case). The countdown is implemented using a loop that decrements a counter (t0) and terminates when the counter reaches 0.
  
  * After the countdown finishes, the program enters a delay loop that simply increments a register (zero) a certain number of times (10 in this case). This delay loop is implemented as a loop that decrements a counter (t0) and terminates when the counter reaches 0.
  
  * After the delay, the program calls a subroutine called "wait_second" which waits for a 1 second pulse signal to be set (the 1 second pulse is represented by bit 0 of register x31, also known as t6). Once the 1 second pulse is set, the program resets the 1 second pulse back to 0 and then returns from the subroutine.
  
  * The program then jumps back to the beginning of the loop that waits for the trigger signal, starting the sequence again.
   
### PDF assembly: 

* The main function begins by calling two functions: "init" and "build".
  
* The "init" function initializes a buffer in memory by setting all the values in the buffer to 0. It does this by using a loop that decrements a counter (a1) and stores a value of 0 in the buffer until the counter reaches 0.
  
* The "build" function builds a PDF using data from an array in memory. It does this by using a loop that reads a value from the data array, increments the corresponding bin in the PDF, and then increments an offset into the data array until the bin count reaches a maximum value.
  
* After the "build" function returns, the main function enters an infinite loop that calls the "display" function and then jumps back to the beginning of the loop.
  
* The "display" function sends the values in the PDF array to a function for display. It does this by using a loop that reads a value from the PDF array, sends it to the display function, and then increments an offset into the PDF array until the end of the array is reached.
  
---

### **Explanation of _run.sh_**

The script takes one, two or three arguments: the name of an assembly program file, the name of a testbench file and the name of a .mem file.

Here is a breakdown of what the script does:

* If no arguments are provided, the script simply runs the simulation using the previously assembled program and the default testbench file (CPU_tb.cpp).

* If one argument is provided, the script assembles the specified assembly program file, copies the resulting .mem file into the CPU directory, and runs the simulation using the default testbench file.

* If two arguments are provided, the script does the same as above but also copies the specified testbench file into the CPU directory and uses it for the simulation.

* If three arguments are provided, the script does the same as above, but also copies the specified data memory file into the CPU directory.

The script also includes some cleanup commands to remove any previously generated files and directories.


---
### **Branch Protection Policy**

The `main` branch is protected an cannot be directly pushed to. This is to attempt to protect production code from untested development code.

When team members approve a pull request from `develop` into `main`, they are indicating that they are reasonably confident that the code in question has been tested and is working as expected. This also helps familiarise team members with others' code.
On the other and, if a pull request is opened merging a feature branch into the `develop` branch, approval incites team members to read through new code to ensure they remain familiar with the codebase.

---

### **Directory Format**

The main branch is protected and the only way to modify it is by submitting a pull request which must be approved by at least two other contributors.

The develop branch looks as follows:

Notice that obj_dir, and the *.vcd files are not included in the repository.

```
README.md (this file)
Assembler P Cheung recommended assembler
F1_asm and other code
programs machine code (.mem) that will be run with the cpu run.sh comman d
RTL ━━━━━┳━ run.sh build to full CPU testbench, and when entering a parameter (ie. hello), moves hello.mem from programs folder to instruction.mem in the CPU folder.
         ┣━ CPU ━━━━━┳━ CPU.sv
         ┃           ┣━ PC.sv
         ┃           ┣━ CONTROL.sv
         ┃           ┣━ INSTR_MEM.sv
         ┃           ┣━ ...
         ┃           ┣━ CPU_tb.cpp
         ┃           ┣━ Vbuddy.cpp
         ┃           ┣━ Vbuddy.cfg
         ┃           ┣━ README.md Explaining the use of the component
         ┃           ┗━ images ━┳━ CPU.png Screaming Snake Case
         ┃                      ┗━ ...
         ┃
         ┣━ PC ━━━━━━┳━ PC.sv
         ┃           ┣━ PC_tb.cpp
         ┃           ┣━ Vbuddy.cpp
         ┃           ┣━ Vbuddy.cfg    
         ┃           ┣━ README.md 
         ┃           ┗━ images ━┳━ PC.png
         ┃                      ┗━ ...
         ┗━ CONTROL ━┳━ CONTROL.sv
                     ┣━ CONTROL_tb.cpp
                     ┣━ Vbuddy.cpp
                     ┣━ Vbuddy.cfg
                     ┣━ README.md
                     ┗━ images ━┳━ CONTROL.png
                                ┗━ ...
.
.
.
and so on
```

and so on...

This allows individual components to be tested individually with their own testbenches. This allows continuous debugging of components. When a component is updated it must be updated in the component folder first, then tested and finally copied to the main CPU folder.


--- 

### **Table of tasks**

| Module / Team members 	| Luigi 	| Diego 	| Corey 	| Ezra 	|
|-----------------------	|-------	|-------	|-------	|------	|
| F1_asm_basics.s       	| M     	| C     	| C     	| C    	|
| F1_asm_IO.s           	| M     	|       	|       	|      	|
| pdf_tb.cpp            	| M     	| C     	|       	|      	|
| pdf.s                 	| C     	| C     	| C     	| C    	|
| F1_IO_tb.cpp          	| M     	|       	|       	|      	|
| CONTROL_UNIT.sv       	| M     	| C     	| C     	| C    	|
| CONTROL_UNIT_tb.cpp   	| M     	|       	|       	|      	|
| CPU_tb.cpp            	| C     	| C     	| M     	| C    	|
| CPU.sv                	| C     	| C     	| M     	| C    	|
| DATA_MEMORY.sv        	| C     	| C     	| M     	| C    	|
| RAM.sv                	|       	|       	| M     	|      	|
| PC_ROM_tb.cpp         	|       	|       	|       	| M    	|
| PC.sv                 	|       	| C     	|       	| M    	|
| ROM.sv                	|       	|       	|       	| M    	|
| ALU_tb.cpp            	|       	| M     	|       	|      	|
| ALU.sv                	|       	| M     	|       	|      	|
| REGFILE_tb.cpp        	|       	| M     	|       	|      	|
| REGFILE.sv            	|       	| M     	|       	|      	|
| REGFILE_ALU.sv        	|       	| M     	|       	|      	|
| REGFILE_ALU_tb.cpp    	|       	| M     	|       	|      	|
| SIGN_EXTEND_tb.cpp    	| M     	|       	|       	|      	|
| SIGN_EXTEND.sv        	| M     	|       	|       	|      	|
| types_pkg.sv          	| M     	| C     	| C     	| C    	|
| run.sh                	| M     	|       	| M     	|      	|

*KEY*: 
  * M = Main contributor
  * C = Contributed