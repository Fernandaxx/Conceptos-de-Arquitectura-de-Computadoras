.data
    control: .word 0x10000
    data: .word 0x10008
    tabla1: .double 0.0, 0.0 ,0.0 0.0
    tabla2: .double 0.0, 0.0 ,0.0

.code
    ld $s0, control($0)
    ld $s1, data($0)

    daddi $s2, $0, 3 ; N-1

    ;leer tabla
    daddi $s5, $0, 4 ; N
    daddi $t0, $0, 8 ; comando leer
    daddi $t1, $0, 0 ;desplazamiento
    leer: sd $t0, 0($s0) ; control = 8
        l.d f0, 0($s1)
        s.d f0, tabla1($t1)
        daddi $t1, $t1, 8
        daddi $s5 , $s5, -1
        bnez $s5, leer
    

    ;Direcciones de elementos a recorrer
    daddi $s3, ,$0, tabla1
    daddi $s4, $0, tabla2
    ;calcular promedio
    loop: l.d f1,0($s3); elemento actual de la tabla
        l.d f2, 8($s3)

        jal promedio
        s.d f3, 0($s4); guardo el promedio en la tabla 2

        ;avanzo en ambas tablas
        daddi $s2, $s2 , -1
        daddi $s3, $s3 , 8
        daddi $s4, $s4, 8
        bnez $s2, loop

    ;imprimir tabla en subrutina
    daddi $a0, $0, tabla2
    jal imprimir
    
    
halt
; f1= primer numero
; f2 = segundo numero
; devuelve promedio en f3
promedio: add.d f3, f1, f2
    daddi $t0, $0, 2
    ;se debe convertir a flotante
    mtc1 $t0, f4
    cvt.d.l f4, f4 
    div.d f3, f3, f4
jr $ra

;mando el dato a DATA y el 3 a control
;a0 direccion de la tabla
imprimir: 
        daddi $t1, $0, 3 ;elementos a iterar
        daddi $t2, $0, 3 ; casualidad que sean igual, este es para enviar a control
        Loop_imp: l.d f0 , 0($a0) ; tomo el elemento actual
            s.d f0, 0($s1); envio dato a DATA
            sd $t2, 0($s0); control = 3
            daddi $a0, $a0, 8 ; avanzo a la siguiente posicion a imprimir
            daddi $t1, $t1, -1
            bnez $t1, Loop_imp
jr $ra
    



    REPASAR TEORIA 
    REPASAR RECORRIDO TABLAS
    REPASAR COMPARAR CADENA
    LEER STRING
    PUSH Y POP





