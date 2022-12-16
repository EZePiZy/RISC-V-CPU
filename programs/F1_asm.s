
# Pipeline F1 program
start:
    addi a1, zero, 8
    addi a0, zero, 0
countdown:
    slli a3, a3, 1
    nop
    nop
    addi a3, a3, 1 
    addi a1, a1, -1
    nop
    addi a0, a3, 0
    bne a1, zero, countdown
    nop 
    nop 
    addi a2, a2, 74
    jal sp, delay 
    nop
    nop
    addi a3, zero, 0 
    jal sp, start
    nop
    nop
delay:
    addi t0, t0, 10
    nop
    nop
loop:                   # Loops 10 times
    addi t0, t0, -1
    nop
    bne t0, zero, loop
    nop
    nop
    jalr zero, sp, 0    # return
    nop
    nop