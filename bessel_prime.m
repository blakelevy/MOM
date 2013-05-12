function [ B ] = bessel_prime(n,x)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
B = besselj(n-1,x) - (n/x)*besselj(n,x);

end

