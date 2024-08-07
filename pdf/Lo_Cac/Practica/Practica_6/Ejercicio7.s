; * Se desea realizar la demostración de la transformación de un carácter codificado en ASCII a  su visualización en una 
; * matriz de  puntos con 7  columnas  y 9  filas. Escriba un programa  que realice  tal demostración, solicitando el ingreso 
; * por teclado de un carácter para luego mostrarlo en la pantalla gráfica de la terminal.



	.data
CONTROL:	.word32 0x10000
DATA:	.word32 0x10008

validos:	.asciiz "012abcA"
banner:	.asciiz "[*] Ingrese caracter: "
bannerInv:	.asciiz "[-] Caracter no conocido!!!"

negro:	.byte 0, 0, 0, 0

	.code

	lwu $s0, CONTROL($0)	; $s0 guarda CONTROL
	lwu $s1, DATA($0)	; $s0 guarda DATA


	daddi $t0, $0, 7	; $t0 guarda 7 funcion limpiar graficos
	sd $t0, 0($s0)		; CONTROL recibe funcion 7 limpiar grafico

	daddi $t0, $0, banner	; $t0 guarda direccion banner
	sd $t0, 0($s1)		; DATA recibe direccion banner

	daddi $t0, $0, 4	; $t0 guarda 4 funcion imprimr texto
	sd $t0, 0($s0)		; CONTROL recibe funcion 4 imprimir texto

	daddi $t0, $0, 9	; $t0 guarda 9 funcion ingresar caracter
	sd $t0, 0($s0)		; CONTROL recibe funcion 4 imprimir texto

	lbu $a0, 0($s1)		; $a0 guarda caracter ingresado

	jal selectChar		; retorna -1 si no se encuentra caracter, posiscion donde esta en validos si se encuentra

	daddi $t0, $0, -1	; $t0 guarda valor de caracter invalido
	beq $v0, $t0, finalizar	; si el caracter es invalido no lo imprime

	dadd $a0, $v0, $0	; envio como parametro posicion caracter valido imprimir
	jal imprimir

finalizar:	halt



selectChar:	dadd $v0, $0, $0	; $v0 guarda indice	
	
selectLoop:	lbu $t1, validos($v0)	; $t1 guarda caracter
	beq $t1, $0, selectFin	; Si se finaliza la cadena de caracteres validos finalizo

	dadd $v0, $v0, $0	; $v0 devuelve 
	beq $t1, $a0, selectOkey	; si el caracter es valido se finaliza 

	daddi $v0, $v0, 1	; incremento indice
	j selectLoop

selectFin:	daddi $v0, $0, -1	; -1 caracter no encontrado
selectOkey:	jr $31



imprimir:	lwu $t1, negro($0)	; $t1 guarda color negro
	sw $t1, 0($s1)		; DATA recibe color negro

	dadd $t1, $0, $0	; $t1 guarda indice de caracter a imprimir
	bne $t1, $a0, imprimir1	; imprimir siguiente caracter

	; imprimir 0
	; 8   * * * 
 	; 7 *       *
	; 6 *       *
	; 5 
	; 4 *       *
	; 3 *       *
	; 2 *       *
	; 1   * * *
	; 0 
	; 0 1 2 3 4 5 6

	; colores inician en 0, 0, 0, 0 ( negro )
	; coordenada y 1
	daddi $t0, $0, 1	; coordenada y
	sb $t0, 4($s1)		; DATA recibe coordenada y

	; coordenada x
	daddi $t0, $0, 2	; coordenada x
	sb $t0, 5($s1)		; DATA recibe coordenada x
	
	daddi $t2, $0, 5	; $t2 guarda funcion 5
	sd $t2, 0($s0)		; CONTROL recibe funcion 5 graficar

	daddi $t3, $0, 2	; contador 2 pixeles
imprimirLH1:	daddi $t0, $t0, 1	; coordenada x
	sb $t0, 5($s1)		; DATA recibe coordenada x

	daddi $t2, $0, 5	; $t2 guarda funcion 5
	sd $t2, 0($s0)		; CONTROL recibe funcion 5 graficar

	daddi $t3, $t3, -1	; decerzco $t3
	bne $t3, $0, imprimirLH1	; loop


	; coordenada y 8
	daddi $t0, $0, 8	; coordenada y
	sb $t0, 4($s1)		; DATA recibe coordenada y

	; coordenada x
	daddi $t0, $0, 2	; coordenada x
	sb $t0, 5($s1)		; DATA recibe coordenada x
	
	daddi $t2, $0, 5	; $t2 guarda funcion 5
	sd $t2, 0($s0)		; CONTROL recibe funcion 5 graficar

	daddi $t3, $0, 2	; contador 2 pixeles
