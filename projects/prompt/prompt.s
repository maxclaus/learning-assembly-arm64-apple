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
.set STDIN, 0
.set STDOUT, 1

.set SYSCALL_EXIT, 1
.set SYSCALL_READ, 3
.set SYSCALL_WRITE, 4

_main:
	// Part 1: Print prompt message
	// ------------------------------
	adrp x1, output_prompt@PAGE			// pointer to the prompt string
	add x1, x1, output_prompt@PAGEOFF
	ldr x2, =output_prompt_len			// length of the string
	bl _print							// Use bl (branch link) so link register (x30) is
										// registered with this address, so we can use "ret"
										// later inside _print function to get back to this address.

	// Part 2: Scan input
	// ------------------------------
	adrp X1, input@PAGE          //set X1 to address of the string
	add X1, X1, input@PAGEOFF    //align to 64 bits
	ldr X2, =input_len

	// The syscalls override x1 and x2 and we need
	// these registers content later again in order to print
	// what the user typed into our program.
	stp x1, x2, [sp, #-16]!

	bl _scan
	// When running lldb debugger, use "x -s 4 -f c &input" to print string.

	// Part 3: Print got message
	// ------------------------------
	adrp x1, output_got@PAGE			// pointer to the got string
	add x1, x1, output_got@PAGEOFF
	ldr x2, =output_got_len				// length of the string
	bl _print

	// Part 4: Print input data
	// ------------------------------
	ldp x1, x2, [sp], #16
	bl _print

	// Part 5: Exit program
	// ------------------------------
	b _exit

// Use a the write syscall to write a text to the stdout.
// https://github.com/opensource-apple/xnu/blob/0a798f6738bc1db01281fc08ae024145e84df927/bsd/kern/syscalls.master#L45C18-L45C30
// Arguments:
// - x1 = memory address, with the content which should be printed to the stdout
// - x2 = string length
_print:
	mov x0, #STDOUT				// stream type (stdout=1)
	mov x16, #SYSCALL_WRITE		// means it is about to call a write syscall operation (id=4).
	svc 0

	ret // ret is the same as "mov pc, x30", which means,
		// move back the next address before the call to this function.

// Use a the read syscall to write a text to the stdout.
// https://github.com/opensource-apple/xnu/blob/0a798f6738bc1db01281fc08ae024145e84df927/bsd/kern/syscalls.master#L44C31-L44C35
//
// Arguments:
// - x1 = memory address, where the input data should be stored
// - x2 = lenght of that memory content
_scan:
	mov X0, #STDIN				 // stream type (stdin=0)
	mov X16, #SYSCALL_READ		 // means it is about to call a read syscall operation (id=3).
	svc 0

	ret                          // ret is the same as "mov pc, x30", which means,
		                         // move back the next address before the call to this function.

_exit:
	mov X0, #0              // 0 = success exit status code
	mov X16, #SYSCALL_EXIT  // 1 = supervisor exit command
	svc 0                   // call supervisor with the previous parameters


.data
output_prompt: .ascii "Number: "
output_prompt_len = . - output_prompt

output_got: .ascii "Got: "
output_got_len = . - output_got

input: .fill 4,1,0	// 4 bytes and fill it with zero
input_len = . - input // length
