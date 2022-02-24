
SECTION asm_lib
PUBLIC POINTSUB

EXTERN OURPIXADD

INCLUDE "../../z88dk-zxspectrum-equates.asm"

; . . . . . . . . . . .
;
; Carry flag set on return if pixel at C,B is set
;

.POINTSUB	LD (COORDS),BC
;			CALL PIXADD
			CALL OURPIXADD
			LD B,A
			INC B
			LD A,1
.POINTLOOP	RRCA
			DJNZ POINTLOOP
			LD B,A
			LD A,(HL)
			AND B
			JR Z,POINTRESET
			SCF
			RET
.POINTRESET	XOR A		; clear carry flag
			RET
