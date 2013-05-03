%% Project #3 MOM
% Authors: Dayo Lawal and Blake Levy
clc;clear;
constants
M = 8; % Number of elements
N = M+1; % Number of nodes
r = 1; % radius of circle
[x y theta T slope L] = mesh_circle(M,r);
plot(x,y)
%% Z, V and I
theta1 = 0*pi/180;
Ez0 = 1;
[V, m] = create_input(x,y,k0, theta1, Ez0);
Z = -1/2*eye(M,M);
I = zeros(M,1);
