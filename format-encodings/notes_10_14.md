# COMP122 Lecture Notes: October 14, 2024

## Announcements:
   1. https://en.wikipedia.org/wiki/Indentation_style

   1. New practicum setup
      - based upon the experience from last lab..
      - a new directory was added to comp122: practicums
        - previous code has been moved
        
   1. Git Repos from last lab practicum
      * git@github.com:COMP122/code_10_09M.git
      * git@github.com:COMP122/code_10_09A.git
      * git@github.com:COMP122/code_10_10.git   (not yet)

      - Instructions to clone them on your machine
        ```bash
        cd ~/classes/comp122/
        git pull
        cd practicums
        git clone git@github.com:COMP122/code_10_09M.git 
        ```


## Today's Agenda:

  1. Lecture
     - Review of UTF-8
     - Review of IEEE 754 standard (binary32)
     - Bitwise Operations
 
  1. Lab: Practicum
     - Finding the most significant bit
       - manualy testing
       - review of for-loop and if-then-else tranformation


## Questions from Last Lecture/Lab, etc.:
   * M/W 
 
   * T/R 

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

    1.
    1.
    1.

  - UTF-8 encoding

  - binary32 decoding
    1. Sign: 1 bit
       - 0: '+', 1: '-'
    1. Expon: 8-bit binary number (lookup table)
       - and then minus the defined bias (127)
    1. Mantissa: 23 bits

  - binary32 encoding

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

      | coefficent    | number       | pos_msb |
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


