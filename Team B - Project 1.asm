;TEAM B - Oloroso, Barrios, Manansala

org 100h

;GET DAY
MOV AH,2AH    
INT 21H
MOV AL,DL     
AAM
MOV BX,AX
   MOV BUFF, 1
   MOV DX, 2000H
   CALL DISPLAYDATE
   MOV BUFF, 2
   MOV DX, 2005H
   CALL DISPLAYDATE
   MOV DX, 200AH
   MOV SI, 0
   MOV CX, 5
   NEXTDAY:
    MOV AL, DOTSn[SI]
    OUT DX, AL
    INC SI
    INC DX
    LOOP NEXTDAY

;GET MONTH
MOV AH, 2AH
INT 21H
MOV AL, DH
AAM
MOV BX, AX
    MOV BUFF, 1
    MOV DX, 200FH
    CALL DISPLAYDATE
    MOV BUFF, 2
    MOV DX, 2014H
    CALL DISPLAYDATE
    MOV DX, 2019H
    MOV SI, 0
    MOV CX, 5
    NEXTMONTH:
    MOV AL, DOTSn[SI]
    OUT DX, AL
    INC SI
    INC DX
    LOOP NEXTMONTH
    
;GET YEAR
MOV AH, 2AH
INT 21H
ADD CX, 0F830H
MOV AX, CX
AAM
MOV BX, AX
    MOV BUFF, 1
    MOV DX, 201EH
    CALL DISPLAYDATE
    MOV BUFF, 2
    MOV DX, 2023H
    CALL DISPLAYDATE

;GET HOUR
MOV AH, 2CH
INT 21H
MOV AL, CH
AAM
MOV BX, AX
    MOV BUFF, 1
    MOV DX, 2030H
    CALL DISPLAYTIME
    MOV BUFF, 2
    MOV DX, 2031H
    CALL DISPLAYTIME
MOV DX, 2032H
MOV AL, LINEn
OUT DX, AL

;GET MINUTE
MOV AH, 2CH
INT 21H
MOV AL, CL
AAM
MOV BX, AX
    MOV BUFF, 1
    MOV DX, 2033H
    CALL DISPLAYTIME
    MOV BUFF, 2
    MOV DX, 2034H
    CALL DISPLAYTIME
MOV DX, 2035H
MOV AL, LINEn
OUT DX, AL

;GET SECONDS
MOV AH, 2CH
INT 21H
MOV AL, DH
AAM
MOV BX, AX
    MOV BUFF, 1
    MOV DX, 2036H
    CALL DISPLAYTIME
    MOV BUFF, 2
    MOV DX, 2037H
    CALL DISPLAYTIME
    


MOV AH, 4CH
INT 21H

DISPLAYDATE PROC
    MOV SI, 0
    MOV CX, 5
    CMP BUFF, 2
        JE HERE
    CMP BH, 00H
    JG IF1
    NEXT0: 
        MOV AL, DOTS0[SI]
        OUT DX, AL
        INC SI
        INC DX
        LOOP NEXT0
        JMP DONE
    IF1:
        CMP BH,02H
        JGE IF2
        NEXT1:
            MOV AL, DOTS1[SI]
            OUT DX, AL
            INC SI
            INC DX
            LOOP NEXT1
            JMP DONE
    IF2:
        CMP BH,03H
        JGE IF3
        NEXT2:
            MOV AL, DOTS2[SI]
            OUT DX, AL
            INC SI
            INC DX
            LOOP NEXT2
            JMP DONE
    IF3:
        CMP BH,04H
        JGE IF4
        NEXT3:
            MOV AL, DOTS3[SI]
            OUT DX, AL
            INC SI
            INC DX
            LOOP NEXT3
            JMP DONE
    IF4:
        CMP BH,05H
        JGE IF5
        NEXT4:
            MOV AL, DOTS4[SI]
            OUT DX, AL
            INC SI
            INC DX
            LOOP NEXT4
            JMP DONE
    IF5:
        CMP BH,06H
        JGE IF6
        NEXT5:
            MOV AL, DOTS5[SI]
            OUT DX, AL
            INC SI
            INC DX
            LOOP NEXT5
            JMP DONE 
    IF6:
        CMP BH,07H
        JGE IF7
        NEXT6:
            MOV AL, DOTS6[SI]
            OUT DX, AL
            INC SI
            INC DX
            LOOP NEXT6
            JMP DONE    
    IF7:
        CMP BH,08H
        JGE IF8
        NEXT7:
            MOV AL, DOTS7[SI]
            OUT DX, AL
            INC SI
            INC DX
            LOOP NEXT7
            JMP DONE
    IF8:
        CMP BH,09H
        JGE IF9
        NEXT8:
            MOV AL, DOTS8[SI]
            OUT DX, AL
            INC SI
            INC DX
            LOOP NEXT8
            JMP DONE
    IF9:
    NEXT9:
        MOV AL, DOTS9[SI]
        OUT DX, AL
        INC SI
        INC DX
        LOOP NEXT9
        JMP DONE
