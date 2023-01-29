;TEAM B - Oloroso, Barrios, Manansala
#START=PRINTER.EXE#
#START=THERMOMETER.EXE#
org 100h

;CREATE DIRECTORY & FILE
MOV AX, CS
MOV DX, AX
MOV ES, AX
MOV DX, OFFSET DIR
MOV AH, 39H
INT 21H 

MOV AH, 3CH
MOV CX, 0
MOV DX, OFFSET FILE
INT 21H
MOV HANDLE, AX
    
INFILOOP:
CALL CHECKTEMP   
;GET DAY
MOV AH,2AH    
INT 21H
MOV AL,DL     
AAM
MOV BX,AX
   MOV BUFF, 1  
   MOV DAY, 1
   MOV MONTH, 0
   MOV YEAR, 0
   MOV DX, 2000H
   CALL DISPLAYDATE 
   MOV BUFF, 2
   MOV DX, 2005H
   CALL DISPLAYDATE
   CALL CHECKTEMP
   MOV DX, 200AH
   MOV SI, 0
   MOV CX, 5
   NEXTDAY:
    MOV AL, DOTSn[SI]
    OUT DX, AL
    INC SI
    INC DX
    LOOP NEXTDAY
CALL CHECKTEMP 
;GET MONTH 
MOV AH, 2AH
INT 21H
MOV AL, DH
AAM
MOV BX, AX       
    MOV BUFF, 1
    MOV DX, 200FH  
    MOV DAY, 0
    MOV MONTH, 1
    MOV YEAR, 0
    CALL DISPLAYDATE
    MOV BUFF, 2
    MOV DX, 2014H
    CALL DISPLAYDATE
    CALL CHECKTEMP
    MOV DX, 2019H
    MOV SI, 0
    MOV CX, 5
    NEXTMONTH:
    MOV AL, DOTSn[SI]
    OUT DX, AL
    INC SI
    INC DX
    LOOP NEXTMONTH
CALL CHECKTEMP     
;GET YEAR
MOV AH, 2AH
INT 21H
ADD CX, 0F830H
MOV AX, CX
AAM
MOV BX, AX
    MOV BUFF, 1 
    MOV DAY, 0
    MOV MONTH, 0
    MOV YEAR, 1
    MOV DX, 201EH
    CALL DISPLAYDATE
    MOV BUFF, 2
    MOV DX, 2023H
    CALL DISPLAYDATE
CALL CHECKTEMP     
;GET HOUR
MOV AH, 2CH
INT 21H
MOV AL, CH
AAM
MOV BX, AX
    MOV BUFF, 1
    MOV HOUR, 1
    MOV MINUTE, 0
    MOV SECOND, 0
    MOV DX, 2030H
    CALL DISPLAYTIME
    MOV BUFF, 2
    MOV DX, 2031H
    CALL DISPLAYTIME
    CALL CHECKTIME
MOV DX, 2032H
MOV AL, LINEn
OUT DX, AL
CALL CHECKTEMP 
;GET MINUTE
MOV AH, 2CH
INT 21H
MOV AL, CL
AAM
MOV BX, AX
    MOV BUFF, 1
    MOV HOUR, 0
    MOV MINUTE, 1
    MOV SECOND, 0
    MOV DX, 2033H
    CALL DISPLAYTIME
    MOV BUFF, 2
    MOV DX, 2034H
    CALL DISPLAYTIME
MOV DX, 2035H
MOV AL, LINEn
OUT DX, AL
CALL CHECKTEMP 
;GET SECONDS
MOV AH, 2CH
INT 21H
MOV AL, DH
AAM
MOV BX, AX
    MOV BUFF, 1
    MOV HOUR, 0
    MOV MINUTE, 0
    MOV SECOND, 1
    MOV DX, 2036H
    CALL DISPLAYTIME
    MOV BUFF, 2
    MOV DX, 2037H
    CALL DISPLAYTIME 
CALL CHECKTEMP 
CMP ISWATERED, 1
    JL INFILOOP
