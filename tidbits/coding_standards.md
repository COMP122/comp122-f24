# COMP122: Initial Coding Standards for MIPS 

1. Start off with the Template provided by
	- the Professor and/or the team

1. Review any starter code provided
   - make sure it assembles and runs as designed
   - make sure you understand what it does

1. Presume changes will be made the program specification, starter code, and test cases
   - Periodically a pull operation to get any updates
     ```
     git fetch                   # Get a fresh copy of the remote repository
     git diff origin main        # Check to how much has changed, and make decisions about what to do
     git pull                    # Incorporate the remote repository into your local repository
     ```

1. Frequently make commits to your local repository
   - anytime you take a break
   - anytime you have made substantial progress on your development
   - anytime you reach a milestone
   
1. Frequently synchronize your remote repository and local repositories
   - (Future) Use branches to maintain code under development

1. Authorship
   - List your name and any team members at the top of the source file
   - Create a contributors file that enumerates team members
   
1. Subroutine file
   - each assemble file should contain a single global subroutine
   - use the '.globl' directive at the top of your file

1. Algorithm
   - Write your algorithm in JAVA TAC
     - compile the code using 'java_subroutine'
     - test your code to ensure it works as it should
   - place the JAVA TAC side-by-side with your MIPS code
   - transliterate your JAVA TAC algorithm to produce your MIPS code

1. Indentation
	- first 16 columns are used for labels
	- global labels must be placed in column 1
	- local labels must indented 
	- indent blocks of code associated with control flow

1. Macros and local subroutines
    - create macros and local subroutines (as appropriate) to make your code more readable
    - place local macros at the top you file
    - place common macros in an include file

1. Final Submissions
  - If it does not assemble, do not turn it!
  - If you don't test it, don't turn it in!
  - If it executes an infinite loop, don't turn it it!
    - use the test cases provide to validate before submission
    - develop additional test cases
    - feel free to share test cases with your colleagues 


