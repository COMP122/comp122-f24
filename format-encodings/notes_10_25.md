# COMP122 Lecture Notes: October 25, 2023

## Announcements:

 
## Today's Agenda:

   1. Mathematical Review 
      - Base10
      - Reframed into Base2

   1. Practicum on UTF-8
      - decode_utf8.md



## Questions from Last Lecture/Lab, etc.:
   * M/W @ 9:00 am
     - When is the 03- assignment due?
     - When will 42-checksum be graded?
     - How to isolate bits:  typically  & and >>,>>>,  <<<
     - How to add bits: typically |

   * T/R @ 9:00 am


---
# Today's Lecture Material
  1. base10-mathematical-review.pdf
  1. base2-encoding-and-mathematical-operations.pdf
 

  1. Integer Representations:
     * Java `unsigned int X;` 
       - Nope does not have it
       - Use the next size up!
       - But if it did!
         * unsigned char  | .byte | 1 byte  | 0 .. 2^8-1   | 0 to 255  
         * unsigned short | .half | 2 bytes | 0 .. 2^16 -1 | 0 .. 64K 
         * unsigned int   | .word | 4 bytes | 0 .. 2^32 -1 | 0 .. 4GB  


     * Java: `int X;`
       * byte  | 1 byte  | .byte  | -  2^7 ..  2^7 -1 | -128 to 127
       * char  | 2 bytes | .half  | - 2^15 .. 2^15 -1 | -32,768 to 32,767
       * short | 2 bytes | .half  | - 2^15 .. 2^15 -1 | -32,768 to 32,767
       * int   | 4 bytes | .word  | - 2^31 .. 2^31 -1 | -2,147,483,648 to 2,147,483,647
       * long  | 8 bytes | .dword | - 2^63 .. 2^63 -1 | 


  1. Encodings:
     1. One's complement:   ~X
     1. Two's complement:   ~X + 1   ===   - X

     1. 4-bit:

     | number |  unsigned  | 1's comp  | 2's comp  |
     |-------:|:----------:|:---------:|:---------:|
     |    0   |       0000 |      0000 |      0000 | 
     |    3   |       0011 |      0011 |      0011 | 
     |   -3   |       ---- |      1100 |      1101 | 
     |   -8   |       ---- |      ---- |      1000 | 0 1000 --> 1 0111 + 1 
     |   -7   |       ---- |      1000 |      1001 | 
     |    5   |       0101 |      0101 |      0101 | 
     |   -4   |       ---- |      1011 |      1100 |
     |    7   |       0111 |      0111 |      0111 |
     |   -6   |       ---- |      1001 |      1010 |


        - recall the bit pattern is: s xxx
          * 1001 : is a negative number, i.e., -7
            - flip all the bits (0110) and then add one (0111)
          * 0111 : is a positive number, i.e., 7

     1. 8-bit:

     | number |  unsigned  | 1's comp  | 2's comp  |
     |-------:|:----------:|:---------:|:---------:|
     |      0 |  0000 0000 | 0000 0000 | 0000 0000 | 
     |     -8 |  ---- ---- | 1111 0111 | 1111 1000 |      
     |        |            |           |           |      
     |    17  |  0001 0001 | 0001 0001 | 0001 0001 |      
     |   -17  |  ---- ---- | 1110 1110 | 1110 1111 | 
     |   -6   |  ---- ---- | 1111 1001 | 1111 1010 |


       - Notice the pattern for the representation of a negative number within different sizes:
         *   -6 :                                     1010
         *   -6 :                                1111 1010
         *   -6 :                      1111 1111 1111 1010
         *   -6 :  1111 1111 1111 1111 1111 1111 1111 1010

    1. Binary Addition
       * Example 1:

         ```response
         x xxxx  xxxx              <!-- response: carries -->
           xxxx  xxxx              <!-- response: op1 encoding -->
         + xxxx  xxxx              <!-- response: op2 encoding -->
         ------  ----          
         y yyyy  yyyy              <!-- response: sum encoding -->

         C: ?; V: ?; S: ?; Z: ?
         ```

      * Example 2:

         ```response
         x xxxx  xxxx              <!-- response: carries -->
           xxxx  xxxx              <!-- response: op1 encoding -->
         + xxxx  xxxx              <!-- response: op2 encoding -->
         ------  ----          
         y yyyy  yyyy              <!-- response: sum encoding -->

         C: ?; V: ?; S: ?; Z: ?
         ```
    1. Status Bits: Re-explained
       - ../tidbits/status_bits_explained.gif
       - V = C ^ previous C
       - consider

         ```mips_cli
         (mips) assign $t1, 0x7FFFFFFF
         (mips) addi $t0, $t1, 1
          cin:                   1111 1111 1111 1111 1111 1111 1111 1110; "cin=0"
           t1:     2147483647; 0b0111 1111 1111 1111 1111 1111 1111 1111;
          imm:              1; 0b0000 0000 0000 0000 0000 0000 0000 0001; "1"
                 +   --------- ------------------------------------------
           t0:    -2147483648; 0b1000 0000 0000 0000 0000 0000 0000 0000;

         C: 0; V: 1; S: 1; Z: 0
         ```



    1. Binary Subtraction
       * 

         ```response
         x xxxx  xxxx              <!-- response: carries -->
           xxxx  xxxx              <!-- response: op1 encoding -->
         + xxxx  xxxx              <!-- response: op2 encoding -->
         ------  ----          
         y yyyy  yyyy              <!-- response: sum encoding -->

         C: ?; V: ?; S: ?; Z: ?
         ```

