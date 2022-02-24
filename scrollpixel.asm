
SECTION asm_lib
PUBLIC SCROLLPLEFT
PUBLIC SCROLLPRIGHT

;EXTERN OURPIXADD

;INCLUDE "../../z88dk-zxspectrum-equates.asm"

.SCROLLPLEFT							; Left scroll by one pixel
			LD HL,$57FF				; End of display
			LD C,192					; No of lines
.SCRPLLP1		LD B,32					; 32 characters per line
			OR A						; Clear carry
.SCRPLLP2		RL (HL)					; Rotate left
			DEC HL					; Previous byte
			DJNZ SCRPLLP2				; Next byte
			DEC C
			JR NZ,SCRPLLP1			; Next line
			RET 						; Return

.SCROLLPRIGHT						; Right scroll by one pixel
			LD HL,$4000				; Start of display
			LD C,192					; No of lines
.SCRPRLP1		LD B,32					; 32 characters per line
			OR A						; Clear carry
.SCRPRLP2		RR (HL)					; Rotate right
			INC HL					; Next byte
			DJNZ SCRPRLP2				; Next byte
			DEC C
			JR NZ,SCRPRLP1			; Next line
			RET 						; Return
