        .text
        .include "macros/syscalls.s"
        .globl countdown


countdown:  nop                         # public static int countdown() {

        # t0: top                       #  int top;
        # t1: i                         #  int i;
        # t2: $l                        #  int $l;
        # t3: $r                        #  int $r;

        li $t0, 10                      #  top = 10;
init:   nop                             #  ; 
        move $t1, $t0                   #  i=top;
        move $t2, $t1                   #  $l = i;
        li $t3, 0                       #  $r = 0;
mary:   ble $t2, $t3, forward           #  for(; $l > $r ; ) {
soul:     nop                           #     ;            
          print_d($t1)                  #     mips.print_d(i);
          print_ci('\n')                #     mips.print_ci('\n');
again:    nop                           #     ;
          addi $t1, $t1, -1             #     i --;
          move $t2, $t1                 #     $l = i;
          li $t3, 0                     #     $r = 0;
        b mary                          #     continue mary;
                                        #  }
forward:  nop                           #  ;
          print_ci('!')                 #  mips.print_ci('!');
          print_ci('\n')                #  mips.print_ci('\n');
          li $v0, 0                     #  return 0;
          jr $ra
                                        #}













