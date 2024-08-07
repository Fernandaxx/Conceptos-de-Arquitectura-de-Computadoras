;Definir un vector de 4 numeros V
;calcular la suma de los numeros del vector, sin utilizar saltos
;asumir que V tiene los elementos 2,4,9 para probar el programa
;con loop

.data
V: .word 2, 4, 9
C: .word 0

.code
daddi r2, r0 , 0 ; result
daddi r3, r0, 3 ; # de elementos del vector

daddi r5, r0, 0 ; desplazamiento
loop: ld r1, V(r5)
      dadd r2, r2, r1 
      daddi r5, r5, 8
      daddi r3, r3, -1
      bnez r3, loop
  
sd r2, C(r0)
halt
