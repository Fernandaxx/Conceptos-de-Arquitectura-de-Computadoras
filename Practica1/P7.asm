org 1000h
NUM1 DW 2
NUM2 DW 3
RES DW ?

org 3000h
MUL:    MOV BX, SP
        ADD BX, 2
        MOV AX , [BX]
        ADD BX, 2
        MOV CX, [BX]
        for: ADD DX, AX
         SUB CX ,1 
         JNZ for
         ret
org 2000h
mov AX,  OFFSET NUM2
PUSH AX
MOV AX, OFFSET NUM1
PUSH AX 
call MUL
MOV RES, DX
POP AX
POP AX
hlt
end
