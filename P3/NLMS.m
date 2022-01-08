function [y,e,W] = NLMS (u,d,M,mu,N,delta)
uM = zeros(M,1)
y = zeros(N,1)
e = zeros(N,1)
W = zeros(N+1,M)

for n=1:N
    uM=[u(n);uM(1:M-1)];
    y(n)=W(n,:)*uM;
    e(n)= d(n)-y(n);
    
    W(n+1,:) = W(n,:)+mu/(norm(uM)^2+delta)*e(n)*uM';
end
end