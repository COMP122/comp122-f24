# This file contains the macros to support the defined COMP122 "REGISTER frame". The frame provides space formal 
# arguments, local variables, temporary storage, and all relevant registers.

# FRAME Layout
#
# See below for a picture layout of the Frame
#
# The layout of the frame contains three major areas:
#
#  1. a static area that contains 
#     - the formal arguments
#       * space for the first 4 arguments (i.e., for $a0 ... $a4) 
#       * actual values of the  
#       * note that the formal arguments are also part of the previous subroutine's dynamic space
#     - space for the return value
#     - the local variables
#
#  1. a dynamic area that contains 
#     - space for the $ra register
#       * which can be eliminated if the subroutine is a leaf node
#     - space for callee saved registers ($s7 .. $s0)
#
#     - space for a subroutine stack  (see: man alloca)
#
#     - space for caller saved registers ($t9..$t0)
#     - space for the $fp register
#       * the location of $fp register is well defined within the Callee's frame
#       * the location below the last formal argument contains the location parent's $fp value
#
#  1. parameter passing for a subordinate subroutine
#     - space for the actual arguments associated with a subroutine call
#
#  * Note the following registers are not stored within the stack frame
#    - $zero: it's a constant
#    - the reserved registers:
#      - $at: it is the responsibility of the assembler
#      - $k1, $k2: it is the responsibility of the kernel
#      - $gp: it is the responsibility of the compiler
#      - $sp: its previous values can be restored algebraically 

#
# EXAMPLE PICTURAL LAYOUT
#
#   Given the example of 
#     ```
#     int name(int a, int b, int c, int d, int e, int f) {
#
#       int x, y, z;
#       z = sub2(x, y, z, a, f);
#     }
#     ```

# Static Space:
#
#         | Variable | Group  | Register |  Memory  | Expression         |
#         |----------|--------|----------|----------|--------------------|
#         |    f     | Formal |          |  24($fp) |  local# << 2       |
#         |    e     | Formal |          |  20($fp) |  local# << 2       |
#         |    d     | Formal |  $a3     |  16($fp) |  local# << 2       |
#         |    c     | Formal |  $a2     |  12($fp) |  local# << 2       |
#         |    b     | Formal |  $a1     |   8($fp) |  local# << 2       |
#         |    a     | Formal |  $a0     |   4($fp) |  local# << 2       |
#  $fp->  |  return  | Return |  $v0     |   0($fp) |                    |
#         ---------------------------------------------------------------|
#         | return2  | Return |  $v1     |  (optional)                   | * consider it a local
#         |    x     | Local  |  --      |  -4($fp) |  - local# << 2     |
#         |    y     | Local  |  --      |  -8($fp) |  - local# << 2     |
#         |    z     | Local  |  --      | -12($fp) |  - local# << 2     |
#         |--------------------------------------------------------------|

# Dynamic Space:
#
#         | Variable | Group  | Register |  Memory  | Expression         |
#         |----------|--------|----------|----------|--------------------|
#         |    -     | Callee |  $ra     |  ?       | pushed onto stack  |
#         |    -     | Callee |  $s7     |  ?       | pushed onto stack  |
#         |    -     | Callee |  ...     |  ?       | pushed onto stack  |
#         |    -     | Callee |  $s0     |  ?       | pushed onto stack  |
#         ----------------------------------------------------------------
#         |    -     | IStack |          |  ?       | alloca(size)       |   # Can repeated any number of times
#         ----------------------------------------------------------------
#         |    -     | Caller |  $t9     |  ?       | pushed onto stack  |
#         |    -     | Caller |  ...     |  ?       | pushed onto stack  |
#         |    -     | Caller |  $t0     |  ?       | pushed onto stack  |
#         |    -     | Callee |  $fp     |  ?       | pushed onto stack  |

