
SECTION asm_lib
PUBLIC PRINTREG

PUBLIC SAVEBOT2
PUBLIC RESTBOT2

EXTERN GETK2
EXTERN GETPRADDR
EXTERN PRSTRNG12
EXTERN PRASCII12
EXTERN PRHEX
EXTERN PRHEX12
EXTERN PRA12FLG
EXTERN GET2

EXTERN PAPERG
EXTERN INKN

INCLUDE "../../z88dk-zxspectrum-equates.asm"

;/* . . . . . . . . . . .
; Print Registers
;
; A general purpose routine to print the contents of registers
; it will:
;	save the bottom two lines of the screen (with attributes)
;	list the contents of the registers with flags in half width font
; 	get a keypress and restore the screen
;
;*/

.PRINTREG	LD (HLPAIR),HL
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
;// Save register contents

			PUSH AF
			PUSH HL
			PUSH DE
			PUSH BC

            CALL SAVEBOT2               ;// :dbolli:20140607 10:58:48 Save bottom 2 lines of screen to PRSCRBUF and PRATRBUF

			LD B,22
			LD C,0
			CALL GETPRADDR
			LD DE,PREGMESS2
			CALL PRSTRNG12

			LD B,23
			LD C,0
			CALL GETPRADDR
			XOR A
			LD (PRA12FLG),A

			LD A,(AFPAIR)
			LD B,8
.PRFLP1		RLCA
			PUSH AF
			JR NC,PRFLPEND1
;			LD A,"X"					;// DB011201 12:45 Commented out...
			LD A,'1'					;// DB011201 12:44 Not sure which looks better Xs or 010101
			JR PRFLPEND2
.PRFLPEND1	LD A,'0'					;// DB011201 14:00 
;			LD A,$20							;// DB011201 12:45 Commented out...
.PRFLPEND2	PUSH BC
			CALL PRASCII12
			POP BC
			POP AF
			DJNZ PRFLP1

			LD B,23
			LD C,5
			CALL GETPRADDR
			LD A,(AFPAIR+1)
			CALL PRHEX				;// Print the A register
;			LD A,(AFPAIR)
;			CALL PRHEX12				;// Print the Flags register

			INC HL
			LD A,(HLPAIR+1)
			CALL PRHEX
			LD A,(HLPAIR)
			CALL PRHEX

			INC HL
			LD A,(DEPAIR+1)
			CALL PRHEX
			LD A,(DEPAIR)
			CALL PRHEX

			INC HL
			LD A,(BCPAIR+1)
			CALL PRHEX
			LD A,(BCPAIR)
			CALL PRHEX

			INC HL
			LD A,(PCPAIR+1)
			CALL PRHEX
			LD A,(PCPAIR)
			CALL PRHEX

			INC HL
			LD A,(SPPAIR+1)
			CALL PRHEX
			LD A,(SPPAIR)
			CALL PRHEX
;/*
;
;			LD B,23
;			LD C,29
;			CALL GETPRADDR
;			XOR A
;			LD (PRA12FLG),A
;;			CALL PRELTIME12
;; Print the elapsed time since startup in seconds
;			LD A,(AFPAIR)
;			CALL PRHEX							; Print the flags register in hex
;
;*/
			LD B,22							;// DB011201 12:42 Print Press a Key Message
			LD C,29
			CALL GETPRADDR
			LD DE,PREGMESS1
			CALL PRSTRNG12

			LD B,22							;// DB011201 12:42 Print Breakpoint Counter Message
			LD C,31
			CALL GETPRADDR
			LD DE,PREGMESS3
			CALL PRSTRNG12
			LD B,22							;// DB011201 12:42 Print Breakpoint Counter Message
			LD C,31
			CALL GETPRADDR
			XOR A
			LD (PRA12FLG),A					;// DB011209 20:36 
			LD A,(PREGMARKER)
			INC A
			LD (PREGMARKER),A
			CALL PRHEX12

if 1
			XOR A
			LD (LASTK),A
