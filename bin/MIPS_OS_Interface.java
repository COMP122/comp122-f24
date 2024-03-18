import java.util.Scanner;
import java.lang.Math;
//import java.util.*; 
//import java.util.regex.Pattern; 

class MIPS_OS_Interface {

  static Scanner stdin = new Scanner(System.in);

  // Manage the special registers
  // Note that these variables may differ from the main class register declarations
  final static int $zero = 0;
  static int $v0 = -1; 
  static int $v1 = -1; 
  static int $gp = -1;
  static int $fp = -1;
  static int $sp = -1;
  static int $ra = -1;


  public static void read(int fd, int buffer, int size) {
    // restictied to fd = 0, size = 4;
     Scanner _scanner = stdin;
     if (fd != 0 || size != 1) {
       return;
     }
     if (stdin.hasNext() == true) {
       MEM[buffer] = stdin.nextByte();
       print_d(MEM[buffer]);
       print_ci('\n');     print_ci('\n');
       $v0 = 1;
     } else {
       $v0 = 0;
     }
  }

  public static void read(int fd, int buffer[], int size) {
    // restictied to fd = 0, size = 4;
     Scanner _scanner = stdin;
     if (fd != 0 || size != 4) {
       return;
     }
     if (stdin.hasNext()) {
       buffer[0] = stdin.nextInt();
       $v0 = 4;
     } else {
       $v0 = 0;
     }
  }

  // MEMORY
  static int sbrk_p = 0;
  static byte[] MEM = new byte[1024];
  static int[] stack = new int[256];
  static char[][] str_stack = new char[25][];



  //  TYPE Conversion
  public static int u_byte(byte value) {
    return Byte.toUnsignedInt(value);
  }
  public static int s_byte(byte value) {
    return value;
  }

  public static int u_half(short value) {
    return Short.toUnsignedInt(value);
  }
  public static int s_half(short value) {
    return value;
  }

  public static int retval() {
    return $v0;
  }


  public static void sbrk(int size) {
    $v0 = sbrk_p;
    sbrk_p += size;
  }

  public static void read_d() {
    $v0 = stdin.nextInt();
  }

  public static void read_c() {
    String str = stdin.findInLine(".");

    if (str == null) {
      $v0 = '\0';
    }
    else {
      $v0 = str.charAt(0);
    }
  }

  public static void read_s(char [] A, int count) {
    String str;
    char [] temp;

    str = stdin.nextLine();
    temp = str.toCharArray();

    for (int i=0; i< str.length(); i++) {
       A[i] = temp[i];
    }

    // validate this...
    $v0 = $v0;
    $v0 = str.length();
  }



  public static void read_x() {
    $v0 = stdin.nextInt(16);
  }

  public static void read_o() {
    $v0 = stdin.nextInt(8);
  }

  public static void read_t() {
    $v0 = stdin.nextInt(2);
  }

  public static void print_d(int register) {
    System.out.printf("%d", register);
    return;
  }

  public static void print_di(int immediate  ) {
    System.out.printf("%d", immediate);
    return;
  }

  public static void print_c(char register) {
    System.out.printf("%c", register);
    return;
  }
  public static void print_ci(char immediate) {
    System.out.printf("%c", immediate);
    return;
  }

  public static void print_s(String register) {
    System.out.printf("%s", register);
    return;
  }

  public static void println_s(String register) {
    System.out.printf("%s\n", register);
    return;
  }


  public static void print_s(char [] register) {
    // The char [] has a 

    int index;
    for (index=0; index < register.length; index++ ) {
       if (register[index] == '\0' ) break;
       System.out.printf("%c", register[index]);
     }
    return;
  }

  public static void println_s(char[] register) {
    print_s(register);
    System.out.printf("\n");
    return;
  }

  public static void print_x(int register) {
    System.out.printf("%x", register);
    return;
  }

  public static void print_xi(int immediate  ) {
    System.out.printf("%x", immediate);
    return;
  }
  public static void print_t(int register) {

    StringBuilder binaryValue = new StringBuilder();
    String binaryString;
    long value = Integer.toUnsignedLong(register);  // Java does not have unsigned
    long remainder;

    while (value > 0) {
        remainder = value % 2;
        value     = value / 2;
        binaryValue.append(remainder);
    }
    binaryString = binaryValue.reverse().toString();
    for (int i=32; i > binaryString.length(); i--) {
      System.out.printf("%c", '0');
    }
    System.out.printf("%s", binaryString);
    return;
  }
  public static void print_ti(int immediate) {
    print_t(immediate);
    return;
  }


  public static void exit(int register) {
    System.exit(register);
    return;
  }
  public static void exiti(int immediate) {
    System.exit(immediate);
    return;
  }


  public void push(char [] register) {
    $sp = $sp + 1;
    str_stack[$sp] = register;
  }
  public char [] pop( char [] dumb ) {
    char [] x = str_stack[$sp];
    $sp = $sp - 1; 
    //$v0 = x;
    return x;
  }


  public void push(int register) {
    $sp = $sp + 1;
    stack[$sp] = register;
  }
  public int pop() {
    int x = stack[$sp];
    $sp = $sp - 1; 
    $v0 = x;
    return x;
  }

}

