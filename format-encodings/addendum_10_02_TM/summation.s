                .text
                .globl summation

summation:      nop                     # public static int summation(int n) {
                                        #    // returns sum where sum = 1 + 2 + 3 + ... + n-1 + n

                # a0: n                 # int n
                # t0: i                 # int i;
                # t1: sum               # int sum;

                li $t1, 0               # sum=0;
init:           nop                     # ;  
                li $t0, 1               # i=1 ;
loop:           bgt $t0, $a0, done      # for(; i<=n; ) {
body:             nop                   #    ;            
                  add $t1, $t1, $t0     #    sum+=i;
next:             nop                   #    ;
                  addi $t0, $t0, 1      #    i++;
                b loop                  #    continue loop;               
                                        # }
done:           nop                     # ;            
                move $v0, $t1           # return sum;
                jr $ra

                                        #}