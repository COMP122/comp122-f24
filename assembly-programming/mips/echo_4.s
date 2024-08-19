catenates the cl args into a single string


## Currently, this does not work.
## Need to save registers

                .data
                .align 2  # Ensure we are aligned on word boundaries

buffer:         .space 1024

str0:           .asciiz "str0"
str1:           .asciiz "str1"
str2:           .asciiz "str2"
str3:           .asciiz "str3"
                .text
                .include "include/stack.s"

                .globl echo4

test:           nop             # A hardcoded test routine for echo
                la $a0, str0
                la $a1, str1
                la $a2, str2
                la $a3, str3

                jal echo4

                li $v0, 10      # v0 contains the number for exit, 10
                syscall         # trap: exit


strcpy:         nop                     #  end = strcpy(str,substr);
                # a0: & str
                # a1: & substr
                # t0: str_p, end
                # t1: substr_p
                # t2: (* str_p)         # Note: not used since it only occurs on the LHS
                # t3: (* substr_p)

                move $t0, $a0           # str_p = & str;
                move $t1, $a1           # substr_p = & substr_p;
                                          
                lbu $t3, 0($t0)         #       // $t2 = (* substr_p)
        loop:   beq $t3, $zero, done    # loop: for (; (* substr_p) != '\0' ;) {
                  sb   $t3, 0($t1)      #         (* str_p) = ( * substr_p );
                  addi $t0, $t0, 1      #         str_p ++;
                  addi $t1, $t1, 1      #         substr_p ++
                  lbu  $t3, 0($t1)      #         // $t2 = (* substr_p)
                b loop                  #         continue loop;
                                        #       }
        done:   nop                     # done: nop
                sb $zero, 0($t1)        # (* str_p) = '\0'

                move $v0, $t0           # return str_p;
                jr $ra

                .macro call_strcpy
                  push $t0, $t1, $t2, $t3, $4, $t5, $t6
                  jal strcpy              # str_p = strcpy(str_p, substr_p);
                  pop $t0, $t1, $t2, $t3, $4, $t5, $t6
                .end_macro

echo4:          nop                     # Entry point of the echo4 subroutine
                                        # concatenate the four arguments
                # a0: &str0
                # a1: &str1
                # a2: &str2
                # a3: &str3
                #-------
                # t0: &str0
                # t1: &str1
                # t2: &str2
                # t3: &str3
                # t4: str_p
                # t5: substr_p
                # t6: return_address (ra)

                move $t6, $ra

                move $t0, $a0
                move $t1, $a1
                move $t2, $a2
                move $t3, $a3
            
                la $t4, buffer          # str_p = &buffer;
            
                move $t5, $t0           # substr_p = &str0;

                move $a0, $t4
                move $a1, $t5

                call_strcpy

                move $t4, $v0
                                    
                move $t5, $t1           # substr_p = &str1;
            
                move $a0, $t4
                call_strcpy             # str_p = strcpy(str_p, substr_p);
                move $t5, $t2           # substr_p = &str2;

                move $a0, $t4
                move $a1, $t5
                call_strcpy             # str_p = strcpy(str_p, substr_p);
                move $t4, $v0                       


                move $t5, $t3           # substr_p = &str3;

                move $a0, $t4
                move $a1, $t5
                call_strcpy             # str_p = strcpy(str_p, substr_p);
                move $t4, $v0

                la $v0, buffer          # return buffer;
                jr $t6




