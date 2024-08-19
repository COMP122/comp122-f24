# README.md:

This directory contains a set of macros for MIPS.
The cononical location of these macros are defined in 
http://www.github.com/smf-steve/mips_subroutine/macros


## Files:
1. io.s: macros that extend IO operatons related syscalls
1. frames: macros that support subroutine calls
   - frames_ad-hoc.s:  using ad-hoc frames
   - frames_register.s: using  the MIPS convention with registers
   - frames_full.s: using frames that don't use registers
1. stack.s: macros that perform stack operations
1. syscalls.s: macros that directly wrap syscalls


## API

### File: "io.s":

The following macros/methods are provided to extend the basic I/O system calls.  These
macros are designed to preserve the values in preexisting register.  

For the following two macros, the value of the "$v0" register contains the value read.

| Name                           | Description                                    |
|--------------------------------|------------------------------------------------|
| read_x()                       | reads a hexidecimal value                      |
| read_t()                       | reads a binary value value                     |


| Name                            | Description                                    |
|---------------------------------|------------------------------------------------|
| print_null()                    | print nothing                                  |
| print_quote(%str)               | print a quoted string                          |
| print_register(%name, %reg)     | print the contents of a register               |
| print_bits(%reg, %start, %stop) | print a range of bits within a register        |
| print_binary32(%reg)            | print the bit representation of a binary32     |
|

Note that ech print operation each forces a newline to be printed after the operation
is performed

| Name                           | Description                                    |
|--------------------------------|------------------------------------------------|
| println_d(%reg)                | print a value as a decimal                     |
| println_di(%imm)               | print an immediate as a decimal                |
| println_u(%reg)                | print a value as a unsigned decimal value      |
| println_ui(%imm)               | print an immediate as unsigned decimal         |
| println_x(%reg)                | print a value as a hexidecimal value           |
| println_xi(%imm)               | print an immediate as a hexidecimal value      |
| println_t(%reg)                | print a value as a 32-bit binary value         |
| println_ti(%imm)               | print an immediate as a 32-bit binary value    |
|                                |                                                |
| println_c(%reg)                | print a value as an ASCII charater             |
| println_ci(%imm)               | print an immediate as an ASCII character       |
| println_s(%reg)                | print a string given it's address              |
| println_si(%label)             | print a string given it's label                |
|                                |                                                |
| println_f(%reg)                | print a floating point number                  |
| println.s(%reg)                | print a single floating point number           |
| println.d(%reg)                | print a double floating point number           |
|                                |                                                |
| println_binary32(%reg)         | print a value as a formated binary 32 value    |
| println_register(%name, %reg)  | printa a register prefixed with a name         |
|                                |                                                |
| println_null()                 | print nothing                                  |



#### Array Versions

The following macros are provided to print out an array of values.
There are no equivalent methods provided for Java.


| Name                       | Description                                |
|----------------------------|--------------------------------------------|
| println_d(%array, %count)  | print an array of decimal numbers          |
| println_u(%array, %count)  | print an array of unsigned decimal numbers |
| println_x(%array, %count)  | print an array of hexidecimal nubmers      |
| println_t(%array, %count)  | print an array of binary numbers           |
|                            |                                            |
| println_c(%array, %count)  | print an array of characters               |
| println_s(%array, %count)  | print an array of strings                  |
|                            |                                            |
| println.d(%array, %count)  | print an array of doubles                  |
| println.s(%array, %count)  | print an array of single                   |
|                            |                                            |
| println_binary32(%reg, %count)   | print an array of binary32 values    |



### Files: "ad-hoc_frames.s", "full_frames.s", and "register_frames.s":

The following macros are defined to support the use of frames within a MIPS subroutine.
There are no equivalent methods provided for Java.

See [frames.md](./frames.md) for additional information. Note that reference to the stack
in the table below can 

