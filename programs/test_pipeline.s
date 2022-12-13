# Simplest F1 program
start:
    nop
    nop
    nop
    nop
    nop
    addi a1, zero, 8
    nop
    nop
    nop
    nop
    nop
    addi a0, zero, 0
    nop
    nop
    nop
    nop
    nop
countdown:
    slli a0, a0, 1
    nop
    nop
    nop
    nop
    nop
    addi a0, a0, 1
    nop
    nop
    nop
    nop
    nop 
    addi a1, a1, -1
    nop
    nop
    nop
    nop
    nop
    bne a1, zero, countdown 
    nop
    nop
    nop
    nop
    nop
    addi a2, a2, 74
    nop
    nop
    nop
    nop
    nop
    jal sp, delay 
    nop
    nop
    nop
    nop
    nop
    addi a0, zero, 0 
    nop
    nop
    nop
    nop
    nop
    jal zero, start
    nop
    nop
    nop
    nop
    nop
delay:
    addi t0, t0, 10
    nop
    nop
    nop
    nop
    nop
loop:                   # Loops 10 times
    addi t0, t0, -1
    nop
    nop
    nop
    nop
    nop
    addi zero, zero, 0  # NOP
    nop
    nop
    nop
    nop
    nop
    bne t0, zero, loop
    nop
    nop
    nop
    nop
    nop
    jalr zero, sp, 0    # return
    nop
    nop
    nop
    nop
    nop