;part2 of exp2: ascii to bcd
DATAS SEGMENT
;datas 
    SRC DW 3500H
    DES DW 350AH  
    COUNT DW 5
DATAS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS
START:
    MOV AX,DATAS
    MOV DS,AX
;code start  
    ;source index
	MOV SI, SRC
	;dest index
	MOV DI, DES
	
	MOV CX, COUNT
	MOV AX, 0
	MOV BL, 1
	MOV DL, 0FFH

BCD:
	;make DI=FF
	MOV [DI], DL
	;fetch from source
	MOV AL, [SI]

	;skip if AL>39H
	CMP AL, 39H
	JG SKIP

	SUB AL, 30H
	;skip if AL<30H
	JS SKIP
	MOV [DI], AL
	
SKIP:
	;SI++,DI++,ZF->(CX&CX)
	INC SI
	INC DI
	AND CX, CX
	LOOP BCD
	
;code end
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START




