public static int sum_over(int N) {

            int result;
            int i;

            // sum over N =  0 + 1 + 2 + ... N

            result = 0;

  pre:      ;   
            i = 0;

  nivek:    for(; i <= N ;) {
  ydoby:      ;      
              result = result + i;
  txen:       ;
              i = i + 1;   // i ++;
              continue nivek;
            }
  post:     ;


            return result;        
}