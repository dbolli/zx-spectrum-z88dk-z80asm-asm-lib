
SECTION asm_lib
PUBLIC PRSTRNG
PUBLIC PRSTRNG2
PUBLIC PRSTRNG12
PUBLIC PRSTRNG3

EXTERN GET2
EXTERN PRASCII
EXTERN PRASCII2
EXTERN PRASCII12
EXTERN PRA12FLG

;INCLUDE "../../z88dk-zxspectrum-equates.asm"

;/*
;
; . . . . . . . . . . .
; Print Routines
;
;*/


;/*
;
; Prints a string at address (HL) from attr and
; ascii info at (DE)
;
;*/
.PRSTRNG	PUSH HL
			LD A,(DE)
			EX AF,AF
			INC DE
			EXX
			POP HL
			CALL GET2
.PSTRLP1	EXX
			LD A,(DE)
			BIT 7,A
			JR NZ, STREXIT
			CALL PRASCII
			INC DE
			EXX
			EX AF,AF
			LD (HL),A
			INC HL
			EX AF,AF
			JR PSTRLP1
.STREXIT	AND $7F					;// %01111111
			CALL PRASCII
			EXX
			EX AF,AF
			LD (HL),A
			RET
;/*
;
; Prints a double height string at address (HL) from attr and
; ascii info at (DE)
;
;*/
.PRSTRNG2	PUSH HL
			LD A,(DE)
			EX AF,AF
			INC DE
			EXX
			POP HL
			CALL GET2
.PSTR2LP1	EXX
			LD A,(DE)
			BIT 7,A
			JR NZ,STR2EXIT
			CALL PRASCII2
			INC DE
			EXX
			EX AF,AF
			LD (HL),A
			PUSH HL
			LD DE,$20
			ADD HL,DE
			LD (HL),A 
			POP HL
			INC HL
			EX AF,AF
			JR PSTR2LP1
.STR2EXIT	AND $7F					;// %01111111
			CALL PRASCII2
			EXX
			EX AF,AF
			LD (HL),A
			PUSH HL
			LD DE,$20
			ADD HL,DE
			LD (HL),A 
			POP HL
			RET
;/*
;
; Prints a half width string at address (HL) from attr and
; ascii info at (DE)
;
;*/
.PRSTRNG12 	PUSH HL
			XOR A
			LD (PRA12FLG),A
			LD A,(DE)
			EX AF,AF
			INC DE
			EXX
			POP HL
			CALL GET2
.PSTR12LP1		EXX
			LD A,(DE)
			BIT 7,A
			JR NZ,STR12EXIT
			CALL PRASCII12
			INC DE
			EXX
			EX AF,AF
			LD (HL),A
			PUSH AF
			LD A,(PRA12FLG)
			AND A
			JR NZ,PSTR12FNZ
			INC HL
.PSTR12FNZ		POP AF
			EX AF,AF
			JR PSTR12LP1
.STR12EXIT		AND $7F					;// %01111111
			CALL PRASCII12
			EXX
			EX AF,AF
			LD (HL),A
			RET

;/*
;
; Prints a string from ascii info at (HL)
;
;*/
.PRSTRNG3	LD A,(HL)
			AND A
			RET Z
;			CALL PRASCII
			PUSH HL
			RST $10
			POP HL
			INC HL
;			INC DE
			JR PRSTRNG3
