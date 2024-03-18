public static int countdown() {
       
         int top;
         int i;
         int $l; 
         int $r;
    
         top = 10;
init:    ; 
         i=top;
         $l = i;
         $r = 0;
sam:     for(; $l > $r ;) {
body:       ;      
            mips.print_d(i);
            mips.print_ci('\n');
next:       ;
            i --;
            $l = i;
            $r = 0;
            continue sam;
         }
done:    ;    
         return 22;
}