%PTC 5890 - 2019
%Prof: Magno T. M. Silva e Maria D. Miranda
%Aluno: Stéfano Albino Vilela Rezende (Ouvinte)
%P5 - Parte Computacional
%Exercício 3

function [y,e,W] = MU_QR_RLS (u1,u2,u3,a,M,Kt,delta,N,lambda,DELTA)
uM = zeros(M,1);
y = zeros(N,1);
e = zeros(N,1);
W = zeros(N+1,M);
dQ1 = zeros(M,1);
R = delta^(1/2)*eye(M,M);
Q_theta = eye(M+1,M+1);

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


