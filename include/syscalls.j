// File: syscalls.j
//
// Description: a companion file for syscalls.s
//
// Purpose: to provide the corresponding macros via Java methods
//
//
//# | Macro Name       | Code | Prototype             |
//# |------------------|------|-----------------------|
//# | print_d          |  1   | void ƛ(int);          |
//# | print_di         |  1   | void ƛ(imm);          |
//# | print.s          |  2   | void ƛ(float);        | # to match c1 instructions
//# | print.d          |  3   | void ƛ(double);       | # to match c1 instructions
//# | print_f          |  3   | void ƛ(double);       | # to match printf
//# | print_s          |  4   | void ƛ(&str);         |
//# | print_si         |  4   | void ƛ(label);        |
//# | read_d           |  5   | int  ƛ(void);         |
//# | read_s           |  8   | int  ƛ(&str, int);    |
//# | read_si          |  8   | int  ƛ(&str, imm);    |
//# | sbrk (allocate)  |  9   | &buffer ƛ(int);       |
//# | sbrki (allocate) |  9   | &buffer ƛ(imm);       |
//# | exit (w/o value) | 10   | void exit(void);      |
//# | print_c          | 11   | void ƛ(byte);         |
//# | print_ci         | 11   | void ƛ(byte);         |
//# | read_c           | 12   | byte ƛ(void);         |
//# | open (fd)        | 13   | fd ƛ(&str, int, int); |
//# | read (from fd)   | 14   | int ƛ(fd, &buf, int); |
//# | write (to fd)    | 15   | int ƛ(fd, &buf, int); |
//# | close (fd)       | 16   | void ƛ(fd);           |
//# | exit (w value)   | 17   | void ƛ(int);          | 
//# | exiti (w value)  | 17   | void ƛ(imm);          |
//# | print_x          | 34   | void ƛ(int);          |
//# | print_xi         | 34   | void ƛ(imm);          |
//# | print_t          | 35   | void ƛ(imm);          |
//# | print_ti         | 35   | void ƛ(int);          |
//# | print_u          | 36   | void ƛ(int);          |
//# | print_ui         | 36   | void ƛ(imm);          |
//
// Refer to the definition of specific macros for additional information

  static Scanner stdin = new Scanner(System.in);

//# ####################################################
//# Macros that perform input from stdin
//#
//# | read_d           |  5   | int  ƛ(void);         |
//# | read_c           | 12   | byte ƛ(void);         |
//# | read_s           |  8   | int  ƛ(&str, int);    |
//# | read_si          |  8   | int  ƛ(&str, int);    |


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

  // Should follow the semantics of UNIX 'fgets'.  
  //   Reads at most n-1 characters. A newline ('\n') is placed in the last
  //   character read, and then string is then padded with a null character ('\0').
  //   If n = 1, input is ignored, and a null byte written to the buffer.
  //   If n <=1, input is ignored, and nothing is written to the buffer.
  // $v0 defines the actual number of bytes read
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
  public static void read_si(char [] A, int count) {
    read_s(A, count);
  }


