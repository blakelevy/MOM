function [ Z ] = intAm( jj, ii, N, dl, rc, tc, rp, rhp, k, Q)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
j = mom_cycle(jj, N);
i = mom_cycle(ii, N);
im1 = mom_cycle(ii-1, N);
jm1 = mom_cycle(jj-1, N);
[x, w] = qrule(Q);
[xl, wl] = lrule(3);
Zself = 1/2*besselh(0,2,k*xl*dl/2)*wl';
if i ~= j
rjim = arrayfun(@(x)sqrt((rp(j,0) - rhp(im1,x))'*(rp(j,0) - rhp(im1,x))),x);
Z = (rc(j)-rc(jm1))'*tc(im1)*1/2*besselh(0,2,k*rjim)*w';
else
Z = (rc(j)-rc(jm1))'*tc(im1)*Zself;
end
end

