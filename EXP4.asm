DATAS SEGMENT
    ; prompts
      MENU DB "Menu program designed by wdr_RA02.",0AH,0AH
                 DB "Please input number 1~5:",0AH
                 DB "1.Convert non-capital letters in string to capital.",0AH
    	 DB "2.Find max ASCII character in a string.",0AH
    	 DB "3.Sort the character by ASCII descending order.",0AH
    	 DB "4.Display the ticking time",0AH
    	 DB "5.End the program.",0AH,'$'
	
	FUN1_WD  DB 0AH,"input a string with less than 100 words: ",0AH,'$'
	FUN4_WD  DB 0AH,"Display ticking time.",0AH
			 DB 0AH,"Under construction......",0AH,'$'
	EXT_PRMT DB 0AH,"Press any key to perform again, or press ESC to return to menu. ",0AH,'$'
	
   	ERR  DB 0AH,"Error! Please input 1~5! ",0AH,'$'
   	QUIT DB 0AH,"Quit the program...",0AH,'$'
   	
   	ENDMK EQU '$'
   	;datasets
   	ORG 1000H
   	;can be commonly used by fun1() and fun2()
   	FUN1_BUF DB 100,?,100 DUP(0)
   	
   	
DATAS ENDS

EXTRA SEGMENT
	;function list
	FUN_LST DB 2 DUP(0)
    		DB 2 DUP(0)
    		DB 2 DUP(0)
    		DB 2 DUP(0)	
EXTRA ENDS

STACKS SEGMENT
    ;此处输入堆栈段代码
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS,ES:EXTRA
START:
MAIN PROC FAR
	;for quitting to DOS mode
	PUSH DS
	MOV AX,0
	PUSH AX
	
	;link regs with storage
    MOV AX,DATAS
    MOV DS,AX
    MOV AX,EXTRA
    MOV ES,AX
    
	;init function list
    LEA AX,FUN_LST
    MOV DI,AX
	MOV ES:WORD PTR[DI],OFFSET FUN1
	ADD DI,2
	MOV ES:WORD PTR[DI],OFFSET FUN2
	ADD DI,2
	MOV ES:WORD PTR[DI],OFFSET FUN3
	ADD DI,2
	MOV ES:WORD PTR[DI],OFFSET FUN4
	ADD DI,2

MAIN_MENU:	
    ;display menu
    LEA DX,MENU
    MOV AH,9
    INT 21H
INPUT:
    ;awaiting input
    MOV AH,7
    INT 21H
    
    ;31H<=AL<=35H--next
    CMP AL,31H
    JL ERROR
    CMP AL,35H
    JE EXIT
    JG ERROR
    
    LEA SI,FUN_LST
    SUB AL,31H
    MOV CH,0
    MOV CL,AL
    MOV AL,2
    MUL CL
    ADD SI,AX
	;call the address in function
	CALL ES:WORD PTR[SI]
	JMP MAIN_MENU
	
ERROR:
	LEA DX,ERR
    CALL DISP_DX
    JMP INPUT
    
EXIT:
	LEA DX,QUIT
    CALL DISP_DX
	RET
MAIN ENDP   

;	auxliary funcs
;display string
DISP_DX PROC
	PUSH AX
	MOV AH,9
	INT 21H
	POP AX
	RET
DISP_DX ENDP

;input string
INPUT_DX PROC
	PUSH AX
	MOV AH,10
	INT 21H
	POP AX
	RET
INPUT_DX ENDP

;add '$' to the end
ENDSTR_SI PROC
	PUSH SI
	PUSH AX
	INC SI
	MOV AL, ENDMK
	MOV [SI], AL
	POP AX
	POP SI
	RET
ENDSTR_SI ENDP
;	auxliary func END


;functions
FUN1 PROC
	PUSH DX
	PUSH AX
	PUSH SI
	PUSH CX
	
PROC_1:	
	LEA DX,FUN1_WD
	CALL DISP_DX

	;input words
	MOV CX,0
	LEA DX,FUN1_BUF
	MOV SI,DX
	CALL INPUT_DX

	;get offset
	INC SI
	MOV CL,BYTE PTR[SI]
	;loop string
