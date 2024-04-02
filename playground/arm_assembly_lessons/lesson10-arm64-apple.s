// Program adapted from linux arm to apple arm64
// based on "lesson10-arm-linux-example.s".
//
// In arm 32-bit we use push and pop to add values to the stack
// without having save or free space from the stack for those values first.
// In arm 64-bit we need to use stp for push and ldp for pop instead because there is
// no push and pop operations available:
// https://community.arm.com/arm-community-blogs/b/architectures-and-processors-blog/posts/using-the-stack-in-aarch32-and-aarch64
//
// https://developer.arm.com/documentation/102374/0102/Loads-and-stores---load-pair-and-store-pair?lang=en

// Also, aarch64 has "bx" mnemonic, we use "ret" instead to return to the previous function.

.global _start

_start:
	mov w0, #1 // arg1
	mov w1, #2 // arg2

	stp w0, w1, [sp, #-16]! // push these values to the stack before we branch to another location.

	bl add_nums
	mov w2, w0   // save w0 to w2, so we don't lose once we restore the original w0 from stack

	ldp w0, w1, [sp], #16 // pop off w0, w1 with the values they were before going into add_numbs

	// Exit program
	mov x0, 0		// 0 status code
	mov x16, 1
	svc 0

add_nums:
	// stores the result back to w0, that is why we need to store the original
	// w0 on _start into the stack, so we could restore it later.
	add w0, w0, w1
	ret
