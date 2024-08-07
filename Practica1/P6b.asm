org 1000h
NUM1 DB 2
NUM2 DB 3
RES DB ?

org 3000h
MUL:    MOV DX, 0
        for: ADD DH, BH
         SUB CH ,1 
         JNZ for
         ret
org 2000h
mov BH, NUM2
MOV CH, NUM1
call MUL
MOV RES, DH
hlt
end
