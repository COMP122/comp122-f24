// 4 instructions : shift, add, sub, b
// * log N

// dynamic
//   for a 32 bit word:
//      32 * 4 == 128 instructions...
// static:  32 * 2 = 64

public static int  qmult(int y, int x ) {
	
   int p;

   do {
     if (x > 16) {
       p = y * x; break;
     }
     if (x == 16) {
       p = y << 4 ; break;
     }

     p = 0;

     if (x >= 8) {   // in_range  15..8:
	     p = p + (y << 3);
       x = x - 8;
     } 
     if (x >= 4 ) { // in_range 7..4:
       p = p + (y << 2);
       x = x - 4;
     }
     if (x >= 2)  { // in_range 3..2
        p = p + (y << 1);
        x = x - 2;
     }
     if (x == 1) {
        p = p + y;
     }
   } while (false);

   return p;

}

// y * 15:    7, 3, 1
// 
//    0 + y * 8 +  y * 4 +  y * 2 + x
// 