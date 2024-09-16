# COMP122 Lecture Notes: September 15, 2024

## Announcements:
   1. Setup Issues: Got Any?
      - see previous notes and slack for fixes and work around
      - I presume everyone is all set.
   1. Bash -- still uncomforable
      - reference/bash.pdf
      - [Manual](https://www.gnu.org/software/bash/manual/bash.html)
      - [Lecture from MIT](https://missing.csail.mit.edu/2020/shell-tools/)
      - Shell Tools and Scripting: [Video](https://youtu.be/kgII-YWo3Zw)
   1. Sublime:
      - [Support](https://www.sublimetext.com/support)
      - [Unoffical Documentation](https://docs.sublimetext.io)
      - [Cheatsheet](https://linuxsimply.com/wp-content/uploads/2023/06/Sublime-Text-cheat-sheet-by-linuxsimply-1.pdf)
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
   1. Lecture: Instruction Set Architecture
      - See Slides

   1. Lab:
      1. Programming Assignment Overview
         - pickup where we left off -- if not done
         - MIPS code
         - quick review of Software Engineering workflow
         - time to complete your 04- assignment

## Questions from Last Lecture/Lab, etc.:
   * M/W @ 10:00 am
     - Questions on the quiz...
     - How to write test cases?


   * T/R @ 10:00 am



## Review from Last-time:
   1. Models of COMP
      - theoretical models:
        4. Turing Machine              Recursively Enumerable
        3. Limited Bounded Automate    Context Sensitive Language
        2. Push Down Automata          Context Free Language  
        1. Finite State Machine        Regular Expressions      
        ---             
        -1. Sequential Circuits        ---       
        -2. Combinational Logic        Boolean Algebra
   1. Universal Computer
      - variation of the Turing machine
      - Tape is cut on both sides (finite)
      - specialized control unit (firmware -- akin to the hardware)
      - Tape contains:
        - a generic program: (aka the Operating System)
        - a specialized program: (software you download, end-user program)
      - how powerful is the machine?
        - capable of computing anything that computable
        - (problem size is limited by the size of memory / tap)
   1. Notion of Correctness
      1. partially correct: provides the correct answer -- *when* it terminates
         - e.g., operating system
      2. totally correct: provides the correct answer - *and* it always terminates

   1. Abstract Architectures
      - von Neumann  : bottle neck between CPU and Memory
      - Harvard      : memory is split into Data and Instructions
   1. Physical Architecture
      - MIPS
      - ARM7 & ARM8
      - x86, `M[123]` 



---
# Today's Lecture Material

  1. See Slides
     -  models-comp-comm/slide*/instruction-set-architecture.pdf


# Today's Lab Material

  1. Programming Assignment Overview
     - URL: https://classroom.github.com/a/O4w6B-Ly
     - [Workflow cheatsheet](../reference/programming_workflow.md)

  1. Pickup where we left off -- if not done
     - MIPS code
     - quick review of Software Engineering workflow
     - time to complete your 04- assignment

---
## Resources
   * reference/git-cheatsheet.png
   * tidbits/git-notes.md
   * tidbits/tidbit-git-merge.md 

   * reference/TAC2mips.md   (Here is a subset)

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


