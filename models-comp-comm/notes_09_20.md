# COMP122 Lecture Notes: September 20, 2023

## Announcements:
   1. Quiz Postponed 1 week.
      - You now have more time to study.
      - Actually, no you don't
        - You are going to procrastinate!

  1. Assignment: practice-quiz-models
      - Status: assigned
      - Deliverable ID: 11
      - Invitation URL: https://classroom.github.com/a/OJbdrx3r
      - Due Date: Sep 24 23:59:59  (Sunday)
      - It's a practice quiz -- time yourself

## Today's Agenda:
   1. Lecture:  Processes
      - models-comp-comm/slide*/process.pdf

   1. Lab: 
      - assembly/slide*/intro_control_flow.pdf


## Questions from Last Lecture/Lab, etc.:
   * M/W @ 9:00 am
     - can I submit multiple times: yes
     - starting of timing: upon accepting invitation
     - can I commit after the deadline: 
       * yes, but I am not _required_ to grade that version
     - how long to time for the practice quiz
       * the same amount of time as the real quiz: 1 hour


   * T/R @ 9:00 am
     - what is the ALU? arithmetic, logic, unit 



---
# Today's Lecture Material

  1. Processes
     - Files
       - Output redirection:  1>, 1>>, 2>, 2>>
         * ls > output 
         * ls >> output
       - Input redirection:   0<, 0<<, 0<<< 
         * cat < filename
         * sort <<EOF
           the input is between
           the first EOF and 
           the last EOF
           EOF
         * base64 <<< word
       - Pipelining: |
         * ls -R | sort | uniq -c | sort -n
     - Environment
       - printenv
       - export NAME=Value 
     - Return Information
       - echo $?
     - Command line execution
       - Sequential:  ;
         * git pull ; date ; git push ; date
       - Concurrently:    &
         * git pull & date & git push & date
       - Conditional:  &&, ||, 
         * git commit -m 'update' && echo success
         * git commit -m 'update' || echo failure


# Today's Lab Material
  1. Macros: (see slides)
     * mips/macros/stack.s     
     * mips/macros/syscalls
     * mips/macros/bit_manipulation.s 
     * mips/macros/subroutine.s    
  1. Discussion on Stacks
  1. Discussion on printf: reference/tidbits/print_routines.md 

  1. Control Flow
  1. Branch Instructions:
     - format:  `b<test> rs, rt, label`
     - tests: (see table below)
  1. Practicum on Macros and IF Statements
     - area of something -- review
     - min
     - max
     - abs
     - diff (difference)

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
        cons: a = a + 1;
        // goto next
      } else {
        alt: b = b - a;
        // goto next
      }
     next:  ; 
     ```

     ```mips
             # a0: a
             # a1: b

             blt $a0, $a1, alt        #  if ( a <= b ) {
     cons:     addi $a0, $a0, 1       #     cons: a = a + 1;
               b next                 #     // goto next
                                      #   } else {
     alt:      sub $a1, $a1, $a0      #     alt: b = b - a;
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
      * {test}: the conditional statement loop statement
      * {body}: the body of a loop
      * {done}: the statement after a control-flow statement

      | TAC Control Flow                  | MIPS Instruction           |
      |-----------------------------------|----------------------------|
      | `label: ;`                        | `label: nop`               |
      | `// goto label;`                  | `b label`                  |
      | `{`                               | ``                         |
      | `}`                               | ``                         |
      |                                   |                            |
      | `if (a <cond> b) {`               | `b<! cond> a, b, {alt}`    |
      |                                   |                            |        
      | `if (a <cond> b) {`               | `b<cond> a, b, {cons}`     |
      |                                   | `b {alt}`                  |
      |                                   |                            |
      | `if (a <cond> b) break;`          | `b<cond> a, b, {done}`     |
      |                                   |                            |
      | `} else {`                        | ``                         |
      | `}`                               | ``                         |
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