CALL SAVELOGS
MOV ISWATERED, 0
JMP INFILOOP
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
        CMP DAY, 1
            JL IFMONTH0
        MOV DAY1, '0'
        JMP DONE
    IFMONTH0:
        CMP MONTH, 1
            JL ISYEAR0
        MOV MONTH1, '0'
        JMP DONE
    ISYEAR0:
        MOV YEAR1, '0'
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
            CMP DAY, 1
                JL IFMONTH1
            MOV DAY1, '1'
            JMP DONE
        IFMONTH1:
            CMP MONTH, 1
                JL ISYEAR1
            MOV MONTH1, '1'
            JMP DONE
        ISYEAR1:
            MOV YEAR1, '1'
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
            CMP DAY, 1
                JL IFMONTH2
            MOV DAY1, '2'
            JMP DONE
        IFMONTH2:
            CMP MONTH,2
                JL ISYEAR2
            MOV MONTH1, '2'
            JMP DONE
        ISYEAR2:
            MOV YEAR1, '2'
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
            CMP DAY, 1
                JL IFMONTH3
            MOV DAY1, '3'
            JMP DONE
        IFMONTH3:
            CMP MONTH, 1
                JL ISYEAR3
            MOV MONTH1, '3'
            JMP DONE
        ISYEAR3:
            MOV YEAR1, '3'
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
            CMP DAY, 1
                JL IFMONTH4
            MOV DAY1, '4'
            JMP DONE
        IFMONTH4:
            CMP MONTH, 1
                JL ISYEAR4
            MOV MONTH1, '4'
            JMP DONE
        ISYEAR4:
            MOV YEAR1, '4'
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
            CMP DAY, 1
                JL IFMONTH5
            MOV DAY1, '5'
            JMP DONE
        IFMONTH5:
            CMP MONTH, 1
                JL ISYEAR5
            MOV MONTH1, '5'
            JMP DONE
        ISYEAR5:
            MOV YEAR1, '5'
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
            CMP DAY, 1
                JL IFMONTH6
            MOV DAY1, '6'
            JMP DONE
        IFMONTH6:
            CMP MONTH, 1
                JL ISYEAR6
            MOV MONTH1, '6'
            JMP DONE
        ISYEAR6:
        MOV YEAR1, '6'
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
            CMP DAY, 1
                JL IFMONTH7
            MOV DAY1, '7'
            JMP DONE
        IFMONTH7:
            CMP MONTH, 1
                JL ISYEAR7
            MOV MONTH1, '7'
            JMP DONE
        ISYEAR7:
            MOV YEAR1, '7'
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
            CMP DAY, 1
                JL IFMONTH8
            MOV DAY1, '8'
            JMP DONE
        IFMONTH8:
            CMP MONTH, 1
                JL ISYEAR8
            MOV MONTH1, '8'
            JMP DONE
        ISYEAR8:
            MOV YEAR1, '8'
            JMP DONE
    IF9:
    NEXT9:
        MOV AL, DOTS9[SI]
        OUT DX, AL
        INC SI
        INC DX
        LOOP NEXT9
        CMP DAY, 1
            JL IFMONTH9
        MOV DAY1, '9'
        JMP DONE
    IFMONTH9:
        CMP MONTH, 1
            JL ISYEAR9
        MOV MONTH1, '9'
        JMP DONE
    ISYEAR9:
        MOV YEAR1, '9'
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
        CMP DAY, 1
            JL IFMONTH00
        MOV DAY2, '0'
        JMP DONE
    IFMONTH00:
        CMP MONTH, 1
            JL ISYEAR00
        MOV MONTH2, '0'
        JMP DONE
    ISYEAR00:
        MOV YEAR2, '0'
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
            CMP DAY, 1
                JL IFMONTH01
            MOV DAY2, '1'
            JMP DONE
        IFMONTH01:
            CMP MONTH, 1
                JL ISYEAR01
            MOV MONTH2, '1'
            JMP DONE
        ISYEAR01:
            MOV YEAR2, '1'
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
            CMP DAY, 1
                JL IFMONTH02
            MOV DAY2, '2'
            JMP DONE
        IFMONTH02:
            CMP MONTH, 1
                JL ISYEAR02
            MOV MONTH2, '2'
            JMP DONE
        ISYEAR02:
            MOV YEAR2, '2'
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
            CMP DAY, 1
                JL IFMONTH03
            MOV DAY2, '3'
            JMP DONE
        IFMONTH03:
            CMP MONTH, 1
                JL ISYEAR03
            MOV MONTH2, '3'
            JMP DONE
        ISYEAR03:
            MOV YEAR2, '3'
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
            CMP DAY, 1
                JL IFMONTH04
            MOV DAY2, '4'
            JMP DONE
        IFMONTH04:
            CMP MONTH, 1
                JL ISYEAR04
            MOV MONTH2, '4'
            JMP DONE
        ISYEAR04:
            MOV YEAR2, '4'
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
            CMP DAY, 1
                JL IFMONTH05
            MOV DAY2, '5'
            JMP DONE
        IFMONTH05:
            CMP MONTH, 1
                JL ISYEAR05
            MOV MONTH2, '5'
            JMP DONE
        ISYEAR05:
            MOV YEAR2, '5'
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
            CMP DAY, 1
                JL IFMONTH06
            MOV DAY2, '6'
            JMP DONE
        IFMONTH06:
            CMP MONTH, 1
                JL ISYEAR06
            MOV MONTH2, '6'
            JMP DONE
        ISYEAR06:
            MOV YEAR2, '6'
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
            CMP DAY, 1
                JL IFMONTH07
            MOV DAY2, '7'
            JMP DONE
        IFMONTH07:
            CMP MONTH, 1
                JL ISYEAR07
            MOV MONTH2, '7'
            JMP DONE
        ISYEAR07:
            MOV YEAR2, '7'
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
            CMP DAY, 1
                JL IFMONTH08
            MOV DAY2, '8'
            JMP DONE
        IFMONTH08:
            CMP MONTH, 1
                JL ISYEAR08
            MOV MONTH2, '8'
            JMP DONE
        ISYEAR08:
            MOV YEAR2, '8'
            JMP DONE
    IFF9:
    NEXTT9:
        MOV AL, DOTS9[SI]
        OUT DX, AL
        INC SI
        INC DX
        LOOP NEXTT9
        CMP DAY, 1
            JL IFMONTH09
        MOV DAY2, '9'
        JMP DONE
    IFMONTH09:
        CMP MONTH, 1
            JL ISYEAR09
        MOV MONTH2, '9'
        JMP DONE
    ISYEAR09:
        MOV YEAR2, '9'
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
        CMP HOUR, 1
            JL CHECKMINUTE0
        MOV HOUR1, '0'
        JMP DONETIME
    CHECKMINUTE0:
        CMP MINUTE, 1
            JL ISSECOND0
        MOV MINUTE1, '0'
        JMP DONETIME
    ISSECOND0:   
        MOV SECOND1, '0'
    JMP DONETIME
    IFT1:
        CMP BH, 02H
            JGE IFT2
        MOV AL, LINE1
        OUT DX, AL  
        CMP HOUR, 1
            JL CHECKMINUTE1
        MOV HOUR1, '1'
        JMP DONETIME
    CHECKMINUTE1:
        CMP MINUTE, 1
            JL ISSECOND1
        MOV MINUTE1, '1'
        JMP DONETIME
    ISSECOND1:       
        MOV SECOND1, '1'        
        JMP DONETIME
    IFT2:
        CMP BH, 03H
            JGE IFT3
        MOV AL, LINE2
        OUT DX, AL
        CMP HOUR, 1
            JL CHECKMINUTE2
        MOV HOUR1, '2'
        JMP DONETIME
    CHECKMINUTE2:
        CMP MINUTE, 1
            JL ISSECOND2
        MOV MINUTE1, '2'
        JMP DONETIME
    ISSECOND2:   
        MOV SECOND1, '2' 
        JMP DONETIME
    IFT3:
        CMP BH, 04H
            JGE IFT4
        MOV AL, LINE3
        OUT DX, AL
        CMP HOUR, 1
            JL CHECKMINUTE3
        MOV HOUR1, '3'
        JMP DONETIME
    CHECKMINUTE3:
        CMP MINUTE, 1
            JL ISSECOND3
        MOV MINUTE1, '3'
        JMP DONETIME
    ISSECOND3:   
        MOV SECOND1, '3'
        JMP DONETIME
    IFT4:
        CMP BH, 05H
            JGE IFT5
        MOV AL, LINE4
        OUT DX, AL 
        CMP HOUR, 1
            JL CHECKMINUTE4
        MOV HOUR1, '4'
        JMP DONETIME
    CHECKMINUTE4:
        CMP MINUTE, 1
            JL ISSECOND4
        MOV MINUTE1, '4'
        JMP DONETIME
    ISSECOND4:   
        MOV SECOND1, '4'
        JMP DONETIME
    IFT5:
        CMP BH, 06H
            JGE IFT6
        MOV AL, LINE5
        OUT DX, AL 
        CMP HOUR, 1
            JL CHECKMINUTE5
        MOV HOUR1, '5'
        JMP DONETIME
    CHECKMINUTE5:
        CMP MINUTE, 1
            JL ISSECOND5
        MOV MINUTE1, '5'
        JMP DONETIME
    ISSECOND5:   
        MOV SECOND1, '5'
        JMP DONETIME
    IFT6:
        CMP BH, 07H
            JGE IFT7
        MOV AL, LINE6
        OUT DX, AL   
        CMP HOUR, 1
            JL CHECKMINUTE6
        MOV HOUR1, '6'
        JMP DONETIME
    CHECKMINUTE6:
        CMP MINUTE, 1
            JL ISSECOND6
        MOV MINUTE1, '6'
        JMP DONETIME
    ISSECOND6:   
        MOV SECOND1, '6'
        JMP DONETIME
    IFT7:
        CMP BH, 08H
            JGE IFT8
        MOV AL, LINE7
        OUT DX, AL    
        CMP HOUR, 1
            JL CHECKMINUTE7
        MOV HOUR1, '7'
        JMP DONETIME
    CHECKMINUTE7:
        CMP MINUTE, 1
            JL ISSECOND7
        MOV MINUTE1, '7'
        JMP DONETIME
    ISSECOND7:   
        MOV SECOND1, '7'
        JMP DONETIME
    IFT8:
        CMP BH, 09H
            JGE IFT9
        MOV AL, LINE8
        OUT DX, AL   
        CMP HOUR, 1
            JL CHECKMINUTE8
        MOV HOUR1, '8'
        JMP DONETIME
    CHECKMINUTE8:
        CMP MINUTE, 1
            JL ISSECOND8
        MOV MINUTE1, '8'
        JMP DONETIME
    ISSECOND8:   
        MOV SECOND1, '8'
        JMP DONETIME    
    IFT9:
        MOV AL, LINE9
        OUT DX, AL 
        CMP HOUR, 1
            JL CHECKMINUTE9
        MOV HOUR1, '9'
        JMP DONETIME
    CHECKMINUTE9:
        CMP MINUTE, 1
            JL ISSECOND9
        MOV MINUTE1, '9'
        JMP DONETIME
    ISSECOND9:   
        MOV SECOND1, '9'
        JMP DONETIME
    
