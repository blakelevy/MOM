function [x y theta S slope L ] = mesh_circle(M,r)
%UNTITLED2 returns x and y vectors that plot a cirlce
%   x = r*cos(theta)
%   y = r*sin(theta)
% returns x,y,theta,T-vector,slope of each element,Length of each element
theta = 0:2*pi/M:2*pi; % discretization in theta direction
x = r*cos(theta); % x-distance
x(end) = x(1);
y = r*sin(theta); % y-distance
y(end) = y(1);
L = sqrt((x(2:end)-x(1:end-1)).^2 + (y(2:end)-y(1:end-1)).^2);
slope = (y(2:end)-y(1:end-1))./(x(2:end)-x(1:end-1));
S = zeros(2,M);
S(1,:) = x(2:end)-x(1:end-1);
S(2,:) = y(2:end)-y(1:end-1);
end

