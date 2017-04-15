ASSUME CS:CODIGO, DS:DATOS, SS:PILA

CODIGO SEGMENT	
	MOV AX,DATOS
	MOV DS,AX
	
	;RESTAR DOS NÚMEROS, TANTO LOS OPERANDOS COMO EL RESULTADO SE ALMACENAN EN VARIABLES DE MEMORIA DE 16 BITS.
	
	;RESTA DE DOS NÚMEROS DE 16 BITS:
	
	MOV AX, OP1
	MOV BX, OP2
	SUB AX, BX ;= 2A4E
	MOV RES, AX
	
	;RESTA DE DOS NÚMEROS DE 8 BITS EN REGISTROS DE 16 BITS:
	;CUANDO EL NUMERO A RESTAR ES MAYOR
	
	MOV AX, OP4
	MOV BX, OP3
	SUB AX, BX ;= FFEF
	MOV RES+2, AX  ; RECORDAR QUE EL VECTOR ES DE TIPO DW (PALABRA) Y SE MUEVE DE 2 EN 2.

	MOV AH,4Ch  
	INT 21h         
CODIGO ENDS

PILA SEGMENT STACK
	DW 32 DUP (0)
PILA ENDS

DATOS SEGMENT
OP1 DW 36520
OP2 DW 25690
;LOS RESULTADOS SE GUARDAN EN UN VECTOR DW (PALABRA) CON 10 PALABRAS RESERVADAS EN EL DS.
RES DW 10 DUP(?)
OP3 DW 69
OP4 DW 52
DATOS ENDS

END