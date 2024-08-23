
### NAME
    mips_subroutine – execute a MIPS subroutine

### SYNOPSIS
    
  1. mips_subroutine entry [ arg ... ]

     In the simplest form, entry is the name of the subroutine followed by a list of arguments. A file, named
     'entry.s' must contain the subroutine 'entry'.

  1. mips_subroutine [-L file] [-A type] [-R type] entry [ arg ... ]

     In this extend form, a list of command line options can be provided to load a set of files, to declare
     the argument type, and to declare the return type.

  1. mips_subroutine [-b before] [-a after] entry [ arg ... ]

     In this extend form, the user can specify a set of instructions to be executed before or after the execution of the 'entry' subroutine.  Such instruction can be useful to prepare the environment or to transform the output of the subroutine.  In the following example, the 'decode' subroutine is called
     after the execution of the 'encode' subroutine.  In such a case the command line argument should match 
     the output.

     ```bash
     $ mips_subroutine -a 'jal decode' encode 43
     43
     ```

     Two predefined uses of the '-a' option are provided to simplify the command line.

        * mips_subroutine [-t] [-r reg] entry [ arg ... ]

     In this form,  all the $t0 registers are printed to stdout via the `-t` option.  An number of 
     specific registers can be printed to stdout via the `-r` option

  1. mips_subroutine [-f frame] entry [ arg ... ]

     In the final form, the structure of the frame can be specified.  Their are three frame types:  
       - adhoc: There is no formal structure defined for a frame.  The stack can be used in an ad-hoc manner.
       - register: This is default frame structure used by MIPS programs where some information is passed via registers
       - full:  This frame structure uses the stack to pass all arguments.


  Note that all of the above command line options can be used together, and can be presented on the command line in any order, any number of times,


### DESCRIPTION
    A MIPS subroutine is assembled and executed.  It is presumed that this subroutine is 
    defined within the file `entry`.s, and has a label `entry` which serves as the entry 
    point for code execution.  The subsequent command line arguments are processed and 
    then passed as parameters to the subroutine `entry`.  

    Each argument's type is interpreted as the simplest type possible, using the duck rule. 
    That is to say, if it looks like a duck, it is a duck.  As such, the argument "3" is passed 
    as an integer, the argument "3.2" is passed as a double, and whereas the argument "3\0" is passed 
    as a string.  The '-A' option can be used to define the type of all input arguments.

    Each of the `arg` values are then passed to the subroutine using the MIPS subroutine convention.
    That is to say the first 4 arguments are staged in $a0 - $a4 (for integers) or $f12 and $f14 
    (for doubles), and subsequent arguments are positioned on top of the stack. 
    (Three different frame types can be used, which impacts the location of these arguments on
    the stack.)

    After execution, the return value of the subroutine is printed on stdout. It is presumed that 
    the return value is an integer.  The '-R' option can be used to define the type of the return value.


### COMMAND LINE OPTIONS
    The following options are available to manage the input:

      -L {file} : load/link the named directory or files to be part of the final program.  

      -A {type} : defines the base type for ALL input arguments. 
                  The value of type can be: integer, long, char, string, and double

      -A argv   : passes the input arguments as via the standard argv structure.
                  Implies that the base type of input arguments are strings.

      -R {type}: specifies the return type from the subroutine.  The return value
         of the subroutine is emitted to stdout after the user output. The
         return types include:
           - null:    no return value is emitted
           - integer: an integer value (the value of $v0)
           - long:    a long integer value of (the value of $v1/$v0)
           - string:  a "string" 
            
         Future options include:
           - float:   a single precision real number (the value of $f0)
           - double:  a double precision real number (the value of $f0-$f1)

         Array data types are also to be supported 
           - the value of $v0 is the address of the array
           - the value of -4($v0) holds the actual length of the array
             - int[n]:   an array of integers 
             - long[n]:  an array of long integers
             - char[n]:  an array of characters
             - float[n]:  an array of single precision real numbers
             - double[n]: an array of double precision real numbers
             (where n is a number)

      -a {instructions} : execute the instruction after the subroutine

      -b {instructions} : execute the instruction before the subroutine

      -r reg_list: dump the registers in the reg_list
        
          A reg_list is a comma separated list of registers numbers names,
          a range may also be provided -- but not implemented yet.
          Examples:
           * -r s0,s2,t1-t5,f2
           * -r 16,18,9-15,f2

      -t  : dump the $t0 - $t9 registers 


