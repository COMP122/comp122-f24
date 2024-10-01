# COMP122 Lecture Notes: September 30, 2024

## Announcements:
  1. Graded Assignments:
     - more adminstrative/grade.report.example 
     * 02-first-MD-assignment: see slack
     * 03-mathematical-review: see slack

  1. Upcoming Assignments:
     * 21-table-encodings  (to be assigned Monday/today)
     * 22-utf8-encodings
     * 41-pemdas-coding    (to be assigned Friday)
    
  1. Starting New Section: format-encodings
     - Introduction to Encodings 
     - Introduction to Numbering Systems
     - Floating Point Encoding
     - Bitwise Operations
     - Conversion between Bases
     - Mathematical Review & Base 2 Encodings
     - Multiplication
     - Base64 Encoding


## Today's Agenda:
  1. Note Lecture and Lab will most likely be blended.

  1. Formats and Encodings (introduction-to-encodings.pptx)
     * Binary Strings
     * Functions/Mapping
     * Fixed Length Encodings
     * BCD Addition (foreshadow)

     ---
     * ASCII in Detail
     * Variable Length Encodings: UTF-8

  1. Lab: 
     - Table Lookup Examples

## Questions from Last Lecture/Lab, etc.:
   * M/W 
     - no questions

   * T/R 

---
# Today's Lecture Material

  1. Formats and Encodings
     - see slides: introduction-to-encodings.pptx

# Today's Lab Material
  - Table Lookup Examples
    * https://drive.google.com/drive/u/0/folders/1ZLRC2SE5znDr8orhsZveRKd45TQs0A_e

    * Input:
      * binary string: left justified
      * binary number: right justified

## Tuesday's Lab

## Monday Afternoon's Lab
  * Binary String: 0101101100101000011000110101  (given)
    - 8#  2   6   6   2   4   1   4   3   2    4
      - 010 110 110 010 100 001 100 011 010    1-00
    - 16#  5    B    2    8    6    3    5
      - 0101 1011 0010 1000 0110 0011 0101
    - BCD: 5   NA    2    8    6    3    5

  * Binary Number: 0101101100101000011000110101000  (given)
    - 8#  0   5   5   4   5   0   3   0   6   5   0
      - 000 101 101 100 101 000 011 000 110 101 000
    - 16#  2    D    9    4    3    1    A    8 
      - 0010 1101 1001 0100 0011 0001 1010 1000

  * Base 8 -> base 2
    - 8#         001 |         234 |         632 |         574 | (given)
    - 2# 000 000 001 | 010 011 100 | 110 011 010 | 101 111 100 |

  * Base 16 -> base 2
    - 16#    1    8    d    e    a    7    6    c (given)
    - 2#  0001 1000 1101 1110 1010 0111 0110 1100

  * Base 16 -> base 8
    - 16#    1    8    d    e    a    7    6    c  (given)
    - 2#  0001 1000 1101 1110 1010 0111 0110 1100 
    - 2#  000 011 000 110 111 101 010 011 101 101 100 
    - 8#    0   3   0   6   7   5   2   3   5   5   4

  * Binary String --> ASCII
    * 0101 1101 | 0010 0100 | 0010 1010 | 0101 1010 (given)
    * 5D 24 2A 5A
    * ]  $  *  z

  * Binary String --> base64
    * 101101010100111000110100001110101000 (given)
    * 10 1101 | 01 0100 | 11 1000 | 11 0100 | 00 1110 | 10 10"00"
    * t         U         4         0         O         o
    * tU40Oo

  * Base6 -> binary
    * Base64:  trU8+m (given)
    * binary: 10 1101 | 10 1011 | 01 0100 | 11 1100 | 11 1110 | 10 0110

## Monday Morning's Lab

  * Binary String: 1010 1110 1101  --> 8#, 16#, BCD (given)
    - 101011101101 
      - 8# 5 355                            <!-- response -->
        * 101 011 101 101
        * 5   3   5   5
      - 16# AED                             <!-- response -->
        * 1010 1110 1101
        * A    E    D
      - BCD:                                <!-- response -->
        * 1010 1110 1101
        * NA   NA   NA  
                
  * Binary Number: 2# 010100010100101001 --> 8#, 16#, BCD (given)
    - 2# 01 0100 0101 0010 1001
      - 8# 242 451
        - 010 100 010 100 101 001
      - 16# 1 4529
      - BCD: 1 4 5 2 9

  * Binary String: 010100010100101001 --> 8#, 16#, BCD (given)
    - 8# 242 451
      - 010 100 010 100 101 001
    - 16# 514A "4"
      - 0101 0001 0100 1010 01 00
    - BCD:

  * Octal, hex, bcd  --> binary string
    -   034           643          246            754           224          57  (given)
      - 000 011 100 | 110 100 011 | 010 100 110 | 111 101 100 | 010 010 100 | 101 111
      - 0x 045f                  e7de                  4523
        -  0000 0100 0101 1101 | 1110 0111 1101 1110 | 0100 0101 0010 0011
      - 12345567
        - 0001 0010 0011 0100 0101 0101 0110 0111

  * Binary string --> ASCII
    * 0100 1010 | 0100 1010 | 0001 0100 |  (given)
       - 0x  | 45 | 45 | 14
       -     |  E |  E | <dc4>
    * 0110 1010 | 0101 1111 | 0000 1101 | 0101 0111  (given)
       - 0x 6A | 5F | 0D | 57
       - j_ <cr> W   :

  * Binary string --> base64
    - | 01 0110 | 10 1101 | 01 1110 | 11 1010 | 10 1000 |  (given)
    -   W         t         e         6         o

  * ASCII, base64 --> binary string 
    - t!iMe1  (given)
      * ASCII: 0x 74 21 69 4d 65 31
      * Binary: 0111 0100 | 0010 0001 | 0110 1001 | 0100 1101 | 0110 0101 | 0011 0001
 
---
## Resources


---
<!-- This section for student's to place their own notes. -->
<!-- This section will not be updated by the Professor.   -->

## Notes  


