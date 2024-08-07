org 1000h
NUM1 DB 2
NUM2 DB 3
RES DB ?

;Sin usar subrutinas, implementando todo en el programa principal.
org 2000h
mov BH, NUM2
MOV CH, NUM1
for: ADD RES, BH
SUB CH ,1 
JNZ for

hlt
end
