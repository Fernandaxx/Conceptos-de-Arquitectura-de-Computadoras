; pic
eoi equ 20h
imr equ 21h
irr equ 22h
isr equ 23h
int0 equ 24h

; pio 
pa equ 30h
pb equ 31h
ca equ 32h
cb equ 33h

; posicion vector interrupciones
dir_f10 equ 10

org 40
        ip_f10 dw rut_f10

org 1000h
        inicio_texto db ?
        
org 3000h
rut_f10: mov bx, offset inicio_texto ; guardar direccion del texto 
        call imprimir_texto ; imprimir el texto ingresado
        mov al, eoi          ; guardar 20h
        out eoi, al          ; finalizar interrupcion
        iret


imprimir_texto: in al, pa    ; guardo estado impresora
        and al, 00000001b    ; reviso si el bit busy esta encendido
        jnz imprimir_texto   ; si la impresora esta busy esperar
        mov al, [bx] ; guardo caracter en al
        out pb, al           ; envio a impresora el caracter

        ; pulso strobe para imprimir
        in al, pa            ; guardo estado impresora
        or al, 00000010b     ; enciendo bit strobe
        out pa, al           ; envio bit strobe
        in al, pa            ; guardo estado impresora
        and al, 11111101b    ; apago bit strobe
        out pa, al           ; envio bit strobe

        inc bx               ; apunto siguiente caracter
        dec cl               ; reduzco contador
        jnz imprimir_texto
        
        ; pausa para que la impresora termine de imprimir 
        mov cl, 255
pausa:  dec cl
        jnz pausa
        
        ret

org 2000h
        cli                  ; inicio configuracion pic 
        mov al, 11111110b    ; enmascarar interrupciones distintas al f10
        out imr, al          ; envio configuracion al pic

        mov al, dir_f10      ; guardo direccion de la interrupcion por f10
        out int0, al         ; cuando se llame a la interrupcion por f10 se 
                             ; ira a la direccion f10 del vector de interrupciones
        sti                  ; fin configuracion pic

        ; configuracion pio (para impresora)
        mov al, 00000011b    ; bit 1 y 2 entrada, strobe y busy
        out ca, al           ; entrada strobe y busy

        mov al, 00000000b    ; todos los bits salida
        out cb, al           ; todos los bits de salida

        mov al, 00000000b    ; caracter nulo
        out pb, al           ; gustito mio iniciar el dato en nulo

        in al, pa            ; guardo estado pa
        and al, 11111101b    ; apago bit strobe
        out pa, al           ; envio strobe apagado a la impresora

        mov cl, 0            ; inicio contador
        mov bx, offset inicio_texto ; guardo direccion inicio del texto

loop:   int 6                ; ingreso texto caracter por caracter
        inc bx               ; incremento posicion del caracter
        inc cl               ; incremento contador caracteres
        jmp loop             ; loopeo

        int 0
end
