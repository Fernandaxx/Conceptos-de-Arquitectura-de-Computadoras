.data
control: .word 0x10000
data: .word 0x10008
num: .byte 0
caracter: .byte 0

.code
ld $s0, control($0) ; s0 = control
ld $s1, data($0); s1 = data

daddi $t0, $0, 8
sd $t0, 0($s0) ; control = 8 => leer numero
lb $t1, 0($s1) ; recupero el numero leido
sb $t1, num($0) ; guardo en variable


daddi $t0, $0, 9
sd $t0, 0($s0) ; control = 9 => leer caracter (no lo muestra en pantalla)
lbu $t1, 0($s1); recupero caracter
sb $t1, caracter($0)


halt