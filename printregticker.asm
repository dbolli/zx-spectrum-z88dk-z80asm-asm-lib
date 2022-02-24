
SECTION asm_lib
PUBLIC PRINTREGTICKER
PUBLIC DUMPHEX

EXTERN NUMTICKERS
EXTERN INITTICKER
EXTERN HANDLETICKER

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
; Print Registers in Ticker
;
; Requires:
;   Ticker library
; A general purpose routine to print the contents of registers
; it will:
;	save the bottom two lines of the screen (with attributes)
;	list the contents of the registers with flags in half width font
; 	get a keypress and restore the screen
;
;*/

.PRINTREGTICKER                                 ;// :dbolli:20140607 11:09:41 Print Register details in Ticker
            LD (HLPAIR),HL                      ;// :dbolli:20140607 11:10:52 Re-uses PRINTREG storage space
			POP HL
			PUSH HL
			LD (PCPAIR),HL
			PUSH DE
			POP HL
			LD (DEPAIR),HL
			PUSH BC
			POP HL
			LD (BCPAIR),HL
			PUSH AF
			POP HL
			LD (AFPAIR),HL
			PUSH AF							;// DB011215 18:32 Save Flags
			LD HL,$0000
			ADD HL,SP							;// DB011209 10:56 Get value of Stack Pointer pair
			LD (SPPAIR),HL						;// DB011209 10:57 This probably should be adjusted by two bytes to compensate for return address...
			LD HL,(HLPAIR)
			POP AF								;// DB011215 18:32 Restore Flags

			PUSH IX
			POP HL
			LD (IXPAIR),HL						; :dbolli:20180820 10:01:36 Added
			PUSH IY
			POP HL
			LD (IYPAIR),HL						; :dbolli:20180820 10:01:36 Added

            EXX
            LD (HLPRIMEPAIR),HL                 ;// :dbolli:20140614 10:41:00 Save alternate registers
            EX AF,AF
            PUSH AF
            POP HL
            LD (AFPRIMEPAIR),HL
            PUSH BC
            POP HL
            LD (BCPRIMEPAIR),HL
            PUSH DE
            POP HL
            LD (DEPRIMEPAIR),HL
            EX AF,AF
            EXX
;// Save register contents

			PUSH AF
			PUSH HL
			PUSH DE
			PUSH BC

            CALL SAVEBOT2               ;// :dbolli:20140607 10:58:48 Save bottom 2 lines of screen to PRSCRBUF and PRATRBUF

            LD DE,PRREGTICKM2FLAGS
			LD A,(AFPAIR)
			LD B,8
.PRTFLP1	RLCA
			PUSH AF
			JR NC,PRTFLPEND1
			LD A,'1'					;// DB011201 12:44 Not sure which looks better Xs or 010101
			JR PRTFLPEND2
.PRTFLPEND1	LD A,'0'					;// DB011201 14:00
.PRTFLPEND2	LD (DE),A
            INC DE
			POP AF
			DJNZ PRTFLP1

            LD DE,PRREGTICKM2AREG
			LD A,(AFPAIR+1)
			CALL DUMPHEX

            LD DE,PRREGTICKM2HLPAIR
			LD A,(HLPAIR+1)
			CALL DUMPHEX
			LD A,(HLPAIR)
			CALL DUMPHEX

            LD DE,PRREGTICKM2DEPAIR
			LD A,(DEPAIR+1)
			CALL DUMPHEX
			LD A,(DEPAIR)
			CALL DUMPHEX

            LD DE,PRREGTICKM2BCPAIR
			LD A,(BCPAIR+1)
			CALL DUMPHEX
			LD A,(BCPAIR)
			CALL DUMPHEX

			LD DE,PRREGTICKM2IXPAIR			; :dbolli:20180820 10:03:47 Added
			LD A,(IXPAIR+1)
			CALL DUMPHEX
			LD A,(IXPAIR)
			CALL DUMPHEX

			LD DE,PRREGTICKM2IYPAIR			; :dbolli:20180820 10:03:47 Added
			LD A,(IYPAIR+1)
			CALL DUMPHEX
			LD A,(IYPAIR)
			CALL DUMPHEX

            LD DE,PRREGTICKM2AFPRIMEPAIR
			LD A,(AFPRIMEPAIR+1)
			CALL DUMPHEX
			LD A,(AFPRIMEPAIR)
			CALL DUMPHEX

            LD DE,PRREGTICKM2HLPRIMEPAIR
			LD A,(HLPRIMEPAIR+1)
			CALL DUMPHEX
			LD A,(HLPRIMEPAIR)
			CALL DUMPHEX

            LD DE,PRREGTICKM2DEPRIMEPAIR
			LD A,(DEPRIMEPAIR+1)
			CALL DUMPHEX
			LD A,(DEPRIMEPAIR)
			CALL DUMPHEX

            LD DE,PRREGTICKM2BCPRIMEPAIR
			LD A,(BCPRIMEPAIR+1)
			CALL DUMPHEX
			LD A,(BCPRIMEPAIR)
			CALL DUMPHEX

            LD DE,PRREGTICKM2PCPAIR
			LD A,(PCPAIR+1)
			CALL DUMPHEX
			LD A,(PCPAIR)
			CALL DUMPHEX

            LD DE,PRREGTICKM2SPPAIR
			LD A,(SPPAIR+1)
			CALL DUMPHEX
			LD A,(SPPAIR)
			CALL DUMPHEX

            LD DE,PRREGTICKM2STKBOT
			LD A,(STKBOT+1)
			CALL DUMPHEX
			LD A,(STKBOT)
			CALL DUMPHEX

            LD DE,PRREGTICKM2RAMTOP
			LD A,(RAMTOP+1)
			CALL DUMPHEX
			LD A,(RAMTOP)
			CALL DUMPHEX

            LD DE,PRREGTICKM2COORDS
			LD A,(COORDS+1)
			CALL DUMPHEX
			LD A,(COORDS)
			CALL DUMPHEX

