

public static int pos_msb(int number) { 

              int i;

init:         ;
              i=0;
loop:         for(; number != 0 ;) {
body:           ;                
                number = number >>> 1;

next:           ;
                i++;
                continue loop;                
              }
done:         ;            

              return i;
}









