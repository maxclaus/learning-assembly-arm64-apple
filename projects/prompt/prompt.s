// This is an example of a prompt with input and output data.
//
// The input part was based on https://www.youtube.com/watch?v=uB02Mr9tS7Q
//
// Important note: In this example we read fix 4 characters from stdin,
// it works fine if we expect users to type in only that max characters,
// but if a user type in more than that, any extra char won't be read
// by the program, and will be executed a shell command once the program is over.
// If we want to make it more safe for that kind of issue, we could
// keep reading one by at time, until we found a `\n` character.

.global _main	// Provide program starting address to linker
.align 4		// Make sure everything is aligned properly

// POSIX standard streams file descriptor codes:
// - 0 = standard input file descriptor (stdin)
// - 1 = standard output file descriptor (stdout)
// - 2 = standard error file descriptor (stderr)

_main:
	bl _print_prompt	// Use bl (branch link) so link register (x30) is
						// registered with this address, so we can use "ret"
						// later inside _print function to get back to this address.

	bl _scan_number

	bl _print_number_msg

	// When running lldb debugger, use "x -s 4 -f c &input" to print string.
	bl _print_number

	b _exit

// Use a the write syscall to write a text to the stdout.
// https://github.com/opensource-apple/xnu/blob/0a798f6738bc1db01281fc08ae024145e84df927/bsd/kern/syscalls.master#L45C18-L45C30
_print_prompt:
	mov X0, #1					// pass 1 for the first argument, which 1 means stdout
	adr X1, text_number_input	// pass second argument, which is the pointer the string
	mov X2, #8					// pass the third argument, which is the length of the string
	mov X16, #4					// means it is about to call a write syscall operation (id=4).
	svc 0

	ret // ret is the same as "mov pc, x30", which means,
		// move back the next address before the call to this function.

// Print output message without the number part
_print_number_msg:
	mov X0, #1					// pass 1 for the first argument, which 1 means stdout
	adr X1, text_number_output	// pass second argument, which is the pointer the string
	mov X2, #5					// pass the third argument, which is the length of the string
	mov X16, #4					// means it is about to call a write syscall operation (id=4).
	svc 0

	ret // ret is the same as "mov pc, x30", which means,
		// move back the next address before the call to this function.

// Print the number from user input
_print_number:
	adrp X1, input@PAGE          // set X1 to address of the string
	add X1, X1, input@PAGEOFF    // align to 64 bits
	ldr X2, =input_len

	mov X0, #1					// pass 1 for the first argument, which 1 means stdout
	mov X16, #4					// means it is about to call a write syscall operation (id=4).
	svc 0

	ret // ret is the same as "mov pc, x30", which means,
		// move back the next address before the call to this function.

// Use a the read syscall to write a text to the stdout.
// https://github.com/opensource-apple/xnu/blob/0a798f6738bc1db01281fc08ae024145e84df927/bsd/kern/syscalls.master#L44C31-L44C35
//
// Output registers:
// X0 contains the number of bytes read
// X1 contains pointer to string
// X2 is the length of the target string
_scan_number:
	adrp X1, input@PAGE          //set X1 to address of the string
	add X1, X1, input@PAGEOFF    //align to 64 bits
	ldr X2, =input_len

	mov X0, #0					// pass 1 for the first argument, which 0 means stdin
	mov X16, #3					// means it is about to call a read syscall operation (id=3).
	svc 0

	ret // ret is the same as "mov pc, x30", which means,
		// move back the next address before the call to this function.


_exit:
	mov X0, #0   // 0 = success exit status code
	mov X16, #1  // 1 = supervisor exit command
	svc 0        // call supervisor with the previous parameters

text_number_input: .ascii "Number: "
text_number_output: .ascii "Got: "

.data
input: .fill 4,1,0	// string with 4 bytes and fill it with zero
input_len = . - input // length
