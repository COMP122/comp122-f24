# Filename: ad-hoc_frames.s
#
# Description: 
#    This file contains a set macros specificall associated with ad-hoc frames.
#    It redefines specific macros associated with registers_frame.s
#
# Restrictions:
#    - the both the $fp and $gp registers are not used
#    - addressing is via $sp, and it does not need to be saved
#      * it is expected that the $sp is modified to ensure correctness
#    - there are no designated "local" variables
#      * such variables must be allocated dynamically, e.g., via alloca
#      * N must be '0' for the macro calls `add_locals N` and `remove_locals N` 
#
# Specification:
#    - the return arguments are passed via the registers $v0, $v1
#    - the first four input arguments are passed via the registers $a0, .. $a3
#    - additional input arguments are pushed onto the stack
#      * in reverse order via the CALLER subroutine
#      * said arguments MUST be popped off the stack via the CALLEE subroutine
#
# Questions Related to Design Criteria:
#   - Refer to the end of this file
#
# Frame Layout via an Example
#
#   Given:
#     ```
#     int name( int a, int b, int c, int d, int e, int f) {
#
#       //  int x, y, z;          # Not Supported: Presume x, y, & z reference registers
#       z = sub2(x, y, z, a, f);
#     }
#     ```

# Static Space upon Call.
#
#         | Variable | Group  | Register |  Memory  | Offset Expression  |
#         |----------|--------|----------|----------|--------------------|
#         |    f     | Formal |          |   8($fp) |  local# << 2       |
#  $sp->  |    e     | Formal |          |   4($fp) |  local# << 2       |
#         ---------------------------------------------------------------|
#
#         Note: the values of e & f, are poped of the statck by the Callee

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
#
# Parameter Passing Space on Stack
#
#         ----------------------------------------------------------------
#         | Variable | Group  | Register |  Memory  | Comment            |
#         |----------|--------|----------|----------|--------------------|
#  $sp->  |    f     | Actual |  ---     |  ?       |  push onto stack   |
#
# Paramemter Passing in Registers
#
#         ----------------------------------------------------------------
#         | Variable | Group  | Register |  Memory  | Comment            |
#         |----------|--------|----------|----------|--------------------|
#         |    a     | Actual |  $a3     |  ?       |                    |
#         |    z     | Actual |  $a2     |  ?       |                    |
#         |    y     | Actual |  $a1     |  ?       |                    |
#         |    x     | Actual |  $a0     |  ?       |                    |
#         ---------------------------------------------------------------
#
#
# Processess
#
# Subroutine Setup/Cleanup Process
#
# #####  
#               .globl name            
# name:         nop                    # int name(int a, int b, int c, int d, int e, int f)
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
#               load_additional_inputs $t4, $t5                 # In lieu of accessing via memory
#               add_locals 0                                    # Space for locals
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
#               remove_locals 0
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
# Ad-hoc Frame: 
#   - Registers are used
#   - Only extra args are placed onto the stack, with no space allocated for arg0..arg3


## Add Locals
.macro add_locals(%count)
        li $gp, %count
        beq $zero, $gp, skip
          break
skip:   nop
.end_macro


.macro remove_locals(%count)
        li $gp, %count
        beq $zero, $gp, skip
          break
skip:   nop                  
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
       addiu $sp, $sp, -20
       sw %arg8, 16($sp)
       sw %arg7, 12($sp)
       sw %arg6,  8($sp)
       sw %arg5,  4($sp)
       sw %arg4,  0($sp)
       # arg0 .. arg3 are marshaled in registers and no space on the stack
.end_macro
.macro stage_formals(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5, %arg6, %arg7)
       addiu $sp, $sp, -16
       sw %arg7, 12($sp)
       sw %arg6,  8($sp)
       sw %arg5,  4($sp)
       sw %arg4,  0($sp)
       # arg0 .. arg3 are marshaled in registers and no space on the stack
.end_macro
.macro stage_formals(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5, %arg6)
       addiu $sp, $sp, -12
       sw %arg6,  8($sp)
       sw %arg5,  4($sp)
       sw %arg4,  0($sp)
       # arg0 .. arg3 are marshaled in registers and no space on the stack
.end_macro
.macro stage_formals(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5)
       addiu $sp, $sp, -8
       sw %arg5, 4($sp)
       sw %arg4, 0($sp)
       # arg0 .. arg3 are marshaled in registers and no space on the stack
.end_macro
.macro stage_formals(%arg0, %arg1, %arg2, %arg3, %arg4)
       addiu $sp, $sp, -4
       sw %arg4, 16($sp)
       # arg0 .. arg3 are marshaled in registers and no space on the stack
.end_macro
.macro stage_formals(%arg0, %arg1, %arg2, %arg3)
.end_macro
.macro stage_formals(%arg0, %arg1, %arg2)
.end_macro
.macro stage_formals(%arg0, %arg1)
.end_macro
.macro stage_formals(%arg0)
.end_macro
.macro stage_formals()
.end_macro


## UnStage Formals
.macro unstage_formals(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5, %arg6, %arg7, %arg8)
       subiu $sp, $sp, -20
.end_macro
.macro unstage_formals(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5, %arg6, %arg7)
       subiu $sp, $sp, -16
.end_macro
.macro unstage_formals(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5, %arg6)
       subiu $sp, $sp, -12
.end_macro
.macro unstage_formals(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5)
       subiu $sp, $sp, -8
.end_macro
.macro unstage_formals(%arg0, %arg1, %arg2, %arg3, %arg4)
       subiu $sp, $sp, -4
.end_macro
.macro unstage_formals(%arg0, %arg1, %arg2, %arg3)

.end_macro
.macro unstage_formals(%arg0, %arg1, %arg2)

.end_macro
.macro unstage_formals(%arg0, %arg1)

.end_macro
.macro unstage_formals(%arg0)

.end_macro
.macro unstage_formals()

.end_macro


## Alloc Return
.macro alloc_return()

.end_macro

.macro stage_return(%reg)
        move $v0, %reg 
.end_macro

.macro unstage_return(%reg)
.end_macro

.macro set_frame()

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
        pop %arg4 %arg5 %arg6 %arg7 %arg8
.end_macro
.macro load_additional_inputs(%arg4, %arg5, %arg6, %arg7)
        pop %arg4 %arg5 %arg6 %arg7
.end_macro
.macro load_additional_inputs(%arg4, %arg5, %arg6)
        pop %arg4 %arg5 %arg6 
.end_macro
.macro load_additional_inputs(%arg4, %arg5)
        pop %arg4 %arg5
.end_macro
.macro load_additional_inputs(%arg4)
        pop %arg4
.end_macro



# Questions Related to Design Criteria:
#   - Who is responsible for pushing formal arguments onto the stack?
#     * the Caller
#
#   - Who is responsible for popping the arguments of the stack?
#     * the Callee
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
#     * mute: the frame pointer is not used
#
#   - Where is the frame pointer set:  start of the frame, at arg0, or other?
#     * mute: the frame pointeer is not used
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
#     * Not only Yes, they must be passed in registers
#       * $v0 ... $v1 for return values.
#       * $a0 ... $a3 for formal arguments.
#
#   - Can both $v0 and $v0 be used to return values
#     * Yes, but only via the registers

