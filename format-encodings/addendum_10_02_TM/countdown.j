public static int countdown() {

         int top;
         int i;
         int $l;
         int $r;

         top = 10;
init:    ;
         i=top;
         $l=i;
         $r=0;
john:    for(; $l > $r ;) {
body:       ;
            mips.print_d(i);
            mips.print_ci('\n');
again:      ;
            i --;
            $l=i;
            $r=0;
            continue john;
         }
forward: ;         
         mips.print_ci('!');
         return 0;
}