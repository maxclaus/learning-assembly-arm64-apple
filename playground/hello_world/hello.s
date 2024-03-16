// This program has been created based on this tutorial:
// "how hello world for arm64 assembly really works (apple silicon)"
// https://www.youtube.com/watch?v=d0OXp0zqIo0

.global _main
.align  2     // Apple silicon boundary is 2

_main:
	b _printf
	b _terminate

_printf:
	// operations for
	// 4	AUE_NULL	ALL	{ user_ssize_t write(int fd, user_addr_t cbuf, user_size_t nbyte); }
	mov X0, #1          // pass 1 for the first argument, which 1 means stdout
	adr X1, hellowworld // pass second argument, which is the pointer the hellow world string
	mov X2, #12         // pass the third argument, which is the length of the hello world string
	mov X16, #4         // menas it is about to call a write syscall operation (id=4).
	svc 0

_reboot:
	mov X0, #1   // pass 1 for the first argument
	mov X16, #55 // syscall id for the reboo operation
	svc 0

_terminate:
	// Move the value 0 (represented as #0) to into the first parameter register (represent as X0).
	// It is setting the first argument for a function that will be called next.
	// Also, important detail, on Apple Silicon chip,
	// X0-X7 are used for parameter registers.
	// Also, X prefix register means it is a 64-bit integer number.
	// And, W prefix is used for 32-bit integer numbers.
	mov X0, #0

	// Calling X16 means that it is about to call a surpervisor call.
	// In the supervisor call termination command is represented by the   // number 1.
	mov X16, #1

	// Call the supervisor call through "svc" command.
	// svc -> sv=supervise, c=call
	// It is a syscall, a call to the OS.
	// List of supported supervisor calls:
	// https://opensource.apple.com/source/xnu/xnu-1504.3.12/bsd/kern/syscalls.master
	svc 0

hellowworld:
	// hello world string
	//  ascii operation assembles each string (with no automatic trailing zero byte)
	// into consecutive addresses.
	// https://sourceware.org/binutils/docs/as/Ascii.html
	.ascii "hello world\n"
