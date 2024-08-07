; pic
eoi equ 20h
imr equ 21h
irr equ 22h
isr equ 23h
int0 equ 24h

; hand-shake
hand_data equ 40h
hand_state equ 41h

; direccion interrupciones
i_printer equ 10

org 40
        ip_printer dw rut_printer

org 1000h
        texto db "Texto a imprimir", 0ah, 0, 0, 0, 0, 0
        texto_fin db ?
        texto_length db offset texto_fin - offset texto

org 3000h
rut_printer: push ax              ; guardo ax
        mov al, [bx]              ; guardo en al caracter
        out hand_data, al         ; envio al hand-shake el caracter
        inc bx                    ; direccion siguiente caracter
        dec cl                    ; decremento contador
        mov al, eoi               ; guardo finalizacion de interrupcion
        out eoi, al               ; envio finalizacion de interrupcion
        pop ax                    ; recupero ax
        iret                      ; retorno interrupcion

subrutina: inc dx
        ret

org 2000h

        mov dx, 0

        ; configuro data
        mov bx, offset texto      ; direccion primer caracter
        mov cl, texto_length      ; cant caracteres
        
        ; configuracion pic
        cli
        mov al, 11111011b         ; enmascaro toda interrupcion que no sea del hand-shake
        out imr, al               ; actualizo imr

        mov al, i_printer         ; guardo en al indice del vector interrupciones
        out int0 + 2, al          ; guardo en int 2 el indice a llamar

        ; configuracion hand-shake
        mov al, 10000000b         ; enciendo bit de interrupcion
        out hand_state, al        ; envio estado al hand
        sti

loop:   call subrutina 
        cmp cl, 0                 ; miro si hay mas caracteres
        jnz loop                  ; si hay caracteres loopeo

        in al, hand_state         ; guardo estado
        and al, 011111111b        ; apago bit interrupcion
        out hand_state, al        ; envio bit interrupcion apagado
      
        int 0                     ; hlt
end