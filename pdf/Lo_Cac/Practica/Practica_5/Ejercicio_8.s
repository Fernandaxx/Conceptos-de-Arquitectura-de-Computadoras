; * Escriba una subrutina que reciba como parámetros las direcciones del comienzo de dos cadenas terminadas en cero y 
; * retorne la posición en la que las dos cadenas difieren. En caso de que las dos cadenas sean idénticas, debe retornar -1. 



	.data
texto1:	.asciiz "Texto2auosenhthtankoeatshneuhueaohtnshtnstthneuashtanseuohtsnhtnsuaeothnsauaetonhsuaetonhshtnsuuehtnseuaonhtseuhtasnohtnseuoetnuhsoa "
texto2:	.asciiz "Texto2auosenhthtankoeatshneuhueaohtnshtnstthneuashtanseuohtsnhtnsuaeothnsauaetonhsua0tonhshtnsuuehtnseuaonhtseuhtasnohtnseuoetnuhsoa "

	.code

	daddi $a0, $zero, texto1	; guardo en parametro1 el offset texto1
	daddi $a1, $zero, texto2	; guardo en parametro2 el offset texto2

	jal subrutina

	halt



subrutina:	daddi $v0, $zero, -1
	
loop:	lbu $t1, ($a0)		; t1 caracteres texto1
	lbu $t2, ($a1)		; t2 caracteres texto2

	beq $t1, $t2, iguales	; caracteres iguales salto

	; textos difieren

	dadd $v0, $a0, $zero	; guardo en v0 el indice
	j fin

iguales:	daddi $a0, $a0, 1	; incremento indice
	daddi $a1, $a1, 1	; incremento indice
	bnez $t1, loop

fin:	jr $ra




