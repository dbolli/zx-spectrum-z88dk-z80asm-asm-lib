
SECTION asm_lib
PUBLIC GETKEY
PUBLIC GETK2

EXTERN GETPRADDR
EXTERN PRSTRNG2

INCLUDE "../../z88dk-zxspectrum-equates.asm"

; . . . . . . . . . . .
; GetKey
;*/

.GETKEY		LD B,22
			LD C,2
			CALL GETPRADDR
			LD DE,GETKEYMESS
			CALL PRSTRNG2

.GETK2		XOR A					; Added second entry point to wait for keypress
			LD (LASTK),A
if 0
.GKLP1		HALT
else
GKLP1:		CALL KEYBOARD			; :dbolli:20220222 11:10:49 Added as will work with DI active (called by MASKINT)
endif
			LD A,(LASTK)
			AND A
			JR Z,GKLP1
			RET

SECTION asm_lib_data

.GETKEYMESS	defb	$CD
			defm	"Press any key to continue.."
			defb	'.' + $80
