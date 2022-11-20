

# Logbook: Lab 4
## Part 1 : Program Counter and related adders.

- [Logbook: Lab 4](#logbook-lab-4)
  - [Part 1 : Program Counter and related adders.](#part-1--program-counter-and-related-adders)
    - [What I did:](#what-i-did)
    - [Traces analysis:](#traces-analysis)
    - [Problems encountered:](#problems-encountered)
    - [Other reflexions:](#other-reflexions)



### What I did: 
* Creation of a programme counter incorporating branches (ImmOp) / normal (+4) increments. 

![schematic](./logbook_images/PC_image.png)

* **TWO** modules are used: 
  *  <ins>*PC*</ins>: 
     * Flip-flop that takes the *next_PC* as input and set ``` PC = next_PC ``` If *rst* is 1 &rarr; ``` PC = 32'b0 ```
  * <ins>*MUX*</ins>:
    * If PCsrc is enabled &rarr; ```next_PC = PC + ImmOp ```
    * Else &rarr; ``` next_PC = PC + 4 ``` as RISC-V uses byte-addressable memory (i.e. byte has a unique
address), so each 32-bit word uses 4 byte addresses ; **32-bit word = 4 bytes, so word address increments by 4**
* Combining the modules in a **top-layer**: 
  * Very simple design, just assigning how the different wires should be connected. 
* Creation of a **Testbench** : 
  * The test bench simulates the design and confirms that everything works correctly. 
  * To test ImmOp and PCsrc (wires coming from other parts of the CPU) I set: 
    * ImmOp = VbdValue() &rarr; Sets an Immediate Operand of value in range 0 -> 100
    * PCsrc = VbdFlag() &rarr; Selects ```next_PC = PC + ImmOp ``` when the rotary switch is pressed. 

---

### Traces analysis:

- Asserting *rst* works as expected: 

![schematic](./logbook_images/assert_rst%20PC.png)


When ```rst = 0``` &rarr; ```PC = 0```

- Asserting *inc_PC* works as expected: 

![schematic](./logbook_images/pc_inc%20assert.png)
When ```PCsrc = 0``` then ```next_PC = PC + 4``` 

- Asserting *branch_PC* works as expected: 
  
![schematic](./logbook_images/branch_PC%20assert.png)
When ```PCsrc = 1``` then ```next_PC = PC + ImmOp```

---
### Problems encountered:

*None*

---
### Other reflexions: 

_None_

