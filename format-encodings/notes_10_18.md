# COMP122 Lecture Notes: October 18, 2023

## Announcements:

      
## Today's Agenda:
   1. Conversion Between Bases
      - Review and then Fractional Values

   1. Binary32 Assignment
      - Time to work on the assignment


## Questions from Last Lecture/Lab, etc.:
   * M/W @ 9:00 am
     - review of the base64 question on 24-
     - Mask construction:
       - xxxx xxxx
       - 0000 1100

   * T/R @ 9:00 am
     - base64 question


---
# Today's Lecture Material
  1. Conversion Between Bases
       - Review and then Fractions
       - See slides: conversion-between-bases.pdf

  1. Base 10 to Base N: Whole Part
     
     - Pattern (table)

       |  number | / N -> | quotient | remainder | glyph |
       |---------|:------:|---------:|----------:|:-----:|
       |         | / N -> |          |           |       |         

       Answer:        (read glyph from bottom to the top)

     - Pattern (code block)

       ```response
       number = number    
           number   / N = quotient, remainder
           quotient / N = 

       answer:    (read remainders from bottom to the top)
       ```

     - Example: 321 --> Base 2

      ```response
       number = 321    
           321   / 2 = 160, 1
           160   / 2 =  80, 0
            80   / 2 =  40, 0
            40   / 2 =  20, 0

            20   / 2 =  10, 0
            10   / 2 =   5, 0
             5   / 2 =   2, 1
             2   / 2 =   1, 0

             1   / 2 =   0, 1

       answer: 1 0100 0001   (read remainders from bottom to the top)
       ```
     - Example: 321 --> Base 18

       ```response
       number = 321    
           321   / 18 = 17, 15 (F)
           17    / 18 =  0, 17 (H)
           0     / 18 =  0, 0


       answer: 18# HF   (read remainders from bottom to the top)
       ```

       - A: 10
       - B: 11
       - C: 12
       - D: 13
       - E: 14
       - F: 15
       - G: 16
       - H: 17

    - Example: 321 --> Base 7

       ```response
       number = 321    
           321   / 7 = 45, 6
            45   / 7 =  6, 2
             6   / 7 =  0, 6
             0   / 7 =  0, 0


       answer: 7# 626  (read remainders from bottom to the top)
       ```


    - Example: 547 --> Base 12

       ```response
       number = 547    
           547   / 12 = 45, 1
            45   / 12 =  3, 1
             3   / 12 =  0, 3
             0   / 12 =  0, 0


       answer: 12#  311   (read remainders from bottom to the top)
       ```
   - Example:  1224 --> Base 9

       ```response
       number =     
            1224 / 9 =  136, 0
             136 / 9 =   15, 1
              15 / 9 =    1, 6
               1 / 9 =    0, 1


       answer: 9# 1610  (read remainders from bottom to the top)
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

     - Example:  .456 to Base 2
       ```response
          number = 456
          max =  1,000
            456 * 2 = 0, 912
            912 * 2 = 1, 824
            824 * 2 = 1, 648
            648 * 2 = 1, 296

            296 * 2 = 0, 592
            592 * 2 = 1, 184
            184 * 2 = 0, 368
            368 * 2 = 0, 736

            736 * 2 = 1, 472
            472 * 2 =
        answer:  2# 0111 0100 1.....
        ```

     - Example: 1999 to Base 16
       ```response
       number =   1999
       max    = 1,0000

       1999 * 16 =  3, 1984   3
       1984 * 16 =  3, 1744   3
       1744 * 16 =  2, 7904   2
       7904 * 16 = 12, 6464   C
       6464 * 16 = 10, 3424   A

       answer = 0x 332CA.....
       ```

     - Example:  532 to Base 8
       ```response
       number =   532
       max    = 1,000
          532 * 8 = 4, 256
          256 * 8 = 2, 048
           48 * 8 = 0, 384
          384 * 8 = 3, 072
           72 * 8 = 0, 576

       answer= 8# 42030
         or  =   042030   (C, C++, C#, Java)
         or  =  0o42030   (python & javascript)
       ```

     - Example:  75 ->   Base 2
       ```
       number =     750
       max    =  1, 000

           75 * 2 =  1, 50
           50 * 2 =  1, 00
           00 * 2 =  0, 00

       answer: 2# 110

       ```

     - Example:  1541 ->   Base 2
       ```
       number =     1541
       max    =  1, 0000

           1541 * 2 =  0, 3082
           3082 * 2 =  0, 6164
           6164 * 2 =  1, 2328
           2328 * 2 =  0, 4656


       answer: 2# 0010 .....

       ```

    - Example:  1541 ->   Base 16
       ```response
       number =     1541
       max    =  1, 0000

         1541 * 16 =  2, 4656   - 2
         4656 * 16 =  7, 4496   - 7
         4496 * 16 =  7, 1936   - 7
         1936 * 16 =  3, 0976   - 3
         0976 * 16 =  1, 5616   - 1
         5616 * 16 =  8, 9856   - 8
         9856 * 16 = 15, 7696   - F
         7696 * 16 = 

       answer: 16#  2 7 7 3 1 8 F

       ```




  1. Code: Whole Part
     ```java
     static int whole2bin (int whole) {


        return 0;
     }
     ```

  1. Code: Fractional Part
     ```java
     static int fractional2bin(int fractional, int precision) {
        int max;
        final int max_bits = 23;

        max = (int) Math.pow(10, precision);

        return 0;
     ```
     - notes:
       * the number is left justified
       * precision == num_digits(number);
   



# Today's Lab Material
  1. Binary32 Assignment
     - Review the specification: README.md
     - Makefile review
     - Time to work on the assignment

---
## Resources


---
<!-- This section for student's to place their own notes. -->
<!-- This section will not be updated by the Professor.   -->

## Notes  


