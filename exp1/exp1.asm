DATAS SEGMENT
    ;�˴��������ݶδ���  
    ARRAY1 DB 2,5,0,3,-4,5,0,0AH,0FH
    ARRAY2 DB 3,5,4,-2,0,8,3,-0AH,20H
    COUNT  DB $-ARRAY2
    ;count����array2���ȣ�=9
    LEN    DB ?
    ;����1byte�Ŀռ�
    SUM    DB 20H DUP(0)
DATAS ENDS

STACKS SEGMENT PARA STACK 'STACK'
	DW 20H DUP(0)
    ;�˴������ջ�δ���
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    ;�˴��������δ���
    
    MOV BX,-1	
    MOV CX,0
    MOV CL,COUNT
    
NOZERO:
;ѭ����͵���˼��
	INC BX
	MOV AL,ARRAY1[BX]
	ADD AL,ARRAY2[BX]
	
	MOV SUM[BX],AL
	;CX--,CX>0����ת
	LOOPNE NOZERO
	;ͬJZ
	JE ENDO
	INC BL
ENDO:
	MOV LEN,BL
	
	
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
