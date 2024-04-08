; https://developer.arm.com/documentation/107829/0200/Calling-an-assembly-function-from-C-code?lang=en
; There were some changes required from that example though.
; For instance ".type" directive isn't supported on Mach-O assembler
; https://stackoverflow.com/a/20908242/1050818
.global    _asm_sum
.align  2

_asm_sum:
	add        x0, x0, x1
	ret
