// This program is based on this tutorial ARM64 for Linux:
// https://www.youtube.com/watch?v=eq60hjbHsmk
// The source code can be found at:
// https://github.com/rdoetjes/tuts/blob/main/asm/arm64_linux/toupper/hello64.s

.text
.align 4
.global _start

_start:
	adrp x1, s_bitcount@PAGE			// set x1 to string pointed to by s_bitcount
	add x1, x1, s_bitcount@PAGEOFF
	ldr x2, =len_s_bitcount				// set x2 to the length of the s_bitcount string
	bl print							// print the string to the screen

	ldr x0, =value						// set the number that we want to count the number of set bits from
	bl printUInt						// print that number in decimal

	adrp x1, s_bitcount1@PAGE			// set x1 to string pointed to by s_bitcount2
	add x1, x1, s_bitcount1@PAGEOFF

	ldr x2, =len_s_bitcount1    		// set x3 to the length of the s_bitcount1 strong
	bl print							// print the s_bitcount1 string to the screen

	bl bitCount							// count the number of set bits in X0, result will be in X0
	bl printUInt						// prints the number of set bits

	mov X0, #0							// set the exit code to 0
	bl exit								// call exit

//Will count the number of set bits in the number in register X0
//Result X0 will contain the number of set bits after calling this routine
bitCount:
	stp x29, x30, [sp, #-16]!	// store frame pointer and  stack pointer on the stack
	stp x1, x2, [sp, #-16]!		// store x1 and x2 on the stack (so they won't be globbered)

	mov x2, #0					// x2 is used to count the set bits, initialize it to 0
bitCount_Counter:
	cmp x0, #0					// if x0 is 0 then there's no more set bits and we should return
	beq bitCount_Exit			// return when there's no more set bits
	add x2, x2, #1				// increment the bit counter, everytimne we hit the loop a bit is set
	//n = n & n-1
	sub x1, x0, #1				// n &= n-1 this is the Kernighan algorithm, to count bits efficiently
	and x0, x0, x1				// (where x0 = n and x1 = n-1)

	bne bitCount_Counter		// x0 is not 0 yet, so there are still be set bits in the value x0

bitCount_Exit:
	mov x0, x2					// copy number of set bits to x0, as x0 contains our result
	ldp x1, x2, [sp], #16		// pop x1 and x2 from stack (so they won't be globbered)
	ldp x29, x30, [sp], #16		// pop fp and sp from stack (so they won't be globbered)
	ret				//return

//Print value in X0 as an unisgned int to screen
printUInt:
	stp x29, x30, [sp, #-16]!	// store frame pointer and  stack pointer on the stack
	stp x5, x7, [sp, #-16]!		// push x5 and x7 to stack (so they won't be globbered)
	stp x2, x3, [sp, #-16]!		// push x2 and x3 to stack (so they won't be globbered)
	stp x0, x1, [sp, #-16]!		// push x0 and x1 to stack (so they won't be globbered)

	mov x7, #10					// x7 will contain the divider (10) used in udiv and msub
	mov x5, #0					// x5 counts the number of digits stored on stackl
	sub sp, sp, #128			// move stack pointer down 128 bytes, so we have space to store the to print digits

	cmp x0, #0					// if x0=0 then the division algorithm will not work
	beq printUInt_Zero			// we set the value on the stack to 0

printUInt_Count:
	udiv x2, x0, x7			// divide the value x0 by 10
	msub x3, x2, x7, x0		// obtain the remainder (x3) and the Quotient (x2)
	add x5, x5, #1			// increment the digit counter (x5)
	strb w3, [sp, x5]		// store the digit on the stack as single byte
	mov x0, x2				// copy the Quotient (x2) into x0 which is the new value to divide by 10
	cmp x0, #0				// if the Quotient (x0) is 00 then we found all individual digits
	bne printUInt_Count		// if x0 is not yet zero than there's more digits to extract
	b printUInt_print		// we set all the digits on the stack now we can pop them off and print them

printUInt_Zero:				// this is the exceptional case when x0 is 0 then we need to push this ourselves to the stack
	add x5, x5, #1 			// x5 is not used so still 0, there for we need to offset it by 1 for the sp offset
	strb w0, [sp, x5]		// set the value 0 to the stack, so that it can be printed to the screen

	//using the stacl guarantees that the digits are printed in the right order (from large to smallest_
printUInt_print:
	ldrb w3, [sp, x5]			// pop the last digit from the stack (the biggest value)
	adrp X1, char@PAGE			// set X1 to the char variable address, so we can store the char there later on
	add X1, X1, char@PAGEOFF
	add w3, w3, 48				// add 48 to the number, turning it into an ASCII char 0-9
	strb w3, [x1]				// store the ASCII char in the char variable (pointed to by X1)
	mov x2,#1					// set the length to write() to 1
	bl print					// call the writer() system call wrapper
	subs x5, x5, #1				// reduce x5 by 1, pointing to the next digit on the stack
	bne printUInt_print			// if x5 is not 0 then there are still digits on the stack, that should be printed

printUInt_exit:
	add sp, sp, #128			// reclaim the 128 bytes local storage on the stack
	ldp x0, x1, [sp], #16		// pop x0 and x1 from stack (so they won't be globbered)
	ldp x2, x3, [sp], #16		// pop x2 and x3 from stack (so they won't be globbered)
	ldp x5, x7, [sp], #16		// pop x5 and x7 from stack (so they won't be globbered)
	ldp x29, x30, [sp], #16		// pop fp and sp from stack (so they won't be globbered)
	ret 				//return

//Print to STDOUT the message pointed by X1
//X1 is string ptr
//X2 is string length of the string
print:
	stp x29, x30, [sp, #-16]!	// store fp and sp on the stack
	stp x2, x8, [sp, #-16]!		// store x2 and x8 on the stack (so they won't be globbered)
	stp x0, x1, [sp, #-16]!		// store x0 and x1 on the stack (so they won't be globbered)

	mov X0, #1					// set X0 to point to standard out
	mov X16, #4					// write syscall
	svc #0						// call system call (64 => write)

	ldp x0, x1, [sp], #16		// pop x0 and x1 from stack (so they won't be globbered)
	ldp x2, x8, [sp], #16		// pop x2 and x8 from stack (so they won't be globbered)
	ldp x29, x30, [sp], #16		// pop fp and sp from stacl
	ret							//return to caller

//Exit to operating system, X0 will contain the exit code
//X0 contains exit code
exit:
	mov X16, #1			// exit system call
	svc #0				// call system call (93 => exit)
	ret					// this won't be called because exit will terminate program before we get here

.data
s_bitcount:	.ascii "We are counting the number of set bits in #"
len_s_bitcount = . - s_bitcount

s_bitcount1: 	.ascii " which there are #"
len_s_bitcount1 = . - s_bitcount1

value = 65535

char: 		.byte 0
