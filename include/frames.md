# Frame Support for MIPS

Within COMP122, we have defined three types of frames that can be used by students.  These frames have been designed to ease assembly develop and to expose students concepts associated with frames.

A series of macros have been developed to further ease application development.  A student can include one of the following files to include the associated definition for each of these macros.  These include files are:
The three types of frames defined are:
  1. register_frames.s
  1. full_frames.s
  1. ad-hoc_frames.s

It is a common convention that within a MIPS assemble program, the return value and the first four input arguments are passed via registers. Additional input arguments and local variables are stored on the stack.  Moreover, the frame pointer ($fp) is used to address both formal arguments and locals.  This convention used as an optimization strategy -- since must MIPS subroutines have 4 or less arguments.

The file "register_frames.s" contains the a set of macros to support this convention.  From a more theoretical point of view, a frame is used to pass all input and output parameters to and frame a subroutine.  We have develop the same set of macros to support this approach via the file "full_frames.s"

Finally, we developed the same set of macros for the most assemble programs that don't need a full frame to support subroutines.  These macros are defined via the file "ad-hoc_frames.s".  With an ad-hoc frame, there is no need for a frame pointer, the are no support for local variables, and the stack is only used for input arguments when there is more than four.


## Macro List

  1. set_frame
     - sets the frame pointer to be current top of the stack:  $fp = $sp
     - under both `register` and `full frames`, 
       * the top of the stack contains the staged return value
     - for `ad-hoc frames`, this macro is equivalent to a nop

  1. unset_frame
     - this macro is effectively a nop
     - the macro is defined to be symmetrical to set_frame

  1. marshal_inputs {reg0}, ... {reg3} 
     - arrange up to four arguments in registers:  $a0, ... $a3
     - for `full frames` this macro is equivalent to a nop

  1. demarshal_inputs {reg0}, ... {reg3} 
     - places the first four arguments into the identified registers
     - for `ad-hoc` and `register frames`, the values in $a0, ... $a3 are copied into the associated identified register
     - for `full frames`, the identified registers are loaded from the stack frame

  1. stage_formals   {arg0}, ... {argN-1}
     - places the arguments onto the stack from right-to-left
     - for `full frames` all arguments are placed onto the stack
     - for `register frames`, 
       * space is only allocated for the first four arguments
       * the additional arguments are loaded onto the stack
     - for `ad-hoc frames`,
       * no space is allocated for the first four arguments
       * the additional arguments are loaded onto the stack

  1. unstage_formals {reg0}, ... {regN-1}
     - copies the arguments from the stack from right-to-left into the identified registers
     - for `full frames` all arguments are placed onto the stack
     - for `register frames`, 
       * only the additional arguments ({reg4} .. {regN-1}) from right-to-left into the identified registers
     - for `ad-hoc frames`, this macro is equivalent toa nop 

  1. alloc_return
     - creates space on top of the stack for the return value
     - for `ad-hoc frames`, this macro is equivalent to a nop

  1. stage_return
     - for `full frames`, loads the return value onto the stack
     - for `register` and `ad-hoc frames`, places the value into $v0

  1. unstage_return
     - for `full frames`, pops the return value off the stack
     - for `register` and `ad-hoc frames`, this macro is equivalent to a nop

  1. add_locals {count}
     - add space on the stack for {count} variables
     - for `ad-hoc frames`, %count must be zero.

  1. remove_locals {count}
     - removes space, previously allocated for locals, from the stack
     - for `ad-hoc frames`, {count} must be zero.

  1. marshal_return {reg}
     - for `full-frames`, stores the return value (%reg) onto the stack
     - otherwise, places the return value (%reg) into $v0

  1. demarshal_return {reg}
     - for `full-frames`, loads the return value from the stack into %reg
     - otherwise, places the value into $v0 into the %reg


## General Discussion: ACTIVATION FRAMES, or simply, FRAMES

A call stack is used to support the execution of subroutines.  Each subroutine invocation results in a activation frame, or simply a frame, being created and stored on top of the stack. The frame contains the formal arguments, locals variables, temporary variables, etc.

There are many possible conventions that can used to defined the structure and the operation associated with a frame. Different programmers, assemblers, and compilers, can utilize different conventions to obtain desirable features. These conventions are typically machine dependent and ABI dependent[^abi].  

While there are some documented conventions associated with parameter passing, etc., for the MIPS architecture, there is no such thin as THE "MIPS Calling Convention" that defined _in total_ the structure of a frame.

In COMP122, utilize three different calling convention: `full frames`, `register frames` and `ad-hoc frame`.  
The first utilizes a more theoretical frame structure that places all values of a frame onto the stack,  the second utilizes registers as an optimization strategy and relies on the stack only when necessary.  Third is a simpler form that is a graceful degradation of the register frames. This last form is the simplest and is used during the beginning of the semester.

