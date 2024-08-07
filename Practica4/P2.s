.data 
A: .word  1 
B: .word  2 
 .code 
 ld  r1, A(r0) 
 ld  r2, B(r0) 
 sd  r2, A(r0) ; esta instruccion genera un atasco RAW; intenta leer antes de que lD llegue a WB
 sd  r1, B(r0) 
halt 

;2.2 CPI
; no se generan atascos , el forwarding tiene buffer temporales donde Sd toma el valor de R2
;1.8 CPI 