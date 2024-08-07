ORG 1000H
    A DB 03H
    B DB 05H
    TOTAL DB ?

ORG 3000H
MUL:; MULTIPLICA
    ; AxB=C
    ; A VIENE EN AL
    ; B VIENE EN BL
    ; C RETORNA EN AL
    MOV CL, BL; Preparo contador 
    MOV BL, AL; guardo en BL el numero a sumar B veces
    MOV AL, 0; AL en 0 para el retorno

MUL_LOOP:
    CMP CL, 0
    JZ MUL_FIN
    ADD AL, BL
    DEC CL
    JMP MUL_LOOP
    
MUL_FIN: RET
    
    
ORG 2000H
    MOV AL, A
    MOV BL, B
    CALL MUL
    HLT
    END