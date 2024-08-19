# File: io.s
#
# Description: This file contains an additional set of compound macros
#   to perform I/O functions.
#
#   These macros ensure the associated "v" and "a" registers are preserved.
# 
# Read a number from stdin: read_x and read_t.  (read_d is provided via syscalls.s)
#   - read_<type>()
#
# Print a value that is in a register  
#   - print_<type>(%reg)                # (see syscalls.s)
#   - print_null()
#   - print_quote("a quoted string")
#   - print_binary32(%reg)
#   - print_bits(%reg, %start, %end)  # %start and %end are immediate
#       * given a 32-bit register, print the bits in the range from %start to %end (%start >= %end)
#       * 31 ... %start - %end ... 0
#
# Print the value with a prefixed with a final newline (\n)
#   - println_<type>(%reg)
#   - println_register(%name, %reg)
#   - println_binary32(%reg)
#
# Print an array of values
#   - println_<type>(%reg, %count)
#   - println_binary32(%reg, %count)
#
#
# Future: Print the value with a space between each %count digit
#   - print_<type>(%reg, %null, %count)
#   - print_ln<type>(%reg, %null, %count)


# Deferring to use the read_d macro within syscalls.s
# .macro read_d()
#         nop                             # read_d:
#         push $a0, $a1, $a2
#         la $a0, io_line
#         read_si($a0, 255)
#         move $a1, $zero
#         li $a2, 10
#         i_strtol($a0, $zero, $a2)
#         pop $a0, $a1, $a2
#         nop                             # read_d: $v0 contains the integer value
# .end_macro

.macro read_x()
        nop                             # read_d:
        push $a0, $a1, $a2
        la $a0, io_line
        move $a1, $zero
        read_si($a0, 255)
        li $a2, 16
        push $a0, $a1, $a2
        la $gp, buffer
        i_strtol($gp, $zero, $a2)
        nop                             # read_d: $v0 contains the integer value
.end_macro

.macro read_t()
        nop                             # read_d:
        push $a0, $a1, $a2
        la $a0, io_line
        read_si($a0, 255)
        move $a1, $zero
        li $a2, 2
        la $gp, buffer
        i_strtol($gp, $zero, $a2)
        nop                             # read_d: $v0 contains the integer value
.end_macro

########################
.macro print_null()
.end_macro

.macro print_quote(%string)
                .data
str_label:      .asciiz %string
                .text
                print_si(str_label)
.end_macro

.macro print_register(%name, %reg)
            print_quote(%name)
            print_ci('\t')
            print_d(%reg)
            print_quote("\t0x ")
            print_x(%reg)
            print_quote("\t0b ")
            print_bits(%reg, 31, 28)
            print_ci(' ')
            print_bits(%reg, 27, 24)
            print_ci(' ')
            print_bits(%reg, 23, 20)
            print_ci(' ')
            print_bits(%reg, 19, 16)
            print_ci(' ')
            print_bits(%reg, 15, 12)
            print_ci(' ')
            print_bits(%reg, 11, 8)
            print_ci(' ')
            print_bits(%reg, 7,  4)
            print_ci(' ')
            print_bits(%reg, 3,  0)
.end_macro

# prints the bits in position 31..start-end..0
.data
buffer:     .space 32
.text

.macro print_bits(%reg0, %imm1, %imm2)
            # $t0  : value
            # $t1  : start, count
            # $t2  : end
            # $t3  : bit, stdout

            nop                           # print_bits: 
            push $t0, $t1, $t2, $t3, $t4
            move $t0, %reg0               #      value = %reg0
            li $t1, %imm1                 #      start = %imm1
            li $t2, %imm2                 #      end   = %imm2

            li $gp, 31
            sub $gp, $gp, $t1             #      point = 31 - start;
            sllv $t0, $t0, $gp            #      value = value << point;
            sub $t1, $t1, $t2             #      count = start - end + 1;
            addi $t1, $t1, 1

      top:  ble $t1, $zero, done          # top: for(; count > 0 ;) {
              blt $t0, $zero, alt         #        if (value >= 0) {
      cons:     print_ci('0')             #          print_ci('0');
              b fi                        #        } else {
       alt:     print_ci('1')             #          print_ci('1');
        fi:   nop                         #        }
              sll $t0, $t0, 1             #        value = value << 1;
              subi $t1, $t1, 1            #        count --;
              b top                       #        continue top;
      done: nop                           #      }
            pop $t0, $t1, $t2, $t3
