
SECTION asm_lib
PUBLIC DRAWBRESCIRCLE

EXTERN PLOTSUB

INCLUDE "../../z88dk-zxspectrum-equates.asm"

.DRAWBRESCIRCLE
; Draw a Bresenham circle at oX,oY radius Rad
; On entry B = oY, C = oX, A = Rad
			LD (DBCOORDS),BC		; Save start coords
			LD E,A					; Save radius
			CP 35
			JR NC,DBCDOBRES
			PUSH AF					; Save radius
			LD A,(DBCOORDS)
			CALL STACKA
			LD A,(DBCOORDS+1)
			CALL STACKA
			POP AF					; Restore radius
			CALL STACKA
			JP CRGRE1
; Use slow ROM routine circle routine
; for circles with radius < 20 pixels
.DBCDOBRES	LD A,$01
			AND A
			SUB E
			LD (DBCDVAR),A			; d = 1 - Rad
;
			XOR A
			LD (DBCXVAR),A			; x = 0
;
			LD A,E
			LD (DBCYVAR),A			; y = Rad
;
.DBCLP1		LD A,(DBCXVAR)
			LD E,A
			LD A,(DBCYVAR)
			AND A
			SUB E
			JP C,DBCDONE			; while y > x
;
; Plot the eight sets of points for each bit of the circle
			LD A,(DBCXVAR)
			LD E,A
			LD A,(DBCOORDS)
			ADD A,E
			LD C,A
			LD A,(DBCYVAR)
			LD E,A
			LD A,(DBCOORDS+1)
			ADD A,E
			LD B,A
			CALL PLOTSUB			; plot Xo + x, Yo + y
			LD A,(DBCXVAR)
			LD E,A
			LD A,(DBCOORDS)
			ADD A,E
			LD C,A
			LD A,(DBCYVAR)
			LD E,A
			LD A,(DBCOORDS+1)
			SUB E
			LD B,A
			CALL PLOTSUB			; plot Xo + x, Yo - y
			LD A,(DBCXVAR)
			LD E,A
			LD A,(DBCOORDS)
			SUB E
			LD C,A
			LD A,(DBCYVAR)
			LD E,A
			LD A,(DBCOORDS+1)
			ADD A,E
			LD B,A
			CALL PLOTSUB			; plot Xo - x, Yo + y
			LD A,(DBCXVAR)
			LD E,A
			LD A,(DBCOORDS)
			SUB E
			LD C,A
			LD A,(DBCYVAR)
			LD E,A
			LD A,(DBCOORDS+1)
			SUB E
			LD B,A
			CALL PLOTSUB			; plot Xo - x, Yo - y
			LD A,(DBCYVAR)
			LD E,A
			LD A,(DBCOORDS)
			ADD A,E
			LD C,A
			LD A,(DBCXVAR)
			LD E,A
			LD A,(DBCOORDS+1)
			ADD A,E
			LD B,A
			CALL PLOTSUB			; plot Xo + y, Yo + x
			LD A,(DBCYVAR)
			LD E,A
			LD A,(DBCOORDS)
			ADD A,E
			LD C,A
			LD A,(DBCXVAR)
			LD E,A
			LD A,(DBCOORDS+1)
			SUB E
			LD B,A
			CALL PLOTSUB			; plot Xo + y, Yo - x
			LD A,(DBCYVAR)
			LD E,A
			LD A,(DBCOORDS)
			SUB E
			LD C,A
			LD A,(DBCXVAR)
			LD E,A
			LD A,(DBCOORDS+1)
			ADD A,E
			LD B,A
			CALL PLOTSUB			; plot Xo - y, Yo + x
			LD A,(DBCYVAR)
			LD E,A
			LD A,(DBCOORDS)
			SUB E
			LD C,A
			LD A,(DBCXVAR)
			LD E,A
			LD A,(DBCOORDS+1)
			SUB E
			LD B,A
			CALL PLOTSUB			; plot Xo + y, Yo + x
;
			LD A,(DBCDVAR)
			AND A
			JP M,DBCDNEG			; if d < 0 then
			LD E,A					; save d
			LD A,(DBCXVAR)
			SLA A					; 2 * x
			ADD A,E					; d + (2 * x)
			ADD A,$03				; d + (2 * x) + 3
			LD (DBCDVAR),A			; d = d + (2 * x) + 3
			LD HL,DBCXVAR
			INC (HL)				; x = x + 1
			JP DBCLP1
; 
.DBCDNEG		LD A,(DBCYVAR)
			LD E,A
			LD A,(DBCXVAR)
			AND A
			SUB E					; x - y
			SLA A					; 2 * (x - y)
			LD E,A
			LD A,(DBCDVAR)
			ADD A,E					; d + 2 * (x - y)
			ADD A,$05				; d + 2 * (x - y)
			LD (DBCDVAR),A			; d = d + 2 * (x - y)
			LD HL,DBCXVAR
			INC (HL)				; x = x + 1
			INC HL
			DEC (HL)				; y = y - 1
			JP DBCLP1
;
.DBCDONE	RET
;

SECTION asm_lib_data

.DBCOORDS defw 0
; Storage for start coords
.DBCDVAR defb 0
.DBCXVAR defb 0
.DBCYVAR defb 0
; Storage for temp variables
