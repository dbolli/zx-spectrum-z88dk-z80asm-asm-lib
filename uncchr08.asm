
SECTION asm_lib
PUBLIC UNCCHR08

EXTERN GETATTR

;INCLUDE "../../z88dk-zxspectrum-equates.asm"

.UNCCHR08	CALL GETATTR
			LD A,(IX+17)
			LD (HL),A
			INC HL
			LD A,(IX+18)
			LD (HL),A
			RET
