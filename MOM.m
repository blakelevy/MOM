%% Project #3 MOM
% Authors: Dayo Lawal and Blake Levy
clc;clear;
Q = [1 2 5 10]; % q-point Quadrature
for G = 1:length(Q)
    q = Q(G);
    constants
    M = 8; % Number of elements
    N = M+1; % Number of nodes
    r = 1; % radius of circle

    [x y theta T slope L] = mesh_circle(M,r);
    S = zeros(2,M);
    S(1,:) = x(2:end)-x(1:end-1);
    S(2,:) = y(2:end)-y(1:end-1);
    % [P] = testpts(x(5),y(5),S(:,5),q);

    %% Z, V and I
    theta1 = 0*pi/180;
    Ez0 = 1;
    [V, m] = create_input(x,y,k0, theta1, Ez0);
    % plot(x,y,'r',P(1),P(2),'+k',m(1,:),m(2,:),'ko')
    Z = -1/2*eye(M,M);
    R = zeros(2,length(x));
    R(1,:) = x;
    R(2,:) = y;
    for i = 1:M
        for j = 1:M
            if (i ~= j)
                Z(i,j) = (k0/4*1j)*create_Z(k0, T(i), R(:,i), R(:,j),S(:,i),S(:,j),q);
            end
        end
    end

    I = zeros(M,1);
    I = Z\V';
    hold on
    if q == 10
    plot(abs(I),'k')
    else
       plot(abs(I))
    end
end





