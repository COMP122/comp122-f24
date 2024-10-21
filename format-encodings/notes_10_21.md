# COMP122 Lecture Notes: October 16, 2024

## Announcements:
   1. Assignments graded
      - 03-mathematical-review
      - 21-table-encodings
      - 22-utf8-encodings

   1. Exceptions, Requests, etc.
      - have not dealt with any of them
      - ~ 5 students did not accept assignment
      - ~ 5 students fail the pregrade test
      - I grade based upon "submitted" tag
        * no tag, no grading
        * tag after due date, no grading
      - IF you tag is in the wrong place
        - move it and request special dispensation.      - 

   1. Outstanding grading
      * Github Classroom made change repo creation 
        - 10-quiz.txt
      * Need to retool grading tool
        - 04-first-programming-assignment
        - 41-simple-interest.txt

   1. Assignment: binary32 
      - Status: Announced
      - Deliverable ID: 43-
      - Invitation URL: https://classroom.github.com/a/rPUz3Z0h
      - Due Date: Oct 27 23:59 PDT

## Today's Agenda:

  1. Lecture
     - Tags and Log file
     - Conversion between Bases
 
  1. Lab: 
     - Binary32 Assignments Walk through
     - Time to work


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

  1. Base N to Base 10 Examples:
      -  8# 542

       |   v   | = |   v   | * 8 +    | digit_10 | glyph | code |
       |------:|:-:|------:|:--------:|---------:|:-----:|:----:|
       |   5   | = |   0   | * 8 +    |      5   |    5  |  53  |
       |  44   | = |   5   | * 8 +    |      4   |    4  |  52  |
       | 354   | = |  44   | * 8 +    |      2   |    2  |  50  |

       Answer: 354

     - 17# A34G

       |   v    | = |   v   | * 17   + | digit_10 | glyph | code |
       |-------:|:-:|------:|:--------:|---------:|:-----:|:----:|
       |    10  | = |    0  | * 17   + |    10    |   A   |  65  |
       |   173  | = |   10  | * 17   + |     3    |   3   |  51  |
       |  2945  | = |  173  | * 17   + |     4    |   4   |  52  |
       | 50081  | = | 2945  | * 17   + |    16    |   G   |  71  |

       Answer: 50081     


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
  
     - Example:  354  -> 8# 
       ```response
       354 = number    
           354   / 8 = 44, 2  
            44   / 8 =  5, 4
             5   / 8 =  0, 5
             0   / 8 =  0, 0


       answer: 542   (read remainders from bottom to the top)
       ```

     - Example: 272 -> 2#
       ```response
       number = 272        ---
           272   / 2 = 136, 0
           136   / 2 =  68, 0
            68   / 2 =  34, 0
            34   / 2 =  17, 0
            17   / 2 =   8, 1
             8   / 2 =   4, 0
             4   / 2 =   2, 0
             2   / 2 =   1, 0
             1   / 2 =   0, 1
             0   / 2 = 


       answer: 2# 1 0001 0000
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
     - Examples 0.465 ->  2# 0.011100
       ```response
       number = 465
       max =  1,000
          465  * 2 =  0, 930
          930  * 2 =  1, 860
          860  * 2 =  1, 720
          720  * 2 =  1, 440
          440  * 2 =  0, 880

       answer:  0.011100  (read overflows from top to bottom)
       ```

# Today's Lab Material

 1. Review 43-binary32
    * off-topic example:
      ```bash
      $ cd  practicum/code_10_15/
      $ java_subroutine java/pos_msb 22
      5
      $ java_subroutine -R binary32 java/pos_msb 22
      | 0 | 00000000 | 00000000000000000000101 |
      ```

    - type_signature:   
      ```java
      public static int 
      binary32(int sign, int coefficient, int expon_sign, int exponent);
      ```
    - example:
      * - 1.01011010101 x 2^101  // 5
        * Inputs: java_subroutine -R binary32 binary32 '-'  2#101011010101 + 2#101
        * Output: | 1   |  1000 0100 | 0101 1010 1010 0000 0000 000 | 
        * Test Case:
          - ARGS="'-'  2#101011010101 + 2#101"
          - OUTPUT="| 1 | 10000100 | 01011010101000000000000 | "
          - EXIT_VAL=0     # 0xC22D50 00 mod 0xFF == 0

      * - 1.01011010101 x 2^101  // 5
        * Inputs: java_subroutine -R binary32 binary32 45  2#101011010101 42 5
        * Output: | 1   |  1000 0100 | 0101 1010 1010 0000 0000 000 | 
        * Test Case:
          - ARGS="45  2#101011010101 42 5"
          - OUTPUT="| 1 | 10000100 | 01011010101000000000000 | "
          - EXIT_VAL= 0     # 0xC22D50 00 mod 0xFF == 0


    - Starter code: (format-encodings/binary32.j)
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

      example usage
      ```mips
      li $t0, bias
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


