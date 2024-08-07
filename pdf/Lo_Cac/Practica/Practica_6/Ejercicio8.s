.data 
CONTROL:       .word32 0x10000 
DATA:          .word32 0x10008 
color_pelota:  .word32 0x00FF00FF  ; Magenta 
color_fondo:   .word32 0x00FFFFFF  ; Blanco 
 
        .text 
        lwu    $s6, CONTROL($0) 
        lwu    $s7, DATA($0) 
        lwu    $v0, color_pelota($0) 
        lwu    $v1, color_fondo($0) 
        daddi  $s4, $0, 5      ; Comando para dibujar un punto 
        
        daddi  $s0, $0, 46     ; Coordenada X de la pelota 
        daddi  $s1, $0, 33     ; Coordenada Y de la pelota 
        daddi  $s2, $0, 2      ; Dirección X de la pelota 
        daddi  $s3, $0, 1      ; Dirección Y de la pelota 
        
        daddi  $t2, $0, 1     ; Coordenada X de la pelota 
        daddi  $t3, $0, 2     ; Coordenada Y de la pelota 
        daddi  $t4, $0, 3     ; DIR X de la pelota 
        daddi  $t5, $0, 2     ; DIR Y de la pelota 
        
        daddi  $t6, $0, 43     ; Coordenada X de la pelota 
        daddi  $t7, $0, 2     ; Coordenada Y de la pelota 
        daddi  $t8, $0, -2     ; DIR X de la pelota 2
        daddi  $t9, $0, -1     ; DIR Y de la pelota 2 

loop:   	;dadd $a0, $s0, $0
	;dadd $a1, $s1, $0
        	;jal game
	;dadd $s0, $a0, $0
	;dadd $s1, $a1, $0

	;dadd $a0, $t2, $0
	;dadd $a1, $t3, $0
	;dadd
        	;jal game
	;dadd $t2, $a0, $0
	;dadd $t3, $a1, $0
        	
	dadd $a0, $t4, $0
	dadd $a1, $t5, $0
        	dadd $a2, $t6, $0
	dadd $a3, $t7, $0
	jal game
	dadd $t4, $a0, $0
	dadd $t5, $a1, $0
        	dadd $t6, $a2, $0
	dadd $t7, $a3, $0
        	
        	
        j loop



        ; a0 pos x
        ; a1 pos y
        ; a2 dir x
        ; a3 dir y
game: sw     $v1, 0($s7)     ; Borra la pelota  
        sb     $a0, 4($s7)     ; DATA recibe pos x 
        sb     $a1, 5($s7)     ; DATA recibe pos y
        sd     $s4, 0($s6)     ; CONTROL recibe 5 GRAFICAR
        dadd   $a0, $a0, $a2   ; Eje X - Mueve la pelota en la dirección actual 
        dadd   $a1, $a1, $a3   ; Eje Y - Mueve la pelota en la dirección actual
        daddi  $t1, $0, 48     ; Comprueba que la pelota no esté en la columna de más 
        slt    $t0, $t1, $a0   ; a la derecha. Si es así, cambia la dirección en X. 
        dsll   $t0, $t0, 1 
        dsub   $a2, $a2, $t0 
        slt    $t0, $t1, $a1   ; Comprueba que la pelota no esté en la fila de más arriba. 
        dsll   $t0, $t0, 1     ; Si es así, cambia la dirección en Y. 
        dsub   $a3, $a3, $t0 
        slti   $t0, $a0, 1     ; Comprueba que la pelota no esté en la columna de más 
        dsll   $t0, $t0, 1     ; a la izquierda. Si es así, cambia la dirección en X. 
        dadd   $a2, $a2, $t0 
        slti   $t0, $a1, 1     ; Comprueba que la pelota no esté en la fila de más abajo. 
        dsll   $t0, $t0, 1     ; Si es así, cambia la dirección en Y. 
        dadd   $a3, $a3, $t0 
        sw     $v0, 0($s7)     ; Dibuja la pelota. 
        sb     $a0, 4($s7) 
        sb     $a1, 5($s7) 
        sd     $s4, 0($s6) 

        daddi  $t0, $0, 5000    ; Hace una demora para que el rebote no sea tan rápido. 
demora: daddi  $t0, $t0, -1    ; Esto genera una infinidad de RAW y BTS pero... 
        bnez   $t0, demora     ; ¡hay que hacer tiempo igualmente! 
        jr $ra