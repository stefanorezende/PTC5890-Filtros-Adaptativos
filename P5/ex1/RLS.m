function [y,e,W] = RLS (u,d,M,N,delta,lambda)
uM = zeros(M,1);
y = zeros(N,1);
e = zeros(N,1);
W = zeros(N+1,M);
R = delta^-1*eye(M,M);

for n=1:N
    
uM=[u(n);uM(1:M-1)];
%ea(n)=(wo-W(n,:))*uM;
k_til=R*uM;
gama=1/(lambda+uM'*R*uM);
k = gama*k_til;

%R = lambda^-1*R-lambda^-1*k*k_til' %VERSÃO 1
R=lambda^-1*R-(k_til*k_til')*lambda^-1*gama; %VERSÃO 2

y(n)=uM'*W(n,:)';

e(n) = d(n)-y(n);
W(n+1,:) = W(n,:)+k'*e(n);
end
end