// Program adapted from linux arm to apple arm64
// based on "lesson05-arm-linux-example.s".

.global _start

_start:
	mov X0, #25
	mov X1, #-25

	mov X2, #16
	mov X3, #-16

	// Exit program
	mov X0, 0		// 0 status code
	mov X16, 1
	svc 0
