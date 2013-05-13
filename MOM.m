%% Project #3 MOM
% Authors: Dayo Lawal and Blake Levy
clc;clear;clf;
tic
constants
qs = 1;
tol = 1e-11; % Tolerance for GMRES
M = 200; % Number of elements
M_max = 400;
if M > M_max
   ds = M/M_max; 
elseif M_max > M
   ds = M_max/M;
else
end
N = M+1; % Number of nodes
ka = 21*pi;
r = ka/k0;
Qo = [1]; % q-point Quadrature
I = zeros(M,3);
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


%     I = Z\V;
    I = gmres(Z,V,M,tol,M);
end
%     plot(1:1:M,abs(I(:,1)),'r',1:1:M,abs(I(:,2)),'b',1:1:M,abs(I(:,3)),'k')
%% Post Processing
s = eta0^2*k0/4*ones(1,length(I));
% Scattering OF PEC from Surface Current
for p = 1:length(I)
    angle = phi(p);
    sum = 0;
    for h = 1:M
        omega = atan2(S(2,h)/L(h),S(1,h)/L(h));
        sum = sum + I(h)*L(h)*sin(omega - angle)*exp(1j*k0*(R(1,h)*cos(angle)+R(2,h)*sin(angle)));      
    end
    s(p) = s(p)*abs(sum)^2;  
end
% Get analytical Solution
if M > M_max
    degree = 0:360/M_max:360;
    degree = degree(1:end-1);
elseif M_max > M
    degree = 0:360/M:360;
    degree = degree(1:end-1);
else
end
[current, scatter] = analytical_MFIE(M_max,k0,r);
% I(2:end) = .5*(I(1:end-1)+I(2:end));
% clf;
% I(1) = (I(1)+I(end))/2;
if M>M_max
   I = downsample(I,ds); 
elseif M_max > M
   current = downsample(current,ds); 
   scatter = downsample(current,ds);
else
end
subplot(2,2,1)
plot(degree,abs(current),'r--',degree,abs(I(:,1)),'k')
legend('Analytical','MOM'); title(strcat('Surface Current ka = ',num2str(ka)))
subplot(2,2,2)
% error = 100*abs(((current')-(I(:,1)))./(current'));
% error = norm((current-I(:,1)'),2)/norm(current,2);
E = abs(abs(current)-abs(I(:,1)'))./abs(current);
clear sum
title('error')
plot(degree,E)
E = sum(E)/length(E)
subplot(2,2,3)
plot(degree,10*log10(abs(scatter)),'k--')
title('Analytic Scattered Field')
subplot(2,2,4)
plot(degree,10*log10(s))
title('MOM Scattered Field')
toc
display(toc)
hold off





