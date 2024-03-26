// Program based on this tutorial:
// https://www.youtube.com/watch?v=aGJm3fuKLhA

.global _start

_start:

	mov r0, #4
	mov r1, #5

	// r0 - r1
	// if r0 > r1 -> result is a positive number
	// if r0 < r1 -> result is a positive negative
	// if r0 == r1 -> result is zero
	cmp r0, r1

