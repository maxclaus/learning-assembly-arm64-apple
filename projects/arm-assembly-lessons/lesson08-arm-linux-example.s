// Program based on this tutorial:
// https://www.youtube.com/watch?v=VeDPnWA_GVI
//
// On the NOTES.md file at the root of this repository
// there are more details about this lesson.

.global _start

_start:

	mov r0, #4
	mov r1, #5

	cmp r0, r1

	beq cond1   // if equal go to cond1
	b cond2     // else go to cond2

cond1:
	mov r2, #1

cond2:
	mov r3, #2
