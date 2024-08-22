# Filename: stack.s
#
# Description: 
#    This file contains a set macros to provide the perform the basic operation 
#    to push and pop items from the stack.
#
#    Note that Macros are not part of the ISA, but are provided by the assembler
#    Here we presume either the MARS or SPIM assembler is used.
#
#    The general usage is as follows:
#    
#      - push $reg1 [, $reg2, ... $reg10 ]
#      - pop  $reg1 [, $reg2, ... $reg10 ]
#
#      - push_t_registers
#      - pop_t_registers
#
#      - push_s_registers
#      - pop_s_registers
#
# Note on the ARM ISA
#    The ARM ISA provides a native push and pop instruction of the following form:
#      - push { $r1, $r2, $r3 }
#    The macros define here mimic this operation
#
# Operational Description.
#    On the MIPS ISA, 
#      - the $sp register holds the address of stored element on top of the stack
#      - the stack grows downwards in memory
#      - Push:
#          1. move the top of the stack up by decrementing $sp by 4 bytes
#          1. store the register into the top position of the stack
#      - Pop:
#          1. load the register from the top position of the stack
#          1. move the top of the stack down by incrementing $sp by 4 bytes
#  
#      - Multiple Push/Pop:
#          1. for a push, the $sp is adjusted by the required space
#          1. relative address is used to store/load registers to/from the stack
#          1. for a pop, the $sp is adjusted by the required space
#

######################
# Push Macros

.macro push(%r0)
        nop                     # Pushing one register
        addiu $sp, $sp, -4      # 1 * 4 bytes = 4
        sw %r0, 0($sp)
.end_macro

.macro push(%r0, %r1)
        nop                     # Pushing two registers
        addiu $sp, $sp, -8      # 2 * 4 bytes = 8
        sw %r1, 4($sp)
        sw %r0, 0($sp)
.end_macro

.macro push(%r0, %r1, %r2)
        nop                     # Pushing three registers
        addiu $sp, $sp, -12     # 3 * 4 bytes = 12
        sw %r2, 8($sp)
        sw %r1, 4($sp)
        sw %r0, 0($sp)
.end_macro

.macro push(%r0, %r1, %r2, %r3)
        nop                     # Pushing four registers
        addiu $sp, $sp, -16     # 4 * 4 bytes = 16
        sw %r3, 12($sp)
        sw %r2, 8($sp)
        sw %r1, 4($sp)
        sw %r0, 0($sp)
.end_macro

.macro push(%r0, %r1, %r2, %r3, %r4)
        nop                     # Pushing five registers
        addiu $sp, $sp, -20     # 5 * 4 bytes = 20
        sw %r4, 16($sp)
        sw %r3, 12($sp)
        sw %r2, 8($sp)
        sw %r1, 4($sp)
        sw %r0, 0($sp)
.end_macro

.macro push(%r0, %r1, %r2, %r3, %r4, %r5)
        nop                     # Pushing 6 registers
        addiu $sp, $sp, -24     # 6 * 4 bytes = 24
        sw %r5, 20($sp)
        sw %r4, 16($sp)
        sw %r3, 12($sp)
        sw %r2, 8($sp)
        sw %r1, 4($sp)
        sw %r0, 0($sp)
.end_macro

.macro push(%r0, %r1, %r2, %r3, %r4, %r5, %r6)
        nop                     # Pushing 7 registers
        addiu $sp, $sp, -28     # 7 * 4 bytes = 28
        sw %r6, 24($sp)              
        sw %r5, 20($sp)
        sw %r4, 16($sp)
        sw %r3, 12($sp)
        sw %r2, 8($sp)
        sw %r1, 4($sp)
        sw %r0, 0($sp)
.end_macro

.macro push(%r0, %r1, %r2, %r3, %r4, %r5, %r6, %r7)
        nop                     # Pushing 8 registers
        addiu $sp, $sp, -32     # 8 * 4 bytes = 32
        sw %r7, 28($sp)
        sw %r6, 24($sp)
        sw %r5, 20($sp)
        sw %r4, 16($sp)
        sw %r3, 12($sp)
        sw %r2, 8($sp)
        sw %r1, 4($sp)
        sw %r0, 0($sp)
.end_macro

.macro push(%r0, %r1, %r2, %r3, %r4, %r5, %r6, %r7, %r8)
        nop                     # Pushing 9 registers
        addiu $sp, $sp, -36     # 9 * 4 bytes = 36
        sw %r8, 32($sp)
        sw %r7, 28($sp)
        sw %r6, 24($sp)
        sw %r5, 20($sp)
        sw %r4, 16($sp)
        sw %r3, 12($sp)
        sw %r2, 8($sp)
        sw %r1, 4($sp)
        sw %r0, 0($sp)
.end_macro

