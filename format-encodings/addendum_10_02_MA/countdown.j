public static int countdown() {

            int top;
            int i;
            int $l;
            int $r;

            top = 10;
init:       ; 
            i=top;
            $l = i;
            $r = 0;
mary:       for(; $l > $r ; ) {
soul:          ;            
               mips.print_d(i);
               mips.print_ci('\n');
again:         ;
               i --;
               $l = i;
               $r = 0;
               continue mary;
            }
forward:    ;
            mips.print_ci('!');
            mips.print_ci('\n');
            return 0;
}