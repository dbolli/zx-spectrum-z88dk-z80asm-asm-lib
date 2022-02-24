
SECTION asm_lib
PUBLIC DRAWBRESLINE

EXTERN OURPIXADD

INCLUDE "../../z88dk-zxspectrum-equates.asm"

; Draws a Bresenham line from x1,y1 to x2,y2
; On entry B = y1, C = x1, D = y2, E = x2

.DRAWBRESLINE	LD (DBLSTART),BC
			LD (DBLEND),DE
			LD A,(DBLEND)
			LD L,A
			LD H,$00
			LD A,(DBLSTART)
			LD E,A
			LD D,$00
			AND A
			SBC HL,DE
			LD (DBLDELTAX),HL			; deltax = x2 - x1
			LD A,(DBLDELTAX+1)
			AND A
			JP P,DBLGENDY
			LD DE,(DBLDELTAX)
			LD HL,$00
			AND A
			SBC HL,DE
			LD (DBLDELTAX),HL			; deltax = abs(x2 - x1)
.DBLGENDY		LD A,(DBLEND+1)
			LD L,A
			LD H,$00
			LD A,(DBLSTART+1)
			LD E,A
			LD D,$00
			AND A
			SBC HL,DE
			LD (DBLDELTAY),HL			; deltay = y2 - y1
			LD A,(DBLDELTAY+1)
			AND A
			JP P,DBLINVAR
			LD DE,(DBLDELTAY)
			LD HL,$00
			AND A
			SBC HL,DE
			LD (DBLDELTAY),HL

.DBLINVAR		LD HL,(DBLDELTAX)
			LD DE,(DBLDELTAY)
			AND A
			SBC HL,DE
			JR C,DBLYINT				; if deltax >= deltay
			LD HL,(DBLDELTAX)			; x is independant variable
			INC HL
			LD (DBLNUMPIX),HL			; numpixels = deltax + 1
			LD HL,(DBLDELTAY)
			ADD HL,HL					; deltay * 2
			LD (DBLDINC1),HL			; dinc1 = deltay * 2
			LD DE,(DBLDELTAX)
			AND A
			SBC HL,DE
			LD (DBLDVAR),HL			; d = (2 * deltay) - deltax
			LD HL,(DBLDELTAY)
			LD DE,(DBLDELTAX)
			AND A
			SBC HL,DE
			ADD HL,HL
			LD (DBLDINC2),HL			; dinc2 = (deltay - deltax) * 2
			LD A,$01
			LD (DBLXINC1),A			; xinc1 = 1
			LD (DBLXINC2),A			; xinc2 = 1
			LD (DBLYINC2),A			; yinc2 = 1
			DEC A
			LD (DBLYINC1),A			; yinc2 = 0
			JR DBLXYRD
.DBLYINT		LD HL,(DBLDELTAY)			; y is independant variable
			INC HL
			LD (DBLNUMPIX),HL			; numpixels = deltay + 1
			LD HL,(DBLDELTAX)
			ADD HL,HL					; deltax * 2
			LD (DBLDINC1),HL			; dinc1 = deltax * 2
			LD DE,(DBLDELTAY)
			AND A
			SBC HL,DE
			LD (DBLDVAR),HL			; d = (2 * deltax) - deltay
			LD A,$01
			LD (DBLXINC2),A			; xinc2 = 1
			LD (DBLYINC1),A			; yinc1 = 1
			LD (DBLYINC2),A			; yinc2 = 1
			DEC A
			LD (DBLXINC1),A			; xinc1 = 0
.DBLXYRD		LD A,(DBLEND)
			LD E,A
			LD A,(DBLSTART)
			SUB E
			JR C,DBLXYRD2				; if x1 > x2
			LD A,(DBLXINC1)
			LD E,A
			XOR A
			SUB E
			LD (DBLXINC1),A			; xinc1 = - xinc1
			LD A,(DBLXINC2)
			LD E,A
			XOR A
			SUB E
			LD (DBLXINC2),A			; xinc2 = - xinc2
.DBLXYRD2		LD A,(DBLEND+1)
			LD E,A
			LD A,(DBLSTART+1)
			SUB E
			JR C,DBLSTDRW				; if y1 > y2
			LD A,(DBLYINC1)
			LD E,A
			XOR A
			SUB E
			LD (DBLYINC1),A			; yinc1 = - yinc1
			LD A,(DBLYINC2)
			LD E,A
			XOR A
			SUB E
			LD (DBLYINC2),A			; yinc2 = - yinc2
.DBLSTDRW		LD HL,(DBLSTART)
			LD (DBLXVAR),HL			; x = x1	y = y1
			LD A,(DBLNUMPIX)
			LD B,A
.DBLDLP1		PUSH BC
			LD BC,(DBLXVAR)
			CALL DBLPLOTSUB

; If this is going to be fast enough
; we're going to have to re-write it
; so that the plot address is updated
; based on the previous plot address
; using INCY and DECY etc.

			LD A,(DBLDVAR+1)			; Get high byte of d
			AND A
			JP P,DBLDGRZ				; if d < 0
			LD HL,(DBLDVAR)
			LD DE,(DBLDINC1)
			AND A
			ADC HL,DE
			LD (DBLDVAR),HL			; d = d + dinc1
			LD A,(DBLXINC1)
			LD E,A
			LD A,(DBLXVAR)
			ADD A,E
			LD (DBLXVAR),A			; x = x + xinc1
			LD A,(DBLYINC1)
			LD E,A
			LD A,(DBLYVAR)
			ADD A,E
			LD (DBLYVAR),A			; y = y + yinc1
			JR DBLDEND
.DBLDGRZ		LD HL,(DBLDVAR)
			LD DE,(DBLDINC2)
			AND A
			ADC HL,DE
			LD (DBLDVAR),HL			; d = d + dinc2
			LD A,(DBLXINC2)
			LD E,A
			LD A,(DBLXVAR)
			ADD A,E
			LD (DBLXVAR),A			; x = x + xinc2
			LD A,(DBLYINC2)
			LD E,A
			LD A,(DBLYVAR)
			ADD A,E
			LD (DBLYVAR),A			; y = y + yinc2
.DBLDEND		POP BC
			DJNZ DBLDLP1

			RET

.DBLPLOTSUB	LD (COORDS),BC
			CALL OURPIXADD
			LD B,A
			INC B
			LD A,1
.DBLPLOTLOOP	RRCA
			DJNZ DBLPLOTLOOP
			LD B,A
			LD A,(HL)
			XOR B
			LD (HL),A
			RET

SECTION asm_lib_data

.DBLSTART		defw 0
.DBLEND		defw 0
.DBLDELTAX		defw 0
.DBLDELTAY		defw 0
.DBLNUMPIX		defw 0
.DBLDVAR		defw 0
.DBLDINC1		defw 0
.DBLDINC2		defw 0
.DBLXINC1		defb 0
.DBLXINC2		defb 0
.DBLYINC1		defb 0
.DBLYINC2		defb 0
.DBLXVAR		defb 0
.DBLYVAR		defb 0
; Storage for temp variables