LPSTR_1:
	INC SI
	MOV AL, [SI]
	CMP AL, 61H
	;si[i]<'a'||si[i]>'z',continue
	JL CONT_1
	
	CMP AL, 7AH
	JG CONT_1
	;else,si[i]-=20H(32)
	SUB AL,20H
	MOV [SI],AL
CONT_1:
	LOOP LPSTR_1
	
	;add '$' to the end
	CALL ENDSTR_SI
	;display content
	MOV AH, 2
	PUSH DX
	MOV DL, 0AH
	INT 21H
	POP DX

	ADD DX, 2
	CALL DISP_DX
	LEA DX, EXT_PRMT
	CALL DISP_DX
	MOV AH, 7
	INT 21H
	
	;esc--1BH,neq->circle
	CMP AL,1BH
	JNE PROC_1
	
	;display "\n"
	MOV AH, 2
	MOV DL, 0AH
	INT 21H
	
	POP CX
	POP SI
	POP AX
	POP DX
	RET
FUN1 ENDP

FUN2 PROC
	PUSH DX
	PUSH AX
	PUSH CX
	PUSH SI
	
PROC_2:
	;share prompt with fun1
	LEA DX,FUN1_WD
	CALL DISP_DX
	;share data buffer with func1
	LEA DX,FUN1_BUF
	MOV SI,DX
	CALL INPUT_DX
	
	INC SI
	MOV CL,[SI]
	MOV CH,0
	MOV DL,[SI+1]
	
	;compare string
CMP2:
	INC SI
	CMP DL,[SI]
	JG CONT2
	MOV DL,[SI]
CONT2:
	LOOP CMP2
	
	MOV DH,DL
	MOV DL,0AH
	MOV AH,2
	INT 21H
	MOV DL,DH
	INT 21H
	
	;end sequence
	LEA DX, EXT_PRMT
	CALL DISP_DX
	MOV AH, 7
	INT 21H
	;esc--1BH,neq->circle
	CMP AL,1BH
	JNE PROC_2
	
	;display "\n"
	MOV AH, 2
	MOV DL, 0AH
	INT 21H
	
	POP SI
	POP CX
	POP AX
	POP DX
	RET
FUN2 ENDP
 
FUN3 PROC
	PUSH DX
	PUSH CX
	PUSH SI
	PUSH DI
PROC_3:
	LEA DX,FUN1_WD
	CALL DISP_DX
	LEA DX,FUN1_BUF
	CALL INPUT_DX
	
	MOV SI,DX
	INC SI
	MOV CL,[SI]
	MOV CH,0
	;wordcount->CL
	MOV DI,SI
	;add '$' to the end
	ADD SI,CX
	CALL ENDSTR_SI
	;CX=0/CX=1,skip
	CMP CX,1
	JLE SKIP
	
	DEC CX
	
LOOP1_3:
	;outer loop, save current CL(outer cycle count) to DL
	MOV SI,DI
	MOV DL,CL
LOOP2_3:
	;inner loop
	INC SI
	MOV DH,[SI]
	CMP DH,[SI+1]
	JG CONT_3
	;SI[i]<SI[i+1]-->exchange
	XCHG DH,[SI+1]
	MOV [SI],DH
	
CONT_3:
	LOOP LOOP2_3
	;end of one cycle of sort,get CL from DL
	MOV CL,DL
	LOOP LOOP1_3
SKIP:
	MOV AH, 2
	MOV DL, 0AH
	INT 21H
	
	MOV DX, DI
	INC DX
	CALL DISP_DX
	
	;end sequence
	LEA DX, EXT_PRMT
	CALL DISP_DX
	MOV AH, 7
	INT 21H
	;esc--1BH,neq->circle
	CMP AL,1BH
	JNE PROC_3
	
	;display "\n"
	MOV AH, 2
	MOV DL, 0AH
	INT 21H
	
	POP DI
	POP SI
	POP CX
	POP DX
	RET
FUN3 ENDP

FUN4 PROC
	PUSH DX
	PUSH AX
	
	LEA DX,FUN4_WD
	MOV AH,9
	INT 21H
	
	POP AX
	POP DX
	RET
FUN4 ENDP

CODES ENDS
    END START













