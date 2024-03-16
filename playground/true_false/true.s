.global _start /* defines where the program starts */
.align 4 /* uses alignment for 64 bits */

; https://www.youtube.com/watch?v=clyO5z_klrk
_start:
  mov x0, #0 /* puts 0 into the 0 register */
  mov x16, #1 /* puts 1 into the 16 register */
  svc #0x80 /* syscall */
