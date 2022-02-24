
SECTION asm_lib
PUBLIC COLCHR08

EXTERN OURPIXADD
EXTERN GETATTR

defc COLCHR08_SUPPRESS	= 0

;INCLUDE "../../z88dk-zxspectrum-equates.asm"

.COLCHR08	CALL GETATTR
			PUSH HL
			LD A,(HL)
			LD (IX+17),A
if !COLCHR08_SUPPRESS					; :dbolli:20130928 11:21:44 Flag to suppress second attribute byte
			INC HL
			LD A,(HL)
			LD (IX+18),A
			DEC HL
endif		; !COLCHR08_SUPPRESS
			POP HL
;
			LD A,(IX+17)
			AND $F8
			OR (IX+16)
			LD (HL),A
if !COLCHR08_SUPPRESS					; :dbolli:20130928 11:21:44 Flag to suppress second attribute byte
			INC HL
			LD A,(IX+18)
			AND $F8
			OR (IX+16)
			LD (HL),A
			DEC HL
endif		; !COLCHR08_SUPPRESS
			RET
