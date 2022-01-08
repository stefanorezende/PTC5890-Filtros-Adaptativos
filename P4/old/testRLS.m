%PTC 5890 - 2019
%Prof: Magno T. M. Silva e Maria D. Miranda
%Aluno: Stéfano Albino Vilela Rezende (Ouvinte)
%P4 - Parte Computacional

clear all
close all
clc

M=10

N = 5000
H = [-0.34 -1 -0.97 0.82 -0.33 0.61 0.72 1.2 0.39 -0.69]

x = randn(1,N)
b = 0.8
u = filter (sqrt(1-b^2),[1 -b],x)

sigmav2=10^-4
v=sqrt(sigmav2)*randn(1,N)

d=filter(H,1,u)+v

mu_til = 0.1
delta_NLMS = 10^-5
delta_RLS = 0.1
lambda = 0.99



%FUNÇÃO
uM = zeros(M,1)
y = zeros(N,1)
e = zeros(N,1)
W = zeros(N+1,M)
R = delta_RLS^-1*eye(M,M)

for n=1:N
    
uM=[u(n);uM(1:M-1)];

k_til=R*uM

gama=1/(lambda+uM'*R*uM)

k = gama*k_til

%R = lambda^-1*R-lambda^-1*k*k_til' %VERSÃO 1
R=lambda^-1*R-(k_til*k_til')*lambda^-1*gama %VERSÃO 2

e(n) = d(n)-uM'*W(n,:)'
W(n+1,:) = W(n,:)+k'*e(n)
end
%FUNÇÃO

[yR,eR,WR] = RLS (u,d,M,N,delta_RLS,lambda)

EMSE_RLS_simul1= e.^2-sigmav2 
EMSE_RLS_simul2= eR.^2-sigmav2 
EMSE_RLS_teor = (1-lambda)*M*sigmav2/2

figure(1)
plot(H.*ones(N+1,10))
hold on
plot(W)
plot(WR)
% ylim([-2 2])
grid

figure(2)
plot(10*log10(abs(EMSE_RLS_simul1)))
hold on
plot(10*log10(abs(EMSE_NLMS_simul)))
plot(10*log10(EMSE_RLS_teor)*ones(N,1),'--k')
hold off
grid


