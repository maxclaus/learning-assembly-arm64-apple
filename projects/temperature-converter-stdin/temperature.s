.text
.align 4
.global c_to_f
.global f_to_c

// arm64 doesn't seem to support immediate float values
// so all the floating arguments we use must come from a constant
f_32:	.single 32	// single precision float
f_1_8:	.single 1.8
f_5:	.single 5
f_9:	.single 9

// https://www.thoughtco.com/celcius-to-farenheit-formula-609227

// Converts the number on x0 from Celsius to Fahrenheit
// Arguments:
//   x0 temperature number in Celsius
// Returns:
//   x0 temperature number in Fahrenheit
c_to_f:
	stp x29, x30, [sp, #-16]!   // store frame pointer and  stack pointer on the stack

	scvtf s0, x0                // copy decimal register value to a float register
	ldr s1, f_1_8				// load float value
	ldr s2, f_32				// load float value

	// Celsius to Fahrenheit Formula: °F = (°C * 1.8) + 32
	fmul s0, s0, s1
	fadd s0, s0, s2

	fcvtzs x0, s0				// copy floag register value back to signed decimal register

	ldp x29, x30, [sp], #16     // pop fp and sp from stack (so they won't be globbered)
	ret


// Converts the number on x0 from Fahrenheit  to Celsius
// Arguments:
//   x0 temperature number in Fahrenheit
// Returns:
//   x0 temperature number in Celsius
f_to_c:
	stp x29, x30, [sp, #-16]!   // store frame pointer and  stack pointer on the stack

	scvtf s0, x0				// copy decimal register value to a float register
	ldr s1, f_32				// load float value
	ldr s2, f_5                 // load float value
	ldr s3, f_9                 // load float value
	fmov s4, wzr				// ensure s2 is zero
	fdiv s4, s2, s3				// resolve 5/9 fractional number
	// 0.55555555555556

	// Fahrenheit to Celsius Formula: °C = (°F - 32) * 5/9
	fsub s0, s0, s1
	fmul s0, s0, s4

	fcvtzs x0, s0				// copy floag register value back to signed decimal register

	ldp x29, x30, [sp], #16     // pop fp and sp from stack (so they won't be globbered)
	ret
