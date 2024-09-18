# COMP122 Lecture Notes: September 18, 2024

## Announcements:
   1. Quiz: 10-
      - End of next week (Sept 27), details to follow
      - In general, details to follow
        - open resource
        - online 
        - one hour timelime
        - 48 hour window to take the quiz
   1. MD Assignment: 11-
      - To be released on Wednesday
      - View it as a practice for the quiz


## Today's Agenda:
   1. Lecture: 
      - Instruction Set Architecture Part II
      - Processes

   1. Lab:
      - Intro to Control Flow
      - Java --> Java_tac --> mips:  min, max


## Questions from Last Lecture/Lab, etc.:
   * M/W @ 10:00 am
     - No Questions..

     ```text
     Bad news is Good news,
       Good news is No news, 
         No news is Bad news
     ```

   * T/R @ 10:00 am



## Review from Last-time:
### Monday's Class
  1. Instruction Set Architectures (ISA)
     1. Instructions: defined list of instructions with syntax and semantics 
     2. Data Types: support by the hardware
        - BCD: Binary Coded Decimals
          - not supported by MIPS (RISC)
          - and supported by x86  (CISC)
     3. Registers: 
        - names, number, size, and purpose
     4. Memory Organization: 
        - layout, length & width (size), address, endianness
     5. OS Interface
        - the rules or protocol to talk the OS

 1. Terms:
     - PC: program counter
     - IR: instruction register
     - lo: special register for multiplication and division
     - hi: special register for multiplication and division
     - memory: an array of bytes

  1. Generalized Execution Cycles
     1. Fetch:   reads from memory 1 instruction and puts into the IR
     2. Decode:  examines the IR and sets a but of switches
     3. Execute: forces the ALU to perform an evaluation 
     4. Write Back: puts the results from the ALU and places into onto
        - the memory
        - the output file

  1. MIPS Execution Cycles
     1. Fetch:
     2. Decode:
     3. Execute:
     4. Memory Access: 
        - puts the results from the ALU into memory, or
        - reads from memory
     5. Write Back:
        - writes the result from:
          1. the ALU, or
          1. the memory
        into a register

   1. RISC versus CISC
      - two approaches to designing a computer chip
      1. RISC: provide less instruction in favor of ....
      1. CISC: provide less of ..... in favor of more Complex instructions

   1. MIPS: Microprocessor without Interlock Pipelined Stages
      - executes up to 5 instructions at a time in pipelined fashion

### Tuesday's Class
 

---
# Today's Lecture Material

  1. See Slides
     -  models-comp-comm/slide*/instruction-set-architecture.pdf 
     -  ~models-comp-comm/slide*/process.pdf~


# Today's Lab Material

  1. Intro to Control Flow
     - assembly-programming/slide_presentations/intro_to_control_flow.pdf

  1. The declaration for min, max, average
     ```java
     // type signature
     public static int min(int a, int b);
     public static int max(int first, int second);
     ```

     ```mips
                .text
                .globl min     # int <- int x int
                               # $v0 <- $a0 x $a1

                .text 
                .globl max     # int <- int x int
                               # $v0 <- $a0 x $a1
     ```
  1. The definition of min and max

     1. Java's min
     ```java
     {
         int min;
         min = 0;
         
         if (a <= b) {
            min = a;
         } else {
            min = b;
         }
         return min;
     }
     ```

     1. Java's max
     ```java
     {
        int max; 

        max = 0;
        if (a <= b) {
          max = b;
        } else {
          max = a;
        }
        return max;
     }
     ```

     1. Java's average
     ```java

     ```

     1. Java-tac
        - see: assembly_programming/code_09_18/max.j
        - see: assembly_programming/code_09_18/min.j
        - see: assembly_programming/code_09_18/average.j
     1. mips
        - see: assembly_programming/code_09_18/max.s
        - see: assembly_programming/code_09_18/min.s
        - see: assembly_programming/code_09_18/average.s     

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
     * {cond}: the line of code that contains: `if ( a <cond> b)`
     * {cons}: the consequence code block for the `if-then-else` statement
     * {alt}:  the alternative code block for the `if-then-else` statement
     * {done}: the statement after `if-then-else` statment
     

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


