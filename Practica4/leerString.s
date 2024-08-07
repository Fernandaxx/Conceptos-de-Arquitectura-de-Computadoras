.data
    control: .word 0x10000
    data: .word 0x10008
    cadena: .asciiz "....."

.code
    ld $s0, control($0)
    ld $s1 ,data($0)

    daddi $t0, $0, 9 ; leer char
    daddi $t1, $0, 0 ; indice
    daddi $t2, $0, 5 ; cant

    loop: sd $t0, 0($s0); control = 9 
        lbu $t3, 0($s1)
        sb $t3, cadena($t1); guarda en la posicion acutual de cadena
        daddi $t1, $t1, 1 ; aumento la posicion 1 por que es byte
        daddi $t2, $t2, -1 ; decremento long
        bnez $t2, loop

    ;imprimir
    daddi $t0, $0, 4 ; imprimir string
    daddi $t1, $0, cadena
    sd $t1, 0($s1)
    sd $t0,0($s0)

halt


