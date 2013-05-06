function [ X, Y ] = testpts( x, y, S, q)
%testpts Creates quadrature points on elements
%   Detailed explanation goes here
[t, ~] = qrule(q);
X = x+t*S(1);
Y = y+t*S(2);
end

