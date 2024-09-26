public static int multiplication(int N, int M) {

     // result  = M * M * M ... * M (N times)
     int result;
     int i;


     result = 0;
i:   ;
     i = 0;

add: for (; i < N ; ) {
b:      ;
        result = result + M;    

n:      ; 
        i = i + 1;    // i ++;
        continue add;       
     }
d:   ;

     return result;
}