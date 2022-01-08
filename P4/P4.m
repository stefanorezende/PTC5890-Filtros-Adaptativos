%PTC 5890 - 2019
%Prof: Magno T. M. Silva e Maria D. Miranda
%Aluno: Stéfano Albino Vilela Rezende (Ouvinte)
%P4 - Parte Computacional

clear all;
close all;
clc;

M=10;
N = 5000;
rlzc = 50;
H = [-0.34 -1 -0.97 0.82 -0.33 0.61 0.72 1.2 0.39 -0.69];
b = 0.8;
sigmav2=10^-4;
mu_til = 0.1;
delta_NLMS = 10^-5;
delta_RLS = 0.1;
lambda = 0.99;

WNmean = zeros(N+1,M);
WRmean = zeros(N+1,M);

EMSE_NLMS_simul = zeros(N,rlzc);
EMSE_RLS_simul = zeros(N,rlzc);

EMS_NLMS_simul = zeros(N,1);
EMS_RLS_simul = zeros(N,1);

h=waitbar(0,'Computando...');
for i=1:rlzc
    
 x = randn(1,N);   
 u = filter (sqrt(1-b^2),[1 -b],x);
 v=sqrt(sigmav2)*randn(1,N);   
 d=filter(H,1,u)+v;

[yN,eN,eaN,WN] = NLMS (u,d,M,mu_til,N,delta_NLMS,H);
[yR,eR,eaR,WR] = RLS (u,d,M,N,delta_RLS,lambda,H);

WNmean = (WN+WNmean)/2;
WRmean = (WR+WRmean)/2;

% EQM
EMS_NLMS_simul = EMS_NLMS_simul+eN.^2; 
EMS_RLS_simul = EMS_RLS_simul+eR.^2;
% EQME
EMSE_NLMS_simul= EMSE_NLMS_simul+eaN(:).^2; 
EMSE_RLS_simul = EMSE_RLS_simul +eaR(:).^2;

waitbar(i/rlzc);
end
close(h);

%Média EQME
EMSE_NLMS_simul_mean = EMSE_NLMS_simul/rlzc;
EMSE_RLS_simul_mean = EMSE_RLS_simul/rlzc;

%Média EQM
EMS_NLMS_simul_mean = EMS_NLMS_simul/rlzc;
EMS_RLS_simul_mean = EMS_RLS_simul/rlzc;

%Valor Teórioco do EQME
EMSE_NLMS_teor = mu_til*sigmav2/(2-mu_til);
EMSE_RLS_teor = (1-lambda)*M*sigmav2/2;

%a)
figure(1) 
subplot(211)
plot(kron(ones(N+1,1),H),'k'); 
hold on;
plot(WN);
xlim([0,N]);
grid;
ylabel('NLMS')
title('Coeficientes do filtro')

subplot(212);
plot(kron(ones(N+1,1),H),'k'); 
hold on;
plot(WR); 
xlim([0,N]);
ylabel('RLS')
xlabel('iterações')
grid;

%c)
figure(2);
plot(10*log10(abs(EMSE_NLMS_simul_mean)));
hold on;
plot(10*log10(abs(EMSE_RLS_simul_mean)));
plot(10*log10(EMSE_NLMS_teor)*ones(N,1),'--k');
hold off;
grid; legend('NLSM','RLS','Teorico');ylabel('EMSE');xlabel('iterações')

figure(3);
plot(10*log10(abs(EMS_NLMS_simul_mean)));
hold on;
plot(10*log10(abs(EMS_RLS_simul_mean)));
% plot(10*log10(EMSE_NLMS_teor)*ones(N,1),'--k');
hold off;
grid; legend('NLSM','RLS');ylabel('EMS (dB)');xlabel('iterações')
