
static char [] buffer = new char[256];
static char [] buffer2;

public static int strcat( char [] first, char [] second) {
   // returns the 'first + second'

   int i;
   int j;

   
   for (i = 0; first[i] != '\0'; i++) {
      buffer[i] = first[i];
   }
   for (j = 0; second[j] != '\0'; j++) {
      buffer[i+j] = second[j];
   }
   buffer[i+j+1]='\0';

   mips.print_s(buffer);
   return i+j+1;

}
