
SECTION asm_lib
PUBLIC DELAY1SEC
PUBLIC DELAY05SEC
PUBLIC DELAY025SEC
PUBLIC DELAY0125SEC
PUBLIC DELAY00625SEC		; :dbolli:20220126 22:51:42 Added
PUBLIC DELAYFORDUR

;EXTERN PAPERG

;INCLUDE "../../z88dk-zxspectrum-equates.asm"

.DELAY1SEC					; Delay for 1 sec
			PUSH HL
			PUSH BC
			LD HL,$0415	; 1.0 sec
			CALL DELAYFORDUR
			POP BC
			POP HL
			RET
;
.DELAY05SEC					; Delay for 0.5 sec
			PUSH HL
			PUSH BC
			LD HL,$0415 / 2	; 0.5 sec
			CALL DELAYFORDUR
			POP BC
			POP HL
			RET
;
.DELAY025SEC					; Delay for 0.25 sec
			PUSH HL
			PUSH BC
			LD HL,$0415 / 4	; 0.25 sec
			CALL DELAYFORDUR
			POP BC
			POP HL
			RET
;
.DELAY0125SEC					; Delay for 0.125 sec
			PUSH HL
			PUSH BC
			LD HL,$0415 / 8	; 0.125 sec
			CALL DELAYFORDUR
			POP BC
			POP HL
			RET
;
.DELAY00625SEC					; Delay for 0.0625 sec	; :dbolli:20220126 22:51:42 Added
			PUSH HL
			PUSH BC
			LD HL,$0415 / 16	; 0.0625 sec
			CALL DELAYFORDUR
			POP BC
			POP HL
			RET
;
.DELAYFORDUR					; HL = duration. Based on ROM routine at $0571
			LD B,0
.DELDRSCLP1	DJNZ DELDRSCLP1	; loop for 255 iterations
			DEC HL
			LD A,H
			OR L
			JR NZ,DELDRSCLP1	; back to LD-WAIT, if not zero, with zero in B.
			RET
