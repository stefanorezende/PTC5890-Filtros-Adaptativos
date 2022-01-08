%PTC 5890 - 2019
%Prof: Magno T. M. Silva e Maria D. Miranda
%Aluno: Stéfano Albino Vilela Rezende (Ouvinte)
%P5 - Parte Computacional
%Exercício 3

function [y,e,W] = MU_RLS (u1,u2,u3,a,M,Kt,delta,N,lambda,DELTA)
uM = zeros(M,1);
y = zeros(N,1);
e = zeros(N,1);
W = zeros(N+1,M);
R = delta^-1*eye(M,M);

for n=1:N
    

uM=[u1(n);uM(1:Kt-1); u2(n);uM(Kt+1:2*Kt-1);u3(n);uM(2*Kt+1:3*Kt-1)];
   % if n+Kt-1<N
      
    %uM=[u1(n:n+Kt-1);u2(n:n+Kt-1);u2(n:n+Kt-1)];
    %end
% ea(n)=(wo-W(n,:))*uM;
k_til=R*uM;
gama=1/(lambda+uM'*R*uM);
k = gama*k_til;

%R = lambda^-1*R-lambda^-1*k*k_til' %VERSÃO 1
R=lambda^-1*R-(k_til*k_til')*lambda^-1*gama; %VERSÃO 2

 if n-DELTA <= 0
        d(n) = a(n);
   else
       d(n) = a(n-DELTA);
    end
   y(n)=W(n,:)*uM; 
e(n) = d(n)-y(n);
W(n+1,:) = W(n,:)+k'*e(n);

if isnan(e(n))==1
    div=[1;n]; %guarda a iteração onde houve divergência
    e(n:N) = NaN; %coloca NaN nas amostras do erro a partir do instante de divergência
    break
end

end
end