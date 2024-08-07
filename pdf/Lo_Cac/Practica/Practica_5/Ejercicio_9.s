	.data 
valor: 	.word 10
result: 	.word 0 
  
	.text 
	daddi $sp, $0, 0x400 ; Inicializa el puntero al tope de la pila (1) 
	ld    $a0, valor($0) 
	jal   factorial 
	sd    $v0, result($0) 
	halt 
 
factorial:	daddi $v0, $zero, 1

	; prologue
factorialRec:	daddi $sp, $sp, -16	; reduzco pila en tamanio de frame
	sd $ra, 0($sp) 		; guardo return address
	sd $a0, 8($sp)		; guardo parametro1

	; code

	dmul $v0, $v0, $a0	; multiplico factorial
	daddi $a0, $a0, -1	; reduzco contador

	beqz $a0, no_saltar	; si el contador esta en 0 no sigo el loop

	jal factorialRec	; seguir el factorial


	; epilogue
no_saltar:	ld $ra, 0($sp)		; recupero return address
	ld $a0, 8($sp)		; recupero parametro1
	daddi $sp, $sp, 16	; incremento pila tamanio de frame

	jr $ra
 
 
 
 
 