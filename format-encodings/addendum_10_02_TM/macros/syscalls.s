# File: syscalls.s
#
#
# Description: MARS and SPIM, two assemblers for the MIPS ISA, 
#   provides a set of system calls.  To perform a system call,
#   the programmer must perform the following steps:
#     1. Marshal the input arguments into the "a" registers
#     1. Load the service number into register $v0
#     1. Invoke the syscall command
#     1. Reposition the return value
#   Note that all other registers are not affected by a system call
#
#   ASIDE: Many of the defined system calls should be transformed into
#     subroutines that make appropriate system calls.
#     E.g., print_x, should be transformed into the following
#          - snprintf(buffer, size, "%x", $a0)
#          - write(1, buffer, size)
#     In short, stdout and stdin should not be treated differently
#
#   This file contains a set of useful macros to invoke these system calls.
#   Each of these macros:
#     1. Marshals the operands into the "a" registers
#     1. Loads the $v0 register with the associated service number
#     1. Invokes the syscall command
#     1. Leaves the return value in the $v0 register
#
#   The naming of macros follows the MIPS mnemonic naming convention, i.e., 
#     - a name append with an "i" indicates that the last argument is an immediate value
#   The naming of I/O routines follow the printf convention to specify the output format
#
#   Macro Example:
#     - print_di 0x00ff == print("%d", 0x00ff)
#        - accepts an immediate value as its last argument
#        - formats that value into a decimal (base 10 number)
#        - prints the result string to stdout
#
#   The following table provides the list of available macros.
#       The table uses the following data types:
#         void: no value is provided
#         imm:  an immediate value
#         int:  a register holding an 2's complement number
#         byte: a register in which only the least significant byte is of interest
#         fd:   an integer value assigned to keep track of a specific file
#         &string: an address of a buffer contain ASCII characters, terminated by the '\0' character
#         &buffer: a memory address corresponding to the starting point of a buffer
#
# | Macro Name       | Code | Prototype             |
# |------------------|------|-----------------------|
# | print_d          |  1   | void ƛ(int);          |
# | print_di         |  1   | void ƛ(imm);          |
# | print_s          |  4   | void ƛ(&str);         |
# | print_si         |  4   | void ƛ(&str);         |
# | read_d           |  5   | int  ƛ(void);         |
# | read_s           |  8   | int  ƛ(&str, int);    |
# | read_si          |  8   | int  ƛ(&str, imm);    |
# | sbrk (allocate)  |  9   | &buffer ƛ(int);       |
# | sbrki (allocate) |  9   | &buffer ƛ(imm);       |
# | exit (w/o value) | 10   | void exit(void);      |
# | print_c          | 11   | void ƛ(byte);         |
# | print_ci         | 11   | void ƛ(byte);         |
# | read_c           | 12   | byte ƛ(void);         |
# | open (fd)        | 13   | fd ƛ(&str, int, int); |
# | read (from fd)   | 14   | int ƛ(fd, &buf, int); |
# | write (to fd)    | 15   | int ƛ(fd, &buf, int); |
# | close (fd)       | 16   | void ƛ(fd);           |
# | exit (w value)   | 17   | void ƛ(int);          | 
# | exiti (w value)  | 17   | void ƛ(imm);          |
# | print_x          | 34   | void ƛ(int);          |
# | print_xi         | 34   | void ƛ(imm);          |
# | print_t          | 35   | void ƛ(imm);          |
# | print_ti         | 35   | void ƛ(int);          |
# | print_u          | 36   | void ƛ(int);          |
# | print_ui         | 36   | void ƛ(imm);          |
#
# Refer to the definition of specific macros for additional information



######################################################
# Macros that perform input from stdin
# | read_d           |  5   | int  ƛ(void);         |
# | read_c           | 12   | byte ƛ(void);         |
# | read_s           |  8   | int  ƛ(&str, int);    |
# | read_si          |  8   | int  ƛ(&str, int);    |


.macro read_d()
        nop                     # Reads from stdin, a decimal (%d) number
        li $v0, 5
        syscall                 
        nop                     # The value is now in $v0
.end_macro

.macro read_c()
        nop                     # Reads from stdin, a character (%c)
        li $v0, 12
        syscall 
        nop                     # The character is now in $v0
.end_macro

