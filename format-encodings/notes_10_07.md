l# COMP122 Lecture Notes: October 7, 2024

## Announcements:
  1. Oct 7 (Monday)
     * The lecture will review material for the upcoming assignments
       - The lecture will be captured via OBS 
     * The lab will be on-line
       - Students can work on their programming assignments
       - Professor will be available via slack
  1. Oct 8 (Tuesday) 
     * The lecture will be conducted asynchronously
       - the video captured on Oct 7 via OBS will be provided
     * The lab will be on-line
       - Students can work on their programing assignments
       - Professor will be available via slack
     * Note that the Professor has a meeting from 11:00am till ?
       - Hence the Professor will not be engaged on slack as much as you would like.

  1. Current Assignments 
     1. Name: Table Encodings
        - Deliverable ID: 21-
        - Invitation URL: https://classroom.github.com/a/obEuBBCT
        - Due Date: Oct 8 23:59 PDT (Tuesday)
   
     1. Name: UTF-8 Encoding
        - Deliverable ID: 22-
        - Invitation URL: https://classroom.github.com/a/UgSIGNYc
        - Due Date: Oct 13 23:59 PDT (Sunday)
    
  1. New Programming Assignments
     1. Assignment: Simple Interest
        - Deliverable ID: 41-
        - Invitation URL: https://classroom.github.com/a/p5JjzpA1
        - Due Date: Oct 11 23:59 PDT (Friday)
     
     1. Assignment: Checksum
        - Deliverable ID: 42-
        - Invitation URL: https://classroom.github.com/a/l7xqHwlp
        - Due Date: Oct 16 23:59 PDT (Wednesday)


## Today's Agenda:
  1. Walk through of 41-simple-interest
  1. Walk through of 42-checksum

## Questions from Last Lecture/Lab, etc.:
   * M/W 
     - none to speak of

   * T/R 


---
# Today's Lecture Material

  * 41-simple-interest
    ```java
    public static int simple_interest(int P, int R, int T);
    ```

    1. The equation and order of operations

       ```math
       P  = 1000                        // $1000.00 initial principal
       R  = 5                           // 5% interest rate
       T  = 3                           // 3 Years
       SI = 1/100 * R  * T * P
          = 0.01 * 5 * 3 * 1000
          = 0.05 * 3 * 1000
          = 0.15 * 1000
          = 150 
       ```
       but
       ```math-integer
       P  = 1000                        // $1000.00 initial principal
       R  = 5                           // 5% interest rate
       T  = 3                           // 3 Years
       SI = 1/100 * R * T * P
          = 0 * R * T * P
          = 0
        ```

     1. Test case creation: test_cases/{account}.sth_case
        - e.g., test_cases/smf-steve.sth_case
        ```sth
        [case]
        ARGS="1000 5 3"
        OUTPUT=150
        ```

     1. Native MIPS instructions for mult/div

        ```mips
        mult rs, rt       #  {hi, lo} = rs * rt
        div  rs, rt       #  lo = rs / rt; hi = rs % rt 
        mflo rd           #  rd = lo
        mfhi rd           #  rd = hi
        ```

     1. Review of the README.md file

  * 42-checksum
     1. Review of IPv4
        - See slide on 7: format-encodings/slide_presentations/introduction-to-encodings.pdf

     1. TAC/MIPS Input
        ```java tac
        mips.read_d();          //  read_d()
        X = mips.retval();      //  move X, $v0
        ```

     1. Execution of the Professor's java solution
     1. Test case creation: test_cases/{account}.sth_case
     1. Review of the README.md file



# Today's Lab Material
  * Time to work on your programming assignments
  * Professor available via slack

---
## Resources


---
<!-- This section for student's to place their own notes. -->
<!-- This section will not be updated by the Professor.   -->

## Notes  


