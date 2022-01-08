%PTC 5890 - 2019
%Prof: Magno T. M. Silva e Maria D. Miranda
%Aluno: Stéfano Albino Vilela Rezende (Ouvinte)
%P5 - Parte Computacional
%Exercício 2

close all
clear all
clc

Nu = 2;
K = 3; % número de antenas
Kt = 4; % diversidade temporal
N = 10^5;
M = K*Kt;
DELTA = 3;
% mu =0.0082;
lambda = 0.9;
delta=10^5;


e1_L_mean = zeros(N,1);
e2_L_mean = zeros(N,1);
e1_R_mean = zeros(N,1);
e2_R_mean = zeros(N,1);

for i=1:1
    
a1 = randi ([0 1], N, 1);
a2 = randi ([0 1], N, 1);


HN_2 = [0.43 0.46 -0.30; 0.21 -0.26 0.16; -0.37 -0.87 0.15; 0.55 -0.61 -0.09; 0.61 0.12 -0.24; 0.43 -0.52 0.31];
HN = [-0.03 0.05 -0.82; 0.78 0.36 1.21; 1.18 -0.19 -0.17; -1.77 -0.27 -0.26; -1.09 1.65 -0.68; 1.99 -0.37 -0.98];


u1=[filter(HN_2(1,:),[1],a1(1:N/2)); filter(HN(1,:),[1],a1(N/2+1:N))]+ [filter(HN_2(2,:),[1],a2(1:N/2)); filter(HN(2,:),[1],a2(N/2+1:N))];
u2=[filter(HN_2(3,:),[1],a1(1:N/2)); filter(HN(3,:),[1],a1(N/2+1:N))]+ [filter(HN_2(4,:),[1],a2(1:N/2)); filter(HN(4,:),[1],a2(N/2+1:N))];
u3=[filter(HN_2(5,:),[1],a1(1:N/2)); filter(HN(5,:),[1],a1(N/2+1:N))]+ [filter(HN_2(6,:),[1],a2(1:N/2)); filter(HN(6,:),[1],a2(N/2+1:N))];

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
dQ1 = zeros(M,1);
R = delta^(1/2)*eye(M,M);
Q_theta = eye(M+1,M+1);
c=zeros(M,1);

for n=1:N

uM=[u1(n);uM(1:Kt-1); u2(n);uM(Kt+1:2*Kt-1);u3(n);uM(2*Kt+1:3*Kt-1)];

y(n)=W(n,:)*uM; 

 if n-DELTA <= 0
        d(n) = 0;
   else
       d(n) = a1(n-DELTA);
 end
 e(n) = d(n)-y(n);
 
if isnan(e(n))==1
    div=[1;n]; %guarda a iteração onde houve divergência
    e(n:N) = NaN; %coloca NaN nas amostras do erro a partir do instante de divergência
    break
end
        R = [(lambda.^1/2)*R; uM'];
        for i = 1:M     
            [G,~] = planerot([R(i,i);R(end,i)]);%[R(end,i);R(end,end)]);            
            Q_theta_i = eye(M+1,M+1);
            Q_theta_i(i,i) = G(1,1);
            Q_theta_i(i,end) = G(1,2);
            Q_theta_i(end,i) = G(2,1);
            Q_theta_i(end,end) = G(2,2);
            R = Q_theta_i*R;
            Q_theta = Q_theta_i*Q_theta;
        end
        R = R(1:end-1,:);     
        aux = Q_theta*[(lambda.^1/2)*dQ1; d(n)];
        dQ1 = aux(1:end-1,:);
        W(n+1,:) = linsolve(R,dQ1)';
end

end
