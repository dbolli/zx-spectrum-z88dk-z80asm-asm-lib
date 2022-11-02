
SECTION asm_lib
PUBLIC DETECT128K

;EXTERN INKN

;INCLUDE "../../z88dk-zxspectrum-equates.asm"

.DETECT128K
			LD A,(75)
			CP 191
			JR NZ,DETECT128KEXIT		; Z flag reset on exit = 128K not detected

			LD A,(23611)					; $5C3B Flags Sys Var
			AND %00010000
			JR NZ,DETECT128KEXIT
			
			XOR A					; Z flag set on exit = 128K detected
			
.DETECT128KEXIT
			RET