HERETIME:
    CMP BL, 00H
        JG IFFT1
    MOV AL, LINE0
    OUT DX, AL 
        CMP HOUR, 1
            JL CHECKMINUTE00
        MOV HOUR2, '0'
        JMP DONETIME
    CHECKMINUTE00:
        CMP MINUTE, 1
            JL ISSECOND00
        MOV MINUTE2, '0'
        JMP DONETIME
    ISSECOND00:   
        MOV SECOND2, '0'
    JMP DONETIME
    IFFT1:
        CMP BL, 02H
            JGE IFFT2
        MOV AL, LINE1
        OUT DX, AL 
        CMP HOUR, 1
            JL CHECKMINUTE01
        MOV HOUR2, '1'
        JMP DONETIME
    CHECKMINUTE01:
        CMP MINUTE, 1
            JL ISSECOND01
        MOV MINUTE2, '1'
        JMP DONETIME
    ISSECOND01:   
        MOV SECOND2, '1'
        JMP DONETIME
    IFFT2:
        CMP BL, 03H
            JGE IFFT3
        MOV AL, LINE2
        OUT DX, AL
        CMP HOUR, 1
            JL CHECKMINUTE02
        MOV HOUR2, '2'
        JMP DONETIME
    CHECKMINUTE02:
        CMP MINUTE, 1
            JL ISSECOND02
        MOV MINUTE2, '2'
        JMP DONETIME
    ISSECOND02:   
        MOV SECOND2, '2'   
        JMP DONETIME
    IFFT3:
        CMP BL, 04H
            JGE IFFT4
        MOV AL, LINE3
        OUT DX, AL
        CMP HOUR, 1
            JL CHECKMINUTE03
        MOV HOUR2, '3'
        JMP DONETIME
    CHECKMINUTE03:
        CMP MINUTE, 1
            JL ISSECOND03
        MOV MINUTE2, '3'
        JMP DONETIME
    ISSECOND03:   
        MOV SECOND2, '3'
        JMP DONETIME
    IFFT4:
        CMP BL, 05H
            JGE IFFT5
        MOV AL, LINE4
        OUT DX, AL 
        CMP HOUR, 1
            JL CHECKMINUTE04
        MOV HOUR2, '4'
        JMP DONETIME
    CHECKMINUTE04:
        CMP MINUTE, 1
            JL ISSECOND04
        MOV MINUTE2, '4'
        JMP DONETIME
    ISSECOND04:   
        MOV SECOND2, '4'
        JMP DONETIME
    IFFT5:
        CMP BL, 06H
            JGE IFFT6
        MOV AL, LINE5
        OUT DX, AL 
        CMP HOUR, 1
            JL CHECKMINUTE05
        MOV HOUR2, '5'
        JMP DONETIME
    CHECKMINUTE05:
        CMP MINUTE, 1
            JL ISSECOND05
        MOV MINUTE2, '5'
        JMP DONETIME
    ISSECOND05:   
        MOV SECOND2, '5'
        JMP DONETIME
    IFFT6:
        CMP BL, 07H
            JGE IFFT7
        MOV AL, LINE6
        OUT DX, AL  
        CMP HOUR, 1
            JL CHECKMINUTE06
        MOV HOUR2, '6'
        JMP DONETIME
    CHECKMINUTE06:
        CMP MINUTE, 1
            JL ISSECOND06
        MOV MINUTE2, '6'
        JMP DONETIME
    ISSECOND06:   
        MOV SECOND2, '6'
        JMP DONETIME
    IFFT7:
        CMP BL, 08H
            JGE IFFT8
        MOV AL, LINE7
        OUT DX, AL
        CMP HOUR, 1
            JL CHECKMINUTE07
        MOV HOUR2, '7'
        JMP DONETIME
    CHECKMINUTE07:
        CMP MINUTE, 1
            JL ISSECOND07
        MOV MINUTE2, '7'
        JMP DONETIME
    ISSECOND07:   
        MOV SECOND2, '7'  
        JMP DONETIME
    IFFT8:
        CMP BL, 09H
            JGE IFFT9
        MOV AL, LINE8
        OUT DX, AL 
        CMP HOUR, 1
            JL CHECKMINUTE08
        MOV HOUR2, '8'
        JMP DONETIME
    CHECKMINUTE08:
        CMP MINUTE, 1
            JL ISSECOND08
        MOV MINUTE2, '8'
        JMP DONETIME
    ISSECOND08:   
        MOV SECOND2, '8'
        JMP DONETIME    
    IFFT9:
        MOV AL, LINE9
        OUT DX, AL  
        CMP HOUR, 1
            JL CHECKMINUTE09
        MOV HOUR2, '9'
        JMP DONETIME
    CHECKMINUTE09:
        CMP MINUTE, 1
            JL ISSECOND09
        MOV MINUTE2, '9'
        JMP DONETIME
    ISSECOND09:   
        MOV SECOND2, '9'
        JMP DONETIME   

