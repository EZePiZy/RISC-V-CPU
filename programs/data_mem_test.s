
lui t0, 0x10
nop
nop
addi a1, zero, 69
lui a2, 6969
jal ra, test
nop
nop
sb a1, 0(t0) 
lbu a0, 0(t0)
lbu a0, 1(t0)
lbu a0, 2(t0)
lbu a0, 3(t0)
lbu a0, 4(t0)
lbu a0, 5(t0)
sw a2, 6(t0)
nop
nop
lw a0, 6(t0)
j end
nop
nop

test:
  addi a0, zero, 342
  nop
  nop
  addi a0, zero, 5
  nop
  nop
loop:
  addi a0, a0, -1
  nop
  nop
  bne a0, zero, loop
  nop
  nop
  jalr zero, ra, 0
  nop
  nop
  
end:
  addi a0, zero, 420 
  j end
  nop
  nop