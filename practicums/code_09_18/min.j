     public static int min(int a, int b)   {
         int min;

                 min = 0;
                 
       init:     ;          
       bob:      if (a <= b) {
       cons:        ;
                    min = a;
                    break bob;
                 } else {
       alt:         ;
                    min = b;
                    break bob;
                 }
       done:     ;
                 return min;
     }
