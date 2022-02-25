
;SECTION asm_lib_test
;PUBLIC sp1_ChangeSprType

;/*
; . . . . . . . . . . .
; Equates	
;
;*/

defc ROMSTART		= $0000	
defc ERROR1			= $0008	
defc PRINTA1		= $0010	
defc GETCHAR		= $0018	
defc NEXTCHAR		= $0020	
defc MASKINT		= $0038	

defc CHADD1			= $0074	           ; Advance CHADD Pointer to next char
defc KEYSCAN		= $028E				
defc KEYBOARD		= $02BF				
defc KEYTEST		= $031E	
defc KDECODE		= $0333	
defc BEEPER			= $03B5				
defc BEEP			= $03F8				
defc LDBYTES		= $0556				
defc POSTORE		= $0ADC	
defc POFETCH		= $0B03	
defc POATTR			= $0BDB	
defc TEMPS			= $0D4D	
defc ROMCLS			= $0D6B	
defc CLSET			= $0DD9	
defc CLSCROLL		= $0E00
defc CLADDR			= $0E9B	
defc COPY			= $0EAC	
defc COPYBUFF		= $0ECD	
defc EDLOOP			= $0F38	
defc EDEDIT			= $0FA9	
defc EDERROR		= $107F	
defc CHANOPEN		= $1601				
defc MAKEROOM		= $1655	
defc STRDATA1		= $1727				
defc NEXTONE		= $19B8				; Find next variable
defc RECLAIM1		= $19E5	
defc RECLAIM2		= $19E8				; Reclaim space
defc NEXT2NUM		= $1C79				
defc EXPT2NUM		= $1C7A	
defc EXPT1NUM		= $1C82	
defc EXPTEXP		= $1C8C				
defc FNDINT1		= $1E94				
defc FINDINT2		= $1E99	
defc PR_AT_TAB		= $201E	           ; Print AT
defc PIXADD			= $22AA	
;defc PIXADD		= OURPIXADD			; Point to our modified PIXADD
defc POINT_			= $22CB				; Coords on stack on entry (use STACKBC), binary result on stack at exit (use FPTOA)
defc CRGRE1			= $233B				; On entry stack = X Y Z -> Draws circle at X,Y with radius Z
defc DRAWLINE		= $24B7	
;defc DRAWLN2		= $24BA				; Use our routine below...
defc SCANNING		= $24FB	
defc STKSTORE		= $2AB6	
defc STKFETCH		= $2BF1	
defc DECTOFP		= $2C9B	
defc STACKA		= $2D28	
defc STACKBC		= $2D2B	
defc FPTOBC		= $2DA2	
defc FPTOA		= $2DD5	
defc PRINTFP		= $2DE3	
defc HLMULTDE		= $30A9			; HL = HL * DE. BC is saved. C set on return if 16 bits overflowed
defc STACKNUM		= $33B4	
defc MOVEFP		= $33C0	

defc DFILE		= $4000				; Screen coords 0 - 255, 0 (top) - 175 (or 191)
defc ATTRS		= $5800				; Screen chars 0 - 31, 0 - 21 (or 23)

defc COMMA_CONTROL		= $06					
defc CHAR_ENTER		= $0D					; ASCII CR
defc INK_CONTROL		= $10					
defc PAPER_CONTROL		= $11					
defc INVERSE_CONTROL		= $14					
defc AT_CONTROL		= $16					

defc CHAR_SPACE		= $20					; ASCII Space

defc GRAPHICS_SHIFT_3		= $8C				; Graphic Shift 3

defc GRAPHICS_A		= $90					; Graphic Char A

