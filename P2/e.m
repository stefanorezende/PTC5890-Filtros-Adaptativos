%PTC 5890 - 2019
%Prof: Magno T. M. Silva
%Aluno: Stéfano Albino Vilela Rezende (Ouvinte)
%P2 - Parte Computacional

clear all
close all
clc

%e)
J=zeros(1,500)
mu=0.03 %passo do LMS
N = 500
n = [0:500] %número de amostras do sinais
M=2 %número de coeficiente do Filtro

for i=1:500

phiv = 2*pi*rand(1,1)
phiu = phiv



%ruído
s = 0.01*randn(1,size(n,2))

%Interferência indesejada
x = sin(2*pi.*n./10+pi/6+phiv)

%sinal correlacionado à interferência
u = 5*sin(2*pi.*n./10+phiu)

%sinal deseja d(n)
d = s+x

[R,p,Wo] = Wiener(u,d',M)

[y,e,W] = LMS (u,d,M,mu,N)

sigmad = var(d)

Jmin(i) = sigmad-Wo'*p
%J(n)  = E{e^2}
J(i) = Jmin(i) + (W(i,:)'-Wo)'*R*(W(i,:)'-Wo)
end

figure(1)
plot (J)
hold on
plot(ones(1,500)*Jmin(i))
ylim([0,0.1])


EMSE = mean(J)-mean(Jmin)

desaj = EMSE/mean(Jmin)

