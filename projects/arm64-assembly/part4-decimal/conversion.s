// This program is based on this tutorial ARM64 for Linux:
// https://www.youtube.com/watch?v=uB02Mr9tS7Q
// The source code can be found at:
// https://github.com/rdoetjes/tuts/blob/main/asm/arm64_linux/decimal/conversion.s
.text
.align 4
.global atoi

// Converts the string in x1 into decimal
// atoi = ASCII to integer
// x1 is input
// x2 is length of input
// x0 contains output
atoi:
	stp x29, x30, [sp, #-16]!   // store frame pointer and  stack pointer on the stack
	stp x5, x6, [sp, #-16]!     // push x5 and x7 to stack (so they won't be globbered)
	stp x3, x4, [sp, #-16]!     // push x2 and x3 to stack (so they won't be globbered)
	stp x1, x2, [sp, #-16]!     // push x0 and x1 to stack (so they won't be globbered)

	mov x5, #1					// mulitplier
	mov x0, #0					// result
	mov x3, #0					// temporary storage
	mov x6, #10					// decimal multiplier (10 base)

atoi_readchar:
	sub x2, x2, #1              // subtract 1 from lenght, because it should start from 0
	ldrb w3, [x1, x2]           // load into w3 the last charactor of the string in x1, so x1 with offset of x2
	sub x3, x3, #48			    // subtract 48 to the ASCII char 0-9, turning it into an number
	mul x3, x3, x5              // multiply by one
	add x0, x0, x3              // add to value result
	mul x5, x5, x6              // decimal multipler (10 base)
	cmp x2, #0                  // check if length is zero, the whole string has been converted
	bne atoi_readchar           // otherwise loop over and convert the next byte

	ldp x1, x2, [sp], #16		// pop x0 and x1 from stack (so they won't be globbered)
	ldp x3, x4, [sp], #16       // pop x2 and x3 from stack (so they won't be globbered)
	ldp x5, x6, [sp], #16       // pop x5 and x7 from stack (so they won't be globbered)
	ldp x29, x30, [sp], #16     // pop fp and sp from stack (so they won't be globbered)
	ret
.data
