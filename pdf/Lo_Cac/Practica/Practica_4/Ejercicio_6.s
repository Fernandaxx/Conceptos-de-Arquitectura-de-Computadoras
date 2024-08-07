; Escribir un programa que lea tres números enteros A, B y C de la memoria de datos y determine cuántos de ellos son iguales 
; entre sí (0, 2 o 3). El resultado debe quedar almacenado en la dirección de memoria D. 

        .data
A:      .word 3
B:      .word 2
C:      .word 3
D:      .word 0

        .code

        ; guardo en registros datos de memoria
        lw r1, A(r0)
        lw r2, B(r0)
        lw r3, C(r0)
	;lw r4, D(r0) ; seteo r4 en 0
	dadd r4, r0, r0

	beq r1, r2, r1_r2_iguales
	; r1 y r3 iguales, distintos de r2
	beq r1, r3, dos_iguales 
	; r2 y r3 iguales, distintos de r1
	beq r2, r3, dos_iguales
	j fin 

	; r1 y r2 iguales, distintos de r3
r1_r2_iguales: beq r1, r3, todos_iguales
	; dos iguales

dos_iguales: daddi r4, r4, 2
	j fin

	; caso de que sean todos iguales 
todos_iguales: daddi r4, r4, 3
	j fin

fin:	sw r4, D(r0)
        halt




