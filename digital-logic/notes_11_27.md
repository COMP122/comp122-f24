# COMP122 Lecture Notes: November 27, 2023

## Announcements:
   1. 03-utf8 was graded

  1. Quiz #3: Digital Logic (30-quiz-digital-logic  )
     - Online Timed Quiz
     - Paper-like Deliverable
     - December 6/7 
     - Released on Dec 5 23:59:59
     - Due: Dec 7 23:59:59


## Today's Agenda:
   1. Start a new section: Digital Logic
      1. Introduction to Digital Logic
      1. Combinational Circuits
      1. Control Lines and the CPU
      1. State and MicroArchitecture



## Questions from Last Lecture/Lab, etc.:
   * M/W @ 9:00 am
     - Will you provide me info on bash scripting? hmm, maybe
     - 3x- practice assignments, will you give answers? maybe
     - binaryReal: does it make calls to other files? yes!
       * java_subroutine -L '\*.j' -S binaryReal 10 "#" 2345 . 1234
     - push & pop
       | java           | mips       |
       |----------------|------------|
       | mips.push(a)   | push(a)    |
       | b = mips.pop() | pop(b)     |

   * T/R @ 9:00 am
     - Can we review if-the-else translation to .j --> TAC? during the lab
     - Will you update the assignments.md file? yes, 

---
# Today's Lecture Material

  1. Introduction to Digitial Logic
     - See Slides: digital-logic/slide_presentation/Introduction_to_Digitial.pdf
 

# Today's Lab Material

  1. Work on 40-exam-mips

```java
     x = a+b;
     y = c*d;
j:   if (x <= y) {
c:
       // stuff 
       // goto k
     }
k:   ;


j:  if (x <= y) {
c:    ;        
      //stuff
      // goto k
    } else {
a:     ;            
       // more stuff
       // goto k       
    }
k:  ; 

```


```java
     j = a+b;
     k = c*d
     m = j <= k;  // (j - k) <= 0 
     n = x == y;  // (x - y) == 0 
     X = m && n;

j:   if (X == TRUE) {
c:
       // stuff 
       // goto k
     }
k:   ;


---
## Resources

      | A | B |  X |
      |---|---|----| 
 A'B' | 0 | 0 |  0 |  
 A'B  | 0 | 1 |  1 |
 AB'  | 1 | 0 |  1 |
 AB   | 1 | 1 |  0 |

A'B + AB'

      | A | B |  X |
      |---|---|----| 
 A'B' | 0 | 0 |  1 |   1   
 A'B  | 0 | 1 |  1 |   1 
 AB'  | 1 | 0 |  ? |   0 
 AB   | 1 | 1 |  1 |   1 


A'B' + A'B  + AB


      | A | B |  X |
      |---|---|----| 
 A'B' | 0 | 0 |  1 |  
 A'B  | 0 | 1 |  1 |
 AB'  | 1 | 0 |  0 |
 AB   | 1 | 1 |  1 |

A'B' + A'B + AB



         | A | B | C | X | Y | Z |
         |---|---|---|---|---|---|
 A'B'C'  | 0 | 0 | 0 | 1 | 1 | 0 |
 A'B'C   | 0 | 0 | 1 | 0 | 0 | 1 |
 A'BC'   | 0 | 1 | 0 | 1 | 0 | 1 |
 A'BC    | 0 | 1 | 1 | 1 | 0 | 1 |
 AB'C'   | 1 | 0 | 0 | 1 | 1 | 0 |
 AB'C    | 1 | 0 | 1 | 0 | 1 | 0 |
 ABC'    | 1 | 1 | 0 | 0 | 1 | 0 |
 ABC     | 1 | 1 | 1 | 1 | 0 | 1 |

X = A'B'C' + A'BC' + A'BC + AB'C' + ABC
Y = A'B'C' + AB'C' + AB'C + ABC'
Z = (Y)' = A'B'C + A'BC' + A'BC + ABC

 A'B'C' + AB'C' + AB'C + ABC' == ( A'B'C + A'BC' + A'BC + ABC )'

---
<!-- This section for student's to place their own notes. -->
<!-- This section will not be updated by the Professor.   -->

## Notes  


