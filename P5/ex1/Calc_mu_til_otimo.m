%PTC 5890 - 2019
%Prof: Magno T. M. Silva e Maria D. Miranda
%Aluno: Stéfano Albino Vilela Rezende (Ouvinte)
%P5 - Parte Computacional
%Exercício 1

close all
clear all
clc

d = audioread('desejado.wav');
[u, fs] = audioread('entrada.wav');
N = length(u);
L = 1024;
M = 150;
delta = 10^-5;

mu_til = 0.001:0.01:2;
r_otimo = -Inf;
MSE_otimo = +Inf;

for i=1:length(mu_til)
    [y,e,W] = NLMS (u,d,M,mu_til(i),N,delta);
    
    [r_i] = ERLE(d,e,L);
    r(i)=10*log10(mean(10.^(r_i/10)));
    
    if r(i)>r_otimo
        r_otimo=r(i);
        mu_til_otimo1 = mu_til(i);
    end
    
    MSE(i)= 10*log10(mean(e.^2));
   
    if MSE(i)<MSE_otimo
        MSE_otimo=MSE(i);
        mu_til_otimo2 = mu_til(i);
    end 
end

figure(1);
plot(mu_til,r)
hold on
plot(mu_til,MSE)
plot(mu_til_otimo1,r_otimo,'rx')
plot(mu_til_otimo2,MSE_otimo,'kx')
xlabel('\mu'); ylabel('[dB]'); title('NLMS'); grid;
ylim([-65 50]);legend ('ERLE', 'MSE', 'ERLE - Ótimo','MSE - Ótimo');