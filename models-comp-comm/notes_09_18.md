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
      - Java --> Java_tac -- mips:  min, max


## Questions from Last Lecture/Lab, etc.:
   * M/W @ 10:00 am


   * T/R @ 10:00 am



## Review from Last-time:
### Monday's Class

### Tuesday's Class
 

---
# Today's Lecture Material

  1. See Slides
     -  models-comp-comm/slide*/instruction-set-architecture.pdf 
     -  models-comp-comm/slide*/process.pdf


# Today's Lab Material

  1. Intro to Control Flow
     - assembly-programming/slide_presentations/intro_to_control_flow.pdf

  1. The declaration for min and make
     ```java
     public static int min(int a, int b);
     ```

     ```mips
                .text
                .globl min     # int x int -> int
     ```
  1. The definition of min and max

     1. Java
     ```java

     ```

     1. java_tac
     ```java

     ```

     1. mips
     ```
     ```
---
## Resources
   * reference/TAC_transformation/if-then-else2TAC.md
   * reference/TAC2mips.md

### TAC2mips.md (Here is a subset)
   * If-then-else Statements:

   * Reference labels
     * {cond}: the line of code that contains: `if ( a <cond> b)`
     * {cons}: the consequence code block for the `if-then-else` statement
     * {alt}:  the alternative code block for the `if-then-else` statement
     * {done}: the statement after `if-then-else` statment
     

  | TAC Control Flow                  | MIPS Instruction           |
  |-----------------------------------|----------------------------|
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
  | `>`          | `gt`          | `le`            |  `>=`         |
   

---
<!-- This section for student's to place their own notes. -->
<!-- This section will not be updated by the Professor.   -->

## Notes  


