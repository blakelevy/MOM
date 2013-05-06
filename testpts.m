function [ P ] = testpts( x, y, S, q)
%testpts Creates quadrature points on elements
%   Detailed explanation goes here
P = zeros(2,q);
[t, ~] = qrule(q);
P(1,:) = x+t*S(1);
P(2,:) = y+t*S(2);
end

