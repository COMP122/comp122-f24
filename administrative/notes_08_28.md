# COMP122 Lecture Notes: August 28, 2023

## Announcements
   1. Greetings / Attendance

   1. The Topic of This Class:  "Computer Architecture and Assembly Language"
      - We will be focusing on the MIPS Architecture -- Alternatives x86, ARM, ...
      - Will you program in MIPS in the future?
      - Consider:  Telsa uses 1000 - 2000 computer chips in their vehicles
        - The have a multitude of sensors to monitor the environment
          * pedestrian steps in front of the car
          * traffic lights have change
          * etc. 

   1. Adding the Class & Permission Numbers
   1. No class on Monday September 4, 2023

   
   1. Feedback System
      - Fall_2023: https://www.csun.edu/~steve/classes/feedback/ 
      - Spring_2023: https://www.csun.edu/~steve/classes/feedback_s23/
      - Fall_2022: https://www.csun.edu/~steve/classes/feedback_f22

   1. Attendance
      - Is Attendance Mandatory?  Yes and No!
        - "Eighty percent of success is showing up." #quote Woody Allen
        - "Don't mistake routine for commitment, just showing up is not enough."  #quote Tommy Amaker

   1. Classroom Management
      - I try to be interactive as much as possible in class.
        - I have slides, but I don't want death by power point 
        - I modify in notes on the fly
        - I demonstrate the software development process interactively

      - Feel free to make various point-of-orders
        - Speak louder, Slow down, Speed up, etc
        - Can we take a break, Please review,
        - Can you share the command again.

      - Show engagement by asking questions (don't stand on ceremony)
        * I love questions:
          - I employ the Socratic Method all the time -- even to myself
           in hopes to stimulate critical thinking
          - Unfortunately, some "just" what "the" answer
          - Refrain from asking "lazy" questions  - you might get a "lazy" answer

   1. Discussion on the Purpose of this Class:
      - To prepare you for a career is CS, SE, CIT, etc.
      - To expose you to different tools and approaches to solving problems
      - To gain a better understanding of the technical foundation of the Universal Computer


## Today's Agenda
   * See the "Today's Material" Section

## Questions from Last Lecture/Lab, etc.:
   * First Lecture, hence no questions from last time!
     - The purpose of questions is to enhance the learning process
       - They ensure the current material is being understood, and 
       - they inform how to better present future material



---
# Today's Material
  (See administrative/documents/day1_agenda.pptx)

  1. Philosophy 
     * Why Unix/Linux?  It is philosophical!
       ```
       The Unix philosophy emphasizes building simple, compact, clear, modular, 
       and extensible code that can be easily maintained and repurposed by developers 
       other than its creators.
       ```

     * Why an emphasis on collaborative tools?
       - Technological Systems are built, maintained, and deployed by teams
       - Agile is an iterative approach to project management and software 
         development that helps teams deliver
       - The Agile Manifesto 
         1. Individuals and interactions over processes and tools
         1. Working software over comprehensive documentation
         1. Customer collaboration over contract negotiation
         1. Responding to change over following a plan
  

     * Consequences of the Agile Approach
       1. Constantly look for new processes and tools to be more effective as a team!
       1. Use documentation as a guide, don't presume the "spec" is always right -- 
          but fix it when it is wrong.
       1. Focus on current needs to solve problems, don't focus a rehashing previous
          (mis)understandings.
       1. Accept what is expected to change: Improvise, Adapt, Overcome!


   1. Class Notes:
     - `notes_[01][0-9]_[0-3][0-9].md`
       - +1 ([0-9]{3}) [0-9]{3} - [0-9]{4}
     - Markdown verses Markup
       - reference/markdown-cheat-sheet.md
     - Sublime Text
       - subl
     - Spacing and Indentation is important!
       - $ cat ../syllabus.md | sed 's/ //g' | awk '{ print $0 }' | sed '/^$/d'
       - cat
         - catenate the file ../syllabus.md onto the current file -- which is the terminal window
       - sed 's/ //g'   
         - \# stream editor (sed) command to "s"ubstitute a space with nothing, "g"lobal within the line
       - awk '{ printf $0}'
         - awk command to print out a line of text without a '\n'
         - as compared to awk '{ printf $0 "\n" }'
       - sed '/^$/d'
         - "d"elete all empty lines

  1. The Command Line Interface versus the Graphical User Interface
     - Hierarchical File System and Naming (tree)
     - Navigation: cd, pushd, popd (stack)
     - Examination: ls -lF
     - Execution:  open/start, subl
     - Modification: 
       - mkdir, touch 
       - rmdir, rm 
       - cp, mv, ln, ln -s 
     - Manual: man 

---
  1. Overview Tools and Resources
     1. Slack
        - actionable
        - images versus snippets
        - threads
        - editing
        - pins

  1. Class Material Walk Through:  README.md

  1. Syllabus

-- 
Stopped here
  1. Comp122 Landscape

  1. Lab: Walk Through


---
## Resources
  * Canonical: (Mathematics) relating to a general rule or standard formula.
  * Lots of good stuff in the bin and resources directory

---
## Notes
<!-- This section is for students to place their notes -->
