public static int fractional2bin(int fractional, int precision) {

   // int fractional;
   // int precision;
   int max;
   int number;
   int count;

   final int max_bits = 23;

   max = (int) Math.pow(10, precision);

   number = fractional;
   for(count=0; number != 0 ; count++) {
      if (count >= max_bits) break;
      
      number = number * 2;
      if ( number >= max ) {
          mips.print_di(1);
          number = number - max;
       } else {
          mips.print_di(0);
       }
   }
   mips.print_ci('\n');


   return 0;
}