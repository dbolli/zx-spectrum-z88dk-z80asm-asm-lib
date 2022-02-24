
SECTION asm_lib
PUBLIC SCROLLCLEFT
PUBLIC SCROLLCRIGHT

;EXTERN OURPIXADD

;INCLUDE "../../z88dk-zxspectrum-equates.asm"

.SCROLLCLEFT						; Left scroll by one character
			LD HL,$4000				; Start of display
			LD D,0
			LD A,192				; No. of lines
.SCRCLLP1	LD B,31					; 32 characters per line
.SCRCLLP2	INC HL					; Next byte
			LD E,(HL)					; into e
			DEC HL					; and back to
			LD (HL),E					; display
			INC HL					; Repeat for entire
			DJNZ SCRCLLP2				; line
			LD (HL),D					; Fill final byte
			INC HL					; Repeat for
			DEC A					; each line
			JR NZ,SCRCLLP1
			RET						; Return

.SCROLLCRIGHT						; Right scroll by one character
			LD HL,$57FF				; End of display
			LD D,0
			LD A,192					; No. of lines
.SCRCRLP1	LD B,31					; 32 characters per line
.SCRCRLP2	DEC HL					; Previous byte
			LD E,(HL)					; into e
			INC HL					; and back to
			LD (HL),E					; display
			DEC HL					; Repeat for entire
			DJNZ SCRCRLP2				; line
			LD (HL),D					; Fill final byte
			DEC HL					; Repeat for
			DEC A					; each line
			JR NZ,SCRCRLP1
			RET						; Return
