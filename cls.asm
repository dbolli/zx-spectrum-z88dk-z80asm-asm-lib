
SECTION asm_lib
PUBLIC CLS

EXTERN PAPERG
EXTERN INKN

INCLUDE "../../z88dk-zxspectrum-equates.asm"

.CLS		LD A,(PAPERG)
			OUT ($FE),A
			LD B,A
			RLC B
			RLC B
			RLC B
			LD A,(INKN)
			OR B
			LD HL,ATTRS
			PUSH HL
			POP DE
			INC DE
			LD BC,$02FF				; The length of the attribute file
			LD (HL),A
			LDIR
			LD HL,DFILE
			PUSH HL
			POP DE
			INC DE
			LD BC,$17FF				; The length of the display file
			LD (HL),0
			LDIR
			RET
