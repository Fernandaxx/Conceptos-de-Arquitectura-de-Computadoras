.data
control: .word 0x10000
data: .word 0x10008
string: .asciiz "hola"

.code

ld $t0, control($0)
ld $t1 , data($0)

daddi $t2,$0, string
sd $t2,0($t1)
daddi $t3, $0, 4
sd $t3, 0($t0)


halt
