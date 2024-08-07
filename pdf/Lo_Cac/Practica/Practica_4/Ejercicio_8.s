; Escribir un programa que multiplique dos números enteros utilizando sumas repetidas (similar al Ejercicio  7 de la Práctica 1). 
; El programa debe estar optimizado para su ejecución con la opción Delay Slot habilitada. 

	.data
a:	.word 7
b:	.word 3
c:	.word 0

	.code

	; c = a * b
	; programa optimizado para su ejecucion con la opcion Delay Slot habilitado

	lw r1, a(r0)		; r1 guarda a
	lw r2, b(r0)		; r2 guarda b
	dadd r3, r0, r0		; r3 guarda c, inicia en 0

	beq r1, r0, fin
	beq r2, r0, fin
	
	daddi r2, r2, -1
loop:	dadd r3, r3, r1		; guardo en r3 la suma a reiteradamante b veces
	bne r2, r0, loop	; salto al loop 
	daddi r2, r2, -1	; como DelaySlot esta habilitada decremento r2 despues

fin:	sw r3, c(r0)
	halt