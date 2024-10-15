// 0000 0000 : 0 : msb = 0
// 0000 0001 : 1 : msb = 1
// 0000 0010 : 2 : msb = 2
// 0000 0011 : 3 : msb = 2



public static int pos_msb(int number) {

  int position = 0;

  for (position=0; number != 0; position ++) {
     number = number >>> 1;
  }

  return position;
}