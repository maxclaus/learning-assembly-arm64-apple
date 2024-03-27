// Program based on this tutorial:
// https://www.youtube.com/watch?v=rg3aBTjsUms
//
// On the NOTES.md file at the root of this repository
// there are more details about this lesson.

.global _start

_start:
	mov r0, #0

loop:
	cmp r0, #5      // compare r0 with 5
	bge end			// go to end if r0 >= 5
	add r0, #1      // r0++
	b loop          // loop over to the next iteration

end:
	mov r1, #2
