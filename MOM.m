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
Z = -1/2*eye(M,M);
V = zeros(M,1);
I = zeros(M,1);
