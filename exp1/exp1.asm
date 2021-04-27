DATAS SEGMENT
    ;此处输入数据段代码  
    ARRAY1 DB 2,5,0,3,-4,5,0,0AH,0FH
    ARRAY2 DB 3,5,4,-2,0,8,3,-0AH,20H
    COUNT  DB $-ARRAY2
    ;count计算array2长度，=9
    LEN    DB ?
    ;分配1byte的空间
    SUM    DB 20H DUP(0)
DATAS ENDS

STACKS SEGMENT PARA STACK 'STACK'
	DW 20H DUP(0)
    ;此处输入堆栈段代码
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    ;此处输入代码段代码
    
    MOV BX,-1	
    MOV CX,0
    MOV CL,COUNT
    
NOZERO:
;循环求和的意思吧
	INC BX
	MOV AL,ARRAY1[BX]
	ADD AL,ARRAY2[BX]
	
	MOV SUM[BX],AL
	;CX--,CX>0则跳转
	LOOPNE NOZERO
	;同JZ
	JE ENDO
	INC BL
ENDO:
	MOV LEN,BL
	
	
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
