# COMP122 Lecture Notes: September 18, 2023

## Announcements:
   1. Assignment: Mathematical Review (Credit/No Credit)
      - Grade!

   1. Assignment: PEMDAS and TAC
      - Status: assigned
      - Deliverable ID: 41
      - Invitation URL: https://classroom.github.com/a/aHiTCHuq
      - Due Date: Sep 19 23:59:59  (Tuesday)
      - Time will be given in Today's Lab to work on it.

   1. Potential Quiz this weekend.
      - You are given a 48 hour window
      - You are given a 1 hour time limit
      - You must use your notes, my notes, and my slides during the quiz

      1. Review: Walk through on how to do a paper-like assignment
         - accept invitation
           * assignments.md
           * pinned in slack
           * in the announcement section of the class notes
         - copy your repository's URL
           * git@github.com/COMP122/{id}-{assignment}-{account}.git
           * git@github.com/COMP122/02-mathematical-review-smf-steve -- as an example!
         - clone your repository
           * cd ~/classes/comp122/deliverables
           * git clone git@github.com/COMP122/{id}-{assignment}-{account}.git
         - start the assignment
           * cd {id}-{name}-{account}
           * cp assignment.md submission.md
           * git add submission.md
           * git commit -m 'initial copy'
         - work on the assignment
           * subl submission.md
           * git commit -a -m 'updated message'
           * git pull ; git push
           * REPEAT




## Today's Agenda:
   1. Lecture:  Complete slides on Models
      - models-comp-comm/slide*/instruction-set-architecture.pdf
      - models-comp-comm/slide*/processes.pdf

   1. Lab: 
      - PEMDAS and TAC Laboratory Assignment



## Questions from Last Lecture/Lab, etc.:
   * M/W @ 9:00 am
     - Universal Computer ?
     - Layers differences between OSI  & TCP/IP models
     - Why OS is different from the User code in Universal Computer
     
   * T/R @ 9:00 am


## Review from Last-time:

   


---
# Today's Lecture Material

  1. Instruction Set Architecture
  1. Processes

# Today's Lab Material
  1. Practicum on PEMDAS and MIPS
     - see addendum_09_13_M1.md, addendum_09_13_M2.md, addendum_09_13_T.md
     
       1. X = (a + b) * (a - b)
       2. Y = b + 2 * c + 4
       3. Z = a / b + (b + 2) / b

     - Process:
       1. write java subroutine, test
       1. rewrite java subroutine to be strictly TAC, test
       1. transliterate java to MIPS, test

  1. Laboratory Assignment
     - Read "README.md"
     - Use the same process I used in class that week  (see line 75)

---
## Resources
  1. reference/TAC2mips.md   (Here is a subset)

      | TAC Equations                 | MIPS Instructions         |   
      |-------------------------------|---------------------------|
      | `return a`                    | `move $v0, a`             |
      |                               | `jr $ra`                  |


      | TAC Equations                 | MIPS Instructions         |
      |-------------------------------|---------------------------|
      | `;`                           | `nop`                     |
      | `x = imm;`                    | `li x, imm`               |
      | `x = - a;`                    | `sub  x, $zero, a`        |
      | `x = a;`                      | `move x, a`               |
      | `x = a <op> b;`               | `<op> x, a, b`            |
      | `x = ~ a`                     | `nor x, a, $zero`         |

     - Java Instructions with two variables: `x = a <op> b;`
       - `MIPS <op>  <- Java operator`
         * add: +, sub: -, or: |, and: &, xor: ^,


      | TAC Mult / Div Equations      | MIPS Instruction          |
      |-------------------------------|---------------------------|
      | `x = a * b;`                  | `mult a, b`               |
      |                               | `mflo x`                  |
      |                               |                           |
      | `x = a / b;`                  | `div a, b`                |
      |                               | `mflo x`                  |
      |                               |                           |
      | `x = a % b;`                  | `div a, b`                |
      |                               | `mfhi x`                  |
      |                               |                           |

      | TAC Mult/Div Pseudo Equations | MIPS Instruction          |
      |-------------------------------|---------------------------|
      | `x = a * b;`                  | `mul x, a, b`             |
      | `x = a / b;`                  | `div x, a, b`             |
      | `x = a % b;`                  | `rem x, a, b`             |




---
<!-- This section for student's to place their own notes. -->
<!-- This section will not be updated by the Professor.   -->

## Notes  


