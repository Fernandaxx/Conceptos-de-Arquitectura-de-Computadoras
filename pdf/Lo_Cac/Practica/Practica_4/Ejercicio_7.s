; Escribir un programa que recorra una TABLA de diez números enteros y determine cuántos elementos son mayores que X. El 
; resultado debe  almacenarse  en una  dirección etiquetada  CANT. El programa  debe  generar además otro arreglo llamado RES 
; cuyos elementos sean ceros y unos. Un ‘1’ indicará que el entero correspondiente en el  arreglo  TABLA  es  mayor  que  X, 
; mientras que un ‘0’ indicará que es menor o igual.

; slt     rd, rf, rg Compara rf con rg, dejando rd=1 si rf es menor que rg (valores con signo)
; rd = rf < rg

; 0  =  1 < 0
; 0  =  0 < 0
; 1  = -1 < 0

	.data
cant:	.word 0
tabla:	.word 1,2,3,4,5,6,7,8,9,10
res:	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
tablaLength:	.word 10
num:	.word 5

	.code

	; set registros
	lw r1, tabla(r0) 	; r1 guarda valores de la tabla
	dadd r2, r0, r0 	; r2 guarda el indice, inicia en 0 y aumenta en 8
	lw r3, num(r0)		; r3 guarda valor x
	dadd r4, r0, r0		; r4 guarda 1 si el valor de la tabla es mayor a x
	dadd r5, r0, r0		; r5 guarda cant
	lw r6, tablaLength(r0) 	; r6 es contador, de 10 a 0

loop:	lw r1, tabla(r2)	; guardo en r1 el valor a analizar

	slt r4, r3, r1		; guarda 1 en r4 si el valor de la tabla es estrictamente mayor que r3 (r3 < r1)
	sw r4, res(r2)                  ; guardo 1 en res cuando el valor de la tabla es mayor a x

	dadd r5, r5, r4		; incremento el registro que guarda el valor de cant

	daddi r2, r2, 8		; guardo en r2 indice a analizar
	daddi r6, r6, -1	; decremento contador
	bne r6, r0, loop	; en todo caso loopeo

	sw r5, cant(r0)		; guardo cant en memoria

	halt