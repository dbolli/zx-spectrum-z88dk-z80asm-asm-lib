
SECTION asm_lib
PUBLIC INVERSE

;EXTERN OURPIXADD

INCLUDE "../../z88dk-zxspectrum-equates.asm"

.INVERSE		PUSH AF
			LD A,INVERSE_CONTROL
			RST $10
			POP AF					; Inverse flag in A
			RST $10
			RET						; Bit 2 of PFLAG System Var should now reflect INVERSE Status
