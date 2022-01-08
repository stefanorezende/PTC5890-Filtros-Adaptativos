

h0=0.3887
h2=0.3887
h1=1
sgm=0.001

ru0 = h0^2 + h1^2 + h2^2 + sgm
ru1 = h1*h0 + h1*h2
ru2 = h2*h0
ru3 = 0
ru4 = 0
ru5 = 0
ru6 = 0

r = [ru0 ru1 ru2 ru3 ru4 ru5 ru6]

Rteo = toeplitz(r)
trR= trace(Rteo)

rud0 = h2
rud1 = h1
rud2 = h0

p2teo = [rud0; rud1; rud2; 0; 0; 0; 0]
p3teo = [0; rud0; rud1; rud2; 0; 0; 0]
p4teo = [0; 0; rud0; rud1; rud2; 0; 0]
p7teo = [0; 0; 0; 0; 0; rud0; rud1]