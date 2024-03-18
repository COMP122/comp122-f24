                .text
                .globl countdown      

                .include "macros/syscalls.s"

                .macro dec(%reg)
                   subi %reg, %reg, 1
                .end_macro

countdown:      nop                     # public static int countdown() {

                # t0 : top              # int top;
                # t1 : i                # int i;
                # t2 : $l               # int $l;
                # t3 : $r               # int $r;
        
                li $t0, 10              # top = 10;
init:           nop                     # ;
                move $t1, $t0           # i=top;
                move $t2, $t1           # $l=i;
                li $t3, 0               # $r=0;
john:           ble $t2, $t3, forward   # for(; $l > $r ;) {
body:             nop                   #    ;
                  print_d($t1)          #    mips.print_d(i);
                  print_ci('\n')        #    mips.print_ci('\n');
again:            nop                   #    ;
                  dec $t1               #    i --;
                  move $t2, $t1         #    $l=i;
                  li $t3, 0             #    $r=0;
                b john                  #    continue john;
                                        # }
forward:        nop                     # ;         
                print_ci('\n')          # mips.print_ci('!');
                li $v0, 0               # return 0;
                jr $ra
                                        # }