DONETIME:   
RET
DISPLAYTIME ENDP

CHECKTIME PROC
    MOV DX, 2040H
    MOV SI, 0
    MOV CX, 48
    CMP BX, 0005H
        JE ISMORNING
    CMP BX, 0101H
        JG IFAFTERNOON    
    CMP BX, 0101H
        JE ISMORNING 
    CMP REPEAT, 1
        JE SET
    NEXTLCDA2:
        MOV AL, MESSAGE1[SI]
        OUT DX, AL
        INC SI
        INC DX
        LOOP NEXTLCDA2
        MOV REPEAT, 1
        MOV ISWATERED, 0
        JMP SET
ISMORNING:
    CMP REPEAT, 0
        JE SET    
    CALL SETTIME
    MOV DX, 2040H
    MOV SI, 0
    MOV CX, 48
    NEXTLCDA1:
        MOV AL, MESSAGEn[SI]
        OUT DX, AL
        INC SI
        INC DX
        LOOP NEXTLCDA1 
        CALL DISPLAYLED
    MOV DX, 2040H
    MOV SI, 0
    MOV CX, 48
    NEXTLCDA3:
        MOV AL, MESSAGE1[SI]
        OUT DX, AL
        INC SI
        INC DX
        LOOP NEXTLCDA3
        MOV ISWATERED, 1
    MOV REPEAT, 0    
    JMP SET
