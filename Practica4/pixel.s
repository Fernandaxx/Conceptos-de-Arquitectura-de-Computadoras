.data
    CONTROL: .word 0x10000
    DATA: .word 0x10008
    coordX: .byte 24
    coordY: .byte 24
    color: .byte 180,100,250,0 ;RGBA

.code
    ld $s0, CONTROL($0) ; $s0 = control
    ld $s1, DATA($0); $s1 = data

    lb $t0, coordY($0)
    sb $t0, 4($s1) ; cargo coord Y

    lb $t1, coordX($0)
    sb $t1, 5($s1) ; cargo coord X

    lwu $t2, color($0)
    sw $t2, 0($s1) ; cargo color en data


    daddi $t0, $0, 5
    sd $t0, 0($s0) ; cargo operacion 5 pantalla grafica en control

    halt

