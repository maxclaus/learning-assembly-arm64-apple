// This program is based on this tutorial ARM64 for Linux:
// https://www.youtube.com/watch?v=uB02Mr9tS7Q
// The source code can be found at:
// https://github.com/rdoetjes/tuts/blob/main/asm/arm64_linux/decimal/input.s
.text
.align 4
.global inputSTDIN

// x1 contains pointer to string
// x2 is the length of the target string
// x0 contains the nunber of byte sread
inputSTDIN:
	stp x29, x30, [sp, #-16]!
	stp x2, x8, [sp, #-16]!

	// x1 gets overriden by the read syscall,
	// so we need to save the string address to the stack as well
	str x1, [sp]

	mov x0, #0
	mov x16, #3        // 3 = read syscall
	svc #0

	ldr x1, [sp]       // loads back the string pointer

	subs x0, x0, #1
	ldrb w8, [x1, x0]
	cmp w8, #'\n'
	beq inputSTDIN_exit
	add x0, x0, #1

inputSTDIN_exit:
	ldp x2, x8, [sp], #16
	ldp x29, x30, [sp], #16
	ret
.data
