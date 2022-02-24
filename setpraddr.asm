
SECTION asm_lib
PUBLIC SETPRADDR

;EXTERN OURPIXADD

INCLUDE "../../z88dk-zxspectrum-equates.asm"

.SETPRADDR	PUSH BC
			CALL CLADDR				; $0E9B Get Display file address in HL from row in B
			POP BC
			XOR A					; Clear carry flag
			LD D,$00
			LD E,C
			ADD HL,DE					; Add column C to display file address in HL
			JP POSTORE				; $0ADC Set the screen position system variables from BC and HL
