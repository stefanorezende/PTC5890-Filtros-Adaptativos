%PTC 5890 - 2019
%Prof: Maria D. Miranda
%Aluno: Stéfano Albino Vilela Rezende (Ouvinte)
%P3 - Parte Computacional

clear all
close all
clc

    
n = 500
H = [-0.34; -1; -0.97; 0.82; -0.33; 0.61; 0.72; 1.2; 0.39; -0.69]
M = 10
N = 500
mu =0.5
delta = 10^-5

Wmean=zeros(n+1,10)

u = randn(1,n)

v=10^-4*randn(1,n)

x=filter(H,[1],u)

d = x+v

[yn,en,Wn] = NLMS (u,d,M,mu,N,delta)
% [y,e,W] = LMS (u,d,M,mu,N)


figure(1)
stem(Wn(500,:))
hold on
stem(Wmean(500,:))
% figure (2)
% stem(W(500,:))
% figure (3)
stem (H')
legend('NLMS','media','Wo'); title('Coeficientes')
