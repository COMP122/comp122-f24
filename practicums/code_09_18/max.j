public static int max(int a, int b) {
         int max; 

         max = 0;

  init:  ; 
  champ: if (a <= b) {
  cons:    ;
           max = b;
           break champ;
         } else {
  alt:     ;        
           max = a;
           break champ;
         }
  done:  ;

         return max;
}
 