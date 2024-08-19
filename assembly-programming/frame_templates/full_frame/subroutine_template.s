# This file provides a template for a MIPS subroutine that uses a simple frame
#
# This template presume that 
#   - a frame is necessary
#   - all arguments are staged in registers (a0..a3, v0, v1)
#   - registers can be saved/restored via push/pop
#
# Assertations:
#   1. First 4 args are in the $a0, $a1, $a2, $a3
#   1. The stack contains, in order:
#         - values for any additional args  (limited to a total of 8)
#         - space for the first 4 args
#         - space for the return value
#   1. The stack subsequently is used to 
#         - hold local values
#         - save the $ra value
#         - save the S registers
#   1. The $fp registers is used to access both the Formals and Local variables
#      * See:  "frames.s" to see the layout of the stack
#        1. Formals are reference as: pos($fp)
#        1. Locals are reference as:  neg($fp)


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

        add_locals 5                            # Make room for locals
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
