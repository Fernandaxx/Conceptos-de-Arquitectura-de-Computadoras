EOI EQU 20H
IMR EQU 21H
INT1  EQU 25H
ID_TIMER EQU 20


CONT EQU 10H
COMP EQU 11H

ORG 1000H
MSJ DB "Vamos a las interrupciones!"
NEWLINE DB 10
FIN DB ?
FLAG DB 0

ORG 80 ; ID_TIMER =20*4
DIR_MANEJADOR DW MANEJADOR

ORG 3000H
MANEJADOR: MOV AL, 0
           OUT CONT , AL
           
           MOV BX, OFFSET MSJ
           MOV AL, OFFSET FIN - OFFSET MSJ
           INT 7
           MOV FLAG,1
MOV AL, EOI
OUT EOI, AL
IRET


ORG 2000H
;CONFIG PIC
CLI ; INHABILITO INTERRUPCIONES MIENTRAS CONFIGURO

MOV AL, 11111101b ; HABILITO TIMER
OUT IMR , AL

MOV AL, ID_TIMER ; ID TIMER
OUT INT1, AL

;CONFIG TIMER
MOV AL, 0 
OUT CONT, AL ;INICIALIZO EN 0

MOV AL, 10
OUT COMP, AL 

STI ; HABILITO INTERP 
LOOP: CMP FLAG , 1
JNZ LOOP
INT 0
END