### WARNINGS
    It is expected that the subroutine follows the MIPS convention regarding the 
    restoration of registers. As such, the following messages may appear on stdout.

   * Warning: One or more of the S registers were not restored.
   * Warning: The $fp register was not restored.
   * Warning: The $sp register was not restored.
   * Warning: Subroutine did not return properly"


### ENVIRONMENT_VARS
    The following environment variables affect the execution of mips_subroutine:

    MARS_JAR:          The location of the Mars jar file
    MIPS_VALIDATE:     TRUE (default)
    MIPS_SUB_FRAME:    ad-hoc
    MIPS_SUB_AFTER:    The default after instruction
    MIPS_SUB_BEFORE:   The default before instruction
    MIPS_SUB_RETURN:   The default return value 

### BEFORE and AFTER INSTRUCTIONS

    Specific instructions can be injected into the execution environment.  These instructions have
    full access to the machine and can be used to achieve a large number of results.  As per the name
    of the command line options, said instructions are executed either just prior to or just after the
    invocation of the 'entry' subroutine.  

    The return values and exit status of the 'entry' subroutine are saved in memory.  This allows 
    several independent routines to be called in turn to examine the results of the 'entry' subroutine.
    Saving and restore these values can be performed via the following macros:

      * restore_exist_status()
      * save_exit_status()
      * restore_return_values()  
      * save_return_values()

    Consider the following examples:

    * mips_subroutine -b 'li $t0, 42' entry  1 2 3 4
      - defines the values of the $a0 - $a3 registers with the following values respectively: 1 2 3 4
      - loads the value of 42 into the $t0 register
      - executes the entry subroutine

    * mips_subroutine -a 'nmv $a0, $v0\njal post_filter' entry 1 2 3 4
      - defines the values of the $a0 - $a3 registers with the following values respectively: 1 2 3 4
      - executes the entry subroutine
      - moves the return value of 'entry' ($v0) into the $a0 register
      - executes the post_filter subroutine

    * mips_subroutin -b precondition.txt -a 'move $a0, $v0' -a postfilters.txt entry 1 2 3 4
      - defines the values of the $a0 - $a3 registers with the following values respectively: 1 2 3 4
      - executes the code contained within the precondition.txt file
      - executes the entry subroutine
      - moves the return value of 'entry' ($v0) into the $a0 register
      - executes the code contained within the postfilters.txt file, which contents the following instructions

      ```
      jal prefilter1
      restore_return_values()  
      jal prefilter2
      restore_return_values()  
      jal prefilter3
      print_register("$s0", $s0)
      ```

### EXPECTION, LIMITATIONS and BUGS
    If an argument conforms to the syntax of a number, but is malformed,
    the shell will report an error and stop. For example,

       $ mips_subroutine func 4#456
       bash: 4#456: value too great for base (error token is "4#456")

### FUTURE WORK

Possible future work includes:

   1. Provide support for array inputs.  For example:
      ```bash
      mips_subroutine entry [ 1 22 333 ]
      ```
      
      The internal structure 
         - $a0 : is the address of the first input argument
         - -4($a0) : contains the length of the array
         - 0($a0)  : contains the value of '1'
         - 4($a0)  : contains the value of '22'
         - 8($a0)  : contains the value of '333'


### EXIT STATUS

    Upon success, the mips_subroutine exits with the value of $v0.
    This value, however, is restricted to the range 0..255

    Upon failure, the mips_subroutine exits with the value of 255.
    Possible failures include:
      - MARS assemble error:
        * various syntax errors have been detected
      - MARS linkage error
        * one or more subroutines are not defined
      - MIPS Calling Convention error
        * one or more of the save registers have not been restored
        * the stack or frame point have not been restored

    Refer to the stdout for additional information related to errors.  Ideally,
    such messages should be sent to stderr. However, bother Java and MARS
    (which is used internally) emit error messages to stdout.

    An "AFTER" routine may modify the original 'exit status' by storing
    a new value into the variable exit_status (e.g., sw $v0, exit_status)


