# Simple Testing Harness (sth)

## Commands: (Bash functions)
   1. sth_validate {directory | file} [ {driver} ]
      - for each of the {test}.config and {test}.case files in {directory}
        executes and validates each associated test case.
      - the optional {driver} overrides the {DRIVER} value defined within {test}.config
      - a summary of activities is emitted to stdout
      - a transcription of activities is emitted to stderr

   1. sth_execute {directory | file} [ {driver} ]
      - Identical functional of sth_validate except for the generated output
      - Output is restricted to that the execution and not the validation process. I.e., 
        - no summary information is presented to stdout
        - no transcription of activites is presented to stderr
      - useful prior to the automated testing/validation process

        
## Files:
   1. sth.bash: a bash script that is inteded to be source into the user environment
   1. sample.config: a sample configuration file for a set of test cases
   2. sample.case: a sample configuration file for a single test case

## Example Usages:
* To execute the following test case in an automated fashion:

  ```bash
   mips_subroutine -L '*.j' binaryReal 10 \# "1234\0" . 4321
  ```
  
1. sth_execute: to execute -- without any validation -- of the 
```bash
$ sth_execute ../test_case/binaryReal_0.case mips_subroutine
2# 10011010010.01101110100111100001101
#########################################
# Above is the output from your program
#########################################

v0:         10; 0x00 00 00 0A; 0b0000 0000 0000 0000 0000 0000 0000 1010;
$
```

Contents of ../test_case/binaryReal_0.case
```
PROG=
OPTIONS="-L '*.j' -S"
ENTRY=binaryReal
INPUT=  
ARGS='10 \# "1234\0" . 4321'   
OUTPUT="2# 10011010010.01101110100111100001101"
RETVAL=10
```


1. sth_validate: to execute and to validate the results

```bash
$ sth_validate ../test_cases/binaryReal_1.case java_subroutine
Testing: java_subroutine -L '*.j' -S binaryReal 10 \# "1234\0" . 4321
    Error: Incorrect Output
Correct Output followed by Your Output
==============
2# 10011010010.01101110100111100001101
==============
2# 10011010010.01101110100111100001101
#########################################
# Above is the output from your program
#########################################

v0:         10; 0x00 00 00 0A; 0b0000 0000 0000 0000 0000 0000 0000 1010;

==============
    Error: Expected Return Value: 10
           Your Return Value: 0

Summary: 1/1  (Passed/Count)
```
