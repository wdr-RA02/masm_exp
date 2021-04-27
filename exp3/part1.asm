DATAS SEGMENT
	;此处输入数据段代码
	ORG 100H
	;make offset(SRC)=100H
	SRC DB 1,2,3,4,5,6
	;length of array
	LEN EQU $-SRC
	;offset btw SRC and DES
	OFSET EQU -3
DATAS ENDS

CODES SEGMENT
	ASSUME CS:CODES,DS:DATAS
START:
	MOV AX,DATAS
	MOV DS,AX
				    
	;init si and di
	LEA SI, SRC
	MOV DI, SI
	ADD DI, OFSET
 	MOV CX, LEN
				    
	;si>di, 从前移动
	;si<di, 从后方移动
	CMP SI,DI
	JG MOV_FWD
 ;move backward
	ADD SI, CX
	ADD DI, CX

MOV_BWD:
	MOV BL, [SI]
	MOV [DI], BL
	DEC SI
	DEC DI
	LOOP MOV_BWD
	JMP NEXT
				    
;move forward
MOV_FWD:
	MOV BL, [SI]
	MOV [DI], BL
	INC SI
	INC DI
	LOOP MOV_FWD
				    
NEXT:    
	MOV AH,4CH
	INT 21H
CODES ENDS
	END START
