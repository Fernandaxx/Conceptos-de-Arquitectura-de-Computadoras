org 1000h
A db 8
B db 5
C db 4
D db ?

org 3000h
CALC: mov bx,sp
ADD  BX , 2
 mov dl, byte ptr [bx]
 ADD bx, 2
MOV AL , BYTE PTR [BX]
 ADD bx, 2
 MOV CL , BYTE PTR [BX]
 add DL, AL
 sub DL, CL
ret
org 2000h
mov AL, C
push AX
mov aL, B
push AX
MOV AL , A
push AX
call CALC
mov D, DL
POP AX
POP AX
POP AX
hlt
end