IFAFTERNOON:
    CMP BX, 0107H
        JG IFEVENING
    CMP BX,0107H
        JE ISAFTERNOON
    CMP REPEAT, 1
        JE SET
    NEXTLCDB2:
        MOV AL, MESSAGE2[SI]
        OUT DX, AL
        INC SI
        INC DX
        LOOP NEXTLCDB2
        MOV REPEAT, 1
        MOV ISWATERED, 0
        JMP SET
ISAFTERNOON:  
    CMP REPEAT, 0
        JE SET
    CALL SETTIME
    MOV DX, 2040H
    MOV SI, 0
    MOV CX, 48
    NEXTLCDB1:
        MOV AL, MESSAGEn[SI]
        OUT DX, AL
        INC SI
        INC DX
        LOOP NEXTLCDB1
        CALL DISPLAYLED
    MOV DX, 2040H
    MOV SI, 0
    MOV CX, 48
    NEXTLCDB3:
        MOV AL, MESSAGE2[SI]
        OUT DX, AL
        INC SI
        INC DX
        LOOP NEXTLCDB3
        MOV ISWATERED, 1     
    MOV REPEAT, 0    
    JMP SET        
IFEVENING:
    CMP BX, 0203H
        JE ISEVENING 
    CMP REPEAT, 1
        JE SET
    NEXTLCDC2:
        MOV AL, MESSAGE3[SI]
        OUT DX, AL
        INC SI
        INC DX 
        LOOP NEXTLCDC2
        MOV REPEAT, 1
        MOV ISWATERED, 0
        JMP SET    
ISEVENING: 
    CMP REPEAT, 0
        JE SET
    CALL SETTIME
    MOV DX, 2040H
    MOV SI, 0
    MOV CX, 48
    NEXTLCDC1:
        MOV AL, MESSAGEn[SI]
        OUT DX, AL
        INC SI
        INC DX
        LOOP NEXTLCDC1
        CALL DISPLAYLED
    MOV DX, 2040H
    MOV SI, 0
    MOV CX, 48
    NEXTLCDC3:
        MOV AL, MESSAGE3[SI]
        OUT DX, AL
        INC SI
        INC DX
        LOOP NEXTLCDC3 
        MOV ISWATERED, 1  
    MOV REPEAT, 0    
    JMP SET              
SET:
RET
CALL CHECKTEMP 
CHECKTIME ENDP
 
