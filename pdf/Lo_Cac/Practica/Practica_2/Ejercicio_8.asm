ORG 1000H 
    TITULO   DB  "INGRESE DOS NUMEROS:", 0AH 
    TITULO_FIN   DB  ? 

    MENOS DB " - "
    IGUAL DB " = "
    OPERADORES_FIN DB ?

ORG 1500H 
    NUM1   DB  ?
    NUM2   DB  ?
    SIGNO DB "-"
    RES DB ?

ORG 3000H
    CLEAN DB 12
LIMPIAR_CONSOLA: 
    PUSH BX
    PUSH AX
    MOV BX, OFFSET CLEAN
    MOV AL, 1
    INT 7
    POP AX
    POP BX
    RET

ES_NUM: CMP BYTE PTR [BX], 30H
    JS ES_NUM_FAL
    CMP BYTE PTR [BX], 40H
    JNS ES_NUM_FAL
ES_NUM_VER: MOV AL, 0FFH
    RET
ES_NUM_FAL: MOV AL, 00H 
    RET
  
ORG 2000H 
    CALL LIMPIAR_CONSOLA
    MOV BX, OFFSET TITULO 
    MOV AL, OFFSET TITULO_FIN - OFFSET TITULO
    INT 7 
    MOV BX, OFFSET NUM1 
    INT 6 
    CALL ES_NUM
    CMP AL, 00H
    JZ FIN
    SUB BYTE PTR [BX], 30H
    MOV DL, [BX]; GUARDO NUMERO 1 EN DL

    MOV BX, OFFSET MENOS
    MOV AL, OFFSET IGUAL - OFFSET MENOS
    INT 7

    MOV BX, OFFSET NUM2 
    INT 6 
    CALL ES_NUM
    CMP AL, 00H
    JZ FIN
    SUB BYTE PTR [BX], 30H
    SUB DL, [BX]; GUARDO EL RESULTADO EN DL, NUM1 + NUM2
    
    MOV BX, OFFSET IGUAL
    MOV AL, OFFSET OPERADORES_FIN - OFFSET IGUAL
    INT 7

    ; FILTRADO DEL RESULTADO

    ADD DL, 0AH
    CMP DL, 0AH
    JNS RES_POSITIVO

    MOV DH, 00H
CALCULAR_NEGATIVO:
    INC DH
    INC DL
    CMP DL, 0AH
    JNZ CALCULAR_NEGATIVO

  
    MOV BX, OFFSET SIGNO
    MOV AL, 1
    INT 7

    ADD DH, 30H
    MOV BX, OFFSET RES
    MOV BYTE PTR [BX], DH
    MOV AL, 1
    INT 7

JMP FIN

RES_POSITIVO: 

    SUB DL, 0AH
    ADD DL, 30H
    MOV BX, OFFSET RES
    MOV BYTE PTR [BX], DL
    MOV AL, 1
    INT 7

FIN: INT 0     
END
 