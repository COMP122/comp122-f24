# COMP122 Lecture Notes: September 25, 2023

## Announcements:
   1. Quiz This Weekend.
      - You now have more time to study.
      - Actually, no you don't
        - You are going to procrastinate!

  1. Assignment: practice-quiz-models
     - Status: past due
     - Due Date: Sep 24 23:59:59  (Sunday)

  1. Assignment: PEMDAS and 
     - Status:  almost graded

## Today's Agenda:
   1. New Section:  Formats and Encodings
      - classes/comp122/format-encodings

   1. Lab: 
      - Pickup where we left off.


## Questions from Last Lecture/Lab, etc.:
   * M/W @ 9:00 am
     - Can we get more information on a hub and switch?
     * Order of computational power of theoretical machines?
     - Difference between combinational and sequential circuits?
     * Difference between OS and kernel?
     - Can we use addi on the quiz?
     * Difference between mul & mult?


   * T/R @ 9:00 am
     - Difference between lval and rval?


---
# Today's Lecture Material

  1. Lecture Ordering:
     - format_encodings/lecture_ordering.md

  1. Introduction to Encodings: introduction-to-encodings.pptx
     - Up to ASCII characters 
     - Up to MIPS encoding



# Today's Lab Material
  1. Control Flow -- Quick Review
  1. Branch Instructions:
     - format:  `b<test> rs, rt, label`
       
       beq $t1, $t2, cons

     - tests: (see table below)

  1. Practicum on Macros and IF Statements
     - area of something -- review
     - min
     - max
     - abs
     - diff (difference)
     - sign
     - ascending swap

---
## Resources

  1. Example Mapping of an if-then-else statement

     ```java
     if ( a <= b ) {
       a = a + 1;
     } else {
       b = b - a;
     }
     ```

     ```java tac
            if ( a <= b ) {
     cons:    ;
              a = a + 1;
              // goto next;
            } else {
     alt:     ;
              b = b - a;
              // goto next;
            }
     next:  ; 
     ```

blt  "b"ranch "l"ess "t"han

     ```mips
             # a0: a
             # a1: b

             bgt $a0, $a1, alt        #  if ( a <= b ) {
     cons:     nop                    #     ;
               addi $a0, $a0, 1       #     a = a + 1;
               b next                 #     // goto next
                                      #   } else {
     alt:      nop                    #     ;
               sub $a1, $a1, $a0      #     b = b - a;
               b next                 #     // goto next
                                      #   }
     next:     nop                    #  next:  ; 


     ```

  1. reference/TAC2mips.md   (Here is a subset)

     | JAVA: MIPS OS Interface       | MIPS Macro                |
     |-------------------------------|---------------------------|
     | `mips.print_t(a);`            | `print_t(a)`              |
     | `mips.print_ti(imm);`         | `print_ti(imm)`           |
     | `mips.print_c(a);`            | `print_c(a)`              |
     | `mips.print_ci(imm);`         | `print_ci(imm)`           |
     |  See print_routines.md        | etc., etc., etc.,         |

  - Control flow labels
      * {cons}: the consequence for an if-then-else statement
      * {alt}:  the alternative for an if-then-else statement
      * {test}: the conditional statement of the loop statement
      * {body}: the body of a loop
      * {done}: the statement after a control-flow statement

      | TAC Control Flow                  | MIPS Instruction           |
      |-----------------------------------|----------------------------|
      | `label: ;`                        | `label: nop`               |
      | `// goto label;`                  | `b label`                  |
      | `{`                               |                            |
      | `}`                               |                            |
      |                                   |                            |
      | `if (a <cond> b) {`               | `b<! cond> a, b, {alt}`    |
      |                                   |                            |        
      | `if (a <cond> b) {`               | `b<cond> a, b, {cons}`     |
      |                                   | `b {alt}`                  |
      |                                   |                            |
      | `if (a <cond> b) break;`          | `b<cond> a, b, {done}`     |
      |                                   |                            |
      | `} else {`                        |                            |
      | `}`                               |                            |
      |                                   |                            |



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


