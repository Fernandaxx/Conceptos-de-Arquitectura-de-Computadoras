org 1000h
NUM1 DW 2
NUM2 DW 3
RES DW ?

org 3000h
MUL:    MOV DX, 0
        MOV AX,[BX]
        MOV BX , CX
        MOV CX , [BX]
        for: ADD DX, AX
         SUB CX ,1 
         JNZ for
         ret
org 2000h
mov BX, OFFSET NUM2
MOV CX, OFFSET NUM1
call MUL
MOV RES, DX
hlt
end