if 0
.PRGKLP1	HALT
else
PRGKLP1:	CALL KEYBOARD					; :dbolli:20220222 11:10:49 Added as will work with DI active (called by MASKINT)
endif
			LD A,(LASTK)
			AND A
			JR Z,PRGKLP1
else
			CALL GETK2							; :dbolli:20220222 11:27:13 Added as will work with DI active
endif
            CALL RESTBOT2                       ;// :dbolli:20140607 11:00:50 Restore bottom 2 lines of screen from PRSCRBUF and PRATRBUF

			POP BC
			POP DE
			POP HL
			POP AF

			RET

.SAVEBOT2	LD B,22                              ;// :dbolli:20140607 10:58:48 Save bottom 2 lines of screen to PRSCRBUF and PRATRBUF
			LD C,0
			CALL GETPRADDR
			PUSH HL
			LD DE,PRSCRBUF
			LD B,2
.PRSLP1		PUSH BC
			LD B,32
.PRSLP2		PUSH BC
			PUSH HL
			LD B,8
.PRSLP3		LD A,(HL)
			LD (DE),A
			XOR A
			LD (HL),A
			INC DE
			INC H
			DJNZ PRSLP3
			POP HL
			POP BC
			INC HL
			DJNZ PRSLP2
			POP BC
			DJNZ PRSLP1
			POP HL
			CALL GET2
			PUSH HL
			LD DE,PRATRBUF
			LD BC,64
			LDIR
			POP HL
			LD A,(INKN)
			LD B,A
			LD A,(PAPERG)
			RLCA
			RLCA
			RLCA
			OR B
			LD (HL),A
			LD (PREGMESS2),A
			PUSH HL
			POP DE
			INC DE
			LD BC,63
			LDIR								;// Save contents of bottom two lines of the screen
            RET

.RESTBOT2	LD B,22                             ;// :dbolli:20140607 11:00:50 Restore bottom 2 lines of screen from PRSCRBUF and PRATRBUF
			LD C,0
			CALL GETPRADDR
			PUSH HL
			LD DE,PRSCRBUF
			LD B,2
.PRSLP4		PUSH BC
			LD B,32
.PRSLP5		PUSH BC
			PUSH HL
			LD B,8
.PRSLP6		LD A,(DE)
			LD (HL),A
			INC DE
			INC H
			DJNZ PRSLP6
			POP HL
			POP BC
			INC HL
			DJNZ PRSLP5
			POP BC
			DJNZ PRSLP4
			POP HL
			CALL GET2
			PUSH HL
			POP DE
			LD HL,PRATRBUF
			LD BC,64
			LDIR								;// Restore the bottom two lines of the screen
            RET

SECTION asm_lib_data
PUBLIC AFPAIR
PUBLIC HLPAIR
PUBLIC DEPAIR
PUBLIC BCPAIR
PUBLIC PCPAIR
PUBLIC SPPAIR

PUBLIC PREGMARKER

.AFPAIR		defw 0
.HLPAIR		defw 0
.DEPAIR		defw 0
.BCPAIR		defw 0
.PCPAIR		defw 0
.SPPAIR		defw 0

.PRSCRBUF	defs 512						;// DB020824 01:32 
;// 512 byte buffer for screen save
.PRATRBUF	defs 64		;// DB020824 01:32 
;// 64 byte buffer for attr save

.PREGMESS1	defb $CD
			defm " Key"
			defb ' ' + $80

.PREGMESS2	defb $CD
			defm "SZ-H-PNC "
			defw $2020
			defm "A "
			defw $2020
			defw $2020
			defw $2020
			defm "H L "
			defw $2020
			defw $2020
			defb $20
			defm "D E "
			defw $2020
			defw $2020
			defw $2020
			defm "B C "
			defw $2020
			defw $2020
			defw $2020
			defm "P C "
			defw $2020
			defm "S "
			defb 'P' + $80

.PREGMESS3	defb @01011111 			;// $5F
			defb $20 | $80			;// DB011209 20:02 This is a counter to show which breakpoint we are at

.PREGMARKER defb $00					;// DB011209 20:12 The actual counter