.macro read_s(%reg1, %reg2)
        # Follows semantics of UNIX 'fgets'.  
        #   Reads at most n-1 characters. A newline ('\n') is placed in the last
        #   character read, and then string is then padded with a null character ('\0').
        #   If n = 1, input is ignored, and a null byte written to the buffer.
        #   If n <=1, input is ignored, and nothing is written to the buffer.
        # $v0 defines the actual number of bytes read

        nop                     # Reads from stdin a string (%s)
        move $a0, %reg1         #   &buffer : the address of the buffer
        move $a1, %reg2         #   num     : the number of bytes to read
        li $v0, 8
        syscall
        nop                     # The MEM[%reg1] has been updated                    

.end_macro
.macro read_si(%reg1, %imm)
        # Follows semantics of UNIX 'fgets'.  
        #   Reads at most n-1 characters. A newline ('\n') is placed in the last
        #   character read, and then string is then padded with a null character ('\0').
        #   If n = 1, input is ignored, and a null byte written to the buffer.
        #   If n <=1, input is ignored, and nothing is written to the buffer.
        # $v0 defines the actual number of bytes read

        nop                     # Reads from stdin, a string (%s)
        move $a0, %reg1         #   &buffer:   the address of the input buffer
        li $a1, %imm            #   num:       the number of bytes to read
        li $v0, 8
        syscall
        nop                     # The MEM[%reg1] has been updated                    
.end_macro

#   read_s 8:  Follows semantics of UNIX 'fgets'.  
#     Reads at most n-1 characters. A newline ('\n') is placed in the last
#     character read, and then string is then padded with a null character ('\0').
#     If n = 1, input is ignored, and a null byte written to the buffer.
#     If n <=1, input is ignored, and nothing is written to the buffer.
#  
#  

######################################################
# Macros that perform output to stdout
#
# | print_d          |  1   | void ƛ(int);          |
# | print_di         |  1   | void ƛ(int);          |
# | print_s          |  4   | void ƛ(&str);         |
# | print_si         |  4   | void ƛ(&str);         |
# | print_c          | 11   | void ƛ(byte);         |
# | print_ci         | 11   | void ƛ(byte);         |
# | print_x          | 34   | void ƛ(int);          |
# | print_xi         | 34   | void ƛ(int);          |
# | print_t          | 35   | void ƛ(int);          | 
# | print_ti         | 35   | void ƛ(int);          | 
# | print_u          | 36   | void ƛ(int);          | 
# | print_ui         | 36   | void ƛ(int);          | 

.macro print_d(%reg)
        nop                     # Prints to stdout, a value as a decimal (%d) number
        move $a0, %reg          # The value is in the register
        li $v0, 1
        syscall
        nop                     # The value has been printed to stdout
.end_macro
.macro print_di(%imm)
        nop                     # Prints to stdout, a value as a decimal (%d) number
        li $a0, %imm            # The value is an immediate value
        li $v0, 1
        syscall
        nop                     # The value has been printed to stdout
.end_macro

.macro print_s(%reg)
        nop                     # Prints to stdout, a string (%s)
        move $a0, %reg          # The address of the string 
        li $v0, 4
        syscall
        nop                     # The value has been printed to stdout
.end_macro
.macro print_si(%label)
        nop                     # Prints to stdout, a string (%s)
        la $a0, %label          # The label of the string
        li $v0, 4
        syscall
        nop                     # The value has been printed to stdout
.end_macro

.macro print_c(%reg)
        nop                     # Prints to stdout, a character (%c)
        move $a0, %reg          # The character is the lsb in the register
        li $v0, 11              #   note only the least-significant byte is used 
        syscall
        nop                     # The value has been printed to stdout
.end_macro
.macro print_ci(%imm)
        nop                     # Prints to stdout, a character (%c)
        li $a0, %imm            # The character is an immediate value
        li $v0, 11              #   note only the least-significant byte is used
        syscall
        nop                     # The value has been printed to stdout
.end_macro

.macro print_x(%reg)
        nop                     # Prints to stdout, a value as a hexadecimal (%x) number
        move $a0, %reg          # The value is in the register
        li $v0, 34          
        syscall
        nop                     # The value has been printed to stdout

.end_macro
.macro print_xi(%imm)
        nop                     # Prints to stdout, a value as a hexadecimal (%x) number
        li $a0, %imm            # The value is an immediate value
        li $v0, 34
        syscall 
        nop                     # The value has been printed to stdout
.end_macro

