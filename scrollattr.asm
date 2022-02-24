
SECTION asm_lib
PUBLIC SCROLLALEFT
PUBLIC SCROLLARIGHT
PUBLIC SCROLLAUP
PUBLIC SCROLLADOWN

EXTERN SCRLNEWATTR

INCLUDE "../../z88dk-zxspectrum-equates.asm"

.SCROLLALEFT	LD HL,ATTRS				; From 40 Best Machine Code Routines 5: Scroll Routines Scroll Attributes Left
			LD A,(SCRLNEWATTR)
			LD C,24
.NXTLNLP1		LD B,31
.NXTCHRLP2		INC HL
			LD E,(HL)
			DEC HL
			LD (HL),E
			INC HL
			DJNZ NXTCHRLP2
			LD (HL),A
			INC HL
			DEC C
			JR NZ,NXTLNLP1
			RET

.SCROLLARIGHT	LD HL,$5AFF				; From 40 Best Machine Code Routines 5: Scroll Routines Scroll Attributes Right
			LD A,(SCRLNEWATTR)
			LD C,24
.NXTLNLP3		LD B,31
.NXTCHRLP4		DEC HL
			LD E,(HL)
			INC HL
			LD (HL),E
			DEC HL
			DJNZ NXTCHRLP4
			LD (HL),A
			DEC HL
			DEC C
			JR NZ,NXTLNLP3
			RET

.SCROLLAUP		LD HL,ATTRS + $20			; From 40 Best Machine Code Routines 5: Scroll Routines Scroll Attributes Up
			LD DE,ATTRS
			LD BC,$2E0
			LDIR
			LD A,(SCRLNEWATTR)
			LD B,32
.NXTCHRLP5		LD (DE),A
			INC DE
			DJNZ NXTCHRLP5
			RET

.SCROLLADOWN	LD HL,$5ADF				; From 40 Best Machine Code Routines 5: Scroll Routines Scroll Attributes DOWN
			LD DE,$5AFF
			LD BC,$2E0
			LDDR
			LD A,(SCRLNEWATTR)
			LD B,32
.NXTCHRLP6		LD (DE),A
			DEC DE
			DJNZ NXTCHRLP6
			RET
