public static int summation(int n) {
   // returns sum where sum = 1 + 2 + 3 + ... + n-1 + n

            int i;
            int sum;

            sum=0;
init:       ;  
            i=1 ;
loop:       for(; i<=n; ) {
body:          ;            
               sum+=i;
next:          ;
               i++;
               continue loop;               
            }
done:       ;            
            return sum;

}