%% graph geometry
% graphs geometry used for MOM calculations
clc;clear;
constants
M = 160;
r = 1;
q = 5;
[x y theta S slope L ] = mesh_circle(M,r);
P = zeros(2,q*length(x)-q);
for i = 1:length(x)-1
    P(:,[q*i-(q-1):q*i]) = testpts( x(i), y(i), S(:,i), q);
end
plot(x,y,'r',P(1,:),P(2,:),'ko')