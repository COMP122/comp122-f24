# COMP122 Lecture Notes: October 16, 2024

## Announcements:
   1. Assignments graded
      - 03-mathematical-review
      - 21-table-encodings
      - 21-table-encodings
      - 22-utf8-encodings
   1. Outstanding grading
      * Github Classroom made change repo creation 
        - 10-quiz.txt
      * Need to retool grading tool
        - 04-first-programming-assignment
        - 41-simple-interest.txt


   1. Assignment: binary32 
      - Status: Released Today.
      - Deliverable ID: 43-
      - Invitation URL: https://classroom.github.com/a/rPUz3Z0h
      - Due Date: Oct 27 23:59 PDT

## Today's Agenda:

  1. Lecture
     - Tags and Log file
     - Conversion between Bases
 
  1. Lab: Time to work
     - Review of Floating Point and Binary32 Assignments
       - 43-binary32


## Questions from Last Lecture/Lab, etc.:
   * M/W

   * T/R 


---
# Today's Lecture Material

  1. Tags and Log files
     - timestamps and events <=>  commits and tags
     - man strftime

     ```bash
     alias git-log='git log --format="%h %ad %s %d" --date="format-local: %b %d %H:%M %Z"'
     ```

     ```bash
     git tag {ref} [ {commit} ]               # to create a tag
     git tag --delete {ref}                   # to delete a tag
     git push origin :{task}_submitted        # to unpublish the tag
     git push origin {task}_submitted         # to publish the tag  
     ```

  1. Conversion between Bases
     - see format-encodings/slide*/conversion-between-bases.pdf

  1. Base N to Base 10

     - Pattern:

       |   v   | = |   v   | * base + | digit_10 | glyph | code |
       |------:|:-:|------:|:--------:|---------:|:-----:|:----:|
       |       | = |       | * base + |          |       |      |

       Answer:      

  1. Base 10 to Base N (WHOLE PART)
     
     - Pattern

       |  number | / N -> | quotient | remainder | glyph |
       |---------|:------:|---------:|----------:|:-----:|
       |         | / N -> |          |           |       |         

       Answer:     (read glyph from bottom to the top)


     - Homework Pattern (code block) 

       ```response
       number = number    
           number   / N = quotient, remainder
           quotient / N = 

       answer:    (read remainders from bottom to the top)
       ```

  1. Base 10 to Base N: Fractional Part

     - Pattern (code block)
       ```response
          number = ddddd
          max =  1,00000
             number  * N = overflow, product
             product * N = 

          answer:    (read overflows from top to bottom)
        ```

  1. Examples

 

# Today's Lab Material

 1. Review 43-binary32
    - format_encodings/43-binary32.j

    - type_signature:   
      ```java
      public static int 
      encode_binary32(int sign, int coefficient, int expon_sign, int exponent);
      ```
    - example:
      * - 1.01011010101 x 2^101  // 5
        * Inputs: java_subroutine -R binary32 '-'  2#101011010101 + 2#101
        * Output: | 1   |  1000 0100 | 0101 1010 1010 0000 0000 000 | 
        * Test Case:
          - ARGS="-'  2#101011010101 + 2#101"
          - OUTPUT="| 1 | 10000100 | 01011010101000000000000 | "
          - EXIT_VAL=0     # 0xC22D50 00 mod 0xFF == 0

      * - 1.01011010101 x 2^101  // 5
        * Inputs: java_subroutine -R binary32 45  2#101011010101 42 5
        * Output: | 1   |  1000 0100 | 0101 1010 1010 0000 0000 000 | 
        * Test Case:
          - ARGS="45  2#101011010101 42 5"
          - OUTPUT="| 1 | 10000100 | 01011010101000000000000 | "
          - EXIT_VAL= 0     # 0xC22D50 00 mod 0xFF == 0

      * off-topic example:
        ```bash
        $ java_subroutine java/pos_msb 22
        5
        $ java_subroutine -R binary32 java/pos_msb 22
        | 0 | 00000000 | 00000000000000000000101 |
        ```


    - starter code:
      * format_encodings/encode_binary32.j
        1. Encode each of the three fields of the floating point format:
           1. Sign Encoding: (encoded_sign = )
           1. Exponent Encoding: (encoded_expon = )
           1. Mantissa Encoding: (encoded_mantissa = )
       1. Shift the pieces into place: sign, exponent, mantissa
          - encoded_sign     = 0;
          - encoded_exponent = 0;
          - encoded_mantissa = 0;
            
       3. Merge the pieces together
          - encoding = 0;
          - return encoding;



   1. final keywork in java
      ```java
      final int bias           = 127;
      ```
    
      is converted to

      ```mips
      .eqv bias 127
      ```

---
## Resources
  * reference/TAC_transformation.md
  * reference/TAC_transformation/for-loop2TAC.md 
  * reference/TAC_transformation/if-then-else2TAC.md
  * reference/TAC2mips.md

---
<!-- This section for student's to place their own notes. -->
<!-- This section will not be updated by the Professor.   -->

## Notes  


