# COMP122 Lecture Notes: September 23, 2024


## Announcements:
   1. Quiz: 10-
      - End of this week (Sept 27), details to follow
      - In general, details to follow
        - open resource
        - online 
        - one hour time-lime
        - 48 hour window to take the quiz
   1. MD Assignment: 11-
      - Invitation URL: https://classroom.github.com/a/oD2pD7Vi
      - Due Date: Sep 26 23:59 PDT (Thursday)


## Today's Agenda:
   1. Lecture: 
      - Processes, System Calls, Memory

   1. Lab:
      - Macros and Stack 
      - Review of if-then-else statement


## Questions from Last Lecture/Lab, etc.:
   * M/W @ 10:00 am
     - 

   * T/R @ 10:00 am
     - 


## Review from Last-time:

   1. MIPS Registers: 32 addressable registers
     - To support subroutine invocations (calls and returns)
       - Input *A*rg..uments (`$a0, $a1, $a2, $a3`)
       - Return *V*alue (`$v0, $v1`)
       - Frame Support (memory associated with a method)
         - Frame Pointer: `$fp` (start of the frame)
         - Stack Pointer: `$sp` (end of the frame)
       - Return Address: `$ra` 
     - To support intermediate calculations
       - *T*emporary registers (`$t0, $t1, ... $t9`)
       - *S*aved registers (`$s0, $s1, ... $s7`)
     - Reserved Registers:  (That is to day DON'T use)
       - `$k0, $k1`: used by the kernel, which is part of the OS
       - `$gp`: used by the compiler (e.g., javac)
       - `$at`: used by the assembler (i.e., mars)
     - Zero register (`$zero`)

   1. OS interface
      - subroutine call
        ```mips
        li $a0, 5                        # x = min(5, 3);
        li $a1, 3
        jal min
        move x, $v0
        ```

      - syscall (system call)
        ```mips
        move $a0, x                         #  print_int(x)
        li $v0, 5     # jal print_int
        syscall 
        ```

### MW's Class

  1. Types of instructions
     - native
       1. arithmetic and logic
       1. data transfers
       1. basic control flows

     - idiomatic 
       - pleasing to see...
         * beq $zero, $zero, label   # versus
         * b label
     - pseudo instructions
       - one or more instructions inserted by the assembler

     - macro instructions
       - user-level pseudo instructions 

     - subroutine
       - jal, jr, j
       - plus a bunch of conventions to follow for registers

   1. MIPS ISA architecture (reviewed)


### TR's Class
   1. ISA Instruction Set Architecture
      1. What is an ISA ?
         - A layer of abstraction just above the hardware
      1. Characteristics of an ISA
         1. A set of instructions and their semantics
         2. The data types that are directly supported by the hardware
         3. The number of registers, their names, size, and purpose.
         4. The orientation of memory, its alignment, its endianness, and size, and layout
         5. The protocol by which we make request to the OS via a defined interface.

   1. More detail about the MIPS ISA
      1. basic instruction:  
         1. arithmetic and logic (controlling the CPU)
         1. data transfers to and from registers/memory
         1. basic control flow: b, b<cond>, j, jal, jr
      1. memory layout
         - size = 0x 1 0000 0000 ( 0x 0000 0000 .. 0x ffff ffff )
         - orientation: 0x 0000 0000 is at the bottom
         - big endian
         - alignment -- deferred 
         - layout:  text, data, heap, and stack
      1. OS interface (see above)

   1. Generalized Execute Steps: Fetch, Decode, Execute, (Mem Access), Write-Back
   1. What is a kernel?
      - the most important part of the OS, 
      - the part of the OS that remains in memory 
   1. RISC (Reduced Instruction) versus CISC (Complex Instruction)
      - design philosophy 


---
# Today's Lecture Material

  1. See Slides
     -  models-comp-comm/slide*/processes*.pdf
  1. Finish up slides in Lab
  

# Today's Lab Material
  1. Finish lecture slides

  1. Macros: (see assembly*/slide*/macros_stack.pdf)
     * include/syscalls.s
     * include/stack.s     
     * include/io.s     
     * include/*frames.s (defer till later)
  1. Discussion on Stacks
  1. Discussion on printf: tidbits/print_routines.md 

  1. If-then-else Review
     - assembly_programming/code_09_18/*

---
## Resources
   * reference/TAC_transformation/if-then-else2TAC.md
   * reference/TAC2mips.md

### TAC2mips.md (Here is a subset)

  | TAC Equations                 | MIPS Instructions         |   
  |-------------------------------|---------------------------|
  | `return a`                    | `move $v0, a`             |
  |                               | `jr $ra`                  |


   * If-then-else Statements:

   * Reference labels
     * {init}: the statement *BEFORE* the `if-then-else` statement
     * {cond}: the line of code that contains: `if ( a <cond> b)`
     * {cons}: the consequence code block for the `if-then-else` statement
     * {alt}:  the alternative code block for the `if-then-else` statement
     * {done}: the statement *AFTER* the `if-then-else` statement
     

  | TAC Control Flow                  | MIPS Instruction           |
  |-----------------------------------|----------------------------|
  |                                   |                            |
  | `label: ;`                        | `label: nop`               |
  | `break label;`                    | `b {done}`                 |
  |                                   |                            |
  | `if (a <cond> b) {`               | `b<! cond> a, b, {alt}`    |
  |                                   |                            |        
  | `if (a <cond> b) {`               | `b<cond> a, b, {cons}`     |
  |                                   | `b {alt}`                  |
  |                                   |                            |
  | `} else {`                        |                            |
  | `}`                               |                            |
  |                                   |                            |


### Conditional Mappings

  | `TAC <cond>` | `MIPS <cond>` | `MIPS <! cond>` |`TAC <! cond>` |
  |:------------:|:-------------:|:---------------:|:-------------:|
  | `<`          | `lt`          | `ge`            |  `>=`         |
  | `<=`         | `le`          | `gt`            |  `>`          |
  | `!=`         | `ne`          | `eq`            |  `==`         |
  | `==`         | `eq`          | `ne`            |  `!=`         |
  | `>=`         | `ge`          | `lt`            |  `<`          |
  | `>`          | `gt`          | `le`            |  `<=`         |
   

---
<!-- This section for student's to place their own notes. -->
<!-- This section will not be updated by the Professor.   -->

## Notes  


