ORG 1000H
    texto DB "HOLIWIS", 00h
    cant_char DB 00

ORG 3000H
    CONCAR: CMP BYTE PTR [BX], 00h
    JZ FIN
    INC CL
    INC BX
    JMP CONCAR
    FIN: MOV cant_char, CL
    RET    

ORG 2000H
    ; AX DIRECCION INICIO TEXTO
    ;
    MOV BX, OFFSET texto

    CALL CONCAR
  HLT
  END
    
