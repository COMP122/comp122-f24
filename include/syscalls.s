# File: syscalls.s
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
#     1. Restores the values of used registers
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
# | print.s          |  2   | void ƛ(float);        | # to match c1 instructions
# | print.d          |  3   | void ƛ(double);       | # to match c1 instructions
# | print_f          |  3   | void ƛ(double);       | # to match printf
# | print_s          |  4   | void ƛ(&str);         |
# | print_si         |  4   | void ƛ(label);        |
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
        nop                     # read_d: reads a decimal (%d) number from stdin
        li $v0, 5               #    set service number
        syscall                 #    make call to the OS
        nop                     # read_d: $v0 contains the decimal value
.end_macro

.macro read_c()
        nop                     # read_c: reads an ASCII character (%c) from stdin
        li $v0, 12              #    set service number
        syscall                 #    make call to the OS
        nop                     # read_c: $v0 contains the ASCII character
.end_macro

.macro read_s(%reg1, %reg2)
        # Follows semantics of UNIX 'fgets'.  
        #   Reads at most n-1 characters. A newline ('\n') is placed in the last
        #   character read, and then string is then padded with a null character ('\0').
        #   If n = 1, input is ignored, and a null byte written to the buffer.
        #   If n <=1, input is ignored, and nothing is written to the buffer.
        # $v0 defines the actual number of bytes read

        nop                     # read_s: reads a string (%s) from stdin
        push $a0, $a1           #    preserve registers
        nop                     #    marshal arguments
        move $a0, %reg1         #        &buffer: the address of the buffer
        move $a1, %reg2         #        num:     the number of bytes to read
        li $v0, 8               #    set service number
        syscall                 #    make call to OS
        pop $a0, $a1            #    restore registers
        nop                     # read_s: $v0 contains the size of the buffer
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


######################################################
# Macros that perform output to stdout
#
# | print_d          |  1   | void ƛ(int);          |
# | print_di         |  1   | void ƛ(int);          |
# | print.s          |  2   | void ƛ(float);        | # to match c1 instructions
# | print.d          |  3   | void ƛ(double);       | # to match c1 instructions
# | print_f          |  3   | void ƛ(double);       | # to match printf
# | print_s          |  4   | void ƛ(&str);         |
# | print_si         |  4   | void ƛ(label);        |
# | print_c          | 11   | void ƛ(byte);         |
# | print_ci         | 11   | void ƛ(byte);         |
# | print_x          | 34   | void ƛ(int);          |
# | print_xi         | 34   | void ƛ(int);          |
# | print_t          | 35   | void ƛ(int);          | 
# | print_ti         | 35   | void ƛ(int);          | 
# | print_u          | 36   | void ƛ(int);          | 
# | print_ui         | 36   | void ƛ(int);          | 

.macro print_d(%reg)
        nop                     # print_d: print a decimal (%d) to stdout
        push $v0, $a0           #     preserve registers
        move $a0, %reg          #     marshal value to print
        li $v0, 1               #     set service number
        syscall                 #     make call to the OS
        pop $v0, $a0            #     restore registers
        nop                     # print_d: done
.end_macro
.macro print_di(%imm)
        nop                     # print_di: print a literal decimal (%d) to stdout
        push $v0, $a0           #     preserve registers
        li $a0, %imm            #     marshal value to print
        li $v0, 1               #     set service number
        syscall                 #     make call to the OS
        pop $v0, $a0            #     restore registers
        nop                     # print_di: done
.end_macro

.macro print.s(%freg)
  mov.d $f12, %freg
  li $v0, 2
  syscall
  nop                          # the value has been printed to stdout
.end_macro
.macro print.d(%freg)
  mov.d $f12, %freg
  li $v0, 3
  syscall
  nop                          # the value has been printed to stdout
.end_macro
.macro print_f(%freg)
  print.d(%freg)
.end_macro

