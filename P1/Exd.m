
%Geração do sinal a(n)
M = 7
n = 10000
a = 2*randi ([0 1], n, 1)-1


%Geração do sinal d(n)
nd2 = [0; 0; 1]
nd3 = [0; 0; 0; 1]
nd4 = [0; 0; 0; 0; 1]
nd7 = [0; 0; 0; 0; 0; 0; 0; 1]

d2 = filter(nd2,[1],a)
d3 = filter(nd3,[1],a)
d4 = filter(nd4,[1],a)
d7 = filter(nd7,[1],a)


%Resposta do Canal
h = [0.3887; 1; 0.3887]
a1 = filter(h,[1],a)
noise = 0.001*randn(size(a,1),1)
u = a1 + noise

%Cálculo da Matriz de Correlação Estimada e Vetores de Correlação Cruzada Estimado
[R,p2,Wo2] = Wiener(u,d2,M)
[R,p3,Wo3] = Wiener(u,d3,M)
[R,p4,Wo4] = Wiener(u,d4,M)
[R,p7,Wo7] = Wiener(u,d7,M)

Rres= Rteo-R
p2res= p2teo-p2
p3res= p3teo-p3
p4res= p4teo-p4
p7res= p7teo-p7

Rnorm = norm(Rres)
p2norm = norm(p2res)
p3norm = norm(p3res)
p4norm = norm(p4res)
p7norm = norm(p7res)

y2 = filter(Wo2,[1],u)
y3 = filter(Wo3,[1],u)
y4 = filter(Wo4,[1],u)
y7 = filter(Wo7,[1],u)



