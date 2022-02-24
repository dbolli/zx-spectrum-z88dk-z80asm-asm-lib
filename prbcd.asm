
SECTION asm_lib
PUBLIC PRBCD1
PUBLIC PRBCD3

EXTERN PRASCII

;INCLUDE "../../z88dk-zxspectrum-equates.asm"

;/*
;
; . . . . . . . . . . .
; Print Routines
;
;*/

.PRBCD1		LD B,1
			JR PBCDLP1

.PRBCD3		LD B,3
.PBCDLP1		LD A,(DE)
			RRCA
			RRCA
			RRCA
			RRCA
			AND $0F
			ADD A,$30
			CALL PRASCII
			LD A,(DE)
			AND $0F					;// %00001111
			ADD A,$30
			CALL PRASCII
			INC DE
			DJNZ PBCDLP1
			RET