HERE:
    CMP BL, 00H
    JG IFF1
    NEXTT0: 
        MOV AL, DOTS0[SI]
        OUT DX, AL
        INC SI
        INC DX
        LOOP NEXTT0
        JMP DONE
    IFF1:
        CMP BL,02H
        JGE IFF2
        NEXTT1:
            MOV AL, DOTS1[SI]
            OUT DX, AL
            INC SI
            INC DX
            LOOP NEXTT1
            JMP DONE
    IFF2:
        CMP BL,03H
        JGE IFF3
        NEXTT2:
            MOV AL, DOTS2[SI]
            OUT DX, AL
            INC SI
            INC DX
            LOOP NEXTT2
            JMP DONE
    IFF3:
        CMP BL,04H
        JGE IFF4
        NEXTT3:
            MOV AL, DOTS3[SI]
            OUT DX, AL
            INC SI
            INC DX
            LOOP NEXTT3
            JMP DONE
    IFF4:
        CMP BL,05H
        JGE IFF5
        NEXTT4:
            MOV AL, DOTS4[SI]
            OUT DX, AL
            INC SI
            INC DX
            LOOP NEXTT4
            JMP DONE
    IFF5:
        CMP BL,06H
        JGE IFF6
        NEXTT5:
            MOV AL, DOTS5[SI]
            OUT DX, AL
            INC SI
            INC DX
            LOOP NEXTT5
            JMP DONE 
    IFF6:
        CMP BL,07H
        JGE IFF7
        NEXTT6:
            MOV AL, DOTS6[SI]
            OUT DX, AL
            INC SI
            INC DX
            LOOP NEXTT6
            JMP DONE    
    IFF7:
        CMP BL,08H
        JGE IFF8
        NEXTT7:
            MOV AL, DOTS7[SI]
            OUT DX, AL
            INC SI
            INC DX
            LOOP NEXTT7
            JMP DONE
    IFF8:
        CMP BL,09H
        JGE IFF9
        NEXTT8:
            MOV AL, DOTS8[SI]
            OUT DX, AL
            INC SI
            INC DX
            LOOP NEXTT8
            JMP DONE
    IFF9:
    NEXTT9:
        MOV AL, DOTS9[SI]
        OUT DX, AL
        INC SI
        INC DX
        LOOP NEXTT9
        JMP DONE
            
DONE:   
RET
DISPLAYDATE ENDP

