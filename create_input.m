function [ V ] = create_input(k,theta,Hzo,R,S,Q)
%create_input Summary of this function goes here
%   Detailed explanation goes here
K = [k*cos(theta) k*sin(theta)];
[~,w] = qrule(Q);
r = testpts(R(1),R(2),S,Q);
% r = zeros(2,Q);
% r(1,:) = R(1)+t*S(1);
% r(2,:) = R(2)+t*S(2);
r = K*r;
% m = [((X(2:end)- X(1:end-1))./2)+X(1:end-1);((Y(2:end)-Y(1:end-1))./2)+Y(1:end-1)];
V = sum(w.*Hzo.*exp(-1j*r));
end

