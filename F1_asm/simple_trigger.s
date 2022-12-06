# Simplest F1 program with trigger input
#
# Trigger is set by bit 0 of register x31 (t6)

trig_loop:              # loop while trigger is not 1
  addi t0, t6, -1     # check if its zero
  bne t6, 1, trig_loop
start:
  addi t0, zero, 8
  addi a0, zero, 0
countdown:
  slli a0, a0, 1
  addi a0, a0, 1 
  addi t0, t0, -1
  bne t0, zero, countdown 
  jal sp, delay 
  addi a0, zero, 0    # finished the F1 light sequence
  addi t6, zero, 0    # reset trigger reg to 0
  jal zero, trig_loop # go back to wait for new trigger
delay:
  addi t0, zero, 10
loop:                 # Loops 10 times
  addi t0, t0, -1
  addi zero, zero, 0  # NOP
  bne t0, zero, loop
  jalr zero, sp, 0    # return