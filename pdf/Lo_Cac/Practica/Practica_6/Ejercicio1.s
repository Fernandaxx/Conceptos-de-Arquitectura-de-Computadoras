	.data 
CONTROL: 	.word32 0x10000 
DATA: 	.word32 0x10008 
fin:	.ascii "0"
texto:	.asciiz "0"



 	.text 

	lbu $t2, fin($0)	; $t2 guarda caracter "0"
	dadd $t3, $0, $0	; t3 contador byte a byte 

 	lwu $s0, DATA(r0) 	; $s0 = dirección de DATA 
	;daddi  $t0, $0, texto 	; $t0 = dirección del mensaje a mostrar 
	;sd $t0, 0($s0) 		; DATA recibe el puntero al comienzo del mensaje 

	lwu $s1, CONTROL(r0) 	; $s1 = dirección de CONTROL 
	daddi  $t0, $0, 6 	; $t0 = 6 -> función 6: limpiar pantalla alfanumérica 
	sd $t0, 0($s1) 		; CONTROL recibe 6 y limpia la pantalla 

loop:	daddi $t0, $0, 9	; $t0 = 9 -> funcion 9: recibe caracter de teclado
	sd $t0, 0($s1)		; CONTROL recibe 9 y lee desde teclado

	lbu $t1, 0($s0)		; guardo en t1 caracter ingresado

	beq $t1, $t2, imprimir	; si el caracter no es '0' loopeo
	
	sb $t1, texto($t3)	; guardo el caracter en texto	
	daddi $t3, $t3, 1	; siguiente byte (caracter)

	j loop

imprimir:	dadd $t1, $0, $0	; caracter nulo
	sb $t1, texto($t3)	; caracter nulo al final del texto	

	daddi  $t0, $0, texto 	; $t0 = dirección del mensaje a mostrar 
	sd $t0, 0($s0) 		; DATA recibe el puntero al comienzo del mensaje 

	daddi  $t0, $0, 4 	; $t0 = 4 -> función 4: salida de una cadena ASCII 
	sd $t0, 0($s1) 		; CONTROL recibe 4 y produce la salida del mensaje 


	halt