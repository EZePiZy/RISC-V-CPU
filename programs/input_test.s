loop:
  andi t0, t6, 2
  addi t0, t0, -2
  addi a0, t0, 0
  addi a0, t6, 0
  bne t0, zero, loop
  addi a0, zero, 69
wait:
  andi t0, t6, 1
  addi t0, t0, -1
  addi a0, zero, 19
  bne t0, zero, wait
  addi a0, zero, 0xFF
  jal loop