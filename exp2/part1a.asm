;part1 of exp2: ascii to hex(bytes) (allow 0~65535)
DATAS SEGMENT
;datas 
    SRC DW 3500H
    DES DW 3510H  
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
	
	;set up circular counts
	MOV CX, COUNT
	MOV BX, 10
	
	;DI=0
	MOV AX, 0
	MOV [DI], AX
	 
;Ö÷Ñ­»·Ìå
CAL:
	;DI=DI*10
	MOV AX, [DI]
	MUL BX
	MOV [DI], AX
	
	;DI+=SI[i]
	MOV BH, BYTE PTR[SI]
	SUB BH, 30H
	ADD [DI], BH
	MOV BH, 0
	
	; SI++
	INC SI
	LOOP CAL
	
;code end
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START


