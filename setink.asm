
SECTION asm_lib
PUBLIC SETINK

EXTERN INKN

INCLUDE "../../z88dk-zxspectrum-equates.asm"

.SETINK		AND %000000111				; $07 Mask out INK only
			LD (INKN),A
			LD B,A
			LD A,(ATTRP)
			AND %11111000				; $F8 Mask out INK bits
			OR B
			LD (ATTRP),A

			RET