# COMP122 Lecture Notes: September 3, 2024

## Announcements:
   1. No class on Monday September 2, 2024


## Today's Agenda:
   1. Review / Questions
      - List of CLI Commands

   1. Programming Overview


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
# Today's Lecture Material
  1. Updates to support Ubuntu within Windows/WSL
     - see revised setup.md file
  1. Make sure everyone is up-to-speed
     - The command line
     - Your comp122 environment
     - Walking through the logistics of git & assignments


# Today's Lab Material
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
        * bottom-right-hand corner -- select desired syntax
          - Open all with current extension as...
          - Select 'java'

  1. First Programming Assignment
     - https://

     - Review of Repository
     - Review of Countdown


  1. PEMDAS and Three Address code
     1. Solve the following equation:  ``a^2*x + b*x + c = 0``

        ![Quadratic Formula](Quadratic.formula.jpg)

     1. Rewrite into a single linear equation: ``$v0 = expression;``
        - use only the following operators: () * / + -
        - use the sqrt() function

     1. Rewrite into a series of linear equation
        - Each equation must be in TAC (Three Address Code)
        - That is to say, each equation must be in the one of the following forms:
          * temp = constant;
          * temp = variable;
          * temp = variable (op) variable;
          * temp = func(variable);
          * $v0  = temp;

     * Requirements:
       - 'temp' variables are named: $t1, $t2, $t3, .. $t9, etc.
       - each 'temp' variable can be used only once!

     
  1. Write Java Method to compute ``$v0 = 2*b + (a + b)/2``
     - Create a file called equation.j in the java subdirectory
     - Use the following template for your method
       ```java
   
       public static int equation(int a, int b) {
         int $v0;
         int $t0;
         int $t1;
         int $t2;
         int $t3;
   
         // Insert your statement to compute $v0 = s2*b + (a + b)/2`

         return $v0;
        }
        ```

     - Requirements:
        - Delete all unnecessary lines
        - Ensure proper formatting
        - Ensure your code complies with `java_subroutine` using "make"

     - Use `java_subroutine to fill in the following table`

       |  a    |  b   |  $v0  |
       |-------|------|-------|
       |   0   |  0   |  xxx  |   `java_subroutine equation 0 0`
       |   0   |  1   |  xxx  |   `java_subroutine equation 0 1`
       |   0   |  2   |  xxx  |   `java_subroutine equation 0 2`
       |   1   |  0   |  xxx  |   `java_subroutine equation 1 0`
       |   1   |  1   |  xxx  |   `java_subroutine equation 1 1`
       |   1   |  2   |  xxx  |   `java_subroutine equation 1 2`
       |   2   |  0   |  xxx  |   `java_subroutine equation 2 0`
       |   2   |  1   |  xxx  |   `java_subroutine equation 2 1`
       |   2   |  2   |  xxx  |   `java_subroutine equation 2 2`
      

   1. Write Java TAC Method to compute ``$v0 = 2*b + (a + b)/2``
      - Use your Java Method as a starting point
      - Transform your single linear equation into a series of TAC statements
      - Create a file called equation.j in the java_tac subdirectory
      - Use `java_subroutine` to validate your results

   1. Given Time:
      - Create one or more sth test case: 'template.sth_case'
      - Use make to test everything

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


