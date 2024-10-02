l# COMP122 Lecture Notes: October 2, 2024

## Announcements:
  1. Oct 8 (Tuesday) 
     * class and lab will must likely be cancelled
     * this will impact Oct 7th plan, as well as Oct 9th's plan

  1. Upcoming Assignments:
     * 21-table-encodings  (to be last Monday)
     * 22-utf8-encodings   (to be assigned Wedneday/today)
     * 41-pemdas-coding    (to be assigned Friday)
     * 41- 42-checksum 



## Today's Agenda:
  1. Formats and Encodings (introduction-to-encodings.pptx)
     * ASCII in Detail
     * Variable Length Encodings: UTF-8

  1. Lab: 
     * More hands-on encoding
     * UTF8 examples

## Questions from Last Lecture/Lab, etc.:
   * M/W 
     - register encodings for MIPS (answered in lab)
    
   * T/R 

---
# Today's Lecture Material

  1. Formats and Encodings
     - see slides: introduction-to-encodings.pptx
     - pick up where we left off

# Today's Lab Material
  1. BCD Example

    ```response
       c  cccC     c  cccc    # Carries           
          xxxx        xxxx    # Augend            
      +   xxxx        xxxx    # Addend            
      --  ----        ----                        
          xxxx        xxxx    # I.Sum  >--------  
                                               |  
       C  cccc     C  cccc    # Carries        |  
      x   xxxx        xxxx    # I.Sum  <--------  
          0xx0        0xx0    # Fix?              
      --  ----        ----                        
       C  xxxx        xxxx                        

   ```
   
   * 23 + 17 = 40

   ```response
       0  0111     0  1110    # Carries           
          0010        0011    # Augend            
      +   0001        0111    # Addend            
      --  ----        ----                        
          0100        1010    # I.Sum  >--------  
                                               |  
       0  0000     1  1100    # Carries        |  
      x   0100        1010    # I.Sum  <--------  
          0000        0110    # Fix?              
      --  ----        ----                        
       0  0100        0000                        
   0 40
   ```

   * 45 + 27 = 72
     ```
        45
     +  27
     ```

   ```response
       0  0001     0  1110    # Carries           
          0100        0101    # Augend            
      +   0010        0111    # Addend            
      --  ----        ----                        
          0111        1100    # I.Sum  >--------  
                                               |  
       C  cccc     1  1000    # Carries        |  
      x   0111        1100    # I.Sum  <--------  
          0000        0110    # Fix?              
      --  ----        ----                        
       0  0111        0010                        
   0 7 2
   ```
   

  1. MIPS instruction Encoding
     - 32bits: three encoding formations:
       * R: | oooooo | sssss | ttttt | ddddd | >>>>> | ffffff   |
       * I: | oooooo | sssss | ttttt | iiii iiii iiii iiii iiii |
       * J: | oooooo |         aa aaaa aaaa aaaa aaaa aaaa aaaa |

     - mips_cli:

     * Example:
       - add $t1, $t2, $s4

       ```response
       - op:   000 000
       - func: 100 000
       - rd: $t1 : 0 1001
       - rs: $t2 : 0 1010
       - rt: $s4 : 1 0100
       - sh: 00000

       * R: | 000000 | 01010 | 10100 | 01001 | 00000 | 100000   |
       * R: 0000 0001 0101 0100 0100 1000 0010 0000  
       *  16# 01544820
       ```

     * Example:  
       - addi $t8, $t5, 0x23
       ```
       op: 001 000
       ~func:~
       ~rd:~
       rs: $t5 : '0 1101
       rt: $t8 : '1 1000
       imm: 0x23 : 0000 0000 0000 0010 0011
       ~addr:~
       ```
       * I: | oooooo | sssss | ttttt | iiii iiii iiii iiii iiii |
       * I: | 001 000 | 0 1101| 1 1000 | 0000 0000 0000 0010 0011 |




  1. Encoding and Decoding of UTF-8

     1. Encoding Examples
        * U+2993                  
          * 16# 2993                                  # convert to hex
          * 2# 0010 1001 1001 0011                    # convert to binary
          * p == 14, ==> l = 16, b = 3                # determine value of p
          * | xxxx xxxx | xxxx xxxx | xxxx xxxx |     
          * 2# | 0010 | 100110 |  010011              # chunk the binary
          * | 1110 xxxx | 10 xx xxxx | 10 xx xxxx |   # grab the 3 byte sequence
          * | 1110 0010 | 10 10 0110 | 10 01 0011 |   # fill in the data bits
          * 2# 1110 0010 1010 0110 1001 0011          # present in 4-bit chucks
          * 0x E2A693                                 # present in hex

        * U+4567
          * 0x 4567                                   # convert to hex
          * 0b 0100 0101 0110 0111                    # convert to binary
          * p == 15  ==> l =16, b = 3                 # determine value of p
          * 0b  0100 | 0101 01 | 10 0111              # chunck the binary
          * | 1110 xxxx | 10 xxxxxx | 10 xxxxxx |     # grab the 3 byte sequence
          * | 1110 0100 | 10 0101 01 | 10 10 0111 |   # fill in the data bits
          * 2# 1110 0100 1001 0101 1010 0111          # present in 4-bit chucks
          * 0x16 E495A7                               # present in hex

        * 0X cd85    ==> U+0345 
          * 0b 1100 1101 1000 0101                    # convert to binary
          * | 110- 0 1101 | 10- 00 0101 |             # gather the bytes, and check
          * | fff- 0 1101 | ff- 00 0101 |             # identify framing bits
          * 2# 0011 0100 0101                         # unpack data bits
          * 16# 345                                   # convert to hex
          * U+0345                                    # present as unicode

        * U+0260
          * 0x 0260
          * 0b 0000 00 "1" 0 0110 0000
          * p == 10, l = 11, b = 2
          * | 0 1001 | 10 0000 |
          * | 110 xxxxx   | 10 xxxxxx |
          * | 110 0 1001  | 10 10 0000 |
          * 2# 1100 1001 1010 0000
          * 16# C9A0

---
## Resources
  * format-encodings/encode-utf8.md
  * format-encodings/decode-utf8.md

---
<!-- This section for student's to place their own notes. -->
<!-- This section will not be updated by the Professor.   -->

## Notes  


