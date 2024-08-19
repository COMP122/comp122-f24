import java.util.Scanner;
import java.io.*; 
import java.lang.Math;


//import java.util.*; 
//import java.util.regex.Pattern; 

// Sections of code:
//   1. MACHINE information
//   1. STACK support
//   1. TAC transformation support
//   1. SYSCALL support
//   1. IO support

class MIPS_library {

  // MACHINE
  final static int $zero = 0;
  static int $v0 = -1; 
  static int $v1 = -1; 
  static int $gp = -1;
  static int $fp = -1;
  static int $sp = -1;
  static int $ra = -1;

  // MEMORY
  static int sbrk_p = 0;
  static byte[] MEM = new byte[1024];
  static Object[] STACK = new Object[256];



  // TAC
  static public void next(String x) {
    return;
  }

  public static int retval() {
    return $v0;
  }




  // Potpourri: Things I thought I might need but just cruft at the moment

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



