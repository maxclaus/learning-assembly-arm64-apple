.text
.align 4
.global input_stdin

.set STDIN, 0
.set SYSCALL_READ, 3

// x1 contains pointer to string
// x2 is the length of the target string
// x0 contains the number of byte sread
input_stdin:
	stp x29, x30, [sp, #-16]!
	stp x2, x8, [sp, #-16]!

	// x1 gets overriden by the read syscall,
	// so we need to save the string address to the stack as well
	str x1, [sp]

	mov x0, #STDIN
	mov x16, #SYSCALL_READ
	svc #0

	ldr x1, [sp]       // loads back the string pointer

	subs x0, x0, #1
	ldrb w8, [x1, x0]
	cmp w8, #'\n'
	beq input_stdin_exit
	add x0, x0, #1

input_stdin_exit:
	ldp x2, x8, [sp], #16
	ldp x29, x30, [sp], #16
	ret
