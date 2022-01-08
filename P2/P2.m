%PTC 5890 - 2019
%Prof: Magno T. M. Silva
%Aluno: St�fano Albino Vilela Rezende (Ouvinte)
%P2 - Parte Computacional

clear all
close all
clc

%o item a) foi feito a m�o e ser� entregue ao professor.

n = [0:500]
phiv = 2*pi*rand(1,1)
phiu = phiv

%N�mero de coeficiente do Filtro
M=2

%ru�do
s = 0.01*randn(1,size(n,2))

%Interfer�ncia indesejada
x = sin(2*pi.*n./10+pi/6+phiv)

%sinal correlacionado � interfer�ncia
u = 5*sin(2*pi.*n./10+phiu)

%sinal deseja d(n)
d = s+x


%b)
%C�lculo da Matriz R, vetor p e coeficientes �timos
[R,p,Wo] = Wiener(u,d',M)

A = eig(R)
%Valor m�ximo de mu para o Algoritmo Steepest Descent
mu = 2/max(A)


%c)
N=500 %N�mero de itera��es para o Algoritmo LMS

%Fun��o LMS
[y,e,W] = LMS (u,d,M,0.03,N)

%Gr�fico contendo u(n), e(n) e s(n)
figure(1)
stem(s(1:50))
hold on
stem(u(1:50))
stem(e(1:50))
legend('s(n)','u(n)','e(n)')

%Gr�fico de compara��o entre os coef ao longo da itera��es e os coef �timos
figure(2)
plot(W)
hold on
plot(ones(500)*Wo(1))
plot(ones(500)*Wo(2))

%Fun��o de Custo
sigmad = var(d) %sigma de s(n)

Jmin = sigmad-Wo'*p
[w0,w1]=meshgrid(-0.1:0.01:.4, -0.4:0.01:0.1)

for i=1:size(w0,1)
    for j=1:size(w1,1)
J (i,j)= Jmin + [w0(i,j)-Wo(1,1) w1(i,j)-Wo(2,1)]*R*[w0(i,j)-Wo(1,1) w1(i,j)-Wo(2,1)]'
    end
end

v=[Jmin+0.05 Jmin+0.05]

figure(3)
contour(w0,w1,J,50)%,'ShowText','on')
hold on
contour(w0,w1,J,v,'ShowText','on')
for i=1:3:size(W,1)
    plot(W(i,1),W(i,2),'r -x')
end

%C�lculo do erro quadr�tico em dB
edB=10*log10(e.^2)

%Filtragem do erro por um filtro de m�dia m�vel para melhor visualiza��o
%dos resultados
Hmm = 1/64.*ones(1,64)

fedB = filter(Hmm,[1],edB)

%Curva do erro quadr�tico em dB
figure(4)
plot(fedB)

%d)
for j=1:10
    mumax=0.03+(j*0.005)
[ymu,emu,Wmu] = LMS (u,d,M,mumax,N)

figure(5)
plot(Wmu)
hold on
plot(ones(500)*Wo(1))
plot(ones(500)*Wo(2))
end