# COMP122 Lecture Notes: September 25, 2024

## Announcements:
   1. Quiz: 10-
      - Follow the process, it is part of the quiz
        - name, account, add, commit, push
        - subsequent iterative commits at least 6 commits
        - `make validate`
      - Released at 6:00pm on Sept 27 (Friday)
        * URL Invitation link posted on #fitzgerald-f24
      - Closed at 11:59 pm on Sept 29 (Sunday)
      - Time limit: 60 minutes.
        * you are responsible for timing yourself
      - DRES accommodations:
        * make sure you inform me out of band

## Today's Agenda:
   1. Lecture: 
      - CLI and processes

   1. Lab:
      - Loop Transformation into Java TAC
      - Loop Transliteration into MIPS


## Questions from Last Lecture/Lab, etc.:
   * M/W @ 10:00 am
     - 

   * T/R @ 10:00 am
     - public/private key (PKI) -- ssh uses it.


## Review from Last-time:

### MW's Class
  1. Interrupts and Traps
     - interrupt its an asynchronous event
     - trap its a synchronous event
  1. System Calls (e.g., read) 
     - its a trap
  1. Process Status Diagram: 
     - example of FA(Q, \Sigma, q0, F)
       1. Q is the set of states
       1. \Sigma input alphabet (aka the transition)
       1. q0: the initial state
       1. F is a set of state that are deemed final
     - transitions: members of \Sigma
       1. admit
       2. dispatch
       3. interrupt
       4. trap
       5. completion
       6. exit 
     - states: members of `Q`
       1. new
       2. wait
       3. running
       4. blocked
       5. terminate 

   1. lval and rval
      - memory is an associate array
        - each element in the array has
          1. an address (aka the lval)
          1. a value associated with the element (aka the rval)
          1. zero or more labels (i.e., names)

      - lval is the address of a variable of memory
      - rval is the value associated with the address in memory 

   1. pointers: its an address, which means it stores an lval
   1. &, and \*:  
      - &: go lookup the lval
      - \*: use the rval of variable as an lval and then get get the value.

   1. Process:
      1. a file of instructions (i.e., program)
      1. set of I/O files, at least three
         0.  stdin, System.in
         1.  stdout, System.out
         2.  stderr, System.err
      1. an environment: an associative array  
      1. a return value or exit value,  `echo $?`  

### TR's Class
   1. FA: a 4-tuple (Q, \Sigma, q0, F)
      - PSD as example: Process Status Diagram 
        - modules the state of *ALL* processes managed by the OS
        - 5 states
          1. N: new
          2. W: wait
          3. R: running
          4. T: terminate
          5. B: blocked
        - 6 elements of the alphabet
          1. admit
          2. dispatch
          3. exit
          4. interrupt
          5. trap
          6. i/o complete / service complete / trap complete
    1. interrupts: typically generated outside your process
       - asynchronous..
       - OS seizes control 
       - example:
         ```
         My program makes a request to the OS to set a timer.  -- that is a trap.
         When the timmer goes off -- that is interrupt.
         ```
    1. trap: generated inside your process
       - synchronous..
       - yield control back to the OS

    1. Combination Circuit versus Sequential Circuit
       - base upon 3 functions: and, or, not
       - Combinational Logic
         - combine the gates in a multitude of ways -- equivalent Boolean Algebra
       - Sequential Circuit
         Combinational Circuit + Time + State 
       - Feedback Loops provides a way to store info (i.e. state)
    1. Memory
       - array of bytes
       - Index arrays, and Associative arrays     (lval & rval)
         - Index: A[x] = v ;    v = A[x];  where x = 0, 1, ... max_int
         - Associative:   A["label"] = v ; v = A["label"]
       - an associative array of bytes at the ISA layer
       - an index array of bytes at the physical layer
    1. Label: associated with one byte in memory
       - lval: the address
       - rval: the valued stored at that address
         ```
         x = x + 1;
         ```
    1. process
       1. environment
       1. files
       1. instructions/code
       1. return value / exit value

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
           mips.print_ci('\n')
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
     public static int count_down(int top) {
                 int c;

         init:   ;
                 c=top;

         kevin:  for (; c>0; ) {
         bd:        ;
                    mips.print_d(c);
                    mips.print_ci('\n')
         nt:        ;
                    c = c - 1 ;   // c--;
                    continue kevin;
                 }
         dn:     ;

                 mips.print_ci('!');
                 mips.print_ci('\n');


                 return top; 
     }
     ```

  1. Loop Transliteration into MIPS
     ```mips
                   .text
                   .globl count_down


      count_down:  nop                        # public static int count_down(int top) {
             # v0: {return value}
             # a0: top

             # t7: c                          # int c;

         init:     nop                        # ;
                   move $t7, $a0              # c=top;

         kevin:    ble $t7, $zero, done       # for (; c>0; ) {

         bd:       nop                        #    ;
                   print_d($t7)               #    print_d(c);
                   print_ci('\n')             #    print_ci('\n')


         nt:       nop                        #    ;
                   subi $t7, $t7, 1           #    c = c - 1 ;   // c--;
                   b kevin                    #    continue kevin;
                                              # }
         dn:       nop                        # ;

                   print_ci('!')              # print_ci('!');
                   print_ci('\n)              # print_ci('\n');

                 
                   move $v0, $a0              # return top; 
                   jr $ra
                                              #}
     ```

  1. Examples: ( see assembly_programming/code_09_25/* )
     - factorial of _N_
     - multiplication of _N_ & _M_ via iteration
     - sum over 1 .. _N_

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


