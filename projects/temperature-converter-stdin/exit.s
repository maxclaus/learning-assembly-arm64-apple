.text
.align 4
.global exit

.set SYSCALL_EXIT, 1

// Exit to operating system, X0 will contain the exit code
// X0 contains exit code
exit:
	mov X16, #SYSCALL_EXIT	// exit system call
	svc #0			        // call system call (1 => exit)
	ret				        // this won't be called because exit will terminate program before we get here
