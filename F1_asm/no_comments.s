    addi a1, zero, 8
    addi a0, zero, 0
countdown:
    slli a0, a0, 1
    addi a0, a0, 1 
    addi a1, a1, -1
    bne a1, zero, countdown 
	addi a2, a2, 74
    jal sp, random_delay 
    addi a0, zero, 0 


random_delay:
    addi t3, t3, 10 
rnd_loop:    
    andi t0, a2, 8
    srli t0, t0, 3
    andi t1, a2, 128
    srli t1, t1, 7
    xor t2, t1, t0
    slli a2, a2, 1 
    andi a2, a2, 255
    or a2, a2, t2
    addi t3, t3, -1
    bne t3, zero, rnd_loop
    add t0, a2, zero
	jalr zero, sp, 0