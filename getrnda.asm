
SECTION asm_lib
PUBLIC GETRNDA

;EXTERN OURPIXADD

INCLUDE "../../z88dk-zxspectrum-equates.asm"

; Return a random number in A between 0 and the number
; in A on entry

.GETRNDA		CALL	STACKA
			CALL	GETRND
			RST $28						; FPCALC
			defb	$04					; multiply
			defb	$38					; end-calc
			JP FPTOA

; . . . . . . . . . . .

.GETRND		LD BC,(SEED)
			CALL	STACKBC
			RST $28						; FPCALC
			defb	$A1					; stk-one
			defb	$0F					; addition
			defb	$34					; stk-data
			defb	$37
			defb	$16
			defb	$04
			defb	$34					; stk-data
			defb	$80
			defb	$41
			defb	$00,$00,$80
			defb	$32					; n-mod-m
			defb	$02					; delete
			defb	$A1					; stk-one
			defb	$03					; subtract
			defb	$31					; duplicate

			defb	$38					; end-calc

			CALL	FPTOBC
			LD (SEED),BC
			LD A,(HL)
			AND A
			JR Z,GRNDEND
			SUB $10
			LD (HL),A
.GRNDEND		RET
