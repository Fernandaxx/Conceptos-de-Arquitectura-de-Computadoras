; Escribir un programa que cuente la cantidad de veces que un determinado caracter aparece en una cadena de texto. Observar 
; cómo se almacenan en memoria los códigos ASCII de los caracteres (código de la letra “a” es 61H). Utilizar la instrucción lbu 
; (load byte unsigned) para cargar códigos en registros. La inicialización de los datos es la siguiente:  .data 
;   cadena: .asciiz "adbdcdedfdgdhdid" ; cadena a analizar 
;   car: .asciiz "d" ; caracter buscado 
;   cant: .word 0 ; cantidad de veces que se repite el caracter car en cadena. 


; forwarding deshabilitado
; delay slot deshabilitado
	.data
cadena: 	.asciiz "adbdcdedfdgdhdid" 	; cadena a analizar 
car: 	.asciiz "d" 		; caracter buscado 
cant: 	.word 0 		; cantidad de veces que se repite el caracter car en cadena. 

	.code
	lbu r1, cadena(r0)	; guardo en r1 los caracteres de la cadena
	dadd r2, r0, r0		; guardo en r2 el indice de la cadena
	lw r3, cant(r0)		; guardo en r3 cant
	lw r4, car(r0)		; guardo en r4 car

loop:	beq r1, r0, fin		; si la cadena esta vacia termino el programa
	daddi r2, r2, 1		; incremento el indice
	bne r1, r4, no_sumar	; si el caracter no coincide no contar
	daddi r3, r3, 1		; aumento en 1 la cantidad de coincidencias
no_sumar: 	lbu r1, cadena(r2)	; guardo en r1 el siguiente caracter
	j loop		; loopeo

fin:	sw r3, cant(r0)		; guardo cant en memoria
	halt





