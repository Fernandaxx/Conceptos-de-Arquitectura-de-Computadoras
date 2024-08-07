; * Escriba una subrutina que reciba como parámetros un número positivo M de 64 bits, la dirección del comienzo de una 
; * tabla  que  contenga  valores  numéricos  de  64  bits  sin  signo  y  la  cantidad  de  valores  almacenados  en  dicha  tabla. 
; * La subrutina debe retornar la cantidad de valores mayores que M contenidos en la tabla.

	.data
m:	.word 33
tabla:	.word 2, 17, 9, 23, 33, 10, 12
tamanio:	.word 7

	.code

	ld $a0, m($zero)	; guardo en parametro1 el valor M
	daddi $a1, $zero, tabla	; guardo en parametro2 el offset de tabla
	ld $a2, tamanio($zero)	; guardo en parametro3 el size de la tabla

	jal subrutina 

	halt


subrutina:	dadd $v0, $zero, $zero
loop:	ld $t0, ($a1) 

	slt $t1, $t0, $a0	; guardo 1 en t1 si valor_tabla < M
	bnez $t1, no_sumar	; si m es menor no sumo
	beq $t0, $a0, no_sumar 	; si m es igual no sumo
	daddi $v0, $v0, 1	; incremento cantidad de numeritos mayores a M

no_sumar:	daddi $a1, $a1, 8
	daddi $a2, $a2, -1
	bnez $a2, loop
	jr $ra
