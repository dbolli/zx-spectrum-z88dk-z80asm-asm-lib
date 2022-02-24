
SECTION asm_lib
PUBLIC CALCSTACKTICKER

EXTERN NUMTICKERS
EXTERN INITTICKER
EXTERN HANDLETICKER
EXTERN DUMPHEX

EXTERN SAVEBOT2
EXTERN RESTBOT2

EXTERN AFPAIR
EXTERN HLPAIR
EXTERN DEPAIR
EXTERN BCPAIR
EXTERN PCPAIR
EXTERN SPPAIR

INCLUDE "../../z88dk-zxspectrum-equates.asm"

;/* . . . . . . . . . . .
; Print Calculator Stack debug info in Ticker
;
; Requires:
;   Ticker library
; A general purpose routine to print Calculator Stack debug info 
; it will:
;	save the bottom two lines of the screen (with attributes)
;	list the contents of the Calculator Stack (STKBOT -> STKEND)
; 	get a keypress and restore the screen
;
;*/

.CALCSTACKTICKER                                 ; :dbolli:20211222 12:23:37 Print Calculator Stack debug info in Ticker
            LD (HLPAIR),HL                      ; :dbolli:20140607 11:10:52 Re-uses PRINTREG storage space
;			POP HL
;			PUSH HL
;			LD (PCPAIR),HL
			PUSH DE
			POP HL
			LD (DEPAIR),HL
			PUSH BC
			POP HL
			LD (BCPAIR),HL
			PUSH AF
			POP HL
			LD (AFPAIR),HL
			PUSH AF							; DB011215 18:32 Save Flags
			LD HL,$0000
			ADD HL,SP							; DB011209 10:56 Get value of Stack Pointer pair
			LD (SPPAIR),HL						; DB011209 10:57 This probably should be adjusted by two bytes to compensate for return address...
			LD HL,(HLPAIR)
			POP AF								; DB011215 18:32 Restore Flags

; Save register contents

			PUSH AF
			PUSH HL
			PUSH DE
			PUSH BC

            CALL SAVEBOT2               ; :dbolli:20140607 10:58:48 Save bottom 2 lines of screen to PRSCRBUF and PRATRBUF

            LD DE,CSTACKTICKM2AREG
			LD A,(AFPAIR+1)
			CALL DUMPHEX

            LD DE,CSTACKTICKM2HLPAIR
			LD A,(HLPAIR+1)
			CALL DUMPHEX
			LD A,(HLPAIR)
			CALL DUMPHEX

            LD DE,CSTACKTICKM2DEPAIR
			LD A,(DEPAIR+1)
			CALL DUMPHEX
			LD A,(DEPAIR)
			CALL DUMPHEX

            LD DE,CSTACKTICKM2BCPAIR
			LD A,(BCPAIR+1)
			CALL DUMPHEX
			LD A,(BCPAIR)
			CALL DUMPHEX

            LD DE,CSTACKTICKM2SPPAIR
			LD A,(SPPAIR+1)
			CALL DUMPHEX
			LD A,(SPPAIR)
			CALL DUMPHEX

            LD DE,CSTACKTICKM2STKBOT
			LD A,(STKBOT+1)
			CALL DUMPHEX
			LD A,(STKBOT)
			CALL DUMPHEX

            LD DE,CSTACKTICKM2STKEND
			LD A,(STKEND+1)
			CALL DUMPHEX
			LD A,(STKEND)
			CALL DUMPHEX

			LD HL,(STKEND)
			LD DE,(STKBOT)
			AND A						; Clear carry flag
			SBC HL,DE					; HL = items on stack * 5
 
 			PUSH HL
 			POP BC						; BC = items on stack * 5
 			CALL STACKBC
			LD A,5
			CALL STACKA
			RST $28						; FPCALC
			defb	$05					; division
			defb	$38					; end-calc
			CALL FPTOBC					; BC = num items on stack

			LD A,C
			LD (STACKNUMITEMS),A
			LD A,B
			LD (STACKNUMITEMS+1),A		; Save num items on stack

			LD DE,CSTACKTICKM2ITEM1		; Clear stack items text area
			LD B,5