defc KWRDSCREENSTR	= $AA					; BASIC Keywords (see pp358-360 of Mastering Machine Code by Toni Baker)
defc KWRDAT			= $AC
defc KWRDCODE		= $AF
defc KWRDVAL		= $B0	
defc KWRDEXP		= $B9	
defc KWRDPEEK		= $BE
defc KWRDUSR		= $C0
defc KWRDBIN		= $C4
defc KWRDLINE		= $CA	
defc KWRDTO			= $CC	
defc KWRDCAT		= $CF	
defc KWRDBEEP		= $D7	
defc KWRDINK		= $D9	
defc KWRDPAPER		= $DA	
defc KWRDFLASH		= $DB
defc KWRDBRIGHT		= $DC	
defc KWRDOVER		= $DE
defc KWRDOUT		= $DF
defc KWRDLPRINT		= $E0	
defc KWRDSTOP		= $E2	
defc KWRDREAD		= $E3	
defc KWRDDATA		= $E4	
defc KWRDRESTORE	= $E5	
defc KWRDBORDER		= $E7	
defc KWRDREM		= $EA	
defc KWRDFOR		= $EB	
defc KWRDLOAD		= $EF	
defc KWRDLET		= $F1	
defc KWRDPAUSE		= $F2	
defc KWRDNEXT		= $F3	
defc KWRDPOKE		= $F4	
defc KWRDPRINT		= $F5	
defc KWRDRUN		= $F7
defc KWRDSAVE		= $F8
defc KWRDRANDOMIZE	= $F9	
defc KWRDCLS		= $FB	
defc KWRDCLEAR		= $FD	

;/*
; . . . . . . . . . . .
; Interface 1 Edition 2 equates (as per Fuse 1.0)
;*/

defc MAINROM		= $00	
defc CALBAS		= $10					; Call a main ROM routine
defc SHERR		= $20	
defc ROMERR		= $28	
defc NEWVAR		= $30	
defc ERR6		= $01F0	
defc NREPORTC		= $052F	
defc STEND		= $05B7	
defc END1		= $05C1				
defc EXPTNUM		= $061E	
defc NREPORT2		= $0663	
defc CHECKM2		= $066D	
defc NREPORT3		= $062D	
defc UNPAGE		= $0700	
defc NREPORTN		= 0x0906	
defc OPRSCH		= $0B17	
defc OPSTREAM		= $0B51	
defc TCHANOUT		= $0C3A	
defc BCHANOUT		= $0D07	
defc SETTMCH		= $10A5	
defc DELMBUF		= $119F	
defc RWFERR		= $1132	
defc GETRLP		= $125F	
defc RSSH2		= $11A3	
defc GHDRC		= $11A5	
defc GETMHD2		= $13A9	
defc RESBMAP		= $13E3	
defc DECSECT		= $13F7	
defc CHKSHDR		= $1426	
defc CLOSE_		= $1718	
defc SELDRIVE		= $1532	
defc OUTMBUF		= $15B3	
defc GETMBLK		= $15F2	
defc DELAYBC		= $1652	
defc RDSECTOR		= $1F3F	
defc RSSH		= $1AC5	
defc FREESECT		= $1D43	
defc PRCHAR		= $1D71	
defc INCHK		= $1E49	
defc DISPHEX		= $14D6	
defc DISPHEX2		= $14ED	
defc DISPCH		= $14F8	


;/*
; . . . . . . . . . . .
; Spectrum 128 Equates (as per http://www.fruitcake.plus.com/Sinclair/Spectrum128/ROMDisassembly/Spectrum128ROMDisassembly.htm )
;*/

defc L1C64      = $1C64             ; Page in Logical RAM Bank
defc L1F20      = $1F20             ; Use Normal RAM Configuration
defc L1F3A      = $1F3A             ; Select Physical RAM Bank
defc L1F45      = $1F45             ; Use Workspace RAM Configuration

;/*
; . . . . . . . . . . .
; System Variables
;
;*/

