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

mu = 0.001:0.001:0.1;
r_otimo = -Inf;
MSE_otimo = +Inf;

for i=1:length(mu)
    [y,e,W] = LMS (u,d,M,mu(i),N);
    
    [r_i] = ERLE(d,e,L);
    r(i)=10*log10(mean(10.^(r_i/10)));
    
    if r(i)>r_otimo
        r_otimo=r(i);
        mu_otimo1 = mu(i);
    end
    
    MSE(i)= 10*log10(mean(e.^2));
   
    if MSE(i)<MSE_otimo
        MSE_otimo=MSE(i);
        mu_otimo2 = mu(i);
    end 
end

figure(1);
plot(mu,r)
hold on
plot(mu,MSE)
plot(mu_otimo1,r_otimo,'rx')
plot(mu_otimo1,MSE_otimo,'kx')
xlabel('\mu'); ylabel('[dB]'); title('LMS'); grid;
ylim([-65 50]);legend ('ERLE', 'MSE', 'ERLE - Ótimo','MSE - Ótimo');