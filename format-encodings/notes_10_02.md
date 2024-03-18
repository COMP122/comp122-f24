# COMP122 Lecture Notes: October 02, 2023

## Announcements:
   1. Git Merge Conflicts
      - Such conflicts are common
        - changes you made versus changes made by others may induce conflicts
        - you are required to resolve conflicts as part of the development process

      - bin/MIPS_OS_Interface.class
        - I made updates to bin/MIPS_OS_Interface.java
        - Some students are running a different version of Java
        - If you have committed your version of bin/MIPS_OS_Interface.class, 
          a merge conflict will occur

      - to address this mismatch, you can do the following
      ```
      cd ~/classes/comp122
      git rm bin/MIPS_OS_Interface.class
      git commit -m 'removed .class file' 
      git pull
      ```

   1. Assignments:
      * Graded
        - 11-practice-quiz-models/
        - 41-pemdas-tac/
      * Due
        - 21-table-encodings: Oct 03 23:59:59 (Tuesday)
        - 22-utf-8: Oct 05 23:59:59 (Thursday)
    
## Today's Agenda:
   1. Lecture
      - Introduction to Numbering Systems

   1. Lab:
      1. Re-Review If-then-else --> TAC Transformation --> MIPS
      1. For-loop --> TAC Transformation --> MIPS
         - For-loop is just a well-structured while-loop

      1. Examples:
         1. Count down
         1. Summation


## Questions from Last Lecture/Lab, etc.:
   * M/W @ 9:00 am
     - Endian and it's affect
     - Universal Computer and two programs: OS and users
     - Markdown question on .png and then layout

   * T/R @ 9:00 am
     - How do ONE review the grade-report and use the grade_guessimator?


---
# Today's Lecture Material

  1. Introduction to Numbering Systems
     - introduction-to-numbering-systems.pdf
 

# Today's Lab Material
  1. Comment:  The defined process
     * Many students did not follow the process in 41-
     * Having your program yield the correct result is NOT sufficient.
     * Follow the process to ensure 
       - you are coach-able,
       - you know how to follow a specification,
       - you can deliver what is expected,
       - you can be successful as a CS/IT/SE Professional!

  1. Development Process:
     1. Write Java Subroutine: `method.j`
        - ensure that it is 100% correct
     1. Rewrite Java Subroutine into TAC style:  `method.`
        - ensure that it is 100% correct
        - ensure it it in PROPER TAC form
     1. Transliterate your Java subroutine into MIPS: `method.s`
        - Copy your `method.j` into `method.s`
        - Comment out your Java Code
        - Transliterate: line by line!
          ```
          {label}:      {mips instruction}       #  {java instruction}
          ```
        - If you have to do more than transliteration, 
          - your Java code is WRONG--even it generates the desired results!


  1. Review: Algorithm If-then-else --> TAC Transformation
     1. Identify the parts of the if-the-else statement
        * {test}: the boolean expression of the if-then-else
        * {cons}: the consequence code block for the if-then-else
        * {alt}:  the alternative code block for the if-then-else
        * {done}: the first line of code executed after the if-then-else

     1. Insert the {init} label, with a null statement, before the start of the if-then-else
     1. Append the {done} label, with a null statement, after the end of the if-then-else

     1. Insert the {cons} label, with a null statement, at top of the consequence code block
     1. Append '// goto {done};' to the end of consequence code block

     1. Insert the {alt} label, with a null statement, at top of the alternative code block
     1. Append '// goto {done};' to the end of consequence code block

        * The resulting template before code movement

          ```java tac
          init:    ;
                   if(  <test>  ) {
          cons:      ;
                     <consequence>
                     // goto done;
                    } else {   ;
          alt:       ;
                     <alternative>
                     // goto done;
                   }
          done:    ;
          ```

     1. Simplify the boolean expression into three parts
        - evaluate the left-hand side into $l
          - move the eval of $l into the {init} block
        - evaluate the righ-hand side into $r
          - move the eval of $r into the {init} block
        - replace the boolean expression with a simple test:  `$l <cond> $r`
          - yielding:    `if ( $l <cond> $r ) {`



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



  1. Examples on For Loop 
     - Count-down (see Resources below)
     - Summation
 
     * See addendum_10_02_* directories for the examples done in class.
     

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


