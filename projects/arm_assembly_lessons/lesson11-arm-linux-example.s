// Program based on this tutorial:
// https://www.youtube.com/watch?v=56VrSY-F7_o
//
// On the NOTES.md file at the root of this repository
// there are more details about this lesson.

.global _start

_start:
	push {lr} // push this value to the stack before we branch to another location

	mov r0, #1 // arg1
	mov r1, #2 // arg2
	mov r2, #3 // arg3
	mov r3, #3

	// Allocate some space on the stack.
	// sp = Stack pointer
	// We allocate 8-bytes on the stack because we intend to
	// store 2 integers on the stack, and each integer is 4-bytes long
	// on a ARM7 (32-bit).
	sub sp, sp, #8

	// Variables into the stack
	mov r4, #6
	str r4, [sp] // store r4 on the next location on the stack
	mov r4, #5
	str r4, [sp, #4] // offset by 4 to store r4 on the next location on the stack

	bl add_nums
	mov r2, r0   // save r0 to r2, so we don't lose once we restore the original r0 from stack

	add sp, sp, #8 // reset stack space

	pop {lr}	 // pop off lr with the value it was before going into add_numbs


add_nums:
	// sum up numbers from registers
	add r0, r0, r1
	add r0, r0, r2
	add r0, r0, r3

	// sum up numbers from stack
	ldr r4, [sp, #4] // use offset to get last arg
	add r0, r0, r4
	ldr r4, [sp] // no offset this time, gets the fist argument
	add r0, r0, r4

	bx lr
