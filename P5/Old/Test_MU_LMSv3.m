close all
clear all
clc

Nu = 2;
K = 3; % número de antenas
Kt = 4; % diversidade temporal
N = 5000;
M = K*Kt;
DELTA = 3;
mu =0.1;

a1 = 2*randi ([0 1], N, 1)-1;
a2 = 2*randi ([0 1], N, 1)-1;

H11 = [0.43 0.46 -0.30];
H21 = [0.21 -0.26 -0.16];
H12 = [-0.37 -0.87 0.15];
H22 = [0.55 -0.61 -0.09];
H13 = [0.61 0.12 -0.24];
H23 = [0.43 -0.52 0.31];

v1 = 0.001*randn(N,1);
v2 = 0.001*randn(N,1);
v3 = 0.001*randn(N,1);

u1=filter(H11,[1],a1)+filter(H21,[1],a2)+v1;
u2=filter(H12,[1],a1)+filter(H22,[1],a2)+v2;
u3=filter(H13,[1],a1)+filter(H23,[1],a2)+v3;


[y1,e1,W1] = MU_LMS (u1,u2,u3,a1,M,Kt,mu,N,DELTA);
[y2,e2,W2] = MU_LMS (u1,u2,u3,a2,M,Kt,mu,N,DELTA);

figure(1)
subplot 211
plot(W1)
subplot 212
plot(W2)

figure(2)
plot (10*log10(e1.^2))
hold on
plot (10*log10(e2.^2))