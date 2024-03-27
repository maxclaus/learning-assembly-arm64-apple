// Program adapted from linux arm to apple arm64
// based on "lesson09-arm-linux-example.s".

.global _start

_start:
	mov x0, #0

loop:
	cmp x0, #5      // compare x0 with 5
	bge end			// go to end if x0 >= 5
	add x0, x0, #1  // x0++
	b loop          // loop over to the next iteration

end:
	mov x1, #2

	// Exit program
	mov x0, 0		// 0 status code
	mov x16, 1
	svc 0
