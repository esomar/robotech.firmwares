v 20100214 2
C 40000 40000 0 0 0 title-B.sym
C 44600 40200 1 0 0 arduino.sym
{
T 45000 47000 5 10 0 0 0 0 1
device=Arduino Nano
T 45000 47200 5 10 0 0 0 0 1
footprint=SOT323
T 44600 40200 5 10 0 0 0 0 1
refdes=U?
}
C 48300 45600 1 0 0 l298n.sym
{
T 48700 49600 5 10 0 0 0 0 1
device=L298N
T 48700 49800 5 10 0 0 0 0 1
footprint=SOT323
T 48300 45600 5 10 0 0 0 0 1
refdes=U?
}
C 51800 43900 1 0 0 dc_motor-1.sym
{
T 52200 44900 5 10 1 1 0 0 1
device=Motor A
T 52300 44500 5 10 0 0 0 0 1
refdes=M?
}
C 51900 49400 1 0 0 dc_motor-1.sym
{
T 52300 50400 5 10 1 1 0 0 1
device=Motor B
T 52400 50000 5 10 0 1 0 0 1
refdes=M?
}
B 41300 40400 1200 1400 3 0 0 0 -1 -1 0 -1 -1 -1 -1 -1
T 41700 41900 9 10 1 0 0 0 1
Servo
P 42900 41600 42500 41600 1 0 0
{
T 42900 41600 5 10 0 0 0 0 1
pintype=unknown
T 42445 41095 5 10 1 1 0 6 1
pinlabel=Supply
T 42595 41645 5 10 1 1 0 0 1
pinnumber=1
T 42900 41600 5 10 0 0 0 0 1
pinseq=0
}
P 42900 41100 42500 41100 1 0 0
{
T 42900 41100 5 10 0 0 0 0 1
pintype=unknown
T 42445 41595 5 10 1 1 0 6 1
pinlabel=PWM Control
T 42595 41145 5 10 1 1 0 0 1
pinnumber=2
T 42900 41100 5 10 0 0 0 0 1
pinseq=0
}
P 42900 40600 42500 40600 1 0 0
{
T 42900 40600 5 10 0 0 0 0 1
pintype=unknown
T 42445 40595 5 10 1 1 0 6 1
pinlabel=GND
T 42595 40645 5 10 1 1 0 0 1
pinnumber=3
T 42900 40600 5 10 0 0 0 0 1
pinseq=0
}
B 41100 42400 1200 1400 3 0 0 0 -1 -1 0 -1 -1 -1 -1 -1
P 42700 43600 42300 43600 1 0 0
{
T 42700 43600 5 10 0 0 0 0 1
pintype=unknown
T 42245 43095 5 10 1 1 0 6 1
pinlabel=Supply
T 42395 43645 5 10 1 1 0 0 1
pinnumber=1
T 42700 43600 5 10 0 0 0 0 1
pinseq=0
}
P 42700 43100 42300 43100 1 0 0
{
T 42700 43100 5 10 0 0 0 0 1
pintype=unknown
T 42245 43595 5 10 1 1 0 6 1
pinlabel=PWM Control
T 42395 43145 5 10 1 1 0 0 1
pinnumber=2
T 42700 43100 5 10 0 0 0 0 1
pinseq=0
}
P 42700 42600 42300 42600 1 0 0
{
T 42700 42600 5 10 0 0 0 0 1
pintype=unknown
T 42245 42595 5 10 1 1 0 6 1
pinlabel=GND
T 42395 42645 5 10 1 1 0 0 1
pinnumber=3
T 42700 42600 5 10 0 0 0 0 1
pinseq=0
}
T 41500 43900 9 10 1 0 0 0 1
Servo
N 42700 43600 43000 43600 4
N 43600 42400 43000 43600 4
N 43600 42400 44700 41900 4
N 42900 41600 44700 41100 4
N 42900 41100 43400 41100 4
N 42700 43100 42900 43100 4
C 42500 42300 1 0 0 ground.sym
C 42700 40300 1 0 0 ground.sym
C 47000 45600 1 0 0 ground.sym
C 47700 47000 1 0 0 ground.sym
N 48400 47300 47900 47300 4
N 46900 45900 47200 45900 4
N 44700 44300 44200 44300 4
N 44200 44300 44200 47500 4
N 44200 47500 47700 47500 4
N 47700 47500 47700 44400 4
N 47700 44400 51400 44400 4
N 51400 44400 51400 46700 4
N 51400 46700 51000 46700 4
N 44700 43500 43800 43500 4
N 43800 43500 43800 47800 4
N 43800 47800 47600 47800 4
N 47600 47800 47600 44100 4
N 47600 44100 51700 44100 4
N 51700 44100 51700 47100 4
N 51700 47100 51000 47100 4
C 50800 45600 1 0 0 ground.sym
C 50800 48400 1 0 0 ground.sym
N 52300 47500 51000 47500 4
N 51600 47500 51600 47900 4
N 51600 47900 51000 47900 4
N 51000 48300 52100 48300 4
N 52100 48300 52100 49400 4
N 48400 48500 48400 50400 4
N 48400 50400 52100 50400 4
N 43700 48100 47900 48100 4
N 43700 43100 43700 48100 4
N 43700 43100 44700 43100 4
N 44700 42700 43600 42700 4
N 43600 42700 43600 48600 4
N 47900 48100 47900 47700 4
N 47900 47700 48400 47700 4
N 48400 48100 48000 48100 4
N 48000 48100 48000 48600 4
N 48000 48600 43600 48600 4
C 47900 46300 1 0 0 generic-power.sym
{
T 48100 46550 5 10 1 1 0 3 1
net=Vcc:8.6V
}
N 48400 46100 48400 43900 4
N 48400 43900 52000 43900 4
N 52000 44900 52000 46300 4
N 52000 46300 51000 46300 4
C 47000 45100 1 0 0 vcc-1.sym
{
T 47000 45100 5 10 1 1 0 0 1
net=+5V
}
C 52100 47500 1 0 0 vcc-1.sym
{
T 52100 47500 5 10 1 1 0 0 1
net=+5V
}
N 47200 45100 46900 45100 4
C 42700 43100 1 0 0 vcc-1.sym
{
T 42700 43100 5 10 1 1 0 0 1
net=+5V
}
C 43200 41100 1 0 0 vcc-1.sym
{
T 43200 41100 5 10 1 1 0 0 1
net=+5V
}
C 48100 46800 1 0 0 vcc-1.sym
{
T 48100 46800 5 10 1 1 0 0 1
net=+5V
}
B 41100 45000 1200 1400 3 0 0 0 -1 -1 0 -1 -1 -1 -1 -1
P 42700 46200 42300 46200 1 0 0
{
T 42245 45695 5 10 1 1 0 6 1
pinlabel=Supply
T 42700 46200 5 10 0 0 0 0 1
pintype=unknown
T 42395 46245 5 10 1 1 0 0 1
pinnumber=1
T 42700 46200 5 10 0 0 0 0 1
pinseq=0
}
P 42700 45700 42300 45700 1 0 0
{
T 42245 46195 5 10 1 1 0 6 1
pinlabel=PWM Control
T 42700 45700 5 10 0 0 0 0 1
pintype=unknown
T 42395 45745 5 10 1 1 0 0 1
pinnumber=2
T 42700 45700 5 10 0 0 0 0 1
pinseq=0
}
P 42700 45200 42300 45200 1 0 0
{
T 42245 45195 5 10 1 1 0 6 1
pinlabel=GND
T 42700 45200 5 10 0 0 0 0 1
pintype=unknown
T 42395 45245 5 10 1 1 0 0 1
pinnumber=3
T 42700 45200 5 10 0 0 0 0 1
pinseq=0
}
C 42500 44900 1 0 0 ground.sym
T 41500 46500 9 10 1 0 0 0 1
Servo
N 44700 41500 43300 41900 4
N 43300 41900 43300 46200 4
N 43300 46200 42700 46200 4
C 42500 45700 1 0 0 vcc-1.sym
{
T 42500 45700 5 10 1 1 0 0 1
net=+5V
}
N 48100 46300 48400 46500 4
N 48300 46800 48400 46900 4