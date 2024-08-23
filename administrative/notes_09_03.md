# COMP122 Lecture Notes: September 3, 2024

## Announcements:
   1. No class on Monday September 2, 2024


## Today's Agenda:
   1. Review / Questions
      - List of CLI Commands

   1. Sublime Updates

   1. PEMDAS and Three Address Code

   1. Programming Assignment Overview


## Questions from Last Lecture/Lab, etc.:
   * M/W @ 9:00 am

   * T/R @ 9:00 am


## Review from Last-time:

   1. List of CLI commands
      ```bash
      cd
      chsh
      cp, mv    # cp A /tmp/
      echo
      git
      git add
      git clone
      git commit
      git config --global --list
      git config --list
      git log
      git push
      git status
      git branch
      git checkout
      ls -l -t -a
      mars
      mips_subroutine
      java_subroutine
      mkdir, rmdir, rm -r
      open                   # start
      pbcopy                 # clip
      pwd
      source
      ssh
      ssh-keygen
      subl
      touch, rm
      ```

      <!-- PROMPT_COMMAND='(( $? == 0 )) && echo success'  -->

---
# Today's  Material
  1. Make sure everyone is up-to-speed
     - The command line
     - Your comp122 environment
     - Walking through the logistics of git & assignments

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
     - https://classroom.github.com/a/DDeWVuqO
     - [Workflow cheatsheet](../reference/programming_workflow.md)

     - Review of Structure of the Repository
     - Review of the `countdown` Program
     - Review `make` and `sth`


  1. Participation Assignment (https://)



---
## Resources
   * reference/git-cheatsheet.png
   * tidbits/git-notes.md
   * tidbits/tidbit-git-merge.md 
   * bin/java_subroutine: a tool used to perform unit testing on a "j" subroutine



---
<!-- This section is for student's to place their own notes. -->
<!-- This section will not be updated by the Professor.   -->

# Notes 


