org 3000h 
rutina: mov bx,3
ret
org 2000h 
push ax
call rutina
pop bx
hlt
end