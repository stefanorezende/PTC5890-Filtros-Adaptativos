function [R,p,Wo] = Wiener(u,d,M)

r=xcorr (u,M-1,'biased')
ru=r(M:end);
R=toeplitz(ru)

rdu=xcorr(d,u,M-1,'biased')
p=rdu(M:end)

Wo=R\p