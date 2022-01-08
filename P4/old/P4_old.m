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

h=waitbar(0,'Computando...');
for i=1:rlzc
    
 x = randn(1,N);   
 u = filter (sqrt(1-b^2),[1 -b],x);
 v=sqrt(sigmav2)*randn(1,N);   
 d=filter(H,1,u)+v;
 
[yN,eN,WN] = NLMS (u,d,M,mu_til,N,delta_NLMS)
[yR,eR,WR] = RLS (u,d,M,N,delta_RLS,lambda)


WNmean = (WN+WNmean)/2;
WRmean = (WR+WRmean)/2;

EMSE_NLMS_simul(:,i) = eN.^2-sigmav2; 
EMSE_RLS_simul(:,i) = eR.^2-sigmav2;

waitbar(i/rlzc);
end

close(h);

EMSE_NLMS_simul_mean = mean(EMSE_NLMS_simul,2);
EMSE_RLS_simul_mean = mean(EMSE_RLS_simul,2);

EMSE_NLMS_teor = mu_til*sigmav2/(2-mu_til);
EMSE_RLS_teor = (1-lambda)*M*sigmav2/2;

figure(1)
subplot(211)
plot(H.*ones(N+1,10));
hold on;
plot(WN);
xlim([0,N]);
grid;

subplot(212);
plot(H.*ones(N+1,10));
hold on;
plot(WR);
xlim([0,N]);
grid;

%Hmm = 1/64.*ones(1,64);

%EMSE_NLMS_simul_mean = filter(Hmm,[1],EMSE_NLMS_simul_mean);
%EMSE_RLS_simul_mean = filter(Hmm,[1],EMSE_RLS_simul_mean);

figure(2);
plot(10*log10(abs(EMSE_NLMS_simul_mean)));
hold on;
plot(10*log10(abs(EMSE_RLS_simul_mean)));
plot(10*log10(EMSE_NLMS_teor)*ones(N,1),'--k');
hold off;
grid; legend('NLSM','RLS','Teorico');ylabel('EMSE');xlabel('iterações')