defc KSTATE		= $5C00	 			; Keyboard bytes
defc LASTK		= $5C08				; Last keypress
defc REPDEL		= $5C09				; Delay until repeat starts (Default 35)
defc REPPER		= $5C0A				; Key repeat delay (Default 5)
defc DEFADD		= $5C0B				; Pointer to DEF FN params during eval
defc KDATA		= $5C0D				; Second byte of colour control from keyboard
defc TVDATA		= $5C0E				; Both bytes of colour, AT, TAB controls
defc STRMS		= $5C10				; Address of Stream data
defc CHARS		= $5C36				; Address - $0100 of character definitions in ROM ($3D00)
defc RASP		= $5C38				; Duration of buzz (i.e. if no mem for input)
defc PIP		= $5C39				; Duration of keyboard click (Default 0)
defc ERRNR		= $5C3A				; Error Report Number - 1 <<< IY Points here
defc FLAGS		= $5C3B				; Flags (bit 5 = LASTK is valid, bit 1 = Printer output)
defc TVFLAG		= $5C3C				; Flag bits
defc ERRSP		= $5C3D				; Pointer to top of stack for RET on error
defc LISTSP		= $5C3F				; Pointer to return from auto list
defc MODE		= $5C41				; Keyword, Extended, Graphics or Letters/Caps
defc NEWPPC		= $5C42				; Next line number of program
defc NSPPC		= $5C44				; Next statement offset (in next line)
defc PPC		= $5C45				; Current line number of program
defc SUBPPC		= $5C47				; Current statement offset (in current line)
defc BORDCR		= $5C48				; Bits 5, 4, 3 = border colour
defc EPPC		= $5C49				; Program edit cursor line number
defc VARS		= $5C4B				; Pointer to first variable
defc DEST		= $5C4D				; Pointer to variable during assignment
defc CHANS		= $5C4F				; Pointer to first channel area
defc CURCHL		= $5C51				; Pointer to current channel area
defc PROG		= $5C53				; Pointer to first line in program
defc NXTLIN		= $5C55				; Pointer to next program line
defc DATADD		= $5C57				; Pointer to just past last data item read
defc ELINE		= $5C59				; Pointer to edit line
defc KCUR		= $5C5B				; Pointer to cursor
defc CHADD		= $5C5D				; Pointer to next char
defc XPTR		= $5C5F				; Pointer to syntax error
defc WORKSP		= $5C61				; Pointer to workspace
defc STKBOT		= $5C63				; Pointer to calculator stack base
defc STKEND		= $5C65				; Pointer to topmost memory address used by BASIC
defc BREG		= $5C67				; Byte used for B register of calculator
defc MEM		= $5C68				; Pointer to calculator memory
defc FLAGS2		= $5C6A				; Bit flags
defc DFSZ		= $5C6B				; Lines in lower screen (Default 2)
defc STOP		= $5C6C				; Line number of top line of auto list
defc OLDPPC		= $5C6E				; Continuation line number
defc OSPCC		= $5C70				; Continuation statement number
defc FLAGX		= $5C71				; Bit flags
defc STRLEN_	= $5C72				; String length during assignment
defc TADDR		= $5C74				; Pointer to next syntax table item
defc SEED		= $5C76				; Word used by random number routines
defc FRAMES		= $5C78				; Frame counter low, med, high bytes
defc UDG		= $5C7B				; Pointer to bit patterns for user defined graphics
defc COORDS		= $5C7D				; Plot x,y values
defc PPOSN		= $5C7F				; Printer position (Range 33-02)
defc PRCC		= $5C80				; Low byte of next address in printer buffer
									; $5C81 Unused
defc ECHOE		= $5C82				; Column, line for input buffer
defc DFCC		= $5C84				; Next screen location for print
defc DFCCL		= $5C86				; Next screen location for print (lower screen)
defc SPOSN		= $5C88				; Screen column (32-02), screen row (24-01)
defc SPOSNL		= $5C8A				; Screen column (32-02), screen row (24-01) (lower screen)
defc SCRCT		= $5C8C				; Remaining scroll count + 1 (0 is maximum)
defc ATTRP		= $5C8D				; Screen colours
defc MASKP		= $5C8E				; Defines the transparent screen colours
defc ATTRT		= $5C8F				; Temporary colours
defc MASKT		= $5C90				; Defines the transparent temporary screen colours
defc PFLAG		= $5C91				; Bit flags
defc MEMBOT		= $5C92				; Scratchpad area for calculator routines
defc SPARE2		= $5CB0				; Pointer used by NMI routine at $0066
defc RAMTOP		= $5CB2				; Pointer to highest stack byte (value $3E)
defc PRAMT		= $5CB4				; Highest byte that passed RAM test

;/*
; . . . . . . . . . . .
; System Variable Offsets
;
;*/

