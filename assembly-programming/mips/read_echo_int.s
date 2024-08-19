# This example MIPS program reads an integer from standard input, and 
# then echos the value onto standard output.
# 
# 
#   1. the variable num is allocated 4 bytes within the .data segment
#   1. the subroutine "main" is placed into the .text segment
#   1. the subroutine "main" performs the following major steps
#      - Trap to the kernel to read a decimal integer
#      - Obtain the lval (i.e., the address) of num
#      - Store the value to memory at location "num"
#      - Load the value from memory location "num"
#      - Trap to the kernel to write an integer
#      - Trap to the system to exit the program
#
# You can test the hello_world subroutine via the mips_subroutine facility 
#
# $ mips_subroutine read_echo_int <<< 5
#
 

                .data
                .align 2        # Set alignment to be on a word boundary
num:            .space 4        # Space for an integer
        
                .text
                .globl read_echo_int

test:           # A hard code subroutine to test "echo_int"
                jal read_echo_int

                li $v0, 10      # Service #10: terminate the program
                syscall      

read_echo_int:  nop             
                li $v0, 5       # Service #5: read decimal
                syscall         
                nop             # The register v0 holds the value just read
 

                la $t0, num     # Obtain the lval (address) of num
                sw $v0, 0($t0)  # Store the value in v0 to memory at the address t0

                lw $a0, 0($t0)  # Load the value in main memory at t0 into a0, the value to be printed
                li $v0, 1       # Service #1:  print decimal integer
                syscall   

                li $a0, '\n'    # Load the '\n' character
                li $v0, 11      # Printout the character
                syscall 

                move $v0, $zero   # Make the value printed the return value of the subroutine
                jr $ra
