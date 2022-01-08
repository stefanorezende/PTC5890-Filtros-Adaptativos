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

lambda = 0.9:0.001:1;
r_otimo = -Inf;
MSE_otimo = +Inf;
h=waitbar(0,'Computando...');
for i=1:length(lambda)
    [y,e,W] = RLS (u,d,M,N,delta,lambda(i));
    
    [r_i] = ERLE(d,e,L);
    r(i)=10*log10(mean(10.^(r_i/10)));
    
    if r(i)>r_otimo
        r_otimo=r(i);
        lambda_otimo1 = lambda(i);
    end
    
    MSE(i)= 10*log10(mean(e.^2));
   
    if MSE(i)<MSE_otimo
        MSE_otimo=MSE(i);
        lambda_otimo2 = lambda(i);
    end 
    
   waitbar(i/100);
end
close (h);
figure(1);
plot(lambda,r)
hold on
plot(lambda,MSE)
plot(lambda_otimo1,r_otimo,'rx')
plot(lambda_otimo1,MSE_otimo,'kx')
xlabel('\lambda'); ylabel('[dB]'); title('RLS'); grid;
ylim([-80 60]);legend ('ERLE', 'MSE', 'ERLE - Ótimo','MSE - Ótimo','Location','southwest')