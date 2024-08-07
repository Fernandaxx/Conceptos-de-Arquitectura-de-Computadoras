; pic
eoi equ 20H
imr equ 21H
irr equ 22H
isr equ 23H
int0 equ 24h

; timer
cont equ 10H
comp equ 11H

; pio
pa equ 30H
pb equ 31H
ca equ 32H
cb equ 33H

; numeros interrupciones
dir_f10 equ 10
dir_timer equ 11

org 40
        ip_f10 dw rut_f10     ; direccion de la subrutina para
                              ; arreglar la iterrupion de la tecla f10

org 44
        ip_clock dw rut_clock ; direccion de la subrutina para 
                              ; arreglar la interrupcion del timer

org 1000h
        n db 0 ; contador

org 3000h
rut_f10: mov al, eoi
        out eoi, al
        int 0 
        iret

rut_clock: push ax ; guardo el valor de ax para modificarlo
        
        ; encendido de leds
        inc n      ; incremento contador
        mov al, n  ; guardo el valor de n en al para pasarlo a los leds
        out pb, al ; cambio de leds

        ; reseteo del timer
        mov al, 0  ; guardo valor para contador
        out cont, al ; reseteo el contador

        ; le indico al pic que finalizo la interrupcion
        mov al, eoi ; guardo 20h en al
        out eoi, al ; envio 20h al eoi

        pop ax     ; recupero ax
        iret

org 2000h
        cli
        
        ; configuracion pic
        mov al, 11111100b ; valor que voy a guardar en el imr 
        out imr, al ; enmascaro todas las interrupciones menos:
                    ;   int 0, interrupcion tecla f10
                    ;   int 1, la interrupcion del timer
        mov al, dir_f10   ; direccion de interrupcion
        out int0, al      ; guardo en int0 la direccion del 
                          ; vector de interrpciones 
        mov al, dir_timer ; direccion de interrupcion
        out int0+1, al    ; guardo en int1 la direccion del 
                          ; vector de interrpciones 

        ; configuracion timer
        mov al, 0    ; guardo valor 0
        out cont, al ; inicio el contador en 0
        mov al, 1    ; guardo valor 1
        out comp, al ; interrupcion de timer cada 1 segundos

        ; configuracion pio
        mov al, 00000000b ; todos los bits 0, salidas
        out cb, al        ; todos los leds salidas
        out pb, al        ; todos los leds apagados
        
        sti

loop: jmp loop

end