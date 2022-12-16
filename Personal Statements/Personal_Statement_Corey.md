# <center>**Personal Statement: Corey O'Malley -  CID: 02050238**</center>

---
- [**Personal Statement: Corey O'Malley -  CID: 02050238**](#personal-statement-corey-omalley----cid-02050238)
  - [**What I contributed to**](#what-i-contributed-to)
    - [1. Single-cycle](#1-single-cycle)
    - [2. Pipeline](#2-pipeline)
    - [3. Cache](#3-cache)
  - [**What I learned**](#what-i-learned)
  - [**Mistakes I made**](#mistakes-i-made)
  - [**What I would do differently**](#what-i-would-do-differently)

---


## **What I contributed to**

This project can be divided in 3 sections: 
* Single-cyle CPU
* Pipeline CPU
* Cache CPU 
  
### 1. Single-cycle

#### Readme And Fix Commits:

* [Changing File Structure](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/1e8eeddc19ca295ec590bdc20fd37ac1f83bf3fc)

* [Editing File Struture and Readme](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/38e99ae7ad1c245d565ba1d8025ab3cc37fbc817)

* [Readme Content](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/958c111ba39d8535eedbe61de2f6c0ff436b2aa0)

#### DataMemory / Ram:

* [1st Data Memory Commit](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/88590b72586d47e94bed83ac054633d533dc9cc7)

* [2nd Data Memory Commit](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/03013be4ee133a8f14ff4e0b796e5f483a7bf1a3)

* [3rd Data Memory Commit](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/54ec625c5fd4cb3fe4aab1a339d99a92d38efc6f)


#### Control Unit:

* [Adding Jalr](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/76e5436400da34ad5f2b5c0518089c86e14a35b3)

* [Byte Signals](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/87f8df7ce70ac5f08c43c2c59bcce891e9c43d78)

* [Mem Stuff](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/dd29f0197f4d2a6730ebc107d5eb3e18ee09cd1e)

### 2. Pipeline 

#### Control Unit / Signals:

* [Moving Control Logic](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/3de697a57cbb46e5e513da187879e5a9d0a736fe)

#### Registers: 

* [Register Internals](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/7ac4fcc5739f673365ecc54f7cf7f3b6ab4d6399)

#### CPU Changes:

* [Changing Layout and Adding Register Code](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/e425b58937790aced02e2b32ef552abbc21dfd6d)

* [1.Fixing Compiler Warnings](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/aa539cf67522da2c2842d75664e997446b003b80)

* [2.Fixing Compiler Warnings](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/eb5259dea70b6c2155a7390550ff32b1b3923b1c)

### 3. Cache

* [Adding Caching](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/d25bd4a70e8f78e2cdf81bec459ce508c7d4db12)

---
## **What I learned**

I learned about Verilog by designing and coding a RISC-V CPU in Verilog. This involved writing code to specify, its registers, instructions, and control flow. I also learned how to use simulation tools to test and debug my design. Through this project, I gained a strong understanding of both Verilog and the principles of computer architecture.

---
## **Mistakes I made**

DataMemory:

The main issue we faced with the datamemory component came from the change between byte addressing and full 32bit. We originally only implemented a data arrary of size 32x(2^16) this worked suffciently until the addition of the byte storing and reading instructions. 

To fix this we added a component around the Data_Memory that would seperate the 32bit output into that of 8bits signextended or not, from the memory using the last two bits of the address. This worked and was a full implementation the single cycle CPU, but it stopped the loading of the correct Data.mem file for the PDF. 

Finally to combat this issue fully we changed how the data_memory component worked with a 8x(2^16) data_array that would concatenate the correct 8x4 bytes into a full 32bit word. This would allow for simplier byte selection and proper loading of memory. This also was implemented as such to not effect the rest of the CPU.

Pipelining:

With Pipeling i implemented all the registers and muxs in quite a short period, this lead to a mistake in which i connected the PCsrc mux to the resultW. This would still compile and run but would effect the JALR instruction making it jump to the incorrect line. This was found quickly and changed to be ResultE and so would jump correctly.

---

## **What I would do differently**

Looking back on my experience designing and coding a RISC-V CPU, I can't think of any major changes I would make to my approach. However, there are a few things I would do differently in terms of how I managed my time and debugging process. Specifically, I would focus on minimizing small mistakes that waste time, such as typos and syntax errors. I would also try to be more efficient in identifying and fixing bugs in my code, as debugging can be a time-consuming task. By addressing these issues, I could potentially save a significant amount of time and improve my overall efficiency in the design and development process.