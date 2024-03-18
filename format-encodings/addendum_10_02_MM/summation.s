        .text
        .include "macros/syscalls.s"

        .globl summation

summation: nop                  # public static int summation(int n) {
                                #    // returns:   sum where sum = 1 + 2 + .. n-1 + n;
                                # 
        # a0: n                        
        # a1:
        # t0: i                 # int i; 
        # t1: sum               # int sum;
        # t2: n



        li $t1, 0               # sum = 0;
init:   nop                     # ;
        li $t0, 1               # i = 1;
bob:    bgt $t0, $a0, forward   # for(; i <= n ;) {
top:      nop                   #    ;        
          add $t1, $t1, $t0     #    sum += i;
again:    nop                   #    ;
          addi $t0, $t0, 1      #    i ++;
        b bob                   #    continue bob;
                                # }
forward: nop                    # ;      
         move $v0, $t1          # return sum;
         jr $ra

                                #}




