; pio
pa equ 30h
pb equ 31h
ca equ 32h
cb equ 33h

org 1000h
        texto db 0,0,"We're no strangers to love", 0ah
              db "You know the rules and so do I", 0ah
              db "A full commitment's what I'm thinking of", 0ah
              db "You wouldn't get this from any other guy", 0ah
              db "I just wanna tell you how I'm feeling", 0ah
              db "Gotta make you understand", 0ah
              db "Never gonna give you up", 0ah
              db "Never gonna let you down", 0ah
              ;db "Never gonna run around and desert you", 0ah
              ;db "Never gonna make you cry", 0ah
              ;db "Never gonna say goodbye", 0ah
              ;db "Never gonna tell a lie and hurt you", 0ah
        texto_fin db ?
        texto_length db offset texto_fin - offset texto

org 2000h
        ; configuracion pio
        mov al, 00000011b ; 1 entrada de dato
        out ca, al        ; puerto a del pio entrada
        
        mov al, 00000000b ; 0 salida de dato
        out cb, al        ; puento b del pio salida 

        ; poner strobe en 0
        in al, pa            ; guardo info de la impresora en al
        and al, 11111101b    ; pongo el bit strobe en 0 
        out pa, al

        mov cl, texto_length ; contador texto
        mov bx, offset texto ; direccion de las letras

poll:   in al, pa            ; reviso si la impresora esta busy
        and al, 1            ; si al tiene el bit menos significativo 
                             ; en 1 la impresora esta busy
        jnz poll             ; si no se prende la z flag loopea

        mov al, [bx]         ; guardo en al el caracter
        out pb, al           ; envio el caracter a imprmimir

        ; pulso de strobe
        in al, pa            ; guardo info de impresora
        or al, 00000010b     ; enciendo el bit strobe
        out pa, al           ; envio el bit strobe
        in al, pa            ; guardo info de impresora
        and al, 11111101b    ; apago el bit strobe
        out pa, al           ; envio el bit strobe
        
        inc bx               ; siguiente caracter
        dec cl               ; decrezco contador
        jnz poll

        int 0
      
end
