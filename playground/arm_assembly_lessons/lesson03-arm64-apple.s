// Program adapted from linux arm to apple arm64
// based on "lesson03-arm-linux-example.s".
//
// Reason why we use ADRP+ADD instead of LDR
// https://github.com/below/HelloSilicon?tab=readme-ov-file#chapter-4-controlling-program-flow
//
// How ADRP and ADD work using PAGE and PAGEOFF:
// The ADRP instruction loads the address of the 4KB (4096 bytes) page anywhere
// in the +/-4GB (33 bits) range of the current instruction
// (which takes 21 high bits of the offset). This is denoted by the @PAGE operator.
// Then, we can either use LDR or STR to read or write any address inside that page
// or ADD to to calculate the final address using the remaining 12 bits of the
// offset (denoted by@PAGEOFF).
// https://reverseengineering.stackexchange.com/a/15324/46073

.global _start

_start:
	mov X0, 0
	mov X0, 0

	// In this first part we load data from memory.
	// -------------

	// Load var1 from the memory, and set its address to X0 register.
	adrp X0, var1@PAGE			// loads the address of var1 "relative to a page (4096 bytes)"
	add X0, X0, var1@PAGEOFF    // offset to var1 within the page

	// Get the value from the address memory stored on X0 register.
	// When using `ldr` with brackets loads the actual value
	// similar to dereferencing a pointer.
	// Load into w1 instead of x1, because we have used `.word` data size
	// for its value which is 32-bit size, so we need to use w register
	// which is also 32-bit size. Otherwise, if we used x register instead
	// it would load a 64-bit size data from memory, which would include
	// more data than expected, causing the value to be wrong.
	// https://stackoverflow.com/q/78212614/1050818
	ldr w1, [X0]

	// In this second part we update data from memory.
	// -------------

	// Set 3 to the X2 register.
	mov X2, 3

	// Load the memory address for the vaX2 data variable.
	adrp X3, var2@PAGE
	add X3, X3, var2@PAGEOFF

	// Store X2 register value to the memory address on the X3 register.
	str X2, [X3]

	// Exit program
	mov X0, 0		// 0 status code
	mov X16, 1
	svc 0

.data
var1: .word 5 // 32 bit size, its needs to be loaded into a w register instead of x register.
var2: .word 6
