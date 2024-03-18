# COMP122 Lecture Notes: September 13, 2023

## Announcements:
   1. Assignment: Mathematical Review (Credit/No Credit)
      - Invitation URL: https://classroom.github.com/a/6Q0OrY44
      - Due Date: Sep 14 23:59:59

   1. Assignment: PEMDAS and TAC
      - Status: assigned
      - Deliverable ID: 41
      - Invitation URL: https://classroom.github.com/a/aHiTCHuq
      - Due Date: Sep 19 23:59:59  (Tuesday)

## Today's Agenda:
   1. Lecture:  Complete slides on Models
      - models-comp-comm/slide*/models.pdf

   1. Lab: 
      - review Intro to MIPS slides
        * assembly-programming/slide*/intro*.pdf
      - MARS walk through
      - Review PEMDAS and then MIPS transliteration


## Questions from Last Lecture/Lab, etc.:
   * M/W @ 9:00 am
     - 9's complement 
     - hexadecimal digits

   * T/R @ 9:00 am
     - no questions


## Review from Last-time:

   1. No input from Wednesday class.
   


---
# Today's Lecture Material

  1. See Slides:  Start with slide 10

# Today's Lab Material
  1. Review Slides: Introduction to MIPS Architecture

  1. Mars Walk through
     - tidbits/mars.md
     - reference/mars

  1. Practicum on PEMDAS and MIPS
     - see addendum_09_13_M1.md, addendum_09_13_M2.md, addendum_09_13_T.md
     
       1. X = (a + b) * (a - b)
       2. Y = b + 2 * c + 4
       3. Z = a / b + (b + 2) / b

     - Process:
       1. write java subroutine, test
       1. rewrite java subroutine to be strictly TAC, test
       1. transliterate java to MIPS, test


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


