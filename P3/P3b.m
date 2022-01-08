%PTC 5890 - 2019
%Prof: Magno T. M. Silva e Maria D. Miranda
%Aluno: Stéfano Albino Vilela Rezende (Ouvinte)
%P3 - Parte Computacional item b

clear all
close all
clc

    
n = 501
H = [-0.34; -1; -0.97; 0.82; -0.33; 0.61; 0.72; 1.2; 0.39; -0.69]
M = 10
N = 500
mutil = [0.3 0.5 0.7 0.9 1.1 1.3 1.5 1.7]

h=waitbar(0,'Computando...');

for j=1:length(mutil)
 
delta = 10^-5
sigmav = 10^-4

 for rpt=1:100
u = randn(1,n)  %sinal de entrada
x=filter(H,[1],u)
v=sqrt(sigmav)*randn(1,n) %ruído de medida
d = x+v

[yn,en,WN] = NLMS (u,d,M,mutil(j),N,delta)

 EMSE_Sim(:,rpt)= en.^2-sigmav

 end

EMSE_Teo(j) = mutil(j)*sigmav /(2-mutil(j))

EMSEmean(j) = mean(mean(EMSE_Sim(0.9*N:N,:)))

waitbar(j/length(mutil))
end
close(h)

figure(1)
plot(mutil,10*log10(EMSEmean))
hold on
plot (mutil,10*log10(EMSE_Teo))
grid;title('EMSE');legend('NLMS-Simulado','NLMS-Teorico')
xlim([0.3 1.7]);xlabel('\mu');ylabel('EMSE[dB]')