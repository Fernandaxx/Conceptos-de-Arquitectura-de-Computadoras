.data
    data: .word 0x10008
    control: .word 0x10000
    color: .byte 255,0,255,0
    x: .byte 5
    y: .byte 5
    base: .word 0
    altura: .word 0
    texto: .asciiz "hola "

.code
    ld $s0, control($0)
    ld $s1, data($0)

    ; imprimir
    daddi $t9, $0, texto
    sd $t9, 0($s1)
    daddi $t8, $0, 4
    sd $t8, 0($s0)
    ;leer base
    daddi $t0, $0, 8 ; comando leer numero
    sd $t0,0($s0); control = 8
    lb $s2, 0($s1); recupero de Data
    sb $s2, base($0); guardo en variable

    ;leer altura
    sd $t0, 0($s0) ; control =8
    lb $s3, 0($s1)
    sb $s3, altura($0)

    ;dibujar:
    ;configuro data
    lbu $s4, x($0)
    sb $s4, 5($s1) ; config X
    lbu $s5, y($0)
    sb $s5, 4($s1); config y
    lwu $t2, color($0)
    sw $t2, 0($s1)
;s2 base
;s3 altura
;s4 coord X
;s5 coord Y
    daddi $t0, $0, 5 ; comando pintar pixel
    dadd $t2, $s4, $0 ; t2 = X
    dadd $t1, $s2, $0 ; guardo la base

    
    loop: sb $t2, 5($s1) ; recupero coord x
        sd $t0, 0($s0) ; control = 5
        daddi $t2, $t2, 1
        daddi $t1,$t1, -1 ; decremento la base
        bnez $t1, loop
        dadd $t1, $s2 , $0 ; t1= base
        dadd $t2, $s4, $0 ; t2 = X
        daddi $s5, $s5, 1
        sb $s5, 4($s1)
        daddi $s3, $s3, -1 ; decremento altura
        bnez $s3, loop

halt


    



    

