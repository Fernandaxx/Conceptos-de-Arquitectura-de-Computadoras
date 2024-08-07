;Dado un vector de 5 numeros V
;calcular el maximo valor del vector y guardarlo en C

.data
V: .word 4, -1, 512 ,8 ,16
C: .word 0

.code
daddi r2, r0 , 0 ; maximo inicial
daddi r3, r0, 5 ; # de elementos del vector

daddi r5, r0, 0 ; desplazamiento
loop: ld r1, V(r5)
     slt r4, r1, r2 ; si r1< maximo --> r4 = 1
     bnez r4,sigue
    dadd r2, r1, r0
sigue:
      daddi r5, r5, 8
      daddi r3, r3, -1
      bnez r3, loop
  
sd r2, C(r0)
halt
