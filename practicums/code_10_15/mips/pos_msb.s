                .text
                .globl pos_msb


pos_msb:      nop                       # public static int pos_msb(int number) {
                # a0 : number
                # v0 : <retval>
                # t0 : position         #   int position;
        
start:        nop                       #   ;
              move position, 0          #   position=0;

ctl:          beq number, 0, done       #   for (; number != 0 ;) {

stuff:          nop                       #      ;
                srl number, number, 1     #      number = number >>> 1;

again:          nop                       #      ;  
                addi position, position, 1  #      position = position + 1;
              b ctl                     #      continue ctl;       
                                        #   }
complete:     nop                       #   ;         
        
              move $v0, position        #   return position;
              jr $ra
                                        # }