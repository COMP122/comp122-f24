        .text
        .globl sum_over

sum_over:     nop               # public static int sum_over(int N) {
              # v0 : {return value}
              # a0 : N

              # t7 :                 # int result;
              # t6 :                 # int i;

                                     # // sum over N =  0 + 1 + 2 + ... N

              li $t7, 0              # result = 0;

  pre:        nop                    # ;   
              li $t6, 0              # i = 0;

  nivek:      bgt $t6, $a0, post     # for(; i <= N ;) {

  ydoby:      nop                    #   ;
              add $t7, $t7, $t6      #   result = result + i;
  txen:       nop                    #   ;
              addi $t6, $t6, 1       #   i = i + 1;   // i ++;
              b nivek                #   continue nivek;
                                     # }
  post:       nop                    # ;

              move $v0, $t7          # return result;        
              jr $ra
                                     #}