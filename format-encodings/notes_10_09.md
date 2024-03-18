# COMP122 Lecture Notes: October 09, 2023

## Announcements:

   1. Assignment: quiz-models
      - Status: Graded
      - Average: 78

      
## Today's Agenda:
   1. Random view of quiz submissions

   1. Floating Point Encoding: floating-point-encoding.pptx

   1. Bitwise Operations: bitwise-operations.pptx 



## Questions from Last Lecture/Lab, etc.:
   * M/W @ 9:00 am
     - Can I commit to the comp122 repository
       - yes, but you need to address merge conflicts
       - yes, but you CAN NOT push to the remote repo

   * T/R @ 9:00 am
     - How to rewrite IF-then-else --> TAC
     - Question on README.md
       - difference between header_checksum and checksum in the algorithm




---
# Today's Lecture Material
   1. Random view of quiz submissions
      - view_random_submission.bash  10-quiz-models
        - Proper Rendering:  open submission.md
        - Proper Editing:    subl -n submission.md
        - Just the reponses: make

  1. Floating Point Encoding: floating-point-encoding.pdf
  1. Floating Point Encoding (encode_float.mdf)
  <!--
  1. Bitwise Operations: bitwise-operations.pdf
  -->

# Today's Lab Material
  1. Field Questions on Checksum Project
     - slide_presentation/checksum.pdf
     - for-loop --> for-loop TAC  -> MIPS
     - * register book keeping, with multiple use of a register
     - * mips.read_d() in JAVA
     - * in MIPS, proper way to compare if (X == 2)

  1. Review of Floating Point Assignment
     - https://github.com/COMP122/floating-point-encoding/blob/main/assignment.md
     - Note this above URL is associated with a private repository
  
  <!--    
  1. TAC for Shift Instructions
     - mips_cli

  1. Floating Point algorithm 
  -->    

---
## Resources


   | TAC Equations                 | MIPS Instructions         |
   |-------------------------------|---------------------------|
   | `;`                           | `nop`                     |
   | `x = imm;`                    | `li x, imm`               |
   | `x = - imm;`                  | `subi x, $zero, imm`      |
   | `x = - a;`                    | `sub  x, $zero, a`        |
   | `x = a;`                      | `move x, a`               |
   | `x = a <op_i> imm; `          | `<op_i> x, a, imm`        |
   | `x = a <op> b;`               | `<op> x, a, b`            |

      
   | `x = ~ a;`                    | `nor x, a, $zero`         |
   | `x = a >>> imm;`              | `srl x, a, imm`           |
   | `x = a >> imm;`               | `sra x, a, imm`           |
   | `x = a << imm;`               | `sll x, a, imm`           |
   | `x = a >>> b;`                | `srlv x, a, b`            |
   | `x = a >> b;`                 | `srav x, a, b`            |
   | `x = a << b;`                 | `sllv x, a, b`            |


---
<!-- This section for student's to place their own notes. -->
<!-- This section will not be updated by the Professor.   -->

## Notes  


