# <center>IAC_RISC-V</center>
---
## <center> **RISC-V Design - 2nd year EIE IAC coursework** </center>
---
### <ins> **Team members:** </ins>
* Luigi Rinaldi: 
  * Task: The Control Unit, the Sign-extension Unit and the instruction memory. 
* Diego Van Overberghe
  * Task: The Register File, ALU and the related MUX.
* Corey O'Malley: 
  * Task: The testbench and verification of the design working via gtkWave and Vbuddy (where appropriate).
* Ezra Reich: 
  * Task: Program Counter and related adders.

---

### <ins> **Lab Specifications:** </ins>

* <ins>Lab 4 - A Reduced RISC-V CPU</ins>
  *  Design a **SINGLE CYCLE CPU** that executes two (or three) RISC-V instructions. 
  *  Same function as the **8-bit binary counter** designed in Lab 1

## Directory Format

The main branch is protected and the only way to modify it is by submitting a pull request which must be approved by at least two other contributors.

The develop branch looks as follows:

Notice that obj_dir, and the *.vcd files are not included in the repository.

CPU ━━━━━┳━ CPU.sv
         ┣━ PC.sv
         ┣━ CONTROL.sv
         ┣━ INSTR_MEM.sv
         ┣━ ...
         ┣━ CPU_tb.cpp
         ┣━ Vbuddy.cpp
         ┗━ Vbuddy.cfg
PC ━━━━━━┳━ PC.sv
         ┣━ PC_tb.cpp
         ┣━ Vbuddy.cpp
         ┗━ Vbuddy.cfg    
CONTROL ━┳━ CONTROL.sv
         ┣━ CONTROL_tb.cpp
         ┣━ Vbuddy.cpp
         ┗━ Vbuddy.cfg

and so on...

This allows individual components to be tested individually with their own testbenches. This allows continuous debugging of components. When a component is updated it must be updated in the component folder first, then tested and finally copied to the main CPU folder.