# Parameter Passing Space:
#
#         ----------------------------------------------------------------
#         | Variable | Group  | Register |  Memory  | Expression         |
#         |----------|--------|----------|----------|--------------------|
#         |    f     | Actual |  ---     |  ?       |  push onto stack   |
#         |    a     | Actual |  $a3     |  ?       |  allocai(4)        |
#         |    z     | Actual |  $a2     |  ?       |  allocai(4)        |
#         |    y     | Actual |  $a1     |  ?       |  allocai(4)        |
#         |    x     | Actual |  $a0     |  ?       |  allocai(4)        |
#  $sp->  |  return  | Return |  $v0     |  ?       |  allocai(4)        |
#         ----------------------------------------------------------------



# PROCESSES
#
# Subroutine Setup/Cleanup Process

# #####  
#               .globl name            
# name:         nop                     # int name(int a, int b, int c, int d, int e, int f)
#
#               # Register Allocation:
#               # t0: a
#               # t1: b
#               # t2: c
#               # t3: d
#               # t4: e
#               # t5: f
#
#               ####################################################
#               # Subroutine Setup
#
#               add_locals 3                                    # Space for locals
#               push $ra                                        # (For Non-leaf): Save the return address
#               push_s_registers                                # (For Non-leaf): Save the "Callee" saved registers
#               demarshal_inputs $t0, $t1, $t2, $t3             # 
#
#               ####################################################
#               # Note: obtain the additional inputs via the stack via direct memory access
#               #   ad-hoc frame:   nope: must use 'load_additional_inputs'
#               #   register frame: access additional args from stack via $fp 
#               #   full frame:     access all args from the stack via the $fp
#
#               < Main Subroutine Code >
#
#               ####################################################
#               # Subroutine Cleanup
# 
#               marshal_return $t1
#               pop_s_registers
#               pop $ra
#               remove_locals 3
#               stage_return $t1
#               ####################################################
#
#               jr $ra
# #####



# Subroutine Invocation Process
#
#               ####################################################
#               # The Pre-call
#
#               marshal_inputs {arg0} ... {arg3} 
#               push_t_registers
#               push $fp
#               stage_formals {arg0} ... {argN-1}
#               alloc_return                                    # Space for return: allocai(4)
#
#               ####################################################
#               # The Call
#
#               set_frame()
#               jal {func}                                      # {retval} = {func}({arg1}..{arg3});
#               unset_frame()
#    
#               ####################################################
#               # The Post-call
#
#               unstage_return $v0                              # Only if return is on the stack    
#               unstage_formals {arg0} ... {argN-1}
#               pop $fp
#               pop_t_registers                                 # Restore T registers 
#               demarshal_return({reg})
#               ####################################################


####################################################################
# Registers Frame: 
#   - Registers are used
#   - All args have space on the stack


## Add Locals
.macro add_locals(%count)
       li $gp, %count
       sll $gp, $gp, 2
       subu  $sp, $sp, $gp
.end_macro
.macro remove_locals(%count)
       li $gp, %count
       sll $gp, $gp, 2
       addu $sp, $sp, $gp
.end_macro


##  Marshal Inputs
.macro marshal_inputs(%arg0, %arg1, %arg2, %arg3)
        move $a3, %arg3
        move $a2, %arg2
        move $a1, %arg1
        move $a0, %arg0
.end_macro
.macro marshal_inputs(%arg0, %arg1, %arg2)
        move $a2, %arg2
        move $a1, %arg1
        move $a0, %arg0
.end_macro
.macro marshal_inputs(%arg0, %arg1)
        move $a1, %arg1
        move $a0, %arg0
.end_macro
.macro marshal_inputs(%arg0)
        move $a0, %arg0
.end_macro
.macro marshal_inputs()

.end_macro

##  Demarshal Inputs
.macro demarshal_inputs(%arg0, %arg1, %arg2, %arg3)
        move %arg3, $a3
        move %arg2, $a2
        move %arg1, $a1
        move %arg0, $a0
.end_macro
.macro demarshal_inputs(%arg0, %arg1, %arg2)
        move %arg3, $a3
        move %arg2, $a2
        move %arg1, $a1
        move %arg0, $a0
.end_macro
.macro demarshal_inputs(%arg0, %arg1)
        move %arg1, $a1
        move %arg0, $a0
