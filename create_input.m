function [ V, m ] = create_input(X, Y, k, theta, Ezo)
%create_input Summary of this function goes here
%   Detailed explanation goes here
m = [((X(2:end)- X(1:end-1))./2)+X(1:end-1);((Y(2:end)-Y(1:end-1))./2)+Y(1:end-1)];
V = Ezo*exp(-1j*(k*cos(theta)*m(1,1:end)+k*sin(theta)*m(2,1:end)));
end

