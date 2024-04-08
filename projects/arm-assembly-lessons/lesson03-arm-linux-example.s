// Program based on this tutorial:
// https://www.youtube.com/watch?v=fJcdt7WMQCs
//
// On the NOTES.md file at the root of this repository
// there are more details about this lesson.
//
// This program can be tested on https://cpulator.01xz.net/ with ARMV7

.global _start

.text
_start:
	// In this first part we load data from memory.
	// -------------

	// Load var1 from the memory, and set its address to r0 register.
	ldr r0, =var1

	// Get the value from the address memory stored on r0 register.
	// When using `ldr` with brackets loads the actual value
	// similar to dereferencing a pointer.
	ldr r1, [r0]

	// In this second part we update data from memory.
	// -------------

	// Set 3 to the r2 register.
	mov r2, #3
	// Load the memory address for the var2 data variable.
	ldr r3, =var2
	// Store r2 register value to the memory address on the r3 register.
	str r2, [r3]

.data
var1: .word 5
var2: .word 6
