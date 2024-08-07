; * Escriba  un  programa  que  utilice  sucesivamente  dos  subrutinas:  
; *   La  primera,  denominada  ingreso,  debe  solicitar el  ingreso por teclado de un número entero (de un dígito), 
; *   verificando que el valor ingresado realmente sea un dígito.   
; *   la segunda,  denominada  muestra,  deberá  mostrar  en  la  salida  estándar  del  simulador  (ventana  Terminal)
; *   el valor del  número ingresado expresado en letras (es decir, si se ingresa un ‘4’, deberá mostrar ‘CUATRO’). 
; *   Establezca el pasaje de parámetros  entre  subrutinas  respetando  las  convenciones  para  el  uso  de  los
; *   registros  y  minimice las detenciones  del cauce (ejercicio similar al ejercicio 6 de Práctica 2).

	.data
CONTROL:	.word32 0x10000
DATA:	.word32 0x10008

z:	.ascii  "0"
CERO:	.asciiz "CERO  "
UNO:	.asciiz "UNO   "
DOS:	.asciiz "DOS   "
TRES:	.asciiz "TRES  "
CUATRO:	.asciiz "CUATRO"
CINCO:	.asciiz "CINCO "
SEIS:	.asciiz "SEIS  "
SIETE:	.asciiz "SIETE "
OCHO:	.asciiz "OCHO  "
NUEVE:	.asciiz "NUEVE "


	.code

	lwu $s0, DATA($0)	; $s0 guarda direccion de DATA    0x10008
	lwu $s1, CONTROL($0)	; $s0 guarda direccion de CONTROL 0x10008

	jal ingreso		; llamada funcion ingreso

	slt $t0, $v0, $0	; set 1 en $t0 si $v0 < $0 (pone 1 en $t0 si la subrutina ingreso retorna -1)

	bne $t0, $0, noImprimir	; si la funcion retorna -1 no imprimir

	dadd $a0, $v0, $0	; $a0 guarda el numero en decimal a imprimir

	jal muestra		; llamada funcion muestra

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




muestra:	dadd $t0, $0, $a0	; $t0 guarda numero a imprimir en decimal
 	daddi $t1, $0, CERO	; $t1 guarda direccion inicio TEXTO

selectNum:	daddi $t0, $t0, -1	; decremento $t0

	slt $t3, $t0, $0	; $t3 en 1 si $t0 == -1 ( $t3 = $t0 < $0 )

	bne $t3, $0, imprimir	; si contador termino imprimo

	daddi $t1, $t1, 8 	; $t1 guada direccion inicio siguiente caracter

	j selectNum

imprimir:	sd $t1, 0($s0)		; guardo en data direccion de texto 

	daddi $t0, $0, 6	; $t0 guarda 6 -> funcion 6: limpiar consola
	sd $t0, 0($s1)		; CONTROL recibe 6 (limpia consola)

	daddi $t0, $0, 4	; $t0 guarda 4 -> funcion 4: imprimir ascii
	sd $t0, 0($s1)		; CONTROL recibe 4

	jr $ra
