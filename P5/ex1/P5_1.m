%PTC 5890 - 2019
%Prof: Magno T. M. Silva e Maria D. Miranda
%Aluno: Stéfano Albino Vilela Rezende (Ouvinte)
%P5 - Parte Computacional
%Exercício 1

close all
clear all
clc

M = 150;
mu = 0.033;
mu_til = 0.591;
delta_NLMS = 10^-5;
delta_RLS = 10^-5;
lambda = 1;


[u, fs] = audioread('entrada.wav');
% sound (u, fs);

[d, fs] = audioread('desejado.wav');
% sound (d, fs);

N = size(u,1);


[y_L,e_L,W_L] = LMS (u,d,M,mu,N);
[y_N,e_N,W_N] = NLMS (u,d,M,mu_til,N,delta_NLMS);
[y_R,e_R,W_R] = RLS (u,d,M,N,delta_RLS,lambda);


L=1024;
Ta=1/fs;
tr=0:(N-1)*Ta/(N/L-1):(N-1)*Ta;


[r_L] = ERLE(d,e_L,L);
[r_N] = ERLE(d,e_N,L);
[r_R] = ERLE(d,e_R,L);

% sound (y_L, fs);
% sound (y_N, fs);
% sound (y_R, fs);

tempo=[0:N-1]/fs;% tempo em segundos

figure
plot(tr,r_L)
hold on
plot(tr,r_N)
plot(tr,r_R)
hold off;grid;
ylabel('ERLE (dB)'); xlabel('tempo (s)');legend('LMS', 'NLMS', 'RLS');


figure
subplot(511); plot(tempo,u(1:N),'b');
hold on
plot(tempo,d(1:N),'r');
hold off; grid
%
subplot(512); plot(tempo,d(1:N),'r');
hold on
plot(tempo,y_L(1:N),'b');
hold off; ylabel('LMS'); grid
% 
subplot(513); plot(tempo,d(1:N),'r');
hold on
plot(tempo,y_N(1:N),'b');
hold off; ylabel('NLMS'); grid
% 
subplot(514); plot(tempo,d(1:N),'r');
hold on
plot(tempo,y_R(1:N),'b');
hold off; ylabel('RLS'); grid
%
subplot(515)
plot(tr,r_L)
hold on
plot(tr,r_N,'r');
plot(tr,r_R,'g');legend('LMS','NLMS', 'RLS')
title('Redução de eco (LMS e RLS)')
ylabel('ERLE (dB)'); xlabel('tempo (s)')
hold off; grid
