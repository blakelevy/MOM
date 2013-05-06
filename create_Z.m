function [ b ] = create_Z( k, Ts, rs, ro, Q)
%create_Z Summary of this function goes here
%   Detailed explanation goes here
% k propagation constant
% Ts tagential vector of the source
% rs source coordinate
% ro observer coordinate
% Q points for quadrature rule
% Q point Quadrature rule (eg: 1-point Quadrature)
% find the distance between source and observer
P = (ro-rs);
Pmag = sqrt(P'*P);
Punit = zeros(1,3);
Punit(1:2) = P/Pmag;
T = zeros(1,3);
T(1:2) = Ts;
T(3) = 0;
[X, W] = qrule(Q);
b = besselh(1,2,k*Pmag)*cross(T,Punit);

end

