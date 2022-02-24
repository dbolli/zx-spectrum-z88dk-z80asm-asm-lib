
SECTION asm_lib
PUBLIC INVERT

;EXTERN PAPERG

INCLUDE "../../z88dk-zxspectrum-equates.asm"

.INVERT     LD HL,ATTRS             ; Invert PAPER and INK values in ATTR file
;            LD BC,$02FF				; The length of the attribute file
            LD BC,$0300				; The length of the attribute file
.INVLP1     LD A,(HL)
            PUSH AF
            AND @11000000           ; $A0 mask off flash and bright bits
            LD D,A
            POP AF
            PUSH AF
            AND @00000111           ; $07 mask off ink
            RLCA
            RLCA
            RLCA                    ; Convert to paper
            LD E,A
            POP AF
            AND @00111000           ; $38 mask off paper
            RRCA
            RRCA
            RRCA                    ; Convert to ink
            OR E                    ; Recombine new paper
            OR D                    ; Recombine old flash and bright
            LD (HL),A
            INC HL
            DEC BC
            LD A,B
            OR C
            JR NZ,INVLP1
            RET
