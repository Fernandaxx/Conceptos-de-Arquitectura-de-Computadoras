; * Escriba un programa que realice la suma de dos números enteros (de un dígito cada uno) utilizando dos subrutinas:
; *   La denominada ingreso del ejercicio anterior (ingreso por teclado de un dígito numérico) y
; *   otra  denominada resultado, que muestre en la salida estándar del simulador (ventana Terminal) 
; *   el resultado numérico de la suma de los dos números ingresados (ejercicio similar al ejercicio 7 de Práctica 2).


	.data
CONTROL:	.word32 0x10000
DATA:	.word32 0x10008
z:	.ascii "0"

	.code
	
	lwu $s0, DATA($0)	; $s0 guarda direccion de DATA
	lwu $s1, CONTROL($0)	; $s1 guarda direccion de CONTROL


	jal ingreso

	slt $t0, $v0, $0	; set 1 en $t0 si $v0 < $0 (pone 1 en $t0 si la subrutina ingreso retorna -1)

	bne $t0, $0, noImprimir	; si la funcion retorna -1 no imprimir

	dadd $s3, $v0, $0	; $s3 guarad primer numero

	jal ingreso

	slt $t0, $v0, $0	; set 1 en $t0 si $v0 < $0 (pone 1 en $t0 si la subrutina ingreso retorna -1)

	bne $t0, $0, noImprimir	; si la funcion retorna -1 no imprimir

	dadd $s4, $v0, $0	; $s4 guarad primer numero


	dadd $a0, $s3, $0	; guardo en parametro 1 el primer  numero (para muestra)
	dadd $a1, $s4, $0	; guardo en parametro 2 el segundo numero (para muestra)

	jal resultado

noImprimir:	halt



ingreso:	daddi $v0, $0, -1	; seteo $v0 en -1 (retorna -1 si el valor ingresado no es un numero, retorna el numero en caso contrario )
	
	daddi $t0, $0, 9	; $t0 guarda 9 -> control funcion 9: leer teclado
	sd $t0, 0($s1)		; envio CONTROL 9. lectura

	lbu $t1, 0($s0)		; $t1 guarda caracter ingresado	 

	lbu $t2, z($0)		; $t2 guarda caracter 0

	xor $t1, $t1, $t2	; $t1 guarda un numero decimal entre 0 y 9 si el caracter esta entre '0' y '9'

	daddi $t2, $0, 10	; $t2 guarda 10 

	slt $t2, $t1, $t2	; $t2 guarda 1 si numero ingresado es un numero

	beq $t2, $0, ingresoFin	; finalizo funcion 

	; para este punto $t1 tiene el numero ingresado en decimal

	dadd $v0, $t1, $0	; $v0 guarda numero retorno

ingresoFin: 	jr $ra		; retorno funcion



resultado:	daddi $t0, $0, 6	; $t0 guarda 6 -> funcion 6: limpiar consola
	sd $t0, 0($s1)		; CONTROL recibe 6 (limpia consola)
	
	dadd $t0, $s3, $s4	; $t0 guarda suma parametro1 + parametro2

	sd $t0, 0($s0)		; guardo en data numero 

	daddi $t0, $0, 6	; $t0 guarda 6 -> funcion 6: limpiar consola
	sd $t0, 0($s1)		; CONTROL recibe 6 (limpia consola)

	daddi $t0, $0, 1	; $t0 guarda 1 -> funcion 1: imprimir entero sin signo
	sd $t0, 0($s1)		; CONTROL recibe 4

	jr $ra