//#####################################################
//# Macros that perform output to stdout
//#
//# | print_d          |  1   | void ƛ(int);          |
//# | print_di         |  1   | void ƛ(int);          |
//# | print.s          |  2   | void ƛ(float);        | # to match c1 instructions
//# | print.d          |  3   | void ƛ(double);       | # to match c1 instructions
//# | print_f          |  3   | void ƛ(double);       | # to match printf
//# | print_s          |  4   | void ƛ(&str);         |
//# | print_si         |  4   | void ƛ(label);        |
//# | print_c          | 11   | void ƛ(byte);         |
//# | print_ci         | 11   | void ƛ(byte);         |
//# | print_x          | 34   | void ƛ(int);          |
//# | print_xi         | 34   | void ƛ(int);          |
//# | print_t          | 35   | void ƛ(int);          | 
//# | print_ti         | 35   | void ƛ(int);          | 
//# | print_u          | 36   | void ƛ(int);          | 
//# | print_ui         | 36   | void ƛ(int);          | 

  public static void print_d(int register) {
    System.out.printf("%d", register);
    return;
  }

  public static void print_di(int immediate) {
    System.out.printf("%d", immediate);
    return;
  }

  //public static void print.s(float register) {
  //  System.out.printf("%f", register);
  //}
  //public static void print.d(double register) {
  //  System.out.printf("%f", register);
  //}
  public static void print_f(double register) {
    System.out.printf("%f", register);
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
  public static void print_si(String immediate) {
    System.out.printf("%s", immediate);
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
  public static void print_si(char [] immediate) {
    print_s(immediate);
  }


  public static void print_x(int register) {
    System.out.printf("%x", register);
    return;
  }
  public static void print_xi(int immediate  ) {
    System.out.printf("%x", immediate);
    return;
  }

  // public static void print_t(int register) {
  //   StringBuilder binaryValue = new StringBuilder();
  //   String binaryString;
  //   long value = Integer.toUnsignedLong(register);  // Java does not have unsigned
  //   long remainder;
  //
  //   while (value > 0) {
  //       remainder = value % 2;
  //       value     = value / 2;
  //       binaryValue.append(remainder);
  //   }
  //   binaryString = binaryValue.reverse().toString();
  //   for (int i=32; i > binaryString.length(); i--) {
  //     System.out.printf("%c", '0');
  //   }
  //   System.out.printf("%s", binaryString);
  //   return;
  // }
  public static void print_t(int register) {
     print_bits(register, 31, 0);
     return;
  }
  public static void print_ti(int immediate) {
    print_bits(immediate, 31, 0);
    return;
  }


  public static void print_u(int register) {
    System.out.printf("%u", register);
  }
  public static void print_ui(int immediate) {
    System.out.printf("%u", immediate);
  }


// ######################################################
// # Macros that perform I/O on files
// # | open (fd)         | 13   | fd ƛ(&str, int, int); | filename, flags, mode
// # | read (from fd)    | 14   | int ƛ(fd, &buf, int); | bytes read |
// # | write (to fd)     | 15   | int ƛ(fd, &buf, int); | bytes read |
// # | close (fd)        | 16   | void ƛ(fd);           |

// # Open: Service 13: MARS implements three flag values: 
//#     0: read-only, 
//#     1: write-only with create
//#     9: write-only with create and append.  
//#     It ignores mode.  
//#     The returned file descriptor will be negative if the operation failed. 
//#  

  static Object FD_LIST[] = new Object[8];
  static int last_fd = 2;

  public static int open(String name, int flags, int mode) {

    last_fd ++;

    try {
      switch (flags) {
      case 0:
         FD_LIST[last_fd] = (Object) new FileInputStream(name);
         break;
      case 1:
      case 9:
         FD_LIST[last_fd] = (Object) new FileOutputStream(name);
         break;
       default:
          System.out.printf("Flag not implemented\n");
          System.exit(1);
          break;
      }
    } catch (IOException x) {
      return -1;
    }
    return last_fd;
  }

 public static int open(char [] name, int flags, int mode) {

    String string = new String(name);
    return open(string, flags, mode);
  }

  public static int read(int fd, byte buffer, int size) {
    try { 
      return ((FileInputStream) FD_LIST[fd]).read(MEM, buffer, size);
    } catch (IOException x) {
      return -1;
    }
  }

  public static int read(int fd, byte buffer[], int size) {
    try { 
      return ((FileInputStream) FD_LIST[fd]).read(buffer, 0, size);
    } catch (IOException x) {
      return -1;
    }
  }


  public static int write(int fd, byte buffer, int size) {
    try {
      ((FileOutputStream) FD_LIST[fd]).write(MEM, buffer, size);
    } catch (IOException x) {
      return -1;
    }
    return size;
   }


  public static int write(int fd, byte buffer[], int size) {
    try {
      ((FileOutputStream) FD_LIST[fd]).write(buffer, 0, size);
    } catch (IOException x) {
      return -1;
    }
    return size;
  }        

  public static void close(int fd) {
    try { 
      if (FD_LIST[fd] instanceof FileInputStream) 
        ( (FileInputStream) FD_LIST[fd]).close();
      else
         ( (FileOutputStream) FD_LIST[fd]).close();
     } catch (IOException x) {
       ;
     }
     return;
  }

// ######################################################
// # Macros that perform other system related activities
// 
// # | sbrk (allocate)   |  9   | &buffer ƛ(int);       |
// # | sbrki (allocate)  |  9   | &buffer ƛ(imm);       |
// # | exit              | 10   | void ƛ(void);         |
// # | exit              | 17   | void ƛ(int);          |
// # | exiti             | 17   | void ƛ(imm);          |

  public static void sbrk(int size) {
    $v0 = sbrk_p;
    sbrk_p += size;
  }
  public static void allocate(int size) {
    sbrk(size);
  }
  public static void sbrki(int size) {
    sbrk(size);
  }
  public static void allocatei(int size) {
    sbrk(size);
  }

  public static void exit(int register) {
    System.exit(register);
    return;
  }
  public static void exiti(int immediate) {
    System.exit(immediate);
    return;
  }
