.text
.equ base_pdf, 0x100
.equ base_data, 0x10000
.equ max_count, 200
main:
    jal     ra, init  # jump to init, ra and save position to ra
    nop#
    nop#
    addi a0, zero, 496
    nop
    nop
    jal     ra, build
    nop#
    nop#
    addi a0, zero, 649
    nop
    nop
forever:
    jal     ra, display # fetch
    nop                 # decode
    nop                 # execute
    j       forever     
    nop#
    nop#
init:       # function to initialise PDF buffer memory 
    addi     a1, zero, 256
    nop#
    nop#
_loop1:                         # repeat
    addi    a1, a1, -1          #     decrement a1
    nop#
    nop#
    sb      zero, base_pdf(a1)  #     mem[base_pdf+a1) = 0 We are not loading what is stored anytime soon so do not need nops
    bne     a1, zero, _loop1    # until a1 = 0
    nop#
    nop#
    ret
    nop#
    nop#
build:      # function to build prob dist func (pdf)
    lui      a1, 0x10       # a1 = base address of data array # Not using a1 immediately soon, so do not need nops
    addi    a2, zero, 0           # a2 = offset into of data array 
    addi    a3, zero, 256         # a3 = base address of pdf array
    addi    a4, zero, 200       # a4 = maximum count to terminate
_loop2:                         # repeat
    add     a5, a1, a2          #     a5 = data base address + offset
    nop#
    nop#
    lbu     t0, 0(a5)           #     t0 = data value
    nop#
    nop#
    add     a6, t0, a3          #     a6 = index into pdf array#
    nop#
    nop#
    lbu     t1, 0(a6)           #     t1 = current bin count
    nop#
    nop#
    addi    t1, t1, 1           #     increment bin count
    nop#
    nop#
    sb      t1, 0(a6)           #     update bin count
    addi    a0, t1, 0 # debug purposes
    addi    a2, a2, 1           #     point to next data in array
    bne     t1, a4, _loop2      # until bin count reaches 
    nop#
    nop
    ret
    nop
    nop

display:    # function send PDF array value to a0 for display
    addi      a1, zero, 0               # a1 = offset into pdf array
    addi      a2, zero, 255             # a2 = max index of pdf array

_loop3:                         # repeat
    li      a0, -1          # signal to tb that data is being displayed 
    lbu     a0, base_pdf(a1)    #   a0 = mem[base_pdf+a1)
    nop#
    nop#
    addi    a1, a1, 1           #   incr
    nop#
    nop#
    bne     a1, a2, _loop3      # until end of pdf array
    nop#
    nop#
    nop#
    nop#
    nop#
    # li      a0, 0x6969          # signal that next data is coming
    ret
    nop#
    nop#
    nop#
    nop#
    nop#
    nop#
