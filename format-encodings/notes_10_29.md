# COMP122 Lecture Notes: October 29, 2023

## Announcements:
   1. Assignment 24-bitwise-operations graded.
   1. Assignment 42-checksum graded.
      - Noted Items:
        1. large number of students (18) did not attempt
        1. scores greater than 90: 33 == 42%
        1. not following the process
           - Java --> Java TAC --> MIPS
        1. register allocation in Java TAC --- Don't do
        1. readability of code
           - direct correlation between   "working code <- and -> readable code"
           - check your tab versus spaces setting.
        1. not following directions associated with tags


   1. Assignment 25-binary to be released.
      https://github.com/COMP122/binary-addition/blob/main/assignment.md



## Today's Agenda:
   1. Review from 10/25/2023

   1. Strings and Arrays

   1. [String Processing](https://docs.google.com/presentation/d/1fg9BuWtyZ9PARK0gDE5ZcbjOiudRSrVP2s1iuSIDYXw/edit#slide=id.g199d0a137fe_0_29)

   1. Macros for ASCII Chars (https://www.javatpoint.com/java-string-touppercase)

   1. Conversion ASCII -> Binary


## Questions from Last Lecture/Lab, etc.:
   * M/W @ 9:00 am
     - no questions...


   * T/R @ 9:00 am


---
# Today's Lecture Material
  1. Arrays

  1. String Processing

  1. Java Strings: three independent types
     1. A string is an object that contains an array of characters
     1. A string is an constant array of characters 
     1. A char[] is a fixed sized array of characters

     ```java
      String O = new String( "A string!"); // An object
      String S = "A string!";              // A constant array (+ stuff?)
      char[] A = S.toCharArray();          // An array 
      
      int l    = A.length;                 // A property: Computed or Stored?
      int l    = S.length();
      ```

   1. Generalized Structure of a String:
      - See the Drawing on the Board!


   1. MIPS Declaration of a String
      ```mips
             .data
      A:     .ascii "A str"
      B:     .ascii "ing!"
             .asciiz "\n"
      Big:   .space 10
      Ints:  .word 4, 5, 6, 7
      ```


   1. Java: A.length  versus  C: strlen(char * A)
      - man strlen
      - man -k string | grep ^str

      ```java
      for(i=0; A[i]!='\0'; i++){
        ;
      }
      
      return i;
      ```

      ```java tac
      init:   ;
              i=0;
              $l = A[i];
              $r = '\0';
      fruit:  for(; $l != $r ;){
      body:       ;
                  ;
      next:       ;
                  i++;
                  $l = A[i];
                  continue fruit;
              }
      done:   ;
      
      return i;  

      ```

      ```mips

      .macro inc(%r)
         addi %r, %r, 1
      .end_macro

      # a0: A
      # t0: A
      # t1: i
      # t2: $l
      # t3: $r
      # t9: just a temp

             # de-marshal args
             move $t0, $a0

      init:  nop                 #  ;
             li $t1, 0           #  i=0;
             la $t9, A           #  $l = A[i];
             add $t9, $t9, $t1
             lbu $t2, 0($t9)

             li $r, '\0'         #  $r = '\0';
      fruit: beq $t2, $t3, done  #  for(; $l != $r ;){
      body:    nop               #      ;
               nop               #      ;
      next:    nop               #      ;
               inc($t1)          #      i++;
               la $t9, A         #  $l = A[i];
               add $t9, $t9, $t1
               lbu $t2, 0($t9)
            b fruit              #      continue fruit;
                                 #  }
      done:  nop                 #  ;
      
             move $v0, $t1       #  return i;  
             jr $ra

      ```

   1. Array Indexing
      - x = A[imm]
 
        - load the address of A into a register
          - `la $t0, A`
        - "load" "byte" into the register
           - lbu x, imm($t0)

      - x = A[i]
        - load the address of A into a register
          - `la $t0, A`
        - modify the address to be A[i]'s address
          - add $t0, $t0, i
        - "load" "byte" into the register
           - lbu x, 0($t0)

   
   | TAC String Equations          | MIPS Instruction          |
   |-------------------------------|---------------------------|
   | `x = A[imm];`                 | `la p, A`                 |
   |                               | `lbu x, imm(p)`           |
   |                               |                           |
   | `x = A[v];`                   | `la p, A`                 |
   |                               | `add p, p, v`             |
   |                               | `lbu x, 0(p)`             |
   |                               |                           |
   | `A[imm] = x;`                 | `la p, A`                 |
   |                               | `sb x, imm(p)`            |
   |                               |                           |
   | `A[v] = x;`                   | `la p, A`                 |
   |                               | `add p, p, v`             |
   |                               | `sb x, 0(p)`              |
   |                               |                           |
   | `p = & A;`                    | `la p, A`                 |
   | `x = (* p);`                  | `lbu x, 0(p)`             |
   | `(* p) = x;`                  | `sb x, 0(p)`              |

 
  1. [String Processing](https://docs.google.com/presentation/d/1fg9BuWtyZ9PARK0gDE5ZcbjOiudRSrVP2s1iuSIDYXw/edit#slide=id.g199d0a137fe_0_29)


  1. Practicum:  strchr()
     - Prototype: `char[] strchr(char[] A, int c);`
     - Description: locate a char in a string

       ```java
          match:  for(i=0; A[i]!='\0'; i++) {
                    if (A[i] == c) {
                      break match;
                    }
                  }
       ```      

       ```java TAC
               i=0;
               $l = A[i];

       match:  for(; $l != '\0' ;) {
                    if ($l == c) break match;
                    i++;
                    $l = A[i];
                    continue match;
               }
       done:
       ```

       ```mips
                # a0: &A
                # a1: c
                # t0: &A
                # t1: c
                # t2: i
                # t3: $l
                # t9: temp

                li $t2, 0              # i=0;
                add $t9, $t0, $t2      # $l = A[i];
                lbu $t3, ($t9)   

       match:   beq $t3, $zero, done   # for(; $l != '\0' ;) {
                beq $t3, $t1, done     #     if ($l == c)  break match;
                                       #    
                  inc($t2)             #     i++;
                  add $t9, $t0, $t2    #     $l = A[i];
                  lbu $t3, ($t9)              
                b match                #      continue match;
                                       # }
       done:    nop
       ```

  
   1. Macros: for ASCII https://www.javatpoint.com/post/java-character
      - init isLowerCase(c)

      ```java
      public static int isLowerCase(char c) {
        if ( 'a' <= c && c <= 'z') return 0;

        return 1;
      }

      ```
      - isPunctuation 
      ```java
      public static int isPunctuation(char c) {
        switch (c) {
           case '?':
           case ',':
           case '.':
              return 0;
              break;
        }

        return 1; 
      }
      ```


      - isUpperCase
      - isDigit
      ```java
      public static int isDigit(char) {
        if ( '0' <= c && c <= '9') return 0;
        return 1;
      }
      ```

      - isLetter
      ```java
      public static int isLetter(char c) {
        if (isUpperCase(c)) return 0;
        if (isLowerCase(c)) return 0;

        return 1;
      }
      ```

      - toUpperCase
      ```java
      public static char toUpperCase(char c) {
        if (! isLower(c) ) return '\0';

        return  c - 'a'  + 'A';
      }
      ```

      - toLowerCase
        ```java
        public static int toLowerCase(char c) {
          if (! isUpperCase(c))  return -1;

          return c - 'A' + 'a'; 
        }
        ```

   1. Conversion ASCII -> Binary
      - man atoi
      - isHexDigit()
        ```java
        public static int isHexDigit(char x) {
          
          if ('0' <= c && c  <= '9' ) return 0;
          if ('a' <= c && c  <= 'f' ) return 0;
          if ('A' <= c && c  <= 'F' ) return 0;
          return 1;
        }
        ```
      - inRange(x, lower, upper)


      - HexValue
      ```java
      public static int HexValue(char d) {
        value = -1;  // default: not a hex digit

        // Update the following code to work correctly
        if ('0' <= c && c  <= '9' ) value = 0;
        if ('a' <= c && c  <= 'f' ) value = 0;
        if ('A' <= c && c  <= 'F' ) value = 0;

        return value; 
      }
      ```


---
## Resources

   | TAC String Equations          | MIPS Instruction          |
   |-------------------------------|---------------------------|
   | `x = A[imm];`                 | `la p, A`                 |
   |                               | `lb x, imm(p)`            |
   |                               |                           |
   | `x = A[v];`                   | `la p, A`                 |
   |                               | `add p, p, v`             |
   |                               | `lb x, 0(p)`              |
   |                               |                           |
   | `A[imm] = x;`                 | `la p, A`                 |
   |                               | `sb x, imm(p)`            |
   |                               |                           |
   | `A[v] = x;`                   | `la p, A`                 |
   |                               |                           |
   |                               | `add p, p, v`             |
   |                               | `sb x, 0(a)`              |
   |                               |                           |
   | `x = & A;`                    | `la x, A`                 |
   | `x = (* p);`                  | `lb x, 0(p)`              |
   | `(* p) = x;`                  | `sb x, 0(p)`              |



<!-- This section for student's to place their own notes. -->
<!-- This section will not be updated by the Professor.   -->

## Notes  


