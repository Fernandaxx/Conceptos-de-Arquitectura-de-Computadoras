ORG 1000H
    A DB 03H
    B DB 02H
    C DB ?

ORG 2000H
    ; IF A==B THEN C=A ELSE C=B 
    MOV AL, A
    MOV BL, B
    CMP AL, BL
    JNZ COND_F
COND_V: 
    MOV CL, AL
    JMP FIN
COND_F:
    MOV CL, BL
FIN: HLT
    END