SETTIME PROC 
    MOV DX, 2032H
    MOV AL, LINEn
    OUT DX, AL
    
    MOV DX, 2033H
    MOV SI, 0
    MOV CX, 2
    RESETTIME1:
        MOV AL, LINE0
        OUT DX, AL
        INC DX
        INC SI
        LOOP RESETTIME1
    
    MOV DX, 2032H
    MOV AL, LINEn
    OUT DX, AL
    
    MOV DX, 2036H
    MOV SI, 0
    MOV CX, 2
    RESETTIME2:
        MOV AL, LINE0
        OUT DX, AL
        INC DX
        INC SI
        LOOP RESETTIME2
RET
SETTIME ENDP 
 
DISPLAYLED PROC
    MOV DX, 2070H
    MOV AL, 00000000B 
    OUT DX, AL 
    MOV AL, 10000000B
    OUT DX, AL
    CALL INTERVAL
    MOV DX, 2070H
    MOV AX, 11000000B
    OUT DX, AL
    CALL INTERVAL 
    MOV DX, 2070H
    MOV AX, 11100000B
    OUT DX, AL
    CALL INTERVAL
    MOV DX, 2070H
    MOV AX, 11110000B
    OUT DX, AL
    CALL INTERVAL
    MOV DX, 2070H
    MOV AX, 11111000B
    OUT DX, AL
    CALL INTERVAL
    MOV DX, 2070H
    MOV AX, 11111100B
    OUT DX, AL
    CALL INTERVAL
    MOV DX, 2070H
    MOV AX, 11111110B
    OUT DX, AL
    CALL INTERVAL 
    MOV DX, 2070H
    MOV AX, 11111111B
    OUT DX, AL
    CALL INTERVAL 
    MOV DX, 2070H
    MOV AX, 01111111B
    OUT DX, AL
    CALL INTERVAL
    MOV DX, 2070H
    MOV AL, 00111111B
    OUT DX, AL
    CALL INTERVAL
    MOV DX, 2070H
    MOV AL, 00011111B
    OUT DX, AL
    CALL INTERVAL
    MOV DX, 2070H
    MOV AL, 00001111B
    OUT DX, AL
    CALL INTERVAL
    MOV DX, 2070H
    MOV AL, 00000111B
    OUT DX, AL
    CALL INTERVAL
    MOV DX, 2070H
    MOV AL, 00000011B
    OUT DX, AL
    CALL INTERVAL
    MOV DX, 2070H
    MOV AL, 00000001B
    OUT DX, AL
    CALL INTERVAL
    MOV DX, 2070H
    MOV AL, 00000000B
    OUT DX, AL
    CALL INTERVAL
    MOV DX, 2070H
    MOV AL, 00000100B
    OUT DX, AL
    CALL INTERVAL
    MOV DX, 2070H
    MOV AL, 00001100B
    OUT DX, AL
    CALL INTERVAL
    MOV DX, 2070H
    MOV AL, 00011100B
    OUT DX, AL
    CALL INTERVAL
    MOV DX, 2070H
    MOV AL, 00111100B
    OUT DX, AL
    CALL INTERVAL 
    MOV DX, 2070H
    MOV AL, 00000000B
    OUT DX, AL
    CMP ISTOOHOT, 1
        JE ISHOT
    JMP DONELED
ISHOT: 
    MOV AL, 10000000B
    OUT DX, AL
    CALL INTERVAL
    MOV AL, 10100000B
    OUT DX, AL
    CALL INTERVAL
    MOV AL, 10101000B
    OUT DX, AL
    CALL INTERVAL
    MOV AL, 10101010B
    OUT DX, AL
    CALL INTERVAL
    MOV AL, 00000000B
    OUT DX, AL
    CALL INTERVAL    
DONELED: 
RET
DISPLAYLED ENDP

INTERVAL PROC
    ;1 SEC0ND INTERVAL
    MOV CX, 0FH
    MOV DX, 4240H
    MOV AH, 86H
    INT 15H
    CALL CHECKTEMP   
RET
INTERVAL ENDP

