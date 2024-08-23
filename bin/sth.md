# Simple Testing Harness (sth)

   A set of scripts to facilitate automated testing of command-line programs. 

   The original or primary intent of the STH system is to facilitate the automated testing of Java and MIPS subroutines.  And as such, the STH system utilizes a driver program.  For our purposes, the two primary driver programs are: [java_subroutine and mips_subroutine](https://github.com/smf-steve/mips_subroutine/blob/main/README.md)

   The STH system, however, has been developed to function without a driver program.  Hence, creating greater functionality.

## Command Summary:
   1. sth_validate {pathspec}... 
      - Executes and validates each test case that is provided in {pathspec}
        * if a {pathspec} is a directory, then every file with .sth_case.
      - During execution:
        * each test case is validated
        * transcript of activities are emitted to stderr
        * a summary of activities is emitted to stdout
      - The exit status ($?) is set to 0 for SUCCESS, when ALL test cases pass

   1. sth_execute {pathspec}...
      - Similar to `sth_validate`, but with the following differences
        * the validating step is skipped 
        * no transcript of activities are emitted to stdout
        * no summary information is presented
     - The exit status ($?) is set to 0 for SUCCESS, when ALL test cases pass

## Demonstrative Example

   Consider our example program[^1] that calculates the sum of a series of number from 1..10.  For example.

   ```bash
   $ sum 1 10
   55
   $
   ```

   As part of the software development process, we need to perform extensive testing to validate our programs work to the defined specification.  To automated this testing, we can create a set of test cases and then execute each of these test cases in turn. 

   We have defined two such test cases within the files `sum_1..10.sth_case` and `sum_0..10.sth_case`.  We can then use the `sth_validate` command to execute these two test case.  As a result, we can detect a problem with the "sum" program.

   * Test case 1:
      ```bash
      $ sth_validate sum_1..10.sth_case
      # Testing:   ./sum 1 10
      55

      Summary: 1/1  (Passed/Count)
      ```

   * Test case 2:
      ```bash
      $ sth_validate sum_0..10.sth_case
      # Testing:   ./sum 0 10
      54
      # ==========================
      # Error: Correct Output is:
      # ==========================
      55
      # ==========================

      Summary: 0/1  (Passed/Count)
      ```

   Obviously, we don't want to execute each of these test cases manually.  The 'sth_validate' command allows you to provide a list of files, and each file is processed in term.  If one of these files is a directory, all files with a .sth_case extension is added to the list of test cases to process. 

   Consider the following example where the first argument to sth_validate is the current working directory (.).  In this case, all the files within the current working directory (.) is executed.  A summary message is provided at the end of execution.

   * Test case 3:
      ```bash
      $ sth_validate .
      # Testing:   ./sum 0 10
      54
      # ==========================
      # Error: Correct Output is:
      # ==========================
      55
      # ==========================

      # Testing:   ./sum 1 10
      55
   
      Summary: 1/2  (Passed/Count)
      $ echo $?
      1
      $
      ```

   * Example .sth_case files

      ```bash
      $ cat sum_1..10.sth_case
      [case]
      ENTRY=./sum
      ARGS='1 10'   
      OUTPUT="55"
      $ cat sum_0..10.sth_case
      [case]
      ENTRY=./sum
      ARGS='0 10'
      OUTPUT="55"
      $
      ```

   Notice in these three examples, the value of DRIVER and OPTIONS undefined, since there is no need for a driver program.  See below for an example that uses a driver program.

   [^1] All these tests cases are in the [example](https://github.com/smf-steve/sth/tree/main/example) subdirectory


# Example with a Driver Program

For our purpose, we want to perform unit testing of a subroutine that is contained within a program.  In this situation we need a driver program 

   - to map stdin and stdout
   - to marshal the arguments for the ENTRY subroutine
   - to invoke the ENTRY subroutine
   - to capture the subroutines return value

A driver program is a command with potiential options that is used to specific test a subroutine.  This subroutine as known as the ENTRY point into the program.  You may also think of the driver programs as a command that has a set of defined subcommands.  Using our VARIABLE terminology, these subcommands is defined using the ENTRY VARIABLE.

In COMP122, we use the program `java_subroutine` to unit test an individual Java method. One such subroutine is `binaryReal` converts a real number in any base to the equivalent real number in base 2. Consider the following true mathematical equation:

   * 8# 1234.43  ==  2# 1010011100.100011

The following command line illustrates the execution of the `binaryReal` subroutines to convert "8# 1234.43" to binary.

  ```bash 
  $ cat /dev/null | java_subroutine  -L . -S binaryReal 8 "\#" 1234 "." 43
  2# 1010011100.100011
  $ echo $?
  0
  ```

To efficiently perform unit testing, we need to test the binaryReal subroutine with many test cases.  These test cases can be placed into a single file, say 'binaryReal.sth_case' and then executed via the `sth-validate` program as follows:

   ```bash
   $ sth_validate binaryReal.sth_case 2> /dev/null
         Summary: 45/45  (Passed/Count)
   $ echo $?
   0
   ```
Notice that the exit value of `sth_validate` is 0.  This indicates that ALL test cases have passed.  An except of the binaryReal.sth_case is as follows:

  ```bash
  $ head -20 binaryReal.sth_case 
  [global]
  INPUT=  
  EXIT_STATUS=0
  
  [default]
  DRIVER=java_subroutine
  OPTIONS="-L ." 
  ENTRY=binaryReal
  
  [case]
  ARGS='10 \# "1234\0" . 4321'   
  OUTPUT="2# 10011010010.01101110100111100001101"
  
  [case]
  ARGS='16 \# FACE . DEAF'
  OUTPUT="2# 1111101011001110.11011110101010110011011"
  
  [case]
  ARGS='8 \# 1234 . 4300000'   
  OUTPUT="2# 1010011100.100011"
  $
  ```


## Test-case (.sth_case) File Format

By convention, test-cases are defined within a file with an .sth_case extensions.  Such a file may contain one or more test cases. The file is separated into one of three types of stanzas.  One of the following labels is used to start a stanza.

  1. The "[default]" label delineates the default values used for all test cases within the file.
  1. The "[case]" label delineates the start of a single test case
  1. The "[global]" label delineates the global values which override all values associated with a test case.

The processing of the file begins within an implicit "[case]" stanza.  That is to say any file without a label to start a stanza defines a single test case.

Within each stanza, two or more of the following variables can be defined:

  | VARIABLE    | Description                        | Example                  | Default   |
  |-------------|------------------------------------|--------------------------|-----------|
  | DRIVER      | The default driver program         | java_subroutine          | ""        |
  | OPTIONS     | The options passed to ${DRIVER}    | "-L ."                   | ""        |
  | ENTRY       | The entry point to start testing   | binaryReal               |           |
  | ARGS        | The arguments passed to ${ENTRY}   | '8 \# 1234 "." 4300000'  | ""        |
  | INPUT       | The provided input (stdin)         |                          | /dev/null |
  | OUTPUT      | The expected output (stdout)       | "2# 1010011100.100011"   | /dev/null |
  | EXIT_STATUS | The expected exit value            | 0                        |           |

Notice that there are no default values for ENTRY and EXIT_STATUS; these values must be defined.

Given the example values above, the following command line is executed by 'sth_validate'.  In the example below, we also present the expected output and return value--for a success test.

  ```bash 
  $ cat /dev/null | java_subroutine  -L . -S binaryReal 8 "\#" 1234 "." 4300000
  2# 1010011100.100011
  $ echo $?
  0
  ```

Notes:
   - the value of INPUT can either be a string or a filename
   - the value of OUTPUT can either be a string or a filename


## External Environment Variables

You can modify the behavior of the 'sth_validate' and 'sth_execute' by the use of environment variables.  The variables can be used to override particular VARIABLE for a test case.  The following environment variables are defined:

  | VARIABLE          | Overrides Variable with .sth_case files |
  |-------------------|-------------|
  | STH_DRIVER        | DRIVER      |
  | STH_OPTIONS       | OPTIONS     |
  | STH_ENTRY         | ENTRY       |
  | STH_ARGS          | ARGS        |
  | STH_INPUT         | INPUT       |
  | STH_OUTPUT        | OUTPUT      |
  | STH_EXIT_STATUS   | EXIT_STATUS |

Additionally, you can define the STH_EXECUTE_ONLY to be "TRUE" to modify the behavior of sth_validate to be equivalent to sth_execute.



## Features, Limitations, Bugs:

  1. Although there can only be one set of "[global]" and "[default]" VARIABLES within a sth configuration file,  both labels can occur multiple times.  All the defined variables within these stanza are merged together to create a single stanza block.  The following two configurations are equivalent:

     1. Example where the "[global]" stanza directives are presented together.
        ```
        [global]
        DRIVER=
        OPTIONS=
        INPUT=/dev/null
        OUTPUT=/dev/n
         
        [case]
        ENTRY=sum
        EXIT_STATUS=0
     ```

     1. Example where the "[global]" stanza directives are split into two sections.
         ```
         [global]
         DRIVER=
         OPTIONS=
           
         [case]
         ENTRY=sum
         EXIT_STATUS=0
         
         [global]
         INPUT=/dev/null
         OUTPUT=/dev/null
         ```




