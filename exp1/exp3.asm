DATAS SEGMENT
    ;�˴��������ݶδ���  
    BUF DB 100
    	DB ?
    	DB 100 DUP(?)	;������Ϣ
    MSG DB 'what is your name? ','$'
    
DATAS ENDS

STACKS SEGMENT
    ;�˴������ջ�δ���
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    ;�˴��������δ���
    LEA DX,MSG
    MOV AH,9	;��ʾ��ʾ��Ϣ
    INT 21H
    
    LEA DX,BUF
    MOV AH,0AH  ; ��������
    INT 21H
    
    ;�������
    XOR BX,BX
    LEA SI,BUF
    
    MOV CL,0AH
    MOV [SI],CL
    INC SI
    MOV BL,BYTE PTR[SI]
    
    MOV CL,0
    MOV [SI],CL
    
    MOV BUF[BX+2],"$"
    ;ADD SI,2
    MOV AH,9
    INT 21H
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START


