DATAS SEGMENT
    ;此处输入数据段代码  
    BUF DB 100
    	DB ?
    	DB 100 DUP(?)	;键盘信息
    MSG DB 'what is your name? ','$'
    
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
    LEA DX,MSG
    MOV AH,9	;显示提示信息
    INT 21H
    
    LEA DX,BUF
    MOV AH,0AH  ; 接受输入
    INT 21H
    
    ;输出部分
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


