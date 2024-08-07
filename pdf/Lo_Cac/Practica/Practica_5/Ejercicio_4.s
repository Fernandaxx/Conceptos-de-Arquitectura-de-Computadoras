;El índice de masa corporal (IMC) es una medida de asociación entre el peso y la talla de un individuo . 
;Se  calcula  a  partir  del  peso  (expresado  en  kilogramos,  por  ejemplo:  75,7  kg)  y  la  estatura  (expresada  en  metros, 
;por ejemplo 1,73 m), usando la fórmula: 
;Error! 
;De acuerdo al valor calculado con este índice, puede clasificarse el estado nutricional de una persona en: 
;Infrapeso (IMC < 18,5),  Normal (18,5 ≤ IMC < 25), Sobrepeso (25 ≤ IMC < 30) y Obeso (IMC ≥ 30). 
; 
;Escriba  un  programa  que  dado  el  peso  y  la  estatura  de  una  persona  calcule  su  IMC  y  lo  guarde  en  la  dirección 
;etiquetada IMC. También deberá guardar en la dirección etiquetada estado un valor según la siguiente tabla:

;	IMC Clasificación Valor guardado 
;	< 18,5	Infrapeso 	1 
;	< 25 	Normal 	2 
;	< 30 	Sobrepeso 	3 
;	≥ 30 	Obeso 	4

;	IMC = Peso / (Altura x Altura)


;c.lt.d fd, ff	Compara fd con ff, dejando flag FP=1 si fd es menor que ff (en punto flotante) 
;c.le.d fd, ff	Compara fd con ff, dejando flag FP=1 si fd es menor o igual que ff (en punto flotante) 
;c.eq.d fd, ff	Compara fd con ff, dejando flag FP=1 si fd es igual que ff (en punto flotante)

	.data
peso:	.double 75.7
altura:	.double 1.73
imc:	.double 0
infra_normal:	.double 18.5
normal_sobre:	.double 25
sobre_obeso:	.double 30

	.code

	l.d f1, peso($0)	; guardo en f1 el peso
	l.d f2, altura($0)	; guardo en f2 la altura
	mtc1 $0, f3		; guardo en f3 el imc
	mtc1 $0, f4		; guardo en f4 valores temporales 
	dadd $v1, $0, $0	; guardo en v1 el resultado imc

	mul.d f3, f2, f2	; imc = altura x altura
	div.d f3, f1, f3	; imc = peso / ( altura x altura )

	; veo si es infrapeso
	l.d f4, infra_normal($0)	; cargo en f4 limite infra normal
	c.lt.d f3, f4		; FP=1 si f3 < f4
	bc1f normal
	daddi $v1, $0, 1
	j fin

normal:	; veo si es normal
	l.d f4, normal_sobre($0)	; cargo en f4 limite normal sobre
	c.lt.d f3, f4		; FP=1 si f3 < f4
	bc1f sobre_peso
	daddi $v1, $0, 2 
	j fin

sobre_peso:	; veo si es sobrepeso
	l.d f4, sobre_obeso($0)	; cargo en f4 limite sobre obeso
	c.lt.d f3, f4		; FP=1 si f3 < f4
	bc1f obeso
	daddi $v1, $0, 3
	j fin

obeso: 	; es obeso
	daddi $v1, $0, 4

fin:	sd $v1, imc($0)		; guardo en memoria el resultado del imc

	halt