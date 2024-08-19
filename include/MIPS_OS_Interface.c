// To be used with \*.j or a \*.c file
// The Java subset used by java_subroutine is almost C
// The differenences include:
//    - C has a preferred switch structure
//    - some extra syntax (see #defines below)  
//    - methods used to call the OS

#include <sys/types.h>
#include <sys/uio.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>


#define public
#define final const
#define null '\0'
#define byte char

// Manage the special registers
// Note that these variables may differ from the main class register declarations
final static int $zero = 0;
static int $v0 = -1; 
static int $v1 = -1; 
static int $gp = -1;
static int $fp = -1;
static int $sp = -1;
static int $ra = -1;

// MEMORY
static int sbrk_p  = 0;
static byte  MEM[1024];
static int   STACK[1024];
static byte  IO[1024];

#define buf_max 1024
static byte * buffer = IO;

static void mips_sbrk(int size) {
  $v0 = sbrk_p;
  sbrk_p += size;
}

void mips_push(int reg) {
  $sp = $sp + 1;
  STACK[$sp] = reg;
}
int mips_pop() {
  int x = STACK[$sp];
  $sp = $sp - 1; 
  $v0 = x;
  return x;
}

static int mips_retval() {
  return $v0;
}

int mips_open(char* str, int flags, int mode) {
   if (mode != 0) {
      fprintf(stderr, "Mode is ignored via the open syscall\n");
      exit(2);
   }
   switch (flags) {
     case 0: 
      flags = O_RDONLY;
      break;

    case 1:
      flags = (O_WRONLY | O_CREAT);
      break;

    case 9: 
      flags = (O_WRONLY | O_CREAT | O_APPEND);
      mode  = 0666;  // rw-rw-rw-
   }
   $v0 = open(str, flags, mode);
   return $v0;
}
int mips_close(int fd) {
  $v0 = close(fd);
  return $v0;
}


static void mips_read(int fd, byte * buffer, int size) {
    int retval = read(fd, (void *) buffer, size); 
    $v0 = retval;
}
#define mips_read_s(buff, count)   fgets(0, buff, count); $v0 = $v0
#define mips_read_d()  fgets(buffer, buf_max, stdin) ; $v0 = strtol(buffer, null, 10)
#define mips_read_x()  fgets(buffer, buf_max, stdin) ; $v0 = strtol(buffer, null, 16)
#define mips_read_o()  fgets(buffer, buf_max, stdin) ; $v0 = strtol(buffer, null, 8)
#define mips_read_t()  fgets(buffer, buf_max, stdin) ; $v0 = strtol(buffer, null, 2)
#define mips_read_c()  read(0, buffer, 1)



#define mips_print_d(reg)   printf("%d", reg)
#define mips_print_di(reg)  printf("%d", imm)
#define mips_print_c(reg)   printf("%c", reg)
#define mips_print_ci(imm)  printf("%c", imm)

#define mips_print_s(reg)   printf("%s", reg)
#define mips_print_x(reg)   printf("%x", reg)  
#define mips_print_xi(imm)  printf("%x", imm)  

#define mips_print_u(reg)   printf("%u", reg)
#define mips_print_ui(imm)  printf("%u", reg)
#define print_fs(reg)       printf("%f" (double) reg) 
#define print_fd(reg)       printf("%f" (double) reg)

#define mips_print_f(reg)   printf("%f",(double) reg)
#define mips_print_fi(reg)  // Not Implemented


void mips_print_t(int value) {

  int remainder;
  int count = 0;

  while (value > 0) {
    remainder = value % 2;
    value     = value / 2;
    mips_push(remainder);
    count++;
  }

  for (int i=32; i > count; i--) {
    printf("%c", '0');
  }
  for (; count >= 0 ; count--) {
     printf("%c", mips_pop());
  }
  return;
}
#define mips_print_ti(imm) print_t(imm)


#define mips_exit(reg)  exit(reg)
#define mips_exiti(imm) exit(imm)


////  TYPE Conversion
//public static int u_byte(byte value) {
//  return Byte.toUnsignedInt(value);
//}
//public static int s_byte(byte value) {
//  return value;
//}

//public static int u_half(short value) {
//  return Short.toUnsignedInt(value);
//}
//public static int s_half(short value) {
//  return value;
//}





