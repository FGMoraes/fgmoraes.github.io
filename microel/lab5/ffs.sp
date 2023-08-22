* FERNANDO MORAES - PUCRS *  flip-flops  - UPDATED: 03/outubro/2022

simulator lang=spectre insensitive=no
include "st65.scs"
simulator lang=spice

******************************************************************
** TRANSITOR SIZING AND OUTPUT LOAD USED DURING THIS SIMULATION
******************************************************************
.param Wp=0.3  Wn=0.15  Cload=3fF

******************************************************************
** BASIC GATES
******************************************************************
.subckt inv in out  vcc
MP1 out in vcc  vcc   psvtgp w=wp l=0.06
MM2 out in 0    0     nsvtgp w=wn l=0.06
.ends inv

.subckt invX4 in out  vcc
MP1 out in vcc  vcc   psvtgp w=wp*4 l=0.06
MM2 out in 0    0     nsvtgp w=wn*4 l=0.06
.ends invX4

.subckt inv_tg in ck nck out  vcc
MP1 1   in  vcc  vcc   psvtgp w=wp l=0.06
MP2 out nck 1    vcc   psvtgp w=wp l=0.06
MM1 out ck  2    0     nsvtgp w=wn l=0.06
MM2 2   in  0    0     nsvtgp w=wn l=0.06
.ends inv_tg

.SUBCKT nand2 o1 s1 s2 vcc
M1 o1 s1 vcc vcc psvtgp w=wp l=0.06
M2 o1 s2 vcc vcc psvtgp w=wp l=0.06
M3 0  s1 2   0   nsvtgp w=wn l=0.06
M4 2  s2 o1  0   nsvtgp w=wn l=0.06
.ENDS nand2

.subckt tg a b nb out vcc
MP1 a  nb out vcc   psvtgp w=wp l=0.06
MN1 a   b out 0     nsvtgp w=wn l=0.06
.ends tg

.subckt clckg CLK clkG vcc
M1 n0 CLK vcc vcc psvtgp w=wp l=0.06
M2 n0 clkG 0  0   nsvtgp w=wn l=0.4
X1 n1 CLK n0 vcc nand2
X2 n1 clkG vcc inv
.ends clckg

******************************************************************
**  FLIP-FLOPS  
******************************************************************
.subckt latch D Q ck nck vcc
X1 D   Y           vcc inv
X2 Y   ck   nck  X vcc tg
X3 X   Z           vcc inv
X4 Z   nck   ck  X vcc inv_tg
X5 X   Q           vcc inv
.ends latch

.subckt ff_static D Q NQ ck nck vcc
X1 D   Y           vcc inv
**  X2   ------ descomentar e completar
**  X3 
**  X4 
**  X5 
**  X6 
**  X7 
**  X8 
**  X9 
.ends ff_static

.subckt ff_tspc D Q nQ ck vcc
** M3   ------ descomentar e completar
** M2
** M1
** M6
** M5
** M4
** M9
** M8
** M7
X1 nQ  Q    vcc inv
.ends ff_tspc

.subckt ff_pulse d q clkG vcc
** M3   ------ descomentar e completar
** M2  
** M1  
** M6  
** M5  
** M4  
.ends ff_pulse

******************************************************************
** CIRCUIT DESCRIPTION
******************************************************************

**** parte 1 - LATCH ***********
X1 D q_latch CK nCK vcc latch
C1 q_latch 0 Cload

**** parte 2 - FLOPS MESTRE ESCRAVO 
*X2 
*X3   ------ descomentar e completar de acordo com tutorial do laboratório
*X4 
*X5 

*C21
*C31
*C41

** parte 3 - divisor de clock **************
X6  nq4 q4 nq4 CK nCK vcc ff_static
C61 q4  0 clms

** parte 4 - contador  **************
.ic v(f0)=0 v(f1)=0 v(f2)=0 v(f3)=0 v(nf0)=1 v(nf1)=1 v(nf2)=1 v(nf3)=1
Xc0 nf0 f0 nf0 CK nCK  vcc ff_static
*Xc1 
*Xc2  ------ descomentar e completar de acordo com tutorial do laboratório
*Xc3 

c5 f0 0 Cload
*c6 
*c7 
*c8 


******************************************************************
** SIMULATION CONTROL AND CLOCK/INPUT SOURCES
******************************************************************

** SIMULATION TIME
.tran .01N 20N

vcc vcc 0 dc 1

** clock signal
v1G ck1G 0 pulse( 1 0 0 0.03N 0.03N 0.5N 1N)
Xb1 ck1G CK   vcc invX4
Xb2 CK   nCK  vcc invX4

** D input - two inverters to generate the D signal to generate a realistic ramp
v2 Din 0 pwl(    0n   0   0.3n   0
+            0.303n   1   0.7n   1
+            0.703n   0   0.9n   0
+            0.903n   1   1.3n   1
+            1.303n   0   2.2n   0
+            2.203n   1   2.4n   1
+            2.403n   0   2.7n   0
+            2.703n   1   3.2n   1
+            3.203n   0   3.4n   0
+            3.403n   1   3.8n   1
+            3.803n   0   4.55n   0
+            4.553n   1 )
Xb3 Din  D2   vcc inv
Xb4 D2   D    vcc invX4


.measure tran t_fr trig v(CK) val=0.5 td=0.5n rise = 1 targ v(qE) val=0.5 rise = 1
.measure tran t_fs trig v(CK) val=0.5 td=0.5n rise = 2 targ v(qE) val=0.5 fall = 1

.measure tran t_tr trig v(CK) val=0.5 td=0.5n rise = 1 targ v(qT) val=0.5 rise = 1
.measure tran t_ts trig v(CK) val=0.5 td=0.5n rise = 2 targ v(qT) val=0.5 fall = 1

.measure tran t_pr trig v(clkG) val=0.5 td=0.5n rise = 1 targ v(qP) val=0.5 rise = 1
.measure tran t_ps trig v(clkG) val=0.5 td=0.5n rise = 2 targ v(qP) val=0.5 fall = 1

.measure tran t1_F_FFD     param = 't_fs * 1e12'
.measure tran t1_R_FFD     param = 't_fr * 1e12'
.measure tran t2_F_TSPC    param = 't_ts * 1e12'
.measure tran t2_R_TSPC    param = 't_tr * 1e12'
.measure tran t3_F_PULSADO param = 't_ps * 1e12'
.measure tran t3_R_PULSADO param = 't_pr * 1e12'

.param clms=20fF    
*.alter
*.param clms=80fF
*.alter
*.param clms=140fF
.end