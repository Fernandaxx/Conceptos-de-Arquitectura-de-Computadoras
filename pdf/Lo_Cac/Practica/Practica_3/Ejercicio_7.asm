; hand-shake
hand_data equ 40h
hand_state equ 41h

org 1000h
        texto db "Texto a imprimir", 0ah, 0, 0, 0, 0, 0
        texto_fin db ?
        texto_length db offset texto_fin - offset texto

org 2000h
        ; configuro handshake
        in al, hand_state    ; recibo estado del hand-shake
        and al, 01111111b    ; apago bit de interrupcion
        out hand_state, al   ; envio estado al hands-hake

        mov bx, offset texto ; guardo direccion inicio del texto
        mov cl, texto_length ; guardo contador cant caracteres

poll:   in al, hand_state    ; guardo estado hand-shake
        and al, 1            ; reviso si la impresora esta busy
        jnz poll             ; si la impresora esta busy loopeo

        mov al, [bx]         ; guardo en al el caracter
        out hand_data, al    ; envio al hand-shake el caracter

        inc bx               ; incremento direccion caracter
        dec cl               ; decremento contador
        jnz poll             ; si no termino el contador loopeo

        int 0                ; hlt
end