.macro print_t(%reg)
    # Print a hexadecimal value whose value is in a register
    # -- 32 binary digits, left-padding with zeros
        nop                     # Prints to stdout, a value as a binary string
        move $a0, %reg          # The value is in the register
        li $v0, 35              
        syscall
        nop                     # The value has been printed to stdout
.end_macro
.macro print_ti(%imm)
        # Print a binary value from an immediate value
        # -- 32 binary digits, left-padding with zeros
        nop                     # Prints to stdout, a value as a binary string
        move $a0, %imm          # The value is an immediate value
        li $v0, 35
        syscall
        nop                     # The value has been printed to stdout
.end_macro

.macro print_u(%reg)
        nop                     # Prints to stdout, an unsigned decimal value
        move $a0, %reg          # The value is in the register
        li $v0, 36
        syscall
        nop                     # The value has been printed to stdout

.end_macro
.macro print_ui(%imm)
        nop                     # Prints to stdout, an unsigned decimal value
        move $a0, %imm          # The value is an immediate value
        li $v0, 36
        syscall
        nop                     # The value has been printed to stdout
.end_macro


######################################################
# Macros that perform I/O on files
# | open (fd)         | 13   | fd ƛ(&str, int, int); | filename, flags, mode
# | read (from fd)    | 14   | int ƛ(fd, &buf, int); | bytes read |
# | write (to fd)     | 15   | int ƛ(fd, &buf, int); | bytes read |
# | close (fd)        | 16   | void ƛ(fd);           |

.macro open(%reg0, %reg1, %reg2)
        nop                     # Opens a file 
        move $a0, %reg0         #   &filename: the address of the filename
        move $a1, %reg1         #   flags:     readonly (0) writeonly(1), append(9)
        move $a2, $reg2         #   mode:      ignored
        li $v0, 13
        syscall 
        nop                     # $v0 contains the "fd" (file descriptor) of the file
.end_macro

.macro read
        nop                     # Reads from "fd", placing the contents into buffer
        move $a0, %reg0         #   fd:        the file descriptor of the file
        move $a1, %reg1         #   &buffer:   the address of the buffer
        move $a2, $reg2         #   num:       the number of bytes to read
        li $v0, 14
        syscall            
        nop                     # $v0 contains that number of bytes read
.end_macro

.macro write
        nop                     # Writes to "fd", the contents of the buffer
        move $a0, %reg0         #   fd:        the file descriptor of the file
        move $a1, %reg1         #   &buffer:   the address of the buffer
        move $a2, $reg2         #   num:       the number of bytes to read
        li $v0, 15
        syscall
        nop                     # $v0 contains that number of bytes written
.end_macro

.macro close
        nop                     # Closes a file
        move $a0, %reg0         #   fd:        the file descriptor of the file
        li $v0, 16
        syscall
.end_macro


#   Service 13: MARS implements three flag values: 
#     0: read-only, 
#     1: write-only with create
#     9: write-only with create and append.  
#     It ignores mode.  
#     The returned file descriptor will be negative if the operation failed. 
#  

######################################################
# Macros that perform other system related activities

# | sbrk (allocate)   |  9   | &buffer ƛ(int);       |
# | sbrki (allocate)  |  9   | &buffer ƛ(imm);       |
# | exit              | 10   | void ƛ(void);         |
# | exit              | 17   | void ƛ(int);          |
# | exiti             | 17   | void ƛ(imm);          |

.macro sbrk(%reg)
        nop                     # Allocates a block of memory
        move $a0, %reg          #   num:       the number of bytes to read
        li $v0, 9
        syscall
        nop                     # $v0 contains the address of the block 
.end_macro
.macro allocate(%reg)
        sbrk %reg
.end_macro

.macro sbrki(%imm)
        nop                     # Allocates a block of memory given an immediate value
        li $a0, %imm            #   num:       the number of bytes to read
        li $v0, 9
        syscall
        nop                     # $v0 contains the address of the block 

.end_macro
.macro allocatei(%imm)
        sbrki %imm
.end_macro

.macro exit()
        nop                     # Halts program without a return value
        li $v0, 10              
        syscall                 # Violates best practice
.end_macro

.macro exit(%reg)
        nop                     # Halt program with register holding exit code
        move $a0, %reg
        li $v0, 17
        syscall
.end_macro


.macro exiti(%imm)
        nop                     # Halt program with immediate exit code
        li $a0, %imm
        li $v0, 17
        syscall
.end_macro







