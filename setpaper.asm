
SECTION asm_lib
PUBLIC SETPAPER

EXTERN PAPERG

INCLUDE "../../z88dk-zxspectrum-equates.asm"

.SETPAPER	LD (PAPERG),A
			RLCA
			RLCA
			RLCA
			LD B,A
			LD A,(ATTRP)
			AND %11000111				; $C7 Mask out PAPER bits
			OR B
			LD (ATTRP),A

			RET