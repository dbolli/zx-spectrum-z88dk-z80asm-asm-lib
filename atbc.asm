
SECTION asm_lib
PUBLIC AT_B_C

;EXTERN OURPIXADD

INCLUDE "../../z88dk-zxspectrum-equates.asm"

.AT_B_C		PUSH BC
			LD A,AT_CONTROL
			RST $10
			POP BC
			PUSH BC
			LD A,B						; First AT co-ordinate.
			RST $10
			POP BC
			LD A,C							; Second AT co-ordinate.
			RST $10
			RET
