close all
clear all
clc

Nu = 2;
K = 2; % número de antenas
Kt = 4; % diversidade temporal
N = 5000;
M = K*Kt;


a1 = 2*randi ([0 1], N, 1)-1;
a2 = 2*randi ([0 1], N, 1)-1;

H11 = [0.43 0.46 -0.30];
H21 = [0.21 -0.26 -0.16];
H12 = [-0.37 -0.87 0.15];
H22 = [0.55 -0.61 -0.09];



v1 = 0.001*randn(N,1);
v2 = 0.001*randn(N,1);

u1=filter(H11,[1],a1)+filter(H21,[1],a2)+v1;
u2=filter(H12,[1],a2)+filter(H22,[1],a2)+v2;

mu =0.1;


%LMS
uM = zeros(M,1);
y = zeros(N,1);
e = zeros(N,1);
W1 = zeros(N+1,M);


for n=1:N

uM=[u1(n);uM(1:Kt-1); u2(n);uM(Kt+1:2*Kt-1)];
    
y(n)=W1(n,:)*uM;
    
    if n-3 <= 0
        d(n) = a2(n);
    else
        d(n) = a2(n-3);
    end
    
    e(n)= d(n)-y(n);
    
W1(n+1,:) = W1(n,:)+mu*e(n)*uM';
end


plot (10*log10(e.^2))
% hold on
% plot (10*log10(mean(e))*ones(size(e)),'k--')