imprimirLH8:	daddi $t0, $t0, 1	; coordenada x
	sb $t0, 5($s1)		; DATA recibe coordenada x

	daddi $t2, $0, 5	; $t2 guarda funcion 5
	sd $t2, 0($s0)		; CONTROL recibe funcion 5 graficar

	daddi $t3, $t3, -1	; decerzco $t3
	bne $t3, $0, imprimirLH8	; loop



	; coordenada x 1
	daddi $t0, $0, 1	; coordenada y
	sb $t0, 5($s1)		; DATA recibe coordenada y

	; coordenada y
	daddi $t0, $0, 2	; coordenada x
	sb $t0, 4($s1)		; DATA recibe coordenada x
	
	daddi $t2, $0, 5	; $t2 guarda funcion 5
	sd $t2, 0($s0)		; CONTROL recibe funcion 5 graficar

	daddi $t3, $0, 5	; contador 2 pixeles
imprimirLV1:	daddi $t0, $t0, 1	; coordenada x
	sb $t0, 4($s1)		; DATA recibe coordenada x

	daddi $t2, $0, 5	; $t2 guarda funcion 5
	sd $t2, 0($s0)		; CONTROL recibe funcion 5 graficar

	daddi $t3, $t3, -1	; decerzco $t3
	bne $t3, $0, imprimirLV1	; loop



	; coordenada x 5
	daddi $t0, $0, 5	; coordenada y
	sb $t0, 5($s1)		; DATA recibe coordenada y

	; coordenada y
	daddi $t0, $0, 2	; coordenada x
	sb $t0, 4($s1)		; DATA recibe coordenada x
	
	daddi $t2, $0, 5	; $t2 guarda funcion 5
	sd $t2, 0($s0)		; CONTROL recibe funcion 5 graficar

	daddi $t3, $0, 5	; contador 2 pixeles
imprimirLV2:	daddi $t0, $t0, 1	; coordenada x
	sb $t0, 4($s1)		; DATA recibe coordenada x

	daddi $t2, $0, 5	; $t2 guarda funcion 5
	sd $t2, 0($s0)		; CONTROL recibe funcion 5 graficar

	daddi $t3, $t3, -1	; decerzco $t3
	bne $t3, $0, imprimirLV2	; loop


	j imprimirFin

imprimir1:	daddi $t1, $t1, 1	; $t1 guarda indice de caracter a imprimir
	bne $t1, $a0, imprimir2	; imprimir siguiente caracter

	daddi $t0, $0, bannerInv	; $t0 guarda inicio texto "invalido"
	sd $t0, 0($s1)		; DATA recibe inico texto

	daddi $t0, $0, 4	; $t0 guarda funcion imprimir texto
	sd $t0, 0($s0)		; CONTROL recibe llamado a imprimir texto

	j imprimirFin

imprimir2:	daddi $t1, $t1, 1	; $t1 guarda indice de caracter a imprimir
	bne $t1, $a0, imprimira	; imprimir siguiente caracter

	daddi $t0, $0, bannerInv	; $t0 guarda inicio texto "invalido"
	sd $t0, 0($s1)		; DATA recibe inico texto

	daddi $t0, $0, 4	; $t0 guarda funcion imprimir texto
	sd $t0, 0($s0)		; CONTROL recibe llamado a imprimir texto


	j imprimirFin

imprimira:	daddi $t1, $t1, 1	; $t1 guarda indice de caracter a imprimir
	bne $t1, $a0, imprimirb	; imprimir siguiente caracter

	daddi $t0, $0, bannerInv	; $t0 guarda inicio texto "invalido"
	sd $t0, 0($s1)		; DATA recibe inico texto

	daddi $t0, $0, 4	; $t0 guarda funcion imprimir texto
	sd $t0, 0($s0)		; CONTROL recibe llamado a imprimir texto

	j imprimirFin

imprimirb:	daddi $t1, $t1, 1	; $t1 guarda indice de caracter a imprimir
	bne $t1, $a0, imprimirc	; imprimir siguiente caracter

	daddi $t0, $0, bannerInv	; $t0 guarda inicio texto "invalido"
	sd $t0, 0($s1)		; DATA recibe inico texto

	daddi $t0, $0, 4	; $t0 guarda funcion imprimir texto
	sd $t0, 0($s0)		; CONTROL recibe llamado a imprimir texto

	j imprimirFin

