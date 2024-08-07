; * Escriba  un  programa  que  solicite  el  ingreso  por  teclado  de  una  clave  (sucesión  de  cuatro  caracteres)  utilizando  la 
; * subrutina char de ingreso de un carácter. 
; * Luego, debe comparar la secuencia ingresada con una cadena almacenada en  la  variable  clave.  
; * Si  las  dos  cadenas  son  iguales  entre  si,  la  subrutina  llamada  respuesta  mostrará  el  texto “Bienvenido” en  la  
; * salida  estándar del  simulador  (ventana  Terminal).  
; * En  cambio,  si  las  cadenas  no  son  iguales,  la  subrutina deberá mostrar “ERROR” y solicitar nuevamente el ingreso de la clave.



	.data
CONTROL:	.word32 0x10000
DATA:	.word32 0x10008

okey:	.asciiz "[+] Bienvenido :D"
error:	.asciiz "[-] ERROR !!! >:^C"

enter:	.byte 0x0a

clave:	.asciiz "pass"
leido:	.asciiz "0000"

	.code

	lwu $s0, DATA($0)	; $s0 guarda direccion DATA
	lwu $s1, CONTROL($0)	; $s1 guarda direccion CONTROL


	daddi $t2, $0, 6	; $t2 guarda 6 -> funcion 6 limpiar consola
	sd $t2, 0($s1)		; CONTROL recibe 6


ingresar:	
	dadd $t0, $0, $0	; $t0 contador cantidad caracteres e indice
	daddi $t1, $0, 4	; $t1 guarda leido size



loop:	
	jal char		; $v0 guarda caracter leido

	sb $v0, leido($t0)		; almacena caracteres 

	daddi $t0, $t0, 1	; incremento contador

	bne $t0, $t1, loop	; loopeo si contador no llega a 0 //  0 -> 1 -> 2 -> 3  

	; Reviso que los textos sean iguales

	daddi $a0, $0, clave	; direccion texto 1
	daddi $a1, $0, leido	; direccion texto 2

	jal subrutina
	dadd $t6, $v0, $0

	dadd $t7, $0, $0	; $t1 seteo 0
	slt $t7, $v0, $0	; $t1 guarda 1 si subrutina retorno -1


	bne $t7, $0, passCorrecta	; textos iguales

passIncorrecta:	daddi $t0, $0, error	; $t0 guarda direccion mensaje error
	sd $t0, 0($s0)		; $s0 guarda direccion asciiz


	daddi $t2, $0, 4	; $t2 guarda 4 -> funcion 4 imprime ascii
	sd $t2, 0($s1)		; CONTROL recibe 4


	; imprime enter

	daddi $t2, $0, enter	; guardo direccion ascii enter
	sd $t2, 0($s0)		; guando en DATA dereccion asciiz

	daddi $t2, $0, 4	; $t2 guarda 4 -> funcion 4 imprime ascii
	sd $t2, 0($s1)		; CONTROL recibe 4

	j ingresar

passCorrecta:	daddi $t0, $0, okey	; $t0 guarda direccion mensaje error
	sd $t0, 0($s0)		; $s0 guarda direccion asciiz


	daddi $t2, $0, 4	; $t2 guarda 4 -> funcion 4 imprime ascii
	sd $t2, 0($s1)		; CONTROL recibe 4


	halt




char:	daddi $t2, $0, 9	; $t2 guarda 9 -> funcion 9 leer caracter
	sd $t2, 0($s1)		; CONTROL recibe 9

	lbu $v0, 0($s0)		; guardo en $v0 caracter leido	

	jr $ra

	; recibe como parametro direccion de texto 1 en a0
	; recibe como parametro direccion de texto 2 en a1
	; retorna en v0 -1 si son iguales, o posicion donde son distintos
subrutina:	daddi $v0, $zero, -1
	
textosLoop:	lbu $t1, ($a0)		; t1 caracteres texto1
	lbu $t2, ($a1)		; t2 caracteres texto2

	beq $t1, $t2, iguales	; caracteres iguales salto

	; textos difieren

	dadd $v0, $a0, $zero	; guardo en v0 el indice
	j fin

iguales:	daddi $a0, $a0, 1	; incremento indice
	daddi $a1, $a1, 1	; incremento indice
	bnez $t1, textosLoop

fin:	jr $ra