.macro print_s(%reg)
        nop                     # print_s: print a string (%s) to stdout
        push $v0, $a0           #     preserve registers
        move $a0, %reg          #     marshal the address of the string 
        li $v0, 4               #     set service number
        syscall                 #     make call to the OS
        pop $v0, $a0            #     restore registers
        nop                     # print_s: done
.end_macro
.macro print_si(%label)
        nop                     # print_s: print a named string (%s) to stdout 
        push $v0, $a0           #     preserve registers
        la $a0, %label          #     marshal the label of the string
        li $v0, 4               #     set service number
        syscall                 #     make call to the OS
        pop $v0, $a0            #     restore registers
        nop                     # print_si: done
.end_macro

.macro print_c(%reg)
        nop                     # print_c: print an ASCII character (%c) to stdout
        push $v0, $a0           #     preserve registers
        move $a0, %reg          #     marshal the value to print (only lsb is used)
        li $v0, 11              #     set service number
        syscall                 #     make call to the OS
        pop $v0, $a0            #     restore registers
        nop                     # print_c: done
.end_macro
.macro print_ci(%imm)
        nop                     # print_c: print an immediate ASCII character (%c) to stdout
        push $v0, $a0           #     preserve registers
        li $a0, %imm            #     marshal the immediate value to print (only lsb is used)
        li $v0, 11              #     set service number
        syscall                 #     make call to the OS
        pop $v0, $a0            #     restore registers
        nop                     # print_ci: done
.end_macro

.macro print_x(%reg)
        nop                     # print_x: print a value as a hexadecimal (%x) number to stdout
        push $v0, $a0           #     preserve registers
        move $a0, %reg          #     marshal the value to print
        li $v0, 34              #     set service number
        syscall                 #     make call to the OS
        pop $v0, $a0            #     restore registers
        nop                     # print_x: done
.end_macro
.macro print_xi(%imm)
        nop                     # print_xi: print a value as a hexadecimal (%x) number to stdout
        push $v0, $a0           #     preserve registers
        li $a0, %imm            #     marshal the immediate value to print
        li $v0, 34              #     set service number
        syscall                 #     make call to the OS
        pop $v0, $a0            #     restore registers
        nop                     # print_xi: done
.end_macro

.macro print_t(%reg)            # -- 32 binary digits, left-padding with zeros
        nop                     # print_t: print a value as a binary number to stdout
        push $v0, $a0           #     preserve registers
        move $a0, %reg          #     marshal the value to print
        li $v0, 35              #     set service number
        syscall                 #     make call to the OS
        pop $v0, $a0            #     restore registers
        nop                     # print_t: done
.end_macro
.macro print_ti(%imm)           # -- 32 binary digits, left-padding with zeros
        nop                     # print_ti: print a value as a binary number to stdout
        push $v0, $a0           #     preserve registers
        li $a0, %imm            #     marshal the value to print
        li $v0, 35              #     set service number
        syscall                 #     make call to the OS
        pop $v0, $a0            #     restore registers
        nop                     # print_ti: done
.end_macro

.macro print_u(%reg)
        nop                     # print_u: print a value as an unsigned (%u) value
        push $v0, $a0           #     preserve registers
        move $a0, %reg          #     marshal the value to print
        li $v0, 36              #     set service number
        syscall                 #     make call to the OS
        pop $v0, $a0            #     restore registers
        nop                     # print_u: done
.end_macro
.macro print_ui(%imm)
        nop                     # print_ui: print an immediate value an unsigned (%u) value
        push $v0, $a0           #     preserve registers
        move $a0, %imm          #     marshal the immediate value to print
        li $v0, 36              #     set service number
        syscall                 #     make call to the OS
        pop $v0, $a0            #     restore registers
        nop                     # print_ui: done
.end_macro



