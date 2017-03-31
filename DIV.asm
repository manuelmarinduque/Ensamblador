ASSUME CS:CODIGO, DS:DATOS, SS:PILA

CODIGO SEGMENT	
	MOV AX,DATOS
	MOV DS,AX
	
	;OPERACIONES DE LA DIVISIÓN:
	
	;	1) AX=DX:AX/BX	- RESTO=DX	DIVISIÓN DE UN NÚMERO DE 32 BITS (DOBLE WORD) ENTRE UNO DE 16 BITS (1 PALABRA).
	;								PREVIAMENTE SE DEBE DE TENER DECLARADO EL NÚMERO DE 32 BITS EN EL REGISTRO DX:AX.
	;								EL RESULTADO SE ALMACENA EN UN REGISTRO DE 16 BITS.
	
	;	2) AL=AX/BL - RESTO=AH		DIVISIÓN DE UN NÚMERO DE 16 BITS (1 PALABRA) ENTRE UNO DE 8 BITS (1 BYTE).
	;								EL RESULTADO SE ALMACENA EN UN REGISTRO DE 8 BITS. *VER OBSERVACIÓN*
	
	
	;OPERACION 1)
	
	;DIVISIÓN DE UN NÚMERO DE 32 BITS ENTRE UNO DE 16 BITS:
	;SE DEBE TENER UN DATO PREVIAMENTE ALMACENADO EN DX:AX O DECLARARLO EN FORMATO HEXADECIMAL.
	;SE DECLARA EL DATO:
	MOV DX, 0060H
	MOV AX, 0C0C0H
	MOV BX, 0D228H
	DIV BX ;=0075H
	;			60C0C0H/D228H=0075H
	;			EL RESTO=B478 SE GUARDA EN DX
	
	
	;DIVISIÓN DE DOS NÚMEROS DE 16 BITS:
	MOV AX, 0B32EH
	MOV DX, 0H		;RELLENO DE 0's PARA AJUSTAR EL NÚMERO DE 16 BITS A UNO DE 32 BITS Y APLICAR LA OPERACIÓN 1)
	MOV BX, 640FH
	DIV BX ;=1H - RESTO=4F1FH
	
	
	;OPERACIÓN 2)
	
	;DIVISIÓN DE UN NÚMERO DE 16 BITS ENTRE UNO DE 8 BITS:
	MOV AX, 53800 
	MOV BL, 230
	DIV BL ;=E9H
	;			0D228H/E6H=E9H
	;			EL RESTO=D2H SE GUARDA EN AH

	
	;DIVISIÓN DE DOS NÚMEROS DE 8 BITS:
	MOV AX, 0FFH 		;EL NÚMERO DE 8 BITS SE GUARDA EN UN REGISTRO DE 16 BITS.
	MOV BL, 4H
	DIV BL ; =3FH - RESTO=03H
	
	;OBSERVACIÓN:
	
	;CUANDO SE REALIZA UNA DIVISIÓN PRIMERO SE TOMA EN CUENTA SI SU RESULTADO CABE DENTRO DEL REGISTRO QUE SE ALMACENA: AL PARA 8 BITS Y AX PARA 16 BITS.
	
	;AQUÍ UN EJEMPLO DE LA DIVISIÓN DE UN NÚMERO DE 16 BITS ENTRE UNO DE 8 BITS QUE USUALMENTE SE HARÍA MEDIANTE LA OPERACIÓN 2: 1000H/10H=100H. EL RESULTADO
	;100H EN DECIMAL ES 256, NÚMERO QUE NO SE PUEDE ALMACENAR EN UN REGISTRO AL, POR LO TANTO ESTA DIVISIÓN NO SE HACE MEDIANTE LA OPERACIÓN 2 SI NO QUE MEDIANTE
	;LA OPERACIÓN 1 QUE GUARDA EN SU REGISTRO AX UN NÚMERO DE 16 BITS.
	;PARA PODER LLEVAR A CABO LA ANTERIOR DIVISIÓN SE SIGUE EL MISMO PROCEDIMIENTO QUE LA DIVISIÓN DE DOS NÚMEROS DE 16 BITS, ES DECIR, PASAR EL NÚMERO DE 16 BITS
	;A UN NÚMERO DE 32 BITS RELLENANDO DE 0's LA PARTE ALTA (EL REGISTRO DX), Y ALMACENANDO EL NÚMERO DE 8 BITS EN EL REGISTRO BX DE 16 BITS:
	
	MOV AX, 1000H
	MOV DX, 0H	;RELLENO DE 0's PARA AJUSTAR EL NÚMERO DE 16 BITS A UNO DE 32 BITS Y APLICAR LA OPERACIÓN 1)
	MOV BX, 10H
	DIV BX ;=100H - RESTO=0H

	;CONCLUSIONES:
	
		;LA DIVISIÓN NO ES CONMUTATIVA.
		;NO SE PUEDE DIVIDIR UN NÚMERO DE 32 BITS ENTRE OTRO DE 32 BITS PORQUE NO VA A HABER UN REGISTRO QUE GUARDE EL DIVISOR.
		;TENER MUY EN CUENTA LA OBSERVACIÓN CUANDO SE DIVIDE UN NÚMERO DE 32 BITS ENTRO UN NÚMERO DE 16 BITS, HAY VECES EN QUE EL NÚMERO DE 32 BITS ES TAN GRANDE
		;QUE AL DIVIDIRSE POR UN NÚMERO DE 16 BITS VA A PRODUCIR UN NÚMERO DE 32 BITS EL CUAL NO SE PODRÍA ALMACENAR.
		
	MOV AH,4Ch  
	INT 21h         
CODIGO ENDS

PILA SEGMENT STACK
	DW 32 DUP (0)
PILA ENDS

DATOS SEGMENT

DATOS ENDS

END