.end_macro
.macro demarshal_inputs(%arg0)
        move %arg0, $a0
.end_macro
.macro demarshal_inputs()

.end_macro



## Stage Formals
.macro stage_formals(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5, %arg6, %arg7, %arg8)
       addiu $sp, $sp, -36
       sw %arg8, 32($sp)
       sw %arg7, 28($sp)
       sw %arg6, 24($sp)
       sw %arg5, 20($sp)
       sw %arg4, 16($sp)
       # arg0 .. arg3 are marshaled in registers
       # sw %arg3, 12($sp)
       # sw %arg2,  8($sp)
       # sw %arg1,  4($sp)
       # sw %arg0,  0($sp)
.end_macro
.macro stage_formals(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5, %arg6, %arg7)
       addiu $sp, $sp, -32
       sw %arg7, 28($sp)
       sw %arg6, 24($sp)
       sw %arg5, 20($sp)
       sw %arg4, 16($sp)
       # arg0 .. arg3 are marshaled in registers
       # sw %arg3, 12($sp)
       # sw %arg2,  8($sp)
       # sw %arg1,  4($sp)
       # sw %arg0,  0($sp)
.end_macro
.macro stage_formals(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5, %arg6)
       addiu $sp, $sp, -28
       sw %arg6, 24($sp)
       sw %arg5, 20($sp)
       sw %arg4, 16($sp)
       # arg0 .. arg3 are marshaled in registers
       # sw %arg3, 12($sp)
       # sw %arg2,  8($sp)
       # sw %arg1,  4($sp)
       # sw %arg0,  0($sp)

.end_macro
.macro stage_formals(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5)
       addiu $sp, $sp, -24
       sw %arg5, 20($sp)
       sw %arg4, 16($sp)
       # arg0 .. arg3 are marshaled in registers
       # sw %arg3, 12($sp)
       # sw %arg2,  8($sp)
       # sw %arg1,  4($sp)
       # sw %arg0,  0($sp)
.end_macro
.macro stage_formals(%arg0, %arg1, %arg2, %arg3, %arg4)
       addiu $sp, $sp, -20
       sw %arg4, 16($sp)
       # arg0 .. arg3 are marshaled in registers
       # sw %arg3, 12($sp)
       # sw %arg2,  8($sp)
       # sw %arg1,  4($sp)
       # sw %arg0,  0($sp)
.end_macro
.macro stage_formals(%arg0, %arg1, %arg2, %arg3)
       addiu $sp, $sp, -16
       # arg0 .. arg3 are marshalled in registers
       # sw %arg3, 12($sp)
       # sw %arg2,  8($sp)
       # sw %arg1,  4($sp)
       # sw %arg0,  0($sp)

.end_macro
.macro stage_formals(%arg0, %arg1, %arg2)
       addiu $sp, $sp, -12
       # arg0 .. arg2 are marshaled in registers
       # sw %arg2,  8($sp)
       # sw %arg1,  4($sp)
       # sw %arg0,  0($sp)
.end_macro
.macro stage_formals(%arg0, %arg1)
       addiu $sp, $sp, -8
       # arg0 .. arg1 are marshaled in registers
       # sw %arg1,  4($sp)
       # sw %arg0,  0($sp)
.end_macro
.macro stage_formals(%arg0)
       addiu $sp, $sp, -4
       # arg0 .. arg1 are marshaled in registers
       # sw %arg0,  0($sp)
.end_macro
.macro stage_formals()

.end_macro

## UnStage Formals
.macro unstage_formals(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5, %arg6, %arg7, %arg8)
       subiu $sp, $sp, -36
.end_macro
.macro unstage_formals(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5, %arg6, %arg7)
       subiu $sp, $sp, -32
.end_macro
.macro unstage_formals(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5, %arg6)
       subiu $sp, $sp, -28
.end_macro
.macro unstage_formals(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5)
       subiu $sp, $sp, -24
.end_macro
.macro unstage_formals(%arg0, %arg1, %arg2, %arg3, %arg4)
       subiu $sp, $sp, -20
