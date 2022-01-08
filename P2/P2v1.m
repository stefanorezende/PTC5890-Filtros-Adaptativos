%PTC 5890 - 2019
%Prof: Magno T. M. Silva
%Aluno: Stéfano Albino Vilela Rezende (Ouvinte)
%P2 - Parte Computacional

clear all
close all
clc

%o item a) foi feito a mão e será entregue ao professor.

n = [0:500]
phiv = 2*pi*rand(1,1)
phiu = phiv

%Número de coeficiente do Filtro
M=2

%ruído
s = 0.01*randn(1,size(n,2))

%Interferência indesejada
x = sin(2*pi.*n./10+pi/6+phiv)

%sinal correlacionado à interferência
u = 5*sin(2*pi.*n./10+phiu)

%sinal deseja d(n)
d = s+x


%b)
%Cálculo da Matriz R, vetor p e coeficientes ótimos
[R,p,Wo] = Wiener(u,d',M)

A = eig(R)
%Valor máximo de mu para o Algoritmo Steepest Descent
mu = 2/max(A)


%c)
N=500 %Número de iterações para o Algoritmo LMS

%Função LMS
[y,e,W] = LMS (u,d,M,0.03,N)

%Gráfico contendo u(n), e(n) e s(n)
figure(1)
stem(s(1:50))
hold on
stem(u(1:50))
stem(e(1:50))
legend('s(n)','u(n)','e(n)')

%Gráfico de comparação entre os coef ao longo da iterações e os coef ótimos
figure(2)
plot(W)
hold on
plot(ones(500)*Wo(1))
plot(ones(500)*Wo(2))

%Cálculo do erro quadrático em dB
edB=10*log10(e.^2)

%Filtragem do erro por um filtro de média móvel para melhor visualização
%dos resultados
Hmm = 1/64.*ones(1,64)

fedB = filter(Hmm,[1],edB)

%Curva do erro quadrático em dB
figure(4)
plot(fedB)

%Função de Custo
[Q A] = eig(R)

sigmad = var(d) %sigma de s(n)

Jmin = sigmad-p'*Wo


% Wf = W(size(W,1),:)'
% 
% v=Q'*(Wf'-Wo)

% for i=1:size(W,1)
% v(:,i)= Q'*(W(i,:)'-Wo)
% end
% 
% J = Jmin + v'*A*v

% J2 = Jmin + (W'-Wo)'*R*(W'-Wo)

% w0=[0:2]
% w1=[0:2]
[w0,w1]=meshgrid(-0.5:.01:0.5)
%J3 = sigmad - 2.*p'.*W + W'.*R.*W

J2 = sigmad - 2.*p(1,1).*w0 - 2.*p(2,1).*w1 + w0.*w1 + R(1,1).*(w0.^2+w1.^2)

%J3 = sigmad - 2.*p(1,1).*W(:,1) - 2.*p(2,1).*W(:,2) + W(:,1).*W(:,2) + R(1,1).*(W(:,1).^2+W(:,2).^2)

%J=sigd-2*Wo'*p+Wo'R*Wo
figure(5)
contour(w0,w1,J2,10,'ShowText','on')


%d)
for j=1:10
    mumax=0.03+(j*0.005)
[ymu,emu,Wmu] = LMS (u,d,M,mumax,N)

figure(6)
plot(Wmu)
hold on
plot(ones(500)*Wo(1))
plot(ones(500)*Wo(2))
end