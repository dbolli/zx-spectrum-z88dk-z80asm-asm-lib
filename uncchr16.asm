
SECTION asm_lib
PUBLIC UNCCHR16

EXTERN GETATTR

;INCLUDE "../../z88dk-zxspectrum-equates.asm"

.UNCCHR16	CALL GETATTR
			LD A,(IX+17)
			LD (HL),A
			INC HL
			LD A,(IX+18)
			LD (HL),A
			INC HL						; :dbolli:20121020 12:02:22 Added
			LD A,(IX+19)				; :dbolli:20121020 12:02:22 Added
			LD (HL),A					; :dbolli:20121020 12:02:22 Added
			DEC HL
			DEC HL						; :dbolli:20121020 12:02:22 Added for third attribute byte
			LD DE,$20
			ADD HL,DE
			LD A,(IX+20)				; :dbolli:20121020 12:02:22 Changed from (IX+19)
			LD (HL),A
			INC HL
			LD A,(IX+21)				; :dbolli:20121020 12:02:22 Changed from (IX+20)
			LD (HL),A
			INC HL						; :dbolli:20121020 12:02:22 Added
			LD A,(IX+22)				; :dbolli:20121020 12:02:22 Added
			LD (HL),A					; :dbolli:20121020 12:02:22 Added
			RET

