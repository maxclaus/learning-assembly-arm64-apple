// Program adapted from linux arm to apple arm64
// based on "lesson02-arm-linux-example.s".
.global _start

_start:
	mov X0, #4
	add X1, X0, #3 // sum instruction

	mov X0, #10
	mov X1, #5
	sub X2, X0, X1 // subtraction instruction


	mov X0, #2
	mov X1, #3
	mul X2, X0, X1 // multiply instruction

	// In this last instruction the result will be 0, and since we are using
	// the `s` suffix for the `sub` instruction, it will save a zero
	// flag on CPSR.
	mov X0, #3
	mov X1, #3
	subs X2, X0, X1 // subtraction instruction saving flags to CPSR

	// Exit program.
	// X16 register is used by the svc instruction to determine which syscall will be executed.
	mov X0, 0		// 0 status code
	mov X16, #1
	svc 0
