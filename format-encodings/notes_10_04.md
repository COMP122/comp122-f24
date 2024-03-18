# COMP122 Lecture Notes: October 04, 2023

## Announcements:

   1. Assignment: Checksum
      - Status: Assigned
      - Deliverable ID: 42
      - Invitation URL: https://classroom.github.com/a/BlKyKwkj
      - Due Date: Oct 12 23:59:59  (Thursday)

   1. TAC2mips.md
      - print this file out
      - have it handing 
        - when I am doing a code demostration
        - when you are working on  `method.j` --> `method.s`

      
## Today's Agenda:
   1. Lecture --> Lab
      1. Review of the For-loop Transformation
         - Factorial
      1. make and makefile
      1. git tags

      1. Revised Factorial:  N!
         - read the value of N, from stdin

         - Java for COMP110, COMP182, COMP282

           * The following code is how you would typical read a value from stdin 
             ```java  
             import java.util.Scanner;

             //...

             Scanner stdin = new Scanner(System.in);
             int num = stdin.nextInt();
             ```

         - Java for COMP122
           * java_subroutine includes a class (mips) to make things easier for COMP122
           * The following code is how you do it in COMP122
              ```java
              mips.read_d()
              num = mips.retval()
              ```
              
         - Native MIPS
         ```mips
         .macro read_d()
           nop                     # Reads from stdin, a decimal (%d) number
           li $v0, 5
           syscall                 
           nop                     # The value is now in $v0
         .end_macro

         read_d()
         move num, $v0
         ```

   1. Lab:
      1. Checksum Practicum
         - slide_presentation/checksum.pdf
      1. Lab description
         - private template: https://github.com/COMP122/42-checksum
         - Invitation link: https://classroom.github.com/a/BlKyKwkj


## Questions from Last Lecture/Lab, etc.:
   * M/W @ 9:00 am
     - Clarification on use of .include
     - Can we do a double nested loop ?

   * T/R @ 9:00 am
     - none



---
# Today's Lecture Material

  1. Bitwise and/or Checksum  (see slides)
 

# Today's Lab Material
  1. Review For-loop Transformation


  1. Algorithm For-loop (aka structured while-loop) --> TAC Transformation
     1. But first, semantics of a for-loop
        ```java

        for( <init> ; <test> ; <next> ) {
           <body>
         }
        ```
        Is equivalent to:
        
        ```java
        <init>               // <init>
        for(; <test> ;) {    // while( <test> ){
           <body>            //   <body>
           <next>            //   <next>
         }                   // }
        ```


     1. Identify with labels the section of the loop
        - {init}: the initialization arm of the for-loop
        - {loop}: the line of code that contains
          `for( <init> ; <test> ; <next> ) {`
        - {body}: the body of the for-loop
        - {next}: the next arm of the for-loop
        - {done}: the first line of code executed after the for-loop

     1. Insert the {init} label, with a null statement, before the start of the for-loop
     1. Associate the {loop} label with `for( init ; test ; next ) {`
     1. Append the {done} label, with a null statement, after the end of the for-loop

     1. Insert the {body} label, with a null statement, at the top of the {body}
     1. Insert the {next} label, with a null statement, at the end of the {body}
     1. Append 'continue {loop};' to the end of of the {next} block

        * The resulting template before code movement

          ```java tac
          init:    ;
          loop:    for( <init> ; <test> ; <next> ) {
          body:       ;
                      <body>

          next:       ;

                      continue loop;
                   }
          done:    ;
          ```

     1. Move the init arm to the {init} block

     1. Move the next arm to the end of the {next} block

     1. Simplify the boolean expression into three parts
        - evaluate the left-hand side into $l
          - move the eval of $l into the {init} block
          - place a copy of the eval of $l at the end of the {next} block
            (but before the `continue {loop}`)
        - evaluate the righ-hand side into $r
          - move the eval of $r into the {init} block
          - place a copy of the eval of $r at the end of the {next} block
            (but before the `continue {loop}`)
        - replace the boolean expression with a simple test:  `$l <cond> $r`
          - yielding:    `loop: for(;  $l <cond> $r ;)`


  1. Example:
     - Factorial

  1. Practicum: Checksum
     - This is your lab!
     - Take good notes!
     - My notes will not be made available to you!

---
## Resources

  1. Example Mapping of an for-loop (a while loop in disguised): Count-down

     ```java
     top = 10;
     for( i=top; i > 0 ; i -- ) {
        mips.print_d(i);
     }
     ```

     ```java tac
             top = 10;

             i=top;

     loop:  for(; i > 0 ;) {
     body:      ;
                mips.print_d(i);

     next:      ;
                i --; 
                continue loop;  
             }
     done:   ;
     ```


  1. reference/TAC2mips.md   (Here is a subset)

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
       | `} else {`                        |                            |
       | `}`                               |                            |

       |                                   |                            |
       | `continue label;`                 | `b label`                  |
       | `break label;`                    | `b {done}`                 |
       |                                   |                            |
       | `for(; a <cond> b ;) {`           | `b<! cond> a, b, {done}`   |
       | `while(a <cond> b) {`             | `b<! cond> a, b, {done}`   |
       |                                   |                            |
       | `for(; a <cond> b ;) {`           | `b<cond> a, b, {body}`     |
       |                                   | `b {done}`                 |


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


