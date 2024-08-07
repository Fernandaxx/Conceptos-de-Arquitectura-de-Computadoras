; timer
cont equ 10h
comp equ 11h

; pic
eoi equ 20h
imr equ 21h
int0 equ 24h

; pio
pa equ 30h
pb equ 31h
ca equ 32h
cb equ 33h

; hand-shake
hand_data equ 40h
hand_state equ 41h

; numero de interrupcion
indice_f10 equ 10
indice_timer equ 11
indice_hand equ 12

org 40
        ip_f10 dw rut_f10
org 44
        ip_timer dw rut_timer

org 48
        ip_hand dw rut_hand

org 1000h
        clock db 12
        min2 db "0"
        min1 db "0"
        db ":"
        seg2 db "0"
        seg1 db "0"
        db 0ah
        clock_length db offset clock_length - offset clock

org 3000h
rut_f10: push ax
        call show_time

        ; resetea timer
        ;mov al, 30h
        ;mov seg1, al
        ;mov seg2, al
        ;mov min1, al
        ;mov min2, al
        
        mov ax, eoi
        out eoi, ax
        pop ax
        iret

; incrementa el timer cada que se activa
rut_timer: push ax
        inc seg1
        cmp seg1, 3Ah
        jnz rut_timer_end
        mov al, 30h
        mov seg1, al
        
        inc seg2
        cmp seg2, 36h
        jnz rut_timer_end
        mov al, 30h
        mov seg2, al
        
        inc min1
        cmp min1, 3Ah
        jnz rut_timer_end
        mov al, 30h
        mov min1, al
        
        inc min2
        cmp min2, 36h
        jnz rut_timer_end
        mov al, 30h
        mov min2, al
        
rut_timer_end: xor al, al
        out cont, al
        mov al, eoi
        out eoi, al
        pop ax
        iret

; traer en bx la direccio del caracter y en cl contador
rut_hand: mov al, [bx]   
        out hand_data, al
        inc bx
        dec cl
        jnz rut_hand_fin
        mov al, 00000000b
        out hand_state, al
rut_hand_fin: mov al, eoi
        out eoi, al
        iret

; si imprimo con hand-shake interrupcion necesito modificar ax y bx
show_time: ;push ax
        ;push bx
        mov bx, offset clock
        mov al, clock_length

        ; cada que se presiona f10 muestra cuanto tiempo paso en consola
        int 7

; ------- inicio impresora pio -------
;        ; imprimir por pio
;        mov bx, offset clock
;        mov cl, clock_length
;
; show_time_printer_pio: in al, pa  ; guardo estado impresora
;         and al, 1                 ; veo si esta busy
;         jnz show_time_printer_pio ; loopeo
;
;         ; imprimo
;
;         mov al, [bx] ; guardo caracter
;         out pb, al   ; envio caracter
;
;         ; pulso strobe
;         in al, pa        ; recibo estado
;         or al, 00000010b ; enciendo strobe
;         out pa, al       ; envio configuracion
;       
;         in al, pa         ; recibo estado
;         and al, 11111101b ; apago strobe
;         out pa, al        ; envio configuracion
;
;         inc bx ; siguiente caracter
;         dec cl ; decresco contador
;         jnz show_time_printer_pio
; ------- fin impresora pio ----------

; ------- inicio impresora hand-shake polling ------

        mov bx, offset clock
        mov cl, clock_length

show_time_printer_hand_polling: in al, hand_state
        and al, 1
        jnz show_time_printer_hand_polling

        mov al, [bx]
        out hand_data, al

        inc bx
        dec cl
        jnz show_time_printer_hand_polling

        
; ------- fin impresora hand-shake polling ---------

; ------- inicio impresora hand-shake interrupcion ------

show_time_printer_hand_interrupcion: mov cl, clock_length 
        mov bx, offset clock
        mov al, 10000000b
        out hand_state, al

        
; ------- fin impresora hand-shake interrupcion ---------
        
        ;pop bx
        ;pop ax
        ret

org 2000h
        cli
        
        ; configucracion timer

        mov al, 1
        out comp, al

        mov al, 0
        out cont, al
        
        ; configuracion pic

        mov al, 11111000b ; desenmascara interrupciones f10, timer y hand-shake
        out imr, al       ; envia configuracion

        mov al, indice_f10 ; guarda indice interrupcion f10
        out int0, al       ; envio configuracion

        mov al, indice_timer ; guarda indice interrupcion timer
        out int0 + 1, al     ; envio configuracion

        mov al, indice_hand ; guarda indice interrupcion hand-shake
        out int0 + 2, al    ; envio configuracion

; ------- inicio impresora pio -------
;        ; configuracion pio
;
;        mov al, 00000011b ; strobe y busy entradas
;        out ca, al        ; envio configuracion
;
;        mov al, 00000000b ; todo salida
;        out cb, al        ; envio configuracion
;
;        ; strobe a 0
;        in al, pa         ; guardo estado
;        and al, 11111101b ; apago strobe
;        out pa, al        ; envio configuracion
; ------- fin impresora pio ----------

; ------- inicio impresora hand-shake interrupcion ------
        ; configuracion hand-shake con interrupcion
        ;mov al, 10000000b   ; enciendo bit interrupcion
        ;out hand_state, al ; envio configuracion
        
; ------- fin impresora hand-shake interrupcion ---------
        sti

loop: jmp loop

        int 0

end