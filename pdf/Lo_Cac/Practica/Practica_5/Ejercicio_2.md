# Es posible convertir valores enteros almacenados en alguno de los registros r1-r31 a su representación equivalente en punto flotante y viceversa. Describa la funcionalidad de las instrucciones mtc1, cvt.l.d, cvt.d.l y mfc1.

-   ## mtc1

**mtc1 rf, fd**

Copia los 64 bits del registro entero rf en el registro fd de punto flotante.

Copia rf en fd.

-   ## mfc1

**mfc1 rd, ff**

Copia los 64 bits del registro ff de punto flotante al registro rd entero.

Copia ff en rd.

-   ## cvt.l.d

**cvt.l.d fd, ff**

Convierte a entero el valor en punto flotante contenido en ff, dejandolo en fd.

Convierte entero de ff a punto flotante en fd.

-   ## cvt.d.l

**cvt.d.l fd, ff**

Convierte a punto flotante el valor entero copiado al registro ff, dejandolo en fd.

Convierte punto flotante de ff a entero en fd.
