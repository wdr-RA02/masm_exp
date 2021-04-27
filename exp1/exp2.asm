DATAS SEGMENT
    ;此处输入数据段代码  
    ;必须加$，否则会乱码
    MESSAGE DB 'HELLO WORLD.$'
DATAS ENDS

STACKS SEGMENT PARA STACK 'STACK'
    ;此处输入堆栈段代码
    ;分配堆栈
    DB 400H DUP(0)
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START PROC FAR
;START: PROC FAR
	PUSH DS
	MOV AX,0
	PUSH AX	;返回dos
	
    MOV AX,DATAS
    MOV DS,AX
    ;此处输入代码段代码
    
    LEA DX,MESSAGE
    MOV AH,9;调用9号中断显示字符串
    

    INT 21H
    RET
START ENDP
CODES ENDS
    END START
