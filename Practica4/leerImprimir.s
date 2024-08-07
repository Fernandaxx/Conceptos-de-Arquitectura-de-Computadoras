.data
control: .word 0x10000
data: .word 0x10008
caracter: .byte 0

.code
ld $s0, control($0) ; s0 = control
ld $s1, data($0); s1 = data

daddi $t0, $0, 9
sd $t0, 0($s0) ; control = 9 => leer caracter (no lo muestra en pantalla)

lbu $t1, 0($s1); recupero caracter
sb $t1, caracter($0)

daddi $t1, $0, caracter ; tomo la direccion del caracter
sd $t1, 0($s1) ; cRGO LA DIRECCION EN DATA

daddi $t0, $0 , 4
sd $t0, 0($s0) ; control = 4 imprime caracter


halt
