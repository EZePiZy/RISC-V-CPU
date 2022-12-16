# <center>**Personal Statement: Ezra Reich -  CID: 02020046**</center>

---
- [**Personal Statement: Ezra Reich -  CID: 02020046**](#personal-statement-ezra-reich----cid-02020046)
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
- Designed and built the PC, instruction memory and related adders blocks [PC, ROM and instruction memory](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/b349d4fef6f78da4b37eb2c8f4748ad8a2d4baa7)
- Debugged and tested the CPU with the [F1 lights program](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/e7ab0bab7b548a57b3de3f87cb1e87de2faabf6f)
- Created the F1 lights [testbench](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/e7ab0bab7b548a57b3de3f87cb1e87de2faabf6f)
- Separated PC and ROM components into [2 individual components](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/53eceaab51c727b237de978f5ad972fb098fb6c5) for debug and clarity purposes. 
- Added logic in the [Control Unit](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/ed135e1f9ad6f265f97075c073fed178ec5794ae) to implement new instructions needed for the reference (PDF) program
- Implemented team [TYPES convention](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/1b5942788100c4b43089a2200152622d6ad8e0cc) in the PC and ROM designs 
- Fixed instruction memory file and fixed [control signals](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/0e29bc6e60e460e7b21bd30639b4080c1bec708f) for the `J`instruction 
  
### 2. Pipeline 
- Documented the README file and laid out the different [tasks and goals](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/2dc10044c7539f888ff7780adc762b0ed36999af) our team had in order to complete the pipeline CPU
- Created a [schematic](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/b6c7ab41fa6164538e9db6c0abda2ccc8e8b77ab) on *Issie* in order to have an accurate and less abstract idea of our fully assembled design.
- Changed the [RAM structure](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/d2b2dd19e722485a5b0a1efadd719c87f07613be) for each address to correspond to a byte rather than a word
- Edited the executable [bash script](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/94e1dbedee7ad8325c186c4aab96b21a43b9478e) to include the new pipeline components
- Updated and debugged the [reference program](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/6602ed875ca0c9255563860891ae7cb4a4104703) (PDF) to be hazard free and executing correctly in the pipelined CPU
- [Optimised](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/4bf8943ed0e5d0d38e1a81578b688874a0ac8a96) and added explanations about our methods to reduce the number of `nop` in our software
- Debugged and [resolved the `jalr`](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/358858bc7fd33fd36d0927ef62484d371ecda2f5)instruction issue in the pipeline CPU
- Added logic tested and debugged the [Control Unit](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/ed135e1f9ad6f265f97075c073fed178ec5794ae) to implement new instructions and edited the README to explain the handling of the control signals

### 3. Cache
- Helped in [conceptualisation of the cache](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/d25bd4a70e8f78e2cdf81bec459ce508c7d4db12) in the CPU
- Helped in [testing](https://github.com/EIE2-IAC-Labs/iac-riscv-cw-5/commit/d25bd4a70e8f78e2cdf81bec459ce508c7d4db12) of the cache

---

## **What I learned**

During the design process of a RISC-V pipelined and cached CPU in SystemVerilog, I learned the importance of thoroughly understanding the hardware architecture and the interactions between different components. This included understanding the different stages of the pipeline and how instructions flow through them, as well as the role of the cache in improving performance. I also learned about hazards and the need to implement techniques to prevent or resolve them in order to ensure the correct execution of instructions.

By taking a more modular approach to the design, I learned how to focus on one component at a time and thoroughly test and debug it before moving on to the next. This made it easier to identify and fix any issues, and resulted in a more organized and efficient design process.

In addition to hardware design, I also learned about the importance of writing clean, well-documented software in SystemVerilog. I learned about the syntax and conventions of SystemVerilog, as well as good coding practices such as commenting and following conventions implemented by our team like using types and organizing files. I also learned how to test and debug hardware and software designs using simulation tools and testbenches. Overall, the design process of a RISC-V pipelined and cached CPU taught me a great deal about the hardware and software aspects of computer architecture, and the importance of careful planning and testing in ensuring a successful design.

In order to effectively manage team work in a group project, it is important to establish clear communication channels and set expectations for contributions and deadlines. In our group, we planned regular meetings to discuss progress, assign tasks, and address any issues that arose.

I learned how to use Git as a version control system to manage and track changes to the project code. This included learning how to clone repositories, create branches, commit and push changes, and merge branches. Using Git helped us to efficiently collaborate on the project and maintain a clear history of our work. Overall, effectively managing team work and using version control systems were important skills that I developed during the project.

---

## **Mistakes I made**

One mistake I made while designing a cached and pipelined RISC-V CPU was merging the PC and ROM components into one. This made the full design less clear and harder to debug. I had to divide them into two separate components in order to improve clarity and facilitate debugging.

Another mistake I made was getting confused by the ADDRESS_WIDTH parameter in the ROM file. At first, I assumed that it was 32, as there are a maximum of 32 bits in a RISC-V address. However, it was only through discussion with Diego that I realized that the ADDRESS_WIDTH was actually 5, as 2^5 = 32. This misunderstanding caused me to spend more time trying to debug the ROM component before realizing my mistake.

Overall, these mistakes taught me the importance of thoroughly understanding the design and being willing to seek help when needed. It also highlighted the value of clear and organized design, as well as the importance of double-checking assumptions and paying attention to details.

---

## **What I would do differently**

If I were to design a RISC-V CPU again, there are a few things I would do differently. First, I would spend more time researching and understanding the architecture and design principles of RISC-V CPUs. This would help me to make more informed design decisions and potentially identify any potential issues or optimization opportunities earlier on in the process.

Another thing I would do differently is that I would make sure to thoroughly test and debug the CPU before considering it complete. This could involve writing a comprehensive suite of test cases and using simulation tools to verify the correct behavior of the CPU. Ensuring that the CPU is fully tested and debugged would help to reduce the risk of issues arising after the design is complete.

If I had more time, I would also consider implementing additional features and optimizations in the CPU. This could include implementing support for additional instructions, improving the performance of the cache, or implementing techniques such as data forwarding or branch prediction to improve the efficiency of the pipeline. Overall, considering additional features and optimizations, would help me to design a more effective and efficient RISC-V CPU.