# Today's Lab Material

  1. Exercise:  UTF-8 decoding
  1. Practicum: UTF-8 decoding
     - read first byte  ( read_x();)
     - read additional bytes
     - validate additional bytes
     - strip framing bits
     - merge data bits
     - output unicode index



---
## Resources

   1. Encodings: unsigned, 1's complement, 2's complement, bias 8

   | #  |  binary number | unsigned |   1's  |   2's  | bias 8 |
   |---:|:--------------:|:--------:|:------:|:------:|:------:|
   | -8 |   2# - 1000    |    --    |   --   |  1000  |  0000  |
   | -7 |   2# - 0111    |    --    |  1000  |  1001  |  0001  |
   | -6 |   2# - 0110    |    --    |  1001  |  1010  |  0010  |
   | -5 |   2# - 0101    |    --    |  1010  |  1011  |  0011  |
   | -4 |   2# - 0100    |    --    |  1011  |  1100  |  0100  |
   | -3 |   2# - 0011    |    --    |  1100  |  1101  |  0101  |
   | -2 |   2# - 0010    |    --    |  1101  |  1110  |  0110  |
   | -1 |   2# - 0001    |    --    |  1110  |  1111  |  0111  |
   | -0 |      --        |    --    |  1111  |   --   |   --   |  
   |  0 |   2# + 0000    |   0000   |  0000  |  0000  |  1000  |
   |  1 |   2# + 0001    |   0001   |  0001  |  0001  |  1001  |
   |  2 |   2# + 0010    |   0010   |  0010  |  0010  |  1010  |
   |  3 |   2# + 0011    |   0011   |  0011  |  0011  |  1011  |
   |  4 |   2# + 0100    |   0100   |  0100  |  0100  |  1100  |
   |  5 |   2# + 0101    |   0101   |  0101  |  0101  |  1101  |
   |  6 |   2# + 0110    |   0110   |  0110  |  0110  |  1110  |
   |  7 |   2# + 0111    |   0111   |  0111  |  0111  |  1111  |
   |  8 |   2# + 1000    |   1000   |   --   |   --   |   --   |
   |  9 |   2# + 1001    |   1001   |   --   |   --   |   --   |
   | 10 |   2# + 1010    |   1010   |   --   |   --   |   --   |
   | 11 |   2# + 1011    |   1011   |   --   |   --   |   --   |
   | 12 |   2# + 1100    |   1100   |   --   |   --   |   --   |
   | 13 |   2# + 1101    |   1101   |   --   |   --   |   --   |
   | 14 |   2# + 1110    |   1110   |   --   |   --   |   --   |
   | 15 |   2# + 1111    |   1111   |   --   |   --   |   --   |



---
<!-- This section for student's to place their own notes. -->
<!-- This section will not be updated by the Professor.   -->

## Notes  


