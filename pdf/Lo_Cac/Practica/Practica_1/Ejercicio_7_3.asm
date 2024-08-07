ORG 1000H
    A DB 03H
    B DB 04H
    TOTAL DB 00H

ORG 3000H
MUL:; MULTIPLICA
    ; AxB=C
    ; AX TRAE DIRECCION DE A
    ; BX TRAE DIRECCION DE B
    ; DX TRAE DIRECCION DE C
    MOV CL, [BX]; Preparo contador 
    MOV BX, AX; Guardo en BX la direccion de A
    MOV CH, [BX]; Guardo en CH el valor de A
    MOV BX, DX; Guardo en BX la direccion de C para retornar el TOTAL
    MOV BYTE PTR [BX], 0; Total inicia en 0

MUL_LOOP:
    CMP CL, 0
    JZ MUL_FIN
    ADD BYTE PTR [BX], CH
    DEC CL
    JMP MUL_LOOP
    
MUL_FIN: RET
    
    
ORG 2000H
    MOV AX, OFFSET A
    MOV BX, OFFSET B
    MOV DX, OFFSET TOTAL
    CALL MUL
    HLT
    END 