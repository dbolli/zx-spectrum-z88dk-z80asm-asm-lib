
SECTION asm_lib
PUBLIC OURPIXADD2

EXTERN PRINTREG
;EXTERN OURPIXADD

INCLUDE "../../z88dk-zxspectrum-equates.asm"

.OURPIXADD2
;//			LD A,175					;// DB020919 14:06 Pixel Address from ROM with our error checking
;//			LD A,175					;// DB020919 14:09 175 $AF
			LD A,191					;// DB020919 14:09 191 $BF
;//			LD A,207					;// DB020919 14:09 207 $CF
			SUB B
			PUSH	AF					;// DB020920 18:03 Save AF
			LD A,(COORDS+1)			;// DB020920 18:03 
			LD D,A					;// DB020920 18:03 
			LD A,(COORDS)				;// DB020920 18:04 
			LD E,A					;// DB020920 18:04 
			POP AF					;// DB020920 18:03 Restore AF
			JP C,PRINTREG				;// DB020919 14:07 Flag a range err
			LD B,A
			AND A
			RRA
			SCF
			RRA
			AND A
			RRA
			XOR B
			AND @11111000				;// DB020919 14:10 $F8
			XOR B
			LD H,A
			LD A,C
			RLCA
			RLCA
			RLCA
			XOR B
			AND @11000111				;// DB020919 14:12 $C7
			XOR B
			RLCA
			RLCA
			LD L,A
			LD A,C
			AND @00000111				;// DB020919 14:14 $07
			RET
