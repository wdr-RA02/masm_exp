;part5 of exp2: bcd to binary
DATAS SEGMENT
;datas 
    SRC DW 3500H
    DES DW 3510H  
    COUNT DW 4
DATAS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS
START:
    MOV AX,DATAS
    MOV DS,AX
;code start
	;indexes
	MOV DI, DES
	MOV SI, SRC
	
	;count
	MOV CX, COUNT
	MOV BX, 10
	MOV AX, 0
CALC:
	;DI[i]=10*SI[i/2]+SI[i/2+1]
	MOV AL,[SI]
	MUL BL
	INC SI
	ADD AL,[SI]
	
	MOV BYTE PTR[DI],AL
	INC SI
	ADD DI, 2
	LOOP CALC
	
	
;code end
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START









