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
        pos_leds db 1    ; posicion de los leds
        rot_leds_iz db 1 ; 1 para rotar izquierda, 0 para rotar derecha 

org 3000h
rut_f10: mov al, eoi
        out eoi, al
        int 0 
        iret

rut_clock: push ax ; guardo el valor de ax para modificarlo
        
        ; encendido de leds
        ;inc pos_leds    ; incremento contador
        mov al, pos_leds ; guardo el valor de n en al para pasarlo a los leds
        out pb, al       ; cambio de leds
        call rotar_leds  ; roto leds

        ; reseteo del timer
        mov al, 0    ; guardo valor para contador
        out cont, al ; reseteo el contador

        ; le indico al pic que finalizo la interrupcion
        mov al, eoi  ; guardo 20h en al
        out eoi, al  ; envio 20h al eoi

        pop ax       ; recupero ax
        iret

rotar_iz_leds: push ax   ; guardo ax
        mov al, pos_leds ; guardo en al la posicion de los leds
        add al, al       ; roto izquierda
        adc al, 0        ; sumo carry si hay
        mov pos_leds, al ; sobreescribo la posicion de los leds
        pop ax           ; recupero ax
        ret

rotar_der_leds: push ax         ; guardo ax
        mov al, 7               ; contador 7 para 7 rotaciones
rotar_der_leds_loop: cmp al, 0  ; comparo contador > 0
        jz rotar_der_leds_fin   ; si termina contador finalizo
        call rotar_iz_leds      ; roto izquierda
        dec al                  ; decrecer al
        jmp rotar_der_leds_loop ; loop rotar derecha
rotar_der_leds_fin: pop ax      ; recupero al
        ret

rotar_leds: cmp rot_leds_iz, 0      ; reviso si rotar iz o der
        jz rotar_leds_der           ; salto a rotar derecha
        call rotar_iz_leds          ; rotar izquierda
        cmp pos_leds, 10000000b     ; comparo con posicion final
        jnz rotar_leds_fin          ; si esta en la ultima posicion 
        mov rot_leds_iz, 0          ; comenzar a rotar a la derecha
        jmp rotar_leds_fin          ; terminar rotacion
rotar_leds_der: call rotar_der_leds ; rotar derecha
        cmp pos_leds, 00000001b     ; comparo con posicion inicial
        jnz rotar_leds_fin          ; si esta en la primer posicion
        mov rot_leds_iz, 1          ; comenzar a rotar a la izquierda
rotar_leds_fin: ret

org 2000h
        cli

        push ax
        
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

        pop ax
        
        sti

loop: jmp loop

end