%PTC 5890 - 2019
%Prof: Maria D. Miranda
%Aluno: St?fano Albino Vilela Rezende (Ouvinte)
%P3 - Parte Computacional item b

clear all
close all
clc

    
n = 501
H = [-0.34; -1; -0.97; 0.82; -0.33; 0.61; 0.72; 1.2; 0.39; -0.69]
M = 10
N = 500
mutil = [0.3 0.5 0.7 0.9 1.1 1.3 1.5 1.7]

h=waitbar(0,'Aguarde...');
for j=1:length(mutil)
    
mu=2*mutil(j)/(10*(2-mutil(j))) %Usado no LMS
delta = 10^-5
sigmav = 10^-4

WNmean=zeros(n,10)
WLmean=zeros(n,10)

 for rpt=1:2
u = randn(1,n)  %sinal de entrada
x=filter(H,[1],u)
v=sigmav*randn(1,length(x)) %ru?do de medida
d = x+v

[R,p,Wo] = Wiener(u,d,M)
trR = trace(R)

sigmad = var(d)
Jmin(rpt) = sigmad -Wo'*p'


[yn,en,WN] = NLMS (u,d,M,mutil(j),N,delta)
[yl,el,WL] = LMS (u,d,M,mu,N)

WNmean =(WN+WNmean)/2 %C?lculo da m?dia dos coeficientes do filtro NLMS
WLmean =(WL+WLmean)/2 %C?lculo da m?dia dos coeficientes do filtro LMS

for i=1:500
Jl(i,rpt) = (WLmean(i,:)'-Wo)'*R*(WLmean(i,:)'-Wo)-sigmav
Jn(i,rpt) = (WNmean(i,:)'-Wo)'*R*(WNmean(i,:)'-Wo)-sigmav
end

% Jl(:,rpt)=el.^2-sigmav
% Jn(:,rpt)=en.^2-sigmav
end

EMSELMS(j) = mu*sigmav *trR/2
EMSENLMS(j) = mutil(j)*sigmav /(2-mutil(j))


Jlmean(j) = mean(mean(Jl(0.9*N:N,:)))-sigmav 
Jnmean(j) = mean(mean(Jn(0.9*N:N,:)))-sigmav 
waitbar(j/length(mutil))
end
close(h)
figure(1)
plot(mutil,10*log(Jlmean))
hold on
plot(mutil,10*log(Jnmean))
plot(mutil,10*log(EMSELMS))
plot (mutil,10*log(EMSENLMS))
grid;title('EMSE');legend('LMS-Simulado','NLMS-Simulado', 'LMS-Teorico','NLMS-Teorico')

figure(2)
plot(mutil,10*log10(Jnmean))
hold on
%plot(mutil,10*log(EMSELMS))
plot (mutil,10*log10(EMSENLMS))
grid;title('EMSE');legend('NLMS-Simulado','NLMS-Teorico')