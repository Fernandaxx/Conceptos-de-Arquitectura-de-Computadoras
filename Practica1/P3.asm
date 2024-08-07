org 3000h
rut: mov bx,3 ; Dirección 3000h
ret ; Dirección 3002h
org 2000h
call rut ; Dirección 2000h
add cx,5 ; Dirección 2002h
call rut ; Dirección 2004h
hlt ; Dirección 2006h
end 