DISPLAYTIME PROC
    CMP BUFF, 2
        JE HERETIME
    CMP BH, 00H
        JG IFT1
    MOV AL, LINE0
    OUT DX, AL
    JMP DONETIME
    IFT1:
        CMP BH, 02H
            JGE IFT2
        MOV AL, LINE1
        OUT DX, AL
        JMP DONETIME
    IFT2:
        CMP BH, 03H
            JGE IFT3
        MOV AL, LINE2
        OUT DX, AL
        JMP DONETIME
    IFT3:
        CMP BH, 04H
            JGE IFT4
        MOV AL, LINE3
        OUT DX, AL
        JMP DONETIME
    IFT4:
        CMP BH, 05H
            JGE IFT5
        MOV AL, LINE4
        OUT DX, AL
        JMP DONETIME
    IFT5:
        CMP BH, 06H
            JGE IFT6
        MOV AL, LINE5
        OUT DX, AL
        JMP DONETIME
    IFT6:
        CMP BH, 07H
            JGE IFT7
        MOV AL, LINE6
        OUT DX, AL
        JMP DONETIME
    IFT7:
        CMP BH, 08H
            JGE IFT8
        MOV AL, LINE7
        OUT DX, AL
        JMP DONETIME
    IFT8:
        CMP BH, 09H
            JGE IFT9
        MOV AL, LINE8
        OUT DX, AL
        JMP DONETIME    
    IFT9:
        MOV AL, LINE9
        OUT DX, AL
        JMP DONETIME
    
HERETIME:
    CMP BL, 00H
        JG IFFT1
    MOV AL, LINE0
    OUT DX, AL
    JMP DONETIME
    IFFT1:
        CMP BL, 02H
            JGE IFFT2
        MOV AL, LINE1
        OUT DX, AL 
        JMP DONETIME
    IFFT2:
        CMP BL, 03H
            JGE IFFT3
        MOV AL, LINE2
        OUT DX, AL   
        JMP DONETIME
    IFFT3:
        CMP BL, 04H
            JGE IFFT4
        MOV AL, LINE3
        OUT DX, AL
        JMP DONETIME
    IFFT4:
        CMP BL, 05H
            JGE IFFT5
        MOV AL, LINE4
        OUT DX, AL 
        JMP DONETIME
    IFFT5:
        CMP BL, 06H
            JGE IFFT6
        MOV AL, LINE5
        OUT DX, AL 
        JMP DONETIME
    IFFT6:
        CMP BL, 07H
            JGE IFFT7
        MOV AL, LINE6
        OUT DX, AL 
        JMP DONETIME
    IFFT7:
        CMP BL, 08H
            JGE IFFT8
        MOV AL, LINE7
        OUT DX, AL  
        JMP DONETIME
    IFFT8:
        CMP BL, 09H
            JGE IFFT9
        MOV AL, LINE8
        OUT DX, AL
        JMP DONETIME    
    IFFT9:
        MOV AL, LINE9
        OUT DX, AL 
        JMP DONETIME   

DONETIME:
RET
DISPLAYTIME ENDP

        
BUFF DB ?,"$"    
 
;0-9 DIGITS DOT MATRIX  
DOTS0 DB 00111110b, 01000001b, 01000001b, 01000001b, 00111110b,
DOTS1 DB 01000100b, 01000010b, 01111111b, 01000000b, 01000000b,
DOTS2 DB 01100110b, 01010001b, 01010001b, 01010001b, 01001110b,
DOTS3 DB 00100010b, 01000001b, 01001001b, 01001001b, 00110110b,
DOTS4 DB 00001000b, 00001100b, 00001010b, 00001001b, 01111111b,
DOTS5 DB 01001111b, 01001001b, 01001001b, 01001001b, 00110001b,
DOTS6 DB 00111110b, 01001001b, 01001001b, 01001001b, 00110010b,
DOTS7 DB 00000011b, 00000001b, 01110001b, 00001001b, 00000111b,
DOTS8 DB 00110110b, 01001001b, 01001001b, 01001001b, 00110110b,
DOTS9 DB 00100110b, 01001001b, 01001001b, 01001001b, 00111110b,
DOTSn DB 00001000b, 00001000b, 00001000b, 00001000b, 00001000b

;0-9 DIGITS SEVEN SEGMENT
LINE0 DB 00111111b,
LINE1 DB 00000110b,
LINE2 DB 01011011b,
LINE3 DB 01001111b,
LINE4 DB 01100110b,
LINE5 DB 01101101b,
LINE6 DB 01111101b,
LINE7 DB 00000111b,
LINE8 DB 01111111b,
LINE9 DB 01101111b,
LINEn DB 10000000b
