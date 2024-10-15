public static int pos_msb(int number) {

            int i;

init:       ;
            i=0;
test:       for(; number != 0 ;) {
body:          ;
               number = number >>> 1;           
next:          ;
               ;
               i++;
               continue test;
            }
done:       ;            
            return i;

}