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