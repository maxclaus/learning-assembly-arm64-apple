// Program adapted from linux arm to apple arm64
// based on "lesson08-arm-linux-example.s".

.global _start

_start:

	mov x0, #4
	mov x1, #5

	cmp x0, x1

	beq cond1   // if equal go to cond1
	b cond2     // else go to cond2

cond1:
	mov x2, #1

	// Exit program
	mov X0, 0		// 0 status code
	mov X16, 1
	svc 0

cond2:
	mov x3, #2

	// Exit program
	mov X0, 0		// 0 status code
	mov X16, 1
	svc 0
