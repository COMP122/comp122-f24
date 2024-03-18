# SYSCALL functions available in MARS

## Introduction

A number of system services, mainly for input and output, are available for use by your MIPS program. They are described in the table below.  MIPS register contents are not affected by a system call, except for result registers as specified in the table below.


## How to use SYSCALL system services
  1. Load the service number in register \$v0. 
  1. Load argument values, if any, in \$a0, \$a1, \$a2, or \$f12 as specified. 
  1. Issue the SYSCALL instruction. 
  1. Retrieve return values, if any, from result registers as specified. 


## Example: display the value stored in \$t0 on the console 

   ```mips
   # Print the value in $t0 as a integer
   li  $v0, 1 
   mv $a0, $t0
   syscall
   ```


## Service Table


| Service Name     |  Number  | Input                              | Output         | C/Java Example         |
|------------------|----------|------------------------------------|-------------   |------------------------|
| Print Integer    |     1    | \$a0 = int                         |                | printf("%d", \$a0);    |
| Print Float      |     2    | \$f12 = float                      |                | printf("%e", \$a0);    |
| Print Double     |     3    | \$f12 = double                     |                | printf("%f", \$a0);    |
| Print String     |     4    | \$a0 = &str                        |                | printf("%s", \$a0);    |
| Read Integer     |     5    |                                    | \$v0           |                        |
| Read Float       |     6    |                                    | \$f0           |                        |
| Read Double      |     7    |                                    | \$f0           |                        |
| Read String      |     8    | \$a0 = \&buf, ||
|                  |          | \$a1 = bytes                       |                | scanf("%s", \$a0);     |
| Allocate Memory  |     9    | \$a0 = num_bytes                   | \$v0 = &buf    | bufp = malloc (\$a0);  |
| Terminate        |    10    |                                    |                | exit();                |
| Print Character  |    11    | \$a0 = char                        |                | printf("%c", \$a0);    |
| Read Character   |    12    |                                    | \$v0           | \$v0 = getc();         |
| File Open        |    13    | \$a0 = &name, ||
|                  |          | \$a1 = flags, ||
|                  |          | \$a2 = mode                        | $v0 = fd       | fd = open("name", flags, mode);  |
| File Read        |    14    | \$a0 = fd,    ||
|                  |          | \$a1 = &buf,  ||
|                  |          | \$a2 = bytes                       | $v0 = count    | count = read(fd, &buf, bytes);   |
| File Write       |    15    | \$a0 = fd,    ||
|                  |          | \$a1 = &buf,  || 
|                  |          | \$a2 = bytes                       | $v0 = count    | count = write(fd, &buf, bytes);  |
| File Close       |    16    | \$a0 = fd                          |                | close(fd);             |

# See Also:
  `~/classes/comp122/mips/macros/syscalls.s` for more service calls and for a more complete description
