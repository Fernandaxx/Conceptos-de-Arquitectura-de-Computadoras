; hand-shake
hand_data equ 40h
hand_state equ 41h

org 1000h
        caracteres db 0, 0, 0, 0, 0
        
        
org 2000h
        ; configurar hand-shake
        in al, hand_state         ; guardo estado del hand-shake
        and al, 01111111b         ; apago el bit de interrupcion
        out hand_state, al        ; envio nuevo estado

        mov cx, 5                 ; contador
        mov bx, offset caracteres ; direccion caracteres

leer_caracteres:int 6             ; leo caracter y lo guardo en [bx]
        inc bx                    ; direccion siguiente caracter
        dec cl                    ; decrementa contador
        jnz leer_caracteres       ; loopea si el contador no es 0

        mov cl, 5                 ; seteo contador
        mov bx, offset caracteres ; direccion caracteres

poll:   in al, hand_state         ; guardo estado impresora
        and al, 1                 ; reviso bit busy
        jnz poll                  ; si busy esta activo loopea

        mov al, [bx]              ; guardo en al el caracter
        out hand_data, al         ; envio caracter a imprimir

        inc bx                    ; direccion siguiente contador
        dec cl                    ; decrezco contador
        jnz poll                  ; si contador no es 0 loopeo


        mov cl, 5                 ; contador
        mov bx, offset caracteres ; direccion carateces
        add bx, 4                 ; desplazamiento

poll_invertido:   in al, hand_state ; guardo estado impresora
        and al, 1                 ; reviso bit busy
        jnz poll_invertido        ; si busy esta activo loopea

        mov al, [bx]              ; guardo en al el caracter
        out hand_data, al         ; envio caracter a imprimir

        dec bx                    ; direccion siguiente contador (anterior)
        dec cl                    ; decrezco contador
        jnz poll_invertido        ; si contador no es 0 loopeo

        int 0                     ; hlt
        
end


; org 1000h
;         caracteres db 0, 0, 0, 0, 0
;         invertidos db 0, 0, 0, 0, 0

; leer_caracteres: mov bx, offset caracteres ; direccion inicio caracteres
;         add bx, 5                 ; adelanto 5
;         sub bx, cx                ; retrocedo hasta caracetr actual
        
;         int 6                     ; leo caracter y lo guardo en [bx]
;         mov al, [bx]              ; guardo en al el caracter

;         mov bx, offset invertidos ; direccion inicio invertidos
;         dec bx                    ; decremento 1 porque cl va de 5 a 1
;         add bx, cx                ; adelanto hasta caracter actual
;         mov [bx], al              ; copio caracter en posicion invertida
        
;         dec cl                    ; decrementa contador
;         jnz leer_caracteres       ; loopea si el contador no es 0

;         mov cx, 5
