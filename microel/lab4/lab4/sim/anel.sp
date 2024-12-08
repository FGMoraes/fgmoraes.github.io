* inversores em anel para cálculo de frequência com inversor extraído
*
* FERNANDO MORAES   PUCRS
* MATHEUS MOREIRA   PUCRS

*
* modelo eletrico para uma tecnologia 65 nm
*
simulator lang=spectre insensitive=no
include "st65.scs"
simulator lang=spice


**
**  PARA SIMULACAO COM ATRASO USAR A LINHA ABAIXO
**
.include "../pexRunDir/inv.pex.spi"


X1  a  o  vcc 0 inv
X2  b  a   vcc 0 inv
X3  c  b   vcc 0 inv
X4  d  c   vcc 0 inv
X5  e  d   vcc 0 inv
X6  f  e   vcc 0 inv
X7  g  f   vcc 0 inv
X8  h  g   vcc 0 inv
X9  i  h   vcc 0 inv
X10  j  i   vcc 0 inv
X11  k  j   vcc 0 inv
X12  l  k   vcc 0 inv
X13  m  l   vcc 0 inv
X14  n  m   vcc 0 inv
X15  o  n   vcc 0 inv

vcc vcc  0  dc 1.0

.tran 0.001N 10N

.ic v(o)=1.0

** medidas
.measure tran tf  trig v(j)  val=0.6  td=2n rise = 1 
+                 targ v(i)  val=0.6        fall = 1
.measure tran tr  trig v(j)  val=0.6  td=2n fall = 1 
+                 targ v(i)  val=0.6        rise = 1
.measure tran periodo  param = '(tf+tr) * 1e9 * 15'
.measure tran freq_ghz  param = '1/periodo'

.end