This simpler form, i.e., ad-hoc frames, has the following restrictions.

  1. There is at most 4 formal arguments provided to a subroutine
  2. Each of these arguments are passed via the registers: $a0, ... $a3
  3. Each of these arguments are then, by the programmer, moved to a temporary register
  4. There are no local variables (as are typical defined for high-level languages) 
     - all variables associated with the subroutine are mapped, a prior, to registers
  5. The single return value is passed via the register: $v0
  6. All functions that return a value that is not a "word", is returned as a pointer to the actual return value.

Because of these restrictions, there is no need to create a "structured" form which utilizes a frame pointer.

The rest of this file, documents this full frame structure. Refer to the individual macro include files for more additional information

[^abi]: application binary interface


## DESIGN CRITERIA

The convention and structure of a frame is based upon a number of Design Criteria.  Here is a list of questions that influence the final structure. We also provide the answers that drove the design of our full frame structure

### Questions:
   - Who is responsible, the Caller or the Callee, for pushing formal arguments onto the stack?
     * the Caller

   - Who is responsible for popping the arguments of the stack?
     * the Caller

   - Are varargs function supported?
     * Yes, and this implies that the Caller is responsible for pushing and popping formal arguments.

   - Is alloca supported, i.e., are temp variables supported?

     * Yes, alloca allows the programmer to allocate additional space on the stack for dynamic data.

   - Who is responsible for saving which registers?
     - Using the MIPS convention:
       * The Caller is responsible for saving the T registers
       * The Callee is responsible for saving the S registers
       * The Callee is responsible for saving any used special registers: i.e., $ra, $fp

   - Who is responsible for setting the frame pointer?
     * Typically, the Callee is responsible, BUT we decided the Caller is responsible
       - Logic is:  We provide the subroutine with: 
         * formal inputs, space for return values, and a pointer to this space (i.e., the $fp)

   - Where is the frame pointer set:  start of the frame, at arg0, or other?
     * The frame pointer is set to the return value, thus
       1. Formals are reference as:  pos($fp)
       1. Locals are reference as:   neg($fp)

   - Can special rules be used for leaf nodes for optimization purposes?
     * Yes, specific defined steps can be eliminated
   
   - What values can be stored on the stack: word, dword, doubles?
     * Only words are stored on the stack

   - Is padding needed to ensure alignment
     * No, because only words can be stored on the stack

   - Can registers be used for parameter passing?
     * Yes, $a0 ... $a3 for formal arguments.
     * Yes, $v0 ... $v1 for return values.

   - Can both $v0 and $v0 be used to return values
     * Yes, but only for the simplified form  
     * No, for the full frame structure.  The $v0 value can be a pointer to actual return value


## FRAME Layout  ee below for a picture layout of the Frame

The layout of the frame contains three major areas:

  1. a static area that contains 
     - the formal arguments
       * space for the first 4 arguments (i.e., for $a0 ... $a4) 
       * actual values of the  
       * note that the formal arguments are also part of the previous subroutine's dynamic space
     - space for the return value
     - the local variables

  1. a dynamic area that contains 
     - space for the $ra register
       * which can be eliminated if the subroutine is a leaf node
     - space for callee saved registers ($s7 .. $s0)

     - space for a subroutine stack  (see: man alloca)

     - space for caller saved registers ($t9..$t0)
     - space for the $fp register
       * the location of $fp register is well defined within the Callee's frame
       * the location below the last formal argument contains the location parent's $fp value

  1. parameter passing for a subordinate subroutine
     - space for the actual arguments associated with a subroutine call

  * Note the following registers are not stored within the stack frame
    - $zero: it's a constant
    - the reserved registers:
      - $at: it is the responsibility of the assembler
      - $k1, $k2: it is the responsibility of the kernel
      - $gp: it is the responsibility of the compiler
      - $sp: its previous values can be restored algebraically 

### EXAMPLE PICTURAL LAYOUT

  Given the example of 

  ```java
  public static int name(int a, int b, int c, int d, int e, int f) {

    int x, y, z;
    z = sub2(x, y, z, a, f);
   }
   ```

### Static Space:

   | Variable | Group  | Register |  Memory    | Expression       |
   |----------|--------|----------|------------|------------------|
   |    f     | Formal |          |    24($fp) |  local# << 2     |
   |    e     | Formal |          |    20($fp) |  local# << 2     |
   |    d     | Formal |  $a3     |    16($fp) |  local# << 2     |
   |    c     | Formal |  $a2     |    12($fp) |  local# << 2     |
   |    b     | Formal |  $a1     |     8($fp) |  local# << 2     |
   |    a     | Formal |  $a0     |     4($fp) |  local# << 2     |
   |  return  | Return |  $v0     |     0($fp) |                  | <- $fp
   |----------|--------|----------|-  ---------|------------------|
   | return2  | Return |  $v1     | (optional) |                  | * Cnsider it a local
   |    x     | Local  |  --      |    -4($fp) |  - local# << 2   |
   |    y     | Local  |  --      |    -8($fp) |  - local# << 2   |
   |    z     | Local  |  --      |   -12($fp) |  - local# << 2   |
   |----------|--------|----------|----------|--------------------|


