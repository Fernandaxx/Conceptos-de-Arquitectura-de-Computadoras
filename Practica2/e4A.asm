EOI EQU 20H
IMR EQU 21H
INT0 EQU 24H
N_F10 EQU 15
ORG 1000H
MSJ DB "Vamos a las imterrupciones"
SALTO DB 10
FIN DB ?
ORG 60
IP_F10 DW RUT_F10

ORG 3000H

RUT_F10:PUSH AX
        PUSH BX
        MOV BX, OFFSET MSJ
        MOV AL, OFFSET FIN - OFFSET MSJ
        INT 7
        
 MOV AL, EOI
 OUT EOI, AL
 POP BX
 POP AX
 IRET



ORG 2000H
 CLI
 MOV AL, 0FEH ; 1111 1110
 OUT IMR, AL
 MOV AL, N_F10
 OUT INT0, AL
 STI
LAZO:JMP LAZO

HLT
END