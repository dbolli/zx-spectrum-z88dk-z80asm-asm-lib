
SECTION asm_lib
PUBLIC DRAWLN2

EXTERN OURPIXADD
EXTERN PLOTSUB

INCLUDE "../../z88dk-zxspectrum-equates.asm"

; Draws a line from COORDS,(COORDS+1) to COORDS+X,(COORDS+1)+Y
; On entry B contains ABS Y, C contains ABS X
;	D contains SGN Y, E contains SGN X 

; This is straight from the ROM routine at $24B7...

.DRAWLN2		LD A,C
			CP B
			JR NC,DLXGEY
			LD L,C
			PUSH DE
			XOR A
			LD E,A
			JR DLLARGER
.DLXGEY		OR C
			RET Z
			LD L,B
			LD B,C
			PUSH DE
			LD D,0
.DLLARGER		LD H,B
			LD A,B
			RRA
.DLLOOP		ADD A,L
			JR C,DLDIAG
			CP H
			JR C,DLHRVT
.DLDIAG		SUB H
			LD C,A
			EXX
			POP BC
			PUSH BC
			JR DLSTEP
.DLHRVT		LD C,A
			PUSH DE
			EXX
			POP BC
.DLSTEP		LD HL,(COORDS)
			LD A,B
			ADD A,H
			LD B,A
			LD A,C
			INC A
			ADD A,L
			JR C,DLRANGE
			RET Z
.DLPLOT		DEC A
			LD C,A
			CALL PLOTSUB
			EXX
			LD A,C
			DJNZ DLLOOP
			POP DE
			RET

.DLRANGE		JR Z,DLPLOT