defc KSTATEOFF		= KSTATE-ERRNR		; Offsets for use in (IY+n)
defc LASTKOFF		= LASTK-ERRNR			
defc REPDELOFF		= REPDEL-ERRNR		
defc REPPEROFF		= REPPER-ERRNR		
defc DEFADDOFF		= DEFADD-ERRNR		
defc KDATAOFF		= KDATA-ERRNR			
defc TVDATAOFF		= TVDATA-ERRNR		
defc STRMSOFF		= STRMS-ERRNR			
defc CHARSOFF		= CHARS-ERRNR			
defc RASPOFF		= RASP-ERRNR			
defc PIPOFF			= PIP-ERRNR			
defc ERRNROFF		= ERRNR-ERRNR			
defc FLAGSOFF		= FLAGS-ERRNR			
defc TVFLAGOFF		= TVFLAG-ERRNR		
defc ERRSPOFF		= ERRSP-ERRNR			
defc LISTSPOFF		= LISTSP-ERRNR		
defc MODEOFF		= MODE-ERRNR			
defc NEWPPCOFF		= NEWPPC-ERRNR		
defc NSPPCOFF		= NSPPC-ERRNR			
defc PPCOFF			= PPC-ERRNR			
defc SUBPPCOFF		= SUBPPC-ERRNR		
defc BORDCROFF		= BORDCR-ERRNR		
defc EPPCOFF		= EPPC-ERRNR			
defc VARSOFF		= VARS-ERRNR			
defc DESTOFF		= DEST-ERRNR			
defc CHANSOFF		= CHANS-ERRNR			
defc CURCHLOFF		= CURCHL-ERRNR		
defc PROGOFF		= PROG-ERRNR			
defc NXTLINOFF		= NXTLIN-ERRNR		
defc DATADDOFF		= DATADD-ERRNR		
defc ELINEOFF		= ELINE-ERRNR			
defc KCUROFF		= KCUR-ERRNR			
defc CHADDOFF		= CHADD-ERRNR			
defc XPTROFF		= XPTR-ERRNR			
defc WORKSPOFF		= WORKSP-ERRNR		
defc STKBOTOFF		= STKBOT-ERRNR		
defc STKENDOFF		= STKEND-ERRNR		
defc BREGOFF		= BREG-ERRNR			
defc MEMOFF			= MEM-ERRNR			
defc FLAGS2OFF		= FLAGS2-ERRNR		
defc DFSZOFF		= DFSZ-ERRNR			

defc ATTRTOFF		= ATTRT-ERRNR	

;/*
; -----------------------------
; THE 'SHADOW' SYSTEM VARIABLES
; -----------------------------
;*/

defc FLAGS3		= $5CB6					; $5CB6 FLAGS3 IY+$7C - Flags
defc VECTOR		= $5CB7					; $5CB7 VECTOR Address used to extend BASIC.
defc SBRT		= $5CB9					; $5CB9 SBRT 10 bytes of Z80 code to Page ROM.
defc BAUD		= $5CC3					; $5CC3 BAUD =(3500000/(26*baud rate)) -2
defc NTSTAT		= $5CC5					; $5CC5 NTSTAT Own network station number.
defc IOBORD		= $5CC6					; $5CC6 IOBORD Border colour during I/O
defc SERFL		= $5CC7					; $5CC7 SER_FL 2 byte workspace used by RS232
defc SECTOR		= $5CC9					; $5CC9 SECTOR 2 byte workspace used by Microdrive.
defc CHADD_		= $5CCB					; $5CCB CHADD_ Temporary store for CH_ADD
defc NTRESP		= $5CCC					; $5CCC NTRESP Store for network response code.

defc NTDEST		= $5CCD					; $5CCD NTDEST Destination station number 0 - 64.
defc NTSRCE		= $5CCE					; $5CCE NTSRCE Source station number.
defc NTNUMB		= $5CD0					; $5CD0 NTNUMB Network block number 0 - 65535
defc NTTYPE		= $5CD2					; $5CD2 NTTYPE Header type block.
defc NTLEN		= $5CD3					; $5CD3 NTLEN Data block length 0 - 255.
defc NTDCS		= $5CD4					; $5CD4 NTDCS Data block checksum.
defc NTHDS		= $5CD5					; $5CD5 NTHDS Header block checksum.

defc DSTR1		= $5CD6					; $5CD6 D_STR1 2 byte drive number 1 - 8.
defc SSTR1		= $5CD8					; $5CD8 S_STR1 Stream number 1 - 15.
defc LSTR1		= $5CD9					; $5CD9 L_STR1 Device type "M", "N", "T" or "B"
defc NSTR1		= $5CDA					; $5CDA N-STR1 Length of filename.
										; $5CDC (dynamic) Address of filename.

defc DSTR2		= $5CDE					; $5CDE D_STR2 2 byte drive  File type.
										; $5CDF        number.       Length of
