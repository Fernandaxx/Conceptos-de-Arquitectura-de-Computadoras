        .data 
A:      .word  13 
B:      .word  24 
        
        .code 
        ld  r1, A(r0) 
        ld  r2, B(r0)
        sd  r2, A(r0) 
        sd  r1, B(r0)
        halt