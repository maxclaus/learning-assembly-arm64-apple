// This program is based on this tutorial ARM64 for Linux:
// https://www.youtube.com/watch?v=uB02Mr9tS7Q
// The source code can be found at:
// https://github.com/rdoetjes/tuts/blob/main/asm/arm64_linux/decimal/decimal.s
// NOTE: 3 important changes were made based on the original source code to work on Apple arm64:
// - Replaced `ldr` with `adrp+add` instructions to load data
// - On input.s it was required to push the string address (x1)
//   to the stack, because x1 gets overriden by the read syscall.
// - Not a Apple arm64 issue, but I also needed to drop `.include`
//   directives and link objects instead. It was done because that
//   directive doesn't seem to work well with lldb debugging
//   https://stackoverflow.com/q/78328949/1050818

.text
.align 4
.global _start

_start:
	adrp x1, input@PAGE
	add x1, x1, input@PAGEOFF
	ldr x2, =input_len
	bl inputSTDIN

	mov x2, x0
	bl atoi
	bl printUInt

	mov x0, #0
	bl exit

.data
input:	.fill 20,1,0
input_len = . - input
