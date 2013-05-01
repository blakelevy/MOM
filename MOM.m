%% Project #3 MOM
% Authors: Dayo Lawal and Blake Levy
clc;clear;
constants
M = 8; % Number of elements
r = 1; % radius of circle
[x y theta T slope L] = mesh_circle(M,r);
plot(x,y)