SAVELOGS PROC
    CALL CHECKTEMP  
    MOV AX, 0       
    MOV AL, [DAY1]
    OUT 130D, AL
    WAITA:
        IN AL, 130D
        OR AL, 0
        JNZ WAITA
    MOV AX, 0 
    MOV AL, [DAY2]
    OUT 130D, AL
    WAITB:
        IN AL, 130D
        OR AL, 0
        JNZ WAITB
    MOV AL, [DDATE]
    OUT 130D, AL
    WAITC:
        IN AL, 130D
        OR AL, 0
        JNZ WAITC 
    CALL CHECKTEMP 
    MOV AX, 0
    MOV AL, [MONTH1]
    OUT 130D, AL
    WAITD:
        IN AL, 130D
        OR AL, 0
        JNZ WAITD
    MOV AX, 0 
    MOV AL, [MONTH2]
    OUT 130D, AL
    WAITE:
        IN AL, 130D
        OR AL, 0
        JNZ WAITE
    MOV AX, 0
    MOV AL, [DDATE]
    OUT 130D, AL
    WAITF:
        IN AL, 130D
        OR AL, 0
        JNZ WAITF 
    CALL CHECKTEMP 
    MOV AX, 0
    MOV AL, [YEAR1]
    OUT 130D, AL
    WAITG:
        IN AL, 130D
        OR AL, 0
        JNZ WAITG
    MOV AX, 0 
    MOV AL, [YEAR2]
    OUT 130D, AL
    WAITH:
        IN AL, 130D
        OR AL, 0
        JNZ WAITH
    CALL CHECKTEMP 
    LEA BX, SSPACE
    MOV CX, 5
    MOV AX, 0
PUTCHARC:
    MOV AL, [BX]
    OUT 130D, AL
    INC BX
    WAITI:
        IN AL, 130D
        OR AL, 0
        JNZ WAITI 
    LOOP PUTCHARC
    
    CALL CHECKTEMP 
    MOV AX, 0
    MOV AL, [HOUR1]
    OUT 130D, AL
    WAIT1:
        IN AL, 130D
        OR AL, 0
        JNZ WAIT1
    MOV AX, 0 
    MOV AL, [HOUR2]
    OUT 130D, AL
    WAIT2:
        IN AL, 130D
        OR AL, 0
        JNZ WAIT2
    MOV AX, 0
    MOV AL, [TTIME]
    OUT 130D, AL
    WAIT3:
        IN AL, 130D
        OR AL, 0
        JNZ WAIT3 
    CALL CHECKTEMP 
    MOV AX, 0
    MOV AL, [MINUTE1]
    OUT 130D, AL
    INC BX
    WAIT4:
        IN AL, 130D
        OR AL, 0
        JNZ WAIT4
    MOV AX, 0 
    MOV AL, [MINUTE2]
    OUT 130D, AL
    WAIT5:
        IN AL, 130D
        OR AL, 0
        JNZ WAIT5
    MOV AX, 0
    MOV AL, [TTIME]
    OUT 130D, AL
    WAIT6:
        IN AL, 130D
        OR AL, 0
        JNZ WAIT6
    CALL CHECKTEMP 
    MOV AX, 0
    MOV AL, [SECOND1]
    OUT 130D, AL
    WAIT7:
        IN AL, 130D
        OR AL, 0
        JNZ WAIT7
    MOV AX, 0 
    MOV AL, [SECOND2]
    OUT 130D, AL
    WAIT8:
        IN AL, 130D
        OR AL, 0
        JNZ WAIT8
        
    LEA BX, SSPACE
    MOV CX, 5
    MOV AX, 0
PUTCHARD:
    MOV AL, [BX]
    OUT 130D, AL
    INC BX
    WAITJ:
        IN AL, 130D
        OR AL, 0
        JNZ WAITJ 
    LOOP PUTCHARD 
    
    CALL CHECKTEMP   
    LEA BX, SSTATUS
    MOV CX, 10
    MOV AX, 0
PUTCHARE:
    MOV AL, [BX]
    OUT 130D, AL
    INC BX
    WAITK:
        IN AL, 130D
        OR AL, 0
        JNZ WAITK 
    LOOP PUTCHARE
CALL CHECKTEMP      
CALL WRITETOFILE   
RET
SAVELOGS ENDP

