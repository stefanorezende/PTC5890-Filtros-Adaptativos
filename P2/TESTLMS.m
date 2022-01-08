clear

n = [1:500]
phiv = 2*pi*rand(1,1)
phiu = 2*pi*rand(1,1)

M=2

%ruído
s = 0.01*randn(1,size(n,2))

%Interferência indesejada
x = sin(2*pi.*n./10+pi/6+phiv)

%sinal correlacionado à interferência

u = 5*sin(2*pi.*n./10+phiu)

d = s+x

mu = 0.03
N = 10


uM = zeros(M,1)
y = zeros(N,1)
e = zeros(N,1)
W = zeros(N+1,M)

for i=1:N
    uM=[u(i);uM(1:M-1)];
    y(i)=W(i,:)*uM;
    e(i)= d(i)-y(i);
    
    W(i+1,:) = W(i,:)+mu*e(i)*uM';
end
