// Program adapted from linux arm to apple arm64
// based on "lesson06-arm-linux-example.s".

.global _start

_start:
	mov x0, #4
	mov x1, #5

	// x0 - x1
	// if x0 > x1 -> result is a positive number
	// if x0 < x1 -> result is a positive negative
	// if x0 == x1 -> result is zero
	cmp x0, x1

	// Exit program
	mov X0, 0		// 0 status code
	mov X16, 1
	svc 0
