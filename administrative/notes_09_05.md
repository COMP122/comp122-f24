# COMP122 Lecture Notes: September 5, 2023

## Announcements:
   1. Because of No class on Monday September 2, 2024
      T/R has an extra day -- which is today.
   1. For Ubuntu User:
      1. subl does not launch via the CL?
         - https://kskroyal.com/run-ubuntu-24-04-on-windows-11-with-gui-using-wsl/
      1. A markdown view for Ubuntu
         - https://snapcraft.io/install/mdview/ubuntu
         - mdview {filename}
   1. MacOS users might want to install mdview -- I plan on switching
      - install go: `https://go.dev/doc/install`
      - install mdview: `sudo go install github.com/mapitman/mdview@latest`

## Today's Agenda:
   1. Review, More Git, and Individual Support
   1. Install MIPS syntax package into sublime
   1. MD Assignment Walk Through
   1. PEMDAS and Three Address Code
   1. Programming Assignment Overview

## Questions from Last Lecture/Lab, etc.:
   * M/W @ 10:00 am

   * T/R @ 10:00 am

# Today's Lecture Material
  1. Review Questions
  1. Oh my Git
  1. Subl support from the CLI
     - Need help?

  1. Install MIPS syntax package into sublime
     - "Install Package Control"
        * cmd+shift+p  or Windows+shift+p or Ctrl+shift+p
        * Install Package Control
      - Install mips syntax
        * cmd+shift+p or Windows+shift+p
        * Package Control: Install Package 
        * mips-syntax
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
     - URL: https://classroom.github.com/a/DDeWVuqO
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
<!-- This section is for student's to place their own notes. -->
<!-- This section will not be updated by the Professor.   -->

# Notes  
