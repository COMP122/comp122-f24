
                .data
buffer:         .space 256                 
                                # static char [] buffer = new bytes[256];
                                # 

                .text
                .globl strcat                                
strcat:         nop             # public static int strcat( char [] first, char [] second) {

                # a0: &first
                # a1: &second   #    // returns the 'first + second'
                # t0: &first
                # t1: &second

                # t2: i         # int i;
                # t3: j         # int j;
                # t4: len       # int len;
                # t5: val       # int val;

                # De-marshal my inputs
                move $t0, $a0
                move $t1, $a1
                                # final int $zero = 0;

init:                           # ;
                                # i = 0;
                                # val = first[i]
betty:                          # for (; val != $zero ;) {
                                #    buffer[i] = val;
                                #    i++;
                                #    val = first[i];
                                #    continue betty;
                                # }
wilma:                          # ;   

                                # j = 0;  
                                # val = second[j];
barney:                         # for (; val != $zero ;) {
                                #    buffer[i+j] = val;
                                #    j++;
                                #    val = second[j];
                                #    continue barney;
                                # }
fred:                           # ;
                                # len = i + j;
                                # len = len + 1;
                                # buffer[len]='\0';

                                # mips.print_s(buffer);
                                # return len;

                                # }







