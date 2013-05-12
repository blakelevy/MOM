function [ Z ] = intP( jj, ii, N, dl, rc, tc, rp, k )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
q = 3;
j = mom_cycle(jj, N);
i = mom_cycle(ii, N);
[x, w] = qrule(q);
[xl, wl] = lrule(q);
Zself = 1/2*besselh(0,2,k*xl*dl/2)*wl';
if i ~= j
rji = arrayfun(@(x)sqrt((rc(j) - rp(i,x))'*(rc(j) - rp(i,x))),x);
Z = besselh(0,2,k*rji)*w';
else
Z = 2*Zself;
end
end
