ORG 1000H
MSJ DB ?
FIN DB ?


ORG 2000H 
MOV BX, OFFSET MSJ
MOV AL, OFFSET FIN-OFFSET MSJ
MOV CX, 41H
MOV DX, 61H
LOOP: MOV [BX], CX
INT 7 
INC CX
MOV [BX], DX
INT 7
INC DX
CMP CX, 5Bh
JNZ LOOP
HLT
END 