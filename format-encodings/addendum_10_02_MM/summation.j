public static int summation(int n) {
   // returns:   sum where sum = 1 + 2 + .. n-1 + n;

         int i; 
         int sum;

         sum = 0;
init:    ;
         i = 1;
bob:     for(; i <= n ;) {
top:        ;        
            sum += i;
again:      ;
            i ++;
            continue bob;
         }
forward: ;      
         return sum;

}