# Simplest F1 program
start:
    addi a1, zero, 8
    addi a0, zero, 0
countdown:
    slli a0, a0, 1
    addi a0, a0, 1 
    addi a1, a1, -1
    bne a1, zero, countdown 
    addi a2, a2, 74
    jal ra, delay 
    addi a0, zero, 0 
    jal ra, start
delay:
    addi t0, t0, 10
loop:                   # Loops 10 times
    addi t0, t0, -1
    addi zero, zero, 0  # NOP
    bne t0, zero, loop
    jalr zero, ra, 0    # return
