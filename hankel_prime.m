function [ J ] = hankel_prime( n,x)
%UNTITLED2 Calculation for the analytical solution
%   new function Hankel Prime to deal with the derivative of hankel
first = besselj(n-1,x) - (n/x)*besselj(n,x);
second = bessely(n-1,x)-(n/x)*bessely(n,x);
J = first - 1j*second;

end