defc SSTR2		= $5CE0					; $5CE0 S_STR2 Stream number.Data.
defc LSTR2		= $5CE1					; $5CE1 L_STR2 Device type.  Start of
defc NSTR2		= $5CE2					; $5CE2 N-STR2 Length of     data.   \
										; $5CE3        filename.     Program  \
										; $5CE4 (dynamic) Address of length. Start of
										; $5CE5 (dynamic) filename           data.

defc HD00		= $5CE6					; $5CE6 HD_00 File type .      _
defc HD0B		= $5CE7					; $5CE7 HD_0B Length of data.   /\
defc HD0D		= $5CE9					; $5CE9 HD_0D Start of data.   /
defc HD0F		= $5CEB					; $5CEB HD_0F Program length. /
defc HD11		= $5CED					; $5CED HD_11 Line number.

defc COPIES		= $5CEF					; $5CEF COPIES Number of copies made by SAVE.

defc CHREC		= $0D	
defc CHDRIV		= $19					; Offset to DSTR1
defc HDNUMB		= $29	


; --------------------
; Spectrum 128 New System Variables
; --------------------
; These are held in the old ZX Printer buffer at $5B00-$5BFF.
; Note that some of these names conflict with the system variables used by the ZX Interface 1.

defc SWAP		= $5B00	  ; 20   Swap paging subroutine.
defc YOUNGER	= $5B14	  ;  9   Return paging subroutine.
defc ONERR		= $5B1D	  ; 18   Error handler paging subroutine.
defc PIN		= $5B2F	  ;  5   RS232 input pre-routine.
defc POUT		= $5B34	  ; 22   RS232 token output pre-routine. This can be patched to bypass the control code filter.
defc POUT2		= $5B4A	  ; 14   RS232 character output pre-routine.
defc TARGET		= $5B58	  ;  2   Address of subroutine to call in ROM 1.
defc RETADDR	= $5B5A	  ;  2   Return address in ROM 0.
defc BANK_M		= $5B5C	  ;  2   Copy of last byte output to I/O port $7FFD.
defc RAMRST		= $5B5D	  ;  1   Stores instruction RST $08 and used to produce a standard ROM error. Changing this instruction allows 128 BASIC to be extended (see end of this document for details).
defc RAMERR		= $5B5E	  ;  1   Error number for use by RST $08 held in RAMRST.
defc BAUD_2		= $5B5F	  ;  2   Baud rate timing constant for RS232 socket. Default value of 11. [Name clash with ZX Interface 1 system variable at $5CC3]
defc SERFL_2	= $5B61	  ;  2   Second character received flag:
                       ;        Bit 0   : 1=Character in buffer.
                       ;        Bits 1-7: Not used (always hold 0).
              ; $5B62  ;      Received Character.
defc COL		= $5B63	  ;  1   Current column from 1 to WIDTH.
defc WIDTH		= $5B64	  ;  1   Paper column width. Default value of 80. [Name clash with ZX Interface 1 Edition 2 system variable at $5CB1]
defc TVPARS		= $5B65	  ;  1   Number of inline parameters expected by RS232 (e.g. 2 for AT).
defc FLAGS3_2	= $5B66	  ;  1   Flags: [Name clashes with the ZX Interface 1 system variable at $5CB6]
                       ;        Bit 0: 1=BASIC/Calculator mode, 0=Editor/Menu mode.
                       ;        Bit 1: 1=Auto-run loaded BASIC program. [Set but never tested by the ROM]
                       ;        Bit 2: 1=Editing RAM disk catalogue.
                       ;        Bit 3: 1=Using RAM disk commands, 0=Using cassette commands.
                       ;        Bit 4: 1=Indicate LOAD.
                       ;        Bit 5: 1=Indicate SAVE.
                       ;        Bit 6; 1=Indicate MERGE.
                       ;        Bit 7: 1=Indicate VERIFY.
defc N_STR1		= $5B67	  ; 10   Used by RAM disk to store a filename. [Name clash with ZX Interface 1 system variable at $5CDA]
                       ;      Used by the renumber routine to store the address of the BASIC line being examined.
defc HD_00		= $5B71	  ;  1   Used by RAM disk to store file header information (see RAM disk Catalogue section below for details). [Name clash with ZX Interface 1 system variable at $5CE6]
                       ;      Used as column pixel counter in COPY routine.
                       ;      Used by FORMAT command to store specified baud rate.
                       ;      Used by renumber routine to store the number of digits in a pre-renumbered line number reference. [Name clash with ZX Interface 1 system variable at $5CE7]
