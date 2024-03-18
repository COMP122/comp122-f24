public static int whole2bin (int whole) {

    int number;
    int count;
    int rem;
    int c;

    number = whole;
    for(count=0; number != 0 ;count++) {
      rem    = number % 2;
      number = number / 2; 
      mips.push(rem);
    }

    for(c=0; c < count; c++) {
      rem = mips.pop();
      mips.print_d(rem);
    }

    mips.print_ci('\n');
    return 0;
 }