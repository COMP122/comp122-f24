# Demonstration MIPS code for the Java subroutine:
#
# public static int add4(int a0, int a1, int a2, int a3) {
#
#  return a0 + a1 + a2 + a3;
#
# }

        .text
        .globl add4
        

add4_test:			# private static void add4_test ()
	# A hard code subroutine to test "add4

        # Marshal the input arguments into the correct registers
        li $a0, 1
        li $a1, 2
        li $a2, 3
        li $a3, 4

        # call the subroutine  # add4(int a0, int a1, int a2, int a3)
        jal add4

        # Demarshal the return value
        move $v0, $v0

        move $a0, $v0		# Print decimal value, which should be 10 (1+2+3+4)
        li $v0, 1
        syscall			

        li $v0, 10		# Exit the program
        syscall 



add4: 	nop			# public static int add4(int a0, int a1, int a2, int a3)
	
	# Add the four arguments
	# Return the final value
	
	move $t0, $zero		# t0 = 0
	add $t0, $t0, $a0	# t0 = t0 + a0
	add $t0, $t0, $a1	# t0 = t0 + a1
	add $t0, $t0, $a2	# t0 = t0 + a2
	add $t0, $t0, $a3	# t0 = t0 + a3
	
	move $v0, $t0
	jr $ra



