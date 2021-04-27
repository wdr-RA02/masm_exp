; model asm file for asm programming.
DATA SEGMENT
	; data here
DATA ENDS

CODE SEGMENT
	ASSUME CS:CODE, DS:DATA
	MOV AX,DATA
	MOV DS,AX
START:
	; code here

	; code ends, back to dos.
	MOV AL,4CH
	INT 21H
	
CODE ENDS
	END START
