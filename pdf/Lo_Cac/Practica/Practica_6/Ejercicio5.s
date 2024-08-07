; * Escriba  un  programa  que  calcule  el  resultado  de  elevar  un  valor  en  punto  flotante  a  la  potencia  indicada  por  un 
; * exponente que es un número entero positivo. 
; * Para ello, en el programa principal se solicitará el ingreso de la base (un número en punto flotante) y del exponente (un número entero sin signo)
; * y se deberá utilizar la subrutina a_la_potencia  para  calcular  el  resultado  pedido  (que  será  un  valor  en  punto  flotante).
; * Tenga  en  cuenta  que cualquier base elevada a la 0 da como resultado 1. 
; * Muestre el resultado numérico de la operación en la salida estándar del simulador (ventana Terminal).


	
	.data
CONTROL:	.word32 0x10000
DATA:	.word32 0x10008
a:	.double 0

	.code

	; cargo control y data
	lwu $s0, DATA($0) 	; $s0 guarda direccion DATA
	lwu $s1, CONTROL($0) 	; $s1 guarda direccion CONTROL


	; recibo flotante
	daddi $t0, $0, 8 	; $t0 guarda 8
	sd $t0, 0($s1)		; CONTROL recibe 8 -> funcion 8: leer entero o flotante

	l.d F1, 0($s0)		; F1 guarda flotante ingresado
	
	; recibo entero
	daddi $t0, $0, 8 	; $t0 guarda 8
	sd $t0, 0($s1)		; CONTROL recibe 8 -> funcion 8: leer entero o flotante
	
	ld $t0, 0($s0)		; $T0 guarda entero ingresado

	; cargo parametros
	mfc1 $a0, F1		; flotante paramertro 1
	dadd $a1, $t0, $0	; entero parametro 2
	
	; llamo a potencia, recibo rta en v0
	jal aLaPotencia

	; muestro en consola flotante
	sd $v0, 0($s0)		; guardo en DATA flotante a mostrar
	sd $v0, a($0)		;
	
	daddi $t0, $0, 3	; $t0 guarda 3 mostrar flotante
	sd $t0, 0($s1)		; CONTROL recibe 3 -> funcion 3 mostrar flotante 

	halt



	; subrutina aLaPotencia
	; realiza la potencia con base flotante y expotente entero
	; a0 recibe flotante
	; a1 recibe entero
	; v0 retorna flotante

aLaPotencia:	daddi $v0, $0, 1	; en caso de exp 0 retorno 1
	beq $a1, $0, aLaPotenciaFin	; exp 0 finalizar

	mtc1 $a0, F1		; F1 guarda foltante
	mtc1 $a0, F2		; F2 guarda foltante

	daddi $a1, $a1, -1	; decremento inicial porque resultado comienza en base (1 x base)

aLaPotenciaMul:	mul.d F2, F2, F1	; potencia
	daddi $a1, $a1, -1	; decremento contador (exponente)
	bne $a1, $0, aLaPotenciaMul	; si contador no es 0 multiplicar

	mfc1 $v0, F2

aLaPotenciaFin:	jr $ra





