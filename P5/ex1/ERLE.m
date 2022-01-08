function [r] = ERLE (d,e,L)

N=length(d);
r=zeros(1,N/L);

for i=1:N/L
ell=L*(i-1)+1:L*i;
r(i)=10*log10(mean(d(ell).^2)/mean((e(ell)+eps).^2));
end