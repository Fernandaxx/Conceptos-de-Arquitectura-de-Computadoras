.data
    control: .word 0x10000
    data: .word 0x10008
    coordX: .byte 5
    coordY: .byte 5
    color: .byte 0,255,0,0
    base: .byte 0
    altura: .byte 0
    texto: .asciiz "ingrese base: "
    texto2: .asciiz "ingrese altura: " 

.code
    ld $s0, control($0) ; s0=control
    ld $s1, data($0); s1 = data

    ;leer base
    daddi $t7, $0, texto
    sd $t7, 0($s1)
    daddi $t6, $0, 4
    sd $t6, 0($s0)

    daddi $t0, $0, 8
    sd $t0, 0($s0) ; control = 1
    ld $s2, 0($s1) ; recupero el dato
    sd $s2, base($0); guardo el dato en variable

    ;leer altura
    daddi $t7, $0, texto2
    sd $t7, 0($s1)
    sd $t6, 0($s0)

    sd $t0, 0($s0) ; control = 1
    ld $s3, 0($s1) ; recupero el dato
    sd $s3, altura($0); guardo el dato en variable


    ;configurar pixel
    lb $t2, coordY($0)
    sb $t2, 4($s1) ; config coord Y
    lb $t3, coordX($0)
    sb $t3, 5($s1) ; config coord X
    lwu $t4, color($0)
    sw $t4, 0($s1); config color

    ;dibujar 
    daddi $t0, $0, 5 ; comando de imprimir pixel
    daddi $t5, $t3, 0 ; guardo la coord x inicial
    dadd $s4, $s2, $0 ; guardo la base

    
        base: sb $t3, 5($s1) ; config coord X
              
             sd $t0, 0($s0) ; control = 5 => imprime pixel
            daddi $t3, $t3, 1 ; incremento x
            
            daddi $s2, $s2, -1 ; decremento base
            bnez $s2, base

        sb $t2, 4($s1)
        dadd $s2, $s4, $0 ; recupero la base
        daddi $t2, $t2, 1 ; incremento Y
        
        dadd $t3, $t5 , $0  ; recupero inicio de X

        daddi $s3, $s3 , -1; decremento altura
        bnez $s3 ,base 
halt
        
    