######################################################
# Macros that perform I/O on files
# | open (fd)         | 13   | fd ƛ(&str, int, int); | filename, flags, mode
# | read (from fd)    | 14   | int ƛ(fd, &buf, int); | bytes read |
# | write (to fd)     | 15   | int ƛ(fd, &buf, int); | bytes read |
# | close (fd)        | 16   | void ƛ(fd);           |

.macro open(%reg1, %reg2, %reg3)
        nop                     # open: opens a file 
        push $a0, $a1, $a2      #    preserve registers
        nop                     #    marshal arguements
        move $a0, %reg1         #       &filename: the address of the filename
        move $a1, %reg2         #       flags:     readonly (0) writeonly(1), append(9)
        move $a2, %reg3         #       mode:      ignored
        li $v0, 13              #    set service number
        syscall                 #    make call to OS
        pop $a0, $a1, $a2       #    restore registers
        nop                     # open: done
.end_macro

.macro read(%reg0, %reg1, %reg2)
        nop                     # read: read a file ("fd") putting values into buffer
        push $a0, $a1, $a2      #    preserve registers
        nop                     #    marshal arguments
        move $a0, %reg0         #       fd:        the file descriptor of the file
        move $a1, %reg1         #       &buffer:   the address of the buffer
        move $a2, %reg2         #       num:       the number of bytes to read
        li $v0, 14              #    set service number
        syscall                 #    make call to the OS
        pop $a0, $a1, $a2       #    restore registers
        nop                     #  read: done
.end_macro

.macro write(%reg0, %reg1, %reg2)
        nop                     # write: write the contents of the buffer to file ("fd")
        push $a0, $a1, $a2      #    preserve registers
        nop                     #    marshal arguments
        move $a0, %reg0         #       fd:        the file descriptor of the file
        move $a1, %reg1         #       &buffer:   the address of the buffer
        move $a2, %reg2         #       num:       the number of bytes to write
        li $v0, 15              #    set service number
        syscall                 #    make call to the OS
        pop $a0, $a1, $a2       #    restore registers
        nop                     # write: done
.end_macro

.macro close(%reg)
        nop                     # close: close a file
        push $a0                #    preserve registers
        move $a0, %reg          #    marshal the fd (file descriptor) of the file
        li $v0, 16              #    set service number
        syscall                 #    make call to the OS
        pop $a0                 #    restore registers
        nop                     # close:
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
        nop                     # sbrk: allocates a block of memory
        push $a0                #    preserver register
        move $a0, %reg          #    marshall the number of bytes to allocate
        li $v0, 9               #    set service number
        syscall                 #    make call to the OS
        pop $a0                 #    restore register
        nop                     # $v0 contains the address of the block 
.end_macro
.macro allocate(%reg)
        sbrk %reg
.end_macro

.macro sbrki(%imm)
        nop                     # sbrki: allocate a block of memory 
        li $a0, %imm            #    marshall the number of bytes to allocate
        li $v0, 9               #    set service number
        syscall                 #    make call to the OS
        nop                     # $v0 contains the address of the block 

.end_macro
.macro allocatei(%imm)
        sbrki %imm
.end_macro

.macro exit()
        nop                     # exit: halt a program without a value
        li $v0, 10              #    set service number
        syscall                 #    make call to the OS
        nop                     #    THIS LINE IS NEVER EXECUTED
        nop                     # exit: done
.end_macro

.macro exit(%reg)
        nop                     # exit: exit with a value
        move $a0, %reg          #    marshal value that becomes the EXIT STATUS
        li $v0, 17              #    set service number
        syscall                 #    make call to the OS
        nop                     #    THIS LINE IS NEVER EXECUTED
        nop                     # exit:
.end_macro
.macro exiti(%imm)
        nop                     # exiti: exit with an immediate value
        li $a0, %imm            #    marshal value that becomes the EXIT STATUS
        li $v0, 17              #    set service number
        syscall                 #    make call to the OS
        nop                     #    THIS LINE IS NEVER EXECUTED
        nop                     # exiti: done
.end_macro
