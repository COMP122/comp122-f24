# COMP122 Lecture Notes: October 14, 2024

## Announcements:
   1. Videos are put slack: #video

   1. New practicum setup
      - based upon the experience from last lab..
      - a new directory was added to comp122: practicums
        - previous code has been moved
        
   1. Git Repos from last lab practicum
      * git@github.com:COMP122/code_10_09M.git
      * git@github.com:COMP122/code_10_09A.git
      * git@github.com:COMP122/code_10_10.git  

      - Instructions to clone them on your machine
        ```bash
        cd ~/classes/comp122/
        git pull
        cd practicums
        git clone git@github.com:COMP122/code_10_09M.git 
        ```

   1. https://en.wikipedia.org/wiki/Indentation_style
      - format_encodings/notes_10_14.s



## Today's Agenda:

  1. Lecture
     - Review of UTF-8
     - Review of IEEE 754 standard (binary32)
     - Bitwise Operations
 
  1. Lab: Practicum
     - Finding the most significant bit
       - manualy testing
       - review of for-loop and if-then-else transformation


## Questions from Last Lecture/Lab, etc.:
   * M/W
     - 42- assignment, what style to use
       * which ever you want, but use 1 style
     - UTF-8 encoding: x format
       * binary encoding and then represented as hex
     - Register questions:
       - can we use the S registers on the mips
         - yes, but refrain from using them.
       - don't use: $at, $k0, $k1, sometimes $gp
       - use the $zero register: whenever you can

   * T/R 
     - 42-, for the java code how do we do the write the code
       - see the code
     - is there a video on the transformation from java --> java_tac
       * Yes, the video from the lab on 10_14
     - can you provide the code for 41-
       * when I grade it, I will provide a subdirectory call "solution"
     - note that there is an error in the 42-checksum assignment in the README.md file.  (read for intent!)

---
# Today's Lecture Material

---
## Review:
  - We're trained to expect inputs are always 100% correct
  - All algorithms need to deal with exceptions
    - i.e., we need to expect malformed data
    - malformed data tests our understanding
    - forward progress needs to be made

  - UTF-8 decoding
    * 0xxx xxxx : start of a 1 byte sequence
    * 10xx xxxx : continuation byte
    * 110x xxxx : start of a 2 byte sequence
    * 1110 xxxx : start of a 3 byte sequence
    * 1111 0xxx : start of a 4 byte sequence

  - Decode the following UTF-8 string
    1. 1101 1101 | 1010 0110 | 1011 0101 | 0111
       - 110 - 1 1101 | 10 - 10 0110 
         - 1 1101  10 0110
         - 0111 0110 0110
         - 0x0766
         - U+0766
       - 1011 0101 : error because not in the middle of a UTF-8 char
       - 0111      : error not enough bits

  - Decode the following UTF-8 string
    1. 0110 1010  | 1101 0011 | 1001 1110| 0101 0101 | 1001 1011 |
   -  0110 1010 : look it up in the ASCII table
   -  110 - 1 0011 | 10 - 01 1110 
      - 0100 1101 1110 (unpack the data)
      - 4 D E
      - U+04DE
   -  0101 0101 : look it up in the ASCII table
   -  1001 1011 - error because its a continuation byte


    1. 1101 1001  0000 0101 0111 0001
       - 1101 1001  0000 0101
         - nope, not a valid UTF-8 character : error
       - 0111 0001 : look it up in the ASCII table

    1. 1101 1001  0000 0101 0111 0001
       -  1101 1001 : error
       -  0000 0101 : ASCII, look it up
       -  0111 0001 : ASCII, look it up


  - binary32 decoding
    1. Sign: 1 bit
       - 0: '+', 1: '-'
    1. Expon: 8-bit binary number (lookup table)
       - and then minus the defined bias (127)
       - 0111 1111
    1. Mantissa: 23 bits

    1. Decode the following binary32
       - 0 110 1111 1 010 1110 1010 1011 1100 1010
       - s eee eeee e mmm mmmm mmmm mmmm mmmm mmmm
         - s: 0  -->  0
         - e: 110 1111 1 - 127
           - 1101 1111 == 0xDF == 223 - 127 == 96
         - m: 010 1110 1010 1011 1100 1010
         - c: 1.010 1110 1010 1011 1100 1010

    1. Decode the following binary32
    - 0 | 101 1101 0 | 111 0101 1101 1001 0101 0101
    - sign: +
    - expon/bias: 1011 1010
    - expon (no bias): 1011 1010 - 127 = 59
    - mantissa: 111 0101 1101 1001 0101 0101

    + 1.111 0101 1101 1001 0101 0101 x 2^11 1011    // 59

  - binary32 encoding

    - + 1101101.101010
    - + 1.101101101010 x 2^ 0110  //6
    - s eeeeeeee mmmmmmmmmmmmmmmmmmmmmmm
      - s = 0
      - e = 6 + 127 = 133 = 0x85 == 1000 0101
      - m = 101101101010000000000000000000000000000
    - s eeee eeee mmmmmmmmmmmmmmmmmmmmmmm
    - 0 1000 0101 10110110101000000000000
    
---     
  1. Bitwise Operations
     * see slides: bitwise-operations.pdf

  1. mips_cli: For the professor only
   ```bash
   cd ~/repositories/mips_cli
   bin/mips_cli 
   run INTERACTIVE
   EMIT_ENCODINGS=FALSE
   ```

  1. Boolean-based Operations:
     * Complement:  
       - s1 = ~ t1;  
       - nor $s1, $t1, $zero   # s1 = ~ ( t1 | 0 ) 
     * And:    
       - s1 = t1 & t2; 
       - and $s1, $t1, $t2
     * Or:     
       - s1 = t1 | t2; 
       - or $s1, $t1, $t2
     * Xor:    
       - s1 = t1 ^ t2; 
       - xor $s1, $t1, $t2

  1. Shift-based Operations:
     * ~Un/Signed~ Left Shift
       - s1 = t1 << 2; 
       - sll $s1, $t1, 2        # Shift Left Logical
     * Unsigned Right Shift
       - s1 = t1 >>> 2;  
       - srl $s1, $t1, 2        # Shift Right Logical
     * Signed Right Shift  
       - s1 = t1 >> 2; 
       - sra $s1, $t1, 2        # Shift Right Arithmetic
     * ~Unsigned Left Shift~ 
       - ~s1 = t1 <<< t2;~


# Today's Lab Material

  - checksum and its algorithm...
    1. read in 10 integers 
    1. add those integers together
       - but don't add in the 6th, but save it as the "header_checksum" value
    1. take the sum and perform the mathematical steps given

  - practicum/code_10_14

  - Manually testing your code
    * Relying on ONLY automated testing is like
      - closing your eyes
      - hoping everything works
      - i.e., no thinking required
    * java_subroutine
    * mips_subroutine

  - static int pos_msb(int number);
    - Input: a coefficient with a fix-point at n

      | coefficient   | number       | pos_msb |
      |---------------|--------------|---------|
      | 1.00101001    |    100101001 |     9   |
      | 1.1110        |        11110 |     5   |
      | 1.0011110     |     10011110 |     8   |
      | 1.01101000001 | 101101000001 |    11   | 

  - Review of for-loop transformation
    - java -> java_tac (transformation)

  - Review of if-then-else transliteration
    - java_tac -> mips (transliteration)


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


