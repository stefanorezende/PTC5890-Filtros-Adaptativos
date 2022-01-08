%PTC 5890 - 2019
%Prof: Maria D. Miranda
%Aluno: Stéfano Albino Vilela Rezende (Ouvinte)
%P3 - Parte Computacional

clear all
close all
clc

    
n = 501
H = [-0.34; -1; -0.97; 0.82; -0.33; 0.61; 0.72; 1.2; 0.39; -0.69]
M = 10
N = 500
mutil =0.5 %Usado no NLMS
mu=2*mutil/(10*(2-mutil)) %Usado no LMS
delta = 10^-5
sigmav = 10^-4

WNmean=zeros(n,10)
WLmean=zeros(n,10)

Jl=zeros(n-1,1)
Jn=zeros(n-1,1)

for rpt=1:100

u = randn(1,n)  %sinal de entrada
v=sigmav*randn(1,n) %ruído de medida


uM=zeros(500,1)
for n=1:501 %vetor regressor passando pelo sistema
    uM=[u(n);uM(1:M-1)];
    x(n)= uM'*H
end

d = x+v     %sinal desejado

[yn,en,WN] = NLMS (u,d,M,mutil,N,delta)
[y,e,WL] = LMS (u,d,M,mu,N)

WNmean =(WN+WNmean)/2 %Cálculo da média dos coeficientes do filtro NLMS
WLmean =(WL+WLmean)/2 %Cálculo da média dos coeficientes do filtro LMS

Jl = ((e.^2)+Jl)/2
Jn = ((en.^2)+Jn)/2
end

%a1.
figure(1)
plot(H'.*ones(500,10))
hold on
plot(WNmean)
title('Coeficientes')
xlim([0,500])

%a2. e a3. resolvidas a mão.

%a4.
[R,p,Wo] = Wiener(u,d,M)
trR = trace(R)

EMSELMS = mu*sigmav *trR/2  %Cálculo do EMSE teórico para o LMS
EMSENLMS = mutil*sigmav /(2-mutil) %Cálculo do EMSE teórico para o NLMS

% for i=1:500
% sigmad = var(d)
% Jmin(i) = sigmad -Wo'*p'
% %J(n)  = E{e^2}
% Jl(i) = Jmin(i)+(WLmean(i,:)'-Wo)'*R*(WLmean(i,:)'-Wo)-sigmav
% Jn(i) = Jmin(i)+(WNmean(i,:)'-Wo)'*R*(WNmean(i,:)'-Wo)-sigmav
% end

figure(2)
plot(Jl)
hold on
plot(Jn)
plot(EMSELMS.*ones(500,1))
plot(EMSENLMS.*ones(500,1))
% ylim([0;0.1])
