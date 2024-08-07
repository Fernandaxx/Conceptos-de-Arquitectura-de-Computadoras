	.data 
valor: 	.word 6
result: 	.word 0 
  
	.text 
	daddi $sp, $0, 0x400 ; Inicializa el puntero al tope de la pila (1) 
	ld    $a0, valor($0) 
	jal   factorial 
	sd    $v0, result($0) 
	halt 
 
factorial:	daddi $v0, $zero, 1	; inicio en 1
loop:	dmul $v0, $v0, $a0	; multiplico factorial
	daddi $a0, $a0, -1	; reduzco contador
	beqz $a0, no_saltar	; si el contador esta en 0 no sigo el loop
	j loop	; seguir el factorial
no_saltar:	jr $ra
 
 
 
 
 