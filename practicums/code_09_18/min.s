        .text
        .globl min

min:    nop                     # public static int min(int a, int b){
                                

        # Register Allocation Table
        # a0: a
        # a1: b
        # t1: min              #     int min;
        #



                                # 
        li $t1, 0               #             min = 0;
                                #             
init:   nop                     #   init:     ;          
bob:    bgt $a0, $a1, alt       #   bob:      if (a <= b) {
                          
cons:   nop                     #   cons:        ;
        move $t1, $a0           #                min = a;
        b done                  #                break bob;
                                #             } else {
alt:    nop                     #   alt:         ;
        move $t1, $a1           #                min = b;
        b done                  #                break bob;
                                #             }
done:   nop                     #   done:     ;


        move $v0, $a1           #             return min;
        jr   $ra
                                # }