.end_macro

.macro print_binary32(%reg)
            print_quote("| ")
            print_bits(%reg, 31, 31)
            print_quote(" | ")
            print_bits(%reg, 30, 23)
            print_quote(" | ")
            print_bits(%reg, 22, 0)
            print_quote(" |")
.end_macro

##########################
.macro println_null()
        print_ci('\n')
.end_macro

.macro println_d(%reg)
        print_d (%reg)
        print_ci('\n')
.end_macro

.macro println_di(%imm)
        print_di(%imm)
        print_ci('\n')
.end_macro


.macro println.s(%reg)
        print.s (%reg)
        print_ci('\n')
.end_macro

.macro println.d(%reg)
        print.d(%reg)
        print_ci('\n')
.end_macro

.macro println_f(%reg)
        print_f (%reg)
        print_ci('\n')
.end_macro

.macro println_s(%reg)
        print_s (%reg)
        print_ci('\n')
.end_macro

.macro println_si(%label)
        print_si(%label)
        print_ci('\n')
.end_macro

.macro println_c(%reg)
        print_c (%reg)
        print_ci('\n')
.end_macro

.macro println_ci(%imm)
        print_ci(%imm)
        print_ci('\n')
.end_macro


.macro println_x(%reg)
        print_x (%reg)
        print_ci('\n')
.end_macro

.macro println_xi(%imm)
        print_xi(%imm)
        print_ci('\n')
.end_macro


.macro println_t(%reg)
        print_t (%reg)
        print_ci('\n')
.end_macro

.macro println_ti(%imm)
        print_ti(%imm)
        print_ci('\n')
.end_macro

.macro println_u(%reg)
        print_u (%reg)
        print_ci('\n')
.end_macro

.macro println_ui(%imm)
        print_ui(%imm)
        print_ci('\n')
.end_macro

.macro println_binary32(%reg)
            print_binary32(%reg)
            print_ci('\n')
.end_macro


.macro println_register(%name, %reg)
            print_register(%name, %reg)
            print_ci('\n')
.end_macro


# Array Macros
.macro println_d(%array, %count)
            nop  # println_d
            # Well what if the args are in the t registers
            # $t0: %arr
            # $t1: %count
            # $t2: counter
            # $t3: offset, addr, value
            push $t0, $t1, $t2, $t3
            move $t0, %array
            li $t1, %count            # count = count
            li $t2, 0                 # counter = 0 
  top:      beq $t2, $t1, done        # if (counter == count) break
              sll $t3, $t2, 2         # offset = counter * 4
              add $t3, $t0, $t3       # addr = %arr + offset
              lw $t3, 0($t3)          # value = MEM[addr]
              print_d($t3)
              print_ci('\n')
              add $t2, $t2, 1
            b top
  done:     pop $t0, $t1, $t2, $t3
.end_macro

.macro println.s(%array, %count)
            # Not Implemented!
.end_macro

.macro println.d(%array, %count)
            # Not Implemented!
.end_macro

.macro println_s(%array, %count)
            nop  # println_s
            # Well what if the args are in the t registers
            # $t0: %arr
            # $t1: %count
            # $t2: counter
            # $t3: offset, addr, value
            push $t0, $t1, $t2, $t3
            move $t0, %array
            li $t1, %count
            li $t2, 0
  top:      beq $t2, $t1, done        # if (counter == count) break
              sll $t3, $t2, 2         # offset = counter * 4
              add $t3, $t0, $t3       # addr = %arr + offset
              lw $t3, 0($t3)          # value = MEM[addr]
              print_s($t3)
              print_ci('\n')
              add $t2, $t2, 1
            b top
  done:     pop $t0, $t1, $t2, $t3
.end_macro

.macro println_c(%array, %count)
            nop  # println_c
            # Well what if the args are in the t registers
            # $t0: %arr
            # $t1: %count
            # $t2: counter
            # $t3: offset, addr, value
            push $t0, $t1, $t2, $t3
            move $t0, %array
            li $t1, %count
            li $t2, 0
  top:      beq $t2, $t1, done        # if (counter == count)
              add $t3, $t0, $t2       # addr = %arr + counter
              lb $t3, 0($t3)          # value = MEM[addr]
              print_c($t3)
              print_ci('\n')
              add $t2, $t2, 1
            b top
  done:     pop $t0, $t1, $t2, $t3
.end_macro