;            LD A,(NUMTICKERS)
;            AND A
;            JR NZ,PRTGKTICKINITDONE         ;// :dbolli:20140614 10:25:58 Only init Tickers if num active tickers is zero

            LD		IX,PRINTREGTICKPARAM1
			CALL	INITTICKER

            LD		IX,PRINTREGTICKPARAM2
			CALL	INITTICKER

			XOR A
			LD (LASTK),A
.PRTGKLP1	HALT
			CALL HANDLETICKER           ; :dbolli:20140614 9:48:28 Update Ticker
			LD A,(LASTK)
			AND A
			JR Z,PRTGKLP1

            CALL RESTBOT2                       ;// :dbolli:20140607 11:00:50 Restore bottom 2 lines of screen from PRSCRBUF and PRATRBUF

            LD A,(NUMTICKERS)
            SUB 2
            LD (NUMTICKERS),A           ;// :dbolli:20140614 10:51:20 Decrement number of active tickers

			POP BC
			POP DE
			POP HL
			POP AF

			RET

.DUMPHEX	PUSH AF                  ;// :dbolli:20140615 11:50:23 Dump two hex digits in A to (DE) and (DE+1)
			RRCA
			RRCA
			RRCA
			RRCA
			AND $0F					;// %00001111
			CP $0A
			JR C,DMPHNC1
			ADD A,7
.DMPHNC1	ADD A,$30
            LD (DE),A               ;// :dbolli:20140615 11:50:23 Store hex digit at (DE)
            INC DE                  ;// :dbolli:20140615 11:50:23 Increment destination pointer
			POP AF
			AND $0F					;// %00001111
			CP $0A
			JR C,DMPHNC2
			ADD A,7
.DMPHNC2	ADD A,$30
			LD (DE),A               ;// :dbolli:20140615 11:50:23 Store hex digit at (DE)
            INC DE                  ;// :dbolli:20140615 11:50:23 Increment destination pointer
			RET                     ;// :dbolli:20140615 11:50:23 DE points to original DE + 2

SECTION asm_lib_data

.IXPAIR		defw $0000				; :dbolli:20180820 10:00:36 Added
.IYPAIR		defw $0000				; :dbolli:20180820 10:00:36 Added
.AFPRIMEPAIR
            defw $0000
.HLPRIMEPAIR
            defw $0000
.DEPRIMEPAIR
            defw $0000
.BCPRIMEPAIR
            defw $0000

