
SECTION asm_lib
PUBLIC PAPER_B_INK_C

;EXTERN OURPIXADD

INCLUDE "../../z88dk-zxspectrum-equates.asm"

.PAPER_B_INK_C PUSH BC
			LD A,PAPER_CONTROL
			RST $10
			POP BC
			PUSH BC
			LD A,B					; Paper in B
			RST $10
			LD A,INK_CONTROL
			RST $10
			POP BC
			LD A,C					; Ink in C
			RST $10
			RET
