
SECTION asm_lib
PUBLIC TABLEPIXADD

EXTERN PRINTREG
;EXTERN OURPIXADD							; Define in main calling asm routine

INCLUDE "../../z88dk-zxspectrum-equates.asm"

; . . . . . . . . . . .
; Calculate Pixel Address using Table of Display File Addresses
;
; On Entry (same as ROM PIXADD routine at $22AA):
;   B = Y Pixel Coordinate (0..191)
;   C = X Pixel Coordinate (0..255)
;
; On Exit (same as ROM PIXADD routine at $22AA):
;   HL = Display file address ($4000..$57FF)
;   A = Pixel offset (0..7)
;

;.OURPIXADD

.TABLEPIXADD                        ; :dbolli:20140504 11:13:00 On Entry C = xcoord, B = ycoord
;			LD A,175				; :dbolli:20140504 11:13:00 $AF
			LD A,191				; :dbolli:20140504 11:13:00 $BF
;			LD A,207				; :dbolli:20140504 11:13:00 $CF
			SUB B
;            JP C,REPORT-B           ; :dbolli:20140610 17:07:32 $24F9 REPORT-B Flag a range err via ROM $24F9 or $046C REPORT-B
			JP C,PRINTREG			; :dbolli:20140504 11:13:00 Flag a range err
            LD HL,PIXELADDRESSTBL   ; :dbolli:20140504 11:13:00 Base address of pixel address table (0-175)
            LD D,$00
            LD E,B
            AND A                   ; :dbolli:20140504 11:13:00 Clear carry flag
            RL E
            RL D                    ; :dbolli:20140504 11:13:00 DE = B * 2
            ADD HL,DE               ; :dbolli:20140504 11:13:00 HL = table row address
            EX DE,HL                ; :dbolli:20140504 11:13:00 DE = table row address
            LD A,(DE)
            LD L,A
            INC DE
            LD A,(DE)
            LD H,A                  ; :dbolli:20140504 11:13:00 HL = screen row address
            LD A,C
;            AND A                   ; :dbolli:20140504 11:13:00 Clear carry flag
            RRA
;            AND A
            RRA
;            AND A
            RRA                     ; :dbolli:20140504 11:13:00 A = C DIV 8 = Pixel byte address offset
            AND @00011111           ; :dbolli:20140610 17:10:37 $1F to avoid clearing carry flag. Suggested by Einar S.
            LD D,$00
            LD E,A
;            CALL PRINTREG           ; :dbolli:20140504 10:29:37 DEBUG
            ADD HL,DE               ; :dbolli:20140504 11:13:00 HL = screen pixel byte address
;            CALL PRINTREG           ; :dbolli:20140504 10:29:37 DEBUG
            LD A,C
            AND $07                 ; :dbolli:20140504 11:13:00 A = C MOD 8 = Pixel offset
            RET

SECTION asm_lib_data

.PIXELADDRESSTBL
            defw $57E0,$56E0,$55E0,$54E0,$53E0,$52E0,$51E0,$50E0
            defw $57C0,$56C0,$55C0,$54C0,$53C0,$52C0,$51C0,$50C0
            defw $57A0,$56A0,$55A0,$54A0,$53A0,$52A0,$51A0,$50A0
            defw $5780,$5680,$5580,$5480,$5380,$5280,$5180,$5080
            defw $5760,$5660,$5560,$5460,$5360,$5260,$5160,$5060
            defw $5740,$5640,$5540,$5440,$5340,$5240,$5140,$5040
            defw $5720,$5620,$5520,$5420,$5320,$5220,$5120,$5020
            defw $5700,$5600,$5500,$5400,$5300,$5200,$5100,$5000
            defw $4FE0,$4EE0,$4DE0,$4CE0,$4BE0,$4AE0,$49E0,$48E0
            defw $4FC0,$4EC0,$4DC0,$4CC0,$4BC0,$4AC0,$49C0,$48C0
            defw $4FA0,$4EA0,$4DA0,$4CA0,$4BA0,$4AA0,$49A0,$48A0
            defw $4F80,$4E80,$4D80,$4C80,$4B80,$4A80,$4980,$4880
            defw $4F60,$4E60,$4D60,$4C60,$4B60,$4A60,$4960,$4860
            defw $4F40,$4E40,$4D40,$4C40,$4B40,$4A40,$4940,$4840
            defw $4F20,$4E20,$4D20,$4C20,$4B20,$4A20,$4920,$4820
            defw $4F00,$4E00,$4D00,$4C00,$4B00,$4A00,$4900,$4800
            defw $47E0,$46E0,$45E0,$44E0,$43E0,$42E0,$41E0,$40E0
            defw $47C0,$46C0,$45C0,$44C0,$43C0,$42C0,$41C0,$40C0
            defw $47A0,$46A0,$45A0,$44A0,$43A0,$42A0,$41A0,$40A0
            defw $4780,$4680,$4580,$4480,$4380,$4280,$4180,$4080
            defw $4760,$4660,$4560,$4460,$4360,$4260,$4160,$4060
            defw $4740,$4640,$4540,$4440,$4340,$4240,$4140,$4040
            defw $4720,$4620,$4520,$4420,$4320,$4220,$4120,$4020
            defw $4700,$4600,$4500,$4400,$4300,$4200,$4100,$4000
