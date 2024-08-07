;utilizar un registro como puntero (no desplazamiento) para acceder
;a los elementos del vector
;Guardar el resultado en C

.data
V: .word 2, 4, 9
C: .word 0

.code
daddi r2, r0 , 0 ; result
daddi r3, r0, 3 ; # de elementos del vector

daddi r5, r0, V ;
loop: ld r1, 0(r5) ; V+ desplazamiento
      dadd r2, r2, r1 
      daddi r5, r5, 8
      daddi r3, r3, -1
      bnez r3, loop
  
sd r2, C(r0)
halt