### Dynamic Space:

   | Variable | Group  | Register |  Memory  | Expression         |
   |----------|--------|----------|----------|--------------------|
   |    -     | Callee |  $ra     |  ?       | pushed onto stack  |
   |    -     | Callee |  $s7     |  ?       | pushed onto stack  |
   |    -     | Callee |  ...     |  ?       | pushed onto stack  |
   |    -     | Callee |  $s0     |  ?       | pushed onto stack  |
   |----------|--------|----------|----------|--------------------|
   |    -     | IStack |          |  ?       | alloca(size)       | * Can repeated any number of times
   |----------|--------|----------|----------|--------------------|
   |    -     | Caller |  $t9     |  ?       | pushed onto stack  |
   |    -     | Caller |  ...     |  ?       | pushed onto stack  |
   |    -     | Caller |  $t0     |  ?       | pushed onto stack  |
   |    -     | Callee |  $fp     |  ?       | pushed onto stack  |
   |----------|--------|----------|----------|--------------------|

### Parameter Passing Space:

   | Variable | Group  | Register |  Memory  | Expression         |
   |----------|--------|----------|----------|--------------------|
   |    f     | Actual |  ---     |  ?       |  push onto stack   |
   |    a     | Actual |  $a3     |  ?       |  allocai(4)        |
   |    z     | Actual |  $a2     |  ?       |  allocai(4)        |
   |    y     | Actual |  $a1     |  ?       |  allocai(4)        |
   |    x     | Actual |  $a0     |  ?       |  allocai(4)        |
   |  return  | Return |  $v0     |  ?       |  allocai(4)        | * <- $sp
   |----------|--------|----------|----------|--------------------|   



## MIPS PROCESSES

### Subroutine Setup/Cleanup Process // Example

   ```mips

                   .globl name            
     name:         nope                    # int name(int a, int b, int c, int d, int e, int f)
    
                   # Register Allocation:
                   # t0: a
                   # t1: b
                   # t2: c
                   # t3: d
                   # t4: e
                   # t5: f
    
                   ####################################################
                   # Subroutine Setup

                   load_additional_inputs $t4, $t5                 # In lieu of accessing via memory
                   add_locals 3                                    # Space for locals
                   push $ra                                        # (For Non-leaf): Save the return address
                   push_s_registers                                # (For Non-leaf) ave the "Callee" saved registers
                   demarshal_inputs $t0, $t1, $t2, $t3             # 
    
                   ####################################################
                   # Note: obtain the additional inputs via the stack via direct memory access
                   #   ad-hoc frame:   nope: must use 'load_additional_inputs'
                   #   register frame: access additional args from stack via $fp 
                   #   full frame:     access all args from the stack via the $fp

    
                   < Main Subroutine Code >
    
                   ####################################################
                   # Subroutine Cleanup
     
                   marshal_return $t1
                   pop_s_registers
                   pop $ra
                   remove_locals 5
                   stage_return $t1
                   ####################################################
    
                   jr $ra
    ```



### Subroutine Invocation Process

   ```mips

                   ####################################################
                   # The Pre-call

                   marshal_inputs({arg0} ... {arg3})
                   push_t_registers
                   push $fp
                   stage_formals({arg0} ... {argN-1})
                   alloc_return                                    # Space for return: allocai(4) -- always

                   ####################################################
                   # The Call

                   set_frame() 
                   jal {func}                                      # {retval} = {func}({arg1}..{arg3});
                   unset_frame()
    
                   ####################################################
                   # The Post-call

                   unstage_return $v0                              # Only if return is on the stack    
                   unstage_formals({arg0} ... {argN-1}) 
                   pop $fp
                   pop_t_registers()                               # Restore T registers 
                   demarshal_return({reg})                         
                   ####################################################
    ```


## Additional Information of Frames

