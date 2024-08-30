# COMP122 Lecture Notes: August 28, 2024

## Announcements
   1. No class on Monday September 2, 2024


## Today's Agenda
   1. Pickup where were left off
      - but first, some shell priming 
   1. SSH : Walk through of github authentication
   1. Git
   1. Walk through of the assignments

## Questions from Last Lecture/Lab, etc.:
   * M/W @ 10:00 am
     1. 

   * T/R @ 10:00 pm
     1. What is PNJ?
     1. What is subl?


---
# Today's Material
  1. The shell
     1. Features in a Programming Language
        - variables:  classes, integers, floats
          ```bash
          X=" hello"
          echo $X
          ```
        - control structures: while-loop, do-loop, if-then-else, switch/case, for-each
        - subroutine: methods, functions, procedure, co-rountines

     1. Syntactical Structure:
        - semicolons to end a statement


     1. Anatomy of the Command Line
        - command, subcommands
        - arguements
        - options
        - files
          * stdin (0), System.in
          * stdout (1), System.out
          * stderr (2), System.err

  1. Pickup where were left off

---
  1. Git
     - A version control system (VCS) that utilizes a repository
       - repository: a complete copy of an entire project _throughout_ its lifetime  
       - commit:  a specific point in time in the life of a repository

     - Command reference `open ../reference/git-cheatsheet.png` and Major Components
        - remote repository (origin/main) (upstream)
        - local repository 
        - staging/index
        - working directory

     - Additional Concepts: (Foreshadowing future stuff)
       - branch:  an offshoot of "official" evolutionary path of the repository
         - merge: a commit point where branch information is combined with another branch

  1. Walk through of evolution of a repository
     - Straight Line Development
     - Feature Creation (common method)

  1. List of most common commands for COMP122  (at least for a while)
     | command            | comment                                                         |
     |--------------------|-----------------------------------------------------------------|
     | `git clone`        | Get the assignment.                                             |
     | `git pull`         | Get any updates related to the assignment.                      |
     | `subl`             | Work on the assignment (well not a git command).                |
     | `git add`          | Set the "stage" for your next version repository                |
     | `git commit`       | Put the file into the local reposition.                         |
     | `git log` (--graph)| View the history of your repository                             |
     | `git status`       | Get the status of working directory and the local repo          |
     | `git repo-status`  | Get the status of your local and remote repositories            |
     | `git reset --hard` | Aargh, I screwed up, lets go back to the last valid version.    |
     | `git tag`          | Assigning a name to a commit                                    |
     | `git checkout`     | Go backwards and forwards in time to view a version of the repo |
     | `git pull-request` | Review what your are submitting as part of the assignment       |



---
## Resources
  * https://git-scm.com
  * 'bin/Oh\ My\ Git\!'
  * https://docs.github.com/en/get-started/quickstart/hello-world
  * https://github.com/classroom-resources/github-starter-course


---
<!-- This section is for student's to place their own notes. -->
<!-- This section will not be updated by the Professor.   -->

# Notes 







