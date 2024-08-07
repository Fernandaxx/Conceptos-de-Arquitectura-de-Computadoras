; Escribir un programa que implemente el siguiente fragmento escrito en un lenguaje de alto nivel:
;  while a > 0 do 
;  begin 
;   x := x + y; 
;   a := a - 1; 
;  end; 
; Ejecutar con la opción Delay Slot habilitada.

; slt     rd, rf, rg Compara rf con rg, dejando rd=1 si rf es menor que rg (valores con signo)
; rd = rf < rg

; 0  =  1 < 0
; 0  =  0 < 0
; 1  = -1 < 0
	.data
a:	.word 4
x:	.word 2
y:	.word 3

	.code

	lw r1, x(r0)		; r1 guarda x
	lw r2, y(r0)		; r2 guarda y
	lw r3, a(r0)		; r3 guarda a
	slt r4, r0, r3		; r4 guarda 1 0 < r3

	beq r4, r0, fin		; si 0 < r3, es decir 

	daddi r3, r3, -1	; decremento r3
while:	dadd r1, r1, r2		; x := x + y
	bnez r3, while		; loopear
	daddi r3, r3, -1	; decremento r3

fin:	sw r1, x(r0)		; guardo el valor de x
	halt