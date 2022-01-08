close all
clear all
clc

Nu = 2;
K = 2; % número de antenas
Kt = 4; % diversidade temporal
N = 5000;
M = K*Kt;


a = 2*randi ([0 1], N, 1)-1;
% a2 = 2*randi ([0 1], n, 1)-1;

H = [0.43 0.46 -0.30; 0.21 -0.26 -0.16];


for j=1:K
v(:,j) = 0.001*randn(size(a,1),1);
end

% u1=filter(H1,[1],a)+v1;
% u2=filter(H2,[1],a)+v2;

for j=1:K
u(:,j)=filter(H(j,:),[1],a)+v(:,j);
end
mu =0.1;

%LMS
uM = zeros(M,1);
y = zeros(N,1);
e = zeros(N,1);
W = zeros(N+1,M);


for n=1:N
    
    for i=1:K
        uM = [u(n,i);uM(1:i*Kt-1)]
%         uM=[u1(n);uM(1:Kt-1); u2(n);uM(Kt+1:2*Kt-1)];
    
    end
    
y(n)=W(n,:)*uM;
    
    if n-3 <= 0
        d(n) = a(n);
    else
        d(n) = a(n-3);
    end
    
e(n)= d(n)-y(n);
    
W(n+1,:) = W(n,:)+mu*e(n)*uM';
end

plot (10*log10(e.^2))
% hold on
% plot (10*log10(mean(e))*ones(size(e)),'k--')