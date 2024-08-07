; pio
pa equ 30h
pb equ 31h
ca equ 32h
cb equ 33h

org 1000h
        cant_caracteres db 5
        caracter db " "

org 2000h
        ; configurar pio para impresora
        mov al, 00000011b       ; entrada de dato strobe y busy
        out ca, al              ; control puerto a entrada S B

        mov al, 00000000b       ; salida de datos 
        out cb, al              ; puerto b salida

        in al, pa               ; guardo el estado del puerto a
        and al, 11111101b       ; apago el bit strobe
        out pa, al              ; envio el sttrobe a la impresora

        mov al, 00000000b       ; un gustito que me doy
        out pb, al              ; seteo dato en 0

        mov cl, cant_caracteres ; contador cantidad de caracteres a ingresar
        mov bx, offset caracter ; guardo en bx la direccion para guardar el caracter
        
poll:   in al, pa               ; guardo en al estado de impresora
        and al, 1               ; reviso si el bit busy esta encendido
        jnz poll                ; si esta busy loopeo
        
        int 6                   ; leo caracter

        mov al, byte ptr [bx]   ; guardo en al el caracter
        out pb, al              ; mando caracter a imprimir

        ; pulso strobe para imprimir
        in al, pa               ; guardo estado impresora
        or al, 00000010b        ; enciendo bit strobe
        out pa, al              ; envio bit strobe
        in al, pa               ; guardo estado impresora
        and al, 11111101b       ; apago bit strobe
        out pa, al              ; envio bit strobe

        dec cl                  ; decrezco contador
        jnz poll                ; lopeo

        int 0
        
end