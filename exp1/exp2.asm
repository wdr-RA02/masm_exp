DATAS SEGMENT
    ;�˴��������ݶδ���  
    ;�����$�����������
    MESSAGE DB 'HELLO WORLD.$'
DATAS ENDS

STACKS SEGMENT PARA STACK 'STACK'
    ;�˴������ջ�δ���
    ;�����ջ
    DB 400H DUP(0)
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START PROC FAR
;START: PROC FAR
	PUSH DS
	MOV AX,0
	PUSH AX	;����dos
	
    MOV AX,DATAS
    MOV DS,AX
    ;�˴��������δ���
    
    LEA DX,MESSAGE
    MOV AH,9;����9���ж���ʾ�ַ���
    

    INT 21H
    RET
START ENDP
CODES ENDS
    END START
