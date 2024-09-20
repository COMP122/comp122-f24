              .text
              .globl max

max:          nop                  # public static int max(int a, int b) {
                                   # $v0 <- $a0 x $a1
  # Register Allocation
  # a0: a
  # a1: b
  # v0: return value
  # t9: max                        # int max; 

                                   # 
              li $t9, 0            # max = 0;
                                   # 
  init:       nop                  # ; 
  champ:      ble $a0, $a1, cons   # if (a <= b) {
              b alt

  cons:       nop                  #   ;
              move $t9, $a1        #   max = b;
              b done               #   break champ;
                                   # } else {
  alt:        nop                  #   ;        
              move $t9, $a0        #   max = a;
              b done               #   break champ;
                                   # }
  done:       nop                  # ;
                                   # 
              move $v0, $t9        # return max; 
              jr $ra
                                   # }
 