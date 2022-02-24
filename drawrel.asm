
SECTION asm_lib
PUBLIC DRAWREL

;EXTERN OURPIXADD

INCLUDE "../../z88dk-zxspectrum-equates.asm"

.DRAWREL	PUSH BC					; B = ABS X Offset C = ABS Y Offset E = SGN X Offset D = SGN Y Offset
			PUSH DE
			LD A,C					; ABS X Offset
			CALL STACKA
			POP DE
			PUSH DE
			LD A,E					;  E = SGN X Offset
			CP $7F
			JR C,DRDOY
			RST $28					; FPCALC
			defb $1B				; negate
			defb $38				; end-calc
.DRDOY		POP DE
			POP BC
			PUSH DE
			LD A,B					; ABS Y Offset
			CALL STACKA
			POP DE
			LD A,D					;  D = SGN Y Offset
			CP $7F
			JR C,DRDODL
			RST $28					; FPCALC
			defb $1B				; negate
			defb $38				; end-calc
.DRDODL
;			CALL OURDRAWLN2
			JP DRAWLINE
