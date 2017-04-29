ASSUME CS:CODIGO, DS:DATOS, SS:PILA

;CONVERTIR UN NÚMERO EN FORMATO B16 A B10: (La lógica de este programa está en el cuaderno)
;SE IMPLEMENTARÁ EN FORMA DE SUBRUTINA PARA QUE SEA REUTILIZABLE EN OTROS CÓDIGOS.

;A TENER EN CUENTA:	*EL USO DE LA PILA.
;					*EL NÚMERO MÁXIMO QUE SE MOSTRARÁ EN PANTALLA ES 65535.
;					*RELLENAR DE CEROS EL REGISTRO DX PARA PODER HACER LA OPERACIÓN AX=DX:AX/OP.
;					*CONVERSIÓN DE DECIMAL A ASCII, PORQUE SÓLO SE IMPRIMEN CARACTERES ASCII.

CODIGO SEGMENT	
	MOV AX,DATOS
	MOV DS,AX
	
	;SE PONE EN AX EL NÚMERO QUE SE CONVERTIRÁ DE B16 A B10:
	MOV AX, 0ABCDH 	
	CALL IMPRIMIR_DECIMAL
	MOV AH, 4CH
	INT 21H

			IMPRIMIR_DECIMAL PROC
				MOV BX, 0AH		;EN BX SE ALMACENA EL DIVISOR A.
			IMPDECI2:
				CMP AX, 0H		;COMPRUEBA SI EL DIVISOR HA LLEGADO A CERO, SI ES CERO ENTONCES SALTA A IMPRIMIR.
				JE IMPDECI1
				MOV DX, 0H		;SE HACE USO DE LA OPERACIÓN AX=DX:AX/OP, PARA ESO DX DEBE RELLENARSE DE CEROS.
				DIV BX
				PUSH DX			;SE PONE EL RESIDUO DE LA DIVISIÓN EN LA PILA.
				INC I
				JMP IMPDECI2
			IMPDECI1:
				LEA DX, MENSAJE2
				MOV AH, 09H
				INT 21H
			IMPDECI3:
				CMP I, 0H
				JE FIN_IMPRIMIR
				POP DX			;SE SACA DE LA PILA EL RESIDUO QUE SE INGRESÓ.
				ADD DX, 30H		;SE SUMA 30H PARA HACER LA CONVERSIÓN DE DECIMAL A ASCII.
				MOV AH, 02H
				INT 21H
				DEC I
				JMP IMPDECI3
			FIN_IMPRIMIR:
				RET
			IMPRIMIR_DECIMAL ENDP
	
	
	;EXPLICACIÓN: (http://www.lawebdelprogramador.com/foros/Ensamblador/25978-Necesito-convertir-hexa-a-decimal-en-ensamblador.html)
	
		;IMAGINA QUE TIENES EL NÚMERO 2F8 Y QUIERES SABER CUANTO VALE EN DECIMAL. LO PRIMERO QUE HAY QUE HACER ES DIVIDIRLO POR 10D (O 0AH). EL RESULTADO SERÁ 4CH, Y EL RESTO (QUE TAMBIÉN ES IMPORTANTE) SERÁ 0.
		;ESE 0 SERÁ EL PRIMER DÍGITO DE LA DERECHA DEL NÚMERO EN DECIMAL. SEGUIMOS. TENEMOS EL RESULTADO 4CH, Y REPETIMOS LA OPERACIÓN. AL DIVIDIRLO POR 10D (0AH) OBTENEMOS EL NÚMERO 07H, Y COMO RESTO 6. ESE SERÁ 
		;EL SIGUIENTE DÍGITO EN DECIMAL DEL NÚMERO. Y REPETIMOS. TENEMOS EL 07H, LO DIVIDIMOS POR 0AH, Y OBTENEMOS COMO RESULTADO 0, Y COMO RESTO 7, QUE SERÁ EL SIGUIENTE DÍGITO. POR ÚLTIMO NOS DAMOS CUENTA DE QUE 
		;EL ÚLTIMO RESULTADO OBTENIDO ES 0, A SI ES QUE NO CONTINUAMOS DIVIDIENDO. TOTAL, TENEMOS LOS DÍGITOS 0, 6 Y 7. TENEMOS QUE ESCRIBIRLOS EN ORDEN INVERSO, ES DECIR: 760, JUSTO EL VALOR DE 2F8H EN DECIMAL. 
		;PARA HACERLO EN ENSAMBLADOR, LO MEJOR ES IR DIVIDIENDO Y METIENDO LOS RESTOS DE CADA DIVISIÓN EN LA PILA. CUANDO EL RESULTADO DE LA DIVISIÓN SEA 0, SACAMOS TANTOS DÍGITOS DE LA PILA COMO DIVISIONES HAYAMOS 
		;HECHO, Y LOS VAMOS ESCRIBIENDO. AL USAR LA PILA DAMOS "LA VUELTA" A LOS RESTOS, ES DECIR SACAREMOS EL ÚLTIMO DE LA PILA AL PRIMERO QUE HAYAMOS CALCULADO, POR LO QUE LO ESCRIBIREMOS JUSTO EN EL DÍGITO DE LA 
		;DERECHA COMO NECESITAMOS.
	
CODIGO ENDS

PILA SEGMENT STACK
	DW 32 DUP (0)
PILA ENDS

DATOS SEGMENT
I DW 0H ;CUENTA LA CANTIDAD DE VECES QUE SE HA INGRESADO UN DATO EN LA PILA (SE HA DIVIDIDO AX) CON EL FIN DE SABER 
			;CUÁNTAS VECES SE DEBE DE SACAR UN DATO DE LA MISMA Y LUEGO SER IMPRIMIDO EN PANTALLA.
MENSAJE2 DB "EL NUMERO CONVERTIDO A DECIMAL ES: $"
DATOS ENDS

END
