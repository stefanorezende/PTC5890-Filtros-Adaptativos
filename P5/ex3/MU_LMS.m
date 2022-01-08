%PTC 5890 - 2019
%Prof: Magno T. M. Silva e Maria D. Miranda
%Aluno: Stéfano Albino Vilela Rezende (Ouvinte)
%P5 - Parte Computacional
%Exercício 3

function [y,e,W] = MU_LMS (u1,u2,u3,a,M,Kt,mu,N,DELTA)
uM = zeros(M,1);
y = zeros(N,1);
e = zeros(N,1);
W = zeros(N+1,M);

for n=1:N
uM=[u1(n);uM(1:Kt-1); u2(n);uM(Kt+1:2*Kt-1);u3(n);uM(2*Kt+1:3*Kt-1)];

y(n)=W(n,:)*uM;
    
   if n-DELTA <= 0
        d(n) = 0;
   else
       d(n) = a(n-DELTA);
   end
    
e(n) = d(n)-y(n);
if isnan(e(n))==1
    div=[1;n]; %guarda a iteração onde houve divergência
    e(n:N) = NaN; %coloca NaN nas amostras do erro a partir do instante de divergência
    break
end

W(n+1,:) = W(n,:)+mu*e(n)*uM';

end
end