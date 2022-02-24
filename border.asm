
SECTION asm_lib
PUBLIC BORDER

EXTERN PAPERG

INCLUDE "../../z88dk-zxspectrum-equates.asm"

; Sets the border to the same colour as the global
;   paper colour (PAPERG)

.BORDER		PUSH BC
			LD A,(BORDCR)
			AND $C7					; %11000111 Clear Paper colour
			LD B,A
			LD A,(PAPERG)
			RLCA
			RLCA
			RLCA
			OR B						; Set global paper colour
			LD (BORDCR),A
			POP BC
			RET
