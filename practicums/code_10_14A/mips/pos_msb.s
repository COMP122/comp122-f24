                .text
                .globl pos_msb 

pos_msb:        nop                     # publ$t0c static int pos_msb(int $a0) {
                # a0: number
                # v0: <return value>
                # t0: i                 #   int i;

init:           nop                     #   ;
                move $t0, $zero         #   i=0;
test:           beq $a0, $zero, done    #   for(; number != 0 ;) {

body:             nop                   #      ;
                  srl $a0, $a0, 1       #      number = number >>> 1;           

next:             nop                   #      ;
                  nop                   #      ;
                  addiu $t0, $t0, 1     #      i++;
                b test                  #      continue test;
                                        #   }
done:           nop                     #   ;            
                move $v0, $t0           #   return i;
                jr $ra

                                        # }