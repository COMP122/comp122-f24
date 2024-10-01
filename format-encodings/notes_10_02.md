l# COMP122 Lecture Notes: October 2, 2024

## Announcements:
  1. Upcoming Assignments:
     * 21-table-encodings  (to be assigned Monday/today)
     * 22-utf8-encodings
     * 41-pemdas-coding    (to be assigned Friday)


## Today's Agenda:
  1. Formats and Encodings (introduction-to-encodings.pptx)
     * ASCII in Detail
     * Variable Length Encodings: UTF-8

  1. Lab: 

## Questions from Last Lecture/Lab, etc.:
   * M/W 
    
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

  1. MIPS instruction Encoding
     - 32bits: three encoding formations:
       * R: | xxxxxx | xxxxx | xxxxx | xxxxx | xxxxx | xxxxxx   |
       * I: | xxxxxx | xxxxx | xxxxx | xxxx xxxx xxxx xxxx xxxx |
       * J: | xxxxxx |         xx xxxx xxxx xxxx xxxx xxxx xxxx |

     - mips_cli:

     

  1. Encoding and Decoding of UTF-8
 
---
## Resources
  * format-encodings/encode-utf8.md
  * format-encodings/decode-utf8.md

---
<!-- This section for student's to place their own notes. -->
<!-- This section will not be updated by the Professor.   -->

## Notes  


