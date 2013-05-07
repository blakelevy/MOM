function [ V ] = create_input(k,theta,Hzo,R)
%create_input Summary of this function goes here
%   Detailed explanation goes here
K = [k*cos(theta) k*sin(theta)];
r = K*R;
% m = [((X(2:end)- X(1:end-1))./2)+X(1:end-1);((Y(2:end)-Y(1:end-1))./2)+Y(1:end-1)];
V = Hzo*exp(-1j*r);
end

