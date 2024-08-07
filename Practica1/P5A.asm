org 1000h
A db 8
B db 5
C db 4
D db ?

org 3000h
CALC: 
add DL, AL
 add DL, AH
 sub DL, CL
ret 

 org 2000h
mov AL, A
MOV AH,B
mov CL, C
CALL CALC
mov D, DL
hlt
end 