The literature provides various definition of frames. The following table compares the three frame structure defined via mips_subroutine with virtual frames and the more standard frame structure.


  | Type      | Anchor Point  | Formals    | Locals | Callee Reg | Temps    | Caller Reg | Actual Args |
  |-----------|---------------|------------|--------| ---------- |----------| ---------- |-------------|
  | Virtual   |  $sp ->tos    |  Stack     |  Yes   |   static   | compiler |   static   | compiler    |
  | Standard  |  $fp ->arg0   |  Stack     |  Yes   |   static   | compiler |   static   | static      |
  | Full      |  $fp ->return |  Stack     |  Yes   |   static   | yes      |   dynamic  | static      |
  | Registers |  $fp ->arg4   |  Stack*    |  Yes   |   static   | yes      |   dynamic  | static      |
  | Ad-Hoc    |  $sp ->tos    |  Reg+Stack |  No    |   dynamic  | yes      |   dynamic  | no          |

 
  * Anchor Point: the relative location in which all addressing is performed
  * Formals:  the location wither formal arguments (and return value) are staged:
    - Stack*: indicates that all formals have a predefined location within the frame, but the first 4 arguments are passed via registers
    - Reg+Stack: indicates that the first 4 arguments are passed via registers, and ONLY the additional arguments are passed via the stack
  * Locals: indicates whether or not "local" variables are supported.
  * Callee Reg: indicates how the callee registers ($sp, $fp, $sX) are placed onto the stack.  Static indicates that the register locations are predefined.
  * Temps: Indicates that temporary variable are supported.  The temps are allocated via "alloca".
  * Caller Reg: indicates how the caller registers ($tX) are placed onto the stack.  Static indicates that the register locations are predefined.
  * Actual Args: indicates if the actual arguments to the subroutine are directly accessible via the anchor point. 



## Typical Frame Components in order of 
   1. Formal Arguments ([^a_regs]): Associated with the Parents Frame(shared)
   1. Local Variables ([^local])
   1. Caller Saved: $t0 .. $t9
   1. Callee Saved: $ra, $sp, $fp, $gp, $s0 - $s8 (^[mask])
   1. Actual Args (shared)



## Frame Components in order of for COMP122
   1. Formal Arguments ([^a_regs]): Associated with the Parents Frame(shared)
   1. Return Value
   1. Local Variables ([^local])
   1. Callee Saved: $ra, $s0 - $s8 (^[mask])
   1. Dynamic Temps ([^alloca])  
   1. Caller Saved: $t0 - $t9 (^[mask],[^[dynamic]])
   1. Frame Pointer: $fp
   1. Actual Args (shared)




   [^*]: The location of the Temp Area is changed to be after the Caller Saved Area
   [^return]: Return values are placed on top of the stack, except Basic and Macro
   [^a_regs]: Space for all arguments are placed on the stack, except Basic and Macro
   [^local]: Includes compiler generated variables.
   [^mask]: If a mask is used to registers in a component need to be organized in descending order.  I.e., the s-registers are stored $s8 - $s0. 
   [^alloca]: The location of the Alloca component is relocated with Virtual and Static frames.
   [^dynamic]: The registers $t0-$t9 must be dynamically placed if alloca is used, either otherwise

## Requirements // Caveats 
   1. The Caller owns the Procedure Call Argument Component
      - hence it is responsible for its creation and destruction
   1. The Caller presumes that the Procedure Call Argument Component is volatile 
      * The Caller presumes the registers: $a0 - $a3, $v0, and $v1 are volatile
   1. Arguments are placed onto the stack from right-to-left
   1. Stack frames must be double word aligned (8)
   1. Stack frames must be in evenly divisible by 8
      - issue with Alloc, take steps to ensure alignment of $sp
      - this is to insure double args can be transferred

   1. Arguments include return values...
   1. Optimization to alias return values with arg_n, etc.


## Names:
   1. Virtual Frame:
      - presumes compiler support
      - frame addressing for all is via $sp ($fp is NOT used)
      - presume no alloca support
    
   1. Standard Frame 
      - frame addressing for all is via $fp
      - $fp points to arg_0
      - alloca component is relocated to the end of the frame
      - return value is place into $fp


Full because it the frame is FULL with respect to the formal arguments

   1. FULL Frame for COMP122
      - frame addressing for formals + locals are via $fp
      - frame addressing for registers is via $sp
      - $fp points to arg_0
      - arg_0 .. arg_3 are passed via register, with space on stack
      - ret_0 ... ret_1 are passed via registers, with space on stack    << * only one return
      - alloca supported

      - Degrades to Ad-Hoc Frame
        - MIPS register convention is used
        - formals <= 4, or popped of the stack a priori
        - number of locals == 0 

   1. Ad-hoc Frame for COMP122
      - it is called the Ad-hoc frame, we do only as necessary
      - $fp is not used, $gp is not used
      - addressing via $sp, and need not be saved
      - ret0..ret1 are in registers
      - arg0..arg3 are in registers
      - additional args are
        - pushd onto the stack by the Caller from right-to-left
        - poped off the stack via the Callee
      - number of locals == 0 (presumed to be all in registers)
      - alloca supported

