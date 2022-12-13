# Simplest F1 program
start:
    addi a1, zero, 8
    addi a0, zero, a0 // NOP 
    addi a0, zero, a0 // NOP 
    addi a0, zero, a0 // NOP
    addi a0, zero, a0 // NOP 
    addi a0, zero, a0 // NOP 
    addi a0, zero, 0
countdown:
    addi a0, zero, a0 // NOP 
    addi a0, zero, a0 // NOP 
    addi a0, zero, a0 // NOP 
    addi a0, zero, a0 // NOP
    addi a0, zero, a0 // NOP 
    addi a0, zero, a0 // NOP 
    slli a0, a0, 1
    addi a0, zero, a0 // NOP 
    addi a0, zero, a0 // NOP 
    addi a0, zero, a0 // NOP
    addi a0, zero, a0 // NOP 
    addi a0, zero, a0 // NOP  
    addi a0, a0, 1 
    addi a0, zero, a0 // NOP 
    addi a0, zero, a0 // NOP 
    addi a0, zero, a0 // NOP
    addi a0, zero, a0 // NOP 
    addi a0, zero, a0 // NOP 
    addi a1, a1, -1
    addi a0, zero, a0 // NOP 
    addi a0, zero, a0 // NOP 
    addi a0, zero, a0 // NOP
    addi a0, zero, a0 // NOP 
    addi a0, zero, a0 // NOP 
    bne a1, zero, countdown 
    addi a0, zero, a0 // NOP 
    addi a0, zero, a0 // NOP 
    addi a0, zero, a0 // NOP
    addi a0, zero, a0 // NOP 
    addi a0, zero, a0 // NOP 
    addi a2, a2, 74
    addi a0, zero, a0 // NOP 
    addi a0, zero, a0 // NOP 
    addi a0, zero, a0 // NOP
    addi a0, zero, a0 // NOP 
    addi a0, zero, a0 // NOP 
    jal sp, delay 
    addi a0, zero, a0 // NOP 
    addi a0, zero, a0 // NOP 
    addi a0, zero, a0 // NOP
    addi a0, zero, a0 // NOP 
    addi a0, zero, a0 // NOP 
    addi a0, zero, 0 
    addi a0, zero, a0 // NOP 
    addi a0, zero, a0 // NOP 
    addi a0, zero, a0 // NOP
    addi a0, zero, a0 // NOP 
    addi a0, zero, a0 // NOP 
    jal zero, start
    addi a0, zero, a0 // NOP 
    addi a0, zero, a0 // NOP 
    addi a0, zero, a0 // NOP
    addi a0, zero, a0 // NOP 
    addi a0, zero, a0 // NOP 
delay:
    addi t0, t0, 10
    addi a0, zero, a0 // NOP 
    addi a0, zero, a0 // NOP 
    addi a0, zero, a0 // NOP
    addi a0, zero, a0 // NOP 
    addi a0, zero, a0 // NOP 
loop:                   # Loops 10 times
    addi t0, t0, -1
    addi a0, zero, a0 // NOP 
    addi a0, zero, a0 // NOP 
    addi a0, zero, a0 // NOP
    addi a0, zero, a0 // NOP 
    addi a0, zero, a0 // NOP 
    addi zero, zero, 0  # NOP
    bne t0, zero, loop
    addi a0, zero, a0 // NOP 
    addi a0, zero, a0 // NOP 
    addi a0, zero, a0 // NOP
    addi a0, zero, a0 // NOP 
    addi a0, zero, a0 // NOP 
    jalr zero, sp, 0    # return 
    addi a0, zero, a0 // NOP 
    addi a0, zero, a0 // NOP 
    addi a0, zero, a0 // NOP
    addi a0, zero, a0 // NOP 
    addi a0, zero, a0 // NOP 