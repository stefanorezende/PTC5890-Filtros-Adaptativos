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
d_f = fft(d);
u_f = fft(u);
H_f = d_f./u_f;
H = ifft(H_f);
L = 10;
for n = 1:length(H)
    buffer = H(n:(n + L - 1));
    if sum(abs(buffer) > 10^-4) == 0
        M = n - 1;
        break;
    end
end
plot(H(1:floor(M*1.2)));
title('Solução Estimada de H');grid;