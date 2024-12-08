* inversor - simulação do circuito extraído do layout projetado
*
* FERNANDO MORAES   PUCRS
* MATHEUS MOREIRA   PUCRS

*
* modelo eletrico para uma tecnologia 65 nm
*
simulator lang=spectre insensitive=no
include "st65.scs"
simulator lang=spice
*
* descricao do inversor na forma de um subcircuito
*
.include "../pexRunDir/inv.pex.spi"
*
* descricao do circuito
* VERIFICAR o mapeamento posicional dos I/Os da célula
* iv = input ; out = output
X1  iv out vcc 0 inv
C3  out  0  25fF
*
* fontes de alimentacao/estimulo
*
vcc vcc  0  dc 1.0
vin1 iv  0  pulse (1.0 0 0 0.01N 0.01N 1N 2N) 
*
* controles para o simulador
*
.tran 0.001N 25N

* mede o tempo de descida do inversor
simulator lang=spice
.measure tran tdescida trig v(iv)  val=0.5  td=5n rise = 1 
+                      targ v(out) val=0.5        fall = 1

.measure tran tsubida  trig v(iv)  val=0.5  td=5n fall = 1 
+                      targ v(out) val=0.5        rise = 1

.measure tran TD  param = 'tdescida * 1e12'
.measure tran TS  param = 'tsubida * 1e12'

.END
