
public static int abs(int a){

                     int answer;
                     int n_one;

                     answer = 0;

   fred_init:        ;
                     n_one = -1;
   fred:             if ( a < 0 ) {
   fred_cons:           ; 
                        answer = a * n_one;
                        break fred;
                     } else {
   fred_otherwise:      ;
                        answer = a;
                        break fred; 
                     }
   fred_done:        ;              
                     return answer;
}