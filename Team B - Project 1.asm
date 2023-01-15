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
   CALL DISPLAY
   MOV BUFF, 2
   MOV DX, 2005H
   CALL DISPLAY
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
;MOV DH,0
MOV AH, 2AH
INT 21H
MOV AL, DH
AAM
MOV BX, AX
    MOV BUFF, 1
    MOV DX, 200FH
    CALL DISPLAY
    MOV BUFF, 2
    MOV DX, 2014H
    CALL DISPLAY
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
    CALL DISPLAY
    MOV BUFF, 2
    MOV DX, 2023H
    CALL DISPLAY

    


MOV AH, 4CH
INT 21H

DISPLAY PROC
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
DISPLAY ENDP

        
BUFF DB ?,"$"    
 
;0-9 digits  
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