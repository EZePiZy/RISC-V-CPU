# lui a0, 0xFFFFF # store 20 bits of 1
addi a0, zero, 0
addi a0, a0, -1 # same as loading 0xFFFF FFFF into a0

sw a0, 5(zero)
lw t0, 5(zero)
addi a0, zero, 42
addi a0, t0, 0
andi a0, t0, 0x0F

sb a0, 4(zero)
lw a0, 5(zero)
addi a0, zero, -1
# sw a0, 4(zero)
addi t0, zero, 0x01
sb t0, 7(zero)
lw a0, 4(zero)

lbu a0, 5(zero)
lb a0, 5(zero)