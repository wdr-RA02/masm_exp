DATAS SEGMENT
    ;此处输入数据段代码 
    DATA1 DW 1234H
    DATA2 DW 3456H 
DATAS ENDS

STACKS SEGMENT
    ;此处输入堆栈段代码
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    ;此处输入代码段代码
    MOV AX,DATA1
   	MOV BX,DATA2
   	
   	ADD AX,BX
   	
   	;取Data2地址
   	LEA BX,DATA2
   	ADD BX,2
   	
   	MOV [BX],AX
   	;ENDS
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START

