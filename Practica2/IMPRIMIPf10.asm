ORG 1000H
EOI EQU 20H
IMR EQU 21H
INT0 EQU 24H
PA EQU 30h
PB EQU 31H
CA EQU 32H
CB EQU 33H
ID_F10 EQU 10
MSJ DB "Ingresar Caracteres: "
FIN DB ?
READ DB ?

ORG 3000H
IMPRIMIR_MENSAJE: PUSH AX
                  PUSH BX
                  MOV BX, OFFSET MSJ
                  MOV AL, OFFSET FIN - OFFSET MSJ
                  INT 7
                  POP BX
                  POP AX
                  RET
STROBE_1: PUSH AX
          IN AL, PA
          OR AL,2
          OUT PA, AL
          POP AX
          RET
          
STROBE_0: PUSH AX
          IN AL, PA
          AND AL, 0FDH
          OUT PA, AL
          POP AX
          RET
           
          
ENVIAR_CARACTERES: PUSH AX
                   PUSH BX
                   PUSH CX 
                  LOOP: 

                  ;VERIFICAR SI BUSSY
                   IN AL, PA
                   AND AL, 1
                   JNZ LOOP 
                   MOV BX, OFFSET READ
                   MOV AL, [BX] ; BX TIENE DIR DE LOS CAR
                   OUT PB, AL ; ENVIO EL DATO

                  CALL STROBE_1
                  CALL STROBE_0
                   INC BX
                   DEC CX ; CX CONTADOR DE LETRAS
                   JNZ LOOP
                   
                   MOV AL, 20H
                   OUT EOI, AL
  
                   POP CX 
                   POP BX
                   POP AX
                   IRET


CONFIG_IMPRESORA:
                  PUSH AX
                  MOV AL, 0FDH
                  OUT CA, AL

                  MOV AL ,0
                  OUT CB, AL
                  POP AX
                  RET
                  
ORG 2000H
;CONFIG F10
CLI
MOV AL, 0FEH ; HABILITO LINEA 1 1111 1110
OUT IMR, AL

MOV AL, ID_F10
OUT INT0, AL

MOV BX, ID_F10 * 4
MOV WORD PTR [BX], ENVIAR_CARACTERES
STI

CALL CONFIG_IMPRESORA
CALL IMPRIMIR_MENSAJE
MOV CX ,0
LOOP3:
MOV BX, OFFSET READ
INT 6
INC BX
INC CX
JMP LOOP3

INT 0
END