.PRINTREGTICKPARAM1
            DEFB	0				; :dbolli:20140607 15:39:11 (IX+0) Start x coord
			DEFB	22				; :dbolli:20140607 15:39:11 (IX+1) Start y coord
			DEFB	32				; :dbolli:20140607 15:39:11 (IX+2) Width (can be longer or shorter than actual message)
			DEFW	PRINTREGTICKHEADERMESS1		; :dbolli:20140607 15:39:11 (IX+3) Pointer to message attr and text
			DEFW	$0000			; :dbolli:20140607 15:39:11 (IX+5) Pointer to current letter in message string (internal)
			DEFB	$00				; :dbolli:20140607 15:39:11 (IX+7) Current letter bit rotation (internal)
			DEFB	$00             ; :dbolli:20140607 15:39:11 (IX+8) Flags to control ticker behaviour
			DEFS	$08,$00			; :dbolli:20140607 15:39:11 (IX+9) 8 byte buffer for next letter (internal)
;
.PRINTREGTICKHEADERMESS1
            DEFB	( $00 * $80 ) + ( $01 * $40 ) + ( $01 * $08 ) + $07     ; :dbolli:20140607 15:39:11 @01001111 Bright Colour white ink on blue paper
			defm "SZ-H-PNC "
			defm " A  "
			defm " H L  "
			defm " D E  "
			defm " B C  "
			defm " I X  "			; :dbolli:20180820 10:04:44 Added
			defm " I Y  "			; :dbolli:20180820 10:04:44 Added
			defm " A F' "
			defm " H L' "
			defm " D E' "
			defm " B C' "
			defm " P C  "
			defm " S P  "
            defm "STKBOT "
            defm "RAMTOP "
            defm "COORDS "
            defm "PRESS  "
			defb ' ' + $80

.PRINTREGTICKPARAM2
            DEFB	0				; :dbolli:20140607 15:39:11 (IX+0) Start x coord
			DEFB	23				; :dbolli:20140607 15:39:11 (IX+1) Start y coord
			DEFB	32				; :dbolli:20140607 15:39:11 (IX+2) Width (can be longer or shorter than actual message)
			DEFW	PRINTREGTICKDATAMESS2		; :dbolli:20140607 15:39:11 (IX+3) Pointer to message attr and text
			DEFW	$0000			; :dbolli:20140607 15:39:11 (IX+5) Pointer to current letter in message string (internal)
			DEFB	$00				; :dbolli:20140607 15:39:11 (IX+7) Current letter bit rotation (internal)
			DEFB	$00             ; :dbolli:20140607 15:39:11 (IX+8) Flags to control ticker behaviour
			DEFS	$08,$00			; :dbolli:20140607 15:39:11 (IX+9) 8 byte buffer for next letter (internal)
;
.PRINTREGTICKDATAMESS2
            DEFB	( $00 * $80 ) + ( $00 * $40 ) + ( $01 * $08 ) + $06     ; :dbolli:20140607 15:39:11 @00001110 Colour yellow ink on blue paper
.PRREGTICKM2FLAGS
            defm "00-0-000"
            defm " "
			defm "$"
.PRREGTICKM2AREG
            defm "00"
            defm " "
			defm "$"
.PRREGTICKM2HLPAIR
            defm "0000"
            defm " "
			defm "$"
.PRREGTICKM2DEPAIR
            defm "0000"
            defm " "
			defm "$"
.PRREGTICKM2BCPAIR
            defm "0000"
            defm " "
			defm "$"
.PRREGTICKM2IXPAIR equ $				; :dbolli:20180820 10:05:34 Added
            defm "0000"
            defm " "
			defm "$"
.PRREGTICKM2IYPAIR equ $				; :dbolli:20180820 10:05:34 Added
            defm "0000"
            defm " "
			defm "$"
.PRREGTICKM2AFPRIMEPAIR
            defm "0000"
            defm " "
			defm "$"
.PRREGTICKM2HLPRIMEPAIR
            defm "0000"
            defm " "
			defm "$"
.PRREGTICKM2DEPRIMEPAIR
            defm "0000"
            defm " "
			defm "$"
.PRREGTICKM2BCPRIMEPAIR
            defm "0000"
            defm " "
			defm "$"
.PRREGTICKM2PCPAIR
            defm "0000"
            defm " "
			defm "$"
.PRREGTICKM2SPPAIR
            defm "0000"
            defm " "
 			defm "$"
.PRREGTICKM2STKBOT
            defm "0000"
            defm "  "
			defm "$"
.PRREGTICKM2RAMTOP
            defm "0000"
            defm "  "
			defm "$"
.PRREGTICKM2COORDS
            defm "0000"
            defm "  "
            defm "ANY KEY"
			defb ' ' + $80

;INCLUDE "../../Ticker-zasm/z88dk-Ticker-library.asm"			;// Screen Ticker library routines