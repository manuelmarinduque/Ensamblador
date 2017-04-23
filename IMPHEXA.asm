ASSUME CS:CODIGO, DS:DATOS, SS:PILA

;IMPRIMIR POR PANTALLA UN RESULTADO O NÚMERO EN HEXADECIMAL:
;Hecho mediante la operación lógica AND rotación ROR de bits de 4 en 4. La lógica está en el cuaderno.

CODIGO SEGMENT	
	MOV AX,DATOS
	MOV DS,AX
	
	;EN H SE ALMACENARÁ EL NÚMERO A MOSTRAR POR PANTALLA:
	MOV H, 5845
	CALL TRANSFORMAR
	MOV AH, 4CH
	INT 21H
			
			TRANSFORMAR PROC
				MOV AH, 09H
				LEA DX, MENSAJE
				INT 21H
				MOV DX, H			
				AND DX, A			;EL AND HACE QUE LOS DEMÁS DÍGITOS SE VUELVAN CERO Y SÓLO QUEDE EL DÍGITO DE LA POSICIÓN QUE SE DESEA IMPRIMIR.
				ROR DX, 12			;SE HACE LA ROTACIÓN PARA QUE EL DÍGITO QUE SE DESEA IMPRIMIR QUEDE JUSTO EN LA ESQUINA DERECHA, PARTE BAJA DE DX.
				CALL IMPRIMIR_HEXADECIMAL
				MOV DX, H			
				AND DX, B
				ROR DX, 8
				CALL IMPRIMIR_HEXADECIMAL
				MOV DX, H			
				AND DX, D
				ROR DX, 4
				CALL IMPRIMIR_HEXADECIMAL
				MOV DX, H			
				AND DX, E
				;ROR DX, 0			;LA ROTACIÓN DE BITS A LA DERECHA VA DECREMENTANDO DE 4 EN 4.
				CALL IMPRIMIR_HEXADECIMAL
				RET
			TRANSFORMAR ENDP
	
			;SUBRUTINA QUE IMPRIME UN NÚMERO EN HEXADECIMAL 
			IMPRIMIR_HEXADECIMAL PROC		
				CMP DL, 09H
				JG IMP1
				ADD DL, 30H		;EN EL CASO QUE SE DEBA IMPRIMIR UN DÍGITO ENTRE 0 Y 9.
				JMP IMP2
			IMP1:
				ADD DL, 37H		;EN EL CASO QUE SE DEBA IMPRIMIR UN DÍGITO ENTRE A Y F.
			IMP2:
				MOV AH, 2H
				INT 21H
				RET
			IMPRIMIR_HEXADECIMAL ENDP     
CODIGO ENDS

PILA SEGMENT STACK
	DW 32 DUP (0)
PILA ENDS

DATOS SEGMENT
H DW 0H			;EN H SE ALMACENARÁ EL NÚMERO A MOSTRAR POR PANTALLA.
A DW 0F000H
B DW 00F00H
D DW 000F0H
E DW 0000FH
MENSAJE DB "EL RESULTADO ES: $"
DATOS ENDS

END