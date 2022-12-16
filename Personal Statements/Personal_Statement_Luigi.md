# **Personal Statement: Luigi Rinaldi -  CID: 02044991**

- [**Personal Statement: Luigi Rinaldi -  CID:**](#personal-statement-luigi-rinaldi----cid)
	- [**What I contributed to**](#what-i-contributed-to)
		- [General](#general)
		- [Programs and Testbenches](#programs-and-testbenches)
		- [Single-cycle](#single-cycle)
		- [Pipeline](#pipeline)
		- [Cache](#cache)
	- [**What I learned**](#what-i-learned)
	- [**Mistakes I made**](#mistakes-i-made)
	- [**What I would do differently**](#what-i-would-do-differently)



## **What I contributed to**

My contributions can be divided in the following sections: 
* General
* Programs
* Single-cyle CPU
* Pipeline CPU
* Cache CPU 
  
### General

- Introduced a shared type system to improve legibility of components and prevent mistakes [1](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/9f8f2413127baa697c88d8748bc572871d8dfc84), [2](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/b6146a735be99485e50cfdacfcd93a9f6f05e3d5) and [3](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/9cc3b4c15e1afcb787a322cd3b36cd9cf2cd4982). This was achieved using the package feature of SystemVerilog. 
- Expanded `run.sh` (originally `exe.sh`) file to automatically assemble `.s` files into `.mem` files and move them into the correct folder for executions. This greatly sped up the workflow as it allowed assembly programs to be tested with one line and it allowed for custom testbenches for different programs. [1](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/22bd9dc38445407fe1a23c4cc3a70fde93eeb752), [2](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/34d191b00a80dc5a94e1c1070c9de9ab84619cbb)
- Created schematic of the single cycle CPU using [Issie](https://tomcl.github.io/issie/). This was of great help in debugging the whole CPU and making sense of which control signals were responsible for what. [1](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/3171942db0a320fcb9b0ebd1ba37ea4182a503d4) and [2](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/e3e5569ed803d4cea1bd07c02b52d5a8b481804d)

### Programs and Testbenches

- Wrote the basic F1 light sequence assembly program and debugged it with other team members [1](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/48a83cac2ab35ea8b79c453b6c653ecf62909647)
- Wrote F1 light sequence assembly program that allows for user interaction and accurate 1 second timing [1](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/1db4d1acf174c0e5c40f7c356e2871916c55141b) and [2](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/f1db0ca260065ae0a2fa659f0b912d1a36738939)
- Wrote a testbench for the reference `pdf.s` that runs the CPU, stores the values it generates in an array, displays them on Vbuddy and stores them in an `out.csv.`. [1](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/9addd7024e4c642211e0a5cb593fe0cd6c5081b3)

### Single-cycle

- Designed, built and tested the Control Unit [1](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/9f8f2413127baa697c88d8748bc572871d8dfc84) and [2](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/ba22ef82db8601f2d584bb4cc569fdca068a1a18)
- Designed, built and tested the Sign Extend [1](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/ebcd6e6c0530a113c2bfd740aacf584ad825786f)
- Collaborated with Exra to implement new instruction required for the reference `pdf.s` program [1](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/ed135e1f9ad6f265f97075c073fed178ec5794ae)
- Collaborated with team members to complete, test and debug the CPU [1](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/2e8868cba408d528b1612f0e013a86506f383ba9)
  
### Pipeline 

- Collaborated with team members to test, debug and fix pipelined CPU [1](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/358858bc7fd33fd36d0927ef62484d371ecda2f5)

### Cache

- Collaborated with team member to design, implement, test, fix and debug the Data Memory Cache [1](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/d25bd4a70e8f78e2cdf81bec459ce508c7d4db12)

## **What I learned**

This project has been a truly enriching learning experience. Not only have I had the opportunity to solidify my understanding of SystemVerilog, but I have also gained an in-depth knowledge of the RISC-V instruction set architecture. Through this project, I have come to better understand the complexity and nuance of computer architecture, particularly in regards to the design and implementation of a pipelined CPU and cache.

Furthermore, I have learned to appreciate the importance of good scripting and naming conventions as tools for efficient and quick workflows. These practices have allowed me to prototype and iterate rapidly, which has been incredibly valuable in the development of this project. All in all, this project has provided me with a wealth of knowledge and insight that I will carry with me for years to come.

Finally it has been a great experience working on this project as a team, allocating tasks and helping each other out. 

## **Mistakes I made**

While writing the testbench for the F1 light sequence with trigger signals and accurate 1 second delays I was writing to the `x31` register directly, therefore overwriting the previous values. The fix for this was to expose the `x31` register on the output as well, so that when writing to it only the relevant bits get changed, but the other bits remain unchanged. 

## **What I would do differently**

Overall I am quite satisfied with the way the project was completed and there are no major changed in the process that I would want. The team collaboration was quite effective but due to the nature of the project it was tricky to split tasks up and assign them individually, since an individuals' contribution would prevent everyone else from moving on. 