.macro println_x(%array, %count)
            nop  # println_x
            # Well what if the args are in the t registers
            # $t0: %arr
            # $t1: %count
            # $t2: counter
            # $t3: offset, addr, value
            push $t0, $t1, $t2, $t3
            move $t0, %array
            li $t1, %count
            li $t2, 0            
  top:      beq $t2, $t1, done        # if (counter == count)
              sll $t3, $t2, 2         # offset = counter * 4
              add $t3, $t0, $t3       # addr = %arr + offset
              lw $t3, 0($t3)          # value = MEM[addr]
              print_x($t3)
              print_ci('\n')
              add $t2, $t2, 1
            b top
  done:     pop $t0, $t1, $t2, $t3
.end_macro

.macro println_t(%array, %count)
            nop  # println_t
            # Well what if the args are in the t registers
            # $t0: %arr
            # $t1: %count
            # $t2: counter
            # $t3: offset, addr, value
            push $t0, $t1, $t2, $t3
            move $t0, %array
            li $t1, %count
            li $t2, 0            
  top:      beq $t2, $t1, done        # if (counter == count)
              sll $t3, $t2, 2         # offset = counter * 4
              add $t3, $t0, $t3       # addr = %arr + offset
              lw $t3, 0($t3)          # value = MEM[addr]
              print_t($t3)
              print_ci('\n')
              add $t2, $t2, 1
            b top
  done:     pop $t0, $t1, $t2, $t3
.end_macro

.macro println_u(%array, %count)
            nop  # println_u
            # Well what if the args are in the t registers
            # $t0: %arr
            # $t1: %count
            # $t2: counter
            # $t3: offset, addr, value
            push $t0, $t1, $t2, $t3
            move $t0, %array
            li $t1, %count
            li $t2, 0            
  top:      bge $t2, $t1, done        # while (counter < count)
              sll $t3, $t2, 2         #   offset = counter * 4
              add $t3, $t0, $t3       #   addr = %arr + offset
              lw $t3, 0($t3)          #   value = MEM[addr]
              print_u($t3)
              print_ci('\n')
              add $t2, $t2, 1
            b top
  done:     pop $t0, $t1, $t2, $t3
.end_macro

.macro println_binary32(%array, %count)
            nop  # println_u
            # Well what if the args are in the t registers
            # $t0: %arr
            # $t1: %count
            # $t2: counter
            # $t3: offset, addr, value
            push $t0, $t1, $t2, $t3
            move $t0, %array
            li $t1, %count
            li $t2, 0            
  top:      bge $t2, $t1, done        # while (counter < count)
              sll $t3, $t2, 2         #   offset = counter * 4
              add $t3, $t0, $t3       #   addr = %arr + offset
              lw $t3, 0($t3)          #   value = MEM[addr]
              print_binary32($t3)
              print_ci('\n')
              add $t2, $t2, 1
            b top
  done:     pop $t0, $t1, $t2, $t3
.end_macro


# The above, presumes that each value is in a word -- except print_c
# Consider adding the size of the element if it is for arrays
#
# Register versions:
# print_x(v)  === print_wx(v)
#   print_wx(v)  -- don't provide, the default is word
#   print_hx(v)  -- don't provide, user required to ensure bytes 4, 3,   are zero
#   print_bx(v)  -- don't provide, user required to ensure bytes 4, 3, 2 are zero
#
# Array Versions
#   print_wx(v, c)   -- don't provide, its. the default
#   print_hx(v, c)   -- limitations, not implemented
#   print_bx(v, c)   -- okay provide some
# 
# Special case
#   print_c(v, c)  !==  print_wc(v, c)
#   print_c(v, c)  ===  print_bc(v, n)

# // .macro println_a*   arra  y of words of such things
# // .macro print_w*   array   of words of such thingst1 // .macro print_h*   array   of halfs of such things
# // .macro print_b*   array   of bytes of such thit1s
#   t1/  -R byte[]       lb
#   1//  -R half[]     lh
#    //  -R word[]   
# 
# $t1   