.end_macro
.macro unstage_formals(%arg0, %arg1, %arg2, %arg3)
       subiu $sp, $sp, -16
.end_macro
.macro unstage_formals(%arg0, %arg1, %arg2)
       subiu $sp, $sp, -12
.end_macro
.macro unstage_formals(%arg0, %arg1)
       subiu $sp, $sp, -8
.end_macro
.macro unstage_formals(%arg0)
       subiu $sp, $sp, -4
.end_macro
.macro unstage_formals()

.end_macro

## Alloc Return
.macro alloc_return()
        push $zero
.end_macro

.macro stage_return(%reg)
        move $v0, %reg 
.end_macro

.macro unstage_return(%reg)
        pop $zero
.end_macro

.macro set_frame()
        move $fp, $sp
.end_macro
.macro unset_frame()

.end_macro


.macro marshal_return(%reg)
        move $v0, %reg
.end_macro
.macro demarshal_return(%reg)
        move %reg, $v0
.end_macro

###########################

.macro load_additional_inputs(%arg4, %arg5, %arg6, %arg7, %arg8)
        lw %arg8, 36($fp)
        lw %arg7, 32($fp)
        lw %arg6, 28($fp)
        lw %arg5, 24($fp)
        lw %arg4, 20($fp)
.end_macro
.macro load_additional_inputs(%arg4, %arg5, %arg6, %arg7)
        lw %arg7, 32($fp)
        lw %arg6, 28($fp)
        lw %arg5, 24($fp)
        lw %arg4, 20($fp)
.end_macro
.macro load_additional_inputs(%arg4, %arg5, %arg6)
        lw %arg6, 28($fp)
        lw %arg5, 24($fp)
        lw %arg4, 20($fp)
.end_macro
.macro load_additional_inputs(%arg4, %arg5)
        lw %arg5, 24($fp)
        lw %arg4, 20($fp)
.end_macro
.macro load_additional_inputs(%arg4)
        lw %arg4, 20($fp)
.end_macro


# DESIGN CRITTERIA
#
# The convention and structure of a frame is based upon a number of Design Criteria.  Here is a list of questions, 
# along with our answers, that influence the final structure
#
# Questions:
#   - Who is responsible, the Caller or the Callee, for pushing formal arguments onto the stack?
#     * the Caller
#
#   - Who is responsible for popping the arguments of the stack?
#     * the Caller
#
#   - Are varargs function supported?
#     * Yes, and this implies that the Caller is responsible for pushing and popping formal arguments.
#
#   - Is alloca supported?
#     * Yes, alloca allows the programmer to allocate additional space on the stack for dynamic data.
#
#   - Who is responsible for saving which registers?
#     - Using the MIPS convention:
#       * The Caller is responsible for saving the T registers
#       * The Callee is responsible for saving the S registers
#       * The Callee is responsible for saving any used special registers: i.e., $ra, $fp
#
#   - Who is responsible for setting the frame pointer?
#     * Typically, the Callee is responsible, BUT we decided the Caller is responsible
#       - Logic is:  We provide the subroutine with: 
#         * formal inputs, space for the return value, and a pointer to this space (i.e., the $fp)
#
#   - Where is the frame pointer set:  start of the frame, at arg0, or other?
#     * The frame pointer is set to the return value, thus
#       1. Formals are reference as:  pos($fp)
#       1. Locals are reference as:   neg($fp)
#
#   - Can special rules be used for leaf nodes for optimization purposes?
#     * Yes, specific defined steps can be eliminated
#   
#   - What values can be stored on the stack: word, dword, doubles?
#     * Only words are stored on the stack
#
#   - Is padding needed to ensure alignment
#     * No, because only words can be stored on the stack
#
#   - Can registers be used for parameter passing?
#     * Yes, $a0 ... $a3 for formal arguments.
#     * Yes, $v0 ... $v1 for return values.
#
#   - Can both $v0 and $v0 be used to return values
#     * Yes, but only for the simplified form  
#     * No, for the full frame structure.  The $v0 value can be a pointer to actual return value
#