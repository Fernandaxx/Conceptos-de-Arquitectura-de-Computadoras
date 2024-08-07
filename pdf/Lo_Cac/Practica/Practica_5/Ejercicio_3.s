;Escribir  un  programa  que  calcule  la  superficie  de  un  triángulo  rectángulo  de  base  5,85  cm  y  altura  13,47  cm.


	.data
base:	.double 5.85
altura:	.double 13.47
area:	.double 0.0
mitad:	.double 0.5

	.code
	l.d f1, base(r0)	; guardo en f1 la base
	l.d f2, altura(r0)	; guardo en f2 la altura
	add.d f3, f0, f0	; guardo en f3 el area
	l.d f4, mitad(r0)	; guardo en f4 el valor 1/2

	mul.d f3, f1, f2	; area = lado x lado
	mul.d f3, f3, f4	; area = lado x lado / 2

	s.d f3, area(r0)	; guardo en memoria el area

	halt





