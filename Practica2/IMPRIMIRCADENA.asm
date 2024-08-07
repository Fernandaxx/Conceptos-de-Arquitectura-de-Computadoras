
ORG 1000H
PA EQU 30H
PB EQU 31H
CA EQU 32H
CB EQU 33H
Cadena DB "IMPRIMIR"
FIN DB ?

ORG 2000H
;CONFUG PA (ESTADO) STROBE 0 BYSY 1
MOV AL, 11111101b
OUT CA, AL

; CONFIG PB (DATOS) TODOS SALIDA
MOV AL, 0
OUT CB, AL

; RECORRER EL STRING
MOV BX, OFFSET CADENA 
POLL: IN AL, PA ; VERIFICAR QUE EL BUFFER NO ESTA LLENO BUSSY = 0
      AND AL, 1 
      JNZ POLL ; MIENTRAS NO ESTE LIBRE SIGO CONSULTANDO
      
;AHORA ESTA LIBRE
MOV AL, [BX]
OUT PB, AL ; MANDO EL CARACTER

;AVISO QUE MANDE UN CARACTER
IN AL, PA ; TOMO EL ESTADO
OR AL ,2 ; FUERZO STROBE A 1 
OUT PA, AL

;MANDO STROBE EN 0
AND AL, 0FDH ; FUERZO STROBE 0
OUT PA, AL

INC BX
CMP BX, OFFSET FIN
JNZ POLL

int 0
end