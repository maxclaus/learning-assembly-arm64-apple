// Program adapted from linux arm to apple arm64
// based on "lesson10-arm-linux-example.s".
//
// In arm 32-bit we can pass up to 4 args through the registers, and the rest
// must be passed through the stack. In arm 64-bit we can pass up to 8 args
// through the general purpose registers.

.global _start

_start:

	mov x0, #1 // arg1
	mov x1, #2 // arg2
	mov x2, #3 // arg3
	mov x3, #4 // arg4
	mov x4, #5 // arg5
	mov x5, #6 // arg6
	mov x6, #7 // arg7
	mov x7, #8 // arg8

	// Allocate some space on the stack.
	// sp = Stack pointer
	// We allocate 16-bytes on the stack because we intend to
	// store 2 integers on the stack, and each integer is 8-bytes long
	// on a AArch64.
	sub sp, sp, #16

	// Variables into the stack
	mov x8, #9
	str x8, [sp] // store x8 on the next location on the stack
	mov x8, #10
	str x8, [sp, #8] // offset by 4 to store x8 on the next location on the stack

	bl add_nums
	mov x2, x0   // save x0 to x2, so we don't lose once we restore the original x0 from stack

	add sp, sp, #16 // reset stack space

	// Exit program
	mov x0, 0		// 0 status code
	mov x16, 1
	svc 0


add_nums:
	// sum up numbers from registers
	add x0, x0, x1
	add x0, x0, x2
	add x0, x0, x3
	add x0, x0, x4
	add x0, x0, x5
	add x0, x0, x6
	add x0, x0, x7

	// sum up numbers from stack
	ldr x8, [sp, #8] // use offset to get last arg
	add x0, x0, x8
	ldr x8, [sp] // no offset this time, gets the fist argument
	add x0, x0, x8

	ret
