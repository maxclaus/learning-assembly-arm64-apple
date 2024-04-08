#include <stdio.h>

extern int asm_sum(int a, int b);
extern int asm_dec_until_eql(int a, int b);

int main() {
  int a = 4;
  int b = 5;
  printf("Calling assembly function asm_sum with x0=%d and x1=%d results "
         "in %d\n",
         a, b, asm_sum(a, b));

  a = 4;
  b = 7;
  printf("After calling my_function, the values of both a and b are now %d\n",
         asm_dec_until_eql(a, b));
  return (0);
}
