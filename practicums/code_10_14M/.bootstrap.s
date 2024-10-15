                .data
  
subroutine:     .asciiz "pos_msb"
                # pos_msb(22)"
  
 
# Layout the command line arguments 
                .align 2
argc:           .word  1
argv:           .word arg_0 

                .align 2
arg_0:          .word 22 # 22


# Create space for register saving
                .align 2
exit_status:    .word 0

                .align 2
saved_sp:       .word 0
saved_fp:       .word 0

                .align 2
saved_v0:       .word 0   # space for v0 and v1
saved_v1:       .word 0 
                .align 3
saved_double:   .double 1.0
                .double 1.0

# Create all the output strings
sp_warning:     .asciiz "Warning: $sp was not restored.\n"
fp_warning:     .asciiz "Warning: $fp was not restored.\n"
s0_error:       .asciiz "Error:   $s0 was not restored.\n"
s1_error:       .asciiz "Error:   $s1 was not restored.\n"
s2_error:       .asciiz "Error:   $s2 was not restored.\n"
s3_error:       .asciiz "Error:   $s3 was not restored.\n"
s4_error:       .asciiz "Error:   $s4 was not restored.\n"
s5_error:       .asciiz "Error:   $s5 was not restored.\n"
s6_error:       .asciiz "Error:   $s6 was not restored.\n"
s7_error:       .asciiz "Error:   $s7 was not restored.\n"
  

                .text
                .globl main
                .include "/Users/steve/classes/comp122/include/syscalls.s"
                .include "/Users/steve/classes/comp122/include/stack.s"
                .include "/Users/steve/classes/comp122/include/ad-hoc_frames.s"
                .include "/Users/steve/classes/comp122/include/io.s"

                .macro print_error(%label)
                    # Update this macro to print to stderr
                    print_si(%label)
                    li $gp, 255
                    sw $at, exit_status
                .end_macro

                .macro save_exit_status()
                    sw $v0, exit_status
                .end_macro

                .macro restore_exit_status()
                    lw $v0, exit_status
                .end_macro

                .macro save_return_values()
                    # Save the possible return values: v0, v1, f0, f2
                    sw $v0, saved_v0
                    sw $v1, saved_v1
                
                    la $gp, saved_double
                    sdc1 $f0, 0($gp)
                    sdc1 $f2, 8($gp)
                .end_macro  

                .macro restore_return_values()
                    lw $v0, saved_v0
                    lw $v1, saved_v1

                    la $gp, saved_double
                    ldc1 $f0, 0($gp)
                    ldc1 $f2, 8($gp)
                .end_macro    


                .macro validate()
                   jal validate_sub
                   bne $v0, $zero, skip
                     # No Error
                     restore_exit_status()
                   b done
            skip:    restore_exit_status()
                     li $v0, 255
                     save_exit_status() 
            done:  nop
                .end_macro


validate_sub:   nop     # This is the routine to test the return of subroutine

                li $v0, 0      
                # Validate that each S registers was restored correctly
                li $gp, 0xDead
                beq $gp, $s0, tst_s1
                  print_error(s0_error)
tst_s1:         beq $gp, $s1, tst_s2
                  print_error(s1_error)
tst_s2:         beq $gp, $s2, tst_s3
                  print_error(s2_error)
tst_s3:         beq $gp, $s3, tst_s4
                  print_error(s3_error)
tst_s4:         beq $gp, $s4, tst_s5
                  print_error(s4_error)
tst_s5:         beq $gp, $s5, tst_s6
                  print_error(s5_error)
tst_s6:         beq $gp, $s6, tst_s7
                  print_error(s6_error)
tst_s7:         beq $gp, $s7, tst_d
                  print_error(s6_error)
tst_d:          nop

                # Validate usage: of $sp and $fp  

                lw $gp, saved_fp
                beq $gp, $fp, skip1
                  print_error(fp_warning)
skip1:          lw $gp,  saved_sp
                beq $gp, $sp, skip2
                  print_error(sp_warning)
skip2:          nop

                jr $ra      

  main:         nop      
                nop # "pos_msb" must to restore stack to here
                sw $sp, saved_sp

                nop # Marshal the input arguments into the registers
                lw $a0, arg_0                # 22

                nop # Stage the remaining input arguments onto the stack
                alloc_return
                set_frame

                nop        # Set the T registers to be random values
                li $t0, 1278
                li $t1, 21964
                li $t2, 15638
                li $t3, 3775
                li $t4, 26999
                li $t5, 26563
                li $t6, 16516
                li $t7, 1898
                li $t8, 30674
                li $t9, 2860

                nop        # Set the S registers to 0xDead
                li $s0, 0xDead
                li $s1, 0xDead
                li $s2, 0xDead
                li $s3, 0xDead
                li $s4, 0xDead
                li $s5, 0xDead
                li $s6, 0xDead
                li $s7, 0xDead

                # Save the SP and FP registers, as appropriate
                sw $fp, saved_fp

                # List of BEFORE actions


                jal pos_msb
                unstage_return $v0
                save_return_values()
                save_exit_status()

                validate()

                # List of AFTER actions

                # Print the return value from the subroutine
                println_d($v0)
                restore_exit_status()
                exit($v0)
