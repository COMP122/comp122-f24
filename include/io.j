// # File: io.s
// #
// # Description: This file contains an additional set of compound macros
// #   to perform I/O functions.
// #
// #   These macros ensure the associated "v" and "a" registers are preserved.
// # 
// # Read a number from stdin: read_x and read_t.  (read_d is provided via syscalls.s)
// #   - read_<type>()
// #
// # Print a value that is in a register  
// #   - print_<type>(%reg)                # (see syscalls.s)
// #   - print_null()
// #   - print_quote("a quoted string")
// #   - print_binary32(%reg)
// #   - print_bits(%reg, %start, %end)  # %start and %end are immediate
// #       * given a 32-bit register, print the bits in the range from %start to %end (%start >= %end)
// #       * 31 ... %start - %end ... 0
// #
// # Print the value with a prefixed with a final newline (\n)
// #   - println_<type>(%reg)
// #   - println_register(%name, %reg)
// #   - println_binary32(%reg)
// #
// # Print an array of values
// #   - println_<type>(%reg, %count)
// #   - println_binary32(%reg, %count)
// #
// #
// # Future: Print the value with a space between each %count digit
// #   - print_<type>(%reg, %null, %count)
// #   - print_ln<type>(%reg, %null, %count)
// 



  public static void read_x() {
    $v0 = stdin.nextInt(16);
    return;
  }

  public static void read_o() {
    $v0 = stdin.nextInt(8);
    return;
  }

  public static void read_t() {
    $v0 = stdin.nextInt(2);
    return;
  }


// ########################
  public static void  print_null() {
    return;
  }


  public static void print_quote(String str) {
    System.out.printf("%s", str);
    return;
  }

  public static void print_register(String name, int value) {
    print_quote(name);
    print_ci('\t');
    print_d(value);
    print_quote("\t0x ");
    print_x(value);
    print_quote("\t0b ");
    print_bits(value, 31, 28);
    print_ci(' ');
    print_bits(value, 27, 24);
    print_ci(' ');
    print_bits(value, 23, 20);
    print_ci(' ');
    print_bits(value, 19, 16);
    print_ci(' ');
    print_bits(value, 15, 12);
    print_ci(' ');
    print_bits(value, 11, 8);
    print_ci(' ');
    print_bits(value, 7,  4);
    print_ci(' ');
    print_bits(value, 3,  0);
    return;
  }


  public static void print_bits(int reg, int start, int end) {

    int value;
    int count;
    int counter;

    value = reg << (31 - start);
    count = start - end + 1; 

top: for(; count > 0 ;) {
      if (value >= 0) {
        print_ci('0');
      } else {
        print_ci('1');
      }
      value = value << 1;
      count --;
      continue top;
    }
    return;
  }


  public static void print_binary32(int reg) {
    print_quote("| ");
    print_bits(reg, 31, 31);
    print_quote(" | ");
    print_bits(reg, 30, 23);
    print_quote(" | ");
    print_bits(reg, 22, 0);
    print_quote(" |");
    return;
  }


// ##########################
  public static void println_null() {
    return;
  }

  public static void println_d(int value) {
    print_d(value);
    print_ci('\n');
    return;
  }

  public static void  println_di(int value) {
    print_di(value);
    print_ci('\n');
    return;
  }


  // public static void println.s(float reg) {
  //   print.s(reg);
  //   print_ci('\n');
  //   return;
  // }

  // public static void println.d(double reg) {
  //   print.d(%reg)
  //   print_ci('\n')
  //   return;
  // }

  public static void println_f(float reg) {
    print_f(reg);
    print_ci('\n');
    return;
  }

  public static void println_s(char[] register) {
    print_s(register);
    System.out.printf("\n");
    return;
  }


  public static void println_si(char[] label) {
    print_si(label);
    print_ci('\n');
    return;
  }

  public static void println_c(char reg) {
    print_c(reg);
    print_ci('\n');
    return;
  }

  public static void println_ci(char imm) {
    print_ci(imm);
    print_ci('\n');
    return;
  }


  public static void println_x(int reg) {
    print_x(reg);
    print_ci('\n');
    return;
  }

  public static void println_xi(int imm) {
    print_xi(imm);
    print_ci('\n');
    return;
  }

  public static void println_t(int reg) {
    print_t(reg);
    print_ci('\n');
    return;
  }

  public static void println_ti(int imm) {
    print_ti(imm);
    print_ci('\n');
    return;
  }

  public static void println_u(int reg) {
    print_u(reg);
    print_ci('\n');
    return;
  }

  public static void println_ui(int imm) {
    print_ui(imm);
    print_ci('\n');
    return;
  }

  public static void println_binary32(int reg) {
    print_binary32(reg);
    print_ci('\n');
    return;
  }


  public static void println_register(String name, int reg) {
    print_register(name, reg);
    print_ci('\n');
    return;
  }



// # Array Macros
  public static void println_d(int arr[], int count) {
    int i;
    for (i=0; i < count; i++) {
      println_d(arr[i]);
      print_ci('\n');
    }
    return;
  }

  // public static void println.s(int arr[], int count) {
  //   int i;
  //   for (i=0; i < count; i++) {
  //     println.s(arr[i]);
  //     print_ci('\n');
  //   }
  //   return;
  // }

  // public static void println.d(int arr[], int count) {
  //   int i;
  //   for (i=0; i < count; i++) {
  //     println  (arr[i]);
  //     print_ci('\n');
  //   }
  //   return;
  // }

  public static void println_s(char arr[][], int count) {
    int i;
    for (i=0; i < count; i++) {
      println_s(arr[i]);
      print_ci('\n');
    }
    return;
  }

  public static void println_c(char arr[], int count) {
    int i;
    for (i=0; i < count; i++) {
      println_c(arr[i]);
      print_ci('\n');
    }
    return;
  }

  public static void println_x(int arr[], int count) {
    int i;
    for (i=0; i < count; i++) {
      println_x(arr[i]);
      print_ci('\n');
    }
    return;
  }

  public static void println_t(int arr[], int count) {
    int i;
    for (i=0; i < count; i++) {
      println_t(arr[i]);
      print_ci('\n');
    }
    return;
  }

  public static void println_u(int arr[], int count) {
    int i;
    for (i=0; i < count; i++) {
      println_u(arr[i]);
      print_ci('\n');
    }
    return;
  }

  public static void println_binary32(int arr[], int count) {
    int i;
    for (i=0; i < count; i++) {
      println_binary32(arr[i]);
      print_ci('\n');
    }
    return;
  }







