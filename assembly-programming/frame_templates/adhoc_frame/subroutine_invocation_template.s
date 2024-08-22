# This file provides a template for calling a MIPS subroutine using a simple frame
#
# Assertions:
#   1. There are at most 4 args
#   1. These arguments are staged in the $a0, $a1, $a2, $a3
#
#   1. The stack is subsequently used
#      - store the T registers
#

#   x = func(arg0, arg1, arg2, arg3, arg4)


        # Example of a Subroutine Invocation
        ####################################################
        # The Pre-call

        marshall_inputs({arg0}, {arg1}, {arg2}, {arg3})   # Marshal the input args into the registers
          # move $a0, {arg1}            
          # move $a1, {arg2}         
          # move $a2, {arg3}         
        push_t_registers()                          # Save the "T" registers


        ####################################################
        # The Call

        set_frame()                             # $fp == $sp
        jal {func}                              # {retval} = {func}({arg1}..{arg3});


        ####################################################
        # The Post-call

        pop_t_registers()                       # Restore T registers 
        demarshal_return({x})                   # Demarshal return value   
        ####################################################
