
SECTION asm_lib
PUBLIC GETATTR
PUBLIC GET2

EXTERN OURPIXADD

;INCLUDE "../../z88dk-zxspectrum-equates.asm"

.GETATTR 	LD B,(IX+1)				;// DB011202 11:27 
			LD C,(IX+0)				;// DB011202 11:27 
			DEC B					;// DB011202 11:27 This differs from library routine
			CALL OURPIXADD			;// Call ROM Pixel address routine
.GET2		LD A,H
			AND $F8					;// %11111000
			RRCA
			RRCA
			RRCA
			OR $58
			LD H,A
			RET
