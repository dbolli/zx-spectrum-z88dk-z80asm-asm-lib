
SECTION asm_lib
PUBLIC PRCHR16
PUBLIC INCY

EXTERN OURPIXADD

;INCLUDE "../../z88dk-zxspectrum-equates.asm"

.PRCHR16	PUSH IX						; Original from Eg*Bert that XORs onto screen
			LD B,(IX+1)
			LD C,(IX+0)
			LD H,(IX+5)
			LD L,(IX+4)
			PUSH HL
			POP IX
			CALL OURPIXADD
			PUSH AF
			LD D,16
			AND A
			JR Z,WBOUND
.LINE		POP AF
			PUSH AF
			LD B,A
			LD A,(IX+0)
			LD C,(IX+1)
			LD E,0
.SCROLL		SRL A
			RR C
			RR E
			DJNZ SCROLL
			XOR (HL)
			LD (HL),A
			INC HL
			LD A,C
.ONE		XOR (HL)
			LD (HL),A
			INC HL
			LD A,E
.TWO		XOR (HL)
			LD (HL),A
			DEC HL
			DEC HL
			INC IX
			INC IX
			CALL INCY
			DEC D
			JR NZ,LINE
			POP AF
			POP IX
			RET
.WBOUND		LD B,D
.XBOUND		LD A,(IX+0)
			XOR (HL)
			LD (HL),A
			INC HL
			LD A,(IX+1)
			XOR (HL)
			LD (HL),A
			DEC HL
			CALL INCY
			INC IX
			INC IX
			DJNZ XBOUND
			POP AF
			POP IX
			RET
;
.INCY		INC H
			LD A,H
			AND 7
			RET NZ
			LD A,H
			SUB 8
			LD H,A
			LD A,L
			ADD A,32
			LD L,A
			RET NC
			LD A,H
			ADD A,8
			LD H,A
			XOR 88
			RET NZ
			LD H,$40
			RET
