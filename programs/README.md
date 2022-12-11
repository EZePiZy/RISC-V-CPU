# F1 Assembly program

The program is tested using [this](https://www.cs.cornell.edu/courses/cs3410/2019sp/riscv/interpreter/#) website.

Even better testing [website](https://venus.kvakil.me/)

## Desired Behaviour

1. Upon receving a trigger the routine is executed
2. The `a0` drives the led bar on the *VBuddy* turning on each light every second
3. Once all 8 lights are on a random amount of time elapses before they all turn off
4. The testbench uses *VBuddy* methods to measure how long it takes the user to press the button after the lights turn off

## Implementation

#### 1. Executing on trigger

- Register `x31` (`t6`) is used as a user input 
- Loop while `x31` is not `0`
- Once `x31` becomes `1` the rest of the program is executed
- At the end of the program `x31` is reset to `0` and ready to wait for another trigger input
- `x31` register has to be exposed to the top level component in order to be accessible by testbench

#### 2. Turning led lights on one at a time

- Loop 8 times using a temporary register (`t0`) 
- Each iteration shift `a0` left by 1 and add 1

#### 3. Random delay

- Call random delay subroutine 
- Generate random number using seed in memory
  - Read seed from memory
  - Use a software 8-bit *LFSR* to generate new random number 
    - *Could be expanded to higher bits for more randomness*
  - Save result in memory to use as seed for the following time
- Use generated random number to loop over `NOPs` thereby adding a random amount of delay
- Return to the program using `JALR` instruction

#### 4. Testbench and VBuddy

*TO-DO*

## Issues

### Pseudo-random number generation:
- In order to have a useful pseudo-random number generator some sort of seed is needed. 
- One way to implement this is to expose a memory address to the testbench in order to have a random seed, which can then be fed to pseudo-random routine
### 1 second delay:
- In order to achieve one second delay between each turning on the CPU clock could be adjusted to execute one instruction per clock.
- This would however make it impossible to use the pseudo-random generator sub-routine as it would take too long, therefore an alternative has to be found

## Required hardware changes

### User input

- Expose `x31` register to the top level file to be used as input for the trigger of the program, and possibly other flags

### New instructions

- **`slli`**

  Logical shift left by immediate:

  ```asm
  slli rd, rs1, imm12

  rd <- rs1 << imm12
  ```

- **`jal`**

  Jump and link:

  ```
  jal rd, imm20

  rd <- pc + 4
  pc <- pc + imm20
  ```

- **`jalr`** 
  Jump and link register:

  ```
  jal rd, rs1, imm12

  rd <- pc + 4
  pc <- rs1 + imm20
  ```

  Used to return from subroutine, `rd` can be set to `x0` when not interested in pc
