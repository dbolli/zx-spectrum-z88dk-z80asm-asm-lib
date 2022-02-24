
SECTION asm_lib
PUBLIC CLICK

EXTERN PAPERG

;INCLUDE "../../z88dk-zxspectrum-equates.asm"

; Sets the border to the same colour as the global
;   paper colour (PAPERG)

.CLICK		LD A,(PAPERG)
			OUT ($FE),A
			LD A,(PAPERG)
			OR $10
			OUT ($FE),A
			LD A,(PAPERG)
			OUT ($FE),A
			RET
