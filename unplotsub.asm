
SECTION asm_lib
PUBLIC UNPLOTSUB

EXTERN OURPIXADD

INCLUDE "../../z88dk-zxspectrum-equates.asm"

.UNPLOTSUB		LD (COORDS),BC
			CALL OURPIXADD
			LD B,A
			INC B
			LD A,1
.UNPLOTLOOP	RRCA
			DJNZ UNPLOTLOOP
			LD B,A
			LD A,(HL)
			XOR B
			LD (HL),A
			RET
