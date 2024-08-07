
; c = a + b

        .data
a:      .byte 7
b:      .byte 24
c:      .byte 0


        .text

start:  daddi r1, r0, a  ; r1 = 7
        daddi r2, r0, b ; r2 = 24
        dadd r3, r1, r2 ; r3 = r1 + r2 = 7 + 24

        halt