# COMP122 Lecture Notes: September 9, 2024

## Announcements:
   1. Oh my Git:  
      ```bash
       oh_my_git  # Works only for MacOS with the M1 chip
      ```
     * For other users, download it from: https://ohmygit.org

   1. Starting New Section:  
      - Models of Communication and Computation
      - `cd ~/classes/comp122/models-comp-comm`

## Today's Agenda:
   1. Lecture: models-comp-comm/slide*/models.pdf
   1. Lab:
      1. PEMDAS and Three Address Code
      1. Programming Assignment Overview


## Questions from Last Lecture/Lab, etc.:
   * M/W @ 10:00 am
     - How do I know if....I submitted things correctly?
       1. run `make validate`: checks minimum requirements
       1. run `make confirm`: 
          - `make validate`, and 
          - shows you what the prof sees
       1. check the web page:

   * T/R @ 10:00 am


## Review from Last-time:

   1. Submission of assignment via the CLI
      ```bash
      cp assignment.md submission.md
      subl submission.md
      make response_key
      git add {filename}
      git commit -m {message}
      make validate
      git pull ; git push
      git push origin submitted
      make confirm
      ```
   1. MIPS packages..
   1. PEMDAS -- (not quite on MW)

---
# Today's Lecture Material

  1. See Slides


# Today's Lab Material

  1. Install MIPS syntax package into sublime
     - "Install Package Control"
        * cmd+shift+p  or Windows+shift+p or Ctrl+shift+p
        * Install Package Control
      - Install mips syntax
        * cmd+shift+p or Windows+shift+p
        * Package Control: Install Package 
        * 'mips syntax'
      - Associate Java Syntax with all .j files within Sublime Text
        * New File (%N)
        * Save as `equation.j`
        * Bottom-right-hand corner -- select desired syntax
          - Open all with current extension as...
          - Select 'java'

  1. PEMDAS and Three Address Code (TAC)
     1. Run the command:  `subl -n quad.j`

     1. Solve the following equation:  ``a^2*x + b*x + c = 0``

        ![Quadratic Formula](quadratic_formula.png)

     1. Rewrite into a single linear equation: ``x = expression;``
        - use only the following operators: () * / + -
        - use the sqrt() function

     1. Rewrite into a series of linear equation
        - Each equation must be in TAC (Three Address Code)
        - That is to say, each equation must be in the one of the following forms:
          * variable = literal;
          * variable = variable;
          * variable = variable (op) variable;
          * variable = func(variable);

     * Requirements:
       - 'temp' variables are named: t1, t2, t3, ...
       - each 'temp' variable can be defined only once!

  1. Programming Assignment Overview
     - nit URL: https://classroom.github.com/a/DDeWVuqO
     - cruft
     - [Workflow cheatsheet](../reference/programming_workflow.md)

     - Review of Structure of the Repository
     - Review of the `countdown` Program
     - Review `make` and `sth`


  1. Participation Assignment (https://classroom.github.com/a/DDeWVuqO
     - README.md

---
## Resources
   * reference/git-cheatsheet.png
   * tidbits/git-notes.md
   * tidbits/tidbit-git-merge.md 

---
<!-- This section for student's to place their own notes. -->
<!-- This section will not be updated by the Professor.   -->

## Notes  


