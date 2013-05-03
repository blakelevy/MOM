function [ b ] = create_Z( k, Ts, rs, ro)
%create_Z Summary of this function goes here
%   Detailed explanation goes here
% Midpoint rule (1-point Quadrature)
% find the distance between source and observer
P = (ro-rs);
Pmag = sqrt(P'*P);
Punit = zeros(1,3);
Punit(1:2) = P/Pmag;
Punit(3) = 0;
T = zeros(1,3);
T(1:2) = Ts;
T(3) = 0;
b = besselh(1,2,k*Pmag)*cross(T,Punit);
end

