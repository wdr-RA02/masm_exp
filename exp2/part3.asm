;part3 of exp2: bin to ascii
DATAS SEGMENT
;datas 
    SRC DW 3500H
    DES DW 3510H  
    COUNT DW 5
DATAS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS
START:
    MOV AX,DATAS
    MOV DS,AX
;code start

	;src address
	MOV SI, SRC
	;dest index
	MOV DI, DES
	ADD DI, COUNT
	;get orig number
	MOV AX, [SI]
	
DIVIDE:
	;DI--
	DEC DI
	;clear out DX and BX
	MOV DX, 0
	MOV BX, 10
	;AX/BX->(AX---DX)
	DIV BX
	;change DX to ASCII 
	ADD DX, 30H
	MOV [DI], DL

	CMP AX, 0
	JA DIVIDE
	
	;judge if 30H fill is needed
	CMP DI, DES
	JBE TERM
	;fill 30H for the rest
FILL:
	DEC DI
	MOV DX, 30H
	ADD [DI], DX
	CMP DI, DES
	JA FILL
	
;code end
TERM:
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START





