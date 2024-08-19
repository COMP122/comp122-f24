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
  1. Made sure everyone is up-to-speed
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


  1. PEMDAS and Three Address code
  1. Assignment:
     1. Given equation
        ```
        4 * a + b^2  - 4 * a * b / a
        ----------------------------
            2 * b
        ```
     1. Rewrite into a single linear expression
     1. Rewrite into a single linear equation that contains only the operators: () * / + -
     1. Define a linear equation of the form `$v0 = expression;`
     1. Rewrite into a series of linear equation
        - Each equation must for of one of the following forms:
          *  temp = constant;
          *  temp = variable;
          *  temp = variable + variable;
          *  temp = variable - variable;
          *  $v0 = temp;

       - you are given a set of local variables:  $t1, $t2, $t3, .. $t9, $v0
       - each variable can can be defined once
       - place the final value into $v0

     1. Write a java subroutine using the following template to compute the value of $v0
        - Place this subroutine in the file named equation.j
          ```java
   
          public static int equation(int a, int b) {
            int $v0;
            int $t0;
            int $t1;
            int $t2;
   
            // Insert your series of equations that define $v0 after this line
   
            // 
            return $v0;
          }
          ```

       * Requirements
         - delete all unnecessary lines
         - ensure proper formatting
         - ensure your code complies with `java_subroutine`

    1. Use `java_subroutine to fill in the following table`

       |  a    |  b   |  $v0 |
       |-------|------|------|
       |   0   |  0   |   error   |   `java_subroutine equation 0 0`
       |   0   |  1   |      |   `java_subroutine equation 0 1`
       |   0   |  2   |      |   `java_subroutine equation 0 2`
       |   1   |  0   |      |   `java_subroutine equation 1 0`
       |   1   |  1   |   0   |   `java_subroutine equation 1 1`
       |   1   |  2   |   2  |   `java_subroutine equation 1 2`
       |   2   |  0   |      |   `java_subroutine equation 2 0`
       |   2   |  1   |      |   `java_subroutine equation 2 1`
       |   2   |  2   |      |   `java_subroutine equation 2 2`
      

---
## Resources
   * reference/git-cheatsheet.png
   * tidbits/git-notes.md
   * tidbits/tidbit-git-merge.md 
   * bin/j_subroutine: a tool used to perform unit testing on a "j" subroutine

---
## Notes
<!-- This section is for students to place their notes -->


this is my students
