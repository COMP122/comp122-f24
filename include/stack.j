
  // stack.s
   public void push(int register) {
    $sp = $sp + 1;
    STACK[$sp] = (Object) register;
  }

  public void push(char[] register) {
    $sp = $sp + 1;
    STACK[$sp] = (Object) register;
  }
  
  public Object pop() {
    Object x = (Object) STACK[$sp];
    $sp = $sp - 1; 
    return x;
  }

  public static void alloca(int register) {
     $sp = $sp - alloca_adjust(register, 0x03);
  }
  public static void allocai(int value) {
      alloca(value);
  }

  public static int alloca_adjust(int register, int mask) {
    // Modify the value of register to ensure multiple of the mask

    int amount = 0;
    int temp = 0;

    amount = register;
    temp   = amount & mask;
    if (temp != 0) {
      // not a multiple of the mask
      temp = ~ mask;
      amount = register + mask;
      amount = amount + 1;
    }
    return register;
  }
