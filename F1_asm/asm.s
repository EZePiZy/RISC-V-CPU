.global _boot
.text

_boot:                    /* x0  = 0    0x000 */
    /* initialize vars */
    addi a1, zero, 8
    addi a0, zero, 0
countdown:
    slli a0, a0, 1 /* shift left by 1*/
    addi a0, a0, 1 /* add 1 */
    addi a1, a1, -1 /* subtract 1 to loop */
    bne a1, zero, countdown /* jump while not zero */
    /* jump to pseudo random delay subroutine*/
    jal sp, random_delay /* assembler figures out the details */
    addi a0, zero, 0 /* set output to zero*/ 
/* subroutine */
random_delay:
	addi a2, a2, 74 /* seed */
    addi t3, t3, 10 /* counter */
rnd_loop:    
    /* 8-bit random generator */
    /* x = {x[1:7], x[3] xor x[7]}*/
    andi t0, a2, 0b1000 /* extract bit 3 */
    srli t0, t0, 3
    andi t1, a2, 0b1000000 /* extract bit 7 */
    srli t1, t1, 7
    xor t2, t1, t0
    slli a2, a2, 1 /* shift left by 1 */
    or a2, a2, t2
    /* repeat 10 times*/
    addi t3, t3, -1
    bne t3, zero, rnd_loop
    
    /* use a2 to loop "random" number of time */
    add t0, a2, zero
nop_loop:
    addi zero, zero, 0
    addi zero, zero, 0
    addi zero, zero, 0
    addi t0, t0, -1
    bne t0, zero, nop_loop
    jalr zero, sp /* pc value is stored in zero */
    
    
    
    