imprimirc:	daddi $t1, $t1, 1	; $t1 guarda indice de caracter a imprimir
	bne $t1, $a0, imprimirA	; imprimir siguiente caracter

	daddi $t0, $0, bannerInv	; $t0 guarda inicio texto "invalido"
	sd $t0, 0($s1)		; DATA recibe inico texto

	daddi $t0, $0, 4	; $t0 guarda funcion imprimir texto
	sd $t0, 0($s0)		; CONTROL recibe llamado a imprimir texto

	j imprimirFin


imprimirA:	daddi $t1, $t1, 1	; $t1 guarda indice de caracter a imprimir
	bne $t1, $a0, imprimirFin	; imprimir siguiente caracter


	; imprimir 0
	; 8   * * * 
 	; 7 *       *
	; 6 *       *
	; 5 * * * * *
	; 4 *       *
	; 3 *       *
	; 2 *       *
	; 1   
	; 0 
	; 0 1 2 3 4 5 6

	; colores inician en 0, 0, 0, 0 ( negro )
	; coordenada y 1
	daddi $t0, $0, 5	; coordenada y
	sb $t0, 4($s1)		; DATA recibe coordenada y

	; coordenada x
	daddi $t0, $0, 2	; coordenada x
	sb $t0, 5($s1)		; DATA recibe coordenada x
	
	daddi $t2, $0, 5	; $t2 guarda funcion 5
	sd $t2, 0($s0)		; CONTROL recibe funcion 5 graficar

	daddi $t3, $0, 2	; contador 2 pixeles
imprimirLH5:	daddi $t0, $t0, 1	; coordenada x
	sb $t0, 5($s1)		; DATA recibe coordenada x

	daddi $t2, $0, 5	; $t2 guarda funcion 5
	sd $t2, 0($s0)		; CONTROL recibe funcion 5 graficar

	daddi $t3, $t3, -1	; decerzco $t3
	bne $t3, $0, imprimirLH5	; loop


	; coordenada y 8
	daddi $t0, $0, 8	; coordenada y
	sb $t0, 4($s1)		; DATA recibe coordenada y

	; coordenada x
	daddi $t0, $0, 2	; coordenada x
	sb $t0, 5($s1)		; DATA recibe coordenada x
	
	daddi $t2, $0, 5	; $t2 guarda funcion 5
	sd $t2, 0($s0)		; CONTROL recibe funcion 5 graficar

	daddi $t3, $0, 2	; contador 2 pixeles
imprimirLH8:	daddi $t0, $t0, 1	; coordenada x
	sb $t0, 5($s1)		; DATA recibe coordenada x

	daddi $t2, $0, 5	; $t2 guarda funcion 5
	sd $t2, 0($s0)		; CONTROL recibe funcion 5 graficar

	daddi $t3, $t3, -1	; decerzco $t3
	bne $t3, $0, imprimirLH8	; loop



	; coordenada x 1
	daddi $t0, $0, 1	; coordenada y
	sb $t0, 5($s1)		; DATA recibe coordenada y

	; coordenada y
	daddi $t0, $0, 2	; coordenada x
	sb $t0, 4($s1)		; DATA recibe coordenada x
	
	daddi $t2, $0, 5	; $t2 guarda funcion 5
	sd $t2, 0($s0)		; CONTROL recibe funcion 5 graficar

	daddi $t3, $0, 5	; contador 2 pixeles
imprimirLV1:	daddi $t0, $t0, 1	; coordenada x
	sb $t0, 4($s1)		; DATA recibe coordenada x

	daddi $t2, $0, 5	; $t2 guarda funcion 5
	sd $t2, 0($s0)		; CONTROL recibe funcion 5 graficar

	daddi $t3, $t3, -1	; decerzco $t3
	bne $t3, $0, imprimirLV1	; loop



	; coordenada x 5
	daddi $t0, $0, 5	; coordenada y
	sb $t0, 5($s1)		; DATA recibe coordenada y

	; coordenada y
	daddi $t0, $0, 2	; coordenada x
	sb $t0, 4($s1)		; DATA recibe coordenada x
	
	daddi $t2, $0, 5	; $t2 guarda funcion 5
	sd $t2, 0($s0)		; CONTROL recibe funcion 5 graficar

	daddi $t3, $0, 5	; contador 2 pixeles
imprimirLV2:	daddi $t0, $t0, 1	; coordenada x
	sb $t0, 4($s1)		; DATA recibe coordenada x

	daddi $t2, $0, 5	; $t2 guarda funcion 5
	sd $t2, 0($s0)		; CONTROL recibe funcion 5 graficar

	daddi $t3, $t3, -1	; decerzco $t3
	bne $t3, $0, imprimirLV2	; loop


	j imprimirFin


imprimirFin:	jr $31