WRITETOFILE PROC
    MOV AH, 40H
    MOV BX, HANDLE
    MOV DX, OFFSET DAY1
    MOV CX, 1 
    INT 21H
    
    MOV AH, 40H
    MOV BX, HANDLE
    MOV DX, OFFSET DAY2
    MOV CX, 1 
    INT 21H
    
    MOV AH, 40H
    MOV BX, HANDLE
    MOV DX, OFFSET DDATE
    MOV CX, 1 
    INT 21H
    
    MOV AH, 40H
    MOV BX, HANDLE
    MOV DX, OFFSET MONTH1
    MOV CX, 1 
    INT 21H
    
    MOV AH, 40H
    MOV BX, HANDLE
    MOV DX, OFFSET MONTH2
    MOV CX, 1 
    INT 21H 
    
    MOV AH, 40H
    MOV BX, HANDLE
    MOV DX, OFFSET DDATE
    MOV CX, 1  
    INT 21H   
    
    MOV AH, 40H
    MOV BX, HANDLE
    MOV DX, OFFSET YEAR1
    MOV CX, 1 
    INT 21H
    
    MOV AH, 40H
    MOV BX, HANDLE
    MOV DX, OFFSET YEAR2
    MOV CX, 1 
    INT 21H
    
    MOV AH, 40H
    MOV BX, HANDLE
    MOV DX, OFFSET SSPACE
    MOV CX, 5   
    INT 21H
    
    MOV AH, 40H
    MOV BX, HANDLE
    MOV DX, OFFSET HOUR1
    MOV CX, 1 
    INT 21H
    
    MOV AH, 40H
    MOV BX, HANDLE
    MOV DX, OFFSET HOUR2
    MOV CX, 1   
    INT 21H
    
    MOV AH, 40H
    MOV BX, HANDLE
    MOV DX, OFFSET TTIME
    MOV CX, 1 
    INT 21H
    
    MOV AH, 40H
    MOV BX, HANDLE
    MOV DX, OFFSET MINUTE1
    MOV CX, 1   
    INT 21H
    
    MOV AH, 40H
    MOV BX, HANDLE
    MOV DX, OFFSET MINUTE2
    MOV CX, 1   
    INT 21H  
    
    MOV AH, 40H
    MOV BX, HANDLE
    MOV DX, OFFSET TTIME
    MOV CX, 1     
    INT 21H
    
    MOV AH, 40H
    MOV BX, HANDLE
    MOV DX, OFFSET SECOND1
    MOV CX, 1  
    INT 21H  
    
    MOV AH, 40H
    MOV BX, HANDLE
    MOV DX, OFFSET SECOND2
    MOV CX, 1   
    INT 21H
    
    MOV AH, 40H
    MOV BX, HANDLE
    MOV DX, OFFSET SSPACE
    MOV CX, 5    
    INT 21H
    
    MOV AH, 40H
    MOV BX, HANDLE
    MOV DX, OFFSET SSTATUS
    MOV CX, 10   
    INT 21H
    
CALL CHECKTEMP 
RET
WRITETOFILE ENDP    
 
CHECKTEMP PROC
    IN AL, 125
    CMP AL, 21
        JL CHANGE1
    CMP AL, 32
        JLE START2   
    JG CHANGE2
        
CHANGE1:
    MOV AL, 1
    OUT 127, AL
    JMP START2
CHANGE2:
    MOV AL, 0
    OUT 127, AL 
    IN AL, 125
    CMP AL, 36H
        JGE ISHIGH
    JMP START2     
ISHIGH:
    MOV DX, 2040H
    MOV SI, 0
    MOV CX, 48
    NEXTH:
        MOV AL, MESSAGEh[SI]
        OUT DX, AL 
        INC SI
        INC DX
        LOOP NEXTH
    MOV DX, 2040H
    MOV SI, 0
    MOV CX, 48 
    MOV ISTOOHOT, 1
    CALL DISPLAYLED
    NEXTH2:
        MOV AL, MESSAGEs[SI]
        OUT DX, AL 
        INC SI
        INC DX
        LOOP NEXTH2 
    MOV ISTOOHOT, 0       
START2:
RET
CHECKTEMP ENDP
                                               
               
            ;|              ||              ||              |
MESSAGE1 DB "******GOOD***********MORNING********************"
MESSAGE2 DB "******GOOD**********AFTERNOON*******************"
MESSAGE3 DB "******GOOD***********EVENING********************"
MESSAGEn DB "********************WATERING******PLEASE WAIT***"
MESSAGEh DB "****TOO HOT!********WATERING******PLEASE WAIT***"
MESSAGEs DB "************************************************"
BUFF DB ?,"$"
REPEAT DB ?,"$"
ISWATERED DB ?,"$"
ISTOOHOT DB ?,"$"   

 
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

;LOGS     
DAY DB ?, "" 
DAY1 DB ?, ""
DAY1_END DB 0 
DAY2 DB ?, ""
DAY2_END DB 0 
MONTH DB ?, ""
MONTH1 DB ?, ""
MONTH1_END DB 0
MONTH2 DB ?, ""
MONTH2_END DB 0
YEAR DB ?, ""   
YEAR1 DB ?, ""
YEAR1_END DB 0
YEAR2 DB ?, ""
YEAR2_END DB 0
DDATE DB "/"  
DDATE_END DB 0
SSPACE DB "     "
SSPACE_END DB 0
HOUR DB ?, ""
HOUR1 DB ?, ""
HOUR1_END DB 0
HOUR2 DB ?, "" 
HOUR2_END DB 0
MINUTE DB ?, ""
MINUTE1 DB ?, ""
MINUTE1_END DB 0
MINUTE2 DB ?, ""
MINUTE2_END DB 0
SECOND DB ?, ""
SECOND1 DB ?, ""
SECOND1_END DB 0  
SECOND2 DB ?, ""
SECOND2_END DB 0
TTIME DB ":" 
TTIME_END DB 0
SSTATUS DB "WATERED.", 0Ah, 0Dh 
SSTATUS_END DB 0

DIR DB "c:\WATERING SYSTEM", 0
FILE DB "c:\WATERING SYSTEM\LOGS.txt", 0
HANDLE DW ?  