| Name                        |   Desription                                           |
|-----------------------------|--------------------------------------------------------|
| set_frame()                 | Sets the starting point of a frame                     |
| unset_frame()               | Unset the reference to the current frame               |
|                             |                                                        | 
| add_locals(%count)          | create space on the stack for local variables          |
| remove_locals(%count)       | remove the space on the stack used by local variables  |
|                             |                                                        | 
| marshal_inputs(...)         | marshal the first 4 input arguments into registers     |
| stage_formals(...)          | stages arguments onto the stack                        |
| unstage_formals(...)        | delete arguments from the stack                        |
|                             |                                                        | 
| demarshal_inputs(...)       | place the first 4 input arguments into registers       |
| load_additional_inputs(...) | load the remaining arguments into registers            |
|                             |                                                        | 
| marshal_return(%reg)        | marshal the return value from the named register       |
| demarshal_return(%reg)      | place the return value into the named register         |
|                             |                                                        | 
| alloc_return()              | allocate space for the return value                    |
| stage_return(%reg)          | stage the return value onto the stack or register      |
| unstage_return(%reg)        | delete the return value form the stack                 | 



### File: "stack.s"
| Name                        | Description                                            |
|-----------------------------|--------------------------------------------------------|               
| alloca(%reg)                | Allocates space on the stack                           |
| allocai(%imm)               | Allocates space on the stack                           |
|                             |                                                        |
| push(%reg, ...)             | Pushes a list of registers onto the stack, left->right |
| pop(%reg, ...)              | Pops a list of registers from the stack, right->left   |
|                             |                                                        |      
| push_s_registers()          | Pushes all the S registers                             |
| pop_s_registers()           | Pops all the S registers                               |
| push_t_registers()          | Pushes all the T registers                             |
| pop_t_registers()           | Pops all the T registers                               |
|                             |                                                        |
| alloca_adjust(%dst, %reg, %mask) |  Adjust the amount amount to allocate to be word aligned |      


### File "syscalls.s":

| Name                         | Description                                    |
|------------------------------|------------------------------------------------|
| sbrk(%reg)                   | Allocates space by "s"etting the break point   |
| sbrki(%imm)                  | Allocates space by "s"etting the break point   |
| allocate(%reg)               | Allocates space (calls sbrk)                   |
| allocatei(%imm)              | Allocates space (call sbrki)                   |
|                              |                                                |
| exit([ %reg ])               | Sets exit status to value provided             |
| exiti(%imm)                  | Sets exit status to value provided             |
|                              |                                                |
| open(%reg1, %reg2, %reg3)    | Opens a file, see 'man 2 open'                 |
| read(%reg0, %reg1, %reg2)    | Reads from a file, see 'man 2 read'            |
| write(%reg0, %reg1, %reg2)   | Writes to a file, see 'man 2 write'            |
| close(%reg)                  | Closes a file, see 'man 2 close'               |


| Name                         | Description                                    |
|------------------------------|------------------------------------------------|
| read_d()                     | read a decimal value                           |
| read_x()                     | see the "io.s" section                         |
| read_t()                     | see the "io.s" Section                         |
|                              |                                                |                  
| read_c()                     | read a signal character                        |
| read_s(%reg1, %reg2)         | read a string of a maximum length              |
| read_si(%reg1, %label)       | read a string of a maximum length              |


| Name                         | Description                                    |
|------------------------------|------------------------------------------------|
| print_d(%reg)                | print a value as a decimal                     |
| print_di(%imm)               | print an immediate as a decimal                |
| print_u(%reg)                | print a value as a unsigned decimal value      |
| print_ui(%imm)               | print an immediate as unsigned decimal         |
| print_x(%reg)                | print a value as a hexidecimal value           |
| print_xi(%imm)               | print an immediate as a hexidecimal value      |
| print_t(%reg)                | print a value as a 32-bit binary value         |
| print_ti(%imm)               | print an immediate as a 32-bit binary value    |
|                              |                                                |
| print_c(%reg)                | print a value as an ASCII charater             |
| print_ci(%imm)               | print an immediate as an ASCII character       |
| print_s(%reg)                | print a string given it's address              |
| print_si(%label)             | print a string given it's label                |
|                              |                                                |
| print_f(%reg)                | print a floating point number                  |
| print.s(%reg)                | print a single floating point number           |
| print.d(%reg)                | print a double floating point number           |
