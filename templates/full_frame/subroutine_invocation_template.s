# This file provides a template for calling a MIPS subroutine using a full frame
#
# Assertions:
#   1. There are more than 4 args
#   1. The first 4 arguments are staged in the $a0, $a1, $a2, $a3
#
#   1. The stack is subsequently used to
#      - store the T registers
#      - store the Caller's fp
#      - pass the additional arguements
#      - hold the return value
#

#   x = func(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)


        # Example of a Subroutine Invocation
        ####################################################
        # The Pre-call

        marshall_inputs({arg0}, {arg1}, {arg2}, {arg3})   # Marshal the input args into the registers
          # move $a0, {arg1}            
          # move $a1, {arg2}         
          # move $a2, {arg3}         
        push_t_registers()                      # Save the "T" registers
        push $fp                                # Save the frame pointer
        stage_formals({arg4} ... {arg7})        # Place args on the Stack
        push $v0                                # Space for return: alloca_i(4) -- always


        ####################################################
        # The Call

        set_frame()                             # $fp == $sp
        jal {func}                              # {retval} = {func}({arg1}..{arg3});


        ####################################################
        # The Post-call

        pop $v0                                 # Pop results even if not used
        unstage_formals({arg4} ... {arg7})      # Dellocate from the stack
        pop $fp                                 # Restore the frame pointer
        pop_t_registers()                       # Restore T registers 
        demarshal_return({x})                   # Demarshal return value   
        ####################################################
