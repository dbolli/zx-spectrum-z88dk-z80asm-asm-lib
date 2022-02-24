
SECTION asm_lib
PUBLIC DECY

;EXTERN OURPIXADD

;INCLUDE "../../z88dk-zxspectrum-equates.asm"

.DECY 						; :dbolli:20161009 13:02:10 As per http://www.animatez.co.uk/programming/assembly-language/z80/z80-library-routines/output-asm/
                            ; Move HL up one pixel line
            DEC H           ; Go up onto the next pixel line
            LD A,H          ; Check if we have gone onto the next character boundary
            AND $07
            CP $07
            RET NZ
            LD A,L
            SUB 32
            LD L,A
            RET C
            LD A,H
            ADD A,$08
            LD H,A
            RET
