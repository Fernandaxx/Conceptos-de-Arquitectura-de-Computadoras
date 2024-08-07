ORG 1000H 
    DIES EQU 10 
    ANCHO EQU 8
    NUMEROS DB " CERO  ", 0AH
            DB " UNO   ", 0AH
            DB " DOS   ", 0AH
            DB " TRES  ", 0AH
            DB " CUATRO", 0AH
            DB " CINCO ", 0AH
            DB " SEIS  ", 0AH
            DB " SIETE ", 0AH
            DB " OCHO  ", 0AH
            DB " NUEVE ", 0AH


    MSJ   DB  "INGRESE UN NUMERO:", 0AH 
    MSJ_FIN   DB  ? 


ORG 1500H 
    NUM   DB  0

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


MUL:; MULTIPLICA
    ; AxB=C
    ; A VIENE EN AL
    ; B VIENE EN AH
    ; C RETORNA EN AL
    MOV CL, AH; Preparo contador 
    MOV AH, AL; guardo en BL el numero a sumar B veces
    MOV AL, 0; AL en 0 para el retorno

MUL_LOOP:
    CMP CL, 0
    JZ MUL_FIN
    ADD AL, AH
    DEC CL
    JMP MUL_LOOP
    
MUL_FIN: RET

IMPRIMIR_NUMERO: MOV AH, ANCHO
    MOV AL, [BX]
    SUB AL, 30H
    CALL MUL
    MOV BX, OFFSET NUMEROS 
    MOV AH, 00
    ADD BX, AX
    MOV AL, ANCHO
    INT 7
    RET

ES_NUM: CMP BYTE PTR [BX], 30H
    JS ES_NUM_FAL
    CMP BYTE PTR [BX], 40H
    JNS ES_NUM_FAL
ES_NUM_VER: CALL IMPRIMIR_NUMERO
ES_NUM_FAL: RET

  
ORG 2000H 
    CALL LIMPIAR_CONSOLA
    MOV BX, OFFSET MSJ 
    MOV AL, OFFSET MSJ_FIN - OFFSET MSJ 
    INT 7 
LOOP: 
    MOV DL, NUM; DL GUARDA EL NUMERO PREVIO
    MOV BX, OFFSET NUM 
    INT 6 

    CALL ES_NUM
    CMP NUM, 30H
    JNZ LOOP
    CMP DL, 30H
    JNZ LOOP
    
    INT 0 

H DB "D"
    
END
 