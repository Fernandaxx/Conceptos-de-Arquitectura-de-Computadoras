        .data 
A:      .word 1 
B:      .word 45
tabla:  .word 0
 
        .code 
        ld  r2, B(r0) 
        ld  r1, A(r0)
        ld r3, tabla(r0)
loop:   daddi  r2, r2, -1 
        dsll   r1, r1, 1
        sd r1, tabla(r3)
        daddi r3, r3, 8
        bnez   r2, loop 
        halt