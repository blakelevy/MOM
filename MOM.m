%% Project #3 MOM
% Authors: Dayo Lawal and Blake Levy
clc;clear;
Q = [5]; % q-point Quadrature
for G = 1:length(Q)
    q = Q(G);
    constants
    M = 160; % Number of elements
    N = M+1; % Number of nodes
    r = 10*lamb0; % radius of circle
    [x y theta S slope L] = mesh_circle(M,r);
    % [P] = testpts(x(5),y(5),S(:,5),q);
    %% Z, V and I
    theta1 = 0*pi/180;
    Hzo = 1;
    V = zeros(M,1);
%     [V, m] = create_input(x,y,k0, theta1, Ez0);
    % plot(x,y,'r',P(1),P(2),'+k',m(1,:),m(2,:),'ko')
    Z = -1/2*eye(M,M);
    R = zeros(2,length(x));
    R(1,:) = x;
    R(2,:) = y;
    for i = 1:M
        for j = 1:M
            if (i ~= j)
                Z(i,j) = (k0/4/1j)*create_Z(k0, S(:,i)/L(i), R(:,i), R(:,j),S(:,i),S(:,j),q);
            end  
        end
        V(i) = create_input(k0,theta1,Hzo,R(:,i),S(:,i),q);
    end

    I = zeros(M,1);
    I = Z\V;
    hold on
    if q == 10
    plot(abs(I./V),'k')
    else
       plot(abs(I./V))
    end
end





