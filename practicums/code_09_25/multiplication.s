          .text
          .globl multiplication

multiplication:     nop                      # public static int multiplication(int N, int M) {
                    # v0 : {return value}
                    # a0 : N
                    # a1 : M
                                             # // result  = M * M * M ... * M (N times)
                    # t0 : result            # int result;
                    # t1 : i                 # int i;
                    
                    
                    li $t0, 0                # result = 0;
i:                  nop                      # ;
                    li $t1, 0                # i = 0;
                    
add_l:              bge $t1, $a0, d          # for (; i < N ; ) {

bo:                 nop                      #   ;
                    add $t0, $t0, $a1        #   result = result + M;    
                    
n:                  nop                      #   ; 
                    addi $t1, $t1, 1         #   i = i + 1;    // i ++;
                    b add_l                  #   continue add;       
                                             # }
d:                  nop                      # ;
                    
                    move $v0, $t0            #return result;
                    jr $ra
                                             # }