.macro push(%r0, %r1, %r2, %r3, %r4, %r5, %r6, %r7, %r8, %r9)
        nop                     # Pushing 10 registers
        addiu $sp, $sp, -40     # 10 * 4 bytes = 40
        sw %r9, 36($sp)
        sw %r8, 32($sp)
        sw %r7, 28($sp)
        sw %r6, 24($sp)
        sw %r5, 20($sp)
        sw %r4, 16($sp)
        sw %r3, 12($sp)
        sw %r2, 8($sp)
        sw %r1, 4($sp)
        sw %r0, 0($sp)
.end_macro


######################
# Pop Macros

.macro pop(%r0)
        nop                     # Popping 1 register
        lw %r0, 0($sp)
        addiu $sp, $sp, 4       # 1 * 4 bytes = 4
.end_macro

.macro pop(%r0, %r1)
        nop                     # Popping 2 registers
        lw %r1, 4($sp)
        lw %r0, 0($sp)
        addiu $sp, $sp, 8       # 2 * 4 bytes = 8
.end_macro

.macro pop(%r0, %r1, %r2)
        nop                     # Popping 3 registers
        lw %r2, 8($sp)
        lw %r1, 4($sp)
        lw %r0, 0($sp)
        addiu $sp, $sp, 12      # 3 * 4 bytes = 12
.end_macro

.macro pop(%r0, %r1, %r2, %r3)
        nop                     # Popping 4 registers
        lw %r3, 12($sp)
        lw %r2, 8($sp)
        lw %r1, 4($sp)
        lw %r0, 0($sp)
        addiu $sp, $sp, 16      # 4 * 4 bytes = 16
.end_macro

.macro pop(%r0, %r1, %r2, %r3, %r4)
        nop                     # Popping 5 registers
        lw %r4, 16($sp)
        lw %r3, 12($sp)
        lw %r2, 8($sp)
        lw %r1, 4($sp)
        lw %r0, 0($sp)
        addiu $sp, $sp, 20      # 5 * 4 bytes = 20
.end_macro

.macro pop(%r0, %r1, %r2, %r3, %r4, %r5)
        nop                     # Popping 6 registers
        lw %r5, 20($sp)
        lw %r4, 16($sp)
        lw %r3, 12($sp)
        lw %r2, 8($sp)
        lw %r1, 4($sp)
        lw %r0, 0($sp)
        addiu $sp, $sp, 24      # 6 * 4 bytes = 24
.end_macro

.macro pop(%r0, %r1, %r2, %r3, %r4, %r5, %r6)
        nop                     # Popping 7 registers
        lw %r6, 24($sp)
        lw %r5, 20($sp)
        lw %r4, 16($sp)
        lw %r3, 12($sp)
        lw %r2, 8($sp)
        lw %r1, 4($sp)
        lw %r0, 0($sp)
        addiu $sp, $sp, 28      # 7 * 4 bytes = 28
.end_macro

.macro pop(%r0, %r1, %r2, %r3, %r4, %r5, %r6, %r7)
        nop                     # Popping 8 registers
        lw %r7, 28($sp)
        lw %r6, 24($sp)
        lw %r5, 20($sp)
        lw %r4, 16($sp)
        lw %r3, 12($sp)
        lw %r2, 8($sp)
        lw %r1, 4($sp)
        lw %r0, 0($sp)
        addiu $sp, $sp, 32      # 8 * 4 bytes = 32
.end_macro

.macro pop(%r0, %r1, %r2, %r3, %r4, %r5, %r6, %r7, %r8)
        nop                     # Popping 9 registers
        lw %r8, 32($sp)
        lw %r7, 28($sp)
        lw %r6, 24($sp)
        lw %r5, 20($sp)
        lw %r4, 16($sp)
        lw %r3, 12($sp)
        lw %r2, 8($sp)
        lw %r1, 4($sp)
        lw %r0, 0($sp)
        addiu $sp, $sp, 36      # 9 * 4 bytes = 36
.end_macro

.macro pop(%r0, %r1, %r2, %r3, %r4, %r5, %r6, %r7, %r8, %r9)
        nop                     # Popping 10 registers
        lw %r9, 36($sp)
        lw %r8, 32($sp)
        lw %r7, 28($sp)
        lw %r6, 24($sp)
        lw %r5, 20($sp)
        lw %r4, 16($sp)
        lw %r3, 12($sp)
        lw %r2, 8($sp)
        lw %r1, 4($sp)
        lw %r0, 0($sp)
        addiu $sp, $sp, 40      # 10 * 4 bytes = 40
.end_macro


######################
# Aggregate Macros

.macro push_t_registers()
        nop                     # Push all of the T registers
        push $t0, $t1, $t2, $t3, $t4, $t5, $t6, $t7, $t8, $t9
.end_macro

.macro pop_t_registers()
        nop                     # Pop all of the T registers
        pop $t0, $t1, $t2, $t3, $t4, $t5, $t6, $t7, $t8, $t9
.end_macro

.macro push_s_registers()
        nop                     # Push all of the S registers
        push $s0, $s1, $s2, $s3, $s4, $s5, $s6, $s7
.end_macro

.macro pop_s_registers()
        nop                     # Pop all of the S registers
        pop $s0, $s1, $s2, $s3, $s4, $s5, $s6, $s7
.end_macro
