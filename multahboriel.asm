
SECTION asm_lib
PUBLIC MULTAHBORIEL

;EXTERN PAPERG

;INCLUDE "../../z88dk-zxspectrum-equates.asm"

.MULTAHBORIEL
;__MUL8_FAST: ; __FASTCALL__ ENTRY, A = A * H (8 bit mul) and carry

    LD B, 8
    LD L, A
    XOR A

__MUL8LOOP:
    ADD A, A ; A *= 2
    SLA L
    JP NC, __MUL8B
    ADD A, H

__MUL8B:
    DJNZ __MUL8LOOP

    RET		; RESULT = HL
