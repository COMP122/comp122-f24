# COMP122 Lecture Notes: October 16, 2024

## Announcements:
   1. Videos posted on slack.. last announcement about videos

   1. Assignment: 42-checksum
      - extended by 24 hours
      - Due Date: Oct 17 23:59 PDT

   1. Assignment: binary32 
      - Status: Unassigned -- Spec needs to be written!
      - Deliverable ID: 43-
      - Invitation URL: https://classroom.github.com/a/rPUz3Z0h
      - Due Date: Oct 27 23:59 PDT

   1. Name: Base Conversion and Floating Point Representation
      - Status: Assigned
      - Deliverable ID: 23-
      - Invitation URL: https://classroom.github.com/a/g4fW0k44
      - Due Date: Oct 23 23:59 PDT


## Today's Agenda:

  1. Lecture
     - Finish the pos_msb practicum
     - Introduction to MARS

     - Review of Floating Point and Binary32 Assignments
       - 23-floating-point
       - 43-binary32
 
  1. Lab: Time to work


## Questions from Last Lecture/Lab, etc.:
   * M/W

   * T/R 


---
# Today's Lecture Material
  1. Finish the pos_msb practicum
     - practicum/code_10_14M
     - practicum/code_10_14A
     - practicum/code_10_15     

  1. Introduction to MARS
     * find . -name "mars*"
     * reference/mars/
     * mips/\*
     * See the prof, during the lab if you can't run mars!


  1. Review of Floating Point
    - https://github.com/comp122/23-binary*

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

# Today's Lab Material
  1. Mars tutorial on your own
     - ensure you can run the examples in the `mips` subdirectory
     - if mars does not work... see the prof.

  1. Time to work on 42-checksum, or other assignments.


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


