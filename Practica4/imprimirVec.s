.data
    control: .word 0x10000
    data: .word 0x10008
    vec: .word 10,20,30,40,50

.code
    ld $s0, control($0)
    ld $s1 ,data($0)

    daddi $t0, $0, 1 ; imprimir entero
    daddi $t1, $0, 5; longitud
    daddi $t2,$0, 0 ; 
    loop: ld $t3, vec($t2) ; tomo posicion actual
        sd $t3, 0($s1); guardo en data
        sd $t0, 0($s0) ; control = 1, imprime
        daddi $t2,$t2, 8
        daddi $t1, $t1, -1
        bnez $t1, loop

halt
