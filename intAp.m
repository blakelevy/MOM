function [ Z ] = intAp( jj, ii, N, dl, rc, tc, rp, rphm, k, Q )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
j = mom_cycle(jj, N);
i = mom_cycle(ii, N);
jm1 = mom_cycle(jj-1, N);
[x, w] = qrule(Q);
[xl, wl] = lrule(Q);
Zself = 1/2*besselh(0,2,k*xl*dl/2)*wl';
if i ~= j
rji = arrayfun(@(x)sqrt((rp(j,0) - rphm(i,x))'*(rp(j,0) - rphm(i,x))),x);
Z = (rc(j)-rc(jm1))'*tc(i)*1/2*besselh(0,2,k*rji)*w';
else
Z = (rc(j)-rc(jm1))'*tc(i)*Zself;
end
end

