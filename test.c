int f(int a, int b) {
   int c;
   int d;

   a = 1;  
   b = 2;  
   c = 3;  
   d = 4;  
   return f ( c, d);
}

int main () {
  int x = 2;
  int y = 3;
  int c;

  c = f(x, y);
  return c;

}