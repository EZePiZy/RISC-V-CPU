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

### <ins> **Branch Protection Policy:** </ins>

The `main` branch is protected an cannot be directly pushed to. This is to attempt to protect production code from untested development code.

When team members approve a pull request from `develop` into `main`, they are indicating that they are reasonably confident that the code in question has been tested and is working as expected. This also helps familiarise team members with others' code.
On the other and, if a pull request is opened merging a feature branch into the `develop` branch, approval incites team members to read through new code to ensure they remain familiar with the codebase.

## Directory Format

The main branch is protected and the only way to modify it is by submitting a pull request which must be approved by at least two other contributors.

The develop branch looks as follows:

Notice that obj_dir, and the *.vcd files are not included in the repository.

```
REAMDE.md this file
CPU ━━━━━┳━ CPU.sv
         ┣━ PC.sv
         ┣━ CONTROL.sv
         ┣━ INSTR_MEM.sv
         ┣━ ...
         ┣━ CPU_tb.cpp
         ┣━ Vbuddy.cpp
         ┣━ Vbuddy.cfg
         ┣━ README.md Explaining the use of the component
         ┗━ images ━┳━ CPU.png Screaming Snake Case
                    ┗━ ...

PC ━━━━━━┳━ PC.sv
         ┣━ PC_tb.cpp
         ┣━ Vbuddy.cpp
         ┣━ Vbuddy.cfg    
         ┣━ README.md 
         ┗━ images ━┳━ PC.png
                    ┗━ ...
CONTROL ━┳━ CONTROL.sv
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