.CSTKDUMPITEMSLP1
			PUSH BC
			LD B,5
.CSTKDUMPITEMSLP2
;			XOR A
;			CALL DUMPHEX
			LD A,'X'					; Fill unused items with 'X's
			LD (DE),A
			INC DE
			LD (DE),A
			INC DE			
			INC HL
			INC DE
			INC DE
			DJNZ CSTKDUMPITEMSLP2
			POP BC
			INC DE
			DJNZ CSTKDUMPITEMSLP1

 			LD DE,CSTACKTICKM2ITEMS
			LD A,B
;			PUSH BC						; DUMPHEX only uses AF and increments DE
			CALL DUMPHEX
;			POP BC
			LD A,C
			CALL DUMPHEX
			
			LD A,(STACKNUMITEMS)
			LD B,A
			LD A,(STACKNUMITEMS+1)
			OR B
			JR Z,CSTKDUMPITEMSEND		; Skip loading items if calc stack empty

			LD HL,(STKBOT)
			LD DE,CSTACKTICKM2ITEM1
.CSTKDUMPITEMSLP3
			PUSH BC
			LD B,5
.CSTKDUMPITEMSLP4
			LD A,(HL)
			CALL DUMPHEX
			INC HL
			INC DE
			INC DE
			DJNZ CSTKDUMPITEMSLP4
			POP BC
			INC DE
			DJNZ CSTKDUMPITEMSLP3

.CSTKDUMPITEMSEND

;            LD A,(NUMTICKERS)
;            AND A
;            JR NZ,PRTGKTICKINITDONE         ;// :dbolli:20140614 10:25:58 Only init Tickers if num active tickers is zero

            LD		IX,CALCSTACKTICKPARAM1
			CALL	INITTICKER

            LD		IX,CALCSTACKTICKPARAM2
			CALL	INITTICKER

			XOR A
			LD (LASTK),A
.CSTKLP1	HALT
			CALL HANDLETICKER           ; :dbolli:20140614 9:48:28 Update Ticker
			LD A,(LASTK)
			AND A
			JR Z,CSTKLP1

            CALL RESTBOT2                       ;// :dbolli:20140607 11:00:50 Restore bottom 2 lines of screen from PRSCRBUF and PRATRBUF

            LD A,(NUMTICKERS)
            SUB 2
            LD (NUMTICKERS),A           ;// :dbolli:20140614 10:51:20 Decrement number of active tickers

			POP BC
			POP DE
			POP HL
			POP AF

			RET

SECTION asm_lib_data

.STACKNUMITEMS	defw $0000

.CALCSTACKTICKPARAM1
            DEFB	0				; :dbolli:20140607 15:39:11 (IX+0) Start x coord
			DEFB	22				; :dbolli:20140607 15:39:11 (IX+1) Start y coord
			DEFB	32				; :dbolli:20140607 15:39:11 (IX+2) Width (can be longer or shorter than actual message)
			DEFW	CALCSTACKTICKHEADERMESS1		; :dbolli:20140607 15:39:11 (IX+3) Pointer to message attr and text
			DEFW	$0000			; :dbolli:20140607 15:39:11 (IX+5) Pointer to current letter in message string (internal)
			DEFB	$00				; :dbolli:20140607 15:39:11 (IX+7) Current letter bit rotation (internal)
			DEFB	$00             ; :dbolli:20140607 15:39:11 (IX+8) Flags to control ticker behaviour
			DEFS	$08,$00			; :dbolli:20140607 15:39:11 (IX+9) 8 byte buffer for next letter (internal)
