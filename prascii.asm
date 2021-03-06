
SECTION asm_lib
PUBLIC PRASCII
PUBLIC PRASCII2
PUBLIC PRASCII12
PUBLIC PRA12FLG

;EXTERN GET2

INCLUDE "../../z88dk-zxspectrum-equates.asm"

;/*
;
; . . . . . . . . . . .
; Print Routines
;
;*/

.PRASCII	PUSH BC
			PUSH DE
			PUSH HL
			LD L,A
			LD H,0
			ADD HL,HL
			ADD HL,HL
			ADD HL,HL
			LD DE,(CHARS)
			ADD HL,DE
			EX DE,HL
			POP HL
			LD B,8
.PASCLP1	LD A,(DE)
			LD (HL),A
			INC DE
			INC H
			DJNZ PASCLP1
			POP DE
			POP BC
			LD A,H
			SUB 8
			LD H,A
			INC L
			RET
;
.PRASCII2	PUSH BC					;// DB011202 11:17 Double height printing
			PUSH DE
			PUSH HL
			LD L,A
			LD H,0
			ADD HL,HL
			ADD HL,HL
			ADD HL,HL
			LD DE,(CHARS)
			ADD HL,DE
			EX DE,HL
			POP HL
			LD B,4
.PASC2LP1	LD A,(DE)
			LD (HL),A
			INC DE
			INC H
			LD (HL),A
			INC H
			DJNZ PASC2LP1
			LD A,H
			SUB 8
			LD H,A
			PUSH HL
			LD BC,$20
			ADD HL,BC
			LD B,4
.PASC2LP2	LD A,(DE)
			LD (HL),A
			INC DE
			INC H
			LD (HL),A
			INC H
			DJNZ PASC2LP2
			POP HL
			INC L
			POP DE
			POP BC
			RET

.PRASCII12	PUSH BC					;// DB011202 11:19 Half width printing
			PUSH DE
			PUSH HL
			LD L,A
			LD H,0
			ADD HL,HL
			ADD HL,HL
			ADD HL,HL
			LD DE,(CHARS)
			ADD HL,DE
			EX DE,HL
			POP HL
			LD A,(PRA12FLG)
			AND A
			JR Z,PASC12FNZ
			DEC HL
.PASC12FNZ		LD B,8
.PASC12LP1		LD A,(DE)
			PUSH BC
			PUSH DE
			LD D,$00
			LD E,$00
			LD B,4
.PASC12LP2		RLCA
			RL D
			RLCA
			RL E
			DJNZ PASC12LP2
			LD A,(PRA12FLG)
			AND A
			JR NZ,PASC12FNZ1
			PUSH BC
			LD B,4
.PASC12LP3		RLC E
			RLC D
			DJNZ PASC12LP3
			POP BC
.PASC12FNZ1	LD A,E
			OR D
			POP DE
			POP BC
			OR (HL)
			LD (HL),A
			INC DE
			INC H
			DJNZ PASC12LP1
			POP DE
			POP BC
			LD A,H
			SUB 8
			LD H,A
			INC L
			LD A,(PRA12FLG)
			CPL
			LD (PRA12FLG),A			;// Invert the flag
			RET

SECTION asm_lib_data

.PRA12FLG	defb 0
