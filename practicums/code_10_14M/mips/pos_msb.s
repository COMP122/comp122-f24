                .text
                .globl pos_msb

pos_msb:        nop                     # public static int pos_msb(int number) { 
                # Bookkeeping
                # a0 : number
                # v0 : <return value>

                # t0 : i                #   int i;

init:           nop                     #   ;
                li $t0, 0               #   i=0;
loop:           beq $a0, 0, done        #   for(; number != 0 ;) {
body:             nop                   #     ;                
                  srl $a0, $a0, 1       #     number = number >>> 1;

next:             nop                   #     ;
                  addi $t0, $t0, 1      #     i++;
                b loop                  #     continue loop;                
                                        #   }
done:           nop                     #   ;            

                move $v0, $t0           #   return i;
                jr $ra
                                        # }









