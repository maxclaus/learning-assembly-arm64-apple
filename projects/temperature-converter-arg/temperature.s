.text
.align 4
.global c_to_f
.global f_to_c

base_temp_div: .single 1.8
base_temp_diff: .single 32

// https://www.thoughtco.com/celcius-to-farenheit-formula-609227

// Converts the number on x0 from Celsius to Fahrenheit
// Arguments:
//   x0 temperature number in Celsius
// Returns:
//   x0 temperature number in Fahrenheit
c_to_f:
	stp x29, x30, [sp, #-16]!   // store frame pointer and  stack pointer on the stack

	scvtf s0, x0
	ldr s1, base_temp_div
	ldr s2, base_temp_diff

	// Celsius to Fahrenheit Formula: (°C * 1.8) + 32 = °F
	fmul s0, s0, s1
	fadd s0, s0, s2

	fcvtzs x0, s0

	ldp x29, x30, [sp], #16     // pop fp and sp from stack (so they won't be globbered)
	ret


// Converts the number on x0 from Fahrenheit  to Celsius
// Arguments:
//   x0 temperature number in Fahrenheit
// Returns:
//   x0 temperature number in Celsius
f_to_c:
	stp x29, x30, [sp, #-16]!   // store frame pointer and  stack pointer on the stack

	scvtf s0, x0
	ldr s1, base_temp_div
	ldr s2, base_temp_diff

	// Fahrenheit to Celsius Formula: (°F - 32) / 1.8 = °C
	fsub s0, s0, s2
	fdiv s0, s0, s1

	fcvtzs x0, s0

	ldp x29, x30, [sp], #16     // pop fp and sp from stack (so they won't be globbered)
	ret
