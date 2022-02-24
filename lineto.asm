
SECTION asm_lib
PUBLIC LINETO

;EXTERN OURPIXADD

INCLUDE "../../z88dk-zxspectrum-equates.asm"

; Destination Coords in BC on entry

.LINETO		PUSH	BC
			LD A,(COORDS)
			LD E,A
			LD A,C
			SUB E
			JR NC,LTXPOS
			LD E,A
			LD A,0
			SUB E
			CALL	STACKA
			RST $28
			defb	$1B					; negate
			defb	$38
			JR LTDOY
.LTXPOS		CALL	STACKA
.LTDOY		POP BC
			LD A,(COORDS+1)
			LD E,A
			LD A,B
			SUB E
			JR NC,LTYPOS
			LD E,A
			LD A,0
			SUB E
			CALL	STACKA
			RST $28
			defb	$1B					; negate
			defb	$38
			JR LTDRLN
.LTYPOS		CALL	STACKA
.LTDRLN		CALL	DRAWLINE
			RET
