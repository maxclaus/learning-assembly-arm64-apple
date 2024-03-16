
; https://developer.arm.com/documentation/107829/0200/Example--decrement-until-equal?lang=en
; There were some changes required from that example though.
; For instance ".type" directive isn't supported on Mach-O assembler
; https://stackoverflow.com/a/20908242/1050818

; Define a function entry point. The indented code is part of the function.
.global    _asm_dec_until_eql

.align  2

; decrement until equal
; check out the article linked at the top for the explanation about each instruction.
_asm_dec_until_eql:
	sub x1, x1, #1
	sub x2, x0, x1
	cmp x2, #0
	b.ne _asm_dec_until_eql
	ret
