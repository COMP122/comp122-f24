                .text
                .globl pos_msb


pos_msb:      nop                       # public static int pos_msb(int number) {
                # a0 : number
                # v0 : <retval>
                # t0 : position         #   int position;
        
start:        nop                       #   ;
              li $t0, 0                 #   position=0;

ctl:          beq $a0, 0, complete      #   for (; number != 0 ;) {

stuff:                               #      ;
                sra $a0, $a0, 1         #      number = number >>> 1;

again:          nop                     #      ;  
                addi $t0, $t0, 1        #      position = position + 1;
              b ctl                     #      continue ctl;       
                                        #   }
complete:                            #   ;         
        
              move $v0, $t0             #   return position;
              jr $ra
                                        # }
