public static int factorial (int N) {
   int result;
   int v;

            // fac(N) = N * n-1 * n-2 ... 1 
            
            result = 1;
            
  init:     ;
            v = N;
  fac:      for(; v >= 1 ;) {
  body:       ;
              result = result * v;

  next:       ;    
              v = v - 1 ;
              continue fac;   
            }
  done:     ;            
            
            return result;
}