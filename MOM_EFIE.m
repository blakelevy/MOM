%% Project #3 MOM
% Authors: Dayo Lawal and Blake Levy
clc;clear;clf;
tic
Qo = [1]; % q-point Quadrature
for G = 1:length(Qo)
    qo = Qo(G);
    qs = 1;
    constants
    tol = 1e-11; % Tolerance for GMRES
    M = 160; % Number of elements
    N = M+1; % Number of nodes
    r = 4*lamb0/2/pi; % radius of circle
    close = 3;
    [x y theta S slope L] = mesh_circle(M,r);
    % [P] = testpts(x(5),y(5),S(:,5),q);
    %% Z, V and I
    phi = 0*pi/180;
    Ezo = 1;
    V = zeros(M,1);
%     [V, m] = create_input(x,y,k0, theta1, Ez0);
    % plot(x,y,'r',P(1),P(2),'+k',m(1,:),m(2,:),'ko')
    Z = zeros(M,M);
%     Z = w*mu0/4*(L(1)-(1j*2*L(1)/pi)*(log(exp(.5772156)*k0*L(1)/4) - 1))*eye(M,M);
    R = zeros(2,length(x));
    R(1,:) = x;
    R(2,:) = y;
    for i = 1:M
        temp = i-1;
        for j = 1:M   
            if (j == 1 && i ~=1)
                r_s = [R(:,i) R(:,i-1) R(:,i+1)];
                r_o = [R(:,j) R(:,end-1) R(:,j+1)];
            elseif (i == 1 && j~=1)
                r_s = [R(:,i) R(:,end-1) R(:,i+1)];
                r_o = [R(:,j) R(:,j-1) R(:,j+1)];
            elseif (i == 1 && j==1)
                r_s = [R(:,i) R(:,end-1) R(:,i+1)];
                r_o = [R(:,j) R(:,end-1) R(:,j+1)];
            elseif (i ~= M && j==M)
                r_s = [R(:,i) R(:,end-1) R(:,i+1)];
                r_o = [R(:,j) R(:,j-1) R(:,1)];
            elseif (i == M && j~=M)
                r_s = [R(:,i) R(:,i-1) R(:,1)];
                r_o = [R(:,j) R(:,j-1) R(:,j+1)];               
            else
                r_s = [R(:,i) R(:,i-1) R(:,i+1)];
                r_o = [R(:,j) R(:,j-1) R(:,j+1)]; 
            end
%             if (i ~= j) && abs(i - j) < 3
            if abs(i - j) < close || abs(i-j)> M-close
                Z(i,j) = create_Z_notes_EFIE_s(k0,eta0,...
                    S(:,j)/L(j),r_s,r_o);
%             elseif (i~=j)
            else
                Z(i,j) = create_Z_notes_EFIE(k0,eta0,...
                    S(:,j)/L(j),r_s,r_o);
            end
        end
        if i == 1
            r_s = [R(:,i) R(:,end-1) R(:,i+1)];
%             r_s = [R(:,temp) R(:,end)];
            V(i) = create_input_EFIE(k0,phi,Ezo,r_s);
        elseif i == M
            r_s = [R(:,i) R(:,i-1) R(:,1)];
            V(i) = create_input_EFIE(k0,phi,Ezo,r_s);
        else
            r_s = [R(:,i) R(:,i-1) R(:,i+1)];
            V(i) = create_input_EFIE(k0,phi,Ezo,r_s);
        end
    end

%     I = zeros(M,1);
%     I = Z\V;
    I = gmres(Z,V,M,tol,M);
    hold on
    if Qo == 5
    plot(abs(I),'k')
    else
       plot(abs(I))
    end
end
toc
display(toc)
hold off





