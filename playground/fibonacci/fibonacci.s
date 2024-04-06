// Program based on this article:
// https://thinkingeek.com/2017/11/05/exploring-aarch64-assembler-chapter-9/

.global _main

_main:
	mov w0, #9   // run the fibonacci program for the number 9
	b fibonacci  // run the fibonacci logic
	mov X0, x0   // return the result as the exit status code
	mov X16, #1  // tell we are about to exit the program
	svc #0		 // run supervisor for the exit command

fibonacci:
    // fibonacci(n) -> result
    //   n is 32-bit and will be passed in w0
    //   result is 64-bit and will be returned in x0
    mov w3, w0          // w3 ← w0
    cmp w3, #1          // compare w3 and 1 and update the flags
    b.le simple_case    // jump to simple_case if w3 <= 1
    sub w3, w3, #1      // w3 ← w3 - 1
    mov x1, #0          // x1 ← 0
    mov x2, #1          // x1 ← 1
    b loop_check        // branch to loop_check
loop_body:
    add x0, x1, x2      // x0 ← x1 + x2
    mov x1, x2          // x1 ← x2
    mov x2, x0          // x2 ← x0
    sub w3, w3, #1      // w3 ← w3 - 1
loop_check:
    cbnz w3, loop_body  // branch to loop_body if w3 != 0

    b fibonacci_end     // branch to fibonacci_end
simple_case:
    sxtw x0, w0         // x0 ← ExtendSigned32To64(w0)

fibonacci_end:
    ret
