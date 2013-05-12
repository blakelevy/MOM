%% Project #3 MOM
% Authors: Dayo Lawal and Blake Levy
clc;clear;clf;
tic
constants
qs = 1;
tol = 1e-11; % Tolerance for GMRES
M = 149; % Number of elements
N = M+1; % Number of nodes
ka = 8;
r = ka/k0;
Qo = [1]; % q-point Quadrature
%%
for G = 1:length(Qo)
    qo = Qo(G);

    r = ka*lamb0/2/pi; % radius of circle
    [x y phi S slope L] = mesh_circle(M,r);
    % [P] = testpts(x(5),y(5),S(:,5),q);
    %% Z, V and I
    theta = 0*pi/180;
    Hzo = sqrt(eps0/mu0);
    V = zeros(M,1);
%     [V, m] = create_input(x,y,k0, theta1, Ez0);
    % plot(x,y,'r',P(1),P(2),'+k',m(1,:),m(2,:),'ko')
    Z = -1/2*eye(M,M);
    R = zeros(2,length(x));
    R(1,:) = x;
    R(2,:) = y;
    for i = 1:M
        for j = 1:M
            if (i ~= j) && abs(i - j) < 3
                flag = false;
                Z(i,j) = (k0/4/1j)*create_Z_notes(k0, S(:,i)/L(i), R(:,i), R(:,j),S(:,i),S(:,j),qs,qo,flag);
            elseif (i~=j)
                flag = false;
                Z(i,j) = (k0/4/1j)*create_Z_notes(k0, S(:,i)/L(i), R(:,i), R(:,j),S(:,i),S(:,j),qs,qo,flag);
            end
        end
        V(i) = create_input(k0,theta,Hzo,R(:,i),S(:,i),qs);
    end

%     I = zeros(M,1);
%     I = Z\V;
    I = gmres(Z,V,M,tol,M);
    if Qo == 5
%     plot(abs(I),'k')
    else
%        plot(abs(I))
    end
end
%% Post Processing
s = k0/4*ones(1,length(I));
for p = 1:length(I)
    angle = phi(p);
    sum = 0;
    for h = 1:M
        omega = atan2(S(2,h)/L(h),S(1,h)/L(h));
        sum = sum + I(h)*L(h)*sin(omega - angle)*exp(1j*k0*(R(1,h)*cos(angle)+R(2,h)*sin(angle)));      
    end
    s(p) = s(p)*abs(sum)^2;  
end
[current, scatter] = analytical_MFIE(M,k0,r);
% I(2:end) = .5*(I(1:end-1)+I(2:end));
% clf;
% I(1) = (I(1)+I(end))/2;
subplot(2,2,1)
plot(1:1:M,abs(current),'r--',1:1:M,abs(I),'k')
subplot(2,2,2)
error = 100*abs(((current')-(I))./(current'));
plot(1:1:M,error)
subplot(2,2,3)
plot(1:1:M,10*log10(abs(scatter)),'k--')
subplot(2,2,4)
plot(1:1:M,10*log10(s))
toc
display(toc)
hold off





