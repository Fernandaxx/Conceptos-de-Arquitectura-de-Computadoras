;Encendido/apagado de las luces (periférico de salida) mediante 
;  la barra de microconmutadores (periférico de entrada), ambos 
;  comunicados con el microprocesador a través de los puertos 
;  paralelos de la PIO. Implementar un programa en el  lenguaje
;  assembly  del  simulador  MSX88  que  configure  la  PIO
;  para  leer  el  estado  de  los  microconmutadores  y 
;  escribirlo  en  la  barra  de  luces.  El  programa  se  debe
;  ejecutar  bajo  la  configuración  P1  C0  del  simulador.
;  Los microconmutadores se manejan con las teclas 0-7. 

pa equ 30h
pb equ 31h
ca equ 32h
cb equ 33h

org 2000h
        ; configuro el puerto A del PIO; 0 salida - 1 entrada
        mov al, 0
        out pa, al
        mov al, 11111111b; todos los bits en 1 
        out ca, al; todos los bits son de entrada para recibir 
                  ; señal de los switches
        
        ; configuro el puerto B del PIO; 0 salida - 1 entrada
        mov al, 0
        out pb, al
        mov al, 00000000b; todos los bits en 0
        out cb, al; todos los bits son de salida para mandar
                  ; señal a los leds

loop:   in al, pa ; guardo el estado de los switches en al
        out pb, al; modifico el estado de los leds
        jmp loop
        
        int 0

end 