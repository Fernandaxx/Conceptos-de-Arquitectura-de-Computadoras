
org 1000h

org 2000h

mov ax, 5
mov bx, 3
push ax
push ax
push bx
pop bx
pop bx
pop ax

  hlt
  end