# COMP122 Lecture Notes: September 25, 2024

## Announcements:
   1. Quiz: 10-
      - End of this week (Sept 27)
      - Released at 6:00pm on Sept 27
        * URL Inviation linke posted on #fitzgerald-f24
      - Closed at  12:00pm on Sept 29
      - Timelimit: 60 minutes.
        * you are responsible for timing yourself
      - DRES accomodations:
        * make sure you inform me out of band

## Today's Agenda:
   1. Lecture: 
      - CLI and processes

   1. Lab:
      - Loop Transformation into Java TAC
      - Loop Translitertion into MIPS


## Questions from Last Lecture/Lab, etc.:
   * M/W @ 10:00 am
     - 

   * T/R @ 10:00 am
     - 

## Review from Last-time:

### MW's Class

### TR's Class


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

  1. A For-Loop Example with and without macros
     ```java
     public static int count_down(int top) {

        for (int c=top ; c>0; c--) {
           System.out.printf("%d\n", c);
        }
        System.out.printf("!\n");
        return top; 
     }
     ```

     - modified to use syscall macros
     ```java
     public static int count_down(int top) {

        for (int c=top ; c>0; c--) {
           mips.print_d(c);
        }
        mips.print_ci('!');
        mips.print_ci('\n');
        return top; 
     }
     ```  
  1. Control Flow Graph of a `while` loop
     - reference/TAC_transformation/for-loop.png

  1. Loop Transformation into Java TAC
     ```java tac
     ```

  1. Loop Translitertion into MIPS
     ```mips
     ```

  1. Examples: ( see assembly_programming/code_09_25/* )
     - multiplication of _N_ & _M_ via iteration
     - sum over 1 .. _N_
     - factorial of _N_

---
## Resources
   * reference/TAC_transformation/for-loop2TAC.md
   * reference/TAC2mips.md


### TAC2mips.md (Here is a subset)

   * Predefined Subroutines and Associated Macros
     1. Output Routines
   
        | Java TAC                      | MIPS Macro                |
        |-------------------------------|---------------------------|
        | `mips.print_d(a);`            | `print_d(a)`              |
        | `mips.print_di(imm);`         | `print_di(imm)`           |
        | ...                           |                           |
   
        * See [print_routines.md](./print_routines.md)
   
     1. Input Routines
   
        | Java TAC                      | MIPS Macro                |
        |-------------------------------|---------------------------|
        | `mips.read_d();`              | `read_d()`                |
        | `mips.read(fd, buff, imm);`   | `read(fd, buff, imm)`     |
        | ...                           | ...                       |
   
        * See [read_routines.md](./read_routines.md)

  * Loop Statements: 
    * Reference labels
      * {init}: the block of code that is executed prior to loop
      * {loop}: the line of code containing the keyword for the loop: do, while
      * {body}: the body of a loop
      * {done}: the statement after the loop

  | TAC Control Flow                  | MIPS Instruction           |
  |-----------------------------------|----------------------------|
  | `label: ;`                        | `label: nop`               |
  | `continue label;`                 | `b label`                  |
  | `break label;`                    | `b {done}`                 |
  |                                   |                            |
  | `for(; a <cond> b ;) {`           | `b<! cond> a, b, {done}`   |
  | `while(a <cond> b) {`             | `b<! cond> a, b, {done}`   |
  |                                   |                            |
  | `for(; a <cond> b ;) {`           | `b<cond> a, b, {body}`     |
  |                                   | `b {done}`                 |
  |                                   |                            |
  | `do {`                            | `nop`                      |
  | `} while ( a <cond> b ){`         | `b<cond> a, b, {loop}`     |


  * If-then-else Statements:

    * Reference labels
      * {init}: the statement *BEFORE* the `if-then-else` statement
      * {cond}: the line of code that contains: `if ( a <cond> b)`
      * {cons}: the consequence code block for the `if-then-else` statement
      * {alt}:  the alternative code block for the `if-then-else` statement
      * {done}: the statement *AFTER* the `if-then-else` statement
     

  | TAC Control Flow                  | MIPS Instruction           |
  |-----------------------------------|----------------------------|
  |                                   |                            |
  | `label: ;`                        | `label: nop`               |
  | `break label;`                    | `b {done}`                 |
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
  | `>`          | `gt`          | `le`            |  `<=`         |
   

---
<!-- This section for student's to place their own notes. -->
<!-- This section will not be updated by the Professor.   -->

## Notes  


