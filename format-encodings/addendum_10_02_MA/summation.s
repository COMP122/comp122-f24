        .text
        .globl summation

        .macro inc(%reg)
           addi %reg, %reg, 1
        .end_macro

summation: nop                  # public static int summation(int n) {
                                #             // return sum where sum = 1 + 2 + 3 + ..  n-1 + n
        # a0: n
        # t0: n                 #       int n;
        # t1: i                 #       int i;
        # t2: sum               #       int sum;

        move $t0, $a0
        li $t2, 0               #       sum = 0;
init:   nop                     #       ;     
        li $t1, 1               #       i=1;
loop:   bgt $t1, $t0, done      #       for(; i <= n ;){
body:     nop                   #          ;
          add $t2, $t2, $t1     #          sum += i;
next:     nop                   #          ;  
          inc $t1               #          i++;
        b loop                  #          continue loop;     
                                #       }
done:   nop                     #       ;            

        move $v0, $t2           #       return sum;
        jr $ra
                                # }