;
.CALCSTACKTICKHEADERMESS1
            DEFB	( $00 * $80 ) + ( $01 * $40 ) + ( $01 * $08 ) + $07     ; :dbolli:20140607 15:39:11 @01001111 Bright Colour white ink on blue paper
			defm " A  "
			defm " H L  "
			defm " D E  "
			defm " B C  "
			defm " S P  "
			defm "STKBOT "
			defm "STKEND "
			defm "ITEMS  "
			defm "ITEM 1               "
			defm "ITEM 2               "
			defm "ITEM 3               "
			defm "ITEM 4               "
			defm "ITEM 5               "
            defm "PRESS  "
			defb ' ' + $80

.CALCSTACKTICKPARAM2
            DEFB	0				; :dbolli:20140607 15:39:11 (IX+0) Start x coord
			DEFB	23				; :dbolli:20140607 15:39:11 (IX+1) Start y coord
			DEFB	32				; :dbolli:20140607 15:39:11 (IX+2) Width (can be longer or shorter than actual message)
			DEFW	CALCSTACKTICKDATAMESS2		; :dbolli:20140607 15:39:11 (IX+3) Pointer to message attr and text
			DEFW	$0000			; :dbolli:20140607 15:39:11 (IX+5) Pointer to current letter in message string (internal)
			DEFB	$00				; :dbolli:20140607 15:39:11 (IX+7) Current letter bit rotation (internal)
			DEFB	$00             ; :dbolli:20140607 15:39:11 (IX+8) Flags to control ticker behaviour
			DEFS	$08,$00			; :dbolli:20140607 15:39:11 (IX+9) 8 byte buffer for next letter (internal)
;
.CALCSTACKTICKDATAMESS2
            DEFB	( $00 * $80 ) + ( $00 * $40 ) + ( $01 * $08 ) + $06     ; :dbolli:20140607 15:39:11 @00001110 Colour yellow ink on blue paper
			defm "$"
.CSTACKTICKM2AREG
            defm "00"
            defm " "
			defm "$"
.CSTACKTICKM2HLPAIR
            defm "0000"
            defm " "
			defm "$"
.CSTACKTICKM2DEPAIR
            defm "0000"
            defm " "
			defm "$"
.CSTACKTICKM2BCPAIR
            defm "0000"
            defm " "
 			defm "$"
.CSTACKTICKM2SPPAIR
            defm "0000"
            defm " "
 			defm "$"
.CSTACKTICKM2STKBOT
            defm "0000"
            defm "  "
			defm "$"
.CSTACKTICKM2STKEND
            defm "0000"
            defm "  "
			defm "$"
.CSTACKTICKM2ITEMS
            defm "0000"
            defm "  "
			defm "$"
.CSTACKTICKM2ITEM1
            defm "00"
            defm " $"
            defm "00"
            defm " $"
            defm "00"
            defm " $"
            defm "00"
            defm " $"
            defm "00"
            defm "  "
			defm "$"
.CSTACKTICKM2ITEM2
            defm "00"
            defm " $"
            defm "00"
            defm " $"
            defm "00"
            defm " $"
            defm "00"
            defm " $"
            defm "00"
            defm "  "
			defm "$"
.CSTACKTICKM2ITEM3
            defm "00"
            defm " $"
            defm "00"
            defm " $"
            defm "00"
            defm " $"
            defm "00"
            defm " $"
            defm "00"
            defm "  "
			defm "$"
.CSTACKTICKM2ITEM4
            defm "00"
            defm " $"
            defm "00"
            defm " $"
            defm "00"
            defm " $"
            defm "00"
            defm " $"
            defm "00"
            defm "  "
			defm "$"
.CSTACKTICKM2ITEM5
            defm "00"
            defm " $"
            defm "00"
            defm " $"
            defm "00"
            defm " $"
            defm "00"
            defm " $"
            defm "00"
            defm "  "
            defm "ANY KEY"
			defb ' ' + $80

;INCLUDE "../../Ticker-zasm/z88dk-Ticker-library.asm"			;// Screen Ticker library routines