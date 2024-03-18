# COMP122 Lecture Notes: November 08, 2023

## Announcements:

   1. The Planning for the rest of the semester
      1. Exam #2: Formats & Encodings
         - November 20/21 (the day before Thanksgiving)
         - During Class time
         - Paper-like Deliverable 

      1. Quiz #3: Digital Logic
         - December 6/7 
         - Released on Dec 5 23:59:59
         - Due: Dec 7 23:59:59
         - Paper-like Deliverable

      1. Dec 6/7: Class / Lab time
         - Work on assignments
         - I'm available

      1. Dec 11 (Monday)
         - Last Day of Instruction
         - No Class, since on class on Tuesday

      1. Exam #4: Assembly Language
         - Programming Assignment in MIPS
         - Presented on:  November 20/21  (Lab time)
         - Due on: Monday, Dec 11 23:59:59


   1. Commits verses Timestamps
      
      1. commits a reference to a point in time:
         ```bash
         $ git log --oneline | head -5
         f676ff2 updates from today
         e1f3cb6 fixed bug
         9a99079 Merge branch 'main' of github.com:COMP122/comp122-f23
         282bd58 updates
         103c76c removed updates
         ```
      1. timestamps a reference to a point in time:
         ```bash
         $ date +%s            #   %s: the number of seconds since the Epoch,
         $ date -r 1698012075  # Print the date and time, since seconds from the Epoch
         $ date -r 0           # The Epoch
         ```
    1. Oh My Git!

## Today's Agenda:
   1. Memory Segments
   1. Cache
   1. Call Marco
   1. Subroutine
   1. Base64 Encoding


## Questions from Last Lecture/Lab, etc.:
   * M/W @ 9:00 am
     - Process of a regrade...
     - 44-... do I have to do every base from 2..16
       * cause mult by 7 with shifts are hard!
     - switch/case statement... can show us?

   * T/R @ 9:00 am


---
# Today's Lecture Material

   1. Memory Segments
      1. text
         - static, read-only, temporal locality
      1. data
         - static, read/write, spatial locality
      1. stack
         - dynamic, read/write, temporal locality
      1. heap
         - dynamic, read/write, spatial locality

   1. Cache and the "Principal of Locality"
      - browser cache
      - web cache

   1. Call Marco
      - used to transition from one subroutine to another 
      - new subroutine, new focus, new scratch space
      - from 44-nextInt

      | Java TAC                | MIPS Macro                |
      |-------------------------|---------------------------|
      | a = glyph2int(b, c);    | call glyph2int b c        |
      |                         | move a, $v0               |


      ```mips
      .macro call( %sub, %arg0, %arg1)
          save_state()
          push $a0, $a1
          move $a0, %arg0
          move $a1, %arg1
          jal %sub
          pop $a0, $a1
          restore_state()
      .end_macro
      ```

      ```mips
      glyph2int:  nop
                  ...
                  move $v0, %ret_value
                  jr $ra
      ```

   1. Subroutine
      - See Slides: assembly_programming/slide_presentation/

 

# Today's Lab Material
  1. Status of Current Lab
  1. Lab Time ?
  1. Base64 Encoding



---
## Resources


---
<!-- This section for student's to place their own notes. -->
<!-- This section will not be updated by the Professor.   -->

## Notes  


