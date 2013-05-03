constants
M = 8;
r = lamb0;
[X Y theta1 T slope L] = mesh_circle(M,r);
theta = 0*pi/180;
Ez0 = 1;
[V,m] = create_input(X,Y,k0, theta, Ez0);
plot(X, Y, m(1,:), m(2,:));
figure
plot(theta1*180/pi);
figure
plot(theta1(1:end-1)*180/pi,angle(V)*180/pi);