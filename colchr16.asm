
SECTION asm_lib
PUBLIC COLCHR16

EXTERN OURPIXADD
EXTERN GETATTR

defc COLCHR16_SUPPRESS	= 0

;INCLUDE "../../z88dk-zxspectrum-equates.asm"

.COLCHR16	CALL GETATTR
			PUSH HL
			LD A,(HL)
			LD (IX+17),A
			INC HL
			LD A,(HL)
			LD (IX+18),A
			INC HL						; :dbolli:20121020 12:02:22 Added
			LD A,(HL)					; :dbolli:20121020 12:02:22 Added
			LD (IX+19),A				; :dbolli:20121020 12:02:22 Added
			DEC HL
			DEC HL						; :dbolli:20121020 12:02:22 Added for third attribute byte
			LD DE,$20
			ADD HL,DE
			LD A,(HL)
			LD (IX+20),A				; :dbolli:20121020 12:02:22 Changed from (IX+19)
			INC HL
			LD A,(HL)
			LD (IX+21),A				; :dbolli:20121020 12:02:22 Changed from (IX+20)
if !COLCHR16_SUPPRESS					; :dbolli:20130928 11:21:44 Flag to suppress third attribute byte
			INC HL						; :dbolli:20121020 12:02:22 Added
			LD A,(HL)					; :dbolli:20121020 12:02:22 Added
			LD (IX+22),A				; :dbolli:20121020 12:02:22 Added
endif		; !COLCHR16_SUPPRESS
			POP HL
;
			LD A,(IX+17)
			AND $F8
			OR (IX+16)
			LD (HL),A
			INC HL
			LD A,(IX+18)
			AND $F8
			OR (IX+16)
			LD (HL),A
if !COLCHR16_SUPPRESS					; :dbolli:20130928 11:21:44 Flag to suppress third attribute byte
			INC HL						; :dbolli:20121020 12:02:22 Added
			LD A,(IX+19)				; :dbolli:20121020 12:02:22 Added
			AND $F8						; :dbolli:20121020 12:02:22 Added
			OR (IX+16)					; :dbolli:20121020 12:02:22 Added
			LD (HL),A					; :dbolli:20121020 12:02:22 Added
			DEC HL
endif		; !COLCHR16_SUPPRESS
			DEC HL						; :dbolli:20121020 12:02:22 Added for third attribute byte
			LD DE,$20
			ADD HL,DE
			LD A,(IX+20)				; :dbolli:20121020 12:02:22 Changed from (IX+19)
			AND $F8
			OR (IX+16)
			LD (HL),A
			INC HL
			LD A,(IX+21)				; :dbolli:20121020 12:02:22 Changed from (IX+20)
			AND $F8
			OR (IX+16)
			LD (HL),A
if !COLCHR16_SUPPRESS					; :dbolli:20130928 11:21:44 Flag to suppress third attribute byte
			INC HL						; :dbolli:20121020 12:02:22 Added
			LD A,(IX+22)				; :dbolli:20121020 12:02:22 Added
			AND $F8						; :dbolli:20121020 12:02:22 Added
			OR (IX+16)					; :dbolli:20121020 12:02:22 Added
			LD (HL),A					; :dbolli:20121020 12:02:22 Added
endif		; !COLCHR16_SUPPRESS
			RET
