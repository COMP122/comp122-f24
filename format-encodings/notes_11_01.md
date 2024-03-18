# COMP122 Lecture Notes: November 1, 2023

## Announcements:
   1. Assignments

      1. Name: Binary Addition
         - Status: Assigned
         - Deliverable ID: 25
         - Invitation URL: https://classroom.github.com/a/xjTmuaU9
         - Due Date: Nov 07 23:59:59 (Tuesday)

      1. Name: nextInt (atoi)
         - Status: Assigned
         - Deliverable ID: 44
         - Invitation URL: https://classroom.github.com/a/9a7konBI
         - Due Date: Nov 10 23:59:59 (Friday)


## Today's Agenda:
   1. Review of Stuff

   1. {java, mips}\_subroutine use with strings

   1. strcat description

   1. Buffer Allocation:
       - static char [] buffer = new char[256];
       - buffer:  .space 256
       - sbrk($t0), sbrk(256)

   1. Practicum: strcat

   1. Lab time
      1. Conversion ASCII -> Binary


## Questions from Last Lecture/Lab, etc.:
   * M/W @ 9:00 am
     - How do I convert a int into a char in Java?
       - int x = 8;
       - char c = (char) x;

     - How do I convert a char into an int in Java?
       1. int x = (int) c;
       1. write code to do the mapping.

     - How do I do conversion from ASCII --> Binary
       (in various base)?   see the lab.

   * T/R @ 9:00 am
     - No questions for now!

---
# Today's Lecture Material

  1. Picture: 
     - MIPS memory Operation of an array

  1. String Methods:
     1. strlen()
        ```java
        public static int strlen(char [] A) {

           for(i=0; A[i]!='\0'; i++);
      
           return i;
        }
        ```

   1. strchr();
      - technically not correct: 
        * Java CAN'T return a substring 
        * Java Solution Method:  indexOf()

      ```java
      public static char[] strchr(char[] A, int c);`
         match:  for(i=0; A[i]!='\0'; i++) {
                   if (A[i] == c) {
                     break match;
                 }
                 return &(A[i]);       // Invalid Java
      }
      ```

      ```java
      public static int indexOf(char[] A, int c);`
         match:  for(i=0; A[i]!='\0'; i++) {
                   if (A[i] == c) {
                     break match;
                 }
                 return i;
      }
      ```


   1. {java, mips}\_subroutine use with strings

       ```java
       public static int hello(char [] input) {
       
          mips.print_s(input);
          return 0;
       
       }
       ```
       
       ```bash
       java_subroutine hello  "This is my string"
       java_subroutine -S hello  "456"
       ```

   1. strcat description

   1. Buffer Allocation:
       - static char [] buffer = new char[256];
       - buffer:  .space 256
       - sbrk($t0), sbrki(256)

   1. Practicum: strcat

   ```java
 
   ```


# Today's Lab Material

  1. Accept the assignment
  1. Clone the assignment
  1. Don't read the README.md file
     - it should contain the specification
     - it does not exist
     - it will be created later!

  1. Write a Java method
     - Name: public static int get_bit();
     - Arguments:  none
     - Description: 
       * reads a char from stdin
       * returns the value of the bit
     - Return Value: 
       *  0 : if the char == '0'
       *  1 : if the char == '1'
       * -1 : otherwise

   1. Review the slides from last week to find relevant material

   1. Write a Java method
      - Name: public static int bits2int();
      - Arguments: none
      - Description:
        * reads a sequence of bits (via 'get_bit')
        * converts this sequence into a base10 number
      - Return Value:
        * a base10 number


   1. Refactor your Java code to work for any base
      - may be restricted to: 2..10, and 16

      1. Refactor your get_bit() method to:
         - Name: public static int glyph2int(int radix);
         - Arguments: radix
         - Description:
           * reads a glyph within the appropriate radix
           * converts the glyph to the corresponding base10 number
         - Return Value:
           * a base10 number

      1. Refactor your bit2int() method to:
         - Name: public static int nextInt(int radix);
         - Arguments: radix
         - Description:
           * reads a sequence of glyphs within the appropriate radix
           * converts this sequence into a base10 number
         - Return Value:
           * a base10 number


   1. Next steps:
      1. Read the Specification
         - make appropriate changes
         - following the require steps
      1. Convert nextInt and supporting method to Java TAC style
      1. Transliterate your Java TAC style into MIPS



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



```java
static char [] buffer = new char[100];

public static int strcat(char [] first, char [] second) {

   int i;
   int j;

   for(i=0; first[i] != '\0' ; i++) {
      buffer[i] = first[i];
   }
   for (j=0; second[j] != '\0' ; j++ ){
      buffer[i+j] = second[j];
   }
   buffer[i+j+1] = '\0';

   mips.print_s(buffer);
   return 0;
}
```


---
<!-- This section for student's to place their own notes. -->
<!-- This section will not be updated by the Professor.   -->

## Notes  


