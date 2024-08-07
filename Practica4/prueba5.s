;Definir un vector de 4 numeros V
;calcular la suma de los numeros del vector, sin utilizar saltos
;asumir que V tiene los elementos 2,4,9 para probar el programa

.data
V: .word 2, 4, 9
C: .word 0

.code
daddi r2, r0 , 0 ; result

daddi r5, r0, 0
ld r1, V(r5)
dadd r2, r2, r1 ; r2 = r2+r1 = 0+2

daddi r5, r5, 8
ld r1, V(r5)
dadd r2, r2 , r1 ; r2 = r2+ r1 = 2+ 4 = 6


daddi r5, r5, 8
ld r1, V(r5)
dadd r2, r2 , r1 ; r2 = r2+ r1 =  6 + 9 = 15

sd r2, C(r0)

halt

