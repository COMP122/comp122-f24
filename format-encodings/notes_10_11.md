# COMP122 Lecture Notes: October 11, 2023

## Announcements:

1. Name: Base Conversion and Floating Point Representation
   - Status: Released
   - Deliverable ID: 23-
   - Invitation URL: https://classroom.github.com/a/hVsevPB0
   - Due Date: Oct 15 23:59:59 (Sunday)
 
 1. Name: Bitwise Operations
   - Status: Released
   - Deliverable ID: 24-
   - Invitation URL: https://classroom.github.com/a/iMnfacqu
   - Due Date: Oct 17 23:59:59 (Tuesday)

1. Assignment: binary32 
   - Status: Reviewed In Class
   - Deliverable ID: 43
   - Template URL: https://github.com/COMP122/43-binary32
   - Invitation URL: TBP [To Be Provided] on Friday!
   - Due Date: Oct 19 23:59:59 (Thursday)

1. Tool Developed by former students of COMP122
   - conversion between different bases
   - https://www.csun.edu/~steve/classes/integers-conversion-encoding/integer-conversion.html

      
## Today's Agenda:
   1. Bitwise Operations: bitwise-operations.pptx 
   1. Tidbit on Merge Conflicts

   1. Binary32 Encoding Algorithm Review

   1. Practicum in Binary32 Decoding


## Questions from Last Lecture/Lab, etc.:
   * M/W @ 9:00 am
     - \*.class files don't put into rep ... why?
     - a += 3;  -->  a = a + 3;  addi $X, $X, 3

   * T/R @ 9:00 am
     - no questions, no answers!


---
# Today's Lecture Material
  1. Bitwise Operations: bitwise-operations.pdf


# Today's Lab Material
  1. Binary32 Encoding: Review

  1. Practicum: Binary32 Decoding
     - separating the pieces
     - repositioning the pieces
     - outputting the pieces

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


