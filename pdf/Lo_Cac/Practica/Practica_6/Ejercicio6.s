; * El  siguiente  programa  produce  una  salida  estableciendo  el  color  de  un  punto  de  la  pantalla  gráfica
; * (en  la  ventana Terminal  del  simulador  WinMIPS64).  Modifique  el  programa  de  modo  que  las  coordenadas
; * y  color  del  punto  sean ingresados por teclado.

	.data 
coorX:   	.byte   24		; coordenada X de un punto 
coorY:   	.byte   24		; coordenada Y de un punto 
color:   	.byte   255, 0, 255, 0	; color: máximo rojo + máximo azul => magenta 
CONTROL: 	.word32 0x10000 
DATA: 	.word32 0x10008 
	
	.text 
	lwu $s6, CONTROL(r0)	; $s6 = dirección de CONTROL 
	lwu $s7, DATA(r0)	; $s7 = dirección de DATA 
		

	; configuracion
	
	; coorX
	jal ingresarNum
	sb $v0, coorX($0)
	
	jal ingresarNum
	sb $v0, coorY($0)
	
	daddi $t1, $0, 0
	jal ingresarNum
	sb $v0, color($t1)
	
	daddi $t1, $t1, 1
	jal ingresarNum
	sb $v0, color($t1)
	
	daddi $t1, $t1, 1
	jal ingresarNum
	sb $v0, color($t1)
	
	; impresion 

	daddi  $t0, $0, 7	; $t0 = 7 -> función 7: limpiar pantalla gráfica 
	sd $t0, 0($s6)		; CONTROL recibe 7 y limpia la pantalla gráfica 
		
	lbu $s0, coorX(r0)	; $s0 = valor de coordenada X 
	sb $s0, 5($s7)		; DATA+5 recibe el valor de coordenada X 
	lbu $s1, coorY(r0)	; $s1 = valor de coordenada Y 
	sb $s1, 4($s7)		; DATA+4 recibe el valor de coordenada Y 
	lwu $s2, color(r0)	; $s2 = valor de color a pintar 
	sw $s2, 0($s7)	 	; DATA recibe el valor del color a pintar 
	
	daddi  $t0, $0, 5	; $t0 = 5 -> función 5: salida gráfica 
	sd $t0, 0($s6)	 	; CONTROL recibe 5 y produce el dibujo del punto 
	halt


	
ingresarNum:	daddi $t0, $0, 8 	; $t0 guarda 8
	sd $t0, 0($s6)		; CONTROL recibe 8, leer numero

	lb $v0, 0($s7)		; leer numero ingresado	

	jr $31