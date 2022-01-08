%PTC 5890 - 2019
%Prof: Magno T. M. Silva e Maria D. Miranda
%Aluno: Stéfano Albino Vilela Rezende (Ouvinte)
%P5 - Parte Computacional
%Exercício 3

close all
clear all
clc

Nu = 2;
K = 3; % número de antenas
Kt = 4; % diversidade temporal
N = 10^5;
M = K*Kt;
DELTA = 3;
lambda = 0.99;
delta=10^5;


e1_L_mean = zeros(N,1);
e2_L_mean = zeros(N,1);
e1_R_mean = zeros(N,1);
e2_R_mean = zeros(N,1);

h=waitbar(0,'Computando...');
for i=1:100
    
a1 = randi ([0 1], N, 1);
a2 = randi ([0 1], N, 1);


HN_2 = [0.43 0.46 -0.30; 0.21 -0.26 0.16; -0.37 -0.87 0.15; 0.55 -0.61 -0.09; 0.61 0.12 -0.24; 0.43 -0.52 0.31];
HN = [-0.03 0.05 -0.82; 0.78 0.36 1.21; 1.18 -0.19 -0.17; -1.77 -0.27 -0.26; -1.09 1.65 -0.68; 1.99 -0.37 -0.98];


u1=[filter(HN_2(1,:),[1],a1(1:N/2)); filter(HN(1,:),[1],a1(N/2+1:N))]+ [filter(HN_2(2,:),[1],a2(1:N/2)); filter(HN(2,:),[1],a2(N/2+1:N))];
u2=[filter(HN_2(3,:),[1],a1(1:N/2)); filter(HN(3,:),[1],a1(N/2+1:N))]+ [filter(HN_2(4,:),[1],a2(1:N/2)); filter(HN(4,:),[1],a2(N/2+1:N))];
u3=[filter(HN_2(5,:),[1],a1(1:N/2)); filter(HN(5,:),[1],a1(N/2+1:N))]+ [filter(HN_2(6,:),[1],a2(1:N/2)); filter(HN(6,:),[1],a2(N/2+1:N))];

var_v1_2=(10^-2.5)*var(u1);
var_v2_2=(10^-2.5)*var(u2);
var_v3_2=(10^-2.5)*var(u3);

v1 = 0.01*sqrt(var_v1_2)*randn(N,1);
v2 = 0.01*sqrt(var_v2_2)*randn(N,1);
v3 = 0.01*sqrt(var_v3_2)*randn(N,1);

u1=u1+v1;
u2=u2+v2;
u3=u3+v3;

mu = (1-lambda)/var([u1; u2; u3]);

[y1_L,e1_L,W1_L] = MU_LMS (u1,u2,u3,a1,M,Kt,mu,N,DELTA);
[y2_L,e2_L,W2_L] = MU_LMS (u1,u2,u3,a2,M,Kt,mu,N,DELTA);

[y1_R,e1_R,W1_R] = MU_RLS (u1,u2,u3,a1,M,Kt,delta,N,lambda,DELTA);
[y2_R,e2_R,W2_R] = MU_RLS (u1,u2,u3,a2,M,Kt,delta,N,lambda,DELTA);

e1_L_mean = e1_L+e1_L_mean;
e2_L_mean = e2_L+e2_L_mean;
e1_R_mean = e1_R+e1_R_mean;
e2_R_mean = e2_R+e2_R_mean;

waitbar(i/100);
end
close(h);

e1_L_mean = e1_L_mean/100;
e2_L_mean = e2_L_mean/100;
e1_R_mean = e1_R_mean/100;
e2_R_mean = e2_R_mean/100;

Lfilter = 256;

figure(1)
plot (filter(ones(Lfilter,1)/Lfilter,1,10*log10(abs(e1_L_mean.^2))))
hold on
plot (filter(ones(Lfilter,1)/Lfilter,1,10*log10(abs(e2_L_mean.^2))))
plot (filter(ones(Lfilter,1)/Lfilter,1,10*log10(abs(e1_R_mean.^2))))
plot (filter(ones(Lfilter,1)/Lfilter,1,10*log10(abs(e2_R_mean.^2))))
hold off
legend('LMS - EQ 1', 'LMS - EQ 2', 'RLS - EQ 1','RLS - EQ 2')
title('Erro médio Quadrático'); ylabel('MSE [dB]'); xlabel('Iterações');grid