public static int pos_msb(int number) {

   int i;

   for(i=0; number != 0 ; i++) {
      number = number >>> 1;           
      ;
   }
   return i;

}