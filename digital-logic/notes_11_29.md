# COMP122 Lecture Notes: November 29, 2023

## Announcements:
   1. Questions:
      - Does the following demostrate the student understanding HOW to
        convert  10#43 to binary?
        ```
        number = 43690                           <!-- response -->
                                                 <!-- response -->
        answer: 2# 1010 1010 1010 1010               <!-- response -->
        ```
      - Should a student receive credit for knowning HOW to do something?
        Or receive for copying the anwer from a website/other?
        * https://www.csun.edu/~steve/classes/integers-conversion-encoding/integer-conversion.html

      - In short.... SHOW YOUR WORK!
                     


## Today's Agenda:
   1. Quick Review of Material from the lecture before
   1. Combinational Circuits


## Questions from Last Lecture/Lab, etc.:
   * M/W @ 9:00 am
     - TT -> Boolean Expression
 
   * T/R @ 9:00 am
     - How do I do push in Java, Java TAC, and then --> MIPS?



---
# Today's Lecture Material

  1. Combining AND, OR, and NOT in various ways.
     - See Slides: digital-logic/slide_presentations/.hidden/Combinational_Circuits.pptx
 

         | A | B | C | X |
         |---|---|---|---|
 A'B'C'  | 0 | 0 | 0 | 1 |
 A'B'C   | 0 | 0 | 1 | 1 |
 A'BC'   | 0 | 1 | 0 | 0 |
 A'BC    | 0 | 1 | 1 | 1 |
 AB'C'   | 1 | 0 | 0 | 0 |
 AB'C    | 1 | 0 | 1 | 0 |
 ABC'    | 1 | 1 | 0 | 1 |
 ABC     | 1 | 1 | 1 | 0 |

X = A'B'C' + A'B'C +  A'BC +  ABC' 

         | A | B | C | X | Y |
         |---|---|---|---|---|
 A'B'C'  | 0 | 0 | 0 | 1 | 0 |
 A'B'C   | 0 | 0 | 1 | 0 | 0 |
 A'BC'   | 0 | 1 | 0 | 0 | 0 |
 A'BC    | 0 | 1 | 1 | 1 | 1 |
 AB'C'   | 1 | 0 | 0 | 0 | 0 |
 AB'C    | 1 | 0 | 1 | 0 | 0 |
 ABC'    | 1 | 1 | 0 | 0 | 0 |
 ABC     | 1 | 1 | 1 | 1 | 1 |

X = A'B'C' + A'BC + ABC
Y = A'BC + ABC

--
Divide and Conquer, Working backward 

```
X  = (                      )  +  ( beta )
                 ^
      (        ) + ( gamma )
          ^

        (  ) * ( delta )
          ^
      ( ( A )')  * ( alpha )
```


# Today's Lab Material

  1. Work on 40-exam-mips


---
## Resources


---
<!-- This section for student's to place their own notes. -->
<!-- This section will not be updated by the Professor.   -->

## Notes  


