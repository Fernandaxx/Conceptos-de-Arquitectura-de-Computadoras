.data
    control: .word 0x10000
    data: .word 0x10008
    coordX: .byte 24
    coordY: .byte 24
    color: .byte 0,255,0,0
    cant: .byte 0

.code
    ld $s0, control($0) ; s0=control
    ld $s1, data($0); s1 = data

    ;leer largo de la linea
    daddi $t0, $0, 8
    sd $t0, 0($s0) ; control = 1
    ld $s2, 0($s1) ; recupero el dato
    sd $s2, cant($0); guardo el dato en variable

    ;configurar pixel
    lb $t2, coordY($0)
    sb $t2, 4($s1) ; config coord Y
    lb $t3, coordX($0)
    sb $t3, 5($s1) ; config coord X
    lwu $t4, color($0)
    sw $t4, 0($s1); config color

    ;dibujar linea
    daddi $t0, $0, 5
    loop: sd $t0, 0($s0) ; control = 5 => imprime pixel
        daddi $t3, $t3, 1 ; incremento x
        sb $t3, 5($s1) ; config coord X
        daddi $s2, $s2, -1 
        bnez $s2, loop

        halt
        
    