defc HD_0B		= $5B72	  ;  2   Used by RAM disk to store header info - length of block.
                       ;      Used as half row counter in COPY routine.
                       ;      Used by renumber routine to generate ASCII representation of a new line number.
defc HD_0D		= $5B74	  ;  2   Used by RAM disk to store file header information (see RAM disk Catalogue section below for details). [Name clash with ZX Interface 1 system variable at $5CE9]
defc HD_0F		= $5B76	  ;  2   Used by RAM disk to store file header information (see RAM disk Catalogue section below for details). [Name clash with ZX Interface 1 system variable at $5CEB]
                       ;      Used by renumber routine to store the address of a referenced BASIC line.
defc HD_11		= $5B78	  ;  2   Used by RAM disk to store file header information (see RAM disk Catalogue section below for details). [Name clash with ZX Interface 1 system variable at $5CED]
                       ;      Used by renumber routine to store existing VARS address/current address within a line.
defc SC_00		= $5B7A	  ;  1   Used by RAM disk to store alternate file header information (see RAM disk Catalogue section below for details).
defc SC_0B		= $5B7B	  ;  2   Used by RAM disk to store alternate file header information (see RAM disk Catalogue section below for details).
defc SC_0D		= $5B7D	  ;  2   Used by RAM disk to store alternate file header information (see RAM disk Catalogue section below for details).
defc SC_0F		= $5B7F	  ;  2   Used by RAM disk to store alternate file header information (see RAM disk Catalogue section below for details).
defc OLDSP		= $5B81	  ;  2   Stores old stack pointer when TSTACK in use.
defc SFNEXT		= $5B83	  ;  2   End of RAM disk catalogue marker. Pointer to first empty catalogue entry.
defc SFSPACE	= $5B85	  ;  3   Number of bytes free in RAM disk (3 bytes, 17 bit, LSB first).
defc ROW01		= $5B88	  ;  1   Stores keypad data for row 3, and flags:
                       ;        Bit 0   : 1=Key '+' pressed.
                       ;        Bit 1   : 1=Key '6' pressed.
                       ;        Bit 2   : 1=Key '5' pressed.
                       ;        Bit 3   : 1=Key '4' pressed.
                       ;        Bits 4-5: Always 0.
                       ;        Bit 6   : 1=Indicates successful communications to the keypad.
                       ;        Bit 7   : 1=If communications to the keypad established.
defc ROW23		= $5B89	  ;  1   Stores keypad key press data for rows 1 and 2:
                       ;        Bit 0: 1=Key ')' pressed.
                       ;        Bit 1: 1=Key '(' pressed.
                       ;        Bit 2: 1=Key '*' pressed.
                       ;        Bit 3: 1=Key '/' pressed.
                       ;        Bit 4: 1=Key '-' pressed.
                       ;        Bit 5: 1=Key '9' pressed.
                       ;        Bit 6: 1=Key '8' pressed.
                       ;        Bit 7: 1=Key '7' pressed.
defc ROW45		= $5B8A	  ;  1   Stores keypad key press data for rows 4 and 5:
                       ;        Bit 0: Always 0.
                       ;        Bit 1: 1=Key '.' pressed.
                       ;        Bit 2: Always 0.
                       ;        Bit 3: 1=Key '0' pressed.
                       ;        Bit 4: 1=Key 'ENTER' pressed.
                       ;        Bit 5: 1=Key '3' pressed.
                       ;        Bit 6: 1=Key '2' pressed.
                       ;        Bit 7: 1=Key '1' pressed.
defc SYNRET		= $5B8B	  ;  2   Return address for ONERR routine.
defc LASTV		= $5B8D	  ;  5   Last value printed by calculator.
defc RNLINE		= $5B92	  ;  2   Address of the length bytes in the line currently being renumbered.
defc RNFIRST	= $5B94	  ;  2   Starting line number when renumbering. Default value of 10.
defc RNSTEP		= $5B96	  ;  2   Step size when renumbering. Default value of 10.
defc STRIP1		= $5B98	  ; 32   Used as RAM disk transfer buffer (32 bytes to $5BB7).
                       ;      Used to hold Sinclair stripe character patterns (16d bytes to $5BA7).
                       ;      ...
defc TSTACK		= $5BFF	  ;  n   Temporary stack (grows downwards). The byte at $5BFF is not actually used.
