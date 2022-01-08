close all
clear all
clc

Nu = 2;
K = 3; % número de antenas
Kt = 4; % diversidade temporal
N = 10^5;
M = K*Kt;
DELTA = 3;
mu =0.0082;
lambda = 0.99;
delta=10^5;

% a1 = 2*randi ([0 1], N, 1)-1;
% a2 = 2*randi ([0 1], N, 1)-1;

a1 = round(rand(N,1));
a2 = round(rand(N,1));

HN_2 = [0.43 0.46 -0.30; 0.21 -0.26 0.16; -0.37 -0.87 0.15; 0.55 -0.61 -0.09; 0.61 0.12 -0.24; 0.43 -0.52 0.31];
HN = [-0.03 0.05 -0.82; 0.78 0.36 1.21; 1.18 -0.19 -0.17; -1.77 -0.27 -0.26; -1.09 1.65 -0.68; 1.99 -0.37 -0.98];


u1=filter(fliplr(HN_2(1,:)),1,a1,[],2)+filter(HN_2(2,:),[1],a2(1:N),[],2); %filter(HN(1,:),[1],a1(N/2+1:N))]+ [filter(HN_2(2,:),[1],a2(1:N/2)); filter(HN(2,:),[1],a2(N/2+1:N))];
u2=filter(fliplr(HN_2(3,:)),1,a1,[],2)+filter(HN_2(2,:),[1],a2(1:N),[],2); %filter(HN(3,:),[1],a1(N/2+1:N))]+ [filter(HN_2(4,:),[1],a2(1:N/2)); filter(HN(4,:),[1],a2(N/2+1:N))];
u3=filter(fliplr(HN_2(5,:)),1,a1,[],2)+filter(HN_2(2,:),[1],a2(1:N),[],2); %filter(HN(5,:),[1],a1(N/2+1:N))]+ [filter(HN_2(6,:),[1],a2(1:N/2)); filter(HN(6,:),[1],a2(N/2+1:N))];

var_v1_2=(10^-2.5)*var(u1);
var_v2_2=(10^-2.5)*var(u2);
var_v3_2=(10^-2.5)*var(u3);

v1 = 0.01*sqrt(var_v1_2)*randn(N,1);
v2 = 0.01*sqrt(var_v2_2)*randn(N,1);
v3 = 0.01*sqrt(var_v3_2)*randn(N,1);

u1=u1+v1;
u2=u2+v2;
u3=u3+v3;


uM = zeros(M,1);
y = zeros(N,1);
e = zeros(N,1);
W = zeros(N+1,M);

for n=1:N
uM=[u1(n);uM(1:Kt-1); u2(n);uM(Kt+1:2*Kt-1);u3(n);uM(2*Kt+1:3*Kt-1)];
   % if n+Kt-1<N
      
   % uM=[u1(n:n+Kt-1);u2(n:n+Kt-1);u2(n:n+Kt-1)];
   % end
y(n)=W(n,:)*uM;
    
   if n-DELTA <= 0
        d(n) = a1(n);
   else
       d(n) = a1(n-DELTA);
   end
    
e(n) = d(n)-y(n);
    
W(n+1,:) = W(n,:)+mu*e(n)*uM';
end



figure(1)

plot(W)

title('Coeficientes LMS')

figure(2)
plot (10*log10(abs(e.^2)))

