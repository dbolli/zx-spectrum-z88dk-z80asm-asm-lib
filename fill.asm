
SECTION asm_lib
PUBLIC FILL

;EXTERN PAPERG

INCLUDE "../../z88dk-zxspectrum-equates.asm"

;
; . . . . . . . . . . .
;
FILL:		LD (COORDS),BC
			LD A,C
			CALL STACKA
			LD A,B
			CALL STACKA
			CALL POINT_
			CALL FPTOA
;			CALL PRINTREG
			AND A
			RET NZ
;			Return if inital fill coord set
			LD BC,(COORDS)
			CALL PIXADD
FMLP1:		LD (FSTRTADDR),HL
;			Save fill start address
			LD A,(HL)
;			CALL PRINTREG
			AND A
			JR Z,FLDLF
;			Start filling left if initial byte blank
			LD (FSBYTE),A
			LD D,$FF
			LD E,0
			AND A
FCMLP1:		RLA
			JR C,FCMDL
			RL D
			RR E
			JR FCMLP1
FCMDL:		LD A,E
			LD (FMASKL),A
;
			LD A,(FSBYTE)
			LD D,$FF
			LD E,0
			AND A
FCMRP1:		RRA
			JR C,FCMDR
			RR D
			RL E
			JR FCMRP1
FCMDR:		LD A,E
			LD (FMASKR),A
;
			LD A,(FMASKL)
			OR E
			CPL
			PUSH AF
			PUSH HL
			LD A,(COORDS+1)
			AND $07
			LD H,0
			LD L,A
			LD DE,(CURRFILLP)
			ADD HL,DE
;			Get offset to pattern byte
			LD A,(HL)
			LD B,A
			POP HL
			POP AF
			AND B
;			AND (CURRFILLP+B MOD 8)
			OR (HL)
			LD (HL),A
			JP DONEFILL
;
FLDLF:		PUSH HL
			LD A,(COORDS+1)
			AND $07
			LD H,0
			LD L,A
			LD DE,(CURRFILLP)
			ADD HL,DE
;			Get offset to pattern byte
			LD A,(HL)
			POP HL
			LD (HL),A
			DEC HL
FLLP1:		LD A,(HL)
			AND A
			JR NZ,DONELFILL
			PUSH HL
			LD A,(COORDS+1)
			AND $07
			LD H,0
			LD L,A
			LD DE,(CURRFILLP)
			ADD HL,DE
;			Get offset to pattern byte
			LD A,(HL)
			POP HL
			LD (HL),A
			DEC HL
			JR FLLP1
DONELFILL:		LD (FLBNDRY),HL
			LD D,$FF
			LD E,0
			AND A
FCMLP2:		RLA
			JR C,FCM2DL
			RL D
			RR E
			JR FCMLP2
FCM2DL:		LD A,E
			CPL
			PUSH AF
			PUSH HL
			LD A,(COORDS+1)
			AND $07
			LD H,0
			LD L,A
			LD DE,(CURRFILLP)
			ADD HL,DE
;			Get offset to pattern byte
			LD A,(HL)
			LD B,A
			POP HL
			POP AF
			AND B
;			AND (CURRFILLP+B MOD 8)
			OR (HL)
			LD (HL),A
;
			LD HL,(FSTRTADDR)
;			Get the fill start addr back
			INC HL
FLLP2:		LD A,(HL)
			AND A
			JR NZ,DONERFILL
			PUSH HL
			LD A,(COORDS+1)
			AND $07
			LD H,0
			LD L,A
			LD DE,(CURRFILLP)
			ADD HL,DE
;			Get offset to pattern byte
			LD A,(HL)
			POP HL
			LD (HL),A
			INC HL
			JR FLLP2
DONERFILL:		LD (FRBNDRY),HL
			LD D,$FF
			LD E,0
			AND A
FCMRP2:		RRA
			JR C,FCM2DR
			RR D
			RL E
			JR FCMRP2
FCM2DR:		LD A,E
			CPL
			PUSH AF
			PUSH HL
			LD A,(COORDS+1)
			AND $07
			LD H,0
			LD L,A
			LD DE,(CURRFILLP)
			ADD HL,DE
;			Get offset to pattern byte
			LD A,(HL)
			LD B,A
			POP HL
			POP AF
			AND B
;			AND (CURRFILLP+B MOD 8)
			OR (HL)
			LD (HL),A
;
;			LD HL,(FRBNDRY)
;			LD DE,(FLBNDRY)
;			AND A
;			SBC HL,DE
;			AND A
;			RR H
;			RR L
;			LD DE,(FLBNDRY)
;			ADD HL,DE
;
			LD BC,(COORDS)
			DEC B
			JP FILL
;
DONEFILL:		RET

SECTION asm_lib_data
PUBLIC CURRFILLP
PUBLIC FILLX
PUBLIC FILLY

PUBLIC FILL1
PUBLIC FILL2
PUBLIC FILL3
PUBLIC FILL4
PUBLIC FILL5

CURRFILLP:		defw 0			;			The address of the current fill pattern

FILLX:		defb 0
FILLY:		defb 0
FILLCOL:		defb 0

;
FSTRTADDR:		defw 0
FSBYTE:		defb 0
;			Screen byte of last fill thing
FMASKL:		defb 0
FMASKR:		defb 0
;			Mask bytes for limits of fill region
FLBNDRY:		defw 0
FRBNDRY:		defw 0

;
;			Fill Patterns
;
FILL1:		defb $AA
			defb $55
			defb $AA
			defb $55
			defb $AA
			defb $55
			defb $AA
			defb $55
;
FILL2:		defb $92
			defb $24
			defb $49
			defb $92
			defb $24
			defb $49
			defb $92
			defb $24
;
FILL3:		defb $00
			defb $00
			defb $00
			defb $01
			defb $00
			defb $00
			defb $00
			defb $10
;
FILL4:		defb $80
			defb $40
			defb $20
			defb $10
			defb $08
			defb $04
			defb $02
			defb $01
;
FILL5:		defb $FF
			defb $FF
			defb $FF
			defb $FE
			defb $FF
			defb $FF
			defb $FF
			defb $EF
;
FTEST:		defb $FF
			defb $80
			defb $80
			defb $80
			defb $80
			defb $80
			defb $80
			defb $FF
;
FTEST2:		defb $00
			defb $00
			defb $00
			defb $FF
			defb $00
			defb $00
			defb $00
			defb $FF
;
FTEST3:		defb $FF
			defb $FF
			defb $FF
			defb $FF
			defb $FF
			defb $FF
			defb $FF
			defb $FF
;
FTEST4:		defb $FF
			defb $FF
			defb $FF
			defb $EE
			defb $FF
			defb $FF
			defb $FF
			defb $EE
