DATAS SEGMENT
    ;�˴��������ݶδ��� 
    DATA1 DW 1234H
    DATA2 DW 3456H 
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
    MOV AX,DATA1
   	MOV BX,DATA2
   	
   	ADD AX,BX
   	
   	;ȡData2��ַ
   	LEA BX,DATA2
   	ADD BX,2
   	
   	MOV [BX],AX
   	;ENDS
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START

