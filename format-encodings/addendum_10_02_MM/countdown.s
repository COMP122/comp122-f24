        .text
        .globl countdown

        .include "macros/syscalls.s"

        .macro dec(%reg)
          addi %reg, %reg, -1
        .end_macro


countdown: nop                  # public static int countdown() {
        # a0:
        # a1:
        # a2:
        # t0: top               #     int top;
        # t1: i                 #     int i;
        # t2: $l                #     int $l; 
        # t3: $r                #     int $r;
                                #   
        li $t0, 10              #     top = 10;
init:   nop                     #     ; 
        move $t1, $t0           #     i=top;
        move $t2, $t1           #     $l = i;
        li $t3, 0               #     $r = 0;
sam:    ble $t2, $t3, done      #     for(; $l > $r ;) {
body:     nop                   #        ;      
          print_d($t1)          #        mips.print_d(i);
          print_ci('\n')        #        mips.print_ci('\n');
next:     nop                   #        ;
          dec $t1               #        i --;
          move $t2, $t1         #        $l = i;
          li $t3, 0             #        $r = 0;
        b sam                   #        continue sam;
                                #     }
done:   nop                     #     ;    
        li $v0, 22              #     return 22;
        jr $ra
                                # }




