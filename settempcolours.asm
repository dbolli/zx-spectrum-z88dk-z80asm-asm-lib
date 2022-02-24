
SECTION asm_lib
PUBLIC SETTEMPCOLOURS

EXTERN PAPERG
EXTERN INKN

INCLUDE "../../z88dk-zxspectrum-equates.asm"

.SETTEMPCOLOURS							; Note: Don't call ROMCLS after using this, call CLS (below) instead
			RES 0,(IY+TVFLAGOFF)		; Flag upper part of screen
			LD A,KWRDPAPER-$C9			; PAPER control char
			RST PRINTA1
			LD A,(PAPERG)
			RST PRINTA1

			RES 0,(IY+TVFLAGOFF)		; Flag upper part of screen
			LD A,KWRDINK-$C9			; INK control char
			RST PRINTA1
			LD A,(INKN)
			RST PRINTA1

			LD HL,(ATTRT)				; Make temp attrs (semi) permanent
			LD (ATTRP),HL
			LD HL,PFLAG
			LD A,(HL)
			RLCA
			XOR (HL)
			AND $AA
			XOR (HL)
			LD (HL),A
			RET
