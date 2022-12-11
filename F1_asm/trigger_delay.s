# Trigger is set by bit 0 of register x31 (t6)
# Bit 1 of x31 is set to 1 everytime a second passes (will be able to use bit 2 once and instruction is implemented)

trig_loop:                  # loop while trigger is not 1
    addi t0, t6, -1         # check if its zero
    bne t0, zero, trig_loop
    addi t6, zero, 0        # reset t6 to 0
start:
    addi t0, zero, 8
    addi a0, zero, 0  
countdown:
    jal sp, wait_second
    slli a0, a0, 1
    addi a0, a0, 1     
    addi t0, t0, -1
    bne t0, zero, countdown 
    jal sp, delay 
    addi a0, zero, 0        # finished the F1 light sequence
    jal sp, wait_second
    addi t6, zero, 0        # reset trigger reg to 0
    jal zero, trig_loop     # go back to wait for new trigger
delay:
    addi t0, zero, 10
loop:                       # Loops 10 times
    addi t0, t0, -1
    addi zero, zero, 0      # NOP
    bne t0, zero, loop
    jalr zero, sp, 0        # return
wait_second:                # subroutine that does nothing while 1 second pulse is not high
    addi t1, t6, -1         # subtract to check if it's one
    bne t1, zero, wait_second   # jump if not equal to 1    
    addi t6, zero, 0        # once set to 1 reset back to 0
    jalr zero, sp, 0        # return from subroutine