DATAS SEGMENT
    ;�˴��������ݶδ��� 
   	ORG 100H
    NUM  DW ?
DATAS ENDS


CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    ;s=1
    MOV DX,1
    MOV BL,2
    MOV AX,0
    
MULTI:
	MOV AL,BL
	INC BL
	;ax=al*bl
	MUL BL
	ADD DX, AX
	CMP AX, 200
	JL MULTI
    
    ;move to data
    LEA DI,NUM
    MOV [DI],DX
    
    MOV AH,4CH
    INT 21H

CODES ENDS
    END START

