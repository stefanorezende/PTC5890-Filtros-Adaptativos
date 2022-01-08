function [y,e,W] = MU_LMS (u,d,M,mu,N)
uM = zeros(M,1)
y = zeros(N,1)
e = zeros(N,1)
W = zeros(N+1,M)

for n=1:N
    uM=[u1(n);uM(1:Kt-1); u2(n);uM(Kt+1:2*Kt-1)];
    
y(n)=W(n,:)*uM;
    
    if n-3 <= 0
        d(n) = a2(n);
    else
        d(n) = a2(n-3);
    end
    
e(n)= d(n)-y(n);
    
W(n+1,:) = W(n,:)+mu*e(n)*uM';
end
end