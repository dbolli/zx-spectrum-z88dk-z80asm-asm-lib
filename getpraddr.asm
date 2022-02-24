
SECTION asm_lib
PUBLIC GETPRADDR

;EXTERN OURPIXADD

;INCLUDE "../../z88dk-zxspectrum-equates.asm"

;/*
;
; Screen print coords in C,B on entry
; Address in HL on exit
;
;*/
.GETPRADDR	LD A,B
			RRCA
			RRCA
			RRCA
			AND $E0
			LD L,A
			LD A,B
			AND $18
			OR $40
			LD H,A
			LD D,0
			LD E,C
			ADD HL,DE
			RET
