; Escriba un programa que solicite el ingreso por teclado de una clave (sucesión de cuatro caracteres) utilizando la
; subrutina char de ingreso de un carácter. Luego, debe comparar la secuencia ingresada con una cadena almacenada
; en la variable clave. Si las dos cadenas son iguales entre si, la subrutina llamada respuesta mostrará el texto
; “Bienvenido” en la salida estándar del simulador (ventana Terminal). En cambio, si las cadenas no son iguales, la
; subrutina deberá mostrar “ERROR” y solicitar nuevamente el ingreso de la clave

.data
    control: .word 0x10000
    data: .word 0x10008
    clave: .asciiz "pass"
    texto1: .asciiz "ingrese su clave: "
    texto2: .asciiz "Bienvenido"
    texto3: .asciiz "ERROR"
    claveLeida: .asciiz "...."

.code
    ;inicializo data y control
    ld $s0, control($0); control = s0
    ld $s1, data($0); data = s1

    daddi $t0, $0, texto1
    sd $t0, 0($s1) ; ingrese su clave
    daddi $t1, $0, 4 ;comando imprimir string
    sd $t1, 0($s0) ; control = 4

    dadd $t2, $0, $0 ; indice
    daddi $t3, $0, 4 ; contador
    loop:
        jal char
        sb $v0, claveLeida($t2) ; carga caracter leido en posicion t2
        daddi $t2, $t2, 1 ; incremento indice
        bne $t2, $t3 , loop 

    daddi $t0,$0,0
    comparar: lb $t1, clave($t0)
            


halt
    ;subrutina leer char
    char: 
        daddi $t4, $0, 9 ; comando leer caracter
        sd $t4, 0($s0) ; control = 9

        lbu $v0, 0($s1) ; recupero y retorno valor leido 
        jr $ra

        


    ;subrutina respuesta

