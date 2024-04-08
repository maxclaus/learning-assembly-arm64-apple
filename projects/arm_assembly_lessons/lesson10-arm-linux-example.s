// Program based on this tutorial:
// https://www.youtube.com/watch?v=pnnOL7kfkz0
//
// On the NOTES.md file at the root of this repository
// there are more details about this lesson.

.global _start

_start:
	mov r0, #1 // arg1
	mov r1, #2 // arg2

	push {r0, r1} // push these values to the stack before we branch to another location

	bl add_nums
	mov r2, r0   // save r0 to r2, so we don't lose once we restore the original r0 from stack

	pop {r0, r1} // pop off r0, r1 with the values they were before going into add_numbs


add_nums:
	add r0, r0, r1
	bx lr
