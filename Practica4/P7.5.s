.data
M: .word 3
Tabla: .word 10,20,30,1,2
length: .word 5
result: .word 0

.code
ld $a0, M(r0) ; parametro 1 valor M
daddi $a1, $0, Tabla ; parametro 2 offset tabla
ld $a2, length($0); parametro size tabla

jal cant_mayores
sd $v0, result(r0)
halt

cant_mayores: dadd $v0, $v0, $0; contador
loop: ld $t0, 0($a1) ; valor de tabla en t0
      slt $t1, $a0, $t0; t1= 1 si M < tabla
      dadd $v0,$v0, $t1; sumo contador
      daddi $a1, $a1, 8 ; incremento puntero
      daddi $a2, $a2, -1 ; disminuyo length
      bnez $a2, loop
      jr $ra




