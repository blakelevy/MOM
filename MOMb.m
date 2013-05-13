% MOMb
%% Project #3 MOM
% Authors: Dayo Lawal and Blake Levy
clc
constants;
Q = 1;
tol = 1e-11;
M = 160;
ka = 4;
a = ka/k0;
N = M;
dtheta = (2*pi)/N;
theta = @(x) x*dtheta;
thetam = @(x) theta(x)+dtheta/2;
Norm = @(x) [cos(thetam(x)); sin(thetam(x)); 0];
Tm = @(x) [-sin(thetam(x)); cos(thetam(x)); 0];
Pm = @(x) Norm(x)*a;
Pmm1 = @(x,y) Pm(x) + Tm(x)*(y-0.5)*dl;
Pmp1 = @(x,y) Pm(x) + Tm(x)*y*dl/2;
rhpm = @(x,y) Pm(x) - Tm(x)*(1-y)*dl/2;
dl = a*dtheta;
K1 = k0*eta0*dl/4;
K2 = eta0/(4*k0);
kv = [k0; 0; 0];
Einc = @(x)[0; 1; 0]*exp(-1j*kv'*Pmm1(x,0));
Z = zeros(N,N);
V = zeros(N,1);
for i=0:N-1
    for j=0:N-1
        Av = K1*(intAm(i,j, N,dl,Pm,Tm, Pmm1, Pmp1, k0, Q) ... 
               + intAp(i,j, N,dl,Pm,Tm, Pmm1, rhpm, k0, Q));
        Phie = K2*(intP(i, j-1, N, dl, Pm, Tm, Pmm1, k0, Q) ...
               - intP(i-1, j-1, N, dl, Pm, Tm, Pmm1, k0, Q) ... 
               - intP(i, j, N, dl, Pm, Tm, Pmm1, k0, Q) ...
               + intP(i-1, j, N, dl, Pm, Tm, Pmm1, k0, Q));    
         Z(i+1,j+1) = Av + Phie;
    end
end

for i = 0:N-1;
    im1 = mom_cycle(i-1,N);
    V(i+1) = (Pm(i)-Pm(im1))'*Einc(i);
end

I = gmres(Z,V,M,tol,M);
i = 0:N-1;
theta = arrayfun(thetam,i);
plot(theta*180/pi,abs(I));


