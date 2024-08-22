# This file provides a template for a MIPS subroutine that uses a simple frame
#
# Assertions:
#   1. There are at most 4 args
#   1. These arguments are staged in the $a0, $a1, $a2, $a3
#   1. There are NO local variables
#   1. The top of stack contains the frame pointer of the parent's frame
#
#   1. The stack is subsequently used
#      - store the $ra address
#      - store the S registers
#
#   1. The stack can subsequently used as an internal stack
#
#   1. As part of a call to a subroutine, the stack is subsequently used to 
#      - store the T registers
#

        .text
        .globl {name}

        # Include any supporting files, such as macros
        #.include ""

        .data
        # Insert an Static Data Declarations

        .text

{name}: nop             # {prototype}

        # Register Allocation Notes
        # a0: 
        # a1: 
        # a2: 
        # a3: 
        # v0: 
        # v1: 

        # t0:
        # t1:
        # t2:
        # t3:
        # t4:
        # t5:
        # t6:
        # t7:
        # t8:
        # t9:

        # s0:
        # s1:
        # s2:
        # s3:
        # s4:
        # s5:
        # s6:
        # s7:

        ####################################################
        # Subroutine Setup

        push $ra                                # (opt) Unless its a leaf node
        push_s_registers                        # Save the "S" registers
        demarshal_inputs $t0, $t1, $t2, $t3
          # move $t0, $a0           
          # move $t1, $a1
          # move $t2, $a2
          # move $t3, $a3

        ####################################################

#       < Main Subroutine Code >

        ####################################################
        # Subroutine Cleanup

        marshal_return $t1                      # (opt) If stack is not used to return result
        pop_s_registers
        pop $ra
        remove_locals 5
        ####################################################

        stage_return $t1                        # (opt) ONLY IF stack IS used to return the result
        jr $ra                                  # Return