####### READ Macros
# some of these are to demostrate what the sycalls do within it.
## 
## # Thes are reading ascii data of a type from stdin
## read_byte_[tx]
## read_half_[tx]
## read_word_[tx]
## 
## # These are just reading binary data from file
## read_byte[_fd]
## read_half[_fd]
## read_word[_fd]
## 
## 
## # Support macros
## read_glyphs %num %type
## unpack %imm
## 
## 
## .macro read_byte()
##    read_byte(0)
## .end_macro
## 
## .macro read_byte_fd(%imm)
##    read(%imm, short_buff, 1)
##    tnei $v0, 1 
##    lb $v0, short_buff
## .end_macro
## 
## .macro read_half()
##    read_half_fd(0)
## .end_macro
## 
## .macro read_half_fd(%imm)
##    read(%imm, short_buff, 2)
##    tnei $v0, 2
##    unpack  2
## .end_macro
## 
## .macro read_word()
##   read_word_fd(1)
## .end_macro
## 
## .macro read_word_fd(%imm)
##    read(%imm, short_buff, 4)
##    tnei $v0, 4
##    unpack 4
## .end_macro
## 
## 
## 
## .macro unpack_2()
##    lb $v0, short_buff
##    lb $v1, short_buff +1
##      slr $v0, $v0, 8
##      or  $v0, $v0, $v1
## .end_macro
## 
## .macro unpack_4()
##    lb $v0, short_buff +0    ## Load the first byte
##    lb $v1, short_buff +1        ## Load the second byte
##      slr $v0, $v0, 8
##      or  $v0, $v0, $v1
##    lb $v1, short_buff +2        ## Load the third byte
##      slr $v0, $v0, 8
##      or  $v0, $v0, $v1
##    lb $v1, short_buff +3        ## Load the third byte
##      slr $v0, $v0, 8
##      or  $v0, $v0, $v1
## .end_macro
## 
## 
## 
## 
## read_byte_t
##    read_glyphs(8, 't')
## read_byte_x
##    read_glyphs(2, 'x')
## 
## read_half_t
##     read_glyphs(16, 't')
## 
## read_half_x
##     read_glyphs(4, 'x')
## 
## read_word_t
##     read_glyphs(32, 't')
## 
## read_word_x
##     read_glyphs(8, 'x')
## 
## 
## read_glyphs (num_glyphs)
##          value = 0;
##    loop: for (i=0; i < num_glyphs; i++) {
##            read_c();
##            x = retval();
##            
##            // skip over punch
##      punc: do { 
##              switch (x) {
##                case ' ':
##                case '|':
##                case '-':
##                case ':':
##                case '\n':
##                case '\t':
##                   read_char()
##                   x = retval;
##            continue punc;
##          }
##             }
## 
##      switch (%type) {
##          case 't':  
##            switch(x) {
##               case '0':
##               case '1':
##                   value = value << 1 + (x - '0');
##                   break glypy;
## 
##               default:
##                   teq $zero, $zero
##              }
##              break;
##          
## 
##          case 'x':
##            do { 
##               value = value << 4
##               test = index_within_range(x, '0', '9')
##               if test != -1 {
##                  value = value + ( x - '0')
##                  break;
##               }
## 
##               test = index_within_range(x, 'a', 'f')
##               if test != -1 {
##                  value = value + 10 + ( x = 'a')
##                  break;
##               }
##               test = index_within_range(x, 'A', 'F')
##               if test != -1 {
##                  value = value + 10 + ( x = 'A')
##                  break;
##               }
##               teq $zero, $zero
##             } while (false);
##             break;
##         }
##         return value;
##    }
## 
## 
##  
## ```mips
## .macro read_x()
##         .data 
## buff:   .space 5
##         .text
## 
##         read_s(buff, 5)
##         value = 0;
##         for (i=0; i<5; i++) {
##            digit = buff[i];
##            if (digit == '\n') break;
##            if (digit == '\0') break;
## 
##            position_in_range(digit, '0', '9');
##            digit = $v0;
## 
##            if (digit < 0) {
##              # Handle Hex...
## 
##              position_in_range(digit, 'a', 'f');
##              digit = $v0 + 10;
##            } else {
##              position_in_range(digit, 'A, 'F')
##              digit = $v0 + 10;
##            }
## 
##            if ($v0 < 0) break;
## 
##            value = value << 4;
##            value = value + digit;
##         }
##         return value;
## 
## 
## 
## 
##         li $at, 0                            #  value = 0;
##         li $v0, 0                            #  $v0 = 0;
## top:    nop                                  #  do { 
##           sll $v0, $v0, 4                    #    value = value << 4;
##                                              #    $v0 = $v0 - '0'
##           add $at, $at, $v0                  #    value = value + $v0;
##           li $v0, 11                         #    read_c();
##           syscall                           
##         bne $v0, '\n', top                   #  while ( $v0 != '\n');
##         
## .end_macro
## ```



