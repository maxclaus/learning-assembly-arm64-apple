// This program is based on this tutorial ARM64 for Linux:
// https://www.youtube.com/watch?v=eq60hjbHsmk
// The source code can be found at:
// https://github.com/rdoetjes/tuts/blob/main/asm/arm64_linux/toupper/hello64.s

.text
.align 4
.global _start

_start:
	// set X0 to point to string starting address
	// DEBUGGING TIP: use `x -s 26 -f c &string --force` on lldb debugger
	// to print X0 content as string.
	adrp X0, string@PAGE
	add X0, X0, string@PAGEOFF

	// set X1 to point top uppercase starting address
	// DEBUGGING TIP: use `x -s 26 -f c &uppercase --force` on lldb debugger
	// to print X0 content as string.
	adrp X1, uppercase@PAGE
	add X1, X1, uppercase@PAGEOFF

	// Set X2 to length.
	// DEBUGGING TIP: use `p $X2` to print X2 content as decimal.
	ldr X2, =len

	bl toupper						// call function toupper

	mov W3, #2						// set W3 to 5, this is the number of time we will print the text
_loop:
	adrp X1, uppercase@PAGE			// set X1 to point to uppercase ptr
	add X1, X1, uppercase@PAGEOFF

	ldr X2, =len					// set X2 to len
	bl print						// call print
	subs W3, W3, #1				// decrement the W3 counter
	bne _loop					// continue to print, as long as W3 is not 0

	mov X0, #0			//set the exit code to 0
	bl exit				//call exit

// Turn string X0 to uppercase and the uppercase result will be pointed to by X1
// X0 contains source string ptr,
// X1 contains uppercase ptr
// X2 contains length
toupper:
	// DEBUGGING TIP: use `re read W3 -f c` to print content as string.
	ldrb W3, [X0], #1	// load byte from X0 (source string) and increment the pointer
	cmp W3, #'a'		// if charachter read is >=a then turn into uppercase, else copy it
	bge _toupper		// turn into uppercase
	b _store			// copy the value if its not [a-z]

_toupper:
	cmp W3, #'z'		// if byte read from source is >z then we just copy it otherwise we turn it into a captitol
	bgt _store			// the byte read was greater than the value z, so we copy
	subs W3, W3, #32	// byte was in the range of [a-z] so we can take away 32 to make it a capitol
_store:
	strb W3, [X1], #1	// store the byte in W3 to the X1 and increment the X1 pointer
	subs X2, X2, #1		// decrement the X2 (length) of the string, if not 1 there's letters to be converted
	bne toupper			// X2 (len) is not 0, more characters to process
	ret					// ret to caller

// Print to STDOUT the message pointed by X1
// X1 is string ptr
// X2 is string length of the string
print:
	mov X0, #1		// set X0 to point to standard out
	mov X16, #4		//  write syscall
	svc #0			// call system call (64 => write)
	ret				// return to caller

// Exit to operating system, X0 will contain the exit code
// X0 contains exit code
exit:
	mov X16, #1			// exit system call
	svc #0				//call system call (93 => exit)
	ret

.data
string:
	.ascii "Hello World, ARM64 rules!\n"
len = . - string
uppercase:
	.fill len, 1, 0
