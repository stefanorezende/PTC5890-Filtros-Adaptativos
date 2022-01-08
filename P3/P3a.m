%PTC 5890 - 2019
%Prof: Magno T. M. Silva e Maria D. Miranda
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

EMSEL_Sim=zeros(n-1,1)
EMSEN_Sim=zeros(n-1,1)

for rpt=1:100

u = randn(1,n)  %sinal de entrada
x=filter(H,[1],u)
v=sqrt(sigmav)*randn(1,length(x)) %ruído de medida
d = x+v     %sinal desejado

[yn,en,WN] = NLMS (u,d,M,mutil,N,delta)
[y,el,WL] = LMS (u,d,M,mu,N)

WNmean =(WN+WNmean)/2 %Cálculo da média dos coeficientes do filtro NLMS
WLmean =(WL+WLmean)/2 %Cálculo da média dos coeficientes do filtro LMS

EMSEL_Sim(:,rpt)= el.^2-sigmav
EMSEN_Sim(:,rpt)= en.^2-sigmav
end

%a1.
figure(1)
plot(H'.*ones(500,10))
hold on
plot(WNmean)
xlim([0,500])
grid;title('Velocidade de Convergência dos Coeficientes')
xlabel('Iterações')

%a2. e a3. resolvidas a mão.

%a4.
[R,p,Wo] = Wiener(u,d,M)
trR = trace(R)

EMSEL_Teo = mu*sigmav *trR/2  %Cálculo do EMSE teórico para o LMS
EMSEN_Teo = mutil*sigmav /(2-mutil) %Cálculo do EMSE teórico para o NLMS

figure(2)
plot(abs(mean(EMSEL_Sim,2)))
hold on
plot(abs(mean(EMSEN_Sim,2)))
plot(EMSEL_Teo.*ones(500,1))
plot(EMSEN_Teo.*ones(500,1))
grid;title('EMSE');legend('LMS-Simulado','NLMS-Simulado','LMS-Teorico','NLMS-Teorico')
xlabel('Iterações');ylabel('EMSE')

figure(3)
plot(abs(mean(EMSEL_Sim,2)))
hold on
plot(abs(mean(EMSEN_Sim,2)))
plot(EMSEL_Teo.*ones(500,1))
plot(EMSEN_Teo.*ones(500,1))
grid;title('EMSE Detalhe');legend('LMS-Simulado','NLMS-Simulado','LMS-Teorico','NLMS-Teorico')
xlabel('Iterações');ylabel('EMSE');ylim([0 1*10^-3])
