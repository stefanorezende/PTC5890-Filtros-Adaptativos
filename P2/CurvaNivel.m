%PTC 5890 - 2019
%Prof: Magno T. M. Silva
%Aluno: Stéfano Albino Vilela Rezende (Ouvinte)
%P2 - Parte Computacional

clear all
close all
clc

%o item a) foi feito a mão e será entregue ao professor.

n = [0:500]
phiv = 2*pi*rand(1,1)
phiu = phiv

%Número de coeficiente do Filtro
M=2

%ruído
s = 0.01*randn(1,size(n,2))

%Interferência indesejada
x = sin(2*pi.*n./10+pi/6+phiv)

%sinal correlacionado à interferência
u = 5*sin(2*pi.*n./10+phiu)

%sinal deseja d(n)
d = s+x


%b)
%Cálculo da Matriz R, vetor p e coeficientes ótimos
[R,p,Wo] = Wiener(u,d',M)

[Q A] = eig(R)
%Valor máximo de mu para o Algoritmo Steepest Descent
mu = 2/max(max(A))


%c)
N=500 %Número de iterações para o Algoritmo LMS

%Função LMS
[y,e,W] = LMS (u,d,M,0.03,N)


%Função de Custo
sigmad = var(d) %sigma de s(n)

Jmin = sigmad-Wo'*p
[w0,w1]=meshgrid(-0.1:0.01:.4, -0.4:0.01:0.1)

for i=1:size(w0,1)
    for j=1:size(w1,1)
J (i,j)= Jmin + [w0(i,j)-Wo(1,1) w1(i,j)-Wo(2,1)]*R*[w0(i,j)-Wo(1,1) w1(i,j)-Wo(2,1)]'
    end
end

v=[Jmin+0.05 Jmin+0.05]

figure(1)
contour(w0,w1,J,50)%,'ShowText','on')
hold on
contour(w0,w1,J,v,'ShowText','on')
for i=1:3:size(W,1)
    plot(W(i,1),W(i,2),'r -x')
end
figure(2)
plot(min(J))