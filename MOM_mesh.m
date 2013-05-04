%% Meshing File for right PEC cylinder
clc;clear;
addpath distmesh
%% import constants.m
constants
%% create mesh
diameter = 10*lamb0;
fd = inline('ddiff(dcircle(p,0,0,1),dcircle(p,0,0,.4))','p');
% fd = @(p) ddiff(drectangle(p,-1,1,-1,1),dcircle(p,0,0,1/2));
fh = inline('min(5*sqrt(sum(p.^2,2))-1,2)','p');
% fh = @(p) .05+.3*dcircle(p,0,0,1/2);
[p t] = distmesh2d(fd,fh,0.05,[-1,-1;1,1],[-1,-1;-1,1;1,-1;1,1]);