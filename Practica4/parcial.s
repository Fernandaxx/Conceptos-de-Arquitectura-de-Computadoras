.data
    DATA: .word 0x10008
    CONTROL: .word 0x10000
    tabla1: .double 1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0,12.0
    tabla2: .double 0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,

.code
    ld $s0, CONTROL($0)
    ld $s1, DATA($0)


    dadd
