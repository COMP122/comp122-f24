
                     .text
                     .globl abs

abs:                 nop         #  public static int abs(int a){

                     # Register Allocation
                     # v0
                     # a0 : a
                     # a1 : <nothing>
                     # t7        int answer;
                     # t8        int n_one;

                     li $t7, 0                     #   answer = 0;

   fred_init:        nop                           #   ;
                     li $t8, -1                    #   n_one = -1;
   fred:             blt $a0, $zero, fred_cons     #   if ( a < 0 ) {
                     b fred_otherwise
                     
   fred_cons:        nop                           #      ; 
                     mult $t7, $a0, $t8            #      answer = a * n_one;
                     b fred_done                   #      break fred;
                                                   #   } else {
   fred_otherwise:   nop                           #      ;
                     move $t7, $a0                 #      answer = a;
                     b fred_done                   #      break fred; 
                                                   #   }
   fred_done:        nop                           #   ;              
                     move $v0, $t7                 #   return answer;
                     jr $ra
                                                   # }




