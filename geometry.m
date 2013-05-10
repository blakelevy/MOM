%% graph geometry
% graphs geometry used for MOM calculations
clc;clear;
constants
M = 4;
r = 1;
q = 1;
[x y theta S slope L ] = mesh_circle(M,r);
P = zeros(2,q*length(x)-q);
for i = 1:length(x)-1
    P(:,[q*i-(q-1):q*i]) = testpts( x(i), y(i), S(:,i), q);
end
angle = zeros(1,length(S));
for i = 1:length(S)
     if S(1,i)*S(2,i) >= 0 
        angle(i) = atan2(S(2,i),S(1,i));
     else
         angle(i) = atan2(S(2,i),S(1,i));
     end
 end
plot(x,y,'r',P(1,:),P(2,:),'ko')
title(strcat(int2str(M),' Elements with ', int2str(q),' Quadrature Points'));