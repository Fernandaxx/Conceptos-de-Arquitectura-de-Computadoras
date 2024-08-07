;Escribir un programa que lea tres números enteros A, B y C de la memoria de datos y determine cuántos de ellos son iguales
;entre sí (0, 2 o 3). El resultado debe quedar almacenado en la dirección de memoria D.
.data
A: .word 5
B: .word 5
C: .word 5
D: .word 0

.code
ld $t0 , A($0)
ld $t1, B($0)
ld $t2 , C($0)

ld $t3 ,D($0)

daddi $t3, $0, 0

      bne $t0,$t1, sig1
      daddi $t3, $t3, 1
sig1: bne $t0, $t2, sig2
      daddi $t3, $t3, 1
sig2: bne $t1,$t2 , sig3
      daddi $t3, $t3 , 1
sig3: sd $t3, D($0)
halt