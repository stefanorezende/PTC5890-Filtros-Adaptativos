%PTC 5890 - 2019
%Prof: Magno T. M. Silva
%Aluno: Stéfano Albino Vilela Rezende (Ouvinte)
%P2 - Parte Computacional

clear all
close all
clc

%f)
J=zeros(1,500)
%passos do LMS
mu1=0.01 
mu3=0.03
mu5=0.05
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
sigmad = var(d)

[R,p,Wo] = Wiener(u,d',M)
Jmin(i) = sigmad-Wo'*p

[y1,e1,W1] = LMS (u,d,M,mu1,N)
%J(n)  = E{e^2}
J1(i) = Jmin(i) + (W1(i,:)'-Wo)'*R*(W1(i,:)'-Wo)


[y3,e3,W3] = LMS (u,d,M,mu3,N)
%J(n)  = E{e^2}
J3(i) = Jmin(i) + (W3(i,:)'-Wo)'*R*(W3(i,:)'-Wo)

[y5,e5,W5] = LMS (u,d,M,mu5,N)
%J(n)  = E{e^2}
J5(i) = Jmin(i) + (W5(i,:)'-Wo)'*R*(W5(i,:)'-Wo)
end



figure(1)
plot (J1)
hold on
plot (J3)
plot (J5)
plot(ones(1,500)*Jmin(i))
ylim([0,0.1])
legend('mu=0.01','mu=0.03','mu=0.05')


EMSE1 = mean(J1)-mean(Jmin)
desaj1 = EMSE1/mean(Jmin)

EMSE3 = mean(J3)-mean(Jmin)
desaj3 = EMSE3/mean(Jmin)

EMSE5 = mean(J5)-mean(Jmin)
desaj5 = EMSE5/mean(Jmin)

