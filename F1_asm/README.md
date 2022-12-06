# F1 Assembly program

The program is tested using [this](https://www.cs.cornell.edu/courses/cs3410/2019sp/riscv/interpreter/#) website.

## Desired Behaviour

1. Upon receving a trigger the routine is executed
2. The `a0` drives the led bar on the *VBuddy* turning on each light every second
3. Once all 8 lights are on a random amount of time elapses before they all turn off
4. The testbench uses *VBuddy* methods to measure how long it takes the user to press the button after the lights turn off

## Implementation

#### 1. Executing on trigger

*TO-DO*

#### 2. Turning led lights on one at a time

- Loop 8 times using a temporary register (`t0-7`) 
- Each loop shift `a0` left by 1 and add 1

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

