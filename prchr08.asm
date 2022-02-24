
SECTION asm_lib
PUBLIC PRCHR08
PUBLIC INCY8

EXTERN OURPIXADD

;INCLUDE "../../z88dk-zxspectrum-equates.asm"

.PRCHR08	PUSH IX						; :dbolli:20121102 22:11:45 Added
			LD B,(IX+1)
			LD C,(IX+0)
			LD H,(IX+5)
			LD L,(IX+4)
			PUSH HL
			POP IX
			CALL OURPIXADD				; :dbolli:20211122 14:41:16 Changed from PIXADD
			PUSH AF
			LD D,8
			AND A
			JR Z,WBOUND8
.LINE8		POP AF
			PUSH AF
			LD B,A
			LD A,(IX+0)
			LD E,0
.SCROLL8	SRL A
			RR E
			DJNZ SCROLL8
			XOR (HL)
			LD (HL),A
			INC HL
			LD A,E
.TWO8		XOR (HL)
			LD (HL),A
			DEC HL
			INC IX
			CALL INCY8
			DEC D
			JR NZ,LINE8
			POP AF
			POP IX
			RET
.WBOUND8	LD B,D
.XBOUND8	LD A,(IX+0)
			XOR (HL)
			LD (HL),A
			CALL INCY8
			INC IX
			DJNZ XBOUND8
			POP AF
			POP IX
			RET
;
.INCY8		INC H
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
