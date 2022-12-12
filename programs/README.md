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
- Loop while bit 2 of `x31` is not `1`
- Once bit 2 of `x31` becomes `1` the rest of the program is executed
- At the end of the program `x31` is reset to `0` and ready to wait for another trigger input
- `x31` register has to be exposed to the top level component in order to be accessible by testbench

#### 2. Turning led lights on one at a time

- Loop 8 times using a temporary register (`t0`) 
- Each iteration shift `a0` left by 1 and add 1
- Call the `wait_second` subroutine which as the name implies loops indefinitely while the first bit of the `t6` register is not 1. The bit is selected with an `andi` instruction.

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

- Using `<chrono>` library the amount of time elapsed is measured every cycle.
- Once 1 second is reached the LSB of the `t6` register is flipped to `1` to signal to the program that 1 second has passed
- If the 2nd bit of the `t6` register is `0` this means that it's ok to send another bit of input, at this point the `vbdFlag()` is sampled in one shot mode and the result sent to the CPU.

## Issues

### Pseudo-random number generation:
- In order to have a useful pseudo-random number generator some sort of seed is needed. 
- One way to implement this is to expose a memory address to the testbench in order to have a random seed, which can then be fed to pseudo-random routine
### 1 second delay:
- In order to achieve one second delay between each turning on the CPU clock could be adjusted to execute one instruction per clock.
- This would however make it impossible to use the pseudo-random generator sub-routine as it would take too long, therefore an alternative has to be found

### Input interference:

**Problem**

The program uses the register `x31` or `t6` to interact with the testbench and user. The first bit of the register is set to 1 every second giving the program a known pulse and allowing for it to wait until this pulse arrives, this works under the assumption that checking if this value is 1 takes less than one second which fortunately it does. 
To allow for a trigger signal from the encoder on the Vbuddy the second bit of the register is used as signal. Here a problem is encountered however, since writing for the trigger input might overwrite the pulse input.

**Solution**

The register has to be exposed as an output for the testbench to be able to write to it without overwriting other values. This way the program can reset a given input bit to 0 signaling to the testbench that it's ready to receive another input. This then allows for up to 32 boolean inputs to the register. 


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
